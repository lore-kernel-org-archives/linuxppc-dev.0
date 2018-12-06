Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE30C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 13:40:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FDC220878
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 13:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouQOyufS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDC220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439cDB4GGTzDqQT
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 00:40:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ouQOyufS";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ouQOyufS"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439bqD1NJ9zDr8V
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 00:22:00 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id q1so175835pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 05:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FifTGwX83EQ8+OEfJfdERX2ACrXZsduv44eJgHUH8jk=;
 b=ouQOyufSH1/uGjxiNK638Mg4OcgdV54+aK+ERvM9nuExiRVwlTnqiudVXzDF0hTPrM
 k5NzMIrpAxJuZq7GrSPO/e43Slpbs3AKzR7xiiNBOCFKHxRZPklchjWhyc2xpXShjz6w
 mY6WyhU5r39tlUPeSie4e/oiy09f0rti5h6M//m450EBt5M95D1Ms25b8W/FiuQXHwIV
 SR2envrTDTAFCluFNaxS6CXxHsqS12dWFc5nbwpE6Y9c+KqBvfln/JhX9h/fVksa4A6/
 DoegjgMPNn3sINWU37pGFc4UKOVj7fq3P8u4r6DlhQVTOtUYxhoL4Thigr4Hu0dIGTBC
 cdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FifTGwX83EQ8+OEfJfdERX2ACrXZsduv44eJgHUH8jk=;
 b=nnzlhjrWyg+5NKgbV2boRoOEo7BiyDPZyeQlvAgqUeZ1zbZde6NOwkjJhYcmzAyzpB
 777cCpfLUjjWyBNx28SDY/nHaiQARhOTaBPB1Qvjvwl7dVxQctEZms2UjjY4ScRDB/+T
 jfLjFwAjDxU8u2m9/5F1EIZvQRbRglek0jHGJxjCxrVPumDst3LPyQkmTaNIfLt3Bjw+
 huenYzX9FE9KZWNC0+UseWooIm+Y35ZvbzuKU+jn0jCiNaii7ooJmZslZiQt8GQzoIE3
 BM/yqJf2akiQXe505U3vBRHWi47U9IhMzbvico+g8I2esZ7WxkKB9ICPrcWudn6Jgw5/
 /6gw==
X-Gm-Message-State: AA+aEWa/56UtVmIDyVCfaCemS6sfQvLO0+Fgc/RTKGaO/HHhXCmv5oOn
 xADDr7kngqxL1d4MaKkOy1o=
X-Google-Smtp-Source: AFSGD/XCYgp2n6afvG2NNG13lbKRDr+Z8n6ZKQ8J0OQOGaIotugH6znCCj6Lc0VvKfwDWXv900qNgQ==
X-Received: by 2002:a63:396:: with SMTP id 144mr24368991pgd.68.1544102518590; 
 Thu, 06 Dec 2018 05:21:58 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id y5sm2409246pge.49.2018.12.06.05.21.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 05:21:58 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [Resend PATCH V5 4/10] KVM/VMX: Add hv tlb range flush support
Date: Thu,  6 Dec 2018 21:21:07 +0800
Message-Id: <20181206132113.2691-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
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
 arch/x86/kvm/vmx.c | 63 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 2356118ea440..bad2aa6c5ca1 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1569,7 +1569,34 @@ static void check_ept_pointer_match(struct kvm *kvm)
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
@@ -1579,29 +1606,26 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
 	if (to_kvm_vmx(kvm)->ept_pointers_match == EPT_POINTERS_CHECK)
 		check_ept_pointer_match(kvm);
 
-	/*
-	 * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs the address of the
-	 * base of EPT PML4 table, strip off EPT configuration information.
-	 * If ept_pointer is invalid pointer, bypass the flush request.
-	 */
 	if (to_kvm_vmx(kvm)->ept_pointers_match != EPT_POINTERS_MATCH) {
 		kvm_for_each_vcpu(i, vcpu, kvm) {
-			u64 ept_pointer = to_vmx(vcpu)->ept_pointer;
-
-			if (!VALID_PAGE(ept_pointer))
-				continue;
-
-			ret |= hyperv_flush_guest_mapping(
-				ept_pointer & PAGE_MASK);
+			/* If ept_pointer is invalid pointer, bypass flush request. */
+			if (VALID_PAGE(to_vmx(vcpu)->ept_pointer))
+				ret |= __hv_remote_flush_tlb_with_range(
+						kvm, vcpu, range);
 		}
 	} else {
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
@@ -7971,8 +7995,11 @@ static __init int hardware_setup(void)
 
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
@@ -11612,6 +11639,8 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.current_vmptr = -1ull;
 
+	vmx->ept_pointer = INVALID_PAGE;
+
 	vmx->msr_ia32_feature_control_valid_bits = FEATURE_CONTROL_LOCKED;
 
 	/*
-- 
2.14.4

