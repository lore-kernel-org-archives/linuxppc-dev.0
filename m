Return-Path: <R65777@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2FD4E2C0281
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 21:37:02 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <scottwood@freescale.com>, <benh@kernel.crashing.org>, <agraf@suse.de>,
 <paulus@samba.org>, <kvm@vger.kernel.org>, <kvm-ppc@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/6 v3] kvm: powerpc: use cache attributes from linux pte 
Date: Tue, 6 Aug 2013 17:01:08 +0530
Message-ID: <1375788674-13140-1-git-send-email-Bharat.Bhushan@freescale.com>
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

First patch is a typo fix where book3e define _PAGE_LENDIAN while it should be
defined as _PAGE_ENDIAN. This seems to show that this is never exercised :-)

Second and third patch is to allow guest controlling "G"-Guarded and
"E"-Endian TLB attributes respectively.

Fourth and fifth patch is moving functions/logic in common code
so they can be used on booke also.

Sixth patch is actually setting caching attributes (TLB.WIMGE) using
corresponding Linux pte.

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
  powerpc: move linux pte/hugepte search to more generic file
  kvm: powerpc: keep only pte search logic in lookup_linux_pte
  kvm: powerpc: use caching attributes as per linux pte

 arch/powerpc/include/asm/kvm_host.h      |    2 +-
 arch/powerpc/include/asm/pgtable-ppc64.h |   36 ------------------
 arch/powerpc/include/asm/pgtable.h       |   60 ++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/pte-book3e.h    |    2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |   38 ++++++-------------
 arch/powerpc/kvm/booke.c                 |    2 +-
 arch/powerpc/kvm/e500.h                  |   10 +++--
 arch/powerpc/kvm/e500_mmu_host.c         |   36 ++++++++++-------
 8 files changed, 102 insertions(+), 84 deletions(-)
