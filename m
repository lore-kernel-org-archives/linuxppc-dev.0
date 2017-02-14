Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMnXV68yjzDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:12:26 +1100 (AEDT)
Date: Tue, 14 Feb 2017 14:12:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>,
 KVM <kvm@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, David Gibson
 <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@ozlabs.org>
Subject: linux-next: manual merge of the kvm tree with the powerpc tree
Message-ID: <20170214141226.6920079a@canb.auug.org.au>
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

  arch/powerpc/include/asm/hvcall.h

between commit:

  64b40ffbc830 ("powerpc/pseries: Add hypercall wrappers for hash page table resizing")

from the powerpc tree and commit:

  cc3d2940133d ("powerpc/64: Enable use of radix MMU under hypervisor on POWER9")

from the kvm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/include/asm/hvcall.h
index 490c4b9f4e3a,54d11b3a6bf7..000000000000
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@@ -276,8 -276,7 +276,9 @@@
  #define H_GET_MPP_X		0x314
  #define H_SET_MODE		0x31C
  #define H_CLEAR_HPT		0x358
 +#define H_RESIZE_HPT_PREPARE	0x36C
 +#define H_RESIZE_HPT_COMMIT	0x370
+ #define H_REGISTER_PROC_TBL	0x37C
  #define H_SIGNAL_SYS_RESET	0x380
  #define MAX_HCALL_OPCODE	H_SIGNAL_SYS_RESET
  
