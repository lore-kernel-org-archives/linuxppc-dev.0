Return-Path: <SRS0=Y1I/=GS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0598CC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 17:29:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A8C23382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 17:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A8C23382
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DHSpZ0C8NzDsjl
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Jan 2021 04:29:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d;
 helo=mail-pl1-x62d.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ABnkoFRE; dkim-atps=neutral
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DHRz36jPmzDsTv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2021 03:51:27 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id g3so5003036plp.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2021 08:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aMdoj0wQ9tAdaFDLpkWxZpb7QCzY+FwQMv5Ch1ewqTw=;
 b=ABnkoFRECutWoVxqv/quVgNr0sAONSw89rUzd1s7KKKVkx15OYFUyKpq7xqQhwhcg/
 UuwMrV3fYXHaXTWJvKiiBgXs8gxvrlleQmEv3JlN4UxHJG7u2ar1AixZutWboFRkSYXy
 HjOAfPw3m/bjcVvNcTsszwRNEjCBbvMWEiPF7kvkjBf63mXoxWfK/Iwl8PV7UGdd5Aqb
 olheNjLfs2+O0oM2kAUbQqjqo7LnCZ1CmOg45NAcJicj5juNNDdN4VZf04sjDcCmiecg
 ZVhCHylLlTvFd5ZNEoUQkIx+NYfhOVIUmPMNtY6syZ0GDZrkaTxUBmWlwadsdNJbAtfI
 vfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aMdoj0wQ9tAdaFDLpkWxZpb7QCzY+FwQMv5Ch1ewqTw=;
 b=fd3OSdOnXl+pr2FFpoZ91OJejnpouBq9qZbGOD6T05xhv82Yz/q2ae0EK2mamLzy9j
 zhoXZIM0bFYb2qZtvYGO78m3eISjzzxrxFY8iUfKW0FKE8V+MAYTVN6uvZZepEnpW7B0
 CQE4sAXPwJ2fWQxSbb0JbQbnhJLhxAZyNKLBJxX/MhUs/tL3CAyGaPqtHdAtbTgwJv24
 WN7yCDtWki6DUjFhOGAa67LhOSoOblTENgJ6R3sveID8g18BlsS3GDgJJ3dQ1Z4ELoLi
 GKQwLHd/6wZmc9GQH3eoltp2ogCyg7LzF10g4kdvuD5Ug6vfTAwbiOpzbcoPQnQe7wYa
 TclA==
X-Gm-Message-State: AOAM532p31HTMzrSrxVHACI/wS7Gnyd6KjnDz/iCPVSQalo+gyQ0OI8W
 LYafEUHBfYacIGCu8yfctp6Vpxj4tHY=
X-Google-Smtp-Source: ABdhPJwWQN6VDHrjTyWx9OBtAJjAr5Dhy/hQBaMmYx7/vXOFyT7sfDFYOXU3rQCjpClGkOD4WkbB2w==
X-Received: by 2002:a17:90b:287:: with SMTP id
 az7mr10181509pjb.70.1610729482989; 
 Fri, 15 Jan 2021 08:51:22 -0800 (PST)
Received: from bobo.ibm.com ([124.170.13.62])
 by smtp.gmail.com with ESMTPSA id u1sm8455477pjr.51.2021.01.15.08.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jan 2021 08:51:22 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 15/39] powerpc/time: move timer_broadcast_interrupt
 prototype to asm/time.h
Date: Sat, 16 Jan 2021 02:49:48 +1000
Message-Id: <20210115165012.1260253-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210115165012.1260253-1-npiggin@gmail.com>
References: <20210115165012.1260253-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Interrupt handler prototypes are going to be rearranged in a
future patch, so tidy this out of the way first.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/hw_irq.h | 1 -
 arch/powerpc/include/asm/time.h   | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 0363734ff56e..e5def36212cf 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -54,7 +54,6 @@ extern void replay_system_reset(void);
 extern void replay_soft_interrupts(void);
 
 extern void timer_interrupt(struct pt_regs *);
-extern void timer_broadcast_interrupt(void);
 extern void performance_monitor_exception(struct pt_regs *regs);
 extern void WatchdogException(struct pt_regs *regs);
 extern void unknown_exception(struct pt_regs *regs);
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 8f789b597bae..8dd3cdb25338 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -102,6 +102,8 @@ DECLARE_PER_CPU(u64, decrementers_next_tb);
 /* Convert timebase ticks to nanoseconds */
 unsigned long long tb_to_ns(unsigned long long tb_ticks);
 
+void timer_broadcast_interrupt(void);
+
 /* SPLPAR */
 void accumulate_stolen_time(void);
 
-- 
2.23.0

