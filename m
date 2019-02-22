Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09315C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:11:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A72820657
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIyl/DXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A72820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445ZY14nrLzDqY6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 02:11:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bIyl/DXX"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445ZST1TM3zDqVq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 02:07:05 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id d15so1240670plr.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 07:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XOGqMApv5NREZBijyNBtk5Mq8chNh80zkhgEbpmMbVY=;
 b=bIyl/DXXoGgQ4YrmVh1iadO3QT3Swk9cSFXEkSmL/zgA6U5uSOK3j/JZSbs9Qtn+qa
 S0pmsqlkUsMp0oIEQ+Pt4CQ6Q3Cd/sKIFlYfcMIRRXe+Cq8f4I/9jlvjiaYi5WqcZmHz
 wJCQqz6u1iv0Ns7GKuH2nmuhofoUU1g88ZohSdRaH4x+ZQyljcbTpY2SiHBhskEuCmFb
 IDqMu8v+TxxqQch73KOvnX7gyDpvry5EPBWhnMOQXwm9mRacBeSzxaj1q1DLUaayBKEU
 4BCaeriqTYrulXkLn9cB1HowchpJzY6P4U6kyBnvCTvp3xXgSi/GPRYdMXQqbQBNxiRb
 CXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XOGqMApv5NREZBijyNBtk5Mq8chNh80zkhgEbpmMbVY=;
 b=McLwo2uPi5/oCrb+Qs3+au8CyjpyYVhrOx8Pn6BMoidZbx1hLI788f2m/0a0hpAoO8
 lyRMl+f9JQXG+6dWd9SlNb0tJr+yXIe2IDkt2gHqb3neXditIZga/Sz3q7LgfMVP38Xt
 khDSXrm0c1K8OIVF2zl9pcAOzfysoH0QS5MBDBq2VCMBHiuJ82xRqIX+7F7w5BlAQdUF
 oO3GcCvGanPXumJO5FJDHq5De1iQoq/CsZu/Xg8Y/bCZUEYBRdBXywbAo1lJ0X9jZ/lo
 A2lknsCHgnjBhYdPkQTSXekE7dj9jHqzTJdHqp7hM32KRsjqOu7vYW9zWc0BLiluqDWR
 W+1g==
X-Gm-Message-State: AHQUAuY8A+aCss6gAMNnnOr0hIAvW4axFaRJqHGogOHm0cvo3UOpURXX
 zCJ9JaUW4r0bb34ZyA0KGJA=
X-Google-Smtp-Source: AHgI3IZnxTMvvgIxIDjzAuWz/HznH+k+Vt2jo6Sat5I/rRyjGjsyeBvU0wvI0UHS3T9mvcSEjBCnPA==
X-Received: by 2002:a17:902:724c:: with SMTP id
 c12mr4652130pll.110.1550848023631; 
 Fri, 22 Feb 2019 07:07:03 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.06.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:07:02 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V3 1/10] X86/Hyper-V: Add parameter offset for
 hyperv_fill_flush_guest_mapping_list()
Date: Fri, 22 Feb 2019 23:06:28 +0800
Message-Id: <20190222150637.2337-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
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
 will.deacon@arm.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
 kys@microsoft.com, kvmarm@lists.cs.columbia.edu, sashal@kernel.org,
 sthemmin@microsoft.com, x86@kernel.org, linux@armlinux.org.uk,
 michael.h.kelley@microsoft.com, mingo@redhat.com, jhogan@kernel.org,
 linux-mips@vger.kernel.org, Lan Tianyu <Tianyu.Lan@microsoft.com>,
 marc.zyngier@arm.com, haiyangz@microsoft.com, kvm-ppc@vger.kernel.org,
 bp@alien8.de, devel@linuxdriverproject.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, christoffer.dall@arm.com,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Add parameter offset to specify start position to add flush ranges in
guest address list of struct hv_guest_mapping_flush_list.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/nested.c        | 4 ++--
 arch/x86/include/asm/mshyperv.h | 2 +-
 arch/x86/kvm/vmx/vmx.c          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index dd0a843f766d..96f8bac7476d 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -58,11 +58,11 @@ EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping);
 
 int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
-		u64 start_gfn, u64 pages)
+		int offset, u64 start_gfn, u64 pages)
 {
 	u64 cur = start_gfn;
 	u64 additional_pages;
-	int gpa_n = 0;
+	int gpa_n = offset;
 
 	do {
 		/*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index cc60e617931c..d6be685ab6b0 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -357,7 +357,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
 		hyperv_fill_flush_list_func fill_func, void *data);
 int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
-		u64 start_gfn, u64 end_gfn);
+		int offset, u64 start_gfn, u64 end_gfn);
 
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4950bb20e06a..77b5379e3655 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -433,7 +433,7 @@ static int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush
 {
 	struct kvm_tlb_range *range = data;
 
-	return hyperv_fill_flush_guest_mapping_list(flush, range->start_gfn,
+	return hyperv_fill_flush_guest_mapping_list(flush, 0, range->start_gfn,
 			range->pages);
 }
 
-- 
2.14.4

