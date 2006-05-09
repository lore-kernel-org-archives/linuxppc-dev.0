Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 09 May 2006 16:03:51 +1000
Subject: [PATCH] powerpc: Make early debugging options behave with oldconfig
Message-Id: <20060509060353.88680679F2@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If you undefine all the early debugging options and then run make oldconfig,
you don't get prompted to see if you want to enable any of them. This is
annoying.

AFAICT we can't do this just with a choice, because the choice is either
optional, in which case we don't get prompted, or not in which case we _must_
select early debugging.

So add a bool which controls whether we have early debugging at all, and then
if that's enabled provide the choice. The extra bool will actually be useful
in another patch I have lying around, so this is a win-win.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/Kconfig.debug |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

Index: to-merge/arch/powerpc/Kconfig.debug
===================================================================
--- to-merge.orig/arch/powerpc/Kconfig.debug
+++ to-merge/arch/powerpc/Kconfig.debug
@@ -110,13 +110,16 @@ config SERIAL_TEXT_DEBUG
 	depends on 4xx || LOPEC || MV64X60 || PPLUS || PRPMC800 || \
 		PPC_GEN550 || PPC_MPC52xx
 
+config PPC_EARLY_DEBUG
+	bool "Early debugging (dangerous)"
+
 choice
-	prompt "Early debugging (dangerous)"
-	bool
-	optional
+	prompt "Early debugging console"
+	depends on PPC_EARLY_DEBUG
 	help
-	  Enable early debugging. Careful, if you enable debugging for the
-	  wrong type of machine your kernel _will not boot_.
+	  Use the selected console for early debugging. Careful, if you
+	  enable debugging for the wrong type of machine your kernel
+	  _will not boot_.
 
 config PPC_EARLY_DEBUG_LPAR
 	bool "LPAR HV Console"
