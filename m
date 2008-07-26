Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 58C91DDF19
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 02:45:28 +1000 (EST)
From: Marvin <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] [PPC64] add tuning options to Kconfig.cputype
Date: Sat, 26 Jul 2008 18:39:27 +0200
References: <200807261833.55994.marvin24@gmx.de>
In-Reply-To: <200807261833.55994.marvin24@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807261839.27862.marvin24@gmx.de>
Cc: olof@lixom.net, miltonm@bga.com, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch adds CPU selection to Kconfig.cputype. I did my best to make oldconfig
happy, but some things just don't work ;-) Maybe more CPUs and help texts can be 
added, but it should be enough for now.

Subject: [PATCH 1/2] [PPC64] add tuning options to Kconfig.cputype

---
 arch/powerpc/platforms/Kconfig.cputype |  133 ++++++++++++++++++++++++++++---
 1 files changed, 120 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 7f65127..f528748 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -56,8 +56,127 @@ config E200
 
 endchoice
 
+config TUNE_OPT_CPU
+	depends on PPC64
+	def_bool n 
+	prompt "Tune/optimize for a specific CPU"
+	help
+	    This option enables a sub-menu where you can choose a certain
+	    CPU to tune (via -mtune) or optimize (via -mcpu) for.
+
+choice
+	depends on TUNE_OPT_CPU
+	prompt "Choose the CPU to tune for"
+	default TUNE_POWER4
+	help
+	  Choosing this will make the code run faster on the selected CPU, 
+	  but somehow slower on others.
+	  
+          This option only changes the scheduling of instructions, not the 
+          selection of instructions itself, so the resulting kernel will keep 
+          running on all other machines.
+          
+          The default is to tune for power4.
+
+config TUNE_RS64
+	bool "RS64"
+
+config TUNE_POWER3
+	bool "POWER3"
+
+config TUNE_POWER4
+	bool "POWER4/G5/970"
+	help
+	  Cause the compiler to tune for the POWER4 and derivates CPUS, like
+	  G5 and other PPC970 variants.
+	  
+config TUNE_POWER5
+	bool "POWER5"
+
+config TUNE_POWER6
+	bool "POWER6"
+
+config TUNE_CELL
+	bool "Cell Broadband Engine"
+	help
+	  Cause the compiler to optimize for the PPE of the Cell Broadband
+	  Engine. This will make the code run considerably faster on Cell
+	  but somewhat slower on other machines. This option only changes
+	  the scheduling of instructions, not the selection of instructions
+	  itself, so the resulting kernel will keep running on all other
+	  machines.
+	  
+endchoice
+
+choice
+	depends on TUNE_OPT_CPU
+	default OPT_NONE
+	prompt "Choose the CPU to optimize for"
+	help
+	  Choosing this will make the code run significant faster on the 
+	  selected CPU by selecting the scheduling and the instruction set
+	  for the specific CPU. It will propably not run on earlier gernerations
+	  but should run on newer ones.
+	  
+          The default is not to optimize for a specific CPU.
+
+config OPT_NONE
+	bool "none"
+
+config OPT_RS64
+	bool "RS64"
+
+config OPT_POWER3
+	bool "POWER3"
+	select POWER3
+
+config OPT_POWER4
+	bool "POWER4"
+	select POWER4_ONLY
+	---help---
+	  Cause the compiler to optimize for POWER4 processors. The resulting 
+	  binary will not work on POWER3 or RS64 processors when compiled 
+	  with binutils 2.15 or later.
+
+config OPT_PPC970
+	bool "G5/PPC970"
+	select POWER4_ONLY
+
+config OPT_POWER5
+	bool "POWER5"
+	select POWER4_ONLY
+
+config OPT_POWER6
+	bool "POWER6"	
+	select POWER4_ONLY
+
+endchoice
+
+config OPT_CPU
+	depends on PPC64
+	string
+	default "rs64"   if OPT_RS64
+	default "power3" if OPT_POWER3
+	default "power4" if OPT_POWER4
+	default "970"    if OPT_PPC970
+	default "power5" if OPT_POWER5
+	default "power6" if OPT_POWER6
+	default "cell"   if OPT_CELL
+	default ""
+
+config TUNE_CPU
+	depends on PPC64
+	string
+	default "rs64"   if TUNE_RS64
+	default "power3" if TUNE_POWER3
+	default "power5" if TUNE_POWER5
+	default "power6" if TUNE_POWER6
+	default "cell"   if TUNE_CELL
+	default "power4"
+
 config POWER4_ONLY
-	bool "Optimize for POWER4"
+	bool 
+	prompt "Optimize for POWER4" if !TUNE_OPT_CPU
 	depends on PPC64
 	default n
 	---help---
@@ -74,18 +193,6 @@ config POWER4
 	depends on PPC64
 	def_bool y
 
-config TUNE_CELL
-	bool "Optimize for Cell Broadband Engine"
-	depends on PPC64
-	help
-	  Cause the compiler to optimize for the PPE of the Cell Broadband
-	  Engine. This will make the code run considerably faster on Cell
-	  but somewhat slower on other machines. This option only changes
-	  the scheduling of instructions, not the selection of instructions
-	  itself, so the resulting kernel will keep running on all other
-	  machines. When building a kernel that is supposed to run only
-	  on Cell, you should also select the POWER4_ONLY option.
-
 # this is temp to handle compat with arch=ppc
 config 8xx
 	bool
-- 
1.5.6.2
