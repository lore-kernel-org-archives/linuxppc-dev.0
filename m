Return-Path: <SRS0=/SFz=QJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E59BC282D8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:50:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C8E20857
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agQsC2Qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C8E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rxl04NsZzDqSr
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 12:50:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="agQsC2Qd"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rxTy2zNKzDqjQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2019 12:39:34 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id y126so4099830pfb.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Feb 2019 17:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=S4ftVHg5FlZ3hwaB6myWBWPeAhGqQEGBON/Y0CtAvlA=;
 b=agQsC2QdMvpn4C7uhQZI3oL3d4Tompeso7z2aiQkFncmX4JWg/uBamjV6PdFYhVR3k
 oX2uDQAPGf5vd3JMceHjWd3zOb6honNJovwJzyFsDilYk3h4kPDusmb8mZ7ZEYleqcSE
 9uBme4VReWk1RL9qbeNyI+Z8+CHg7tBC670AHNS9Ixurcy4RidGTlBfGSEeSBVskoBE4
 kDDouF+hsf/IUxkz3wWDqCor8SL1zRKNxx8sFfe0FC1ZLM9D8d8rtxmhZTbUJwEcx94e
 uAcqSt+1r9k0d5su0uGKjFvdvzQFGnPHQYuPGbaLZGAetRUCfjM2O99LcXRklvHcAi42
 iNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=S4ftVHg5FlZ3hwaB6myWBWPeAhGqQEGBON/Y0CtAvlA=;
 b=NmTB9ElCD8HYT4/NLEpO7LyNonVe4BJitTYOWxxRVaYzgxaleXN9H2LAHmBNdL+OIw
 JfXK+ZVTYR0AEJPij0fkMF84n4HZrdv2J46+kjqZgY1PskxpP6AJs7HNPmhACKwVEBp+
 JqCjfosVK6FfC1aS08+uUc+pozdKFMFiRzYjAfBrlV7qTVUWCbV0cmuutBnhQB3f6Ng6
 Rb37Xn8M23IiM0i/h/hExVAQMgGoPAqSXcyqKInW8O/m4Dpowu3jZAIsM3jXVOcZYscg
 iaym/KJjIj2dijg9vsk2UnBGBvQKBGqxqkKkB/CM3AThOzlF/2aSKY6B72JwGxf02JaC
 E1uw==
X-Gm-Message-State: AJcUukdXP/ikwWzyiQUHLvmqzwMmojXq/TSQMA6Jmtbi1IQ811+xI0Y4
 sdACqizFgHS81uZD4Tgts7U=
X-Google-Smtp-Source: ALg8bN6ijptjqFitOy96WFBZeRXgkg4rQ+4Jg8H6p266gaeKh2xdTdOvDwbEn+uVqVIuUB2t5iGdSg==
X-Received: by 2002:a62:5910:: with SMTP id n16mr41321495pfb.128.1549071572866; 
 Fri, 01 Feb 2019 17:39:32 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 17:39:32 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V2 6/10] KVM/MMU: Flush tlb directly in the
 kvm_mmu_slot_gfn_write_protect()
Date: Sat,  2 Feb 2019 09:38:22 +0800
Message-Id: <20190202013825.51261-7-Tianyu.Lan@microsoft.com>
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

This patch is to flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
when range flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d57574b49823..6b5e9bed6665 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1718,6 +1718,11 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 		write_protected |= __rmap_write_protect(kvm, rmap_head, true);
 	}
 
+	if (write_protected && kvm_available_flush_tlb_with_range()) {
+		kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
+		write_protected = false;
+	}
+
 	return write_protected;
 }
 
-- 
2.14.4

