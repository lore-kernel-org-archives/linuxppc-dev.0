Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB9AF1A0358
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 10:29:14 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 3 Feb 2016 16:29:13 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id CF79019D803F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 16:17:10 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13NTBRX29622498
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 16:29:11 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13NTAcr029573
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 16:29:10 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: JBottomley@odin.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, hare@suse.de,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH 1/6] ibmvscsi: Correct values for several viosrp_crq_format
 enums
Date: Wed,  3 Feb 2016 17:28:29 -0600
Message-Id: <1454542114-1797-2-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1454542114-1797-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1454542114-1797-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The enum values for VIOSRP_LINUX_FORMAT and VIOSRP_INLINE_FORMAT are
off by one. They are currently defined as 0x06 and 0x07 respetively.
These values are defined in PAPR correctly as 0x05 and 0x06. This
inconsistency has gone unnoticed as neither enum is currently used.
The possible future support of PING messages between the VIOS and
client adapter relies on VIOSRP_INLINE_FORMAT crq messages.
Corrected these enum values to match PAPR definitions.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/viosrp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/viosrp.h b/drivers/scsi/ibmvscsi/viosrp.h
index 1162430..d1044e9 100644
--- a/drivers/scsi/ibmvscsi/viosrp.h
+++ b/drivers/scsi/ibmvscsi/viosrp.h
@@ -56,8 +56,8 @@ enum viosrp_crq_formats {
 	VIOSRP_MAD_FORMAT = 0x02,
 	VIOSRP_OS400_FORMAT = 0x03,
 	VIOSRP_AIX_FORMAT = 0x04,
-	VIOSRP_LINUX_FORMAT = 0x06,
-	VIOSRP_INLINE_FORMAT = 0x07
+	VIOSRP_LINUX_FORMAT = 0x05,
+	VIOSRP_INLINE_FORMAT = 0x06
 };
 
 enum viosrp_crq_status {
-- 
2.5.0
