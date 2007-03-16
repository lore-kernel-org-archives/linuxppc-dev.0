Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B5F4DDFB8
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 00:57:26 +1100 (EST)
Received: from [172.17.0.11] (helo=iron.emcraft.com)
	by ocean.emcraft.com with esmtp (Exim 4.43) id 1HSCWS-0003P7-Ka
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 16:31:08 +0300
From: Yuri Tikhonov <yur@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
Date: Fri, 16 Mar 2007 16:35:16 +0300
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_U0p+FsJ4iMk3wnu"
Message-Id: <200703161635.16571.yur@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_U0p+FsJ4iMk3wnu
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri Mar 16 16:14:48 EST 2007 Paul Mackerras wrote:
> If I'm reading the patch right, with 64k pages you're using 8kB pgd
> arrays and 256-byte pte arrays, so you're only using 1/256th of each
> PTE page.  In fact each PTE page could map 512MB (assuming 8 byte
> ptes), and the pgd array could be a tiny 8-entry thing, which we could
> kmalloc.  I think that would use memory more efficiently.

 Your understanding of the patch is correct. When the page size is set to 64K 
then the 32-bit linear address is being splitted in the following way:

(1) 64K:
PGD: 11 msb -> there are 2K page global directory entries;
PTE: 5 bits -> 32 8-byte PTE entries in each page table => 32x8=256 of 64K;
Offset: 16 lsb -> page size is 64K.

 So, I do not use "page table" pages (with PTEs) fully indeed. If use the 
following decoding of the linear address then each page table with PTEs will 
be utilized in full:

(2) 64K:
PGD: 3 msb -> there are 8 page global directory entries,
PTE: 13 bits -> 8K 8-byte PTE entries in each page table => 8Kx8=64K of 64K,
Offset: 16 lsb -> page size is 64K.

 The corresponding point is correct regarding to my 16K implementation too:

(3) 16K:
PGD: 7 msb -> there are 128 page global directory entries,
PTE: 11 bits -> 2K 8-byte PTE entries in each page table => 2Kx8=16K of 16K,
Offset: 14 lsb -> page size is 16K.

 Additional note regarding to the 64K pages. When use decoding (2) there is a 
WARN_ON() triggered in the dma_alloc_init() function ( 
arch/powerpc/lib/dma-noncoherent.c):

WARN_ON(!pmd_none(*pmd)),

 that leads to the following message during kernel booting-up:
------------[ cut here ]------------
Badness at c02ebb30 [verbose debug info unavailable]
Call Trace:
[C054FE50] [C000858C] show_stack+0x48/0x190 (unreliable)
[C054FE80] [C00F189C] report_bug+0xa4/0xac
[C054FE90] [C0002A7C] program_check_exception+0x170/0x4a0
[C054FEB0] [C0001E74] ret_from_except_full+0x0/0x4c
[C054FF70] [C003C068] init_irq_proc+0x3c/0x5c
[C054FF80] [C02E0830] init+0x94/0x1c4
[C054FFF0] [C0003AC0] kernel_thread+0x44/0x60

 This warning means that the PMD, which is being checked here, was already 
allocated during executing of some prior code. When only 3 msb are being used 
as a PMD component of the linear address then each PMD entry covers the 512MB 
area (0x20000000). This is rather a big area so I think there is nothing 
strange or erroneous that this area was already accessed somewhere before the 
dma_alloc_init() call. So, to spare users' minds I suggest to replace the 
WARN_ON() call in the dma_alloc_init() with more harmless warning message. 

 The patch that fixes PTE tables memory usage for the 16K and 64K pages is 
attached. Also this patch replace WARN_ON() in the dma_alloc_init() with the 
printk(). 

 Regards, Yuri.

--Boundary-00=_U0p+FsJ4iMk3wnu
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ppc44x_page_070316.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ppc44x_page_070316.patch"

diff --git a/arch/powerpc/lib/dma-noncoherent.c b/arch/powerpc/lib/dma-noncoherent.c
index 48f3d13..4f9da90 100644
--- a/arch/powerpc/lib/dma-noncoherent.c
+++ b/arch/powerpc/lib/dma-noncoherent.c
@@ -318,7 +318,8 @@ static int __init dma_alloc_init(void)
 			ret = -ENOMEM;
 			break;
 		}
