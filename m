Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8EBC10F11
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:43:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57FD820818
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH+pvqRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FD820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fn1n4YrgzDqBm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:43:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WH+pvqRX"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fmrC04QMzDqHv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 13:35:23 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id c8so2701765pfd.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 20:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=++5Kahm69pfih1hlK32V2CQsRTIBHswnoEuweJf+4FY=;
 b=WH+pvqRX3E2xh2rFecOyDRCL/X74JCuPg/LesGHhNgXVZDyFJA0pQLS9Vy3VdLRxvP
 vTSlK0Zk5yKDB7vLIIUxly10b8IO+D989VVDom5iZ7qDXy3L5dW65+HleAdiQodR7A+2
 Md3pdYPS+GqAam57HbHSogR6EqZEN81o8OR03KxxXDccb/s5bQki31tJb7gGL+5Yr0t6
 EePjGtlxj/m/LDQ47/STaqzMd40vfqCO3/gVetZjVvVOqTrm2kh6XqKyGnpWMxj+6bbZ
 FXEiBQtOxW1hn5hzUuVUz+tgJ21i9wa8d77Yd/AusxdfZpjw8qF2Jo2BBguFKMaz02Sw
 xlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=++5Kahm69pfih1hlK32V2CQsRTIBHswnoEuweJf+4FY=;
 b=gSq8hLEe594xmaxcC+spYe0XcpFVu42TkHVEAid4OUjoBm8YiO5hegywblu4bcKz6i
 8RdExHb3SOJTxpjfJ22LJFGfOtxab76VIgB7LAIqwqBcnku6qMSBXoSX8qe0hPMNwSnj
 OQjE2V2XKu4KZmvUhM4ekxc2pZpIncmJFQr5TMH1V/LiRt1swO+PEFAsLWj5+WpAVmq4
 ML+6G2q8e5lfS0ZZz0BJ3w1Zy0HT6WM5X3oUDmXh7V/ubDXH6M3urGCio1o2q0czzewM
 W3H4NsBmh4JJoKsrIBCKeWrCvDO+0/cQtk0R6wRsePy/xW9/G24PTGk+4tbtaQeDoWF+
 KPog==
X-Gm-Message-State: APjAAAXA1TDarDuqI+DuAIMuhjUofu0YwPOeYS0TOo8X5QpDBqIPRCsi
 BHn858NWBL56OLwbSBk/DS4=
X-Google-Smtp-Source: APXvYqwTHeF65/Hp98rNuZyayD9mE9HdJHFhhwJYBomZ+S1ESXIs7o+WkVag66TeJ4YVjbnqclZNJA==
X-Received: by 2002:a63:115c:: with SMTP id 28mr15643940pgr.270.1554953721421; 
 Wed, 10 Apr 2019 20:35:21 -0700 (PDT)
Received: from bobo.local0.net ([203.63.188.231])
 by smtp.gmail.com with ESMTPSA id b9sm37231416pfd.32.2019.04.10.20.35.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Apr 2019 20:35:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH v2 4/5] kernel/sched/isolation: require a present CPU in
 housekeeping mask
Date: Thu, 11 Apr 2019 13:34:47 +1000
Message-Id: <20190411033448.20842-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411033448.20842-1-npiggin@gmail.com>
References: <20190411033448.20842-1-npiggin@gmail.com>
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
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

During housekeeping mask setup, currently a possible CPU is required.
That does not guarantee the CPU would be available at boot time, so
check to ensure that at least one present CPU is in the mask.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/sched/isolation.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index b02d148e7672..687302051a27 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -65,6 +65,7 @@ void __init housekeeping_init(void)
 static int __init housekeeping_setup(char *str, enum hk_flags flags)
 {
 	cpumask_var_t non_housekeeping_mask;
+	cpumask_var_t tmp;
 	int err;
 
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
@@ -75,16 +76,23 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 		return 0;
 	}
 
+	alloc_bootmem_cpumask_var(&tmp);
 	if (!housekeeping_flags) {
 		alloc_bootmem_cpumask_var(&housekeeping_mask);
 		cpumask_andnot(housekeeping_mask,
 			       cpu_possible_mask, non_housekeeping_mask);
-		if (cpumask_empty(housekeeping_mask))
+
+		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
+		if (cpumask_empty(tmp)) {
+			pr_warn("Housekeeping: must include one present CPU, "
+				"using boot CPU:%d\n", smp_processor_id());
 			__cpumask_set_cpu(smp_processor_id(), housekeeping_mask);
+			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
+		}
 	} else {
-		cpumask_var_t tmp;
-
-		alloc_bootmem_cpumask_var(&tmp);
+		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
+		if (cpumask_empty(tmp))
+			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
 		cpumask_andnot(tmp, cpu_possible_mask, non_housekeeping_mask);
 		if (!cpumask_equal(tmp, housekeeping_mask)) {
 			pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
@@ -92,8 +100,8 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 			free_bootmem_cpumask_var(non_housekeeping_mask);
 			return 0;
 		}
-		free_bootmem_cpumask_var(tmp);
 	}
+	free_bootmem_cpumask_var(tmp);
 
 	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK)) {
 		if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
-- 
2.20.1

