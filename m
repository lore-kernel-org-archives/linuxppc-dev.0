Return-Path: <SRS0=nAOP=6W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4933BC38A2A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 05:03:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16EA208D6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 05:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui9b9NTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16EA208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49JJBM1FJmzDr5T
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 15:03:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::441;
 helo=mail-pf1-x441.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Ui9b9NTg; dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49JHYQ2LMVzDqwf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2020 14:34:50 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id v63so290565pfb.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2020 21:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lv9Al9ISmmfNSgwsdH794N3cg6xW1cqbd2+cJWFzJCQ=;
 b=Ui9b9NTgq3vlpXz1mg+9CjcdcPRwz5mKPYGt2T5eDeCTLu7J5h5A1P524JsRX9fiS4
 Tmdotc91kVo1aLdTRFYOWwuqriV4mSiXWnS4CTZLcYRGMGr41GXdemUPtDGOa8S/DP/h
 zfoaqjHeT7EBDTzofIz6yp2YjMYrOGbI8XWRqP5tyqMXCBpYULcpU3PvdAoXhW5T0y7z
 oQbin0fH3uH4KTdXtrUxUiqu6aRlT6JBJJ8RgZo0HCWoF0U2QmndgbZkYjV0TgWj4p2t
 0D71z6azzVQYyvlREWM9O71GO7UOKcH5/9BY9DbqZyUMCPPt+PEmOgAT28aRR1g72ciq
 0cNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lv9Al9ISmmfNSgwsdH794N3cg6xW1cqbd2+cJWFzJCQ=;
 b=DRE9kMEL4Cg+hhdVKizjiZSVK4nEcSwJshlIyNQSvNk1EhNwHH+RW2qGtStZRXX5lq
 t2mKwoi8DTYzUXzka2nYq1tacG4UMRZKk1nyXECXwZEPDsqIB7ZMYeXGEJMYSSIGU7jI
 0ownf9IaghhwM5vXrGIFbVXLmQIHIqiAWWhQGhXzAOYCPgsRn5MfNJPXDnbRMJZOAwnP
 rw4n7hoDO9hzYwDOUMmpDlOw4JheeUwr5izKn5htr7mqUgADbFuh0vcHEZeBvgNQ6CDD
 BBNJbaV0XGthUDRroSK5hx8E1dOTvlKxMY28JEk9JKlbATB9rtYCaeUOl9zz+4J0qvx+
 7+RA==
X-Gm-Message-State: AGi0PuasJT9HjO02NYxDBzNDaOtPYzkQ8bWvSTNY5un3Mtn5bXaTetWm
 Pa/lnJn6abAPbjSqe9XA1/cobVyC
X-Google-Smtp-Source: APiQypIavPR4jSqjYAIi++PvHpa+xC0x1e8KnNadGWbnPYbQZtlJ1WMhssx0qfb8nkNf+1tZdIkJWw==
X-Received: by 2002:a63:5a4c:: with SMTP id k12mr575164pgm.50.1588912488152;
 Thu, 07 May 2020 21:34:48 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-214-199.tpgi.com.au. [61.68.214.199])
 by smtp.gmail.com with ESMTPSA id i9sm358813pfk.199.2020.05.07.21.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 21:34:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 13/16] powerpc/64s: machine check do not trace real-mode
 handler
Date: Fri,  8 May 2020 14:34:05 +1000
Message-Id: <20200508043408.886394-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200508043408.886394-1-npiggin@gmail.com>
References: <20200508043408.886394-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Rather than notrace annotations throughout a significant part of the
machine check code across kernel/ pseries/ and powernv/ which can
easily be broken and is infrequently tested, use paca->ftrace_enabled
to blanket-disable tracing of the real-mode non-maskable handler.

Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index be7e3f92a7b5..fd90c0eda229 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/irq_work.h>
 #include <linux/extable.h>
+#include <linux/ftrace.h>
 
 #include <asm/machdep.h>
 #include <asm/mce.h>
@@ -571,10 +572,14 @@ EXPORT_SYMBOL_GPL(machine_check_print_event_info);
  *
  * regs->nip and regs->msr contains srr0 and ssr1.
  */
-long machine_check_early(struct pt_regs *regs)
+long notrace machine_check_early(struct pt_regs *regs)
 {
 	long handled = 0;
 	bool nested = in_nmi();
+	u8 ftrace_enabled = this_cpu_get_ftrace_enabled();
+
+	this_cpu_set_ftrace_enabled(0);
+
 	if (!nested)
 		nmi_enter();
 
@@ -589,6 +594,8 @@ long machine_check_early(struct pt_regs *regs)
 	if (!nested)
 		nmi_exit();
 
+	this_cpu_set_ftrace_enabled(ftrace_enabled);
+
 	return handled;
 }
 
-- 
2.23.0

