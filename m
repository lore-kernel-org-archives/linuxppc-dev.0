Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE09ECDE4B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 14:55:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF312081D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 14:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkmqcX8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF312081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rRCW2G41zF3QX
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 01:55:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JkmqcX8K";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JkmqcX8K"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rR2P3btdzF3Pw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 01:47:09 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id v68-v6so5806953pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 06:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LcouHPlA21WmVqJldeSHxclMup9IM+x2oKuWevoKsOg=;
 b=JkmqcX8KZyNmO2n/uztZnRJdiSbewzm6GMv+1vFxX95JSFDLt6x5HLz2EN/e9Jpfmu
 iZCMGCe2weJQ8H4YFeusZ8Do9hmfAC+UeDCoic0wET0nGXs8cJlME4+p99owc0G1aqDD
 1P2sgBBSp7WHPXj5mpHc+lGT1W85JqqIdDwduXIFiWhvXc6Ep3aJd5wlUkc0XtDhY74Z
 0FJxfXdKSCYLU1Yuzj2Xx5IdQs5XMqd4yUXztSijafQQyyelKZbPiq+NBNv8N9yKp2F9
 2DN+4Y5h/H3PLmrEzP1dh2/JCSomFThLksiKIUDaU87jTX0fcrlJ4lQ+uy/R2SY11J+J
 Iy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LcouHPlA21WmVqJldeSHxclMup9IM+x2oKuWevoKsOg=;
 b=l4P3ivGwV2NVDndYiGOnQy/mfneyeDZN/w+fbU58mqJTKYME6vyNhH1Flyz/p1d5XS
 gsYJX3AzWm/Qj0ksU2VjIVU9qsdgxaemo5IQGNh90kkofotZffOYiZdI6lQ0nYfOANHN
 YTypqVWArcL5x1pSlFm2m+B3K1WMbEU8ae2ABzjIBulW281amtRmjDPUhsQoycutAA1H
 V1NImYW9GSuv/WJjxz5k0rWQcORFrpGvdRMtInBK02TbtuAD3SibeGKakNpiMYDx5YwA
 29aIlzwwxU/IVAEjAUHB81d4kCTCBhRfuXuokInijhzJGuiOv3qdPJXExURso54B9+v/
 QZSg==
X-Gm-Message-State: AGRZ1gLTVUtiWQw0rXpjE7mqexCEptaX15ICjhgDTFhquR5088pDDiaU
 rqDl6mHyPuEWBRknZ3N0RMo=
X-Google-Smtp-Source: AJdET5fbrIVBuJI6Qp4ZjmIMOIFNQb21T3aRd5oUOxuTC+6IplUmqnGeqIy8/K/AJagGlPJnaalnxg==
X-Received: by 2002:a63:4926:: with SMTP id w38mr3857439pga.353.1541688427616; 
 Thu, 08 Nov 2018 06:47:07 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id
 k75-v6sm11526731pfb.119.2018.11.08.06.46.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 08 Nov 2018 06:47:07 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [Resend PATCH V5 3/10] x86/Hyper-v: Add trace in the
 hyperv_nested_flush_guest_mapping_range()
Date: Thu,  8 Nov 2018 22:46:32 +0800
Message-Id: <20181108144639.11206-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
References: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
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

