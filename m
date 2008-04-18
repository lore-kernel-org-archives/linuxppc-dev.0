Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e2c42d8733e0d68fc97a42da7c8a91eab2724661.1208505275.git.michael@ellerman.id.au>
In-Reply-To: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
References: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 03/11] Register udbg console early on pseries LPAR
Date: Fri, 18 Apr 2008 17:54:35 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On pseries LPAR we can call the udbg routines, and the udbg console very
early. So mark the udbg console as safe to call early in boot, and register
the udbg console as soon as the udbg routines are hooked up.

This allows platforms/pseries code to use printk() and pr_debug() rather
than needing to call udbg_printf() directly for early debugging. This is
nice because a) it's standard, b) it goes via the printk buffer, and c)
you can get printk time stamps.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/lpar.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 9235c46..450c237 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -196,6 +196,9 @@ void __init udbg_init_debug_lpar(void)
 	udbg_putc = udbg_putcLP;
 	udbg_getc = udbg_getcLP;
 	udbg_getc_poll = udbg_getc_pollLP;
+
+	udbg_console_anytime();
+	register_early_udbg_console();
 }
 
 /* returns 0 if couldn't find or use /chosen/stdout as console */
-- 
1.5.5
