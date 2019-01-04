Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F03C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 08:58:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732132184B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 08:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdMxIz2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732132184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WJbb2YgwzDqLs
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 19:58:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bdMxIz2g"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WJW91PztzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 19:54:29 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id b5so17162702plr.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 00:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=i8dTC8urZcLwzyeR/Vu4fyO0uZy0FNHekKBQ29Y6YMc=;
 b=bdMxIz2guzLdRdqjth6wjnjPZpbVIL8eDJoyDtFD6lpVDG7+fysF4tr92TwaeGD1UJ
 qRmQlP4GDRzHhqiUly7mOgKQGoRufG5jOxCQprD7BlFuSMnoSILnCdYWNYs+6Ifx/Sln
 BGPnkmqSEvmUauOGa4FkchQZedbLOMT0dOl6y1mzlvMOjHfyYIKmxF2lovPJcLAPFIyg
 gILasOp6WzoJ3XwF459ntkbpt1eusiDJxR2P1Wx8GAlWuPYMWPGZ7tqoeLUStKpgHcy+
 lM5Z8J2RLqWHa11em3HaSKFHjEgz+xGNaSjMe9S5fSyqT57yTB128mxRtrlcPWt36UEC
 q27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=i8dTC8urZcLwzyeR/Vu4fyO0uZy0FNHekKBQ29Y6YMc=;
 b=rF9zmC1nSjSmrs0+i/d1+vAFGu1ej1bSI1PU41ZOCnPlEHBF5Q14pj65Eegb+2uzuj
 9Sk3yYuNhnPfidg8cA8104BnNtMBUbYN0yT8xgRV0jkkYiv08G5Tz14hiLaINRihoakw
 ImSAK1ddtGPu5dPXZ91Ib6MLyQ/+kN9pGg7mQI3IulSrG0YujeG75Zptw8vOrslugqVm
 aVuwOXSbjYTOSV8Pzisx7Fs1U1722YK/H7Y/vOpcLzoigrpGHkiB4PujFwsHsaZWxuiW
 dhdCgKngo1LIrxxviuol0MJgtPE7GvtE1SwQz4PvRzLVn9NLSX2wPmdEK14U9xP2fUdI
 HafA==
X-Gm-Message-State: AJcUukdk3sXO/OLlLaWW12mIy7OO23iF4PsuJ1hbu1Wd/jDFAbkWrrCQ
 iHe4eM8FaJ18932BBrFy6AA=
X-Google-Smtp-Source: ALg8bN7Hd/i8EVRwXrchiQNQpGOa141b9ceEW8y8b4HLeNCBSzMideSbEpZ9osZHG5VKjOcZ5XywAA==
X-Received: by 2002:a17:902:59c8:: with SMTP id
 d8mr50066601plj.116.1546592067395; 
 Fri, 04 Jan 2019 00:54:27 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:54:26 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 1/11] X86/Hyper-V: Add parameter offset for
 hyperv_fill_flush_guest_mapping_list()
Date: Fri,  4 Jan 2019 16:53:55 +0800
Message-Id: <20190104085405.40356-2-Tianyu.Lan@microsoft.com>
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
 will.deacon@arm.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
 kys@microsoft.com, kvmarm@lists.cs.columbia.edu, sthemmin@microsoft.com,
 x86@kernel.org, linux@armlinux.org.uk, michael.h.kelley@microsoft.com,
 mingo@redhat.com, jhogan@kernel.org, linux-mips@vger.kernel.org,
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
index 87224e4c2fd9..2c159efedc40 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -428,7 +428,7 @@ int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush,
 {
 	struct kvm_tlb_range *range = data;
 
-	return hyperv_fill_flush_guest_mapping_list(flush, range->start_gfn,
+	return hyperv_fill_flush_guest_mapping_list(flush, 0, range->start_gfn,
 			range->pages);
 }
 
-- 
2.14.4

