Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBCDC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:18:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD0B207E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESb80kNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD0B207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Zj62B6vzDqcx
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 02:18:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ESb80kNi"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445ZT42Ns0zDqRY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 02:07:36 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id u9so1252625pgo.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 07:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YM3seOtHGatq4lqSEDt4Wr16opyBlW43DUEP6U3tUmw=;
 b=ESb80kNiQ9yog25hPeo9L5hKj8CkvoWsClwvZnFApBr+huWEHDWQTXqNuizJjyoiLZ
 CiXdav6OWZyQC9tqLSnqze0GiMae/oOAqV9Ud+Bd0ydew6/OsD/5XGOh4zoWPCGpyzum
 RvRhzwTNo7shXmgxFxA0oErxpGAnGACXRAIV2H/5+tE9/MOPelqqfgFQgoPkHrPGJcva
 OFNYA0CbwxPF4AS95pELF6Np+sXag6o6tqlsTWOYsfVykohWQxclNwxjcwzsbz78YRtX
 ArQsaIhAhxE+H3rU76V/GO1lQSdXD6+ZWGqrTKkUG1aU8t+bF50qLOCpSMN2Xyqn7kh1
 JrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YM3seOtHGatq4lqSEDt4Wr16opyBlW43DUEP6U3tUmw=;
 b=SnNOohJMXa4d7yIJ2nB8upQEGzpwYqTQA6uQsBFJVQVXDwSrgzQfoO1AMu2X77Z8TW
 2wfk9igTq3/yAFbEeXTBOqW/MX3romMZs7ITRIdPU5KgretJFKeIAH2i+UfrnIHdNaPI
 hNyyjSYPQ+qhbD1fsfzGC9aB+fpRkZUakXem4S3C2T9A0io+l16U7IZ+lnAiUCeYmDb/
 R/vi7LCZYN9j1edHOgQ5Sv+tct4vbcQDYQVKCobC13Yg+STmiPYj8LojddoMD4UUbPjx
 d1jAPKazlRBQZqIeAOqA+hWqAudY63e8zxo1azwouITyR3qgdN1n8u7aLeznA6JVrqPp
 r0fA==
X-Gm-Message-State: AHQUAuY9j6+0meo0tl0+kB6KQymBhhtowFudwDP0QKf9CHAPoR8a8u3d
 vknI+99+697PTLSrAWl9BlA=
X-Google-Smtp-Source: AHgI3IZ4Yi0roB+29f2OCEvwvH3n/OYYmCvsm0Fts14g6RKRhp0fOWP4XzYAgutWF3KiQlBf5I9nbw==
X-Received: by 2002:a62:48c1:: with SMTP id q62mr4660304pfi.113.1550848054699; 
 Fri, 22 Feb 2019 07:07:34 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:07:33 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V3 5/10] KVM/MMU: Flush tlb directly in the
 kvm_mmu_slot_gfn_write_protect()
Date: Fri, 22 Feb 2019 23:06:32 +0800
Message-Id: <20190222150637.2337-6-Tianyu.Lan@microsoft.com>
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

This patch is to flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
when range flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 7a862c56b954..60b1771e400e 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1729,6 +1729,11 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
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

