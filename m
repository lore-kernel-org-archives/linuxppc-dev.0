Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40R36d4sJRzF1xm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 23:36:09 +1000 (AEST)
Message-Id: <0051d3c950c957983c018230b7fd3c7ddde513f7.1524055122.git.christophe.leroy@c-s.fr>
In-Reply-To: <fe9959328efb520e6030476553ed23541c547639.1524055122.git.christophe.leroy@c-s.fr>
References: <fe9959328efb520e6030476553ed23541c547639.1524055122.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/2] powerpc: Allow selection of
 CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 18 Apr 2018 15:36:05 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This option does dead code and data elimination with the linker by
compiling with -ffunction-sections -fdata-sections and linking with
--gc-sections.

By selecting this option on mpc885_ads_defconfig,
vmlinux LOAD segment size gets reduced by 10%

Program Header before the patch:
    LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**16
         filesz 0x0036eda4 memsz 0x0038de04 flags rwx

Program Header after the patch:
    LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**16
         filesz 0x00316da4 memsz 0x00334268 flags rwx

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8fe4353be5e3..e1fac49cf465 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -888,6 +888,14 @@ config PPC_MEM_KEYS
 
 	  If unsure, say y.
 
+config PPC_UNUSED_ELIMINATION
+	bool "Eliminate unused functions and data from vmlinux"
+	default n
+	select LD_DEAD_CODE_DATA_ELIMINATION
+	help
+	  Select this to do dead code and data elimination with the linker
+	  by compiling with -ffunction-sections -fdata-sections and linking
+	  with --gc-sections.
 endmenu
 
 config ISA_DMA_API
-- 
2.13.3
