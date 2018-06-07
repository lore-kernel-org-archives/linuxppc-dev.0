Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411hB75gfLzF33d
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 20:10:23 +1000 (AEST)
Message-Id: <7268fb263b855d2773b387ad4cfe7e29b4f43e80.1528365638.git.christophe.leroy@c-s.fr>
In-Reply-To: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
References: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/3] powerpc: Allow CPU selection also on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  7 Jun 2018 10:10:20 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch extends to PPC32 the capability to select the exact
CPU type.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/Kconfig.cputype | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 71ef559cc474..ed7c6edec87e 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -86,7 +86,6 @@ endchoice
 
 choice
 	prompt "CPU selection"
-	depends on PPC64
 	default GENERIC_CPU
 	help
 	  This will create a kernel which is optimised for a particular CPU.
@@ -96,13 +95,17 @@ choice
 
 config GENERIC_CPU
 	bool "Generic (POWER4 and above)"
-	depends on !CPU_LITTLE_ENDIAN
+	depends on PPC64 && !CPU_LITTLE_ENDIAN
 
 config GENERIC_CPU
 	bool "Generic (POWER8 and above)"
-	depends on CPU_LITTLE_ENDIAN
+	depends on PPC64 && CPU_LITTLE_ENDIAN
 	select ARCH_HAS_FAST_MULTIPLIER
 
+config GENERIC_CPU
+	bool "Generic 32 bits powerpc"
+	depends on PPC32 && !PPC_8xx
+
 config CELL_CPU
 	bool "Cell Broadband Engine"
 	depends on PPC_BOOK3S_64 && !CPU_LITTLE_ENDIAN
@@ -138,6 +141,10 @@ config E6500_CPU
 	bool "Freescale e6500"
 	depends on E500
 
+config 860_CPU
+	bool "8xx family"
+	depends on PPC_8xx
+
 endchoice
 
 config SPECIAL_CPU_BOOL
@@ -153,7 +160,7 @@ config SPECIAL_CPU
 	default "power7" if POWER7_CPU
 	default "power8" if POWER8_CPU
 	default "power9" if POWER9_CPU
-	default "860" if PPC_8xx
+	default "860" if 860_CPU
 
 config PPC_BOOK3S
 	def_bool y
-- 
2.13.3
