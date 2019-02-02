Return-Path: <SRS0=/SFz=QJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101BDC282D8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:42:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8065C20857
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWgc/n0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8065C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rxYY4FwszDqkG
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 12:42:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="sWgc/n0w"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rxTD15PbzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2019 12:38:56 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id w73so4081467pfk.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Feb 2019 17:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Q/TrOrVhLXlgdKs/anicFSIumLYNrR3S6ily0jTwiFk=;
 b=sWgc/n0wioZ0QPyR2/TMQhWMn+EcQ4V9TLtHHpF6yUVU5eoSZFrKAXwnHKFduWuNGy
 bhdPbUncbK4hPYBXcGL6hac5877pETaapnUHwEFWCyic4Q1LtZg5eNnY9JvnC2wjdQ35
 NEc0YoMNf7cg7l8zHMGYXw6yDYSX96DJXYcin/1oF9pZBzV0D01BxgoUARYPA4S78Wys
 T6fs8GyRnxh04MBB2iQB1cXVv6z2RCeJs2+5yyTZ/dj09bGrg/0WmsW3EkSbSmkrvHE9
 l5oVFt51S01XR3mDQMHo5uDS3NeUdcWXKZrX3iNjg8/oWnwLaMugDW9zPsZJSTTeEfTm
 mO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Q/TrOrVhLXlgdKs/anicFSIumLYNrR3S6ily0jTwiFk=;
 b=ZlFk5v7MtaL0ph75EO1gU3y7/F0rtNIkDznuXSk0SxR61kAlAmL6Pkv0TCYXMze13T
 h/31abf8n9urp6P9fh8yilFEHJW3Ljca/2AUZ871v3tpvMJrjWpWQGjeWMN8yZxywTEK
 IPaHsy4JozJogGbMFTbTGCWPHZJS0gOGhrtVO4RX9GZBl/xxiid3mJVGMzxBNowVKPqp
 h2V9rDz1uR6SOwma72mnNJnxk+5GtcoxP6c5WaevxBcgydxqDkwgk8gQMP9zLQp5//Ph
 CAR5znqL6gVSap6PxSWFba8setUU8uj5x6sFYXVr5AYy1nIBwJZRmPx6DgM1N93IEWU6
 J7og==
X-Gm-Message-State: AHQUAua/qJDgcmDSA0DVivvn/0IaxWmTTsHry8k+Xw8t2sxghRafr48N
 CkYrA6/WQxHZ1IeJkSHpOyE=
X-Google-Smtp-Source: AHgI3IZQrPjBo3eUg0JRfhqVrGX+BuDiIBD5aJn/dNJwX/tBweo7Rr0ue0lfwQapg8+KOo95O3mC9w==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr4549552pgh.265.1549071534414; 
 Fri, 01 Feb 2019 17:38:54 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.38.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 17:38:53 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V2 1/10] X86/Hyper-V: Add parameter offset for
 hyperv_fill_flush_guest_mapping_list()
Date: Sat,  2 Feb 2019 09:38:17 +0800
Message-Id: <20190202013825.51261-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
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
index f6915f10e584..9d954b4adce3 100644
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

