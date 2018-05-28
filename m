Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vf8K72yXzDrpN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 00:17:53 +1000 (AEST)
Message-Id: <0adce33cf1c70ac7203f8ebd987a912451aabd45.1527517001.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/Makefile: fix build failure by disabling
 attribute-alias warning
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 28 May 2018 14:17:49 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Latest GCC version emit many warnings similar to the following one.

As arch/powerpc code is built with -Werror, this breaks build with
GCC 8.1

This patch inhibits that warning

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 26ccd0b91512..d6c557530ce8 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -145,6 +145,8 @@ CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
 CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option,-mno-readonly-in-sdata)
 
+CFLAGS-y += $(call cc-option,-Wno-attribute-alias)
+
 ifeq ($(CONFIG_PPC_BOOK3S_64),y)
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
 CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=power8
-- 
2.13.3
