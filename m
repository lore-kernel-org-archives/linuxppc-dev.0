Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43760C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:16:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E03207E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFEDariz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E03207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445ZgG1VdbzDqcM
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 02:16:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VFEDariz"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445ZSx04nFzDqW9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 02:07:28 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id m1so1249363pgq.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 07:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HSIeB4k5ZuogmL6MUD/u+Ar8YyEEuP4vsoidGitcBOo=;
 b=VFEDarizmQAexjrnIXw10DNn/NEU/q3swR8bwAjLeGeWR5tr50z2EvERNhdjvyBtb4
 VqcDze6oJyEG2pknFT+FiETqiVnE0DZHnLwja3h0uY8qOOjM21+Dp6SLpG/BC3cE4h81
 SF/psiWa1QApresuj0e8ND3u+47m/GWHAnUBUNUC7nvhjODQgJkjJ6VL5W9Z5qzpBEql
 aj+3/jBXo1eCh94oYlGSFb8sc69YJn3TYkh/EmPjUsk5AMD6kLLfgTmUnd3sAw1vBVnr
 hJaY7uoZAfxkdaMxF06564Gne0Mr7a2eQI5ZiDFFUQvgZkp3OVmUBVZyCVYSG/kRWDXN
 qDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HSIeB4k5ZuogmL6MUD/u+Ar8YyEEuP4vsoidGitcBOo=;
 b=iLPFXaNYcaFfT79bOAVH5Nej8oKpEDMhdhrsuuBauRGQapbHGlsv73nI/o8Ecb/LIU
 mLodTXvDm+8h1wP/NOwEA57dPrjMdrOxtq56NuOCLvUW9EgrG4185FzPBxKipS0cNX3L
 r56Sj9pcPMWW2wirumR+w4CGDeQ/Fh8yqQB3lLv2axvtxvsM4htmGI7216MQyi48qWRY
 LHwUr8t9/fB9qSDMAHBkPS5JSpz8fas/IbDrf8/0KaiEM+kQuZvdTSqtkuZGp/iLQxjb
 hOMviiCiomeTraskGO1XzvHgeq083Z2B4qZgUOSo2Mu9eptvB4+C4YJ54fUizMMfxxfn
 G+lg==
X-Gm-Message-State: AHQUAuY5NtCJ/a7NlnTAxbe8KKFFAhhWNLBxscL9OrF5YU9ggUeGW60q
 rF1KyotNOMU+MYmRfY9qH0Q=
X-Google-Smtp-Source: AHgI3IYeKFBy5DfEgi7+NoEfVT1WeWulgurOSdqM73OPfGXKYCvFjRfn6bTV8zsuwtVzgFf4mlVMaQ==
X-Received: by 2002:a63:2ccb:: with SMTP id s194mr4379235pgs.214.1550848047046; 
 Fri, 22 Feb 2019 07:07:27 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:07:26 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V3 4/10] KVM/MMU: Use range flush in sync_page()
Date: Fri, 22 Feb 2019 23:06:31 +0800
Message-Id: <20190222150637.2337-5-Tianyu.Lan@microsoft.com>
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

This patch is to use range flush to flush tlbs of input struct
kvm_mmu_page in the sync_page(). If range flush is not available,
kvm_flush_remote_tlbs_with_address() will call kvm_flush_remote_tlbs().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/paging_tmpl.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 6bdca39829bc..768c5c64e3f8 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -1033,8 +1033,9 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 					 true, false, host_writable);
 	}
 
-	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
-		kvm_flush_remote_tlbs(vcpu->kvm);
+
+	kvm_flush_remote_tlbs_with_address(vcpu->kvm, sp->gfn,
+			KVM_PAGES_PER_HPAGE(sp->role.level + 1));
 
 	return nr_present;
 }
-- 
2.14.4

