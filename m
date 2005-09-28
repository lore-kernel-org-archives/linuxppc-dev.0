Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 169C66841A
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Sep 2005 09:34:35 +1000 (EST)
Date: Thu, 29 Sep 2005 00:34:30 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Message-ID: <20050928233430.GK7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mv64x60 iomem annotations
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-n_r3964/arch/ppc/syslib/mv64x60.c RC14-rc2-git6-mv64x60/arch/ppc/syslib/mv64x60.c
--- RC14-rc2-git6-n_r3964/arch/ppc/syslib/mv64x60.c	2005-09-28 13:01:59.000000000 -0400
+++ RC14-rc2-git6-mv64x60/arch/ppc/syslib/mv64x60.c	2005-09-28 13:02:22.000000000 -0400
@@ -34,7 +34,7 @@
 DEFINE_SPINLOCK(mv64x60_lock);
 
 static phys_addr_t 	mv64x60_bridge_pbase;
-static void 		*mv64x60_bridge_vbase;
+static void 		__iomem *mv64x60_bridge_vbase;
 static u32		mv64x60_bridge_type = MV64x60_TYPE_INVALID;
 static u32		mv64x60_bridge_rev;
 #if defined(CONFIG_SYSFS) && !defined(CONFIG_GT64260)
@@ -938,7 +938,7 @@
  *
  * Return the virtual address of the bridge's registers.
  */
-void *
+void __iomem *
 mv64x60_get_bridge_vbase(void)
 {
 	return mv64x60_bridge_vbase;
diff -urN RC14-rc2-git6-n_r3964/include/asm-ppc/mv64x60.h RC14-rc2-git6-mv64x60/include/asm-ppc/mv64x60.h
--- RC14-rc2-git6-n_r3964/include/asm-ppc/mv64x60.h	2005-09-22 01:17:31.000000000 -0400
+++ RC14-rc2-git6-mv64x60/include/asm-ppc/mv64x60.h	2005-09-28 13:02:22.000000000 -0400
@@ -233,7 +233,7 @@
 struct mv64x60_handle {
 	u32		type;		/* type of bridge */
 	u32		rev;		/* revision of bridge */
-	void		*v_base;	/* virtual base addr of bridge regs */
+	void		__iomem *v_base;/* virtual base addr of bridge regs */
 	phys_addr_t	p_base;		/* physical base addr of bridge regs */
 
 	u32		pci_mode_a;	/* pci 0 mode: conventional pci, pci-x*/
@@ -303,7 +303,7 @@
 	u32 cfg_data, struct pci_controller **hose);
 int mv64x60_get_type(struct mv64x60_handle *bh);
 int mv64x60_setup_for_chip(struct mv64x60_handle *bh);
-void *mv64x60_get_bridge_vbase(void);
+void __iomem *mv64x60_get_bridge_vbase(void);
 u32 mv64x60_get_bridge_type(void);
 u32 mv64x60_get_bridge_rev(void);
 void mv64x60_get_mem_windows(struct mv64x60_handle *bh,
