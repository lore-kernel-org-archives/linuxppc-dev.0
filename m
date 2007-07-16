Return-Path: <rongkai.zhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 1FC69DDE32
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 05:48:52 +1000 (EST)
Message-ID: <469B33F9.2080604@windriver.com>
Date: Mon, 16 Jul 2007 17:01:45 +0800
From: Mark Zhan <rongkai.zhan@windriver.com>
MIME-Version: 1.0
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] 82xx: Parse SMC serial device node in DTS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes 'cpm_uart_of_init' be able to parses SMC serial device node in DTS

Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
---
  arch/powerpc/sysdev/fsl_soc.c |   37 ++++++++++++++++++++-----------------
  1 file changed, 20 insertions(+), 17 deletions(-)

Index: linux-powerpc-2.6.x/arch/powerpc/sysdev/fsl_soc.c
===================================================================
--- linux-powerpc-2.6.x.orig/arch/powerpc/sysdev/fsl_soc.c	2007-07-16 15:52:17.000000000 +0800
+++ linux-powerpc-2.6.x/arch/powerpc/sysdev/fsl_soc.c	2007-07-16 16:59:31.000000000 +0800
@@ -757,8 +757,8 @@

  arch_initcall(fs_enet_of_init);

-static const char scc_regs[] = "regs";
-static const char scc_pram[] = "pram";
+static const char cpm_uart_regs[] = "regs";
+static const char cpm_uart_pram[] = "pram";

  static int __init cpm_uart_of_init(void)
  {
@@ -775,6 +775,7 @@
  		const int *id;
  		const char *model;

+		cpm_uart_dev = NULL;
  		memset(r, 0, sizeof(r));
  		memset(&cpm_uart_data, 0, sizeof(cpm_uart_data));

@@ -782,31 +783,35 @@
  		if (ret)
  			goto err;

-		r[0].name = scc_regs;
+		r[0].name = cpm_uart_regs;

  		ret = of_address_to_resource(np, 1, &r[1]);
  		if (ret)
  			goto err;
-		r[1].name = scc_pram;
+		r[1].name = cpm_uart_pram;

  		of_irq_to_resource(np, 0, &r[2]);

-		cpm_uart_dev =
-		    platform_device_register_simple("fsl-cpm-scc:uart", i, &r[0], 3);
-
-		if (IS_ERR(cpm_uart_dev)) {
-			ret = PTR_ERR(cpm_uart_dev);
-			goto err;
-		}
-
  		id = of_get_property(np, "device-id", NULL);
  		cpm_uart_data.fs_no = *id;

  		model = of_get_property(np, "model", NULL);
  		strcpy(cpm_uart_data.fs_type, model);

-		cpm_uart_data.uart_clk = ppc_proc_freq;
+		if (strstr(model, "SMC")) {
+			cpm_uart_dev = platform_device_register_simple("fsl-cpm-smc:uart",
+							i, &r[0], 3);
+		} else if (strstr(model, "SCC")) {
+			cpm_uart_dev = platform_device_register_simple("fsl-cpm-scc:uart",
+							i, &r[0], 3);
+		}

+		if (IS_ERR(cpm_uart_dev)) {
+			ret = PTR_ERR(cpm_uart_dev);
+			goto err;
+		}
+
+		cpm_uart_data.uart_clk = ppc_proc_freq;
  		cpm_uart_data.tx_num_fifo = 4;
  		cpm_uart_data.tx_buf_size = 32;
  		cpm_uart_data.rx_num_fifo = 4;
@@ -816,10 +821,8 @@
  		cpm_uart_data.clk_tx = *((u32 *)of_get_property(np,
  						"tx-clock", NULL));

-		ret =
-		    platform_device_add_data(cpm_uart_dev, &cpm_uart_data,
-					     sizeof(struct
-						    fs_uart_platform_info));
+		ret = platform_device_add_data(cpm_uart_dev, &cpm_uart_data,
+					sizeof(struct fs_uart_platform_info));
  		if (ret)
  			goto unreg;
  	}
