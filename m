Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 2/2] fsl/embedded6xx: don't cast the result of of_get_property
Message-Id: <1189748800.165997.810365539433.2.gpush@pokey>
In-Reply-To: <1189748800.165136.731062325870.1.gpush@pokey>
To: <linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 14 Sep 2007 15:46:40 +1000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use a temporary variable of the correct type instead.

Also, this allows us to check the return value in ls_uarts_init, to
avoid dereferencing a null pointer if required properties aren't
present.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/embedded6xx/ls_uart.c |   14 +++++++++-----
 arch/powerpc/sysdev/fsl_soc.c                |   18 ++++++++++--------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/ls_uart.c b/arch/powerpc/platforms/embedded6xx/ls_uart.c
index d0bee9f..9d4b40c 100644
--- a/arch/powerpc/platforms/embedded6xx/ls_uart.c
+++ b/arch/powerpc/platforms/embedded6xx/ls_uart.c
@@ -103,20 +103,24 @@ static void __init ls_uart_init(void)
 static int __init ls_uarts_init(void)
 {
 	struct device_node *avr;
-	phys_addr_t phys_addr;
+	const u32 *avr_clock_prop, *phys_addr;
 	int len;
 
 	avr = of_find_node_by_path("/soc10x/serial@80004500");
 	if (!avr)
 		return -EINVAL;
 
-	avr_clock = *(u32*)of_get_property(avr, "clock-frequency", &len);
-	phys_addr = ((u32*)of_get_property(avr, "reg", &len))[0];
+	phys_addr = of_get_property(avr, "reg", &len);
+	avr_clock_prop = of_get_property(avr, "clock-frequency", &len);
 
-	if (!avr_clock || !phys_addr)
+	if (!avr_clock_prop || !phys_addr)
 		return -EINVAL;
 
-	avr_addr = ioremap(phys_addr, 32);
+	avr_clock = *avr_clock_prop;
+	if (!avr_clock || !phys_addr[0])
+		return -EINVAL;
+
+	avr_addr = ioremap(phys_addr[0], 32);
 	if (!avr_addr)
 		return -EFAULT;
 
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 1cf29c9..564d5e5 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -673,6 +673,7 @@ static int __init fs_enet_of_init(void)
 		struct fs_platform_info fs_enet_data;
 		const unsigned int *id, *phy_addr, *phy_irq;
 		const void *mac_addr;
+		const u32 *clk;
 		const phandle *ph;
 		const char *model;
 
@@ -740,10 +741,10 @@ static int __init fs_enet_of_init(void)
                         goto unreg;
                 }
 
-		fs_enet_data.clk_rx = *((u32 *)of_get_property(np,
-						"rx-clock", NULL));
-		fs_enet_data.clk_tx = *((u32 *)of_get_property(np,
-						"tx-clock", NULL));
+		clk = of_get_property(np, "rx-clock", NULL);
+		fs_enet_data.clk_rx = *clk;
+		clk = of_get_property(np, "tx-clock", NULL);
+		fs_enet_data.clk_tx = *clk;
 
 		if (strstr(model, "FCC")) {
 			int fcc_index = *id - 1;
@@ -844,6 +845,7 @@ static int __init cpm_uart_of_init(void)
 		struct resource r[3];
 		struct fs_uart_platform_info cpm_uart_data;
 		const int *id;
+		const u32 *clk;
 		const char *model;
 
 		memset(r, 0, sizeof(r));
@@ -882,10 +884,10 @@ static int __init cpm_uart_of_init(void)
 		cpm_uart_data.tx_buf_size = 32;
 		cpm_uart_data.rx_num_fifo = 4;
 		cpm_uart_data.rx_buf_size = 32;
-		cpm_uart_data.clk_rx = *((u32 *)of_get_property(np,
-						"rx-clock", NULL));
-		cpm_uart_data.clk_tx = *((u32 *)of_get_property(np,
-						"tx-clock", NULL));
+		clk = of_get_property(np, "rx-clock", NULL);
+		cpm_uart_data.clk_rx = *clk;
+		clk = of_get_property(np, "tx-clock", NULL);
+		cpm_uart_data.clk_tx = *clk;
 
 		ret =
 		    platform_device_add_data(cpm_uart_dev, &cpm_uart_data,
