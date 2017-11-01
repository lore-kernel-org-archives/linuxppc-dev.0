Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yS26z5M4qzDqvq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 08:54:19 +1100 (AEDT)
Date: Thu, 2 Nov 2017 08:54:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>
Subject: linux-next: manual merge of the powerpc tree with the powerpc-fixes
 tree
Message-ID: <20171102085418.3272faac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/powerpc/mm/tlb-radix.c

between commit:

  26e53d5ebe2e ("powerpc/64s/radix: Fix preempt imbalance in TLB flush")

from the powerpc-fixes tree and commit:

  6773027205ea ("powerpc/mm/radix: Drop unneeded NULL check")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/mm/tlb-radix.c
index d304028641a2,3a07d7a5e2fe..000000000000
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@@ -359,8 -359,7 +359,8 @@@ void radix__flush_tlb_collapsed_pmd(str
  	unsigned long pid, end;
  
  
- 	pid = mm ? mm->context.id : 0;
+ 	pid = mm->context.id;
 +	preempt_disable();
  	if (unlikely(pid == MMU_NO_CONTEXT))
  		goto no_context;
  
