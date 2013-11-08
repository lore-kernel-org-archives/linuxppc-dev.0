Return-Path: <kernelfans@gmail.com>
Received: from mail-qc0-x22e.google.com (mail-qc0-x22e.google.com
 [IPv6:2607:f8b0:400d:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6F30A2C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 18:29:28 +1100 (EST)
Received: by mail-qc0-f174.google.com with SMTP id v1so1398749qcw.19
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Nov 2013 23:29:18 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 0/2] powerpc kvm: fix deadlock scene
Date: Fri,  8 Nov 2013 15:29:52 +0800
Message-Id: <1383895794-16164-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2->v3:
  introduce kvmppc_hv_unlock_hpte() to pair with kvmppc_hv_find_lock_hpte()
  and hide the preemption detail inside this pair from the callers

Liu Ping Fan (2):
  powerpc: kvm: pair kvmppc_hv_find_lock_hpte with _unlock_hpte
  powerpc: kvm: fix rare but potential deadlock scene

 arch/powerpc/include/asm/kvm_book3s.h |  3 ++-
 arch/powerpc/kvm/book3s_64_mmu_hv.c   | 10 ++++------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c   | 29 ++++++++++++++++++++++++-----
 3 files changed, 30 insertions(+), 12 deletions(-)

-- 
1.8.1.4
