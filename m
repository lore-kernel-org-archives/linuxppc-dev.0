Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DB9ECDE4B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 14:57:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE6C2081D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 14:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dakgvDUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE6C2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rRGG4WPnzF31m
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 01:57:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dakgvDUh";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="dakgvDUh"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rR2Y09XzzF3Qx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 01:47:16 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id f12-v6so8456580plo.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 06:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BZQ//cVaU9tNuNQAUhzd/1Jm0JpGnlnc9pX5EOH8jfE=;
 b=dakgvDUhoG0N4yW1yG/I0oZq3nCDdZBOh/wa74K3vSf5FR+lqAfagvxUCvlcBTr8jR
 aRvO2iqpJiqkKZ3uoba0/tGVvIZ63uOsTeneeBsFjM4nSav6NpKTjViA5zyQakVAF2fH
 IxWhGFvQgmu5aoTDeiWdg9hq+AZns7c5bwi1gXOzmja2Q+5A3PbRhIXPJVTm1l02WmJv
 Mfo3VzPP/U0mzo3s0VzU2dNt3fy+YmM8nZAXIA3NkXHdRj64q5r7AfiYrRz9PKtgZneU
 42erW7HWBLITML/dTDpuJb5r812nEw+O+d5y51ZtjaYP9cm8tkhO4HhESp1guPLtXv91
 7YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BZQ//cVaU9tNuNQAUhzd/1Jm0JpGnlnc9pX5EOH8jfE=;
 b=BQxOGJLXkE1d5nTE2o/V57wuiLHUqzCp6hczbvQNL/wGbzafgEWq4rR3KmZ2bWq920
 FZm3xLRKiYxo089+e+Rtxw2CzrqSXZOn+lpbYtXXyS9NQZwGhsqfIhiGbSSHqjSqawlX
 /itCIWXEdpVE8m3+z5x6p3Tu+Hdhqgo3lYYe8NSvR0fZb62VxuPeH/tOlnJOSRjkuhGC
 aw4p/BT5ppJO9GtlMX2sulboM3oRefzrMSyFEFRirMW4eMpeiAL30IHcsUqLsbHRvJm+
 aPi5X0TLCdPkc7m981WABX1FapIeWXOhtR7z+T5ukld98VtlVCD4XrF3/X8C7VVpNcZb
 twYA==
X-Gm-Message-State: AGRZ1gLhopq0mOusi/l4Lo16nowKgf/ZFVeEEuDW2VO5Fav0dOUcbEzf
 dJG7vl1mL/lkXG88A9ugZis=
X-Google-Smtp-Source: AJdET5d0OyvOJn1vhgHbHuNaVqFsq35jwkAoBXKHzeiDPK0Z34EZ7m7GbyqOI0ETtiYP5f072/N0ng==
X-Received: by 2002:a17:902:31a4:: with SMTP id
 x33-v6mr4777932plb.105.1541688435329; 
 Thu, 08 Nov 2018 06:47:15 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id
 k75-v6sm11526731pfb.119.2018.11.08.06.47.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 08 Nov 2018 06:47:14 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [Resend PATCH V5 4/10] KVM/VMX: Add hv tlb range flush support
Date: Thu,  8 Nov 2018 22:46:33 +0800
Message-Id: <20181108144639.11206-4-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
References: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
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
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
 catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@arm.com,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu, x86@kernel.org,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com, mingo@redhat.com,
 jhogan@kernel.org, Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to register tlb_remote_flush_with_range callback with
hv tlb range flush interface.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v4:
	- Use new function kvm_fill_hv_flush_list_func() to fill flush
       request.
Change since v3:
	- Merge Vitaly's don't pass EPT configuration info to
vmx_hv_remote_flush_tlb() fix.
Change since v1:
	- Pass flush range with new hyper-v tlb flush struct rather
       than KVM tlb flush struct.
---
 arch/x86/kvm/vmx.c | 69 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index edbc96cb990a..405dfbde70b2 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1567,7 +1567,38 @@ static void check_ept_pointer_match(struct kvm *kvm)
 	to_kvm_vmx(kvm)->ept_pointers_match = EPT_POINTERS_MATCH;
 }
 
