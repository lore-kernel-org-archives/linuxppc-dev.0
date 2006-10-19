Return-Path: <kalle.pokki@iki.fi>
Received: from smtp-1.hut.fi (smtp-1.hut.fi [130.233.228.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0BD6B67B83
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 22:35:58 +1000 (EST)
Date: Thu, 19 Oct 2006 15:31:10 +0300 (EEST)
From: kalle.pokki@iki.fi
To: linuxppc-embedded@ozlabs.org, galak@kernel.crashing.org, panto@intracom.gr,
	vbordug@ru.mvista.com
Subject: [PATCH] CPM_UART: Fix non-console initialisation
Message-ID: <Pine.OSF.4.61.0610191525580.318096@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

If there is a frame buffer console, the cpm_uart_init_portdesc()
function is never called in the compat mode. Also, the set_lineif()
method is not called in the compat mode.

Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>
---
  drivers/serial/cpm_uart/cpm_uart.h      |    2 +-
  drivers/serial/cpm_uart/cpm_uart_core.c |    9 ++++-----
  drivers/serial/cpm_uart/cpm_uart_cpm1.c |    6 +++++-
  drivers/serial/cpm_uart/cpm_uart_cpm2.c |    6 +++++-
  4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
index 3b35cb7..19a6ffe 100644
--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -89,7 +89,7 @@ extern struct uart_cpm_port cpm_uart_por

  /* these are located in their respective files */
  void cpm_line_cr_cmd(int line, int cmd);
-int cpm_uart_init_portdesc(void);
+int __init cpm_uart_init_portdesc(void);
  int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con);
  void cpm_uart_freebuf(struct uart_cpm_port *pinfo);

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 8f3b3e5..895f2f1 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1349,11 +1349,8 @@ static int cpm_uart_init(void) {
  		pr_info("cpm_uart: WARNING: no UART devices found on platform bus!\n");
  		pr_info(
  		"cpm_uart: the driver will guess configuration, but this mode is no longer supported.\n");
-#ifndef CONFIG_SERIAL_CPM_CONSOLE
-		ret = cpm_uart_init_portdesc();
-		if (ret)
-			return ret;
-#endif
+
+		cpm_uart_init_portdesc();

  		cpm_reg.nr = cpm_uart_nr;
  		ret = uart_register_driver(&cpm_reg);
@@ -1365,6 +1362,8 @@ #endif
  			int con = cpm_uart_port_map[i];
  			cpm_uart_ports[con].port.line = i;
  			cpm_uart_ports[con].port.flags = UPF_BOOT_AUTOCONF;
+			if (cpm_uart_ports[con].set_lineif)
+				cpm_uart_ports[con].set_lineif(&cpm_uart_ports[con]);
  			uart_add_one_port(&cpm_reg, &cpm_uart_ports[con].port);
  		}

diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index 95afc37..6f04a9f 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -184,10 +184,14 @@ void cpm_uart_freebuf(struct uart_cpm_po
  }

  /* Setup any dynamic params in the uart desc */
-int cpm_uart_init_portdesc(void)
+int __init cpm_uart_init_portdesc(void)
  {
  	pr_debug("CPM uart[-]:init portdesc\n");

+	/* Don't run this again, if the console driver did it already */
+	if (cpm_uart_nr > 0)
+		return 0;
+
  	cpm_uart_nr = 0;
  #ifdef CONFIG_SERIAL_CPM_SMC1
  	cpm_uart_ports[UART_SMC1].smcp = &cpmp->cp_smc[0];
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index ef3bb47..0f21543 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -252,10 +252,14 @@ void cpm_uart_freebuf(struct uart_cpm_po
  }

  /* Setup any dynamic params in the uart desc */
-int cpm_uart_init_portdesc(void)
+int __init cpm_uart_init_portdesc(void)
  {
  	pr_debug("CPM uart[-]:init portdesc\n");

+	/* Don't run this again, if the console driver did it already */
+	if (cpm_uart_nr > 0)
+		return 0;
+
  	cpm_uart_nr = 0;
  #ifdef CONFIG_SERIAL_CPM_SMC1
  	cpm_uart_ports[UART_SMC1].smcp = (smc_t *) & cpm2_immr->im_smc[0];
-- 
1.4.1.1
