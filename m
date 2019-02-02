Return-Path: <SRS0=/SFz=QJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9864BC282D8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:45:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B6520857
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKl4t9Ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B6520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rxd86CTrzDqjH
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 12:45:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JKl4t9Ss"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rxTW2YJDzDqRf
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2019 12:39:11 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id h3so4109754pfg.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Feb 2019 17:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QkCKWdNQDd7n0mb8dlG6t1culFOMAQghK/Ej0OwX5M0=;
 b=JKl4t9SsRWFQRqm/2ykkdDbszCjiZIyL9GEDu1emOACGiirfjKR4PU2Y1yFEaeqHLe
 4Gg4rW7yrPMnpiI0rSIwiM8z2uBBUK/Ol8t+l1N1VxwoceQdtJBxJeNkd4oXCXGX81Ln
 /mA+Fi7RDYkiSi5AJlTWoN2SUEgpHbUuXQrcQbSmKlwxk2aHCImQkJLlezWkOovxwH/r
 pdVkbF/4t7THhVIvbGyuKG1ZlsttuJYikvG2qecvpaGfUuC9O3QNWZVxRbeg1svaAD8C
 EQJQrmp2Uw8Htj/sc9HDeAQO0XwYAHiepwQfXGOUnd4F6iyTf9QGL+LEgTPPwhG6DHWC
 qGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QkCKWdNQDd7n0mb8dlG6t1culFOMAQghK/Ej0OwX5M0=;
 b=CbSdOQp3DQ7sC130cFfgdzdsvpZHAPdDinoec253R37WSA0TERngL3Fjt0H7hCseSK
 aT21HWxU8E+bl3tIjqe1XacECuy8iDFVDcdwx209CULMRVJsOtV+PT5rkzThXsJopjFs
 PkZ2kh3/PdYQPSxw2C9P259vb0Cnyebms3I3nWSmAEstMAP8cDp4aVtMAEW6CDqtxtzc
 Rql27bsyLq2OEZ6b2jxdxgFbvqPhIq/1B+4J3vdoJVOnsFGbUcqOQK0W1VH6iPecSzV4
 uKNofgaSjh7FsfMt+380zrtb4/UBPUIvtntn6HIr9aYfZGdRChsyausLomPilnD9KFOf
 Irww==
X-Gm-Message-State: AHQUAuZF8Q208DXCsyAWnSN+uMtvQE0VR7nt5zsnDsRn6K83uLcyVCXs
 VTWPeJGJrEWgYEdvZMsraGg=
X-Google-Smtp-Source: AHgI3IYtiYj+YWXlKinAagZU+CzzWQGsIguvJwkSw/9h/aC/bdhFYr+TlIVLI3IuHned8yzL8VgVKw==
X-Received: by 2002:a65:6542:: with SMTP id a2mr4544721pgw.389.1549071549793; 
 Fri, 01 Feb 2019 17:39:09 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 17:39:09 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V2 3/10] KVM/MMU: Add last_level in the struct mmu_spte_page
Date: Sat,  2 Feb 2019 09:38:19 +0800
Message-Id: <20190202013825.51261-4-Tianyu.Lan@microsoft.com>
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

This patch is to add last_level in the struct kvm_mmu_page. When build
flush tlb range list, last_level will be used to identify whehter the
page should be added into list.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/mmu.c              | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4a3d3e58fe0a..9d858d68c17a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -325,6 +325,7 @@ struct kvm_mmu_page {
 	struct hlist_node flush_link;
 	struct hlist_node hash_link;
 	bool unsync;
+	bool last_level;
 
 	/*
 	 * The following two entries are used to key the shadow page in the
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index ce770b446238..70cafd3f95ab 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2918,6 +2918,9 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 
 	if (level > PT_PAGE_TABLE_LEVEL)
 		spte |= PT_PAGE_SIZE_MASK;
+
+	sp->last_level = is_last_spte(spte, level);
+
 	if (tdp_enabled)
 		spte |= kvm_x86_ops->get_mt_mask(vcpu, gfn,
 			kvm_is_mmio_pfn(pfn));
-- 
2.14.4

