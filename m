Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D9FC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 08:59:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7449B2184B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 08:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfoGxhg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7449B2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WJdH3czWzDqMN
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 19:59:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UfoGxhg+"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WJWJ3jX3zDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 19:54:36 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id y1so17147515plp.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 00:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3xvjZ/wjhJvQ+EiSQdkuRkphovQlZ1pkKAij+DudaK0=;
 b=UfoGxhg+Hd437kHWcocOKD4R7AEnDRlzv3+9E9HJw9uGV7/pvCZrMR6ZoCK0BaqvmA
 77Mu3LTWe655ERI5Dx3fl4LFYedAvptTqCeFZZV9fkMKJGpW12xQcbXlTMWvnlaPeKtD
 1+xxgO+uhbCznYh4qlV1zGwrCM9GFUEipbnIkCZPi04bRrGL2ONf/Z9HO1fHrvkWEmJ0
 FD46PfpqMUag74dDDGZGWKMOsdJlPqLQM/KOrNyNNZjhHBQPqSwWFxJirOueeWMCLZn/
 xbs/7qlpNmF0vIj9CJjAubmh84omLHTWBxD1AhGu4ws7s4c0KGWR/JFEk5A2OpbMg3oa
 x9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3xvjZ/wjhJvQ+EiSQdkuRkphovQlZ1pkKAij+DudaK0=;
 b=nzApuaxsLgqT6Yu0DYp1A46kt0BLSfavH6cShOC1+QjIZIaKrkLivOb3M3pXW4XI4P
 xoIe7tfA6Be4R/dZp88VDSycSE4fbXezDSpTz3XtZfp0RJ3nwMiiFZdZ8l2chVkhpbgO
 t26uX5WLslmrUW7+hNWwUVCEubm+y8Y5NAgWn/5XqT7TgxnkWnCA1NCYpO6UZWXXhpR/
 w81f159seBXpmfu/rx2zJfmn6pU2v6t53W0OtWGIKh7kFurZFU8os2AmHQeKHFTknEfP
 8D3KLDqlzk0rqM5tCEeEsHJ+YBkH7tyu8PfEIuMl5rmL81pMtlAMA3fqimJCwzeqcWxc
 DtYQ==
X-Gm-Message-State: AJcUukdqLps4vDEve51ZzjSdeSsJXyX1H4mwByIPFQVzzj4yvweM938Z
 qu2A4paKBplQREAcvIhiA4M=
X-Google-Smtp-Source: ALg8bN5WGbG/X0YfKxi+O0qWupEnRFREachjWFJDxbXTB00aKKZLPgBmf4DoRkBwMh4mrFM0l5hDCw==
X-Received: by 2002:a17:902:6b87:: with SMTP id
 p7mr50903905plk.282.1546592074861; 
 Fri, 04 Jan 2019 00:54:34 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:54:34 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 2/11] KVM/VMX: Fill range list in kvm_fill_hv_flush_list_func()
Date: Fri,  4 Jan 2019 16:53:56 +0800
Message-Id: <20190104085405.40356-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
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
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, catalin.marinas@arm.com,
 will.deacon@arm.com, christoffer.dall@arm.com, hpa@zytor.com,
 kys@microsoft.com, kvmarm@lists.cs.columbia.edu, x86@kernel.org,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com, mingo@redhat.com,
 jhogan@kernel.org, linux-mips@vger.kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Populate ranges on the flush list into struct hv_guest_mapping_flush_list
when flush list is available in the struct kvm_tlb_range.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/vmx/vmx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2c159efedc40..384f4782afba 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -427,9 +427,23 @@ int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush,
 		void *data)
 {
 	struct kvm_tlb_range *range = data;
+	struct kvm_mmu_page *sp;
 
-	return hyperv_fill_flush_guest_mapping_list(flush, 0, range->start_gfn,
-			range->pages);
+	if (!range->flush_list) {
+		return hyperv_fill_flush_guest_mapping_list(flush,
+			0, range->start_gfn, range->pages);
+	} else {
+		int offset = 0;
+
+		list_for_each_entry(sp, range->flush_list, flush_link) {
+			int pages = KVM_PAGES_PER_HPAGE(sp->role.level);
+
+			offset = hyperv_fill_flush_guest_mapping_list(flush,
+					offset, sp->gfn, pages);
+		}
+
+		return offset;
+	}
 }
 
 static inline int __hv_remote_flush_tlb_with_range(struct kvm *kvm,
-- 
2.14.4

