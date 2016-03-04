Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 646171A045D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 15:30:27 +1100 (AEDT)
Date: Fri, 4 Mar 2016 15:30:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>,
 <kvm@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "Aneesh Kumar
 K.V" <aneesh.kumar@linux.vnet.ibm.com>, Alexey Kardashevskiy
 <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>
Subject: linux-next: manual merge of the kvm tree with the powerpc tree
Message-ID: <20160304153026.76c2732b@canb.auug.org.au>
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

Today's linux-next merge of the kvm tree got a conflict in:

  arch/powerpc/kvm/book3s_64_vio_hv.c

between commit:

  f64e8084c94b ("powerpc/mm: Move hash related mmu-*.h headers to book3s/")

from the powerpc tree and commit:

  d3695aa4f452 ("KVM: PPC: Add support for multiple-TCE hcalls")

from the kvm tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/kvm/book3s_64_vio_hv.c
index 039028d3ccb5,44be73e6aa26..000000000000
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@@ -29,7 -30,8 +30,8 @@@
  #include <asm/tlbflush.h>
  #include <asm/kvm_ppc.h>
  #include <asm/kvm_book3s.h>
 -#include <asm/mmu-hash64.h>
 +#include <asm/book3s/64/mmu-hash.h>
+ #include <asm/mmu_context.h>
  #include <asm/hvcall.h>
  #include <asm/synch.h>
  #include <asm/ppc-opcode.h>
