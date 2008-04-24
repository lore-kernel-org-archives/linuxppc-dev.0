Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <72afe553101381c56856158e7ef5260924940959.1209013992.git.michael@ellerman.id.au>
In-Reply-To: <c01702547f6296b2c18e5ff7504ad52cb0402664.1209013992.git.michael@ellerman.id.au>
References: <c01702547f6296b2c18e5ff7504ad52cb0402664.1209013992.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/5] Register udbg console early on pseries LPAR
Date: Thu, 24 Apr 2008 15:13:17 +1000 (EST)
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
 arch/powerpc/platforms/pseries/lpar.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 9235c46..c34789f 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -196,6 +196,8 @@ void __init udbg_init_debug_lpar(void)
 	udbg_putc = udbg_putcLP;
 	udbg_getc = udbg_getcLP;
 	udbg_getc_poll = udbg_getc_pollLP;
+
+	register_early_udbg_console();
 }
 
 /* returns 0 if couldn't find or use /chosen/stdout as console */
-- 
1.5.5
