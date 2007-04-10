Return-Path: <vbordug@ru.mvista.com>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D40FADDE24
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 03:52:13 +1000 (EST)
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/3] [PPC32] Address compilation and linking errors of
	mpc86xads build.
Date: Tue, 10 Apr 2007 21:52:04 +0400
Message-Id: <20070410175204.8806.93242.stgit@vitb.ru.mvista.com>
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

 arch/ppc/8xx_io/commproc.c           |   26 ++++++++++++++++++++++++++
 arch/ppc/platforms/mpc866ads_setup.c |   17 +++++++++--------
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
index 3b23bcb..7a8722b 100644
--- a/arch/ppc/8xx_io/commproc.c
+++ b/arch/ppc/8xx_io/commproc.c
@@ -39,6 +39,21 @@
 #include <asm/tlbflush.h>
 #include <asm/rheap.h>
 
+#define immr_map(member)						\
+({									\
+	u32 offset = offsetof(immap_t, member);				\
+	void *addr = ioremap (IMAP_ADDR + offset,			\
+			      sizeof( ((immap_t*)0)->member));		\
+	addr;								\
+})
+
+#define immr_map_size(member, size)					\
+({									\
+	u32 offset = offsetof(immap_t, member);				\
+	void *addr = ioremap (IMAP_ADDR + offset, size);		\
+	addr;								\
+})
+
 static void m8xx_cpm_dpinit(void);
 static	uint	host_buffer;	/* One page of host buffer */
 static	uint	host_end;	/* end + 1 */
@@ -364,11 +379,16 @@ static rh_block_t cpm_boot_dpmem_rh_bloc
 static rh_info_t cpm_dpmem_info;
 
 #define CPM_DPMEM_ALIGNMENT	8
+static u8* dpram_vbase;
+static uint dpram_pbase;
 
 void m8xx_cpm_dpinit(void)
 {
 	spin_lock_init(&cpm_dpmem_lock);
 
+	dpram_vbase = immr_map_size(im_cpm.cp_dpmem, CPM_DATAONLY_BASE + CPM_DATAONLY_SIZE);
+	dpram_pbase = (uint)&((immap_t *)IMAP_ADDR)->im_cpm.cp_dpmem;
+
 	/* Initialize the info header */
 	rh_init(&cpm_dpmem_info, CPM_DPMEM_ALIGNMENT,
 			sizeof(cpm_boot_dpmem_rh_block) /
@@ -442,3 +462,9 @@ void *cpm_dpram_addr(uint offset)
 	return ((immap_t *)IMAP_ADDR)->im_cpm.cp_dpmem + offset;
 }
 EXPORT_SYMBOL(cpm_dpram_addr);
+
+uint cpm_dpram_phys(u8* addr)
+{
+	return (dpram_pbase + (uint)(addr - dpram_vbase));
+}
+EXPORT_SYMBOL(cpm_dpram_phys);
diff --git a/arch/ppc/platforms/mpc866ads_setup.c b/arch/ppc/platforms/mpc866ads_setup.c
index 5b05d4b..7ce5364 100644
--- a/arch/ppc/platforms/mpc866ads_setup.c
+++ b/arch/ppc/platforms/mpc866ads_setup.c
@@ -21,6 +21,7 @@
 #include <linux/fs_enet_pd.h>
 #include <linux/fs_uart_pd.h>
 #include <linux/mii.h>
+#include <linux/phy.h>
 
 #include <asm/delay.h>
 #include <asm/io.h>
@@ -37,10 +38,10 @@
 
 extern unsigned char __res[];
 
-static void setup_fec1_ioports(void);
-static void setup_scc1_ioports(void);
-static void setup_smc1_ioports(void);
-static void setup_smc2_ioports(void);
+static void setup_fec1_ioports(struct fs_platform_info*);
+static void setup_scc1_ioports(struct fs_platform_info*);
+static void setup_smc1_ioports(struct fs_uart_platform_info*);
+static void setup_smc2_ioports(struct fs_uart_platform_info*);
 
 static struct fs_mii_fec_platform_info	mpc8xx_mdio_fec_pdata;
 
@@ -137,7 +138,7 @@ void __init board_init(void)
 	iounmap(bcsr_io);
 }
 
-static void setup_fec1_ioports(struct fs_platform_info*)
+static void setup_fec1_ioports(struct fs_platform_info* pdata)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 
@@ -145,7 +146,7 @@ static void setup_fec1_ioports(struct fs
 	setbits16(&immap->im_ioport.iop_pddir, 0x1fff);
 }
 
-static void setup_scc1_ioports(struct fs_platform_info*)
+static void setup_scc1_ioports(struct fs_platform_info* pdata)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 	unsigned *bcsr_io;
@@ -194,7 +195,7 @@ static void setup_scc1_ioports(struct fs
 
 }
 
-static void setup_smc1_ioports(struct fs_uart_platform_info*)
+static void setup_smc1_ioports(struct fs_uart_platform_info* pdata)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 	unsigned *bcsr_io;
@@ -216,7 +217,7 @@ static void setup_smc1_ioports(struct fs
 
 }
 
-static void setup_smc2_ioports(struct fs_uart_platform_info*)
+static void setup_smc2_ioports(struct fs_uart_platform_info* pdata)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 	unsigned *bcsr_io;
