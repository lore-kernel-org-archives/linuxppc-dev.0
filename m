Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72BCC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 12:13:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8632186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 12:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8632186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LPcP4ccgzDqST
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 23:13:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.111.220; helo=1.mo179.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 1.mo179.mail-out.ovh.net (1.mo179.mail-out.ovh.net
 [178.33.111.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LPV34Vq4zDqSR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 23:07:55 +1100 (AEDT)
Received: from player793.ha.ovh.net (unknown [10.109.146.211])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id ABD8C11BAE2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 13:07:50 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id 998743CD1E40;
 Fri, 15 Mar 2019 12:07:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v3 07/17] KVM: PPC: Book3S HV: XIVE: add a global reset control
Date: Fri, 15 Mar 2019 13:05:59 +0100
Message-Id: <20190315120609.25910-8-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315120609.25910-1-clg@kaod.org>
References: <20190315120609.25910-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10778802760361085911
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrheehgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

This control is to be used by the H_INT_RESET hcall from QEMU. Its
purpose is to clear all configuration of the sources and EQs. This is
necessary in case of a kexec (for a kdump kernel for instance) to make
sure that no remaining configuration is left from the previous boot
setup so that the new kernel can start safely from a clean state.

The queue 7 is ignored when the XIVE device is configured to run in
single escalation mode. Prio 7 is used by escalations.

The XIVE VP is kept enabled as the vCPU is still active and connected
to the XIVE device.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---

 Changes since v2 :

 - fixed locking on source block

 arch/powerpc/include/uapi/asm/kvm.h        |  1 +
 arch/powerpc/kvm/book3s_xive_native.c      | 85 ++++++++++++++++++++++
 Documentation/virtual/kvm/devices/xive.txt |  5 ++
 3 files changed, 91 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 1cd728c87d7c..95e82ab57c03 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -677,6 +677,7 @@ struct kvm_ppc_cpu_char {
 
 /* POWER9 XIVE Native Interrupt Controller */
 #define KVM_DEV_XIVE_GRP_CTRL		1
+#define   KVM_DEV_XIVE_RESET		1
 #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source identifier */
 #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source identifier */
 #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit EQ identifier */
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 42e824658a30..3385c336fd89 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -560,6 +560,83 @@ static int kvmppc_xive_native_get_queue_config(struct kvmppc_xive *xive,
 	return 0;
 }
 
+static void kvmppc_xive_reset_sources(struct kvmppc_xive_src_block *sb)
+{
+	int i;
+
+	for (i = 0; i < KVMPPC_XICS_IRQ_PER_ICS; i++) {
+		struct kvmppc_xive_irq_state *state = &sb->irq_state[i];
+
+		if (!state->valid)
+			continue;
+
+		if (state->act_priority == MASKED)
+			continue;
+
+		state->eisn = 0;
+		state->act_server = 0;
+		state->act_priority = MASKED;
+		xive_vm_esb_load(&state->ipi_data, XIVE_ESB_SET_PQ_01);
+		xive_native_configure_irq(state->ipi_number, 0, MASKED, 0);
+		if (state->pt_number) {
+			xive_vm_esb_load(state->pt_data, XIVE_ESB_SET_PQ_01);
+			xive_native_configure_irq(state->pt_number,
+						  0, MASKED, 0);
+		}
+	}
+}
+
+static int kvmppc_xive_reset(struct kvmppc_xive *xive)
+{
+	struct kvm *kvm = xive->kvm;
+	struct kvm_vcpu *vcpu;
+	unsigned int i;
+
+	pr_devel("%s\n", __func__);
+
+	mutex_lock(&kvm->lock);
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+		unsigned int prio;
+
+		if (!xc)
+			continue;
+
+		kvmppc_xive_disable_vcpu_interrupts(vcpu);
+
+		for (prio = 0; prio < KVMPPC_XIVE_Q_COUNT; prio++) {
+
+			/* Single escalation, no queue 7 */
+			if (prio == 7 && xive->single_escalation)
+				break;
+
+			if (xc->esc_virq[prio]) {
+				free_irq(xc->esc_virq[prio], vcpu);
+				irq_dispose_mapping(xc->esc_virq[prio]);
+				kfree(xc->esc_virq_names[prio]);
+				xc->esc_virq[prio] = 0;
+			}
+
+			kvmppc_xive_native_cleanup_queue(vcpu, prio);
+		}
+	}
+
+	for (i = 0; i <= xive->max_sbid; i++) {
+		struct kvmppc_xive_src_block *sb = xive->src_blocks[i];
+
+		if (sb) {
+			arch_spin_lock(&sb->lock);
+			kvmppc_xive_reset_sources(sb);
+			arch_spin_unlock(&sb->lock);
+		}
+	}
+
+	mutex_unlock(&kvm->lock);
+
+	return 0;
+}
+
 static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 				       struct kvm_device_attr *attr)
 {
@@ -567,6 +644,10 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 
 	switch (attr->group) {
 	case KVM_DEV_XIVE_GRP_CTRL:
+		switch (attr->attr) {
+		case KVM_DEV_XIVE_RESET:
+			return kvmppc_xive_reset(xive);
+		}
 		break;
 	case KVM_DEV_XIVE_GRP_SOURCE:
 		return kvmppc_xive_native_set_source(xive, attr->attr,
@@ -599,6 +680,10 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
 {
 	switch (attr->group) {
 	case KVM_DEV_XIVE_GRP_CTRL:
+		switch (attr->attr) {
+		case KVM_DEV_XIVE_RESET:
+			return 0;
+		}
 		break;
 	case KVM_DEV_XIVE_GRP_SOURCE:
 	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
index a4de64f6e79c..e1893d303ab7 100644
--- a/Documentation/virtual/kvm/devices/xive.txt
+++ b/Documentation/virtual/kvm/devices/xive.txt
@@ -17,6 +17,11 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
 
   1. KVM_DEV_XIVE_GRP_CTRL
   Provides global controls on the device
+  Attributes:
+    1.1 KVM_DEV_XIVE_RESET (write only)
+    Resets the interrupt controller configuration for sources and event
+    queues. To be used by kexec and kdump.
+    Errors: none
 
   2. KVM_DEV_XIVE_GRP_SOURCE (write only)
   Initializes a new source in the XIVE device and mask it.
-- 
2.20.1

