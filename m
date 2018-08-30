Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42172p6ZV7zF36y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 13:17:22 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH kernel 0/4] KVM: PPC: Some error handling rework
Date: Thu, 30 Aug 2018 13:16:43 +1000
Message-Id: <20180830031647.34134-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are some inconsistencies in how I handle errors which prevents
us from validating these properly:
KVM: PPC: Check if IOMMU page is contained in the pinned physical page
KVM: PPC: Book3S: Fix guest DMA when guest partially backed by THP pages


This is based on sha1
ff69279 Ard Biesheuvel "powerpc: disable support for relative ksymtab references".

Please comment. Thanks.



Alexey Kardashevskiy (4):
  KVM: PPC: Validate all tces before updating tables
  KVM: PPC: Inform the userspace about TCE update failures
  KVM: PPC: Validate TCEs against preregistered memory page sizes
  KVM: PPC: Propagate errors to the guest when failed instead of
    ignoring

 arch/powerpc/include/asm/kvm_ppc.h  |  2 -
 arch/powerpc/kvm/book3s_64_vio.c    | 78 ++++++++++++++++++++++++++++---------
 arch/powerpc/kvm/book3s_64_vio_hv.c | 60 ++++++++++++++++------------
 3 files changed, 96 insertions(+), 44 deletions(-)

-- 
2.11.0
