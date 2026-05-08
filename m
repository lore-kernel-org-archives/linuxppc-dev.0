Return-Path: <linuxppc-dev+bounces-20611-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81E1CD3447
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 13:17:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBqR30nlQz30Pp;
	Fri, 08 May 2026 23:17:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778246239;
	cv=none; b=QqsRM1uC0kDEb8BuEi6CtjZvyPeR2jplxcVDeg8EnUPpR7AC/9Ax7wTMRWubuY1t2t5aqbS1qhW/vN7sfKeOft586IZnfT4E7BYGZQRAOX4U8BAOKcdGt4Ze2mtOHizQ+rqaeunmI0DRr3JPv6m2VmUCEMa4Dx4ygCSf6ZmvJX2igbU9dkDMjnmyaEE6fM7acKBGFl2brwPqMoa+of/FFal0zVxUGGioNPtPItVWpLMXwicUVVhZa61rff6yC8kDvoD4QargY13FhV4/tkETS+AMtxjIv0XCtb0fGFhYXCCBNd85C7oUGSMn+Iomhiy+aAmvVuWymJoPw8OVIQhv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778246239; c=relaxed/relaxed;
	bh=AfCDR3WypzrS9UBfIYRWqQLV9CXwH0GTwCToV4zUyXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3sV67sWZahBNwuvyZafnnWkr3po4kwSZCJLcim4QR+B/Dh+Hxr0Je78/z6Xp3Z2a5hMomN+LC1o2lnZyOI4GE6hELsOE5C7cROfSa1e1/6cyC5BND7kmFaGQyPKNKh9pTZmMGRPris1TZWPOrxVc/DJasazKt9zXH3/7VEVPF3zzOmijM9T3eXBFK56emodf9KyRBdLAUAdNRV9YTuAEszSe3jdi8OfBykEfX5tx1Xhs9rUPhZK6VQ9ttVBYliBVxUr1FZm+GtWuGQURo8u/m8k3GBWB0/GWi6YLHjaMN6ISuIJUiC41hW38seOz+0ZeRwp8KkCZU4HYQfsTRXAtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NmqMd9nq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NmqMd9nq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBqR21jTbz2xQC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 23:17:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 604DE60052;
	Fri,  8 May 2026 13:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F370C2BCB8;
	Fri,  8 May 2026 13:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246235;
	bh=auNYKADD05SLlsp/9RYz5+LVvmnhMqjrsvSp8Ju4hXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NmqMd9nq7hn4woGsz+DEgaq28CUB6LJXpklLRcwhPyjO9vgeTr1+3cmtj3FWbKsV/
	 5TkXkZ+SdTaVAeNvXcOr8pfQw8K+krvr+81SLj/aHPs1GBL86UBk6hNkLpoY9IQKVI
	 nqFmsdeDcLO7sT7j26IJRNUZLe00M2AP6Qwnt4NfZt4l0DiBRrc755lwhpMlN4YCqs
	 Vgj7bYiyp0bzNJFH7HcZnUprszddIl9TLq0FmW2TNdWYt/dAIwOxui9fbXYMdFTiBQ
	 CJza4ccWbDGNwRDTCbBGx5b4BrcZ2ee5GPDcut1s1ZlRnZbRF3z6sEfXsXIe26hbaM
	 LKiMXzlugQm9w==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Sashiko@lists.ozlabs.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/15] tick/sched: Fix TOCTOU in nohz idle time fetch
Date: Fri,  8 May 2026 15:16:33 +0200
Message-ID: <20260508131647.43868-2-frederic@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508131647.43868-1-frederic@kernel.org>
References: <20260508131647.43868-1-frederic@kernel.org>
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
Content-Transfer-Encoding: 8bit

When the nohz idle time is fetched, the current clock timestamp is taken
outside the seqcount, which can result in such a race as reported by
Sashiko:

    get_cpu_sleep_time_us()                 tick_nohz_start_idle()
    -----------------------                 ---------------------
    now = ktime_get()
                                            write_seqcount_begin(idle_sleeptime_seq);
                                            idle_entrytime = ktime_get()
                                            tick_sched_flag_set(ts, TS_FLAG_IDLE_ACTIVE);
                                            write_seqcount_end(&ts->idle_sleeptime_seq);
    read_seqcount_begin(idle_sleeptime_seq)
    delta = now - idle_entrytime);
    //!! But now < idle_entrytime
    idle = *sleeptime +  delta;
    read_seqcount_retry(&ts->idle_sleeptime_seq, seq)

Here the read side fetches the timestamp before the write side and its
update. As a result the time delta computed on the read side is negative
(ktime_t is signed) and breaks the cputime monotonicity guarantee.

This could possibly be fixed with reading the current clock timestamp
inside the seqcount but the reader overhead might then increase. Also
simply checking that the current timestamp is above the idle entry time
is enough to prevent any issue of the like.

Reported-by: Sashiko
Fixes: 620a30fa0bd1 ("timers/nohz: Protect idle/iowait sleep time under seqcount")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cbbb87a0c6e7..171393367b5c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -797,15 +797,16 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
 		*last_update_time = ktime_to_us(now);
 
 	do {
+		ktime_t delta = 0;
+
 		seq = read_seqcount_begin(&ts->idle_sleeptime_seq);
 
 		if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE) && compute_delta) {
-			ktime_t delta = ktime_sub(now, ts->idle_entrytime);
-
-			idle = ktime_add(*sleeptime, delta);
-		} else {
-			idle = *sleeptime;
+			if (now > ts->idle_entrytime)
+				delta = ktime_sub(now, ts->idle_entrytime);
 		}
+
+		idle = ktime_add(*sleeptime, delta);
 	} while (read_seqcount_retry(&ts->idle_sleeptime_seq, seq));
 
 	return ktime_to_us(idle);
-- 
2.53.0


