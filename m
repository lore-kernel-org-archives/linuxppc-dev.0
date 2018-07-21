Return-Path: <rdunlap@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Xz8c3LrVzDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jul 2018 05:58:40 +1000 (AEST)
To: PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] scsi: prevent ISA driver from building on PPC32
Message-ID: <5928f120-5a23-eff9-6c1d-41344d588b11@infradead.org>
Date: Sat, 21 Jul 2018 12:58:21 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Randy Dunlap <rdunlap@infradead.org>

Prevent drivers from building on PPC32 if they use isa_bus_to_virt(),
isa_virt_to_bus(), or isa_page_to_bus(), which are not available and
thus cause build errors.

../drivers/scsi/aha1542.c: In function 'aha1542_queuecommand':
../drivers/scsi/aha1542.c:461:30: error: implicit declaration of function 'isa_page_to_bus'; did you mean 'page_to_bus'? [-Werror=implicit-function-declaration]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/scsi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20180720.orig/drivers/scsi/Kconfig
+++ linux-next-20180720/drivers/scsi/Kconfig
@@ -428,7 +428,7 @@ config SCSI_AHA152X
 
 config SCSI_AHA1542
 	tristate "Adaptec AHA1542 support"
-	depends on ISA && SCSI && ISA_DMA_API
+	depends on ISA && SCSI && ISA_DMA_API && !PPC32
 	---help---
 	  This is support for a SCSI host adapter.  It is explained in section
 	  3.4 of the SCSI-HOWTO, available from
