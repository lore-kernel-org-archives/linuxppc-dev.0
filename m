Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40jKKZ6gcnzF2rs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 05:05:06 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4BIx11f118940
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 15:05:04 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hwfkgucj7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 15:05:03 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 11 May 2018 15:05:02 -0400
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 1/7] cxlflash: Yield to active send threads
Date: Fri, 11 May 2018 14:04:46 -0500
In-Reply-To: <1526065440-38806-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1526065440-38806-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1526065486-38860-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following Oops may be encountered if the device is reset, i.e. EEH
recovery, while there is heavy I/O traffic:

59:mon> t
[c000200db64bb680] c008000009264c40 cxlflash_queuecommand+0x3b8/0x500
					[cxlflash]
[c000200db64bb770] c00000000090d3b0 scsi_dispatch_cmd+0x130/0x2f0
[c000200db64bb7f0] c00000000090fdd8 scsi_request_fn+0x3c8/0x8d0
[c000200db64bb900] c00000000067f528 __blk_run_queue+0x68/0xb0
[c000200db64bb930] c00000000067ab80 __elv_add_request+0x140/0x3c0
[c000200db64bb9b0] c00000000068daac blk_execute_rq_nowait+0xec/0x1a0
[c000200db64bba00] c00000000068dbb0 blk_execute_rq+0x50/0xe0
[c000200db64bba50] c0000000006b2040 sg_io+0x1f0/0x520
[c000200db64bbaf0] c0000000006b2e94 scsi_cmd_ioctl+0x534/0x610
[c000200db64bbc20] c000000000926208 sd_ioctl+0x118/0x280
[c000200db64bbcc0] c00000000069f7ac blkdev_ioctl+0x7fc/0xe30
[c000200db64bbd20] c000000000439204 block_ioctl+0x84/0xa0
[c000200db64bbd40] c0000000003f8514 do_vfs_ioctl+0xd4/0xa00
[c000200db64bbde0] c0000000003f8f04 SyS_ioctl+0xc4/0x130
[c000200db64bbe30] c00000000000b184 system_call+0x58/0x6c

When there is no room to send the I/O request, the cached room is refreshed
by reading the memory mapped command room value from the AFU. The AFU
register mapping is refreshed during a reset, creating a race condition
that can lead to the Oops above.

During a device reset, the AFU should not be unmapped until all the active
send threads quiesce. An atomic counter, cmds_active, is currently used to
track internal AFU commands and quiesce during reset. This same counter can
also be used for the active send threads.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index a24d7e6..dad2be6 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -616,6 +616,7 @@ static int cxlflash_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scp)
 		rc = 0;
 		goto out;
 	default:
+		atomic_inc(&afu->cmds_active);
 		break;
 	}
 
@@ -641,6 +642,7 @@ static int cxlflash_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scp)
 	memcpy(cmd->rcb.cdb, scp->cmnd, sizeof(cmd->rcb.cdb));
 
 	rc = afu->send_cmd(afu, cmd);
+	atomic_dec(&afu->cmds_active);
 out:
 	return rc;
 }
-- 
2.1.0