-		WARN_ON(!pmd_none(*pmd));
+		if(!pmd_none(*pmd))
+			printk("%s warning: PMD is not empty.\n", __FUNCTION__);
 
 		pte = pte_alloc_kernel(pmd, CONSISTENT_BASE);
 		if (!pte) {
diff --git a/include/asm-ppc/page.h b/include/asm-ppc/page.h
index 0b8f354..3b2f17a 100644
--- a/include/asm-ppc/page.h
+++ b/include/asm-ppc/page.h
@@ -28,13 +28,7 @@
  */
 #ifdef CONFIG_PTE_64BIT
 typedef unsigned long long pte_basic_t;
-#if (PAGE_SHIFT == 16) && defined(CONFIG_PPC32)
-#define PTE_SHIFT	(PAGE_SHIFT - 11)	/* 32 ptes per table */
-#elif (PAGE_SHIFT == 14) && defined(CONFIG_PPC32)
-#define PTE_SHIFT	(PAGE_SHIFT - 7)	/* 128 ptes per table */
-#else
-#define PTE_SHIFT	(PAGE_SHIFT - 3)	/* 512 ptes per page */
-#endif
+#define PTE_SHIFT	(PAGE_SHIFT - 3)	/* PAGE_SIZE/8 ptes per page */
 #define PTE_FMT		"%16Lx"
 #else
 typedef unsigned long pte_basic_t;
diff --git a/include/asm-ppc/ppc_page_asm.h b/include/asm-ppc/ppc_page_asm.h
index 4f7ee78..1dbfd3b 100644
--- a/include/asm-ppc/ppc_page_asm.h
+++ b/include/asm-ppc/ppc_page_asm.h
@@ -33,27 +33,27 @@
 /*
  * PAGE_SIZE  16K
  * PAGE_SHIFT 14
- * PTE_SHIFT  7
- * PMD_SHIFT  21
+ * PTE_SHIFT  11
+ * PMD_SHIFT  25
  */
 #define PPC44x_TLB_SIZE		PPC44x_TLB_16K
-#define PPC44x_PGD_OFF_SH	13 /*(32 - PMD_SHIFT + 2)*/
-#define PPC44x_PGD_OFF_M1	19 /*(PMD_SHIFT - 2)*/
+#define PPC44x_PGD_OFF_SH	9  /*(32 - PMD_SHIFT + 2)*/
+#define PPC44x_PGD_OFF_M1	23 /*(PMD_SHIFT - 2)*/
 #define PPC44x_PTE_ADD_SH	21 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
-#define PPC44x_PTE_ADD_M1	22 /*32 - 3 - PTE_SHIFT*/
+#define PPC44x_PTE_ADD_M1	18 /*32 - 3 - PTE_SHIFT*/
 #define PPC44x_RPN_M2		17 /*31 - PAGE_SHIFT*/
 #elif (PAGE_SHIFT == 16)
 /*
  * PAGE_SIZE  64K
  * PAGE_SHIFT 16
- * PTE_SHIFT   5
- * PMD_SHIFT  21
+ * PTE_SHIFT  13
+ * PMD_SHIFT  29
  */
 #define PPC44x_TLB_SIZE		PPC44x_TLB_64K
-#define PPC44x_PGD_OFF_SH	13 /*(32 - PMD_SHIFT + 2)*/
-#define PPC44x_PGD_OFF_M1	19 /*(PMD_SHIFT - 2)*/
+#define PPC44x_PGD_OFF_SH	5  /*(32 - PMD_SHIFT + 2)*/
+#define PPC44x_PGD_OFF_M1	27 /*(PMD_SHIFT - 2)*/
 #define PPC44x_PTE_ADD_SH	19 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
-#define PPC44x_PTE_ADD_M1	24 /*32 - 3 - PTE_SHIFT*/
+#define PPC44x_PTE_ADD_M1	16 /*32 - 3 - PTE_SHIFT*/
 #define PPC44x_RPN_M2		15 /*31 - PAGE_SHIFT*/
 #else
 #error "Unsupported PAGE_SIZE"

--Boundary-00=_U0p+FsJ4iMk3wnu--
