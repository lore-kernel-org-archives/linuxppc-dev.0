Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A449ECDE4B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 14:52:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97E52081D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 14:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmbqdSX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97E52081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rR8K2YWVzF3QQ
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 01:52:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XmbqdSX4";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XmbqdSX4"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rR2F1T98zF3Q7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 01:47:01 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id d13-v6so2229800pfo.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 06:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TYuyTkflRcnx3QMiKvx4ju01+G1cvnTqq8KRbiS6pe8=;
 b=XmbqdSX4r3pdTr821/AzuHd9y57PQNvdSzcnMslakgBUVI+NrSf+SY+Ei3h1EXGNmB
 0m0vivRZEQ+jfvW+X8voEFNQ/9wYBnDTkabYraKMLl1w6EvVSQv1a58DPh6oKF5KjjRm
 1OU9I5t/z8UPC/BqqPEGcTioATrG5lbUPxgofC3HulAxJIfeTUXWts12nD9xi/xbTjPe
 7GDf2ZJ1CvDpL8tbM5sAD6QNB8x/fCgKsjn4e9wyxVrLVhYqEh+IHfAECTK4PohEB8lc
 1OX13V/gPqYgfxfL0jx2V+duRbQvLopHqy3BLPw1XwyjsDB8Ub2zeO8WPSJ0dX+joMjN
 gvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TYuyTkflRcnx3QMiKvx4ju01+G1cvnTqq8KRbiS6pe8=;
 b=YR8VFXFj5rBPMmjbjexXtGTLl0fzmoyOmU7rOtcd6QUmfbjiXvjahVqCkTkioonai+
 MTfYs6ANkIz7MGQSUHgMT02OssdfALzeJxIokY76bs2ier3mqT8HsqrXUo0xGlz03Zxk
 Au/d+oc7jTsJUs9kibHxfbD0/H4H2B7OdP7WenwHy6wOVIrd5ruIRqfoPyhyl+0NzkdI
 wxrSRWPhJKz2eNjN0m2v3QXlH6e6hKDM+Qywc7MEton30hWZ6bxi4cEFLu3JYvmvd263
 L1fLASBdX/EKTvk8nlVxjymH9aaCp71xmGjZtCPY39GzPagXpr4wnGaAhi3gidrSIgJH
 yQeQ==
X-Gm-Message-State: AGRZ1gLQovTFBO3HYfbOUqABZ7PlsEiXK6WWAQkm/GUR6Vu37yZ4eAGB
 UN8lqf2urx4KqkokFVOXB6U=
X-Google-Smtp-Source: AJdET5fNr/xwGzjyov3VZwQpb5i6rNaHmda0EpWHGpBuHJFpkufPd6sI5eVgLDlp1G2XJ8N7VDMcFw==
X-Received: by 2002:a62:3a8c:: with SMTP id
 v12-v6mr4771457pfj.118.1541688419461; 
 Thu, 08 Nov 2018 06:46:59 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id
 k75-v6sm11526731pfb.119.2018.11.08.06.46.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 08 Nov 2018 06:46:58 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [Resend PATCH V5 2/10] x86/hyper-v: Add HvFlushGuestAddressList
 hypercall support
Date: Thu,  8 Nov 2018 22:46:31 +0800
Message-Id: <20181108144639.11206-2-Tianyu.Lan@microsoft.com>
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
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
 sthemmin@microsoft.com, x86@kernel.org, linux@armlinux.org.uk,
 michael.h.kelley@microsoft.com, mingo@redhat.com, jhogan@kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, bp@alien8.de,
 devel@linuxdriverproject.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, christoffer.dall@arm.com,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Hyper-V provides HvFlushGuestAddressList() hypercall to flush EPT tlb
with specified ranges. This patch is to add the hypercall support.

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change sincd v4:
       - Expose function hyperv_fill_flush_guest_mapping_list()
       out of hyperv file
       - Adjust parameter of hyperv_flush_guest_mapping_range()

Change since v2:
      Fix some coding style issues
        - Move HV_MAX_FLUSH_PAGES and HV_MAX_FLUSH_REP_COUNT to
	hyperv-tlfs.h.
	- Calculate HV_MAX_FLUSH_REP_COUNT in the macro definition
	- Use HV_MAX_FLUSH_REP_COUNT to define length of gpa_list in
	struct hv_guest_mapping_flush_list.

Change since v1:
       Add hyperv tlb flush struct to avoid use kvm tlb flush struct
in the hyperv file.
---
 arch/x86/hyperv/nested.c           | 79 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h | 32 +++++++++++++++
 arch/x86/include/asm/mshyperv.h    | 15 ++++++++
 3 files changed, 126 insertions(+)

diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index b8e60cc50461..3d0f31e46954 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -7,6 +7,7 @@
  *
  * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
  */
+#define pr_fmt(fmt)  "Hyper-V: " fmt
 
 
 #include <linux/types.h>
