Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 08C422C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:42 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 Oct 2013 02:48:31 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 914A93578054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:29 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r97GmGSj65470640
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:18 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r97GmR8H024718
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:27 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 02/14] kvm: powerpc: book3s: move book3s_64_vio_hv.c into
 the main kernel binary
Date: Mon,  7 Oct 2013 22:17:50 +0530
Message-Id: <1381164482-31001-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>

Since the code in book3s_64_vio_hv.c is called from real mode with HV
KVM, and therefore has to be built into the main kernel binary, this
makes it always built-in rather than part of the KVM module.  It gets
called from the KVM module by PR KVM, so this adds an EXPORT_SYMBOL_GPL().

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/Makefile           | 12 ++++++++----
 arch/powerpc/kvm/book3s_64_vio_hv.c |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 6646c95..104e8dc 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -53,32 +53,36 @@ kvm-e500mc-objs := \
 	e500_emulate.o
 kvm-objs-$(CONFIG_KVM_E500MC) := $(kvm-e500mc-objs)
 
+kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) := \
+	book3s_64_vio_hv.o
+
 kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_PR) := \
 	$(KVM)/coalesced_mmio.o \
 	fpu.o \
 	book3s_paired_singles.o \
 	book3s_pr.o \
 	book3s_pr_papr.o \
-	book3s_64_vio_hv.o \
 	book3s_emulate.o \
 	book3s_interrupts.o \
 	book3s_mmu_hpte.o \
 	book3s_64_mmu_host.o \
 	book3s_64_mmu.o \
 	book3s_32_mmu.o
-kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_PR) := \
+
+kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_PR) += \
 	book3s_rmhandlers.o
 
 kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_HV) := \
 	book3s_hv.o \
 	book3s_hv_interrupts.o \
 	book3s_64_mmu_hv.o
+
 kvm-book3s_64-builtin-xics-objs-$(CONFIG_KVM_XICS) := \
 	book3s_hv_rm_xics.o
-kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HV) := \
+
+kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HV) += \
 	book3s_hv_rmhandlers.o \
 	book3s_hv_rm_mmu.o \
-	book3s_64_vio_hv.o \
 	book3s_hv_ras.o \
 	book3s_hv_builtin.o \
 	book3s_hv_cma.o \
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 30c2f3b..2c25f54 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -74,3 +74,4 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	/* Didn't find the liobn, punt it to userspace */
 	return H_TOO_HARD;
 }
+EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
-- 
1.8.1.2
