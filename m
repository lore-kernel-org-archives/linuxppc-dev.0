Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4D59967C4B
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 20:53:01 +1100 (EST)
Received: from az33smr01 (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k9V9r051020589
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 02:53:00 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01 (8.13.1/8.13.0) with ESMTP id k9V9qurO016894
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 03:52:59 -0600 (CST)
Message-ID: <45471D28.5090107@freescale.com>
Date: Tue, 31 Oct 2006 17:53:44 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH 2/2] qe_lib: Remove immrbar_virt_to_phys() function
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove private address mapping function immrbar_virt_to_phys() as it can be
replaced by kernel generic API like iopa().  iopa() had problem dealing with
area mapped by io_block_mapping().  It's now working as all io spaces are mapped
by ioremap().  Users of this function should change to use generic functions.

Signed-off-by: Li Yang <leoli@freescale.com>
---
diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
index ce12f85..7cccd16 100644
--- a/include/asm-powerpc/immap_qe.h
+++ b/include/asm-powerpc/immap_qe.h
@@ -464,14 +464,5 @@ struct qe_immap {
 extern struct qe_immap *qe_immr;
 extern phys_addr_t get_qe_base(void);
 
-static inline unsigned long immrbar_virt_to_phys(volatile void * address)
-{
-	if ( ((u32)address >= (u32)qe_immr) &&
-			((u32)address < ((u32)qe_immr + QE_IMMAP_SIZE)) )
-		return (unsigned long)(address - (u32)qe_immr +
-				(u32)get_qe_base());
-	return (unsigned long)virt_to_phys(address);
-}
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_IMMAP_QE_H */
