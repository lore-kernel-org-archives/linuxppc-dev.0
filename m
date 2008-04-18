Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 01/11] Set udbg_console index to 0
Date: Fri, 18 Apr 2008 17:54:34 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Because the udbg_console has CON_ENABLED set, it's possible that when we
register it with the console code the index won't be set. This leads to
slightly confusing boot messages like:

[    0.000000] console [udbg-1] enabled

We could remove CON_ENABLED, but we don't want to do that, we always
want the udbg console to be activated, even if the user specified some
other console on the command line.

The simplest fix seems to be just to set the index to 0 by hand. There
is no issue with duplicate udbg consoles, as we guard against registering
multiple times in register_early_udbg_console().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/udbg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 7aad620..9ac5f3a 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -155,7 +155,7 @@ static struct console udbg_console = {
 	.name	= "udbg",
 	.write	= udbg_console_write,
 	.flags	= CON_PRINTBUFFER | CON_ENABLED | CON_BOOT,
-	.index	= -1,
+	.index	= 0,
 };
 
 static int early_console_initialized;
-- 
1.5.5
