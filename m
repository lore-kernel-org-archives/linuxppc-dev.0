Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411hBB0dT2zDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 20:10:25 +1000 (AEST)
Message-Id: <630b39e3b632912e982168782e071ddf15336eb3.1528365638.git.christophe.leroy@c-s.fr>
In-Reply-To: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
References: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/3] powerpc: Allow CPU selection of e300core variants
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  7 Jun 2018 10:10:22 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

GCC supports -mcpu=e300c2 and -mcpu=e300c3

This patch gives the opportunity to tune kernel to one of
those two types.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/Kconfig.cputype | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index ed7c6edec87e..d174acb41389 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -145,6 +145,14 @@ config 860_CPU
 	bool "8xx family"
 	depends on PPC_8xx
 
+config E300C2_CPU
+	bool "e300c2 (832x)"
+	depends on PPC_BOOK3S_32
+
+config E300C3_CPU
+	bool "e300c3 (831x)"
+	depends on PPC_BOOK3S_32
+
 endchoice
 
 config SPECIAL_CPU_BOOL
@@ -161,6 +169,8 @@ config SPECIAL_CPU
 	default "power8" if POWER8_CPU
 	default "power9" if POWER9_CPU
 	default "860" if 860_CPU
+	default "e300c2" if E300C2_CPU
+	default "e300c3" if E300C3_CPU
 
 config PPC_BOOK3S
 	def_bool y
-- 
2.13.3
