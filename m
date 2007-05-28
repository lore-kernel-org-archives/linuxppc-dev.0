Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 76AE7DDEE3
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 20:46:42 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4SAkQxQ023528
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 03:46:27 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4SAkKVN012992
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 05:46:21 -0500 (CDT)
Message-ID: <465AB366.6030504@freescale.com>
Date: Mon, 28 May 2007 18:48:06 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH] qe_lib: export symbols for QE driver to compile as module
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

Export symbols of qe_lib to be used by QE driver.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Selvamuthukumar V <vsmkumar.84@gmail.com> 
---
Remove symbols for off-tree drivers

 arch/powerpc/sysdev/qe_lib/ucc.c      |    2 ++
 arch/powerpc/sysdev/qe_lib/ucc_fast.c |    8 ++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c b/arch/powerpc/sysdev/qe_lib/ucc.c
index ac12a44..f970e54 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
+#include <linux/module.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -40,6 +41,7 @@ int ucc_set_qe_mux_mii_mng(int ucc_num)
 
 	return 0;
 }
+EXPORT_SYMBOL(ucc_set_qe_mux_mii_mng);
 
 int ucc_set_type(int ucc_num, struct ucc_common *regs,
 		 enum ucc_speed_type speed)
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
index 9143236..3df202e 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -19,6 +19,7 @@
 #include <linux/stddef.h>
 #include <linux/interrupt.h>
 #include <linux/err.h>
+#include <linux/module.h>
 
 #include <asm/io.h>
 #include <asm/immap_qe.h>
@@ -70,6 +71,7 @@ void ucc_fast_dump_regs(struct ucc_fast_private * uccf)
 	printk(KERN_INFO "guemr : addr - 0x%08x, val - 0x%02x",
 		  (u32) & uccf->uf_regs->guemr, uccf->uf_regs->guemr);
 }
+EXPORT_SYMBOL(ucc_fast_dump_regs);
 
 u32 ucc_fast_get_qe_cr_subblock(int uccf_num)
 {
@@ -85,11 +87,13 @@ u32 ucc_fast_get_qe_cr_subblock(int uccf_num)
 	default: return QE_CR_SUBBLOCK_INVALID;
 	}
 }
+EXPORT_SYMBOL(ucc_fast_get_qe_cr_subblock);
 
 void ucc_fast_transmit_on_demand(struct ucc_fast_private * uccf)
 {
 	out_be16(&uccf->uf_regs->utodr, UCC_FAST_TOD);
 }
+EXPORT_SYMBOL(ucc_fast_transmit_on_demand);
 
 void ucc_fast_enable(struct ucc_fast_private * uccf, enum comm_dir mode)
 {
@@ -110,6 +114,7 @@ void ucc_fast_enable(struct ucc_fast_private * uccf, enum comm_dir mode)
 	}
 	out_be32(&uf_regs->gumr, gumr);
 }
+EXPORT_SYMBOL(ucc_fast_enable);
 
 void ucc_fast_disable(struct ucc_fast_private * uccf, enum comm_dir mode)
 {
@@ -130,6 +135,7 @@ void ucc_fast_disable(struct ucc_fast_private * uccf, enum comm_dir mode)
 	}
 	out_be32(&uf_regs->gumr, gumr);
 }
+EXPORT_SYMBOL(ucc_fast_disable);
 
 int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** uccf_ret)
 {
@@ -341,6 +347,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	*uccf_ret = uccf;
 	return 0;
 }
+EXPORT_SYMBOL(ucc_fast_init);
 
 void ucc_fast_free(struct ucc_fast_private * uccf)
 {
@@ -355,3 +362,4 @@ void ucc_fast_free(struct ucc_fast_private * uccf)
 
 	kfree(uccf);
 }
+EXPORT_SYMBOL(ucc_fast_free);
