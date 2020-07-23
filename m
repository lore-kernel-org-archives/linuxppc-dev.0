Return-Path: <SRS0=Lnkm=BC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83D2C433E1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 10:58:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC8D2080D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 10:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6FyYWFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC8D2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BC8T52ShpzDrLb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 20:58:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1041;
 helo=mail-pj1-x1041.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=c6FyYWFe; dkim-atps=neutral
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BC8Qj4zH6zDr6l
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2020 20:56:29 +1000 (AEST)
Received: by mail-pj1-x1041.google.com with SMTP id k5so2890646pjg.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2020 03:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B+mLXieEAfXnO/747XGSjyHkJWweuJW45UcNIGomDRA=;
 b=c6FyYWFei/GJd4W55hsLdi161Ij5iiz7XoxIgjk8uWEyUHjj+HzhiwHI9g/9lzjL9J
 8JwVe3kqr/y5qBDb0HaNVOemR+LFDw7OHJVDnej1EW+fUA91rBUAvZcdivH2wG9HyrMA
 3AAZN+m7GRTB8I7TT5YxXOwSvQiUwHnuEDwFGdU/KE5iIQR5Q1gdo2OvaDbfm65T0lE+
 rsA+aUfoJ3VeW58rSNvW1MOQYbzFEC1qnVTjqZi473T5DG0Scw0qWT1x7keIapAeDtLG
 b5GZT7JXPChb3Rx5F+XvVny5702h5KhkLCOO/1hUo32rBmHGDcI3qxfKzfi3AoP0TfnW
 MB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B+mLXieEAfXnO/747XGSjyHkJWweuJW45UcNIGomDRA=;
 b=XY14yDshepSfV5zRF8DSma6g/oK/zaZhL8iBk0k8o8o/xizX3PlL+FXV7Tpu/BYDtt
 e4L+2Bp/VxKqkSWmY9q1IJT13w6qiSvjc9c0jPdZqZU2ji9OHfvfqlcOCbyrj2i9RO9r
 Z2k4Cl2E7yqkymlPsW1Eb+q7qQfG1eFT6XgzGL92kDe4iMfYi9dpf1AadUlB3smY2XXw
 5tFj4lIJrQGqiACtJfazXo/GWRJLcgnPcbVgw6sUisjmqxHPhIYJY2EY0L9DVLXldlLx
 xd1XAzChXJ0ozfu9BPVPCyNS4lTODk/i+IY/GLnPpx87TOdiNlQYvwrVzNz8usfJuSNG
 FSyg==
X-Gm-Message-State: AOAM530S16f+TfMysWE3uXGMsDJ19jtsADeevgBmKxuxoCMMTWh3SswL
 g9Os2PzfUy0MGYGy8e8ZBjc=
X-Google-Smtp-Source: ABdhPJzn2+x7F7ArPwBbfRDcLnhlqdLSyy4lZ9Qn+NY5m6fLUb48Uxpzopafbl3UM+x1jlxLVUSumg==
X-Received: by 2002:a17:902:b20a:: with SMTP id
 t10mr3176863plr.185.1595501785905; 
 Thu, 23 Jul 2020 03:56:25 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au.
 [110.174.173.27])
 by smtp.gmail.com with ESMTPSA id 204sm2598009pfx.3.2020.07.23.03.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 03:56:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Date: Thu, 23 Jul 2020 20:56:14 +1000
Message-Id: <20200723105615.1268126-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
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
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If an interrupt is not masked by local_irq_disable (e.g., a powerpc perf
interrupt), then it can hit in local_irq_enable() after trace_hardirqs_on()
and before raw_local_irq_enable().

If that interrupt handler calls local_irq_save(), it will call
trace_hardirqs_off() but the local_irq_restore() will not call
trace_hardirqs_on() again because raw_irqs_disabled_flags(flags) is true.

This can lead lockdep_assert_irqs_enabled() to trigger false positive
warnings.

Fix this by being careful to only enable and disable trace_hardirqs with
the outer-most irq enable/disable.

Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

I haven't tested on other architectures but I imagine NMIs in general
might cause a similar problem.

Other architectures might have to be updated for patch 2, but there's
a lot of asm around interrupt/return, so I didn't have a very good
lock. The warnings should be harmless enough and uncover most places
that need updating.

 arch/powerpc/include/asm/hw_irq.h | 11 ++++-------
 include/linux/irqflags.h          | 29 ++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 3a0db7b0b46e..35060be09073 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
 #define powerpc_local_irq_pmu_save(flags)			\
 	 do {							\
 		raw_local_irq_pmu_save(flags);			\
-		trace_hardirqs_off();				\
+		if (!raw_irqs_disabled_flags(flags))		\
+			trace_hardirqs_off();			\
 	} while(0)
 #define powerpc_local_irq_pmu_restore(flags)			\
 	do {							\
-		if (raw_irqs_disabled_flags(flags)) {		\
-			raw_local_irq_pmu_restore(flags);	\
-			trace_hardirqs_off();			\
-		} else {					\
+		if (!raw_irqs_disabled_flags(flags))		\
 			trace_hardirqs_on();			\
-			raw_local_irq_pmu_restore(flags);	\
-		}						\
+		raw_local_irq_pmu_restore(flags);		\
 	} while(0)
 #else
 #define powerpc_local_irq_pmu_save(flags)			\
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 6384d2813ded..571ee29ecefc 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -163,26 +163,33 @@ do {						\
  * if !TRACE_IRQFLAGS.
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
-#define local_irq_enable() \
-	do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0)
-#define local_irq_disable() \
-	do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0)
+#define local_irq_enable()				\
+	do {						\
+		trace_hardirqs_on();			\
+		raw_local_irq_enable();			\
+	} while (0)
+
+#define local_irq_disable()				\
+	do {						\
+		bool was_disabled = raw_irqs_disabled(); \
+		raw_local_irq_disable();		\
+		if (!was_disabled)			\
+			trace_hardirqs_off();		\
+	} while (0)
+
 #define local_irq_save(flags)				\
 	do {						\
 		raw_local_irq_save(flags);		\
-		trace_hardirqs_off();			\
+		if (!raw_irqs_disabled_flags(flags))	\
+			trace_hardirqs_off();		\
 	} while (0)
 
 
 #define local_irq_restore(flags)			\
 	do {						\
-		if (raw_irqs_disabled_flags(flags)) {	\
-			raw_local_irq_restore(flags);	\
-			trace_hardirqs_off();		\
-		} else {				\
+		if (!raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_on();		\
-			raw_local_irq_restore(flags);	\
-		}					\
+		raw_local_irq_restore(flags);		\
 	} while (0)
 
 #define safe_halt()				\
-- 
2.23.0

