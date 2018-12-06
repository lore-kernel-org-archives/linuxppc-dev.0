Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD45AC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 13:37:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281D420878
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 13:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tlnp9BJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281D420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439c8x06c8zDr5N
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 00:37:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tlnp9BJS";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tlnp9BJS"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439bq46hZ9zDr9C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 00:21:52 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id t13so153356ply.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 05:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LcouHPlA21WmVqJldeSHxclMup9IM+x2oKuWevoKsOg=;
 b=Tlnp9BJSUa7XFAwwW+GKNzzbXZKtZmfeo/5Fv/ovAsoFzIKqIjwypNVHiyd8+gfLPH
 Fb7gxuUGSIyjYPawgXDGQLme/G7CS1zch9eFiaKR3eqZzxwNMw+mwvBmpkEFO9fyaneg
 OiKaViiD9vXZiBlOie/V6BWRbKxML36lqpoJ8ecYC07oRzZlgbr0wxuh+KVfLrzla7TL
 fEFs607cmdp+xLpu/F3LiyEdN90SStH2c2b+HVYB1kjqezE+VFYvSrdpdsrMXhdyP129
 WKMGcGUEquPFViD0K0PBC7PYykx4TcQ+5CHmO8cT1Nn4YOBv4JJuWfOvwvS6lzwOiB+m
 /kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LcouHPlA21WmVqJldeSHxclMup9IM+x2oKuWevoKsOg=;
 b=uRvfcoR6iQCFl6Y9p0brXbBIRjpbQVqwx1rXs0drsxDolE49Q7/Xe56a1WHLO1jIjq
 Y1HwSZO6goPVgL9mRiiRljEOZsgdKarOaUWzilRUJlSHAajVy5Bp7zVZoEH3KIxD/elQ
 xWy4gPH1wpm8TgG4M+wTDdLBqQLuTr6J8DtGxCSYV+5gSVhUu8HJ4uXMknUg4TZwqSpf
 IlPsa+Quvs/LlRFgNZBF4LR/A58MHCYD4Ae+uH76JnZHt0pivpP5CZtCMr+naiTO7J3H
 Ojg2DpVtH2ZpBxGU7huzVEumm0pxdrGfD0BGt+sCEdWo5JnYeXHekLEw40hpEV7/IDzc
 9wyw==
X-Gm-Message-State: AA+aEWaxmGNkgxLB//9BGHw8y6EgmwU43N+11gXkPMZ7gvMkoaraFOxM
 fTsawu1wnPIuO+xB/dzwXA4=
X-Google-Smtp-Source: AFSGD/UK1m2QlD/ekJ26senJEbu6Pb+HfQlL4cpRyq7HPE9fC51Z5WuWvOTYycdw7BrwYcyq06rLUg==
X-Received: by 2002:a17:902:2aaa:: with SMTP id
 j39mr28951899plb.335.1544102511104; 
 Thu, 06 Dec 2018 05:21:51 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id y5sm2409246pge.49.2018.12.06.05.21.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 05:21:50 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [Resend PATCH V5 3/10] x86/Hyper-v: Add trace in the
 hyperv_nested_flush_guest_mapping_range()
Date: Thu,  6 Dec 2018 21:21:06 +0800
Message-Id: <20181206132113.2691-4-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
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
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
 sthemmin@microsoft.com, x86@kernel.org, linux@armlinux.org.uk,
 michael.h.kelley@microsoft.com, mingo@redhat.com, jhogan@kernel.org,
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

This patch is to trace log in the hyperv_nested_flush_
guest_mapping_range().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/nested.c            |  1 +
 arch/x86/include/asm/trace/hyperv.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index 3d0f31e46954..dd0a843f766d 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -130,6 +130,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
 	else
 		ret = status;
 fault:
+	trace_hyperv_nested_flush_guest_mapping_range(as, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping_range);
diff --git a/arch/x86/include/asm/trace/hyperv.h b/arch/x86/include/asm/trace/hyperv.h
index 2e6245a023ef..ace464f09681 100644
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@ -42,6 +42,20 @@ TRACE_EVENT(hyperv_nested_flush_guest_mapping,
 	    TP_printk("address space %llx ret %d", __entry->as, __entry->ret)
 	);
 
+TRACE_EVENT(hyperv_nested_flush_guest_mapping_range,
+	    TP_PROTO(u64 as, int ret),
+	    TP_ARGS(as, ret),
+
+	    TP_STRUCT__entry(
+		    __field(u64, as)
+		    __field(int, ret)
+		    ),
+	    TP_fast_assign(__entry->as = as;
+			   __entry->ret = ret;
+		    ),
+	    TP_printk("address space %llx ret %d", __entry->as, __entry->ret)
+	);
+
 TRACE_EVENT(hyperv_send_ipi_mask,
 	    TP_PROTO(const struct cpumask *cpus,
 		     int vector),
-- 
2.14.4

