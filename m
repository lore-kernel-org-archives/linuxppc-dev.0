Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8364606A32F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 04:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZmO6y6MP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTBDK3Y82z2yb9;
	Tue, 17 Nov 2026 15:13:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794888801;
	cv=none; b=ioc/RajS5s8KsQT6pBqz/mIPHlA7ih23nW7pbfPz7Vqc2nI7GR9i+f7Touou42adnTQoNpimf+4YpkFaIC+A8U7cdDzBLJ9BnixEFysSZSwOZ46Ijtne7or5GC2bzseQRnShabnEz03wK9g0YBz/RXlzbLQGmRh2Tvt8quzSx+mtk5pIvfLulpP58YlyMGknMegvkQ1t8zsEoGUxt/ltXs0KqcXdMO6tpVC8iqg1TVEI1WRRUgffUURlZ03PwJtFgoLouFcLdCEe5qTDkYVZp+G+CUiF6sVHYJTBmjhLR5fE/WLLNTk4uZaB6w6m6pim/DIpfhbW/dVV3oC15aN5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794888801; c=relaxed/relaxed;
	bh=IlsaCHEk58qGFGAb0OAbGJOtQIRxROfDzkwINL2H/Is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U1Yx8Bureu2Tw3zRegGue2uFHlLbOIAhcVAg+EfMKsAEb9XhsWgVQcVyfC1IggmdiDOaWHpbTcVufZMecCKH3fDqOgRiFoSr7Pc45OiSqDif36x2F58lT5xCajwgREUVVfiFLZjRc3VHC52VMD/+tUfbvXcYh7YwaRvDRpP2/UQB8vbmxw+BxPcCF9KD71iA3vc87Y67Tee7AQIJhKK1nAMJ2L6XaMW717UiGIOZ+QjYUBtXtBbGUBryXqYXTsKdL258x2Yz7FoXcaWHSgKspB3ImeNr3sfGvINVMHzzrPUgNPu2lDPEiq87Goaa6KwJlB7UGW46rJ5BJrQaEZ2R/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZmO6y6MP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZmO6y6MP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com [IPv6:2607:f8b0:4864:20::122c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTBDJ5HlZz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 15:13:20 +1100 (AEDT)
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-1b244fb7fffso5089378c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 20:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794888799; x=1795493599; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IlsaCHEk58qGFGAb0OAbGJOtQIRxROfDzkwINL2H/Is=;
        b=ZmO6y6MPodfORD3TTa22/U2AcjCnFXhvQrNvN1FIEO0BPqOzTyqhGlDJPoLSnJAFzK
         XgZsb6deSz+b7HodkffFcsdFzoPXWK/5OC8mgEEohCZ+1nKY10NNkRjl28Xvb9EDjYZo
         cyx1pUHStOI3TsUBIXBDhpNKi/zE6XX/dryeaI7z7WgHTI0TwiP7OTpQArOQMWVMHE6W
         0mmcviccaYOUAuamIlD8n1S8CvTuqaaMjfd1ogOvxzj1NNH3jRPdztUYraMKpoyMAMjA
         xTpZf1mYKrqlVvKNTms4TvIyXrqDmL/hwRbzcR+g7eJcPl+bL8D8stfdRNzkRiKmERsJ
         yhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794888799; x=1795493599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IlsaCHEk58qGFGAb0OAbGJOtQIRxROfDzkwINL2H/Is=;
        b=jnVkearEaiQxQb9z8UKZXYS7PZYfIIKJjSyipwnNYIU2E2x1sfayy7ksYztIJ2P1Au
         odnUvXTjd0UwGd/U1xP/H4q834aUh54g2BHLYNm7EyqtCQ9FqhLGz48myzp9f5ZaKYuP
         Bnbis1D/8H6gjojz2PfnO2O5kx9V66QZrgv/iyN1G6BGReKQUaNjeuz5j4Bn79U9F+Oy
         XmAsjJ+gKZqknhwXDKpYZa4PEyNnyiMN8Ys1EB5ZUnfqA8u/c7zajP9TWaN6KT7hIwcq
         d/UJYhSdnbFeclGBQtkTY4ud9AVlP224p3D+VjhX6n3ITfsHRkvCUWx1U0B8eehcx9iy
         vUgA==
X-Gm-Message-State: APuU4Z+aTg03tMG2Fmi6KPrxP5CIZNHNlLltCwM5VOGXjBzYieEW5P4E
	4/xG5ZVE95GT4WYrSCA4I+fKxC3tenBDZ/Ko5VopDcMbqepiwEAvwdwTNfQgTUd0
X-Gm-Gg: AYBFou2pedq64StZYxHSFM2CxgoQ8ZMTF8Q0mMszTKc6uRLW7ypBFXCzDE/xAG+rjEo
	RQgnivBAX03YtL72l99tBGdYChBGLbNoeg9Qz9kjzxz3u2/gHJBBNOmiaJYyDH9WM7cQGd+Mkzy
	LiBEvgh349AUIbQWtSr+FBlS9E/7UV+7Ne7On0GjzHTyN2nmgzmATcQ/3E/8O9yNjhb06FqURNz
	kH4PzDecjCI64JjNo7wa2Ui3/3TmEO01ZtfhpVHgmEoALNzDYdAWRIQAUdMQO8fe4KNVmJ36HzL
	pmFYmtH5WerlZJnnvfvw7FiUneFJb14tFt0zgKry/tauu9bci/fW9BUfvzbBusjaFBCxGjteFJw
	VDwPAw+88vNyOSqVuv+7XXLk/0PKrvNyhbbnc8dkfjGE9T3Q53/j2Ze35r7+rVlsZbq9jwPqFCL
	oRwwoKZs2Dyo32KYnk+3yAOMOF0Iq5lR651N+nlMVPJ/2D+z38STPGYENO1HsZoQT7JXNrHdAmx
	00+6i8mJ6udXNAsJ8S9SFvtVNkedLitPH8q7h5iHLBkbKjLKMeu9PTr9IPi+fb4TNKkz90mJcjE
	vT+aFy9Jq4DnBRBQaN3Kx8cLcmyIA1hB4w==
X-Received: by 2002:a05:701a:cccc:10b0:1b5:3616:599d with SMTP id a92af1059eb24-1b536165bffmr2485931c88.35.1794888798411;
        Mon, 16 Nov 2026 20:13:18 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm40433851c88.14.2026.11.16.20.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 20:13:17 -0800 (PST)
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
Subject: [PATCH 3/3] powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
Date: Tue, 17 Nov 2026 09:42:53 +0530
Message-Id: <a2ce5073c33127d04aed012e586b2ba708d7ff26.1794887659.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794887659.git.ritesh.list@gmail.com>
References: <cover.1794887659.git.ritesh.list@gmail.com>
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
index 44f178e07531..61b67dde04f2 100644
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
+	cpu = smp_processor_id();
+
 	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
 		return;

--
2.39.5


