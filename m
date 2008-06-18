Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Wed, 18 Jun 2008 10:47:34 +1000
Subject: [PATCH 9/9] powerpc: Add CONFIG_VSX config option
In-Reply-To: <1213750053.678227.22239172650.qpush@coopers>
Message-Id: <20080618004734.4EBD670291@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add CONFIG_VSX config build option.  Must compile with POWER4, FPU and ALTIVEC.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/platforms/Kconfig.cputype |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: linux-2.6-ozlabs/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/Kconfig.cputype
+++ linux-2.6-ozlabs/arch/powerpc/platforms/Kconfig.cputype
@@ -171,6 +171,22 @@ config VSX
 
 	  If in doubt, say Y here.
 
+config VSX
+	bool "VSX Support"
+	depends on POWER4 && ALTIVEC && PPC_FPU
+	---help---
+
+	  This option enables kernel support for the Vector Scaler extensions
+	  to the PowerPC processor. The kernel currently supports saving and
+	  restoring VSX registers, and turning on the 'VSX enable' bit so user
+	  processes can execute VSX instructions.
+
+	  This option is only usefully if you have a processor that supports
+	  VSX (P7 and above), but does not have any affect on a non-VSX
+	  CPUs (it does, however add code to the kernel).
+
+	  If in doubt, say Y here.
+
 config SPE
 	bool "SPE Support"
 	depends on E200 || E500
