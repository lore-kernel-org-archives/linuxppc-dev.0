Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA3FC43612
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:07:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1703E2184B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bERgKUKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1703E2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WJpK24ZRzDqRY
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 20:07:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bERgKUKu"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WJX21P22zDqGC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 19:55:14 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id h3so18009454pfg.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 00:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3CQvyPlxafLLMYYmnidZXL6MopPPAyOd1R4OKDK3Tg8=;
 b=bERgKUKu51PAzYg3Rrzv52DBjdnCcfNkUuGl0QEWhiWj6W0MmP1KserqG3gw+V0uOz
 717BaRsb17KQy9DlLpRwN73NDF+JlNIwIa6Vtid3Wn7/unsJsMpEWzLVhDoWsO+jPqBK
 CXzhbDQK4O0iY5rU0gimk9NZuMJOLue/IM7psgZOst2rkKV6QjkUQ+xy9R5CHlRtE0yf
 6eYDVGquJEt/gVb0OBEtL7uwYx/NIUXuq7ZJAts2E7VLsvPLZYf9o1OEXSsCvqx1R+Fm
 FOz/j9UPfBj3duCoLjjODwHV5/2+j1i4jVT/zc46j+B8Sqj4H5cNFpIum3Jq9ABDTfbu
 UfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3CQvyPlxafLLMYYmnidZXL6MopPPAyOd1R4OKDK3Tg8=;
 b=Acs1KrcQskbDs6hONFcDMVFPOk2tqCOsN7KcN/Bae8g34VMvNsr+GGsv27kGdxO1gk
 1tWWYjhc7c6cAKPlSrEDteZP/eboRCaV5OKLcYaRCNueAr2QbhOb0waiSFPqHAwdtq7/
 nJt2H9fXCnm0PFQhHkrGfiI0PSyNDxlWabRHZwR1zPL9XlhX7bQqJ9nYbkcGydZ/XHQG
 MWicsgwKDjZNZ0A6Sd/xPsQ6yftX38Ggk7IjrHdhEGI/1r8yyPrdradhoSOhK3to5t/3
 Ti73v2985e6phsYr7hI4/ibXrafPUB4F5klw5A2P5oaENYwJ1QiHjd1LmG40s9/zNdlv
 ugPw==
X-Gm-Message-State: AJcUukcXiBt9U4CfexXuxnSFUvde6mwGjw9qp7h698QNle0AUl8Z/64m
 Kqh81/GcV7o1uFslyXwpvSA=
X-Google-Smtp-Source: ALg8bN52JNWJUY4wd3KWz56nhScCreos1hBMy4NTN0TRzwOHpvOyEaRyBz6+s+XGkePV/idoh2nHEQ==
X-Received: by 2002:a63:557:: with SMTP id 84mr19472589pgf.411.1546592112418; 
 Fri, 04 Jan 2019 00:55:12 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.55.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:55:11 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 7/11] KVM: Remove redundant check in the
 kvm_get_dirty_log_protect()
Date: Fri,  4 Jan 2019 16:54:01 +0800
Message-Id: <20190104085405.40356-8-Tianyu.Lan@microsoft.com>
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

The dirty bits have already been checked in the previous check of
"dirty_bitmap" and mask must be non-zero value at this point.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 virt/kvm/kvm_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf7cc0554094..e75dbb15fd09 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1206,11 +1206,9 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 			mask = xchg(&dirty_bitmap[i], 0);
 			dirty_bitmap_buffer[i] = mask;
 
-			if (mask) {
-				offset = i * BITS_PER_LONG;
-				kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
-									offset, mask);
-			}
+			offset = i * BITS_PER_LONG;
+			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
+								offset, mask);
 		}
 		spin_unlock(&kvm->mmu_lock);
 	}
-- 
2.14.4

