Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfNx81gbQzDqtG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 10:35:08 +1000 (AEST)
Date: Wed, 29 Jun 2016 10:35:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "Naveen N.
 Rao" <naveen.n.rao@linux.vnet.ibm.com>, Thadeu Lima de Souza Cascardo
 <cascardo@redhat.com>
Subject: linux-next: manual merge of the powerpc tree with Linus' tree
Message-ID: <20160629103507.52c60714@canb.auug.org.au>
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

  arch/powerpc/Kconfig

between commit:

  844e3be47693 ("powerpc/bpf/jit: Disable classic BPF JIT on ppc64le")

from Linus' tree and commit:

  156d0e290e96 ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")

from the powerpc tree.

I fixed it up (see below - I am not sure this entirely correct) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/Kconfig
index 0a9d439bcda6,ee82f9a09a85..000000000000
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@@ -128,7 -128,8 +128,8 @@@ config PP
  	select IRQ_FORCED_THREADING
  	select HAVE_RCU_TABLE_FREE if SMP
  	select HAVE_SYSCALL_TRACEPOINTS
- 	select HAVE_CBPF_JIT if CPU_BIG_ENDIAN
 -	select HAVE_CBPF_JIT if !PPC64
++	select HAVE_CBPF_JIT if !PPC64 && CPU_BIG_ENDIAN
+ 	select HAVE_EBPF_JIT if PPC64
  	select HAVE_ARCH_JUMP_LABEL
  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
  	select ARCH_HAS_GCOV_PROFILE_ALL
