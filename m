Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-45-244.msk.skylink.ru
	[83.217.45.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF8D367BED
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 10:44:32 +1000 (EST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.7/8.13.7) with ESMTP id k7C0iQ9g006789
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 04:44:26 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 1/2] [incomplete] update 8xx platform data structures
Date: Sat, 12 Aug 2006 04:44:26 +0400
To: linuxppc-dev@ozlabs.org
Message-Id: <20060812004426.6748.16500.stgit@localhost.localdomain>
In-Reply-To: <20060812003759.6748.89145.stgit@localhost.localdomain>
References: <20060812003759.6748.89145.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Vitaly Bordug <vbordug@ru.mvista.com>

With cpm2 introduced to powerpc, there was a change of the fs_enet
platform data, so the code below fixes compilation error and makes
ppc/ fs_enet users happy again

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/ppc/platforms/mpc8272ads_setup.c |   16 ++++++++--------
 arch/ppc/platforms/mpc885ads_setup.c  |   20 ++++++++++----------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/ppc/platforms/mpc8272ads_setup.c b/arch/ppc/platforms/mpc8272ads_setup.c
index d5d36c3..f444b7e 100644
--- a/arch/ppc/platforms/mpc8272ads_setup.c
+++ b/arch/ppc/platforms/mpc8272ads_setup.c
@@ -30,10 +30,10 @@ #include <linux/fs_uart_pd.h>
 
 #include "pq2ads_pd.h"
 
-static void init_fcc1_ioports(void);
-static void init_fcc2_ioports(void);
-static void init_scc1_uart_ioports(void);
-static void init_scc4_uart_ioports(void);
+static void init_fcc1_ioports(struct fs_platform_info*);
+static void init_fcc2_ioports(struct fs_platform_info*);
+static void init_scc1_uart_ioports(struct fs_uart_platform_info*);
+static void init_scc4_uart_ioports(struct fs_uart_platform_info*);
 
 static struct fs_uart_platform_info mpc8272_uart_pdata[] = {
 	[fsid_scc1_uart] = {
@@ -103,7 +103,7 @@ static struct fs_platform_info mpc82xx_e
 	},
 };
 
-static void init_fcc1_ioports(struct fs_platform_info*)
+static void init_fcc1_ioports(struct fs_platform_info* ptr)
 {
 	struct io_port *io;
 	u32 tempval;
@@ -144,7 +144,7 @@ static void init_fcc1_ioports(struct fs_
 	iounmap(immap);
 }
 
-static void init_fcc2_ioports(struct fs_platform_info*)
+static void init_fcc2_ioports(struct fs_platform_info* ptr)
 {
 	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
 	u32 *bcsr = ioremap(BCSR_ADDR+12, sizeof(u32));
@@ -229,7 +229,7 @@ static void mpc8272ads_fixup_uart_pdata(
 	}
 }
 
-static void init_scc1_uart_ioports(struct fs_uart_platform_info*)
+static void init_scc1_uart_ioports(struct fs_uart_platform_info* ptr)
 {
 	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
 
@@ -246,7 +246,7 @@ static void init_scc1_uart_ioports(struc
 	iounmap(immap);
 }
 
-static void init_scc4_uart_ioports(struct fs_uart_platform_info*)
+static void init_scc4_uart_ioports(struct fs_uart_platform_info* ptr)
 {
 	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
 
diff --git a/arch/ppc/platforms/mpc885ads_setup.c b/arch/ppc/platforms/mpc885ads_setup.c
index bf388ed..88209d9 100644
--- a/arch/ppc/platforms/mpc885ads_setup.c
+++ b/arch/ppc/platforms/mpc885ads_setup.c
@@ -35,13 +35,13 @@ #include <asm/commproc.h>
 #include <asm/ppc_sys.h>
 
 extern unsigned char __res[];
-static void setup_smc1_ioports(void);
-static void setup_smc2_ioports(void);
+static void setup_smc1_ioports(struct fs_uart_platform_info *);
+static void setup_smc2_ioports(struct fs_uart_platform_info *);
 
 static struct fs_mii_fec_platform_info	mpc8xx_mdio_fec_pdata;
-static void setup_fec1_ioports(void);
-static void setup_fec2_ioports(void);
-static void setup_scc3_ioports(void);
+static void setup_fec1_ioports(struct fs_platform_info*);
+static void setup_fec2_ioports(struct fs_platform_info*);
+static void setup_scc3_ioports(struct fs_platform_info*);
 
 static struct fs_uart_platform_info mpc885_uart_pdata[] = {
 	[fsid_smc1_uart] = {
@@ -161,7 +161,7 @@ #endif
 #endif
 }
 
-static void setup_fec1_ioports(struct fs_platform_info*)
+static void setup_fec1_ioports(struct fs_platform_info* ptr)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 
@@ -181,7 +181,7 @@ static void setup_fec1_ioports(struct fs
 	clrbits32(&immap->im_cpm.cp_cptr, 0x00000100);
 }
 
-static void setup_fec2_ioports(struct fs_platform_info*)
+static void setup_fec2_ioports(struct fs_platform_info* ptr)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 
@@ -193,7 +193,7 @@ static void setup_fec2_ioports(struct fs
 	clrbits32(&immap->im_cpm.cp_cptr, 0x00000080);
 }
 
-static void setup_scc3_ioports(struct fs_platform_info*)
+static void setup_scc3_ioports(struct fs_platform_info* ptr)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 	unsigned *bcsr_io;
@@ -315,7 +315,7 @@ static void __init mpc885ads_fixup_scc_e
 	mpc885ads_fixup_enet_pdata(pdev, fsid_scc1 + pdev->id - 1);
 }
 
-static void setup_smc1_ioports(struct fs_uart_platform_info*)
+static void setup_smc1_ioports(struct fs_uart_platform_info* ptr)
 {
         immap_t *immap = (immap_t *) IMAP_ADDR;
         unsigned *bcsr_io;
@@ -335,7 +335,7 @@ static void setup_smc1_ioports(struct fs
         clrbits16(&immap->im_cpm.cp_pbodr, iobits);
 }
 
-static void setup_smc2_ioports(struct fs_uart_platform_info*)
+static void setup_smc2_ioports(struct fs_uart_platform_info* ptr)
 {
         immap_t *immap = (immap_t *) IMAP_ADDR;
         unsigned *bcsr_io;
