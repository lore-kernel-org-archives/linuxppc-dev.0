Return-Path: <waldi@debian.org>
Received: from wavehammer.waldi.eu.org (wavehammer.waldi.eu.org
	[82.139.201.20]) by ozlabs.org (Postfix) with ESMTP id 48A70DDDF5
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 05:30:02 +1000 (EST)
Date: Mon, 28 Jul 2008 20:56:51 +0200
From: Bastian Blank <waldi@debian.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/lpar - defer prefered console setup
Message-ID: <20080728185651.GA29530@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

The powerpc lpar code adds a prefered console at a very early state,
during arch_setup. This runs even before the console setup from the
command line and takes preference.

This patch moves the prefered console setup into an arch_initcall which
runs later and allows the specification of the correct console on the
command line. The udbg console remains as boot console.

There is a different problem that the code does not pick up the correct
console because it uses a part (4) of the lpar device number (30000004)
instead of the correct index 1.

Signed-off-by: Bastian Blank <waldi@debian.org>

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 9235c46..626290d 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -57,6 +57,7 @@ extern void pSeries_find_serial_port(void);
 
 
 int vtermno;	/* virtual terminal# for udbg  */
+static char *console_name;
 
 #define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))
 static void udbg_hvsi_putc(char c)
@@ -232,18 +233,24 @@ void __init find_udbg_vterm(void)
 		udbg_putc = udbg_putcLP;
 		udbg_getc = udbg_getcLP;
 		udbg_getc_poll = udbg_getc_pollLP;
-		add_preferred_console("hvc", termno[0] & 0xff, NULL);
+		console_name = "hvc";
 	} else if (of_device_is_compatible(stdout_node, "hvterm-protocol")) {
-		vtermno = termno[0];
 		udbg_putc = udbg_hvsi_putc;
 		udbg_getc = udbg_hvsi_getc;
 		udbg_getc_poll = udbg_hvsi_getc_poll;
-		add_preferred_console("hvsi", termno[0] & 0xff, NULL);
+		console_name = "hvsi";
 	}
 out:
 	of_node_put(stdout_node);
 }
 
+static void __init enable_vterm(void)
+{
+	if (console_name)
+		add_preferred_console(console_name, vtermno, NULL);
+}
+arch_initcall(enable_vterm);
+
 void vpa_init(int cpu)
 {
 	int hwcpu = get_hard_smp_processor_id(cpu);

-- 
Genius doesn't work on an assembly line basis.  You can't simply say,
"Today I will be brilliant."
		-- Kirk, "The Ultimate Computer", stardate 4731.3
