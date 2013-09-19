Return-Path: <R65777@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8ACE72C0100
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 16:10:20 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <benh@kernel.crashing.org>, <agraf@suse.de>, <paulus@samba.org>,
 <kvm@vger.kernel.org>, <kvm-ppc@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 0/6 v5] kvm: powerpc: use cache attributes from linux pte
Date: Thu, 19 Sep 2013 11:32:40 +0530
Message-ID: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bharat Bhushan <bharat.bhushan@freescale.com>

First patch is a typo fix where book3e define _PAGE_LENDIAN while it
should be defined as _PAGE_ENDIAN. This seems to show that this is never exercised :-)

Second and third patch is to allow guest controlling "G"-Guarded and "E"-Endian TLB attributes respectively.

Fourth patch is moving functions/logic in common code so they can be used on booke also.

Fifth and Sixth patch is actually setting caching attributes (TLB.WIMGE) using corresponding Linux pte.

v3->v5
 - Fix tlb-reference-flag clearing issue (patch 4/6)
 - There was a patch (4/6 powerpc: move linux pte/hugepte search to more generic file)
   in the last series of this patchset which was moving pte/hugepte search functions to
   generic file. That patch is no more needed as some other patch is already applied to fix that :)

v2->v3
 - now lookup_linux_pte() only have pte search logic and it does not
   set any access flags in pte. There is already a function for setting
   access flag which will be called explicitly where needed.
   On booke we only need to search for pte to get WIMG.

v1->v2
 - Earlier caching attributes (WIMGE) were set based of page is RAM or not
   But now we get these attributes from corresponding Linux PTE.

Bharat Bhushan (6):
  powerpc: book3e: _PAGE_LENDIAN must be _PAGE_ENDIAN
  kvm: powerpc: allow guest control "E" attribute in mas2
  kvm: powerpc: allow guest control "G" attribute in mas2
  kvm: powerpc: keep only pte search logic in lookup_linux_pte
  kvm: booke: clear host tlb reference flag on guest tlb invalidation
  kvm: powerpc: use caching attributes as per linux pte

 arch/powerpc/include/asm/kvm_host.h   |    2 +-
 arch/powerpc/include/asm/pgtable.h    |   24 ++++++++++++++++
 arch/powerpc/include/asm/pte-book3e.h |    2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c   |   36 ++++++++----------------
 arch/powerpc/kvm/booke.c              |    2 +-
 arch/powerpc/kvm/e500.h               |   10 ++++--
 arch/powerpc/kvm/e500_mmu_host.c      |   50 +++++++++++++++++++--------------
 7 files changed, 74 insertions(+), 52 deletions(-)
