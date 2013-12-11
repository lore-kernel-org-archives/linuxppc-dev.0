Return-Path: <kernelfans@gmail.com>
Received: from mail-oa0-x231.google.com (mail-oa0-x231.google.com
 [IPv6:2607:f8b0:4003:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6319E2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 19:46:58 +1100 (EST)
Received: by mail-oa0-f49.google.com with SMTP id i4so6799958oah.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 00:46:53 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 0/4] powernv: kvm: numa fault improvement
Date: Wed, 11 Dec 2013 16:47:50 +0800
Message-Id: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series is based on Aneesh's series  "[PATCH -V2 0/5] powerpc: mm: Numa faults support for ppc64"

For this series, I apply the same idea from the previous thread "[PATCH 0/3] optimize for powerpc _PAGE_NUMA"
(for which, I still try to get a machine to show nums)

But for this series, I think that I have a good justification -- the fact of heavy cost when switching context between guest and host,
which is  well known.

If my suppose is correct, will CCing kvm@vger.kernel.org from next version.


Liu Ping Fan (4):
  mm: export numa_migrate_prep()
  powernv: kvm: make _PAGE_NUMA take effect
  powernv: kvm: extend input param for lookup_linux_pte
  powernv: kvm: make the handling of _PAGE_NUMA faster for guest

 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 38 ++++++++++++++++++++++++++++++++++---
 include/linux/mm.h                  |  2 ++
 2 files changed, 37 insertions(+), 3 deletions(-)

-- 
1.8.1.4
