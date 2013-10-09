Return-Path: <R65777@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 827EE2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 16:15:46 +1100 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <scottwood@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <benh@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc: Added __cmpdi2 for signed 64bit comparision
Date: Wed, 9 Oct 2013 10:38:42 +0530
Message-ID: <1381295322-7197-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This was missing on powerpc and I am getting compilation error
drivers/vfio/pci/vfio_pci_rdwr.c:193: undefined reference to `__cmpdi2'
drivers/vfio/pci/vfio_pci_rdwr.c:193: undefined reference to `__cmpdi2'

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 arch/powerpc/kernel/misc_32.S   |   14 ++++++++++++++
 arch/powerpc/kernel/ppc_ksyms.c |    2 ++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 777d999..7c0eec2 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -644,6 +644,20 @@ _GLOBAL(__lshrdi3)
 	blr
 
 /*
+ * 64-bit comparison: __cmpdi2(s64 a, s64 b)
+ * Returns 0 if a < b, 1 if a == b, 2 if a > b.
+ */
+_GLOBAL(__cmpdi2)
+	cmpw	r3,r5
+	li	r3,1
+	bne	1f
+	cmplw	r4,r6
+	beqlr
+1:	li	r3,0
+	bltlr
+	li	r3,2
+	blr
+/*
  * 64-bit comparison: __ucmpdi2(u64 a, u64 b)
  * Returns 0 if a < b, 1 if a == b, 2 if a > b.
  */
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 21646db..5674c00 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -143,6 +143,8 @@ EXPORT_SYMBOL(__ashldi3);
 EXPORT_SYMBOL(__lshrdi3);
 int __ucmpdi2(unsigned long long, unsigned long long);
 EXPORT_SYMBOL(__ucmpdi2);
+int __cmpdi2(long long, long long);
+EXPORT_SYMBOL(__cmpdi2);
 #endif
 long long __bswapdi2(long long);
 EXPORT_SYMBOL(__bswapdi2);
-- 
1.7.0.4
