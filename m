Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC118C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:16:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 609F620674
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609F620674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fW5f3NnPzDqN5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:16:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.72.238; helo=9.mo177.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 9.mo177.mail-out.ovh.net (9.mo177.mail-out.ovh.net
 [46.105.72.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fVtR0qXNzDqQ4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 03:06:21 +1000 (AEST)
Received: from player157.ha.ovh.net (unknown [10.109.159.152])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id EBF2AEE271
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 19:06:17 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
 [86.201.133.22]) (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id E61B8492A463;
 Wed, 10 Apr 2019 17:06:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v5 10/16] KVM: PPC: Book3S HV: XIVE: add get/set accessors for
 the VP XIVE state
Date: Wed, 10 Apr 2019 19:04:42 +0200
Message-Id: <20190410170448.3923-11-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410170448.3923-1-clg@kaod.org>
References: <20190410170448.3923-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2488520271941503959
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudejgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The state of the thread interrupt management registers needs to be
collected for migration. These registers are cached under the
'xive_saved_state.w01' field of the VCPU when the VPCU context is
pulled from the HW thread. An OPAL call retrieves the backup of the
IPB register in the underlying XIVE NVT structure and merges it in the
KVM state.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---

 Changes since v4:

 - add documentation in Documentation/virtual/kvm/api.txt

 arch/powerpc/include/asm/kvm_ppc.h         | 11 ++++
 arch/powerpc/include/uapi/asm/kvm.h        |  2 +
 arch/powerpc/kvm/book3s.c                  | 24 +++++++
 arch/powerpc/kvm/book3s_xive_native.c      | 76 ++++++++++++++++++++++
 Documentation/virtual/kvm/api.txt          |  1 +
 Documentation/virtual/kvm/devices/xive.txt | 17 +++++
 6 files changed, 131 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 6928a35ac3c7..0579c9b253db 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -273,6 +273,7 @@ union kvmppc_one_reg {
 		u64	addr;
 		u64	length;
 	}	vpaval;
+	u64	xive_timaval[2];
 };
 
 struct kvmppc_ops {
@@ -605,6 +606,10 @@ extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
 extern void kvmppc_xive_native_init_module(void);
 extern void kvmppc_xive_native_exit_module(void);
+extern int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu,
+				     union kvmppc_one_reg *val);
+extern int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu,
+				     union kvmppc_one_reg *val);
 
 #else
 static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 server,
@@ -637,6 +642,12 @@ static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
 static inline void kvmppc_xive_native_init_module(void) { }
 static inline void kvmppc_xive_native_exit_module(void) { }
+static inline int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu,
+					    union kvmppc_one_reg *val)
+{ return 0; }
+static inline int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu,
+					    union kvmppc_one_reg *val)
+{ return -ENOENT; }
 
 #endif /* CONFIG_KVM_XIVE */
 
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 12744608a61c..cd3f16b70a2e 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -482,6 +482,8 @@ struct kvm_ppc_cpu_char {
 #define  KVM_REG_PPC_ICP_PPRI_SHIFT	16	/* pending irq priority */
 #define  KVM_REG_PPC_ICP_PPRI_MASK	0xff
 
+#define KVM_REG_PPC_VP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U128 | 0x8d)
+
 /* Device control API: PPC-specific devices */
 #define KVM_DEV_MPIC_GRP_MISC		1
 #define   KVM_DEV_MPIC_BASE_ADDR	0	/* 64-bit */
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 7c3348fa27e1..efd15101eef0 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -651,6 +651,18 @@ int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
 				*val = get_reg_val(id, kvmppc_xics_get_icp(vcpu));
 			break;
 #endif /* CONFIG_KVM_XICS */
+#ifdef CONFIG_KVM_XIVE
+		case KVM_REG_PPC_VP_STATE:
+			if (!vcpu->arch.xive_vcpu) {
+				r = -ENXIO;
+				break;
+			}
+			if (xive_enabled())
+				r = kvmppc_xive_native_get_vp(vcpu, val);
+			else
+				r = -ENXIO;
+			break;
+#endif /* CONFIG_KVM_XIVE */
 		case KVM_REG_PPC_FSCR:
 			*val = get_reg_val(id, vcpu->arch.fscr);
 			break;
@@ -724,6 +736,18 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
 				r = kvmppc_xics_set_icp(vcpu, set_reg_val(id, *val));
 			break;
 #endif /* CONFIG_KVM_XICS */
+#ifdef CONFIG_KVM_XIVE
+		case KVM_REG_PPC_VP_STATE:
+			if (!vcpu->arch.xive_vcpu) {
+				r = -ENXIO;
+				break;
+			}
+			if (xive_enabled())
+				r = kvmppc_xive_native_set_vp(vcpu, val);
+			else
+				r = -ENXIO;
+			break;
+#endif /* CONFIG_KVM_XIVE */
 		case KVM_REG_PPC_FSCR:
 			vcpu->arch.fscr = set_reg_val(id, *val);
 			break;
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 16d23ef3bd39..2f9d5e9439a6 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -896,6 +896,82 @@ static int kvmppc_xive_native_create(struct kvm_device *dev, u32 type)
 	return ret;
 }
 