@@ -54,3 +55,81 @@ int hyperv_flush_guest_mapping(u64 as)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping);
+
+int hyperv_fill_flush_guest_mapping_list(
+		struct hv_guest_mapping_flush_list *flush,
+		u64 start_gfn, u64 pages)
+{
+	u64 cur = start_gfn;
+	u64 additional_pages;
+	int gpa_n = 0;
+
+	do {
+		/*
+		 * If flush requests exceed max flush count, go back to
+		 * flush tlbs without range.
+		 */
+		if (gpa_n >= HV_MAX_FLUSH_REP_COUNT)
+			return -ENOSPC;
+
+		additional_pages = min_t(u64, pages, HV_MAX_FLUSH_PAGES) - 1;
+
+		flush->gpa_list[gpa_n].page.additional_pages = additional_pages;
+		flush->gpa_list[gpa_n].page.largepage = false;
+		flush->gpa_list[gpa_n].page.basepfn = cur;
+
+		pages -= additional_pages + 1;
+		cur += additional_pages + 1;
+		gpa_n++;
+	} while (pages > 0);
+
+	return gpa_n;
+}
+EXPORT_SYMBOL_GPL(hyperv_fill_flush_guest_mapping_list);
+
+int hyperv_flush_guest_mapping_range(u64 as,
+		hyperv_fill_flush_list_func fill_flush_list_func, void *data)
+{
+	struct hv_guest_mapping_flush_list **flush_pcpu;
+	struct hv_guest_mapping_flush_list *flush;
+	u64 status = 0;
+	unsigned long flags;
+	int ret = -ENOTSUPP;
+	int gpa_n = 0;
+
+	if (!hv_hypercall_pg || !fill_flush_list_func)
+		goto fault;
+
+	local_irq_save(flags);
+
+	flush_pcpu = (struct hv_guest_mapping_flush_list **)
+		this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	flush = *flush_pcpu;
+	if (unlikely(!flush)) {
+		local_irq_restore(flags);
+		goto fault;
+	}
+
+	flush->address_space = as;
+	flush->flags = 0;
+
+	gpa_n = fill_flush_list_func(flush, data);
+	if (gpa_n < 0) {
+		local_irq_restore(flags);
+		goto fault;
+	}
+
+	status = hv_do_rep_hypercall(HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST,
+				     gpa_n, 0, flush, NULL);
+
+	local_irq_restore(flags);
+
+	if (!(status & HV_HYPERCALL_RESULT_MASK))
+		ret = 0;
+	else
+		ret = status;
+fault:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping_range);
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 4139f7650fe5..405a378e1c62 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -10,6 +10,7 @@
 #define _ASM_X86_HYPERV_TLFS_H
 
 #include <linux/types.h>
+#include <asm/page.h>
 
 /*
  * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent
@@ -358,6 +359,7 @@ struct hv_tsc_emulation_status {
 #define HVCALL_POST_MESSAGE			0x005c
 #define HVCALL_SIGNAL_EVENT			0x005d
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
+#define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
 
 #define HV_X64_MSR_VP_ASSIST_PAGE_ENABLE	0x00000001
 #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
@@ -757,6 +759,36 @@ struct hv_guest_mapping_flush {
 	u64 flags;
 };
 
+/*
+ *  HV_MAX_FLUSH_PAGES = "additional_pages" + 1. It's limited
+ *  by the bitwidth of "additional_pages" in union hv_gpa_page_range.
+ */
+#define HV_MAX_FLUSH_PAGES (2048)
+
+/* HvFlushGuestPhysicalAddressList hypercall */
+union hv_gpa_page_range {
+	u64 address_space;
+	struct {
+		u64 additional_pages:11;
+		u64 largepage:1;
+		u64 basepfn:52;
+	} page;
+};
+
+/*
+ * All input flush parameters should be in single page. The max flush
+ * count is equal with how many entries of union hv_gpa_page_range can
+ * be populated into the input parameter page.
+ */
+#define HV_MAX_FLUSH_REP_COUNT (PAGE_SIZE - 2 * sizeof(u64) /	\
+				sizeof(union hv_gpa_page_range))
+
+struct hv_guest_mapping_flush_list {
+	u64 address_space;
+	u64 flags;
+	union hv_gpa_page_range gpa_list[HV_MAX_FLUSH_REP_COUNT];
+};
+
 /* HvFlushVirtualAddressSpace, HvFlushVirtualAddressList hypercalls */
 struct hv_tlb_flush {
 	u64 address_space;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 0d6271cce198..fde76f66f354 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -22,6 +22,11 @@ struct ms_hyperv_info {
 
 extern struct ms_hyperv_info ms_hyperv;
 
+
+typedef int (*hyperv_fill_flush_list_func)(
+		struct hv_guest_mapping_flush_list *flush,
+		void *data);
+
 /*
  * Generate the guest ID.
  */
@@ -348,6 +353,11 @@ void set_hv_tscchange_cb(void (*cb)(void));
 void clear_hv_tscchange_cb(void);
 void hyperv_stop_tsc_emulation(void);
 int hyperv_flush_guest_mapping(u64 as);
+int hyperv_flush_guest_mapping_range(u64 as,
+		hyperv_fill_flush_list_func fill_func, void *data);
+int hyperv_fill_flush_guest_mapping_list(
+		struct hv_guest_mapping_flush_list *flush,
+		u64 start_gfn, u64 end_gfn);
 
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
@@ -370,6 +380,11 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 	return NULL;
 }
 static inline int hyperv_flush_guest_mapping(u64 as) { return -1; }
+static inline int hyperv_flush_guest_mapping_range(u64 as,
+		hyperv_fill_flush_list_func fill_func, void *data);
+{
+	return -1;
+}
 #endif /* CONFIG_HYPERV */
 
 #ifdef CONFIG_HYPERV_TSCPAGE
-- 
2.14.4

