Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A649606A329
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X9St/jtM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTRpz53zfz2xnZ;
	Wed, 18 Nov 2026 01:25:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794925547;
	cv=none; b=XQ+m6qrNfdgU/lVgNXfHiu2JDgugPI+fyWUd+O02diKVyS5878hEP+pULBoW5bregadgNS+/iQ7JfMWrxS7+x0o7Lr/c8+MPMxN1H/NGqjGKyrlEV8WaFLYVEhZHWMjgVT1NBjTJ7TFtuYFTwMAlERKcWHooXpZgpWaZNt2EBcCrm9aj3Z1awHfT3bjwkFBydQzLLLnvmwkJ4sDju36RCYnH2GR7tQLhe5UH7hk06hxjl4mOlsjAqn1XEk16CqFAPQA5N0ZOq9pKXvarFg5xD8itzQ+jWCckTHqwMr831PLOiPZlngi/6IA+d4oEl3axq4GkjCdxOrJhmCZAhuggTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794925547; c=relaxed/relaxed;
	bh=rjmPFH4B/D4fb22VPFX9Sq3mznItdFyAVWsb2qu0yoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WdYLBQBeAh9R7qcAOTwB1PBEwHRR5dw63NmwR3uJNOYwpA3KNBVqytOe2Wk6FznVH3YmprRo0FpSsTh7w/nZ6m/cUnH6yHvxBKnTzaj3BCWiOwQTFaBW6X79dOWqQ152g35xpkFimuRzi3D65BvgENSaCJDowt9HPkDPnAsBeOrVaNI1/AIr+e9oTkyZmaK5sv2r5JqTYfaZe6RN3jhEBxUUZS1Vsijxzdj6bsRf/B3JDezFY3jRu3Whb9eBgynIbhCJjwbfMzbC9SJt/ssJozFWZnN9exOsZ4+DHIyBhVGk53Ei+Q/fyGDlOGDfwtNFonGDPDC2CpXTAoxhSXeI4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X9St/jtM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X9St/jtM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTRpy6SpTz2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 01:25:46 +1100 (AEDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-706113e92f9so3372841eaf.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 06:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794925544; x=1795530344; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rjmPFH4B/D4fb22VPFX9Sq3mznItdFyAVWsb2qu0yoE=;
        b=X9St/jtMpQcTQsnhYBcpu6wfBZUg9HzqXl+uDe5G9QMjbl+R2/8LvwkWSZkznKPjCs
         JakpVrq33EwlEiPvmWt9l1tCfS82CJXqrEz43XQIKEQXc6/M4+e9C/bONvOgDyAiZZ6h
         T10jugCzpVKS72eGLUynOLsUyFgZfOWT1VXDbIMLsCKlcbQXRI3rC/0chQ5mY6YUc0nc
         3hbuv1m55NrSj2eO68wxaWnprtV3QP9P76qK6HiKJlX6FpaJabArbr2GCSRUS2GgdkdE
         l7kAjm/709tb0QAjxbuFR/HkrEe0RFG28zAT9uPYqVCKSXjT8C7i9QBq78eiqJ1uy6dX
         3KGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925544; x=1795530344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rjmPFH4B/D4fb22VPFX9Sq3mznItdFyAVWsb2qu0yoE=;
        b=Lu+WbLnm4aB+2k9y519XdR+hYgiD3CDc9x5blENnXGsQS/HVcvWbQtEYLD1XpCUsiY
         /8vYRitcwrmnAvCylHrnmzjNoOriYU2RQfcqXy42zV2vHn/Gl/rrwqnGvF1TO0FnKdOv
         ns9Gq6A6+/K7U/ZVUw9L0e+Om2aiVdj6DsZ1cws7klMwqqx7CyvXRiPCKRIO22SBWiV/
         xnWtK5W53epgBzFzgopST0AfXJ8mWcCpsNtwPnqLgs9pjMpHIKkfSC/hku7A6HmMYp6e
         3Bc0UDG68E+Yfv3prKuHZBC1W/6Cgzz5jnKvPDXB3hGD3ol2I9dxUKIlihKVfEODns97
         CZ9w==
X-Gm-Message-State: APuU4Z9lZFqvFo+Qo79VJKigtlt1V7BCPDlGpKEEgTmI84kgjl4toWtH
	ABo9hp/pbVhEIaEauWS8gP75RW2BEKG8jImuGh8cq02ID51S7zprSYBBI1FERA37
X-Gm-Gg: AYBFou1in3XzMlA31mYlt1/t9k3E4fSSFxRzTHJwQQaWgGRZ/T8VgNw7gCrCMQbw9/A
	rORaX0ctwcdmj77/l6AIRSOu65SvQ/SVGB6hCPMbnN6DpfRAw+6dsc0rY7GX/x5cjuEplW7BBvL
	zDpCaUt4j2ZMr69P9cnGZCjfDIBQWDTr3H71Z0+r8zsamwZ2E9FAk53MW9wwAsS7QrCdtFu5NcV
	vcg8xyKbe9S5guv0Ou3TZmJPgFpSnFGzCiguT3raTvl6Jw2+4rXc6UgJfKDc36eeL/L6b1/8kbI
	AFYc3pNfmOd4dxGpQtVCOrEYfys7M8Ik1KpgtWO3VyVA4S/E6a9mrpeWo3wzY1dxtPjktNowg1Y
	1+YMvElEIbnFByBkKstskwoDaiFqfiE09Q4wV5pPrEw8wqxr8EtwmWmT5cftDMy62pgdJ0ZiXY4
	hOHgxnPrT2o1+6v+i/JMHl4gQVz3PJUQaBd+41WmUDeVVqSEXXUPXb/Ub6H+y+ApfVEhWh6LHPU
	Yci6R3eHYKwmt4to95Gy/m3aNUHomQHSMzVkk5CYpM4rb6GGysDQdOKbqXUV9W4qwQWhuTvfZgN
	1iT3FIMnZzfkUv9qKfkJElg25b0DVWdK2qQ=
X-Received: by 2002:a05:6820:3388:20b0:71a:eea9:81b7 with SMTP id 006d021491bc7-71aeea987dfmr3362475eaf.54.1794925543956;
        Tue, 17 Nov 2026 06:25:43 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71af0a8a18csm5313709eaf.4.2026.11.17.06.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:25:42 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCHv2 2/4] powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
