Subject: Re: U-Boot and kernel 2.6
From: David Woodhouse <dwmw2@infradead.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Meriin Michael-BMM063 <Meriin@motorola.com>,
	"'Ricardo DIz'" <rdiz@alumni.deec.uc.pt>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <40C99182.8050201@intracom.gr>
References: 
	 <0F48024310E5D6118D200002B3A440DB08B07A3D@zil01exm08.mcil.comm.mot.com>
	 <1086950206.15845.1268.camel@hades.cambridge.redhat.com>
	 <40C99182.8050201@intracom.gr>
Content-Type: text/plain
Message-Id: <1086952822.15845.1274.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Fri, 11 Jun 2004 12:20:22 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-06-11 at 14:03 +0300, Pantelis Antoniou wrote:
> Or we can parse the u-boot environment which is ascii.
> I already do this...

Yeah, that works too.

Btw, consoles starting nice and early is nice...

diff -ur --exclude '.*.cmd' --exclude '.config.*' --exclude '*.o' linux-2.6.6-nopci/arch/ppc/syslib/m8260_setup.c linux-2.6.6/arch/ppc/syslib/m8260_setup.c
--- linux-2.6.6-nopci/arch/ppc/syslib/m8260_setup.c	2004-06-11 09:09:03.000000000 +0100
+++ linux-2.6.6/arch/ppc/syslib/m8260_setup.c	2004-06-11 11:39:08.710629736 +0100
@@ -53,6 +53,7 @@
 unsigned char __res[sizeof(bd_t)];

 extern void cpm2_reset(void);
+extern int cpm_uart_console_init(void);

 static void __init
 m8260_setup_arch(void)
@@ -60,6 +61,9 @@
 	/* Reset the Communication Processor Module.
 	*/
 	cpm2_reset();
+#ifdef CONFIG_SERIAL_CPM_CONSOLE
+	cpm_uart_console_init();
+#endif
 }

 /* The decrementer counts at the system (internal) clock frequency
--- linux-2.6.6-nopci/drivers/serial/cpm_uart/cpm_uart_core.c	2004-06-11 09:09:03.000000000 +0100
+++ linux-2.6.6/drivers/serial/cpm_uart/cpm_uart_core.c	2004-06-11 11:38:51.376264960 +0100
@@ -1151,7 +1151,14 @@

 int __init cpm_uart_console_init(void)
 {
-	int ret = cpm_uart_init_portdesc();
+	static int first = 1;
+	int ret;
+
+	if (!first)
+		return 0;
+
+	first = 0;
+	ret = cpm_uart_init_portdesc();

 	if (!ret)
 		register_console(&cpm_scc_uart_console);


--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
