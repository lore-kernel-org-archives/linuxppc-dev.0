Return-Path: <spopovyc@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yr6rv1CJ4zDsJW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 01:36:46 +1100 (AEDT)
From: Serhii Popovych <spopovyc@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, michael@ellerman.id.au,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 david@gibson.dropbear.id.au
Subject: [PATCH v2 0/2] Fix use after free in HPT resizing code and related
 minor improvements
Date: Mon,  4 Dec 2017 09:36:40 -0500
Message-Id: <1512398202-8195-1-git-send-email-spopovyc@redhat.com>
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
tracking allocation state.

See individual commit description message to get more
information on changes presented.

v2:
 Serhii Popovych: Tested with current 4.15-rc2 as host kernel on P8
                  with same testcase as for v1: no problems so far.

Serhii Popovych (2):
  KVM: PPC: Book3S HV: Drop prepare_done from struct kvm_resize_hpt and
    cleanups
  KVM: PPC: Book3S HV: Fix use after free in case of multiple resize
    requests

 arch/powerpc/kvm/book3s_64_mmu_hv.c | 84 +++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 27 deletions(-)

-- 
1.8.3.1
