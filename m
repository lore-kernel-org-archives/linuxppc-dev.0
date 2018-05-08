Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gN2628gMzF15H
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 00:59:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxram@us.ibm.com
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: [PATCH 3/8] mm/pkeys: Remove include of asm/mmu_context.h from pkeys.h
Date: Wed,  9 May 2018 00:59:43 +1000
Message-Id: <20180508145948.9492-4-mpe@ellerman.id.au>
In-Reply-To: <20180508145948.9492-1-mpe@ellerman.id.au>
References: <20180508145948.9492-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While trying to unify the pkey handling in show_smap() between x86 and
powerpc we stumbled across various build failures due to the order of
includes between the two arches.

Part of the problem is that linux/pkeys.h includes asm/mmu_context.h,
and the relationship between asm/mmu_context.h and asm/pkeys.h is not
consistent between the two arches.

It would be cleaner if linux/pkeys.h only included asm/pkeys.h,
creating a single integration point for the arch pkey definitions.

So this patch removes the include of asm/mmu_context.h from
linux/pkeys.h.

We can't prove that this is safe in the general case, but it passes
all the build tests I've thrown at it. Also asm/mmu_context.h is
included widely while linux/pkeys.h is not, so most likely any code
that is including linux/pkeys.h is already getting asm/mmu_context.h
from elsewhere.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 include/linux/pkeys.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 0794ca78c379..ed06e1a67bfa 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -3,7 +3,6 @@
 #define _LINUX_PKEYS_H
 
 #include <linux/mm_types.h>
-#include <asm/mmu_context.h>
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
 #include <asm/pkeys.h>
-- 
2.14.1
