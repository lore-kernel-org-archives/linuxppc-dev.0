Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D74FC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 20:03:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D0C206BB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 20:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D0C206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YRDC4H9BzDq5y
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 07:03:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.43.131; helo=7.mo7.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 3602 seconds by postgrey-1.36 at bilbo;
 Tue, 08 Jan 2019 07:01:47 AEDT
Received: from 7.mo7.mail-out.ovh.net (7.mo7.mail-out.ovh.net [46.105.43.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YR9l07LMzDqKJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 07:01:46 +1100 (AEDT)
Received: from player737.ha.ovh.net (unknown [10.109.146.175])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 640A2F2C73
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2019 19:45:21 +0100 (CET)
Received: from kaod.org (lfbn-1-10605-110.w90-89.abo.wanadoo.fr
 [90.89.196.110]) (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id D962C186643B;
 Mon,  7 Jan 2019 18:45:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 08/19] KVM: PPC: Book3S HV: add a VC_BASE control to the XIVE
 native device
Date: Mon,  7 Jan 2019 19:43:20 +0100
Message-Id: <20190107184331.8429-9-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107184331.8429-1-clg@kaod.org>
References: <20190107184331.8429-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11403395734415510487
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

The ESB MMIO region controls the interrupt sources of the guest. QEMU
will query an fd (GET_ESB_FD ioctl) and map this region at a specific
address for the guest to use. The guest will obtain this information
using the H_INT_GET_SOURCE_INFO hcall. To inform KVM of the address
setting used by QEMU, add a VC_BASE control to the KVM XIVE device

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/uapi/asm/kvm.h   |  1 +
 arch/powerpc/kvm/book3s_xive.h        |  3 +++
 arch/powerpc/kvm/book3s_xive_native.c | 39 +++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 89c140cb9e79..8b78b12aa118 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -679,5 +679,6 @@ struct kvm_ppc_cpu_char {
 #define KVM_DEV_XIVE_GRP_CTRL		1
 #define   KVM_DEV_XIVE_GET_ESB_FD	1
 #define   KVM_DEV_XIVE_GET_TIMA_FD	2
+#define   KVM_DEV_XIVE_VC_BASE		3
 
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index 5f22415520b4..ae4a670eea63 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -125,6 +125,9 @@ struct kvmppc_xive {
 
 	/* Flags */
 	u8	single_escalation;
+
+	/* VC base address for ESBs */
+	u64     vc_base;
 };
 
 #define KVMPPC_XIVE_Q_COUNT	8
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index ee9d12bf2dae..29a62914de55 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -153,6 +153,25 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 	return rc;
 }
 
+static int kvmppc_xive_native_set_vc_base(struct kvmppc_xive *xive, u64 addr)
+{
+	u64 __user *ubufp = (u64 __user *) addr;
+
+	if (get_user(xive->vc_base, ubufp))
+		return -EFAULT;
+	return 0;
+}
+
+static int kvmppc_xive_native_get_vc_base(struct kvmppc_xive *xive, u64 addr)
+{
+	u64 __user *ubufp = (u64 __user *) addr;
+
+	if (put_user(xive->vc_base, ubufp))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int xive_native_esb_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -289,6 +308,16 @@ static int kvmppc_xive_native_get_tima_fd(struct kvmppc_xive *xive, u64 addr)
 static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 				       struct kvm_device_attr *attr)
 {
+	struct kvmppc_xive *xive = dev->private;
+
+	switch (attr->group) {
+	case KVM_DEV_XIVE_GRP_CTRL:
+		switch (attr->attr) {
+		case KVM_DEV_XIVE_VC_BASE:
+			return kvmppc_xive_native_set_vc_base(xive, attr->addr);
+		}
+		break;
+	}
 	return -ENXIO;
 }
 
@@ -304,6 +333,8 @@ static int kvmppc_xive_native_get_attr(struct kvm_device *dev,
 			return kvmppc_xive_native_get_esb_fd(xive, attr->addr);
 		case KVM_DEV_XIVE_GET_TIMA_FD:
 			return kvmppc_xive_native_get_tima_fd(xive, attr->addr);
+		case KVM_DEV_XIVE_VC_BASE:
+			return kvmppc_xive_native_get_vc_base(xive, attr->addr);
 		}
 		break;
 	}
@@ -318,6 +349,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
 		switch (attr->attr) {
 		case KVM_DEV_XIVE_GET_ESB_FD:
 		case KVM_DEV_XIVE_GET_TIMA_FD:
+		case KVM_DEV_XIVE_VC_BASE:
 			return 0;
 		}
 		break;
@@ -353,6 +385,11 @@ static void kvmppc_xive_native_free(struct kvm_device *dev)
 	kfree(dev);
 }
 
+/*
+ * ESB MMIO address of chip 0
+ */
+#define XIVE_VC_BASE   0x0006010000000000ull
+
 static int kvmppc_xive_native_create(struct kvm_device *dev, u32 type)
 {
 	struct kvmppc_xive *xive;
@@ -387,6 +424,8 @@ static int kvmppc_xive_native_create(struct kvm_device *dev, u32 type)
 	if (xive->vp_base == XIVE_INVALID_VP)
 		ret = -ENOMEM;
 
+	xive->vc_base = XIVE_VC_BASE;
+
 	xive->single_escalation = xive_native_has_single_escalation();
 
 	if (ret)
-- 
2.20.1

