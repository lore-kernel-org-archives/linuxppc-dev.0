Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlFJv4SnqzDrJ6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 18:10:54 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1J7A2LU137283
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 02:10:51 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g7bbawr4r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 02:10:49 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 19 Feb 2018 07:10:47 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: "Manoj N . Kumar" <manoj@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 "Matthew R . Ochs" <mrochs@linux.vnet.ibm.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] scsi: cxlflash: Select SCSI_SCAN_ASYNC
Date: Mon, 19 Feb 2018 12:40:37 +0530
Message-Id: <20180219071037.27938-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cxlflash driver uses "Asynchronous SCSI scanning" enabled by
CONFIG_SCSI_SCAN_ASYNC. Without this enabled the modprobe of cxlflash
module gets hung with following backtrace:

Call Trace:
 __switch_to+0x2cc/0x470
 __schedule+0x288/0xab0
 schedule+0x40/0xc0
 schedule_timeout+0x254/0x4f0
 wait_for_common+0xdc/0x260
 flush_work+0x140/0x2a0
 work_on_cpu+0x88/0xb0
 pci_device_probe+0x1d0/0x220
 driver_probe_device+0x408/0x5b0
 __driver_attach+0x16c/0x1a0
 bus_for_each_dev+0xb8/0x110
 driver_attach+0x3c/0x60
 bus_add_driver+0x1d8/0x370
 driver_register+0x9c/0x180
 __pci_register_driver+0x74/0xa0
 init_cxlflash+0x158/0x1cc
 do_one_initcall+0x68/0x1e0
 do_init_module+0x90/0x254
 load_module+0x2f8c/0x3720
 SyS_finit_module+0xcc/0x140
 system_call+0x58/0x6c

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/cxlflash/Kconfig b/drivers/scsi/cxlflash/Kconfig
index a011c5dbf214..f054c1b0fff3 100644
--- a/drivers/scsi/cxlflash/Kconfig
+++ b/drivers/scsi/cxlflash/Kconfig
@@ -6,6 +6,7 @@ config CXLFLASH
 	tristate "Support for IBM CAPI Flash"
 	depends on PCI && SCSI && CXL && EEH
 	select IRQ_POLL
+	select SCSI_SCAN_ASYNC
 	default m
 	help
 	  Allows CAPI Accelerated IO to Flash
-- 
2.14.3
