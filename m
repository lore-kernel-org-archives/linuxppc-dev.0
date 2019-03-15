Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1DEC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 12:39:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6410721871
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 12:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6410721871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LQBJ16qXzDqJM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 23:39:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.51.53; helo=5.mo178.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 5.mo178.mail-out.ovh.net (5.mo178.mail-out.ovh.net
 [46.105.51.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LPrn3xjpzDqPl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 23:24:08 +1100 (AEDT)
Received: from player793.ha.ovh.net (unknown [10.109.160.153])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 6B5C458D01
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 13:08:01 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id A01E53CD1EE4;
 Fri, 15 Mar 2019 12:07:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v3 08/17] KVM: PPC: Book3S HV: XIVE: add a control to sync the
 sources
Date: Fri, 15 Mar 2019 13:06:00 +0100
Message-Id: <20190315120609.25910-9-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315120609.25910-1-clg@kaod.org>
References: <20190315120609.25910-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10781898983822101463
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

This control will be used by the H_INT_SYNC hcall from QEMU to flush
event notifications on the XIVE IC owning the source.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---

 Changes since v2 :

 - fixed locking on source block

 arch/powerpc/include/uapi/asm/kvm.h        |  1 +
 arch/powerpc/kvm/book3s_xive_native.c      | 36 ++++++++++++++++++++++
 Documentation/virtual/kvm/devices/xive.txt |  8 +++++
 3 files changed, 45 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 95e82ab57c03..fc9211dbfec8 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -681,6 +681,7 @@ struct kvm_ppc_cpu_char {
 #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source identifier */
 #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source identifier */
 #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit EQ identifier */
+#define KVM_DEV_XIVE_GRP_SOURCE_SYNC	5       /* 64-bit source identifier */
 
 /* Layout of 64-bit XIVE source attribute values */
 #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 3385c336fd89..26ac3c505cd2 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -340,6 +340,38 @@ static int kvmppc_xive_native_set_source_config(struct kvmppc_xive *xive,
 						       priority, masked, eisn);
 }
 
+static int kvmppc_xive_native_sync_source(struct kvmppc_xive *xive,
+					  long irq, u64 addr)
+{
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	struct xive_irq_data *xd;
+	u32 hw_num;
+	u16 src;
+	int rc = 0;
+
+	pr_devel("%s irq=0x%lx", __func__, irq);
+
+	sb = kvmppc_xive_find_source(xive, irq, &src);
+	if (!sb)
+		return -ENOENT;
+
+	state = &sb->irq_state[src];
+
+	rc = -EINVAL;
+
+	arch_spin_lock(&sb->lock);
+
+	if (state->valid) {
+		kvmppc_xive_select_irq(state, &hw_num, &xd);
+		xive_native_sync_source(hw_num);
+		rc = 0;
+	}
+
+	arch_spin_unlock(&sb->lock);
+	return rc;
+}
+
 static int xive_native_validate_queue_size(u32 qsize)
 {
 	/*
@@ -658,6 +690,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
 		return kvmppc_xive_native_set_queue_config(xive, attr->attr,
 							   attr->addr);
+	case KVM_DEV_XIVE_GRP_SOURCE_SYNC:
+		return kvmppc_xive_native_sync_source(xive, attr->attr,
+						      attr->addr);
 	}
 	return -ENXIO;
 }
@@ -687,6 +722,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
 		break;
 	case KVM_DEV_XIVE_GRP_SOURCE:
 	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
+	case KVM_DEV_XIVE_GRP_SOURCE_SYNC:
 		if (attr->attr >= KVMPPC_XIVE_FIRST_IRQ &&
 		    attr->attr < KVMPPC_XIVE_NR_IRQS)
 			return 0;
diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
index e1893d303ab7..055aed0c2abb 100644
--- a/Documentation/virtual/kvm/devices/xive.txt
+++ b/Documentation/virtual/kvm/devices/xive.txt
@@ -89,3 +89,11 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
     -EINVAL: Invalid queue address
     -EFAULT: Invalid user pointer for attr->addr.
     -EIO:    Configuration of the underlying HW failed
+
+  5. KVM_DEV_XIVE_GRP_SOURCE_SYNC (write only)
+  Synchronize the source to flush event notifications
+  Attributes:
+    Interrupt source number  (64-bit)
+  Errors:
+    -ENOENT: Unknown source number
+    -EINVAL: Not initialized source number
-- 
2.20.1

