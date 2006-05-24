Return-Path: <vbordug@ru.mvista.com>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AB30467A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 May 2006 03:40:27 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH] ppc32 CPM_UART: various fixes for pq2 uart users
Date: Wed, 24 May 2006 21:40:18 +0400
Message-Id: <20060524174018.15173.67998.stgit@vitb.ru.mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This fixes various odd things that missed update together with cpm_uart
platform_device move. Unified resources names, restructurisation, etc.
Also, addressed issue with recent phys/virt translation rework. Being
cache-coherent, CPM2's do alloc_bootmem() for the console stuff, and it was
used to treat console buffer descriptor mapping 1:1 (as in CPM1 case),
which is definitely wrong.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/ppc/platforms/mpc8272ads_setup.c   |   10 +++++-----
 arch/ppc/syslib/pq2_devices.c           |   16 ++++++++--------
 arch/ppc/syslib/pq2_sys.c               |    8 ++++----
 drivers/serial/cpm_uart/cpm_uart_core.c |    8 +++++---
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    2 +-
 5 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/ppc/platforms/mpc8272ads_setup.c b/arch/ppc/platforms/mpc8272ads_setup.c
index e62b757..abb7154 100644
--- a/arch/ppc/platforms/mpc8272ads_setup.c
+++ b/arch/ppc/platforms/mpc8272ads_setup.c
@@ -279,11 +279,11 @@ static int mpc8272ads_platform_notify(st
 	static const struct platform_notify_dev_map dev_map[] = {
 		{
 			.bus_id = "fsl-cpm-fcc",
-			.rtn = mpc8272ads_fixup_enet_pdata
+			.rtn = mpc8272ads_fixup_enet_pdata,
 		},
 		{
 			.bus_id = "fsl-cpm-scc:uart",
-			.rtn = mpc
+			.rtn = mpc8272ads_fixup_uart_pdata,
 		},
 		{
 			.bus_id = NULL
@@ -335,15 +335,15 @@ struct platform_device* early_uart_get_p
 	struct platform_device* pdev = NULL;
 	if(index) { /*assume SCC4 here*/
 		pdev = &ppc_sys_platform_devices[MPC82xx_CPM_SCC4];
-		pinfo = &mpc8272<F12>_uart_pdata[1];
+		pinfo = &mpc8272_uart_pdata[fsid_scc4_uart];
 	} else { /*over SCC1*/
 		pdev = &ppc_sys_platform_devices[MPC82xx_CPM_SCC1];
-		pinfo = &mpc8272_uart_pdata[0];
+		pinfo = &mpc8272_uart_pdata[fsid_scc1_uart];
 	}
 
 	pinfo->uart_clk = bd->bi_intfreq;
 	pdev->dev.platform_data = pinfo;
-	ppc_sys_fixup_mem_resource(pdev, IMAP_ADDR);
+	ppc_sys_fixup_mem_resource(pdev, CPM_MAP_ADDR);
 	return NULL;
 }
 
diff --git a/arch/ppc/syslib/pq2_devices.c b/arch/ppc/syslib/pq2_devices.c
index 0636aed..8692d00 100644
--- a/arch/ppc/syslib/pq2_devices.c
+++ b/arch/ppc/syslib/pq2_devices.c
@@ -121,13 +121,13 @@ struct platform_device ppc_sys_platform_
 		.num_resources	 = 3,
 		.resource = (struct resource[]) {
 			{
-				.name	= "scc_mem",
+				.name	= "regs",
 				.start	= 0x11A00,
 				.end	= 0x11A1F,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
-				.name	= "scc_pram",
+				.name	= "pram",
 				.start	= 0x8000,
 				.end	= 0x80ff,
 				.flags	= IORESOURCE_MEM,
@@ -145,13 +145,13 @@ struct platform_device ppc_sys_platform_
 		.num_resources	 = 3,
 		.resource = (struct resource[]) {
 			{
-				.name	= "scc_mem",
+				.name	= "regs",
 				.start	= 0x11A20,
 				.end	= 0x11A3F,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
-				.name	= "scc_pram",
+				.name	= "pram",
 				.start	= 0x8100,
 				.end	= 0x81ff,
 				.flags	= IORESOURCE_MEM,
@@ -169,13 +169,13 @@ struct platform_device ppc_sys_platform_
 		.num_resources	 = 3,
 		.resource = (struct resource[]) {
 			{
-				.name 	= "scc_mem",
+				.name 	= "regs",
 				.start	= 0x11A40,
 				.end	= 0x11A5F,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
-				.name	= "scc_pram",
+				.name	= "pram",
 				.start	= 0x8200,
 				.end	= 0x82ff,
 				.flags	= IORESOURCE_MEM,
@@ -193,13 +193,13 @@ struct platform_device ppc_sys_platform_
 		.num_resources	 = 3,
 		.resource = (struct resource[]) {
 			{
-				.name	= "scc_mem",
+				.name	= "regs",
 				.start	= 0x11A60,
 				.end	= 0x11A7F,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
-				.name	= "scc_pram",
+				.name	= "pram",
 				.start	= 0x8300,
 				.end	= 0x83ff,
 				.flags	= IORESOURCE_MEM,
diff --git a/arch/ppc/syslib/pq2_sys.c b/arch/ppc/syslib/pq2_sys.c
index 433b0fa..fee8948 100644
--- a/arch/ppc/syslib/pq2_sys.c
+++ b/arch/ppc/syslib/pq2_sys.c
@@ -139,13 +139,13 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		.ppc_sys_name	= "8272",
 		.mask		= 0x0000ff00,
 		.value		= 0x00000c00,
-		.num_devices	= 11,
+		.num_devices	= 12,
 		.device_list = (enum ppc_sys_devices[])
 		{
 			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_SCC1,
-			MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3, MPC82xx_CPM_SMC1,
-			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
-			MPC82xx_CPM_USB, MPC82xx_SEC1,
+			MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3, MPC82xx_CPM_SCC4,
+			MPC82xx_CPM_SMC1, MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI,
+			MPC82xx_CPM_I2C, MPC82xx_CPM_USB, MPC82xx_SEC1,
 		},
 	},
 	/* below is a list of the 8280 family of processors */
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 969f949..5cba59a 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1164,14 +1164,16 @@ static int __init cpm_uart_console_setup
 	struct fs_uart_platform_info *pdata;
 	struct platform_device* pdev = early_uart_get_pdev(co->index);
 
-	port =
-	    (struct uart_port *)&cpm_uart_ports[cpm_uart_port_map[co->index]];
-	pinfo = (struct uart_cpm_port *)port;
 	if (!pdev) {
 		pr_info("cpm_uart: console: compat mode\n");
 		/* compatibility - will be cleaned up */
 		cpm_uart_init_portdesc();
+	}
 
+	port =
+	    (struct uart_port *)&cpm_uart_ports[cpm_uart_port_map[co->index]];
+	pinfo = (struct uart_cpm_port *)port;
+	if (!pdev) {
 		if (pinfo->set_lineif)
 			pinfo->set_lineif(pinfo);
 	} else {
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index 4b2de08..cdba128 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -213,7 +213,7 @@ int cpm_uart_allocbuf(struct uart_cpm_po
 	    L1_CACHE_ALIGN(pinfo->tx_nrfifos * pinfo->tx_fifosize);
 	if (is_con) {
 		mem_addr = alloc_bootmem(memsz);
-		dma_addr = mem_addr;
+		dma_addr = virt_to_bus(mem_addr);
 	}
 	else
 		mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
