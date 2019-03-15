Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFDCC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 12:15:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2833B2186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 12:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2833B2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LPfp1kxRzDqSm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 23:15:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.72.216; helo=16.mo7.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 16.mo7.mail-out.ovh.net (16.mo7.mail-out.ovh.net
 [46.105.72.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LPW011kFzDqKH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 23:08:42 +1100 (AEDT)
Received: from player793.ha.ovh.net (unknown [10.109.146.143])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 5C905109C2F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 13:08:38 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id 7657A3CD200F;
 Fri, 15 Mar 2019 12:08:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v3 11/17] KVM: introduce a 'mmap' method for KVM devices
Date: Fri, 15 Mar 2019 13:06:03 +0100
Message-Id: <20190315120609.25910-12-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315120609.25910-1-clg@kaod.org>
References: <20190315120609.25910-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10792313560885988311
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
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Some KVM devices will want to handle special mappings related to the
underlying HW. For instance, the XIVE interrupt controller of the
POWER9 processor has MMIO pages for thread interrupt management and
for interrupt source control that need to be exposed to the guest when
the OS has the required support.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c38cc5eb7e73..cbf81487b69f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1223,6 +1223,7 @@ struct kvm_device_ops {
 	int (*has_attr)(struct kvm_device *dev, struct kvm_device_attr *attr);
 	long (*ioctl)(struct kvm_device *dev, unsigned int ioctl,
 		      unsigned long arg);
+	int (*mmap)(struct kvm_device *dev, struct vm_area_struct *vma);
 };
 
 void kvm_device_get(struct kvm_device *dev);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 076bc38963bf..e4881a8c2a6f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2878,6 +2878,16 @@ static long kvm_vcpu_compat_ioctl(struct file *filp,
 }
 #endif
 
+static int kvm_device_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct kvm_device *dev = filp->private_data;
+
+	if (dev->ops->mmap)
+		return dev->ops->mmap(dev, vma);
+
+	return -ENODEV;
+}
+
 static int kvm_device_ioctl_attr(struct kvm_device *dev,
 				 int (*accessor)(struct kvm_device *dev,
 						 struct kvm_device_attr *attr),
@@ -2927,6 +2937,7 @@ static const struct file_operations kvm_device_fops = {
 	.unlocked_ioctl = kvm_device_ioctl,
 	.release = kvm_device_release,
 	KVM_COMPAT(kvm_device_ioctl),
+	.mmap = kvm_device_mmap,
 };
 
 struct kvm_device *kvm_device_from_filp(struct file *filp)
-- 
2.20.1

