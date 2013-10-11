Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id CF9CF2C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 23:56:46 +1100 (EST)
Date: Fri, 11 Oct 2013 14:56:40 +0200
Message-Id: <201310111256.r9BCuepM006243@localhost.localdomain>
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc 8xx: Fixing memory init issue with CONFIG_PIN_TLB
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Activating CONFIG_PIN_TLB allows access to the 24 first Mbytes of memory at
bootup instead of 8. It is needed for "big" kernels for instance when activating
CONFIG_LOCKDEP_SUPPORT. This needs to be taken into account in init_32 too,
otherwise memory allocation soon fails after startup.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

diff -ur linux-3.11.org/arch/powerpc/kernel/head_8xx.S linux-3.11/arch/powerpc/kernel/head_8xx.S
--- linux-3.11.org/arch/powerpc/mm/init_32.c	2013-09-02 22:46:10.000000000 +0200
+++ linux-3.11/arch/powerpc/mm/init_32.c	2013-09-09 11:28:54.000000000 +0200
@@ -213,7 +213,12 @@
 	 */
 	BUG_ON(first_memblock_base != 0);
 
+#ifdef CONFIG_PIN_TLB
+	/* 8xx can only access 24MB at the moment */
+	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x01800000));
+#else
 	/* 8xx can only access 8MB at the moment */
 	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x00800000));
+#endif
 }
 #endif /* CONFIG_8xx */
