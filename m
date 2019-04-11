Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F0BC10F11
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:37:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C7B2084D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m25urrAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C7B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fmt503ZfzDqNs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:37:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="m25urrAi"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fmqt3Xv1zDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 13:35:06 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id a96so2660712pla.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 20:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mfPce7oGCKplZgC5wXkTyuZmmh+XEXF/RZVOfDV3eos=;
 b=m25urrAi+4xkiJ1CsLzM2apRGya51y7qwjJc5REkCjz4D+TyX1l1LYGQKvtosh77RZ
 sq94kLAAMjlYnNTTPTYouQxeUQuXn7z/o9b5erowiqk6PWtnt8RjhNXSgL0t1bLCIWOM
 5KlWXorybfGXnxz1Z3NpdB32Wpwf0zxBU0QFfGU8O9brs67wY1T3OfhWRWoY2TRssr0n
 Ov6gQJgxWw23Cde35hvR12HiX4aWT1q9gynTOOgljdVREIdSctJVuz4/3fcxo3y41NWC
 09ZNZHtDRDfj9008TgUDSy4p/WXItsW0aeIH4VJIOE76ILtkij16gkNamBkeCcL7O54/
 ll0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mfPce7oGCKplZgC5wXkTyuZmmh+XEXF/RZVOfDV3eos=;
 b=Zd5vwl94QpqAXMJ3R9oaF3QIIbCKBADHzZfz0Qt8Ze7Tfc6CeGgS1rAb0Ba46TCj6o
 DQ4ZfKi8Qxwg9OknLT9XZng277+MIOHb7FarGWBtKQx81GKR5mujEsUzicLr1VxUaNsK
 6nyYEh+3Yfq6qP+D0SUa8g9FdhRiJdJzK6ejwByNZQYco7R6mQO8nObhWafIhfbdJSib
 C+rv/AJphxk8ynJ7aTcgrcL2VJleeokCcbhzrOHNHKLHh7cu67ZalPlwWQYafa8SESpq
 dGn/ascYpxG4xHr/2xIX4zfbO9v5BQg37y6epH60ZNtVyXt+b+xLyXE9M0CodpypAIeR
 2QgQ==
X-Gm-Message-State: APjAAAXnq0/97rPoJWW+w94P3yfKaBdqEB5iLEEi7WjgAI70Tz7mUQZQ
 /LTD15KDfjm5SJBchCCBCM0=
X-Google-Smtp-Source: APXvYqyICp4HbALhnA3SbAwWILmej0/qeGjvG1lnDwsLQ7HXwWDLdgTW/8U6whyjVhne8GwPzireTg==
X-Received: by 2002:a17:902:bd0c:: with SMTP id
 p12mr21998494pls.50.1554953702774; 
 Wed, 10 Apr 2019 20:35:02 -0700 (PDT)
Received: from bobo.local0.net ([203.63.188.231])
 by smtp.gmail.com with ESMTPSA id b9sm37231416pfd.32.2019.04.10.20.34.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Apr 2019 20:35:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH v2 0/5] Allow CPU0 to be nohz full
Date: Thu, 11 Apr 2019 13:34:43 +1000
Message-Id: <20190411033448.20842-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
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

Since last time, I added a compile time option to opt-out of this
if the platform does not support suspend on non-zero, and tried to
improve legibility of changelogs and explain the justification
better.

I have been testing this on powerpc/pseries and it seems to work
fine (the firmware call to suspend can be called on any CPU and
resumes where it left off), but not included here because the
code has some bitrot unrelated to this series which I hacked to
fix. I will discuss it and either send an acked patch to go with
this series if it is small, or fix it in powerpc tree.

Thanks,
Nick

Nicholas Piggin (5):
  sched/core: allow the remote scheduler tick to be started on CPU0
  PM / suspend: add function to disable secondaries for suspend
  kernel/cpu: Allow non-zero CPU to be primary for suspend / kexec
    freeze
  kernel/sched/isolation: require a present CPU in housekeeping mask
  nohz_full: Allow the boot CPU to be nohz_full

 include/linux/cpu.h       | 15 ++++++++++++
 kernel/cpu.c              | 10 +++++++-
 kernel/kexec_core.c       |  4 ++--
 kernel/power/Kconfig      |  9 +++++++
 kernel/power/hibernate.c  | 12 +++++-----
 kernel/power/suspend.c    |  4 ++--
 kernel/sched/core.c       |  2 +-
 kernel/sched/isolation.c  | 18 ++++++++++----
 kernel/time/tick-common.c | 50 +++++++++++++++++++++++++++++++++++----
 kernel/time/tick-sched.c  | 34 ++++++++++++++++++--------
 11 files changed, 131 insertions(+), 31 deletions(-)

-- 
2.20.1

