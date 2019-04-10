Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2CCC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:12:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA83206DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA83206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fW204gkSzDqCW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:12:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=188.165.48.182; helo=7.mo2.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 114440 seconds by postgrey-1.36 at bilbo;
 Thu, 11 Apr 2019 03:05:45 AEST
Received: from 7.mo2.mail-out.ovh.net (7.mo2.mail-out.ovh.net [188.165.48.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fVsj1g2GzDqMm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 03:05:44 +1000 (AEST)
Received: from player157.ha.ovh.net (unknown [10.109.160.253])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id A3C6D18A5B4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 19:05:39 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
 [86.201.133.22]) (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id A369E492A38A;
 Wed, 10 Apr 2019 17:05:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v5 05/16] KVM: PPC: Book3S HV: XIVE: add a control to
 configure a source
Date: Wed, 10 Apr 2019 19:04:37 +0200
Message-Id: <20190410170448.3923-6-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410170448.3923-1-clg@kaod.org>
References: <20190410170448.3923-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2477824223266966487
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

This control will be used by the H_INT_SET_SOURCE_CONFIG hcall from
QEMU to configure the target of a source and also to restore the
configuration of a source when migrating the VM.

The XIVE source interrupt structure is extended with the value of the
Effective Interrupt Source Number. The EISN is the interrupt number
pushed in the event queue that the guest OS will use to dispatch
events internally. Caching the EISN value in KVM eases the test when
checking if a reconfiguration is indeed needed.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/uapi/asm/kvm.h        | 11 +++
 arch/powerpc/kvm/book3s_xive.h             |  4 +
 arch/powerpc/kvm/book3s_xive.c             |  5 +-
 arch/powerpc/kvm/book3s_xive_native.c      | 97 ++++++++++++++++++++++
 Documentation/virtual/kvm/devices/xive.txt | 21 +++++
 5 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index d468294c2a67..e8161e21629b 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -680,9 +680,20 @@ struct kvm_ppc_cpu_char {
 /* POWER9 XIVE Native Interrupt Controller */
 #define KVM_DEV_XIVE_GRP_CTRL		1
 #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source identifier */
+#define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source identifier */
 
 /* Layout of 64-bit XIVE source attribute values */
 #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
 #define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
 
+/* Layout of 64-bit XIVE source configuration attribute values */
+#define KVM_XIVE_SOURCE_PRIORITY_SHIFT	0
+#define KVM_XIVE_SOURCE_PRIORITY_MASK	0x7
+#define KVM_XIVE_SOURCE_SERVER_SHIFT	3
+#define KVM_XIVE_SOURCE_SERVER_MASK	0xfffffff8ULL
+#define KVM_XIVE_SOURCE_MASKED_SHIFT	32
+#define KVM_XIVE_SOURCE_MASKED_MASK	0x100000000ULL
+#define KVM_XIVE_SOURCE_EISN_SHIFT	33
+#define KVM_XIVE_SOURCE_EISN_MASK	0xfffffffe00000000ULL
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index 1be921cb5dcb..ae26fe653d98 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -61,6 +61,9 @@ struct kvmppc_xive_irq_state {
 	bool saved_p;
 	bool saved_q;
 	u8 saved_scan_prio;
+
+	/* Xive native */
+	u32 eisn;			/* Guest Effective IRQ number */
 };
 
 /* Select the "right" interrupt (IPI vs. passthrough) */
@@ -268,6 +271,7 @@ int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *vcpu);
 struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
 	struct kvmppc_xive *xive, int irq);
 void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);
+int kvmppc_xive_select_target(struct kvm *kvm, u32 *server, u8 prio);
 
 #endif /* CONFIG_KVM_XICS */
 #endif /* _KVM_PPC_BOOK3S_XICS_H */
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 6c9f9fd0855f..e09f3addffe5 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -342,7 +342,7 @@ static int xive_try_pick_queue(struct kvm_vcpu *vcpu, u8 prio)
 	return atomic_add_unless(&q->count, 1, max) ? 0 : -EBUSY;
 }
 
