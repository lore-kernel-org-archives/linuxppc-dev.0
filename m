Return-Path: <aik@ozlabs.ru>
Received: from mail-ia0-x22c.google.com (ia-in-x022c.1e100.net
 [IPv6:2607:f8b0:4001:c02::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D5BF2C02C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 23:20:30 +1100 (EST)
Received: by mail-ia0-f172.google.com with SMTP id u8so6391506iag.31
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 04:20:27 -0800 (PST)
From: aik@ozlabs.ru
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/4] powerpc iommu: extending real mode support
Date: Mon, 11 Feb 2013 23:12:39 +1100
Message-Id: <5118e050.22ca320a.1f08.ffffe2e1@mx.google.com>
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

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The first 2 patches in this set add a multi-tce support feature
(adding/deleting several TCE records at once) in real and virtual mode.

The last 2 patches enable real mode acceleration for VFIO and
extend the multi-tce feature to be available for VFIO devices.

The QEMU change is required in order to support this functionality
(additional ioctl to add a new LIOBN and hook it with a specific IOMMU)).


Alexey Kardashevskiy (4):
  powerpc: lookup_linux_pte has been made public
  powerpc kvm: added multiple TCEs requests support
  powerpc: preparing to support real mode optimization
  vfio powerpc: added real mode support

 arch/powerpc/include/asm/iommu.h         |   10 +
 arch/powerpc/include/asm/kvm_host.h      |    2 +
 arch/powerpc/include/asm/kvm_ppc.h       |   17 ++
 arch/powerpc/include/asm/pgtable-ppc64.h |    6 +
 arch/powerpc/include/uapi/asm/kvm.h      |    8 +
 arch/powerpc/kernel/iommu.c              |  253 ++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_vio.c         |   55 ++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c      |  397 ++++++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv.c             |   23 ++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |    4 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |    6 +
 arch/powerpc/kvm/book3s_pr_papr.c        |   37 ++-
 arch/powerpc/kvm/powerpc.c               |   14 ++
 arch/powerpc/mm/init_64.c                |   56 ++++-
 include/uapi/linux/kvm.h                 |    2 +
 15 files changed, 852 insertions(+), 38 deletions(-)

-- 
1.7.10.4
