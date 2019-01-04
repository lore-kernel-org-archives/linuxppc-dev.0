Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86716C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:04:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000992184B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW2Ji7XB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000992184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WJkl0j8xzDqKX
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 20:04:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OW2Ji7XB"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WJWl11lbzDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 19:54:58 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id b85so18003871pfc.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 00:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lVVdEslgom8hND2ea3FWWDCI/x9Q6uJ8jZfIIsF2DSM=;
 b=OW2Ji7XBSYB1+gGPVjstYoLKPTzQ1AmfMKSKOstz5QdPudY86VQ380UUUsnf/zGmVM
 xn6Mh0pYG3xrcy20WnDqchjHf0s2vor5WP0jYSxpDbJWJjbYB3QmqZJ0fwIHRl8AAQNK
 lxbecV+o95hItU6JP7PaPD8X3TJPHKx2mAM6ZTHdq6sV5V9Krp4xs8TdoVqrAT8V0Xt9
 X9+ykYR1/2wD4+G1Z4KIV0Ml1JTrhu5uudJqftY/TkXmydDiAMUHPf4qFOrUwiy9y1Gm
 C8XClO7UzUvFQDxjE0HxdBZXHppJjVWt0tiZIPFJ3583Ah2FqOq6EH1oP+MPBMLn9PvU
 zBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lVVdEslgom8hND2ea3FWWDCI/x9Q6uJ8jZfIIsF2DSM=;
 b=GNk86n3vOcthdbWsWbbtYEf4vxQF/GCWKCUSAXcyr+p3IH91m9IbYSZq+qUoecAO3G
 0XVvD1DsE+N5FKS95b2YxdMcqmHNbaeOp5BM8+nRBAMRA90ewvba6Mq1amUPgSiRyHzr
 1Pke/vsqI+MDuE0sHYHhjYe7l5X+0DHOI6ykQOZui9b8kphlKB4mXhFvRrFklR7+Sbk/
 XqtIqYjt3wFGzA5AZ+3ui1QNrnoxiI0tdAt6C3KxHeTE3Qy1ljxTb7ctA7pRwYV5LFFg
 RNWYcoLLeNPA/gMA0eoCr5zRn5OIB+voFjOZC9Z1VfbFZ8uNDmAbzJnE08rcp/d4wuXP
 OIfQ==
X-Gm-Message-State: AA+aEWbBRKxKmHkuQ081zh4ZfbiWkoAGXwaPHbq2xYDHGXA/Kry7O+jC
 8T41x3gk0xOGVHHvAJR6Y1U=
X-Google-Smtp-Source: ALg8bN6Kuw2ITWSZOeeG0JAVP4GO5UzPiaRW5tnwjEiTZXlCq7w6q2DQ3Tfsj+QkVgS7pj1Cmr9+qg==
X-Received: by 2002:a62:56c7:: with SMTP id h68mr53695204pfj.134.1546592097417; 
 Fri, 04 Jan 2019 00:54:57 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:54:56 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 5/11] KVM/MMU: Flush tlb directly in the
 kvm_mmu_slot_gfn_write_protect()
Date: Fri,  4 Jan 2019 16:53:59 +0800
Message-Id: <20190104085405.40356-6-Tianyu.Lan@microsoft.com>
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

This patch is to flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
when range flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d3272c5066ea..6d4f7dfeaa57 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1715,6 +1715,11 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
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

