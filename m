Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PSJq6mVrzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 00:24:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	rdunlap@infradead.org,
	malat@debian.org
Subject: [PATCH 2/2] powerpc: Add ppc64le and ppc64_book3e allmodconfig targets
Date: Tue, 10 Jul 2018 00:24:26 +1000
Message-Id: <20180709142426.26999-2-mpe@ellerman.id.au>
In-Reply-To: <20180709142426.26999-1-mpe@ellerman.id.au>
References: <20180709142426.26999-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Similarly as we just did for 32-bit, add phony targets for generating
a little endian and Book3E allmodconfig. These aren't covered by the
regular allmodconfig, which is big endian and Book3S due to the way
the Kconfig symbols are structured.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 2556c2182789..48e887f03a6c 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -359,6 +359,16 @@ ppc32_allmodconfig:
 	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/book3s_32.config \
 		-f $(srctree)/Makefile allmodconfig
 
+PHONY += ppc64le_allmodconfig
+ppc64le_allmodconfig:
+	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/le.config \
+		-f $(srctree)/Makefile allmodconfig
+
+PHONY += ppc64_book3e_allmodconfig
+ppc64_book3e_allmodconfig:
+	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/85xx-64bit.config \
+		-f $(srctree)/Makefile allmodconfig
+
 define archhelp
   @echo '* zImage          - Build default images selected by kernel config'
   @echo '  zImage.*        - Compressed kernel image (arch/$(ARCH)/boot/zImage.*)'
-- 
2.14.1