Date: Tue, 17 Nov 2026 19:55:18 +0530
Message-Id: <3cb2893bf883be87ea1c3712344ac03f727937d0.1794924821.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794924821.git.ritesh.list@gmail.com>
References: <cover.1794924821.git.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

touch_nmi_watchdog() can be called from preemptible context, e.g.
sysrq-w via /proc/sysrq-trigger. The powerpc implementation uses
smp_processor_id(), so with DEBUG_PREEMPT we get:

  root@buildroot:/# echo w > /proc/sysrq-trigger
  sysrq: Show Blocked State
  BUG: using smp_processor_id() in preemptible [00000000] code: bash/238
  caller is arch_touch_nmi_watchdog+0x3c/0xd4
  CPU: 0 UID: 0 PID: 238 Comm: bash Not tainted 7.4.0-rc2-00029-g7664547149ae-dirty #126 PREEMPT
  Call Trace:
   dump_stack_lvl+0x138/0x150 (unreliable)
   check_preemption_disabled+0x120/0x158
   arch_touch_nmi_watchdog+0x3c/0xd4
   show_state_filter+0xf0/0x338
   sysrq_handle_showstate_blocked+0x24/0x38
   __handle_sysrq+0x134/0x3a8
   write_sysrq_trigger+0x178/0x22c
   proc_reg_write+0xf4/0x150
   vfs_write+0xfc/0x71c
   ksys_write+0x8c/0x150
   system_call_exception+0x310/0x590
   system_call_vectored_common+0x15c/0x2ec
  ---- interrupt: 3000 at 0x7ffd01755b98

Unlike the generic version, which only sets a flag, we update the CPU's
timebase stamp and its SMP watchdog pending bit, so a migration in
between touches the state of a CPU we are no longer on.

Disable preemption across the update. While at it, let's also mark the
function as notrace (since we might be within a tracer when this
function gets called).

Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
Cc: stable@vger.kernel.org
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 44f178e07531..32d4e716cb0a 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -456,12 +456,16 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	return HRTIMER_RESTART;
 }

-void arch_touch_nmi_watchdog(void)
+notrace void arch_touch_nmi_watchdog(void)
 {
 	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
-	int cpu = smp_processor_id();
+	int cpu;
 	u64 tb;

+	/* Callers may be preemptible. Stay on this CPU for the update. */
+	guard(preempt_notrace)();
+	cpu = raw_smp_processor_id();
+
 	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
 		return;

--
2.39.5


