Return-Path: <spopovyc@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yn5nf0h7XzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 03:38:30 +1100 (AEDT)
From: Serhii Popovych <spopovyc@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: michael@ellerman.id.au, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, david@gibson.dropbear.id.au
Subject: [PATCH 0/4] Fix use after free in HPT resizing code and related minor
 improvements
Date: Wed, 29 Nov 2017 11:38:22 -0500
Message-Id: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is possible to trigger use after free during HPT resize
causing host kernel to crash. More details and analysis of
the problem can be found in change with corresponding subject
(KVM: PPC: Book3S HV: Fix use after free in case of multiple
resize requests).

We need some changes to prepare for the fix, especially
make ->error in HPT resize instance single point for
tracking allocation state, improve kvmppc_allocate_hpt()
and kvmppc_free_hpt() so they can be used more safely.

See individual commit description message to get more
information on changes presented.

Serhii Popovych (4):
  KVM: PPC: Book3S HV: Drop prepare_done from struct kvm_resize_hpt and
    cleanups
  KVM: PPC: Book3S HV: Improve kvmppc_allocate_hpt()/kvmppc_free_hpt()
  KVM: PPC: Book3S HV: Fix use after free in case of multiple resize
    requests
  KVM: PPC: Book3S HV: Remove redundant parameter from
    resize_hpt_release()

 arch/powerpc/kvm/book3s_64_mmu_hv.c | 139 +++++++++++++++++++++---------------
 1 file changed, 82 insertions(+), 57 deletions(-)

-- 
1.8.3.1
