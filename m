Return-Path: <vbordug@ru.mvista.com>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 470C1DDF58
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 03:52:07 +1000 (EST)
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/3] [PPC32] Address compilation and linking errors of
	mpc885ads build.
Date: Tue, 10 Apr 2007 21:52:02 +0400
Message-Id: <20070410175202.8806.23747.stgit@vitb.ru.mvista.com>
In-Reply-To: <20070410175153.8806.90306.stgit@vitb.ru.mvista.com>
References: <20070410175153.8806.90306.stgit@vitb.ru.mvista.com>
Cc: linuxppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/ppc/platforms/mpc885ads_setup.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/ppc/platforms/mpc885ads_setup.c b/arch/ppc/platforms/mpc885ads_setup.c
index f8161f3..87deaef 100644
--- a/arch/ppc/platforms/mpc885ads_setup.c
+++ b/arch/ppc/platforms/mpc885ads_setup.c
@@ -35,13 +35,13 @@
 #include <asm/ppc_sys.h>
 
 extern unsigned char __res[];
-static void setup_smc1_ioports(void);
-static void setup_smc2_ioports(void);
+static void setup_smc1_ioports(struct fs_uart_platform_info*);
+static void setup_smc2_ioports(struct fs_uart_platform_info*);
 
 static struct fs_mii_fec_platform_info	mpc8xx_mdio_fec_pdata;
-static void setup_fec1_ioports(void);
-static void setup_fec2_ioports(void);
-static void setup_scc3_ioports(void);
+static void setup_fec1_ioports(struct fs_platform_info*);
+static void setup_fec2_ioports(struct fs_platform_info*);
+static void setup_scc3_ioports(struct fs_platform_info*);
 
 static struct fs_uart_platform_info mpc885_uart_pdata[] = {
 	[fsid_smc1_uart] = {
@@ -161,7 +161,7 @@ void __init board_init(void)
 #endif
 }
 
-static void setup_fec1_ioports(struct fs_platform_info*)
+static void setup_fec1_ioports(struct fs_platform_info* pdata)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 
@@ -181,7 +181,7 @@ static void setup_fec1_ioports(struct fs
 	clrbits32(&immap->im_cpm.cp_cptr, 0x00000100);
 }
 
-static void setup_fec2_ioports(struct fs_platform_info*)
+static void setup_fec2_ioports(struct fs_platform_info* pdata)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 
@@ -193,7 +193,7 @@ static void setup_fec2_ioports(struct fs
 	clrbits32(&immap->im_cpm.cp_cptr, 0x00000080);
 }
 
-static void setup_scc3_ioports(struct fs_platform_info*)
+static void setup_scc3_ioports(struct fs_platform_info* pdata)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 	unsigned *bcsr_io;
@@ -315,7 +315,7 @@ static void __init mpc885ads_fixup_scc_e
 	mpc885ads_fixup_enet_pdata(pdev, fsid_scc1 + pdev->id - 1);
 }
 
-static void setup_smc1_ioports(struct fs_uart_platform_info*)
+static void setup_smc1_ioports(struct fs_uart_platform_info* pdata)
 {
         immap_t *immap = (immap_t *) IMAP_ADDR;
         unsigned *bcsr_io;
@@ -335,7 +335,7 @@ static void setup_smc1_ioports(struct fs
         clrbits16(&immap->im_cpm.cp_pbodr, iobits);
 }
 
-static void setup_smc2_ioports(struct fs_uart_platform_info*)
+static void setup_smc2_ioports(struct fs_uart_platform_info* pdata)
 {
         immap_t *immap = (immap_t *) IMAP_ADDR;
         unsigned *bcsr_io;
