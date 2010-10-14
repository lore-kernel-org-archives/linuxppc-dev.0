Return-Path: <timur@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 478C7B70AF
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 07:15:40 +1100 (EST)
Received: from mail21-am1 (localhost.localdomain [127.0.0.1])	by
	mail21-am1-R.bigfish.com (Postfix) with ESMTP id C7DE69A85A9	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 20:15:35 +0000 (UTC)
Received: from am1ehsmhs010.bigfish.com (unknown [10.3.201.243])	by
	mail21-am1.bigfish.com (Postfix) with ESMTP id 91F956B8053	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 20:15:34 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9EKFVaB003721	for <linuxppc-dev@ozlabs.org>;
	Thu, 14 Oct 2010 13:15:32 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: <linuxppc-dev@ozlabs.org>, <kumar.gala@freescale.com>
Subject: [PATCH] powerpc: fix warning when compiling immap_qe.h
Date: Thu, 14 Oct 2010 15:15:30 -0500
Message-ID: <1287087330-11172-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the warnings genereted by arch/powerpc/include/asm/immap_qe.h when
CONFIG_PHYS_ADDR_T_64BIT is defined:

immap_qe.h: In function 'immrbar_virt_to_phys':
immap_qe.h:472:8: warning: cast from pointer to integer of different size
immap_qe.h:472:24: warning: cast from pointer to integer of different size
immap_qe.h:473:5: warning: cast from pointer to integer of different size
immap_qe.h:473:21: warning: cast from pointer to integer of different size
immap_qe.h:474:36: warning: cast from pointer to integer of different size

Note that the QE does not support 36-bit physical addresses, so even when
CONFIG_PHYS_ADDR_T_64BIT is defined, the QE MURAM must be located below the
4GB boundary.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/include/asm/immap_qe.h |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/immap_qe.h b/arch/powerpc/include/asm/immap_qe.h
index 4e10f50..0edb684 100644
--- a/arch/powerpc/include/asm/immap_qe.h
+++ b/arch/powerpc/include/asm/immap_qe.h
@@ -467,13 +467,22 @@ struct qe_immap {
 extern struct qe_immap __iomem *qe_immr;
 extern phys_addr_t get_qe_base(void);
 
-static inline unsigned long immrbar_virt_to_phys(void *address)
+/*
+ * Returns the offset within the QE address space of the given pointer.
+ *
+ * Note that the QE does not support 36-bit physical addresses, so if
+ * get_qe_base() returns a number above 4GB, the caller will probably fail.
+ */
+static inline phys_addr_t immrbar_virt_to_phys(void *address)
 {
-	if ( ((u32)address >= (u32)qe_immr) &&
-			((u32)address < ((u32)qe_immr + QE_IMMAP_SIZE)) )
-		return (unsigned long)(address - (u32)qe_immr +
-				(u32)get_qe_base());
-	return (unsigned long)virt_to_phys(address);
+	void *q = (void *)qe_immr;
+
+	/* Is it a MURAM address? */
+	if ((address >= q) && (address < (q + QE_IMMAP_SIZE)))
+		return get_qe_base() + (address - q);
+
+	/* It's an address returned by kmalloc */
+	return virt_to_phys(address);
 }
 
 #endif /* __KERNEL__ */
-- 
1.7.2.3
