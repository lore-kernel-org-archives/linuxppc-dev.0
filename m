Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sw8HL3gqrzDt2D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:53:50 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 128so6055092pfz.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 17:53:50 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: pbonzini@redhat.com, rkrcmar@redhat.com, agraf@suse.com, corbet@lwn.net
Cc: paulus@samba.org, mpe@ellerman.id.au, sam.bobroff@au1.ibm.com,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 linux-doc@vger.kernel.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 2/6] powerpc/kvm: Use generic kvm module parameters in kvm-hv
Date: Fri, 14 Oct 2016 11:53:20 +1100
Message-Id: <1476406404-32752-3-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
References: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The previous patch exported the variables which back the module parameters
of the generic kvm module. Now use these variables in the kvm-hv module
so that any change to the generic module parameters will also have the
same effect for the kvm-hv module. This removes the duplication of the
kvm module parameters which was redundant and should reduce confusion when
tuning them.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3686471..daad638 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -104,23 +104,6 @@ module_param_cb(h_ipi_redirect, &module_param_ops, &h_ipi_redirect,
 MODULE_PARM_DESC(h_ipi_redirect, "Redirect H_IPI wakeup to a free host core");
 #endif
 
-/* Maximum halt poll interval defaults to KVM_HALT_POLL_NS_DEFAULT */
-static unsigned int halt_poll_max_ns = KVM_HALT_POLL_NS_DEFAULT;
-module_param(halt_poll_max_ns, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(halt_poll_max_ns, "Maximum halt poll time in ns");
-
-/* Factor by which the vcore halt poll interval is grown, default is to double
- */
-static unsigned int halt_poll_ns_grow = 2;
-module_param(halt_poll_ns_grow, int, S_IRUGO);
-MODULE_PARM_DESC(halt_poll_ns_grow, "Factor halt poll time is grown by");
-
-/* Factor by which the vcore halt poll interval is shrunk, default is to reset
- */
-static unsigned int halt_poll_ns_shrink;
-module_param(halt_poll_ns_shrink, int, S_IRUGO);
-MODULE_PARM_DESC(halt_poll_ns_shrink, "Factor halt poll time is shrunk by");
-
 static void kvmppc_end_cede(struct kvm_vcpu *vcpu);
 static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu);
 
@@ -2544,8 +2527,8 @@ static void grow_halt_poll_ns(struct kvmppc_vcore *vc)
 	else
 		vc->halt_poll_ns *= halt_poll_ns_grow;
 
-	if (vc->halt_poll_ns > halt_poll_max_ns)
-		vc->halt_poll_ns = halt_poll_max_ns;
+	if (vc->halt_poll_ns > halt_poll_ns)
+		vc->halt_poll_ns = halt_poll_ns;
 }
 
 static void shrink_halt_poll_ns(struct kvmppc_vcore *vc)
@@ -2655,15 +2638,15 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	}
 
 	/* Adjust poll time */
-	if (halt_poll_max_ns) {
+	if (halt_poll_ns) {
 		if (block_ns <= vc->halt_poll_ns)
 			;
 		/* We slept and blocked for longer than the max halt time */
-		else if (vc->halt_poll_ns && block_ns > halt_poll_max_ns)
+		else if (vc->halt_poll_ns && block_ns > halt_poll_ns)
 			shrink_halt_poll_ns(vc);
 		/* We slept and our poll time is too small */
-		else if (vc->halt_poll_ns < halt_poll_max_ns &&
-				block_ns < halt_poll_max_ns)
+		else if (vc->halt_poll_ns < halt_poll_ns &&
+				block_ns < halt_poll_ns)
 			grow_halt_poll_ns(vc);
 	} else
 		vc->halt_poll_ns = 0;
-- 
2.5.5
