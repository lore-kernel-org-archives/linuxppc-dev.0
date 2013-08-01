Return-Path: <R65777@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6AA2B2C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 21:17:42 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <benh@kernel.crashing.org>, <agraf@suse.de>, <kvm-ppc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <scottwood@freescale.com>
Subject: [PATCH 0/6 v2] kvm: powerpc: use cache attributes from linux pte
Date: Thu, 1 Aug 2013 16:42:32 +0530
Message-ID: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
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
"E"-Endiany TLB attributes respectively.

Rest of patches is about setting caching attributes (TLB.WIMGE) using
corresponding Linux pte.

v1->v2
 - Earlier caching attributes (WIMGE) were set based of page is RAM or not
   But now we get these attributes from corresponding Linux PTE.

Bharat Bhushan (6):
  powerpc: book3e: _PAGE_LENDIAN must be _PAGE_ENDIAN
  kvm: powerpc: allow guest control "E" attribute in mas2
  kvm: powerpc: allow guest control "G" attribute in mas2
  powerpc: move linux pte/hugepte search to more generic file
  kvm: powerpc: booke: Add linux pte lookup like booke3s
  kvm: powerpc: use caching attributes as per linux pte

 arch/powerpc/include/asm/kvm_booke.h     |   73 ++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm_host.h      |    2 +-
 arch/powerpc/include/asm/pgtable-ppc64.h |   36 ---------------
 arch/powerpc/include/asm/pgtable.h       |   37 +++++++++++++++
 arch/powerpc/include/asm/pte-book3e.h    |    2 +-
 arch/powerpc/kvm/booke.c                 |    2 +-
 arch/powerpc/kvm/e500.h                  |   10 +++--
 arch/powerpc/kvm/e500_mmu_host.c         |   31 +++++++-----
 8 files changed, 137 insertions(+), 56 deletions(-)