-static int xive_select_target(struct kvm *kvm, u32 *server, u8 prio)
+int kvmppc_xive_select_target(struct kvm *kvm, u32 *server, u8 prio)
 {
 	struct kvm_vcpu *vcpu;
 	int i, rc;
@@ -530,7 +530,7 @@ static int xive_target_interrupt(struct kvm *kvm,
 	 * priority. The count for that new target will have
 	 * already been incremented.
 	 */
-	rc = xive_select_target(kvm, &server, prio);
+	rc = kvmppc_xive_select_target(kvm, &server, prio);
 
 	/*
 	 * We failed to find a target ? Not much we can do
@@ -1504,6 +1504,7 @@ struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
 
 	for (i = 0; i < KVMPPC_XICS_IRQ_PER_ICS; i++) {
 		sb->irq_state[i].number = (bid << KVMPPC_XICS_ICS_SHIFT) | i;
+		sb->irq_state[i].eisn = 0;
 		sb->irq_state[i].guest_priority = MASKED;
 		sb->irq_state[i].saved_priority = MASKED;
 		sb->irq_state[i].act_priority = MASKED;
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 5f2bd6c137b7..492825a35958 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -242,6 +242,99 @@ static int kvmppc_xive_native_set_source(struct kvmppc_xive *xive, long irq,
 	return rc;
 }
 
+static int kvmppc_xive_native_update_source_config(struct kvmppc_xive *xive,
+					struct kvmppc_xive_src_block *sb,
+					struct kvmppc_xive_irq_state *state,
+					u32 server, u8 priority, bool masked,
+					u32 eisn)
+{
+	struct kvm *kvm = xive->kvm;
+	u32 hw_num;
+	int rc = 0;
+
+	arch_spin_lock(&sb->lock);
+
+	if (state->act_server == server && state->act_priority == priority &&
+	    state->eisn == eisn)
+		goto unlock;
+
+	pr_devel("new_act_prio=%d new_act_server=%d mask=%d act_server=%d act_prio=%d\n",
+		 priority, server, masked, state->act_server,
+		 state->act_priority);
+
+	kvmppc_xive_select_irq(state, &hw_num, NULL);
+
+	if (priority != MASKED && !masked) {
+		rc = kvmppc_xive_select_target(kvm, &server, priority);
+		if (rc)
+			goto unlock;
+
+		state->act_priority = priority;
+		state->act_server = server;
+		state->eisn = eisn;
+
+		rc = xive_native_configure_irq(hw_num,
+					       kvmppc_xive_vp(xive, server),
+					       priority, eisn);
+	} else {
+		state->act_priority = MASKED;
+		state->act_server = 0;
+		state->eisn = 0;
+
+		rc = xive_native_configure_irq(hw_num, 0, MASKED, 0);
+	}
+
+unlock:
+	arch_spin_unlock(&sb->lock);
+	return rc;
+}
+
+static int kvmppc_xive_native_set_source_config(struct kvmppc_xive *xive,
+						long irq, u64 addr)
+{
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u64 __user *ubufp = (u64 __user *) addr;
+	u16 src;
+	u64 kvm_cfg;
+	u32 server;
+	u8 priority;
+	bool masked;
+	u32 eisn;
+
+	sb = kvmppc_xive_find_source(xive, irq, &src);
+	if (!sb)
+		return -ENOENT;
+
+	state = &sb->irq_state[src];
+
+	if (!state->valid)
+		return -EINVAL;
+
+	if (get_user(kvm_cfg, ubufp))
+		return -EFAULT;
+
+	pr_devel("%s irq=0x%lx cfg=%016llx\n", __func__, irq, kvm_cfg);
+
+	priority = (kvm_cfg & KVM_XIVE_SOURCE_PRIORITY_MASK) >>
+		KVM_XIVE_SOURCE_PRIORITY_SHIFT;
+	server = (kvm_cfg & KVM_XIVE_SOURCE_SERVER_MASK) >>
+		KVM_XIVE_SOURCE_SERVER_SHIFT;
+	masked = (kvm_cfg & KVM_XIVE_SOURCE_MASKED_MASK) >>
+		KVM_XIVE_SOURCE_MASKED_SHIFT;
+	eisn = (kvm_cfg & KVM_XIVE_SOURCE_EISN_MASK) >>
+		KVM_XIVE_SOURCE_EISN_SHIFT;
+
+	if (priority != xive_prio_from_guest(priority)) {
+		pr_err("invalid priority for queue %d for VCPU %d\n",
+		       priority, server);
+		return -EINVAL;
+	}
+
+	return kvmppc_xive_native_update_source_config(xive, sb, state, server,
+						       priority, masked, eisn);
+}
+
 static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 				       struct kvm_device_attr *attr)
 {
@@ -253,6 +346,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 	case KVM_DEV_XIVE_GRP_SOURCE:
 		return kvmppc_xive_native_set_source(xive, attr->attr,
 						     attr->addr);
+	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
+		return kvmppc_xive_native_set_source_config(xive, attr->attr,
+							    attr->addr);
 	}
 	return -ENXIO;
 }
@@ -270,6 +366,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
 	case KVM_DEV_XIVE_GRP_CTRL:
 		break;
 	case KVM_DEV_XIVE_GRP_SOURCE:
+	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
 		if (attr->attr >= KVMPPC_XIVE_FIRST_IRQ &&
 		    attr->attr < KVMPPC_XIVE_NR_IRQS)
 			return 0;
diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
index cd8bfc37b72e..33c64b2cdbe8 100644
--- a/Documentation/virtual/kvm/devices/xive.txt
+++ b/Documentation/virtual/kvm/devices/xive.txt
@@ -32,3 +32,24 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
     -ENOMEM: Could not create a new source block
     -EFAULT: Invalid user pointer for attr->addr.
     -ENXIO:  Could not allocate underlying HW interrupt
+
+  3. KVM_DEV_XIVE_GRP_SOURCE_CONFIG (write only)
+  Configures source targeting
+  Attributes:
+    Interrupt source number  (64-bit)
+  The kvm_device_attr.addr points to a __u64 value:
+  bits:     | 63   ....  33 |  32  | 31 .. 3 |  2 .. 0
+  values:   |    eisn       | mask |  server | priority
+  - priority: 0-7 interrupt priority level
+  - server: CPU number chosen to handle the interrupt
+  - mask: mask flag (unused)
+  - eisn: Effective Interrupt Source Number
+  Errors:
+    -ENOENT: Unknown source number
+    -EINVAL: Not initialized source number
+    -EINVAL: Invalid priority
+    -EINVAL: Invalid CPU number.
+    -EFAULT: Invalid user pointer for attr->addr.
+    -ENXIO:  CPU event queues not configured or configuration of the
+             underlying HW interrupt failed
+    -EBUSY:  No CPU available to serve interrupt
-- 
2.20.1

