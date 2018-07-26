Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bgz11FkbzF0PZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 15:44:45 +1000 (AEST)
Date: Thu, 26 Jul 2018 15:43:54 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Sam Bobroff <sbobroff@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/2] KVM: PPC: Book3S HV: Allow creating max number of VCPUs
 on POWER9
Message-ID: <20180726054353.GB1672@fergus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 1e175d2 ("KVM: PPC: Book3S HV: Pack VCORE IDs to access full
VCPU ID space", 2018-07-25) allowed use of VCPU IDs up to
KVM_MAX_VCPU_ID on POWER9 in all guest SMT modes and guest emulated
hardware SMT modes.  However, with the current definition of
KVM_MAX_VCPU_ID, a guest SMT mode of 1 and an emulated SMT mode of 8,
it is only possible to create KVM_MAX_VCPUS / 2 VCPUS, because
threads_per_subcore is 4 on POWER9 CPUs.  (Using an emulated SMT mode
of 8 is useful when migrating VMs to or from POWER8 hosts.)

This increases KVM_MAX_VCPU_ID to 8 * KVM_MAX_VCPUS when HV KVM is
configured in, so that a full complement of KVM_MAX_VCPUS VCPUs can
be created on POWER9 in all guest SMT modes and emulated hardware
SMT modes.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
This and the next patch apply on my kvm-ppc-next branch, which
includes Sam Bobroff's patch "KVM: PPC: Book3S HV: Pack VCORE IDs to
access full VCPU ID space".

 arch/powerpc/include/asm/kvm_host.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 5b9e660..906bcbdf 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -42,7 +42,14 @@
 #define KVM_USER_MEM_SLOTS	512
 
 #include <asm/cputhreads.h>
-#define KVM_MAX_VCPU_ID                (threads_per_subcore * KVM_MAX_VCORES)
+
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+#include <asm/kvm_book3s_asm.h>		/* for MAX_SMT_THREADS */
+#define KVM_MAX_VCPU_ID		(MAX_SMT_THREADS * KVM_MAX_VCORES)
+
+#else
+#define KVM_MAX_VCPU_ID		KVM_MAX_VCPUS
+#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
 
-- 
2.7.4
