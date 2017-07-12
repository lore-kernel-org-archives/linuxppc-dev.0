Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6vmj09KPzDqjY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 20:08:52 +1000 (AEST)
Message-Id: <e180ea05ab13a9e0099f09c2223aa509a2ba4329.1499633349.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1499633349.git.christophe.leroy@c-s.fr>
References: <cover.1499633349.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/7] powerpc/32: Avoid risk of unrecoverable TLBmiss inside
 entry_32.S
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Jul 2017 12:08:49 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By default, the 8xx pins an ITLB on the first 8M of memory in order
to avoid any ITLB miss on kernel code.
However, with some debug functions like DEBUG_PAGEALLOC and
DEBUG_RODATA, pinning TLBs is contradictory.

In order to avoid any ITLB miss in a critical section without pinning
TLBs, we have to ensure that there is no page boundary crossed between
the setup of a new value in SRR0/SRR1 and the associated RFI.

The functions modifying srr0/srr1 are all located in setup_32.S.
They are spread over almost 4kbytes.

The patch forces a 12 bits (4kbytes) alignment for those
functions. This garanties that the functions remain in a
single 4k page.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 8587059ad848..4e9a359ceff6 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -43,6 +43,13 @@
 #define LOAD_MSR_KERNEL(r, x)	li r,(x)
 #endif
 
+/*
+ * Align to 4k in order to ensure that all functions modyfing srr0/srr1
+ * fit into one page in order to not encounter a TLB miss between the
+ * modification of srr0/srr1 and the associated rfi.
+ */
+	.align	12
+
 #ifdef CONFIG_BOOKE
 	.globl	mcheck_transfer_to_handler
 mcheck_transfer_to_handler:
-- 
2.12.0
