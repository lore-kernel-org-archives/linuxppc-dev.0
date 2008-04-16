Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <6cafb63611e792391bf4e259ebcee9aa99fd0338.1208317906.git.michael@ellerman.id.au>
In-Reply-To: <0709e3bcb1c8a4341b474f530c1823d2735d26ce.1208317906.git.michael@ellerman.id.au>
References: <0709e3bcb1c8a4341b474f530c1823d2735d26ce.1208317906.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/2] Always add preferred consoles in platforms/pseries/lpar.c
Date: Wed, 16 Apr 2008 13:51:49 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is logic in platforms/peries/lpars.c which checks if the user has
specified a console on the command line, and refrains from adding a
preferred console entry for the hvc/hvsi console if they have.

This trips up if you use "netconsole=foo" on the command line, and has
the result that you get _only_ the netconsole, because the hvc device is
never added as a preferred console. Worse still if you get the netconsole
configuration wrong somehow, you end up with no console at all.

As it turns out we don't need to worry about checking the command line.
If the user has specified "console=foo", then foo will be set as the
preferred console when the command line is parsed in start_kernel(), much
later than the pseries code, and so the latter setting will take effect.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/lpar.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 8a20452..9235c46 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -204,7 +204,6 @@ void __init find_udbg_vterm(void)
 	struct device_node *stdout_node;
 	const u32 *termno;
 	const char *name;
-	int add_console;
 
 	/* find the boot console from /chosen/stdout */
 	if (!of_chosen)
@@ -220,8 +219,6 @@ void __init find_udbg_vterm(void)
 		printk(KERN_WARNING "stdout node missing 'name' property!\n");
 		goto out;
 	}
-	/* The user has requested a console so this is already set up. */
-	add_console = !strstr(cmd_line, "console=");
 
 	/* Check if it's a virtual terminal */
 	if (strncmp(name, "vty", 3) != 0)
@@ -235,15 +232,13 @@ void __init find_udbg_vterm(void)
 		udbg_putc = udbg_putcLP;
 		udbg_getc = udbg_getcLP;
 		udbg_getc_poll = udbg_getc_pollLP;
-		if (add_console)
-			add_preferred_console("hvc", termno[0] & 0xff, NULL);
+		add_preferred_console("hvc", termno[0] & 0xff, NULL);
 	} else if (of_device_is_compatible(stdout_node, "hvterm-protocol")) {
 		vtermno = termno[0];
 		udbg_putc = udbg_hvsi_putc;
 		udbg_getc = udbg_hvsi_getc;
 		udbg_getc_poll = udbg_hvsi_getc_poll;
-		if (add_console)
-			add_preferred_console("hvsi", termno[0] & 0xff, NULL);
+		add_preferred_console("hvsi", termno[0] & 0xff, NULL);
 	}
 out:
 	of_node_put(stdout_node);
-- 
1.5.5
