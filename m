Return-Path: <aik@ozlabs.ru>
Received: from mail-ie0-x233.google.com (mail-ie0-x233.google.com
 [IPv6:2607:f8b0:4001:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1603D2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 16:11:26 +1000 (EST)
Received: by mail-ie0-f179.google.com with SMTP id c13so2690286ieb.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jun 2013 23:11:24 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/4 v3] KVM: PPC: IOMMU in-kernel handling
Date: Wed,  5 Jun 2013 16:11:09 +1000
Message-Id: <1370412673-1345-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben, ping! :)

This series has tiny fixes (capability and ioctl numbers,
changed documentation, compile errors in some configuration).
More details are in the commit messages.
Rebased on v3.10-rc4.


Alexey Kardashevskiy (4):
  KVM: PPC: Add support for multiple-TCE hcalls
  powerpc: Prepare to support kernel handling of IOMMU map/unmap
  KVM: PPC: Add support for IOMMU in-kernel handling
  KVM: PPC: Add hugepage support for IOMMU in-kernel handling

 Documentation/virtual/kvm/api.txt        |   45 +++
 arch/powerpc/include/asm/kvm_host.h      |    7 +
 arch/powerpc/include/asm/kvm_ppc.h       |   40 ++-
 arch/powerpc/include/asm/pgtable-ppc64.h |    4 +
 arch/powerpc/include/uapi/asm/kvm.h      |    7 +
 arch/powerpc/kvm/book3s_64_vio.c         |  398 ++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c      |  471 ++++++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv.c             |   39 +++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |    6 +
 arch/powerpc/kvm/book3s_pr_papr.c        |   37 ++-
 arch/powerpc/kvm/powerpc.c               |   15 +
 arch/powerpc/mm/init_64.c                |   77 ++++-
 include/uapi/linux/kvm.h                 |    3 +
 13 files changed, 1121 insertions(+), 28 deletions(-)

-- 
1.7.10.4
