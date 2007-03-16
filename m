Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2030DDEE9
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 00:57:18 +1100 (EST)
Received: from [172.17.0.11] (helo=iron.emcraft.com)
	by ocean.emcraft.com with esmtp (Exim 4.43) id 1HSCWA-0003P1-Gf
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 16:30:50 +0300
From: Yuri Tikhonov <yur@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
Date: Fri, 16 Mar 2007 16:34:58 +0300
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_C0p+Fcgc2e/QVcy"
Message-Id: <200703161634.58444.yur@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_C0p+Fcgc2e/QVcy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue Mar 13 18:12:14 EST 2007, Benjamin Herrenschmidt wrote:
> - You only adapted head_4xx.S but the config option is global to all of
> arch/ppc, thus changing it will probably break everything else. Make
> sure the option is done in such a way that it can't be changed or the
> kernel doesn't build if changed for a processor family where you haven't
> implemented the support

 The configuration option we had introduced changes the global PPC PAGE_SIZE 
definition indeed. To let changing the PAGE_SIZE from the configuration menu 
for the 44x processors only the following modification of the 
arch/ppc/Kconfig file might make sense:

 - int "Page size (12=>4KB; 16=>64KB)"
+ int "Page size (12=>4KB; 16=>64KB)" if 44x

 For other than 44x processors the PPC_PAGE_SHIFT value will be unchangeable 
from the configuration menu and set to default  value 12 ( PAGE_SIZE = 4 KB).

> - Have you tried other page sizes ? How hard would it be to support 16K
> and what kind of performance numbers do you get with 16K ? It's a better
> compromise for some applications as 64K causes significant bloat of the
> page cache (among other things).

 To support 16K, one more bunch of definitions should be calculated and added 
to the include/asm/ppc_page_asm.h file (for PAGE_SHIFT = 14). Attached is the 
patch that adds 16KB PAGE_SIZE capability for the ppc44x processors.

 Regards, Yuri.

--Boundary-00=_C0p+Fcgc2e/QVcy
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ppc44x_page_16k_070315.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ppc44x_page_16k_070315.patch"

Support for the PAGE_SIZE = 16 KB on the PPC32 44x platforms. 

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
---

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index e825e98..72af523 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1202,7 +1202,7 @@ config SECCOMP
 	  If unsure, say Y. Only embedded should say N here.
 
 config PPC_PAGE_SHIFT
-	int "Page size (12=>4KB; 16=>64KB)" if 44x
+	int "Page size (12=>4KB; 14=>16KB; 16=>64KB)" if 44x
 	default "12"
 	range 12 16
 	help
diff --git a/include/asm-ppc/page.h b/include/asm-ppc/page.h
index 61698ac..0b8f354 100644
--- a/include/asm-ppc/page.h
+++ b/include/asm-ppc/page.h
@@ -29,7 +29,9 @@
 #ifdef CONFIG_PTE_64BIT
 typedef unsigned long long pte_basic_t;
 #if (PAGE_SHIFT == 16) && defined(CONFIG_PPC32)
-#define PTE_SHIFT	(PAGE_SHIFT - 11)	/* 256 ptes per table*/
+#define PTE_SHIFT	(PAGE_SHIFT - 11)	/* 32 ptes per table */
+#elif (PAGE_SHIFT == 14) && defined(CONFIG_PPC32)
+#define PTE_SHIFT	(PAGE_SHIFT - 7)	/* 128 ptes per table */
 #else
 #define PTE_SHIFT	(PAGE_SHIFT - 3)	/* 512 ptes per page */
 #endif
diff --git a/include/asm-ppc/ppc_page_asm.h b/include/asm-ppc/ppc_page_asm.h
index 4918ddc..4f7ee78 100644
--- a/include/asm-ppc/ppc_page_asm.h
+++ b/include/asm-ppc/ppc_page_asm.h
@@ -29,6 +29,19 @@
 #define PPC44x_PTE_ADD_SH	23 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
 #define PPC44x_PTE_ADD_M1	20 /*32 - 3 - PTE_SHIFT*/
 #define PPC44x_RPN_M2		19 /*31 - PAGE_SHIFT*/
+#elif (PAGE_SHIFT == 14)
+/*
+ * PAGE_SIZE  16K
+ * PAGE_SHIFT 14
+ * PTE_SHIFT  7
+ * PMD_SHIFT  21
+ */
+#define PPC44x_TLB_SIZE		PPC44x_TLB_16K
+#define PPC44x_PGD_OFF_SH	13 /*(32 - PMD_SHIFT + 2)*/
+#define PPC44x_PGD_OFF_M1	19 /*(PMD_SHIFT - 2)*/
+#define PPC44x_PTE_ADD_SH	21 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
+#define PPC44x_PTE_ADD_M1	22 /*32 - 3 - PTE_SHIFT*/
+#define PPC44x_RPN_M2		17 /*31 - PAGE_SHIFT*/
 #elif (PAGE_SHIFT == 16)
 /*
  * PAGE_SIZE  64K

--Boundary-00=_C0p+Fcgc2e/QVcy--
