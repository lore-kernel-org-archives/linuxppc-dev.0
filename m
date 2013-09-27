Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 223012C036F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 20:04:19 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 15:34:17 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CFC80394004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:33:58 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RA6Mvu28704950
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:36:22 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RA42Ks020058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:34:02 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 03/11] kvm: powerpc: book3s: move book3s_64_vio_hv.c into
 the main kernel binary
Date: Fri, 27 Sep 2013 15:33:45 +0530
Message-Id: <1380276233-17095-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
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
 arch/powerpc/kvm/book3s_64_vio_hv.c |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

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
index 30c2f3b..70d6594 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -74,3 +74,5 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	/* Didn't find the liobn, punt it to userspace */
 	return H_TOO_HARD;
 }
+EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
+
-- 
1.8.1.2
