Return-Path: <linuxppc-dev+bounces-27918-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBB4C982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 15:12:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq3Vy4sqXz2yQJ;
	Wed, 23 Sep 2026 01:12:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790089962;
	cv=none; b=QxniYJkAlccrQY0oYEJ6k7HLbO+c9eqOhq+E3ovyDNqbM/qzTCrL7se/5hduAHvWSbxRfKIckEyI33P5w/OZiOArRgYxKp7A12O3s9GoC8H2EPwBI/AihKJK4pIEcJ84ThaAu0KKUPZEGzTdbkLtrD3GOOujLEFpEMT0U6KpBbA5XNwV+GjKK8qcRoL87qBa2xF/t1pw/GOc2TMFNnnBTZzGpw8rnQ0gdZ686iJiHLQeopyfTTjRfKx95jHOp6jZ1+FyeJkEgQ/J/9Xub5J7Yy5+TvkybZ1w7uwUFzSX8kRUJrUigK7gzYAj3csUqiS9RvpkL/D4tyvjJDeNAb9IFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790089962; c=relaxed/relaxed;
	bh=TiXadWFU7B6ab0WDVPsln/3CMRKya/0OF/8XBOyxvag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bpvsce2y+3N+DO0wzkp6i4kKfFJo/rc+buKtp8lz/utro5s9gSXxeTlAkAt3G5VbSTYwJ6sOP2usESLk3EKy5Q0HRVVipkOhRWMb9bjcGwWZA323gSeOdLbJmPcKG8M1VONOofpmmU93X1YsvuqhuzoQoSDELWEXr+rJ3VofTD/Zwt/l1YNea4gpTS+4/Ws4Z4KPKzvnfo7dAoA3LQ6Jxn7bLWAH+El08dv6uiRbQ2T9Amb2CMhCC/BAbxaIZskx+pbwusw9GdKpoAPDzr+QxIiYQrBj4z71V2FvugSMAUTECNz9fcIp9koKD2L9OdZ5uATx5XcW1+7+79+aixlbSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BUv+n5BI; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=W6F+Plm7; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BUv+n5BI;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=W6F+Plm7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 369 seconds by postgrey-1.37 at boromir; Wed, 23 Sep 2026 01:12:40 AEST
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq3Vw22V0z2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 01:12:40 +1000 (AEST)
Date: Tue, 22 Sep 2026 17:06:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790089580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=TiXadWFU7B6ab0WDVPsln/3CMRKya/0OF/8XBOyxvag=;
	b=BUv+n5BIGntoaDwlCwSy5DewyYsABxbxgMYdHr9l38nsUh3I0x3MZAGZG1T0eibzQssdog
	S9Owvu5A24GlFew5NWD7nZc+zTVduImD1sgwJYnBp/50DRXwaOY85dvNGsis+XMUp1QYnD
	x6zqSPJ7Lv/vEYXCngDu7mF2KPcKmaEbDbxVdceiEInCMRh5Mq3H/D+RBJ/ilBmY+C33u2
	ojmdRoLbG78vIq/W/heNFeSYnDlGshFttrNwyiTDWj9Q0wIxTu5fT7GeoPZemr57fGu20J
	BoIGcimgwzmT9DUQAKzWihYMi+CINlV3TDspOWK8D90rbfVFhxZWb01W9wlmiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790089580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=TiXadWFU7B6ab0WDVPsln/3CMRKya/0OF/8XBOyxvag=;
	b=W6F+Plm723Su8gjO51/xnwXokhcs4amdMxwVFVLFgNbJtKMvyY99wqgc8MZbywgSPsTk4d
	WK8+l1W8NX2vM+DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: 7.3.0-rc4: DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
Message-ID: <20260922150619.lwWqj1AO@linutronix.de>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I've seen similar reports such as
	https://lore.kernel.org/all/b44aefc5-e066-478b-8d34-50d2d0deab6b@linux.ibm.com/

but nothing on recent one. I am not sure if this is the same issue or
something different. This happens during boot:

| ------------[ cut here ]------------
| DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
| WARNING: kernel/locking/lockdep.c:4448 at lockdep_hardirqs_on_prepare+0x22c/0x2e0, CPU#0: swapper/0/0
| Modules linked in:
| CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.3.0-rc4 #6 PREEMPT(lazy)
| Hardware name: IBM pSeries (emulated by qemu) Power11 (architected) 0x821200 0xf000007 of:SLOF,HEAD pSeries
| NIP:  c0000000001ec72c LR: c0000000001ec728 CTR: c000000000e1ab70
| REGS: c0000000017531e0 TRAP: 0700   Not tainted  (7.3.0-rc4)
| MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 48028228  XER: 00000000
| CFAR: c00000000011ee84 IRQMASK: 3
| GPR00: c0000000001ec728 c000000001753480 c000000001248000 000000000000002e
| GPR04: c0000000015ee8d8 c0000000015ee9c8 0000000000000001 0000000000000080
| GPR08: c0000000015ee7b8 0000000001000003 c000000001581400 0000000048028228
| GPR12: c000000001788228 c000000002340000 c0000000005bbd50 c000000000ea30f0
| GPR16: c0000000016cec98 c0000000011a1518 c000000003327658 0000000000000001
| GPR20: c0000000016c9620 c0000000015e3c80 c0000000016c9670 0000000000000000
| GPR24: 0000000000000000 0000000000000001 0000000000000000 c000000001788228
| GPR28: c000000001380580 c000000000027644 0000000000000000 c000000001387160
| NIP [c0000000001ec72c] lockdep_hardirqs_on_prepare+0x22c/0x2e0
| LR [c0000000001ec728] lockdep_hardirqs_on_prepare+0x228/0x2e0
| Call Trace:
| [c000000001753480] [c0000000001ec728] lockdep_hardirqs_on_prepare+0x228/0x2e0 (unreliable)
| [c000000001753500] [c000000000331c90] trace_hardirqs_on+0x90/0x130
| [c000000001753540] [c000000000e257f4] irqentry_exit+0x554/0x10b0
| [c000000001753600] [c000000000027644] timer_interrupt+0x254/0x5c0
| [c0000000017536c0] [c00000000003a2c0] __replay_soft_interrupts+0x140/0x390
| [c000000001753880] [c00000000003a614] arch_local_irq_restore+0x104/0x1f0
| [c0000000017538b0] [c0000000001eed9c] lock_acquire+0x19c/0x440
| [c0000000017539b0] [c000000000541024] __kmalloc_cache_noprof+0x114/0x630
| [c000000001753a90] [c0000000004970c8] shrinker_alloc+0x38/0xe0
| [c000000001753ac0] [c0000000005bf374] sget_fc+0x364/0x940
| [c000000001753c00] [c0000000005bfd78] get_tree_nodev+0x38/0xf0
| [c000000001753c40] [c000000000649060] nullfs_fs_get_tree+0x20/0x40
| [c000000001753c60] [c0000000005ba01c] vfs_get_tree+0x3c/0x110
| [c000000001753ce0] [c0000000006043a0] fc_mount+0x20/0xc0
| [c000000001753d20] [c000000000604544] vfs_kern_mount.part.0+0x104/0x120
| [c000000001753d80] [c0000000006045bc] kern_mount+0x2c/0x60
| [c000000001753da0] [c000000001296f20] mnt_init+0x3c8/0x50c
| [c000000001753e80] [c000000001296610] vfs_caches_init+0x100/0x144
| [c000000001753f30] [c00000000125442c] start_kernel+0xa4c/0xabc
| [c000000001753fe0] [c00000000000d688] start_here_common+0x1c/0x20
| Code: 4182ff80 3d220054 3929106c 81290000 2c090000 4082ff6c 3c82ffe7 3c62ffe7 38846858 3863dfd8 4bf32645 60000000 <0fe00000> 4bffff4c 60000000 60000000
| irq event stamp: 472
| hardirqs last  enabled at (471): [<c000000000e39034>] _raw_spin_unlock_irqrestore+0xa4/0xb0
| hardirqs last disabled at (472): [<c00000000003a5b8>] arch_local_irq_restore+0xa8/0x1f0
| softirqs last  enabled at (10): [<c00000000012db60>] handle_softirqs+0x670/0x6d0
| softirqs last disabled at (3): [<c000000000016f88>] do_softirq_own_stack+0x38/0x50
| ---[ end trace 0000000000000000 ]---

Sebastian

