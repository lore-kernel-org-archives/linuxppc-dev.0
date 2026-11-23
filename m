Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2A606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KkpNUj9d
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY6nb3WDDz3btt;
	Tue, 24 Nov 2026 00:52:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795441939;
	cv=none; b=bWJl3g3TeKHDN4qPkpnBhMAYhpLSXjQ804J4+wycUb5gonLl6rQvDq1dmFYDnCg1hLalgQovP0tWHzYfBfR7SLj8rCElaLNbqG183QO0mmzp9298jnK7OG5u3LDpVvB0akT1nU4CUYQm95shtqW2NGGjnGsdImb25RJiSCb6/smUXEnXr5x2hlWmsi/7osJntHAtAkGgojSaerno44dOT9J1VzBEDVAifBf4KOdI+ePdbTDjHfp8z9bJTRRS3lNdp9Q4haFH4C8BYQEZZZQd2in0/ovVO4WhxbZqNY+rcm0Hc3rfxOHhcVZngnBfXeNLW+qGjugLYHARep7TrTHkug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795441939; c=relaxed/relaxed;
	bh=a/CsYCjZnUT9LdHmBziM6cx7f8RTiWtsUMpbEwB8YcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cpdw5pfxjd1dfvFLDu+G2wutNMScL9f87lZ2SmLZcqcMp2M6mgMBC0zEgfDJytLiObhen09Vp8ZhpLgFsd4/ZnEgTmKVY1OMNACgeClH70RjtVE1LjtaEC4dgfpdc5xXbG47929JaLZVdLmBh+urkmv/BkT96cZJFVTu77+nORE+1nrb9hIytBKAXqZW3rGWhUncHsPwWtgPCtkMrrnodID9VGtK1yh/EJbydC5dsG92/L40AkbxxD5ycyFDqoSJ4BBMod9MWPx/6JS+IajkV753qSY42TRciNp1DrYiGWf2OC/RjQUCs/gRvcOeumLOYacEsWSDlecuJVtYXMmsjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KkpNUj9d; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KkpNUj9d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY6nZ5NZHz3bsm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 00:52:18 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3b3d4d3bba3so1649143a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 05:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795441936; x=1796046736; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/CsYCjZnUT9LdHmBziM6cx7f8RTiWtsUMpbEwB8YcQ=;
        b=KkpNUj9dE5EsRe0oUbyTb0MIfY/GM9EYvmd/CVHeV6q7JgHYyrcO170OS0AA/f/WnU
         FtH1aArYTNqhtCY3niEEjWJ3Zf68XkscHa3hjCgOxrvUuNHXKH3EHsNQedfAQbZAe5WI
         f0TT6WTHBNnbNl1jgFXQ62ShW0d2ga/4/pYBGZaD7fJLPv7GvxFK4ssA62768Nw4RGOX
         DYeRA6k4yGXsEgWWZ3TeXHLJCI12YpCdki4cwADcRG987OrPJlBXwvGOseEKoOCIgxXC
         MYGEtVxK0BpTI8A8jUI7ub1GkTEnQOdXtdScK0VXaZEdE3nWydyqnbIgRvfB0kOp4R2r
         MWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441936; x=1796046736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/CsYCjZnUT9LdHmBziM6cx7f8RTiWtsUMpbEwB8YcQ=;
        b=OLbIQG00YlZ5s86+/M6zTnsZenf4cYk2bp/emphRGpLcz5WWyYLu6GI4BeprAcQ+dK
         aodrcXrXssKUTcORQmaJ8I87mkqBZHJ201up0YMmXgA8W/WR2HM7BLIK3OUdCx52UsF6
         J05lh/C9xG9sZkoTEoS9ApgQj04osZJ4X5md8YQXvJzYGChcc0PPNZYmVXuY8rhp2W5M
         lwre0beUlOggs3Sak/XUtffbQ8G30P1p/7LZL/935QuMbU99cR2WFKNxxEpuIPgY3R/P
         vb2cEc7FNQGsLaLUY+ujTIPFKVKvirI6+CAvF+wE12GxejDOwYMcVxbVYrEBGJyhzGPZ
         5BCQ==
X-Gm-Message-State: APuU4Z9IKH5WEdTjmc2Gho4bctBEGuUEG//ulwWt/139PfF/55HDIoye
	OHdY5DATbl8dfzNC/Kh9dxCIa23Gv6w/kotzipM8l/ncHu4jeAkQBHwnvtNCVQ==
X-Gm-Gg: AZFdTZdxQlBk/R4Cg5HkXa7OeL3D28jzlH9iZ3ffKAXCIpHYHG6/ocwIx5Ki6wR/jgt
	rT9CCvONOKJc/q6kgd52SZx+4NAYIP+uQvkZQLQr1XuSBB5b1wl/2CLxJwMIBGW845DLHWro4m7
	xUpQ49xGSr1a6tHThXx5gMD2LpsOKIaMLJDM2jE4eEWtEq2/BqG8B7bBcritaniPdcznkJMK9kO
	u2TGa5ruEWHFRi3p+bpPKXSzHHcKgSL+uX7E4X+HeldJFNrBTkYvDnRCuU/VBKZVgGkTA8CCy9N
	U9DvoozM3nEFUE9rbxo0QRzXHjYyoQ5/whqD8FJ2i/Cdom7X4B6K/pEglx2em8bBU8iJg3B6H/5
	dZMMAgVAMqqKpjBUDOFhCHp4Ik7hRq5g5XhWZ0tGgfeHRggs8yU+W3/1MJ6xUThgK+pmQLjhZjS
	0sROgUehU/RWWW6A2Ho9MmpD1DEkQ6jfDS4tPXVlTfwMVL3u7iNyGPlOblX+lGxWmsHgijk3bgA
	DS8YJrq9c4MNLMRU5pwrO7HRk6t/u615OVBxkHDSY98QWNQZ8VC1mV5ppmOFbtu/qkTS9rNtJJE
	cfxzOfFgVjjgkJTRd72CNN2v0h03GbBEIg==
X-Received: by 2002:a17:90b:4ad0:b0:3ae:9944:3bf0 with SMTP id 98e67ed59e1d1-3b41c938c77mr10300495a91.34.1795441936461;
        Mon, 23 Nov 2026 05:52:16 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ec698dsm20842512a91.14.2026.11.23.05.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:52:15 -0800 (PST)
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
Subject: [PATCHv3 2/4] powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
Date: Mon, 23 Nov 2026 19:21:51 +0530
Message-Id: <8a70fa42449a63a73b8340d3296974cc519b5826.1795441238.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795441238.git.ritesh.list@gmail.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
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
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
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