-static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
+int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush,
+		void *data)
+{
+	struct kvm_tlb_range *range = data;
+
+	return hyperv_fill_flush_guest_mapping_list(flush, range->start_gfn,
+			range->pages);
+}
+
+static inline int __hv_remote_flush_tlb_with_range(struct kvm *kvm,
+		struct kvm_vcpu *vcpu, struct kvm_tlb_range *range)
+{
+	u64 ept_pointer = to_vmx(vcpu)->ept_pointer;
+
+	/* If ept_pointer is invalid pointer, bypass flush request. */
+	if (!VALID_PAGE(ept_pointer))
+		return 0;
+
+	/*
+	 * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs address
+	 * of the base of EPT PML4 table, strip off EPT configuration
+	 * information.
+	 */
+	if (range)
+		return hyperv_flush_guest_mapping_range(ept_pointer & PAGE_MASK,
+				kvm_fill_hv_flush_list_func, (void *)range);
+	else
+		return hyperv_flush_guest_mapping(ept_pointer & PAGE_MASK);
+}
+
+static int hv_remote_flush_tlb_with_range(struct kvm *kvm,
+		struct kvm_tlb_range *range)
 {
 	struct kvm_vcpu *vcpu;
 	int ret = -ENOTSUPP, i;
@@ -1577,30 +1608,23 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
 	if (to_kvm_vmx(kvm)->ept_pointers_match == EPT_POINTERS_CHECK)
 		check_ept_pointer_match(kvm);
 
-	/*
-	 * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs the address of the
-	 * base of EPT PML4 table, strip off EPT configuration information.
-	 * If ept_pointer is invalid pointer, bypass the flush request.
-	 */
 	if (to_kvm_vmx(kvm)->ept_pointers_match != EPT_POINTERS_MATCH) {
-		kvm_for_each_vcpu(i, vcpu, kvm) {
-			if (!VALID_PAGE(to_vmx(vcpu)->ept_pointer))
-				return 0;
-
-			ret |= hyperv_flush_guest_mapping(
-				to_vmx(vcpu)->ept_pointer & PAGE_MASK);
-		}
+		kvm_for_each_vcpu(i, vcpu, kvm)
+			ret |= __hv_remote_flush_tlb_with_range(
+					kvm, vcpu, range);
 	} else {
-		if (!VALID_PAGE(to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer))
-			return 0;
-
-		ret = hyperv_flush_guest_mapping(
-			to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
+		ret = __hv_remote_flush_tlb_with_range(kvm,
+				kvm_get_vcpu(kvm, 0), range);
 	}
 
 	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
 	return ret;
 }
+
+static int hv_remote_flush_tlb(struct kvm *kvm)
+{
+	return hv_remote_flush_tlb_with_range(kvm, NULL);
+}
 #else /* !IS_ENABLED(CONFIG_HYPERV) */
 static inline void evmcs_write64(unsigned long field, u64 value) {}
 static inline void evmcs_write32(unsigned long field, u32 value) {}
@@ -7957,8 +7981,11 @@ static __init int hardware_setup(void)
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	if (ms_hyperv.nested_features & HV_X64_NESTED_GUEST_MAPPING_FLUSH
-	    && enable_ept)
-		kvm_x86_ops->tlb_remote_flush = vmx_hv_remote_flush_tlb;
+	    && enable_ept) {
+		kvm_x86_ops->tlb_remote_flush = hv_remote_flush_tlb;
+		kvm_x86_ops->tlb_remote_flush_with_range =
+				hv_remote_flush_tlb_with_range;
+	}
 #endif
 
 	if (!cpu_has_vmx_ple()) {
@@ -11567,6 +11594,8 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.current_vmptr = -1ull;
 
+	vmx->ept_pointer = INVALID_PAGE;
+
 	vmx->msr_ia32_feature_control_valid_bits = FEATURE_CONTROL_LOCKED;
 
 	/*
-- 
2.14.4