+/*
+ * Interrupt Pending Buffer (IPB) offset
+ */
+#define TM_IPB_SHIFT 40
+#define TM_IPB_MASK  (((u64) 0xFF) << TM_IPB_SHIFT)
+
+int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	u64 opal_state;
+	int rc;
+
+	if (!kvmppc_xive_enabled(vcpu))
+		return -EPERM;
+
+	if (!xc)
+		return -ENOENT;
+
+	/* Thread context registers. We only care about IPB and CPPR */
+	val->xive_timaval[0] = vcpu->arch.xive_saved_state.w01;
+
+	/* Get the VP state from OPAL */
+	rc = xive_native_get_vp_state(xc->vp_id, &opal_state);
+	if (rc)
+		return rc;
+
+	/*
+	 * Capture the backup of IPB register in the NVT structure and
+	 * merge it in our KVM VP state.
+	 */
+	val->xive_timaval[0] |= cpu_to_be64(opal_state & TM_IPB_MASK);
+
+	pr_devel("%s NSR=%02x CPPR=%02x IBP=%02x PIPR=%02x w01=%016llx w2=%08x opal=%016llx\n",
+		 __func__,
+		 vcpu->arch.xive_saved_state.nsr,
+		 vcpu->arch.xive_saved_state.cppr,
+		 vcpu->arch.xive_saved_state.ipb,
+		 vcpu->arch.xive_saved_state.pipr,
+		 vcpu->arch.xive_saved_state.w01,
+		 (u32) vcpu->arch.xive_cam_word, opal_state);
+
+	return 0;
+}
+
+int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
+
+	pr_devel("%s w01=%016llx vp=%016llx\n", __func__,
+		 val->xive_timaval[0], val->xive_timaval[1]);
+
+	if (!kvmppc_xive_enabled(vcpu))
+		return -EPERM;
+
+	if (!xc || !xive)
+		return -ENOENT;
+
+	/* We can't update the state of a "pushed" VCPU	 */
+	if (WARN_ON(vcpu->arch.xive_pushed))
+		return -EBUSY;
+
+	/*
+	 * Restore the thread context registers. IPB and CPPR should
+	 * be the only ones that matter.
+	 */
+	vcpu->arch.xive_saved_state.w01 = val->xive_timaval[0];
+
+	/*
+	 * There is no need to restore the XIVE internal state (IPB
+	 * stored in the NVT) as the IPB register was merged in KVM VP
+	 * state when captured.
+	 */
+	return 0;
+}
+
 static int xive_native_debug_show(struct seq_file *m, void *private)
 {
 	struct kvmppc_xive *xive = m->private;
diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index e38eb17b7be6..5b505520a616 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1985,6 +1985,7 @@ registers, find a list below:
   PPC   | KVM_REG_PPC_TLB3PS            | 32
   PPC   | KVM_REG_PPC_EPTCFG            | 32
   PPC   | KVM_REG_PPC_ICP_STATE         | 64
+  PPC   | KVM_REG_PPC_VP_STATE          | 128
   PPC   | KVM_REG_PPC_TB_OFFSET         | 64
   PPC   | KVM_REG_PPC_SPMC1             | 32
   PPC   | KVM_REG_PPC_SPMC2             | 32
diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
index 7ffd4c7be7b5..525d1eebcf34 100644
--- a/Documentation/virtual/kvm/devices/xive.txt
+++ b/Documentation/virtual/kvm/devices/xive.txt
@@ -107,6 +107,23 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
     -ENOENT: Unknown source number
     -EINVAL: Not initialized source number
 
+* VCPU state
+
+  The XIVE IC maintains VP interrupt state in an internal structure
+  called the NVT. When a VP is not dispatched on a HW processor
+  thread, this structure can be updated by HW if the VP is the target
+  of an event notification.
+
+  It is important for migration to capture the cached IPB from the NVT
+  as it synthesizes the priorities of the pending interrupts. We
+  capture a bit more to report debug information.
+
+  KVM_REG_PPC_VP_STATE (2 * 64bits)
+  bits:     |  63  ....  32  |  31  ....  0  |
+  values:   |   TIMA word0   |   TIMA word1  |
+  bits:     | 127       ..........       64  |
+  values:   |            unused              |
+
 * Migration:
 
   Saving the state of a VM using the XIVE native exploitation mode
-- 
2.20.1

