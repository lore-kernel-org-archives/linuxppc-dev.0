Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7E0CFDDEE3
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 23:16:55 +1000 (EST)
From: Marvin <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] reorganize cputypes for PPC64
Date: Sat, 12 Jul 2008 15:16:49 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_B7KeIb7etm6ejQ7"
Message-Id: <200807121516.49576.marvin24@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_B7KeIb7etm6ejQ7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

attached patch introduces a "processor type" menu similar to ppc32. It 
_should_ not change anything upto now. 

The aim is to allow future fine graded cpu optimizations via mcpu/mtune 
compiler flags and also to clean up the arch Makefile/Kconfig.cputypes (I 
know this is a minefield).

Greetings

Marvin


--Boundary-00=_B7KeIb7etm6ejQ7
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ppc64_cputypes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ppc64_cputypes.patch"

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f7efaa9..eebde6c 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -54,35 +54,65 @@ config E200
 
 endchoice
 
-config POWER4_ONLY
-	bool "Optimize for POWER4"
+choice
+	prompt "Processor Type"
 	depends on PPC64
+	default TUNE_POWER4
+	help
+	  There are serveral families of 64 bit PowerPC chips supported.
+	  These include the Power3 to Power6 series, 970, and Cell BE based
+	  CPUs made be IBM.
+
+	  If unsure, select Power4.
+
+config TUNE_POWER3
+	bool "Power3"
+
+config TUNE_POWER4
+	bool "Power4"
+
+config TUNE_970
+	bool "970/G5"
+
+config TUNE_POWER5
+	bool "Power5"
+
+config TUNE_POWER6
+	bool "Power6"
+
+config TUNE_CELL
+	bool "Cell Broadband Engine"
+	help
+	  Cause the compiler to optimize for the PPE of the Cell Broadband
+	  Engine. This will make the code run considerably faster on Cell
+	  but somewhat slower on other machines. If the resulting kernel is
+	  built to run only on Cell BE machines, select also OPT_EXCLUSIVE.
+
+endchoice
+
+config OPT_EXCLUSIVE
+	bool "Optimize to run exclusive on selected CPU"
 	default n
-	---help---
-	  Cause the compiler to optimize for POWER4/POWER5/PPC970 processors.
-	  The resulting binary will not work on POWER3 or RS64 processors
-	  when compiled with binutils 2.15 or later.
+	help
+	  Cause the compiler to optimize to run exclusive on the selected
+	  CPU. The resulting binary will probably not work on other CPUs.
+	  
+	  If the compiler/binutils combination does not support the exclusive
+	  optimization, it will try to tune only or fail.
+	  
+	  If you are unsure, select no.
 
 config POWER3
-	bool
 	depends on PPC64
-	default y if !POWER4_ONLY
+	def_bool y if !POWER4_ONLY
 
 config POWER4
 	depends on PPC64
 	def_bool y
 
-config TUNE_CELL
-	bool "Optimize for Cell Broadband Engine"
+config POWER4_ONLY
 	depends on PPC64
-	help
-	  Cause the compiler to optimize for the PPE of the Cell Broadband
-	  Engine. This will make the code run considerably faster on Cell
-	  but somewhat slower on other machines. This option only changes
-	  the scheduling of instructions, not the selection of instructions
-	  itself, so the resulting kernel will keep running on all other
-	  machines. When building a kernel that is supposed to run only
-	  on Cell, you should also select the POWER4_ONLY option.
+	def_bool y if TUNE_POWER4 && OPT_EXCLUSIVE
 
 config 6xx
 	bool

--Boundary-00=_B7KeIb7etm6ejQ7--
