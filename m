Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 031162C0344
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 20:04:13 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 15:34:06 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4C0F3394005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:33:47 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RA6KIn46465102
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:36:20 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RA42Lv020004
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:34:02 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 01/11] kvm: powerpc: book3s hv: Fix vcore leak
Date: Fri, 27 Sep 2013 15:33:43 +0530
Message-Id: <1380276233-17095-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

add kvmppc_free_vcores() to free the kvmppc_vcore structures
that we allocate for a guest, which are currently being leaked.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 62a2b5a..edc7f9f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1931,10 +1931,20 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 	return 0;
 }
 
+static void kvmppc_free_vcores(struct kvm *kvm)
+{
+	long int i;
+
+	for (i = 0; i < KVM_MAX_VCORES; ++i)
+		kfree(kvm->arch.vcores[i]);
+	kvm->arch.online_vcores = 0;
+}
+
 void kvmppc_core_destroy_vm(struct kvm *kvm)
 {
 	uninhibit_secondary_onlining();
 
+	kvmppc_free_vcores(kvm);
 	if (kvm->arch.rma) {
 		kvm_release_rma(kvm->arch.rma);
 		kvm->arch.rma = NULL;
-- 
1.8.1.2
