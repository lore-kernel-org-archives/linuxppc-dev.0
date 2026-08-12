Return-Path: <linuxppc-dev+bounces-25779-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED310C5B56A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 15:20:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKsdF6DdSz303K;
	Thu, 13 Aug 2026 01:20:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786548049;
	cv=none; b=Vak9fJ6mduBcYeT6kQipvqUu0k+/Pv0ssiFzlzUwgzlZQf5bJxAsuhs1GBDt69lkA8NIVFkMMReU3Ew9kRFFnFTLeVRXkb9MXnYB0K7PqsVNhcA+/RFuJKWJbLio+OuLXBzwCO1XYBlIrY2tJmi3HBRLIjqvCyh/x4Zitni+I49BuwvsroYpTopsJOA/HAY6zvCeBl1t1OjjCg+UwS3wTab6ty6MB6T3awP4y1RiMqW3zUcASaTqQR+j6Plu4g0E4Yj4g6rB0xblskbvXOh1DuTRJRPVWvL0uF4RuXpgyZduYub3qJb159bp5VqCzBm4Ng7CttjtTAYaFUPjIhuq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786548049; c=relaxed/relaxed;
	bh=craqyBqdnDvM4zjNVGlzWDDB/ZXfuR/jCq7Hxjoe9ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=njCikmGepIS9ncshxsmi3ZKmgytzdxtKM/uZUxqXVCSwpY9IVca31AIYgjl+ANvhEIusNi0HHvhwVD3BY1R7UNe/ntzUt02//qXIbRpuXVB3T5H4oypAxWGYJFgXnFjetn35LWAweuOVbQuLQW+0hx+AQILtJu4q5Uou4oxZFZZ/rp0CIWKhO0WB5zYqYdindhNInyDyshHY3SNicazSaZoWVsT+cn/Er7zun62WpVY252RVItDBoV6+/CFp+ezocnsaG3ZlxxWZ6WeQsnddFq2fHTJMqX+YeyXvxSYqj+3CYuo24B2ybRLWksw9ssqpW7HuXxscU5N93xlPEH4AUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P9OBApw7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P9OBApw7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKsdD3vyyz302l
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 01:20:47 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2d032846c95so12011485ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 08:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786548045; x=1787152845; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=craqyBqdnDvM4zjNVGlzWDDB/ZXfuR/jCq7Hxjoe9ew=;
        b=P9OBApw7SNcvuiyLqmT/oOoRPSNv7g3YynP+Y2hE7dMOURixb5Qfl76nJCTRze6aBq
         Trdlmzz1Y27E6796HO1C7JFFUhus+2Yix6XXM1D7/RNWsbjZ2aN2CuIr4xPHkFHhOp3q
         45eunfW7Qq4Q3zxlg7z5vU0/AT0ComitVxDji+IluZGVc7IMIWLBG3yOo4IHT3P5KBKU
         6aBuZNqYCyg8EGrhUYfkHi8MNnKKmF4H9v1kKQ7UjsY8nD5hobqUWYfCgHKefGTnBz9e
         0jHmlqw//XVIMeSsUcrjLFovT4DDU4zqx59w8H0FDbcwtoofsGeCSHszGtYZgSzkELHW
         ZiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548045; x=1787152845;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=craqyBqdnDvM4zjNVGlzWDDB/ZXfuR/jCq7Hxjoe9ew=;
        b=Gb305k2qfxCKIxk1RZYDbPT9A6VkmgKl/mT4jed2WkAROe4r75E+6iwkjVI6eGS0jn
         CuMIsbZExlNKrfCxpmzOODwhD7TqTiJ7+zBdjmGz3qzLziWrTNZ9rbbIu6SEalPXGB+Y
         d6WZLBD5L3rWVfz9RFUMy7S9KQj6ZT0hrZxmso2mUbnV02WnGdp6qNhDXAOsGDkshCAl
         ec2RIV9sJksYB3ck6KxeSjH1fTp7C0vO42NQxAYeeRWgRRr41wSSPOIJpet4s1QPEs1R
         AZh0pRpn8vWqqNzOCaBjaHspdNJbhBfZjfEDGwfJv759f+o1tSbsT69X320mbzsNwlu3
         DlJg==
X-Forwarded-Encrypted: i=1; AHgh+RoNTCZQFnJ5IXaF92WNWDkCSXaDcVoCSjZn0rdMyDsNv9+Re4AoOso+BP8EtOnumJk3cF/rwrnqfLOLIDs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwnoSxEmlfnlTPblpGRVfHMim/XnNM+jRCHWHS4C/FGT26q2hej
	ZoIUQNnJiJJMSuNHI9vd5v5g5aR2k7dquIOdcItVBowv+cTI+0SZCSq0
