Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMnd357g0zDqJr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:16:23 +1100 (AEDT)
Date: Tue, 14 Feb 2017 14:16:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>,
 KVM <kvm@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, David Gibson
 <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@ozlabs.org>
Subject: linux-next: manual merge of the kvm tree with the powerpc tree
Message-ID: <20170214141622.1aac0ef3@canb.auug.org.au>
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

  arch/powerpc/include/asm/prom.h

between commit:

  0de0fb09bbce ("powerpc/pseries: Advertise HPT resizing support via CAS")

from the powerpc tree and commit:

  3f4ab2f83b4e ("powerpc/pseries: Fixes for the "ibm,architecture-vec-5" options")

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

diff --cc arch/powerpc/include/asm/prom.h
index 00fcfcbdd053,8af2546ea593..000000000000
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@@ -151,11 -153,17 +153,18 @@@ struct of_drconf_cell 
  #define OV5_XCMO		0x0440	/* Page Coalescing */
  #define OV5_TYPE1_AFFINITY	0x0580	/* Type 1 NUMA affinity */
  #define OV5_PRRN		0x0540	/* Platform Resource Reassignment */
 +#define OV5_RESIZE_HPT		0x0601	/* Hash Page Table resizing */
- #define OV5_PFO_HW_RNG		0x0E80	/* PFO Random Number Generator */
- #define OV5_PFO_HW_842		0x0E40	/* PFO Compression Accelerator */
- #define OV5_PFO_HW_ENCR		0x0E20	/* PFO Encryption Accelerator */
- #define OV5_SUB_PROCESSORS	0x0F01	/* 1,2,or 4 Sub-Processors supported */
+ #define OV5_PFO_HW_RNG		0x1180	/* PFO Random Number Generator */
+ #define OV5_PFO_HW_842		0x1140	/* PFO Compression Accelerator */
+ #define OV5_PFO_HW_ENCR		0x1120	/* PFO Encryption Accelerator */
+ #define OV5_SUB_PROCESSORS	0x1501	/* 1,2,or 4 Sub-Processors supported */
+ #define OV5_XIVE_EXPLOIT	0x1701	/* XIVE exploitation supported */
+ #define OV5_MMU_RADIX_300	0x1880	/* ISA v3.00 radix MMU supported */
+ #define OV5_MMU_HASH_300	0x1840	/* ISA v3.00 hash MMU supported */
+ #define OV5_MMU_SEGM_RADIX	0x1820	/* radix mode (no segmentation) */
+ #define OV5_MMU_PROC_TBL	0x1810	/* hcall selects SLB or proc table */
+ #define OV5_MMU_SLB		0x1800	/* always use SLB */
+ #define OV5_MMU_GTSE		0x1808	/* Guest translation shootdown */
  
  /* Option Vector 6: IBM PAPR hints */
  #define OV6_LINUX		0x02	/* Linux is our OS */
