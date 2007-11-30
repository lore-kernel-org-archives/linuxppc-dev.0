Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 Nov 2007 17:10:44 +1100
Subject: [PATCH 5/24] powerpc: Fix 440SPE machine check
In-Reply-To: <1196403038.569525.367459803520.qpush@grosgo>
Message-Id: <20071130061147.AE528DDEC6@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 440SPE has a 440A core, and thus needs a setup_cpu function to
fixup its machine check handler.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/cpu_setup_44x.S |    1 +
 arch/powerpc/kernel/cputable.c      |    3 +++
 2 files changed, 4 insertions(+)

Index: linux-work/arch/powerpc/kernel/cpu_setup_44x.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/cpu_setup_44x.S	2007-11-27 16:13:04.000000000 +1100
+++ linux-work/arch/powerpc/kernel/cpu_setup_44x.S	2007-11-27 16:13:09.000000000 +1100
@@ -29,6 +29,7 @@ _GLOBAL(__setup_cpu_440epx)
 _GLOBAL(__setup_cpu_440grx)
 	b	__plb_disable_wrp
 _GLOBAL(__setup_cpu_440gx)
+_GLOBAL(__setup_cpu_440spe)
 	b	__fixup_440A_mcheck
 
  /* Temporary fixup for arch/ppc until we kill the whole thing */
Index: linux-work/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/cputable.c	2007-11-27 16:11:27.000000000 +1100
+++ linux-work/arch/powerpc/kernel/cputable.c	2007-11-27 16:13:51.000000000 +1100
@@ -35,6 +35,7 @@ extern void __setup_cpu_440ep(unsigned l
 extern void __setup_cpu_440epx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_440gx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_440grx(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_440spe(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
@@ -1248,6 +1249,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features      = COMMON_USER_BOOKE,
 		.icache_bsize           = 32,
 		.dcache_bsize           = 32,
+		.cpu_setup		= __setup_cpu_440spe,
 		.platform               = "ppc440",
 	},
 	{ /* 440SPe Rev. B */
@@ -1258,6 +1260,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440spe,
 		.platform		= "ppc440",
 	},
 #endif /* CONFIG_44x */
