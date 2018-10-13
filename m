Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD9BC6787C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 05:57:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20F420835
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 05:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rp6f8txF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20F420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XrTD6nnFzF3By
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 16:57:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rp6f8txF";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rp6f8txF"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XSQw29TNzF3DW
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 01:54:32 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id s4-v6so7282288plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 07:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=px0gV+gBnpOH60iOcTCGqmbUjehg++DRdbAxzx/hWFA=;
 b=rp6f8txFq2Z++vvFYXV5hUS6IcLak/IyxBJWHXWM8AkS6KURSFVAfxx/YE97efIsUU
 E4e/KL8csquVEaxBw0R1BoISOtQsd75AZA16eXP5lGPyMZZxTDY94QRtVOd9z8gB+BGz
 EyyW4yykMzbdZnZ0H78W4ERR3OJ+/BR8mDkbAw89wA4dlzgDzcDqopu7pUYAGrfWcCvd
 nwDcS3oU1IPTjODCkh8Q1L6F4qsiz8g5B8mROcu6prFhM2YZP6/b8phF8BgMKTw+LKgf
 2oxwPYzgHQER/la4dzJ2wKp21z2Nx7HtMZdVuZl42f8NzQV9qo+aq6M+MgYi1fijdt/y
 cMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=px0gV+gBnpOH60iOcTCGqmbUjehg++DRdbAxzx/hWFA=;
 b=pY508ygfXF+HbbgSwZFUklQoDej6acDcOlFZ8nFXV10WM1iv8fXeANWVdHJkBhEMxF
 H0BQqAT0vVzzAFf46WTU+9KKCroftHDQ966vC2eBZ9KQOlMKmocQWKjzjhFyMBAmIaVT
 C8G1OuCskteuNZGCQZ1oiR/UQMCWhysr+TlY2fAX6wlSNLs+VT9dCQ8grVpscoh4V8cN
 q3MK3jzr4wvkPj6Xk3z2tyHa9EeJtyJdz2ed8Wrk+aUQQgbaAtNYMOkhIB3kyXreXpUp
 X9dPGEi+ZMOc+kMDIV6xeBcRmtNGuVCsxFm5phTA32ztoGrJzrsq4ACJNPaoSYdaAJiW
 68GA==
X-Gm-Message-State: ABuFfogqIqmwxCujmSZB56hkBW64AvDLecPxqFJjP93wVuMPnDxTekNJ
 hpGmakO1y56CO9SmU+19UwA=
X-Google-Smtp-Source: ACcGV62HWs3gWO94ingYjrTNOd2X4hqsmsPW7d3NRYDQAgfnfqDU4fT7925KW4ssd+32230A+ZzFJA==
X-Received: by 2002:a17:902:2825:: with SMTP id
 e34-v6mr1226708plb.244.1539442470478; 
 Sat, 13 Oct 2018 07:54:30 -0700 (PDT)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id
 v81-v6sm8688724pfj.25.2018.10.13.07.54.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 13 Oct 2018 07:54:29 -0700 (PDT)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V4 1/15] KVM: Add tlb_remote_flush_with_range callback in
 kvm_x86_ops
Date: Sat, 13 Oct 2018 22:53:52 +0800
Message-Id: <20181013145406.4911-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
X-Mailman-Approved-At: Sun, 14 Oct 2018 16:51:35 +1100
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
Cc: linux-mips@linux-mips.org, linux@armlinux.org, kvm@vger.kernel.org,
 rkrcmar@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, hpa@zytor.com, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, sthemmin@microsoft.com, x86@kernel.org,
 michael.h.kelley@microsoft.com, mingo@redhat.com, jhogan@kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, devel@linuxdriverproject.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 christoffer.dall@arm.com, ralf@linux-mips.org, paul.burton@mips.com,
 pbonzini@redhat.com, vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Add flush range call back in the kvm_x86_ops and platform can use it
to register its associated function. The parameter "kvm_tlb_range"
accepts a single range and flush list which contains a list of ranges.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Change "end_gfn" to "pages" to aviod confusion as to whether
"end_gfn" is inclusive or exlusive.
---
 arch/x86/include/asm/kvm_host.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4b09d4aa9bf4..fea95aa77319 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -439,6 +439,12 @@ struct kvm_mmu {
 	u64 pdptrs[4]; /* pae */
 };
 
+struct kvm_tlb_range {
+	u64 start_gfn;
+	u64 pages;
+	struct list_head *flush_list;
+};
+
 enum pmc_type {
 	KVM_PMC_GP = 0,
 	KVM_PMC_FIXED,
@@ -1039,6 +1045,8 @@ struct kvm_x86_ops {
 
 	void (*tlb_flush)(struct kvm_vcpu *vcpu, bool invalidate_gpa);
 	int  (*tlb_remote_flush)(struct kvm *kvm);
+	int  (*tlb_remote_flush_with_range)(struct kvm *kvm,
+			struct kvm_tlb_range *range);
 
 	/*
 	 * Flush any TLB entries associated with the given GVA.
-- 
2.14.4

