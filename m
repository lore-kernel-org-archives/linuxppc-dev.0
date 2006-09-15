Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF2D367C49
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 03:39:28 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 7/7] POWERPC: Bring the fs_no calculation to the relevant SoC
	enumeration
Date: Fri, 15 Sep 2006 21:39:22 +0400
Message-Id: <20060915173921.7984.99918.stgit@localhost.localdomain>
In-Reply-To: <20060915213751.128e85f3@localhost.localdomain>
References: <20060915213751.128e85f3@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The fs_no mean used to be fs_enet driver driven, hence it was an
enumeration across all the possible fs_enet "users" in the SoC. Now, with
QE on the pipeline, and to make DTS descriptions more clear, fs_no features
relevant SoC part number, with additional field to describe the SoC type.

Another reason for that is now not only fs_enet is going to utilize those
stuff. There might be UART, HLDC, and even USB, so to prevent confusion and
be ready for upcoming OF_device transfer, fs_enet and cpm_uart drivers were
updated in that concern, as well as the relevant DTS.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/boot/dts/mpc8560ads.dts    |    8 +++----
 arch/powerpc/sysdev/fsl_soc.c           |    8 ++++++-
 drivers/net/fs_enet/fs_enet-main.c      |    3 ++-
 drivers/serial/cpm_uart/cpm_uart_core.c |    9 +++++---
 include/linux/fs_enet_pd.h              |   37 +++++++++++++++++++++++++++++++
 include/linux/fs_uart_pd.h              |   10 ++++++++
 6 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index ba5c943..2b16848 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -244,7 +244,7 @@
 				device_type = "serial";
 				compatible = "cpm_uart";
 				model = "SCC";
-				device-id = <2>;
+				device-id = <1>;
 				reg = <91a00 20 88000 100>;
 				clock-setup = <00ffffff 0>;
 				rx-clock = <1>;
@@ -258,7 +258,7 @@
 				device_type = "serial";
 				compatible = "cpm_uart";
 				model = "SCC";
-				device-id = <3>;
+				device-id = <2>;
 				reg = <91a20 20 88100 100>;
 				clock-setup = <ff00ffff 90000>;
 				rx-clock = <2>;
@@ -272,7 +272,7 @@
 				device_type = "network";
 				compatible = "fs_enet";
 				model = "FCC";
-				device-id = <3>;
+				device-id = <2>;
 				reg = <91320 20 88500 100 913a0 30>;
 				mac-address = [ 00 00 0C 00 02 FD ];
 				clock-setup = <ff00ffff 250000>;
@@ -287,7 +287,7 @@
 				device_type = "network";
 				compatible = "fs_enet";
 				model = "FCC";
-				device-id = <4>;
+				device-id = <3>;
 				reg = <91340 20 88600 100 913d0 30>;
 				mac-address = [ 00 00 0C 00 03 FD ];
 				clock-setup = <ffff00ff 3700>;
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 26153a2..29d027a 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -622,6 +622,7 @@ static int __init fs_enet_of_init(void)
 
 		id = (u32 *) get_property(np, "device-id", NULL);
 		fs_enet_data.fs_no = *id;
+		strcpy(fs_enet_data.fs_type, model);
 
 		mdio = of_get_parent(phy);
                 ret = of_address_to_resource(mdio, 0, &res);
