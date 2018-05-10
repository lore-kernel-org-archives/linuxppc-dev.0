Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hZTd2WJnzF2BG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 23:54:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxram@us.ibm.com
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: [PATCH 9/8] powerpc/pkeys: Drop private VM_PKEY definitions
Date: Thu, 10 May 2018 23:54:22 +1000
Message-Id: <20180510135422.6585-1-mpe@ellerman.id.au>
In-Reply-To: <20180508145948.9492-9-mpe@ellerman.id.au>
References: <20180508145948.9492-9-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we've updated the generic headers to support 5 PKEY bits for
powerpc we don't need our own #defines in arch code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/pkeys.h | 15 ---------------
 1 file changed, 15 deletions(-)

One additional patch to finish cleaning things up.

I've added this to my branch.

cheers

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 18ef59a9886d..5ba80cffb505 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -15,21 +15,6 @@ DECLARE_STATIC_KEY_TRUE(pkey_disabled);
 extern int pkeys_total; /* total pkeys as per device tree */
 extern u32 initial_allocation_mask; /* bits set for reserved keys */
 
-/*
- * Define these here temporarily so we're not dependent on patching linux/mm.h.
- * Once it's updated we can drop these.
- */
-#ifndef VM_PKEY_BIT0
-# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
-# define VM_PKEY_BIT0	VM_HIGH_ARCH_0
-# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
-# define VM_PKEY_BIT2	VM_HIGH_ARCH_2
-# define VM_PKEY_BIT3	VM_HIGH_ARCH_3
-# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
-#elif !defined(VM_PKEY_BIT4)
-# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
-#endif
-
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
 			    VM_PKEY_BIT3 | VM_PKEY_BIT4)
 
-- 
2.14.1
