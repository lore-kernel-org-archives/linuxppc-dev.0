Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0F6606A6B7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ADik9ZiC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZHSN01MSz2xjN;
	Wed, 25 Nov 2026 22:26:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795605987;
	cv=none; b=WYcidumYrK/0Rm53ATUUSaGpIpoFkfpSM5B+mVp4D66rAyyiHGsky9anTZSqKy82hCshJWPhJE+sDZfz5rOzfnUxG5CahWi2ijGWlM/qZvnko3oLqlguG7gG/jwXyzcuG21r8JXbCLFobcSUKgQENl8XEaCrvz/FubnuZ9kG0CSsDjZ10eB2kRn7DyaHLRAKe3akLi/H+s/WY8lCvRx5bYl0Z9EvD5cBk60vRk50VWFBE81kaz+MF0RImdAsXTYzY0gJOVUpcdwcTmbP4zo0dgXNLqNgmdf//vvt062FxC3YdZeyh5n489pyzvttJEQDnb7sXLNsctAz3uO+UUj5kA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795605987; c=relaxed/relaxed;
	bh=FPpoQE6KUvyWN2jX7u+574bkZWMVb7HlyPTqHT4GBCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DvyIWeqe0T1VWJw/Qwp9mRwWhuwpY3DqHhr843hjTh4P8y6WsTedA4DAQQnPc6syJiw4+vgWsliftewg9DGI5Rj+IqkVjbCMf93TvovlmglMsXs5b1pIjTv11ZysbEgoZOAqw3CDO+TP8jRi1Vgc9tXFomuIv83dMUuXw8ZWiN+5a57I+uyB5EaM7CEN6wDJ9JTLqei6mutTdHqdZPYDT9XWmoxpbOWQKhf1dYgCUko9oe5kLRO1kovMS1jVGrqjIn5mZDGmGT/enzhWQscP5IAi76q4az2kfgj5/GmFPHYC7/+PCIxyto1AZlG3qv2ro5zB7g0fY1enfl428p+i9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ADik9ZiC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ADik9ZiC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZHSM1nFQz2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 22:26:26 +1100 (AEDT)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-3282db206d3so5530635eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 03:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605985; x=1796210785; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FPpoQE6KUvyWN2jX7u+574bkZWMVb7HlyPTqHT4GBCQ=;
        b=ADik9ZiCvEOWFoJL9Dw6w5dYQgZXxw8/clGnHGlzRF0GMj/fpNZLKBVZDgu8YckWXe
         wVZARG9Pj7LhmwerM68Uy6UL6G+hysqcnw5g4e/ri7Agh+c249jL9pI6iuelkCcgfVFf
         YunnwV3sDSEekbxhAwo/lSK2HRN9mGTgxoFBPf3Icnt5yaFWgeoq0HJ9iKzx68QeXycy
         Ia2DDQtgzyj1vWYiABHd6DhB8TXrvshWTdUMjHCmQ1UVbxiCczcCY8aGlOccpFMLqD98
         qBHHqWSJ8AThs5/YFsowjX3VZvmF9aFJYYHmxPhmR3nY/lOuDstzr7EPwmSzna3Y2UuC
         5pmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605985; x=1796210785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPpoQE6KUvyWN2jX7u+574bkZWMVb7HlyPTqHT4GBCQ=;
        b=r2BF1piuoLdz92MxMAUJ350WwQTYjdoMJTR4j8hm59bGBW8eb7sfFOND/09xnxBf0t
         lzhULKUgDidZa/uu30zxGp2r5QMZmlPHwctBRsYvsUFy23H9t+nEkcfkpM1S2CSPTLXZ
         ceEh9ldqOzMkM24ooM6VpewEh/Dn/hTioeG0k+NlXTitlT485F24MNA45sVF+U1OS6H3
         eSpfnVkDc9AZ3kLoLeRpx7y5B3wDWj7htWU1pyOjcNWdzKlvfXHQ1NRBZf3dhz9kQas5
         qQ1kfNuAzt5hYw0hORV6up8dnS726blPggayTC0D8STx7LPhEAkRExmrBJNSdtnQuTEM
         ANug==
X-Gm-Message-State: APuU4Z+MSxVeFKXyoh8jRpji37n9/p2KgD8viOU7RKNJcsQveNAIlFR+
	ZpPPFkAa3B+UE7aCnl7ySw8rpT3bVLYwx5x214SqC840ibICESydWvXPDcA0EA==
X-Gm-Gg: AZFdTZduybyBVX5nk0jXo2NhK7q3yAPdfxI7n1wpuUSkqQULgDsdce1QUi1/mVMCLMy
	MadJ01ZSw7ADtR/38i3T9oQMh5SPCh5RODw0cmOkepfGIA3J8+seRsW60ghLQbmsb4HJfG+rMuZ
	/7pWwLJf/jmRQfHZ8D0G/MY3xYOnWiR1vWiaR5rNqjUdK6bv8VTyyuuXQyPxWDWygxESwAq6fzJ
	zI7rX6jerRHyiYvQUEd6YmChckkW2nVpe2gHGlnMiMEd7OVrRm8suybK2w6HJ33zarR80VkvAwS
	QszpntBFIiQ+78C92SeZmmHD+M9xkFhbQG5TbLtqGvVS1G90wu4vWudqX6h0XUzuwIyEjNE03uz
	VKBxoOH7jKE65TU82kvoUP8g1d++f4uB7Fsmsn/CbdfAsIsDZsnSj4mf+00U23mTmgAhwNIT23q
	c+5LxSYgKsdMgGTRnyFu5xslfUKgil3Kk/3wde/whDi84MjSTyXz46tKf7sPi61fI9ZgoFrxSIl
	2WEBvwKDaBP90muoiiPWe7Nu3elBZ2hUo4tDfhAVF2ciQuRaX/l4k8Npsezaxius/YOPyvWW+xi
	mGQrJqgv5dW0uuk1s6M9cdq2ULEGi1ON4seqP1boSkkV2C96UTP9IXQ=
X-Received: by 2002:a05:7301:618f:20b0:386:ad3b:a48a with SMTP id 5a478bee46e88-386ad3ba7cfmr10073158eec.5.1795605984884;
        Wed, 25 Nov 2026 03:26:24 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm11778380eec.17.2026.11.25.03.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:26:24 -0800 (PST)
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
Subject: [PATCHv4 2/4] powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
Date: Wed, 25 Nov 2026 16:56:04 +0530
Message-Id: <fb07a250216a733b064f8eec672f9e682c3660d8.1795603946.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795603946.git.ritesh.list@gmail.com>
References: <cover.1795603946.git.ritesh.list@gmail.com>
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

Disable preemption across the update to fix this.

Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
Cc: stable@vger.kernel.org
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 44f178e07531..1a8514b2d853 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -459,9 +459,13 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 void arch_touch_nmi_watchdog(void)
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


