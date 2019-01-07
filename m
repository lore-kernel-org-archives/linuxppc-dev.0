Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC83C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:08:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BFE0206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFE0206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YQ0f3fd4zDqQd
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 06:08:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=87.98.172.75; helo=4.mo2.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 960 seconds by postgrey-1.36 at bilbo;
 Tue, 08 Jan 2019 06:02:30 AEDT
Received: from 4.mo2.mail-out.ovh.net (4.mo2.mail-out.ovh.net [87.98.172.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YPsL6w78zDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 06:02:30 +1100 (AEDT)
Received: from player737.ha.ovh.net (unknown [10.109.143.146])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3A17F17927E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2019 19:46:38 +0100 (CET)
Received: from kaod.org (lfbn-1-10605-110.w90-89.abo.wanadoo.fr
 [90.89.196.110]) (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 89F9A1866589;
 Mon,  7 Jan 2019 18:46:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 15/19] KVM: PPC: Book3S HV: add get/set accessors for the
 source configuration
Date: Mon,  7 Jan 2019 19:43:27 +0100
Message-Id: <20190107184331.8429-16-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107184331.8429-1-clg@kaod.org>
References: <20190107184331.8429-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11425069306851462103
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrvdejgdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

Theses are use to capure the XIVE EAS table of the KVM device, the
configuration of the source targets.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/uapi/asm/kvm.h   | 11 ++++
 arch/powerpc/kvm/book3s_xive_native.c | 87 +++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 1a8740629acf..faf024f39858 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -683,9 +683,20 @@ struct kvm_ppc_cpu_char {
 #define   KVM_DEV_XIVE_SAVE_EQ_PAGES	4
 #define KVM_DEV_XIVE_GRP_SOURCES	2	/* 64-bit source attributes */
 #define KVM_DEV_XIVE_GRP_SYNC		3	/* 64-bit source attributes */
+#define KVM_DEV_XIVE_GRP_EAS		4	/* 64-bit eas attributes */
 
 /* Layout of 64-bit XIVE source attribute values */
 #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
 #define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
 
+/* Layout of 64-bit eas attribute values */
+#define KVM_XIVE_EAS_PRIORITY_SHIFT	0
+#define KVM_XIVE_EAS_PRIORITY_MASK	0x7
+#define KVM_XIVE_EAS_SERVER_SHIFT	3
+#define KVM_XIVE_EAS_SERVER_MASK	0xfffffff8ULL
+#define KVM_XIVE_EAS_MASK_SHIFT		32
+#define KVM_XIVE_EAS_MASK_MASK		0x100000000ULL
+#define KVM_XIVE_EAS_EISN_SHIFT		33
+#define KVM_XIVE_EAS_EISN_MASK		0xfffffffe00000000ULL
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index f2de1bcf3b35..0468b605baa7 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -525,6 +525,88 @@ static int kvmppc_xive_native_sync(struct kvmppc_xive *xive, long irq, u64 addr)
 	return 0;
 }
 
+static int kvmppc_xive_native_set_eas(struct kvmppc_xive *xive, long irq,
+				      u64 addr)
+{
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u64 __user *ubufp = (u64 __user *) addr;
+	u16 src;
+	u64 kvm_eas;
+	u32 server;
+	u8 priority;
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
+	if (get_user(kvm_eas, ubufp))
+		return -EFAULT;
+
+	pr_devel("%s irq=0x%lx eas=%016llx\n", __func__, irq, kvm_eas);
+
+	priority = (kvm_eas & KVM_XIVE_EAS_PRIORITY_MASK) >>
+		KVM_XIVE_EAS_PRIORITY_SHIFT;
+	server = (kvm_eas & KVM_XIVE_EAS_SERVER_MASK) >>
+		KVM_XIVE_EAS_SERVER_SHIFT;
+	eisn = (kvm_eas & KVM_XIVE_EAS_EISN_MASK) >> KVM_XIVE_EAS_EISN_SHIFT;
+
+	if (priority != xive_prio_from_guest(priority)) {
+		pr_err("invalid priority for queue %d for VCPU %d\n",
+		       priority, server);
+		return -EINVAL;
+	}
+
+	return kvmppc_xive_native_set_source_config(xive, sb, state, server,
+						    priority, eisn);
+}
+
+static int kvmppc_xive_native_get_eas(struct kvmppc_xive *xive, long irq,
+				      u64 addr)
+{
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u64 __user *ubufp = (u64 __user *) addr;
+	u16 src;
+	u64 kvm_eas;
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
+	arch_spin_lock(&sb->lock);
+
+	if (state->act_priority == MASKED)
+		kvm_eas = KVM_XIVE_EAS_MASK_MASK;
+	else {
+		kvm_eas = (state->act_priority << KVM_XIVE_EAS_PRIORITY_SHIFT) &
+			KVM_XIVE_EAS_PRIORITY_MASK;
+		kvm_eas |= (state->act_server << KVM_XIVE_EAS_SERVER_SHIFT) &
+			KVM_XIVE_EAS_SERVER_MASK;
+		kvm_eas |= ((u64) state->eisn << KVM_XIVE_EAS_EISN_SHIFT) &
+			KVM_XIVE_EAS_EISN_MASK;
+	}
+	arch_spin_unlock(&sb->lock);
+
+	pr_devel("%s irq=0x%lx eas=%016llx\n", __func__, irq, kvm_eas);
+
+	if (put_user(kvm_eas, ubufp))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 				       struct kvm_device_attr *attr)
 {
@@ -544,6 +626,8 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 						     attr->addr);
 	case KVM_DEV_XIVE_GRP_SYNC:
 		return kvmppc_xive_native_sync(xive, attr->attr, attr->addr);
+	case KVM_DEV_XIVE_GRP_EAS:
+		return kvmppc_xive_native_set_eas(xive, attr->attr, attr->addr);
 	}
 	return -ENXIO;
 }
@@ -564,6 +648,8 @@ static int kvmppc_xive_native_get_attr(struct kvm_device *dev,
 			return kvmppc_xive_native_get_vc_base(xive, attr->addr);
 		}
 		break;
+	case KVM_DEV_XIVE_GRP_EAS:
+		return kvmppc_xive_native_get_eas(xive, attr->attr, attr->addr);
 	}
 	return -ENXIO;
 }
@@ -583,6 +669,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
 		break;
 	case KVM_DEV_XIVE_GRP_SOURCES:
 	case KVM_DEV_XIVE_GRP_SYNC:
+	case KVM_DEV_XIVE_GRP_EAS:
 		if (attr->attr >= KVMPPC_XIVE_FIRST_IRQ &&
 		    attr->attr < KVMPPC_XIVE_NR_IRQS)
 			return 0;
-- 
2.20.1

