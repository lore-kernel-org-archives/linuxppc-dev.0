Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vF0Wn1mHwzDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 13:03:17 +1100 (AEDT)
Date: Fri, 3 Feb 2017 13:03:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Anton
 Blanchard <anton@samba.org>
Subject: linux-next: manual merge of the rcu tree with the powerpc tree
Message-ID: <20170203130316.720ea048@canb.auug.org.au>
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

Today's linux-next merge of the rcu tree got a conflict in:

  arch/powerpc/Kconfig

between commit:

  d6c569b99558 ("powerpc/64: Move HAVE_CONTEXT_TRACKING from pseries to common Kconfig")

from the powerpc tree and commit:

  c7327406b3c3 ("rcu: Make arch select smp_mb__after_unlock_lock() strength")

from the rcu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/Kconfig
index a47e2b22df67,9fecd004fee8..000000000000
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@@ -164,10 -164,11 +164,11 @@@ config PP
  	select ARCH_HAS_SCALED_CPUTIME if VIRT_CPU_ACCOUNTING_NATIVE
  	select HAVE_ARCH_HARDENED_USERCOPY
  	select HAVE_KERNEL_GZIP
 -	select HAVE_CC_STACKPROTECTOR
 +	select HAVE_CONTEXT_TRACKING if PPC64
+ 	select ARCH_WEAK_RELEASE_ACQUIRE
  
  config GENERIC_CSUM
 -	def_bool CPU_LITTLE_ENDIAN
 +	def_bool n
  
  config EARLY_PRINTK
  	bool
