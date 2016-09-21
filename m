Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sf0kM3JSJzDsfl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 10:24:43 +1000 (AEST)
Date: Wed, 21 Sep 2016 10:24:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>, Michal
 Marek <mmarek@suse.cz>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro
 <viro@zeniv.linux.org.uk>, Nicholas Piggin <npiggin@gmail.com>
Subject: linux-next: manual merge of the powerpc tree with the kbuild tree
Message-ID: <20160921102442.1061af69@canb.auug.org.au>
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

Today's linux-next merge of the powerpc tree got conflicts in:

  arch/powerpc/kernel/misc_32.S
  arch/powerpc/kernel/misc_64.S

between commit:

  9445aa1a3062 ("ppc: move exports to definitions")

from the kbuild tree and commit:

  6f698df10cb2 ("powerpc/kernel: Use kprobe blacklist for asm functions")

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

diff --cc arch/powerpc/kernel/misc_32.S
index f5156105c5f3,03756ffdcd71..000000000000
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@@ -360,7 -358,8 +360,9 @@@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_
  	sync				/* additional sync needed on g4 */
  	isync
  	blr
+ _ASM_NOKPROBE_SYMBOL(flush_icache_range)
 +EXPORT_SYMBOL(flush_icache_range)
+ 
  /*
   * Flush a particular page from the data cache to RAM.
   * Note: this is necessary because the instruction cache does *not*
diff --cc arch/powerpc/kernel/misc_64.S
index 8b526846e72a,5d7e583f1588..000000000000
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@@ -110,8 -109,8 +110,9 @@@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_
  	bdnz	2b
  	isync
  	blr
- 	.previous .text
+ _ASM_NOKPROBE_SYMBOL(flush_icache_range)
 +EXPORT_SYMBOL(flush_icache_range)
+ 
  /*
   * Like above, but only do the D-cache.
   *
