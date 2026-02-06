Return-Path: <linuxppc-dev+bounces-16678-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F17EE20A6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 14:24:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6xD421K7z3bfY;
	Sat, 07 Feb 2026 01:24:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770387844;
	cv=none; b=ORqNbdaMm28/xcTpjZSNYPJw5/AAbY5CTFJSB4cgIBq2V8dlVCxaFZY+aeotA07ogfStX7WcYFAc7BN7j8gfwJVMS3VnqJQzAMqAlROo1kBCO4fxPfY41+gUSq8HyjGwwxmLle8Dj/rkdHtyvmm5JMpEmmW/e943rghfoD2aMc+pTJzC54bwQ1yEGs1oY2gWfQyw3BEyBbxeV3wsZiyOKZP6l+sqaexr8a1l1WnuTxscZtd8gItmPhsBJ47D46PvLgAjcRKVCQivste+opMmLQTiX6KqmYkfoK3nT4c8ptFAn4lO7Pw3UYFuasMrC8iQ/5ekkQ1kCzhagYYcRlc3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770387844; c=relaxed/relaxed;
	bh=1CK/S7yURlkJZ0Du4p0+VypY1SSI2dUFinA4nv9adSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+hMbjST9Dd9bRQwkoYXFz9ZP0z5QuIJ+JZsRzrVhZdRPcAhg/KcTcMcnbr697d0E7+F1YPhmlkqSAP6jawwe9XToq/ERt12xow8Od3i37c1IiwibQl614UuZAA4ss9IQaULnHUS4gIHWXXCWVWulhsdxV11IZGZJPhQM7HnTUV59H7ILj0UHTFFsnB8p+aUqTPNp0G1OrSXy8Ap8QzgkSQWYxSGUlY2EmU/hPGqsLM2nM170811Mj3Q8GHlZyB6/WP5CazfochnpU5IPQPYC0iDkjxx+7jBHlsBnZuGUPDKtWdCJi8MvIEJxsdRZAogVg5Ewm7nFCxBC53PQoBAKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MNCOcSTU; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MNCOcSTU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6xD33Swtz30BR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Feb 2026 01:24:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8CC44600AD;
	Fri,  6 Feb 2026 14:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C84C19424;
	Fri,  6 Feb 2026 14:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387841;
	bh=Do+hwWPxjZYbNWyybj7BAgIt5vnOwzvEtgVy4FMIXwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNCOcSTUpyOl9Q4mQMbIw/URy1l4D0S4asdOyftfsDcewue8Dao7li7nylw6jdcwE
	 5xcCiyjI3UiF0TauFM9tLjJ8X4dezh3KXpax440RTfP2Ql0TwnHiTyko6XU/bojUvv
	 sZme44B3wIxiPO5Konropk5kzhzrEJrsDg19F4SG4dMN9FqNlYgMtRFZ7sPQ4GZuum
	 GwLqscapKQe5/ksPhSAwloBYLxXkckaoYnECQws7iJQYpvxbnyf/1LOy58zv7lUvmI
	 2qoQ3CyzqCo7aEPiDlZx6WHpY6T2bdtoHv3tqUL6o4SEHwUMgwS/fDuTASEFBuahwR
	 tdeMxn8n7tTnw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH 08/15] tick/sched: Remove nohz disabled special case in cputime fetch
Date: Fri,  6 Feb 2026 15:22:38 +0100
Message-ID: <20260206142245.58987-9-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260206142245.58987-1-frederic@kernel.org>
References: <20260206142245.58987-1-frederic@kernel.org>
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

Even when nohz is not runtime enabled, the dynticks idle cputime
accounting can run and the common idle cputime accessors are still
relevant.

Remove the nohz disabled special case accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 81c619bf662c..2b58cdc326c3 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -792,9 +792,6 @@ static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
 	ktime_t now, idle;
 	unsigned int seq;
 
-	if (!tick_nohz_active)
-		return -1;
-
 	now = ktime_get();
 	if (last_update_time)
 		*last_update_time = ktime_to_us(now);
@@ -835,7 +832,7 @@ static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
  *
- * Return: -1 if NOHZ is not enabled, else total idle time of the @cpu
+ * Return: -1 if generic vtime is enabled, else total idle time of the @cpu
  */
 u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
@@ -859,7 +856,7 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
  *
- * Return: -1 if NOHZ is not enabled, else total iowait time of @cpu
+ * Return: -1 if generic vtime is enabled, else total iowait time of @cpu
  */
 u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 {
-- 
2.51.1


