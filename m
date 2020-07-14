Return-Path: <SRS0=DUdi=AZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0906AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2020 15:03:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DC222453
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2020 15:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oan2KmRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DC222453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B5kKT6PDyzDqP4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 01:03:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::442;
 helo=mail-wr1-x442.google.com; envelope-from=lee.jones@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=oan2KmRn; dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B5k3W2RbRzDqXK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 00:51:03 +1000 (AEST)
Received: by mail-wr1-x442.google.com with SMTP id z13so22178928wrw.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2020 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=87fYCk78HvnEcHEWI8252kKdAErne/JGHZaNtIMV4DM=;
 b=oan2KmRnlmziHA33dlWeKxYSz99uymPx4Upt4DdPZqzkE7Pn6aNbVFcS4EqijPPT1b
 epm+Z0+gabomO1htq+2nGq7mfGaa4AQjVGvinv2W7rG4Yf4zrX1lLQEsQqp/IxzwJsZK
 KsU3lyQE4BSuu7m+y0e17j3xQipWcaeFlmiHFAjUhm+t5oiOf17IImiudspjVz2Gr4Np
 +3ggtvvQ+Y0p36Roz5hpma2QxOSlmCwdpxC50LPbuzXaY/z9L0dMBVjNrKdi9Dd18Pfz
 bjl9EDQ3qx3ytSsCNXEZ3bn0ERkPJPoJyn67O07VbJKTig+xN3S9JouZaVPvYAKfp92V
 EHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=87fYCk78HvnEcHEWI8252kKdAErne/JGHZaNtIMV4DM=;
 b=f1abTpAzSTOMcB2usHeGCMdv9OXHtR1lV0f50Tq2Ag88wECWyF55NHaBbbxoBmRHVE
 sWfkBvi4OI88nIECk1uyKpLSP54bNjPRcurH+AyMBZFTFC+VEh1g3kf4uuAfDw/4l/IT
 nx6lIXFY1HfJXNPQENr4o4qycPSD5jCNI2LTGVuhnL0qQ7aQmbk/sYv4emISAvAkja3L
 SalxT/7cRYErZ4pJEPn1G4JQP5myVrdyxwtHJQhwPMn3ary/OVgJ72LgQiYDDe/WkOZh
 EMX2oR9K/4RbyWe1BNZADLfioEt7DKL0VWUafN5ryucP7nunEAllVZHvcEfM8fVFc/Ui
 rHcg==
X-Gm-Message-State: AOAM530aWj7Lsxozu83YzHhZn56b/etWULiFX9WZVmUJCtyZhYI0Jn76
 Qf/rY1SQbz2fkiHZio44wmA59A==
X-Google-Smtp-Source: ABdhPJyholUMWz/5/8DrxA2fX1xTdZCmREnCcugfLGT0R3+RARPOD0BiRca7mzrYbDfRATUmPfhpCg==
X-Received: by 2002:a5d:6990:: with SMTP id g16mr6060756wru.131.1594738259994; 
 Tue, 14 Jul 2020 07:50:59 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
 by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 07:50:59 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: rjw@rjwysocki.net,
	viresh.kumar@linaro.org
Subject: [PATCH 07/13] cpufreq: powernv-cpufreq: Fix a bunch of kerneldoc
 related issues
Date: Tue, 14 Jul 2020 15:50:43 +0100
Message-Id: <20200714145049.2496163-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
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
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Repair problems with formatting and missing attributes/parameters, and
demote header comments which do not meet the required standards
applicable to kerneldoc.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/powernv-cpufreq.c:84: warning: Function parameter or member 'last_lpstate_idx' not described in 'global_pstate_info'
 drivers/cpufreq/powernv-cpufreq.c:84: warning: Function parameter or member 'last_gpstate_idx' not described in 'global_pstate_info'
 drivers/cpufreq/powernv-cpufreq.c:84: warning: Function parameter or member 'policy' not described in 'global_pstate_info'
 drivers/cpufreq/powernv-cpufreq.c:182: warning: Function parameter or member 'i' not described in 'idx_to_pstate'
 drivers/cpufreq/powernv-cpufreq.c:201: warning: Function parameter or member 'pstate' not described in 'pstate_to_idx'
 drivers/cpufreq/powernv-cpufreq.c:670: warning: Function parameter or member 't' not described in 'gpstate_timer_handler'
 drivers/cpufreq/powernv-cpufreq.c:670: warning: Excess function parameter 'data' description in 'gpstate_timer_handler'

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/powernv-cpufreq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 068cc53abe320..2e5a8b8a4abaa 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -64,13 +64,14 @@
  *				highest_lpstate_idx
  * @last_sampled_time:		Time from boot in ms when global pstates were
  *				last set
- * @last_lpstate_idx,		Last set value of local pstate and global
- * last_gpstate_idx		pstate in terms of cpufreq table index
+ * @last_lpstate_idx:		Last set value of local pstate and global
+ * @last_gpstate_idx:		pstate in terms of cpufreq table index
  * @timer:			Is used for ramping down if cpu goes idle for
  *				a long time with global pstate held high
  * @gpstate_lock:		A spinlock to maintain synchronization between
  *				routines called by the timer handler and
  *				governer's target_index calls
+ * @policy:			Associated CPUFreq policy
  */
 struct global_pstate_info {
 	int highest_lpstate_idx;
@@ -170,7 +171,7 @@ static inline u8 extract_pstate(u64 pmsr_val, unsigned int shift)
 
 /* Use following functions for conversions between pstate_id and index */
 
-/**
+/*
  * idx_to_pstate : Returns the pstate id corresponding to the
  *		   frequency in the cpufreq frequency table
  *		   powernv_freqs indexed by @i.
@@ -188,7 +189,7 @@ static inline u8 idx_to_pstate(unsigned int i)
 	return powernv_freqs[i].driver_data;
 }
 
-/**
+/*
  * pstate_to_idx : Returns the index in the cpufreq frequencytable
  *		   powernv_freqs for the frequency whose corresponding
  *		   pstate id is @pstate.
@@ -660,7 +661,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
 /**
  * gpstate_timer_handler
  *
- * @data: pointer to cpufreq_policy on which timer was queued
+ * @t: Timer context used to fetch global pstate info struct
  *
  * This handler brings down the global pstate closer to the local pstate
  * according quadratic equation. Queues a new timer if it is still not equal
-- 
2.25.1