X-Gm-Gg: AR+sD13AgtDZY5eVhYN5Stkt6Jhng2kKdIk2i5uxuFmvOqzfN938JpZrQiq6amo0jNY
	fIfxSyPldj/mrgqJ4dzDCmkUr+2+uQo3C0y4B5HQj/8yXg9SGfYuWSg4J851VOqP+fyx6ArfMrt
	/4wtXSfFNvIg+sGws0Mdz8bOGXbWd0g702Lfv0+rYwQIi7dMkeeTM0sL3PuBkrFHaCDUEIpuY0W
	adQIJhl/9lGB2HVJ0HNYD/wDek5zImVqb5I7azNebUxGJ8lsJnIW8Tqv5PAf13273WgI5OKwKRj
	3LZ4TiVA09WgronoiVMrRn7PBG1TCVyZSFDmy7x5aLB7LF0SWvqfKUws8BmxVwK6xLoXhBu4dlO
	liAzkTeWl9qCz4eaOie4amEbIqfhwYCqJv9IQFpeWuqzc4LlQjzpplhNh0QSjSYdZJWG8cpxPu0
	3XGJA+08SnqHuHZSMfjjxKKdtyAIWJ3QJsTdjC6BG9kljMywqLF2kYRl3P1z49FNfZ9SeU8gcHB
	g1kIDYgrXgbdDdJ5JbMlYDgLp7BoGATWF50
X-Received: by 2002:a17:90b:2b8f:b0:38e:8300:af51 with SMTP id 98e67ed59e1d1-39301424de5mr6935116a91.8.1786548044416;
        Wed, 12 Aug 2026 08:20:44 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141243819eesm10653360c88.0.2026.08.12.08.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:20:43 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	sshegde@linux.ibm.com,
	mchauras@linux.ibm.com,
	mkchauras@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] powerpc/entry: Use hard_irq_disable() in arch_interrupt_exit_prepare()
Date: Wed, 12 Aug 2026 20:50:35 +0530
Message-ID: <20260812152035.1661781-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 334f3f6d7a16 ("powerpc/entry: Disable interrupts before irqentry_exit")
fixed a BUG in preempt_schedule_irq() by calling local_irq_disable()
unconditionally in arch_interrupt_exit_prepare() before irqentry_exit().
The fix is correct in intent but uses the wrong primitive for PPC64.

On PPC64, local_irq_disable() only sets the soft-mask
(irq_soft_mask = IRQS_DISABLED). It does not set PACA_IRQ_HARD_DIS in
irq_happened and does not clear MSR[EE].

This causes a continuous WARN_ON boot hang on Power11 pSeries LPARs
using the dedicated-cede cpuidle path. When the CPU wakes from H_CEDE,
interrupt_exit_kernel_prepare() calls replay_soft_interrupts(), which
dispatches pending async handlers (timer_interrupt, do_IRQ) using the
DEFINE_INTERRUPT_HANDLER_ASYNC macro. That macro calls
arch_interrupt_async_exit_prepare() -> arch_interrupt_exit_prepare()
before irqentry_exit(). With local_irq_disable(), PACA_IRQ_HARD_DIS
is not set, but next_interrupt() unconditionally asserts it:

  WARN_ON(!(local_paca->irq_happened & PACA_IRQ_HARD_DIS));

This fires on every replayed interrupt, looping indefinitely and
preventing boot completion.

Fix this by replacing local_irq_disable() with hard_irq_disable().
On PPC64, hard_irq_disable() sets irq_soft_mask to IRQS_ALL_DISABLED,
sets PACA_IRQ_HARD_DIS in irq_happened, and clears MSR[EE] — satisfying
all of:

  - lockdep_assert_irqs_disabled() in irqentry_exit_to_kernel_mode()
  - next_interrupt()'s WARN_ON(!(irq_happened & PACA_IRQ_HARD_DIS))
  - preempt_schedule_irq()'s BUG_ON(!irqs_disabled())

On PPC32/non-64, hard_irq_disable() is equivalent to local_irq_disable(),
so there is no regression on those platforms.

Fixes: 334f3f6d7a16 ("powerpc/entry: Disable interrupts before irqentry_exit")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/6f9bfb0f-b14c-468e-bb9f-c157d120d0dc@linux.ibm.com/
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/include/asm/entry-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index c5adb5006361..de64389b0815 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -270,7 +270,7 @@ static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
 	}
 
 	/* irqentry_exit expects to be called with interrupts disabled */
-	local_irq_disable();
+	hard_irq_disable();
 }
 
 static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
-- 
2.55.0