@@ -635,7 +636,7 @@ static int __init fs_enet_of_init(void)
 		fs_enet_data.clk_tx = *((u32 *) get_property(np, "tx-clock", NULL));
 
 		if (strstr(model, "FCC")) {
-			int fcc_index = fs_get_fcc_index(*id);
+			int fcc_index = *id - 1;
 
 			fs_enet_data.dpram_offset = (u32)cpm_dpram_addr(0);
 			fs_enet_data.rx_ring = 32;
@@ -688,6 +689,7 @@ static int __init cpm_uart_of_init(void)
 		struct resource r[3];
 		struct fs_uart_platform_info cpm_uart_data;
 		int *id;
+		char *model;
 
 		memset(r, 0, sizeof(r));
 		memset(&cpm_uart_data, 0, sizeof(cpm_uart_data));
@@ -716,6 +718,10 @@ static int __init cpm_uart_of_init(void)
 
 		id = (int*)get_property(np, "device-id", NULL);
 		cpm_uart_data.fs_no = *id;
+
+		model = (char*)get_property(np, "model", NULL);
+		strcpy(cpm_uart_data.fs_type, model);
+
 		cpm_uart_data.uart_clk = ppc_proc_freq;
 
 		cpm_uart_data.tx_num_fifo = 4;
diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index f358ee6..3e2a3a2 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -944,12 +944,13 @@ extern int fs_mii_connect(struct net_dev
 extern void fs_mii_disconnect(struct net_device *dev);
 
 static struct net_device *fs_init_instance(struct device *dev,
-		const struct fs_platform_info *fpi)
+		struct fs_platform_info *fpi)
 {
 	struct net_device *ndev = NULL;
 	struct fs_enet_private *fep = NULL;
 	int privsize, i, r, err = 0, registered = 0;
 
+	fpi->fs_no = fs_get_id(fpi);
 	/* guard */
 	if ((unsigned int)fpi->fs_no >= FS_MAX_INDEX)
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 24613a6..a0d6136 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1023,15 +1023,17 @@ int cpm_uart_drv_get_platform_data(struc
 {
 	struct resource *r;
 	struct fs_uart_platform_info *pdata = pdev->dev.platform_data;
-	int idx = pdata->fs_no;	/* It is UART_SMCx or UART_SCCx index */
+	int idx;	/* It is UART_SMCx or UART_SCCx index */
 	struct uart_cpm_port *pinfo;
 	int line;
 	u32 mem, pram;
 
+        idx = pdata->fs_no = fs_uart_get_id(pdata);
+
 	line = cpm_uart_id2nr(idx);
 	if(line < 0) {
 		printk(KERN_ERR"%s(): port %d is not registered", __FUNCTION__, idx);
-		return -1;
+		return -EINVAL;
 	}
 
 	pinfo = (struct uart_cpm_port *) &cpm_uart_ports[idx];
@@ -1263,11 +1265,12 @@ static int cpm_uart_drv_probe(struct dev
 	}
 
 	pdata = pdev->dev.platform_data;
-	pr_debug("cpm_uart_drv_probe: Adding CPM UART %d\n", cpm_uart_id2nr(pdata->fs_no));
 
 	if ((ret = cpm_uart_drv_get_platform_data(pdev, 0)))
 		return ret;
 
+	pr_debug("cpm_uart_drv_probe: Adding CPM UART %d\n", cpm_uart_id2nr(pdata->fs_no));
+
 	if (pdata->init_ioports)
                 pdata->init_ioports(pdata);
 
diff --git a/include/linux/fs_enet_pd.h b/include/linux/fs_enet_pd.h
index 9322235..543cd3c 100644
--- a/include/linux/fs_enet_pd.h
+++ b/include/linux/fs_enet_pd.h
@@ -55,6 +55,30 @@ static inline int fs_get_scc_index(enum 
 	return -1;
 }
 
+static inline int fs_fec_index2id(int index)
+{
+	int id = fsid_fec1 + index - 1;
+	if (id >= fsid_fec1 && id <= fsid_fec2)
+		return id;
+	return FS_MAX_INDEX;
+		}
+
+static inline int fs_fcc_index2id(int index)
+{
+	int id = fsid_fcc1 + index - 1;
+	if (id >= fsid_fcc1 && id <= fsid_fcc3)
+		return id;
+	return FS_MAX_INDEX;
+}
+
+static inline int fs_scc_index2id(int index)
+{
+	int id = fsid_scc1 + index - 1;
+	if (id >= fsid_scc1 && id <= fsid_scc4)
+		return id;
+	return FS_MAX_INDEX;
+}
+
 enum fs_mii_method {
 	fsmii_fixed,
 	fsmii_fec,
@@ -91,6 +115,7 @@ struct fs_platform_info {
 	void(*init_ioports)(struct fs_platform_info *);
 	/* device specific information */
 	int fs_no;		/* controller index            */
+	char fs_type[4];	/* controller type             */
 
 	u32 cp_page;		/* CPM page */
 	u32 cp_block;		/* CPM sblock */
@@ -126,4 +151,16 @@ struct fs_mii_fec_platform_info {
 	u32 irq[32];
 	u32 mii_speed;
 };
+
+static inline int fs_get_id(struct fs_platform_info *fpi)
+{
+	if(strstr(fpi->fs_type, "SCC"))
+		return fs_scc_index2id(fpi->fs_no);
+	if(strstr(fpi->fs_type, "FCC"))
+		return fs_fcc_index2id(fpi->fs_no);
+	if(strstr(fpi->fs_type, "FEC"))
+		return fs_fec_index2id(fpi->fs_no);
+	return fpi->fs_no;
+}
+
 #endif
diff --git a/include/linux/fs_uart_pd.h b/include/linux/fs_uart_pd.h
index a99a020..809bb9f 100644
--- a/include/linux/fs_uart_pd.h
+++ b/include/linux/fs_uart_pd.h
@@ -49,6 +49,7 @@ struct fs_uart_platform_info {
         void(*init_ioports)(struct fs_uart_platform_info *);
 	/* device specific information */
 	int fs_no;		/* controller index */
+	char fs_type[4];        /* controller type  */
 	u32 uart_clk;
 	u8 tx_num_fifo;
 	u8 tx_buf_size;
@@ -59,4 +60,13 @@ struct fs_uart_platform_info {
 	u8 clk_tx;
 };
 
+static inline int fs_uart_get_id(struct fs_uart_platform_info *fpi)
+{
+        if(strstr(fpi->fs_type, "SMC"))
+                return fs_uart_id_smc2fsid(fpi->fs_no);
+        if(strstr(fpi->fs_type, "SCC"))
+                return fs_uart_id_scc2fsid(fpi->fs_no);
+        return fpi->fs_no;
+}
+
 #endif
