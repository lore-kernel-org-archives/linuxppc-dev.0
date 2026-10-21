Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E411C606A328
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 05:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gf7G1XSH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8dQD4mQdz2xLm;
	Wed, 21 Oct 2026 16:39:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792561172;
	cv=none; b=OLXV32aQ0TRTc+l6T5R7JCW3VEC54JNw1bmT64LcuMnjoT3Q9NwRVMCf4tFLgYhi2+jxELXjNJ+wd5tev2AfkkJ6iPJnzHg0M5MkLCJpNMGyfjvPEx40B2mEghBvzC46G9K4Lmdw5URou7joGGVqmcHHIuMdWqSIbFwQnzWrBUNqeN6Rk8ZKtMNfzSPj6qJICQbdDPGfZ0urmkAYhdgVAu6H0HOLDEHWDPAxviZxzVSsPSNM3/Z9Hr158B6cc6P2pmjyuX4EomL2foJsQCH6Wj0v3zQYSaj5VQCLPTZCC6q0lmNiYijAnWGTqkQJQfePkCD+yXZ/6+9Au3T465Lguw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792561172; c=relaxed/relaxed;
	bh=TnOW/P9t5St/1xN0d8b1YgYT14hih4Z7CV1qA3BWNBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qec0er+tx24rNk85raB/hm9vJhx6mT8hFvQl1IAGnQiLAc82X2m1TCcyIPwwVH2LptqWDiOa7DF4V3Lu9ZgAurXHKbbQeCICojNKR4YSlNHjdiD6ATRqOwWAUlnC3tnnMP0InF4BYtOKw8ZXg+/N+O7CBVqMymtyGe13p7m1Fx+X0e8xGLQAzFL8gXjeKVTjJsHdjutOfDGzRRKdBe//95qF7W22ztbMYu6REOi0SAXnHkIrC6gP14JpsG0Z6KABZp74UT+A+K0eRDDKQT4IaleYy8baMCKWg5ctFLo8HbdG+Sfkr87nE8/VfVL9oMN94qelzhtzJMbveMyDLCtmkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gf7G1XSH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gf7G1XSH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com [IPv6:2607:f8b0:4864:20::132d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8dQC14ZTz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 16:39:30 +1100 (AEDT)
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-35f036b17easo931763eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 22:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792561168; x=1793165968; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TnOW/P9t5St/1xN0d8b1YgYT14hih4Z7CV1qA3BWNBM=;
        b=Gf7G1XSHJZakG8PIyvJvckq8LVmMSR4E57CfPXmdbYXMfDilIru84YWrflGIcCrOgA
         47IC4nGdvmTcN0nRxBFezKhS3rTt3AIgwGqlNWECZoKZy6tOxwsLsr4bXjJs13bzyUoi
         libuD2Vz6+JX4hk/QqXEXxn7/ImLpXR4znNezey2rl66FXhi7OQ9iIF9Mxr8/3gnseFZ
         PDNyQp333NaUIw2oLEfuku85s75zgkOsBjYD51sGoz/EY8jyDCayoQZYxWhg8MsCPa9k
         a7kAulNcFsdziffKmDBJnvH/t9ugvEXFdqaSXjQH3UD6NqoWiJKbyHRqlPZH6UZIxDkF
         QePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792561168; x=1793165968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TnOW/P9t5St/1xN0d8b1YgYT14hih4Z7CV1qA3BWNBM=;
        b=suqZ29iFsRVArf41i9sEEops39HF4eBTvUiQ21zF5Q/5iivHsscXuvzRGRWRi4hRhC
         fFzv4KDTrk78xDuCsYfTvzTpicWhMhpGvwVvqeJgtymj5AlQa1E9Vrvu0PLnysiu986h
         6VtL8PDvHkt4KBi8X3pF15etI/FE0RXgjPN4/ZgivGbydHI2S5UL5se2kVzSBBIPHzD0
         sx+tJi08vGWdUZdu4GKbEVXi/eG1mIBbtSo+kDvLhXbE0Gow9IUU2DTxE5uZk8x1QYiJ
         /tQIwTChALUVVjWUAKE8H7fzQsahoUncBz9vb7CXHDHjXmQfVho1rrEeWVgzyFYF22H/
         N9jQ==
X-Forwarded-Encrypted: i=1; AKwUvByomh2t7Ljftk3DtdLE0SK4l2vNFMofJ93kr69o1u83rEqlWQ+qDxweqAbnBGockZQZYGVreEBKQhJV+Mc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK+Cqo5MZV7NeeQ3yn1KILUBEv3X6XBa7KK12cSxWaRU5mpTceS
	YiqceXzHTq2iZNKj/JwTYBVoAfGAHOk8HE2thMwHKfwPDhJ35AyCccLY
X-Gm-Gg: AYBFou2SPyn+EPoer1u6vKbIxQnARzwrQMZAGHCIvnSwr9+AN1lQkB7FIawGUatV9dF
	ihxMxfKmSe6MAcdKCecBUs3iWJ7euwSIjwN6CGEqZBl1lQo99+GDdvx/rF6NITZ8NQq9URVd5dP
	X4mVgLDE+Adpao+YNmeiah89eQrfrNIPDR4OEFIgaG/zl74x0ubGkPHbcZZ9IuVgiJFh1o/7flO
	ahKDI1K7U9OKl7G0/ZmNkhDSiyJ2UxrpLgZAAvXXMLvkgYoDhXCLYd/+TtIMyGNAwZzcEGMEYvk
	T8Kyf1Q1wvKkuekDSlwX2nXoiasTCHLCvqDep6u2ir7vjRU1fvUczpLVE7gQMX6tAJzqpV330+1
	30mYevR1YexKiTipeqyp0qfVk1jY3xtiCvRKrqPfceXATKUB0/mTcIO1GRtG3bzCBMVMLynqgSK
	aqk97RJioJLbFjofga3AywtT795c7Bsnz63ytInlSa1tX8IoizrvsllJVk+YUUTQKq8EaRHmY2G
	VVz10vY/jJ7lSl0GuhuGJakt9Oc/SJEbKDu4jUxWf3HS0VQ2uDa6YBA4HN147XL3vzfmH2yXucx
	JOrp2zn4bJqc4yoY7FA6Esb3BrV8WrCGu6/xcm69WEJuyqg=
X-Received: by 2002:a05:7022:61a8:b0:168:3243:c910 with SMTP id a92af1059eb24-190a6adcc45mr2159610c88.13.1792561167798;
        Tue, 20 Oct 2026 22:39:27 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm3350955c88.3.2026.10.20.22.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 22:39:27 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:09:20 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Srikar Dronamraju <srikar@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [next20260529]powerpc/pseries: multiple WARNs: RCU not watching
 for tracepoint and lockdep_hardirq_context() during boot and cpuidle
 (Power11)
Message-ID: <athOt8vlETgvNqrH@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <b44aefc5-e066-478b-8d34-50d2d0deab6b@linux.ibm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b44aefc5-e066-478b-8d34-50d2d0deab6b@linux.ibm.com>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Jun 01, 2026 at 06:57:46PM +0530, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> 
> I am observing multiple reproducible WARN_ONs related to RCU and lockdep IRQ
> state tracking on a Power11 pSeries system when running on latest linux-next
> kernel.
> 
> 
> Environment:
>   Architecture: ppc64le (Power11, pSeries LPAR)
>   Kernel: 7.1.0-rc5-next-20260529
>   Config: PREEMPT(lazy)
>           CONFIG_LOCKDEP=y
>           CONFIG_PROVE_LOCKING=y
> 
> 
> 
[...]
> Warning2:
> 
> [    0.010098] ------------[ cut here ]------------
> [    0.010103] DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
> [    0.010107] WARNING: kernel/locking/lockdep.c:4406 at
> lockdep_hardirqs_on_prepare+0x22c/0x2d4, CPU#0: swapper/0/1
> [    0.010116] Modules linked in:
> [    0.010120] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G     W       
>    7.1.0-rc5-next-20260529 #1 PREEMPT(lazy)
> [    0.010125] Tainted: [W]=WARN
> [    0.010127] Hardware name: IBM,9080-HEX Power11 (architected) 0x820200
> 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [    0.010131] NIP:  c00000000031549c LR: c000000000315498 CTR:
> 0000000000000000
> [    0.010135] REGS: c0000000045bf100 TRAP: 0700   Tainted: G   W           
> (7.1.0-rc5-next-20260529)
> [    0.010139] MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 44044228 
> XER: 00000005
> [    0.010147] CFAR: c00000000022e9d4 IRQMASK: 3
> [    0.010147] GPR00: c000000000315498 c0000000045bf3c0 c000000001ccf100
> 000000000000002e
> [    0.010147] GPR04: 3fffffffffff7fff c0000000045bf1b0 c0000000045bf1a8
> 0000000000000000
> [    0.010147] GPR08: c0000000029d1230 0000000000010002 c0000000048b2b00
> 0000000000000003
> [    0.010147] GPR12: c000000002d514e0 c000000003ea1000 c000000000011ae4
> 0000000000000000
> [    0.010147] GPR16: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
> [    0.010147] GPR20: 0000000000000000 0000000000000004 c000000000272684
> c0000000029bb0c0
> [    0.010147] GPR24: 0000000ebc171000 c000000ebeb63850 c000000003084d00
> c00000000308b2d0
> [    0.010147] GPR28: c00000000002a488 0000000000000001 0000000000000000
> c000000002246e08
> [    0.010188] NIP [c00000000031549c]
> lockdep_hardirqs_on_prepare+0x22c/0x2d4
> [    0.010192] LR [c000000000315498] lockdep_hardirqs_on_prepare+0x228/0x2d4
> [    0.010196] Call Trace:
> [    0.010198] [c0000000045bf3c0] [c000000000315498]
> lockdep_hardirqs_on_prepare+0x228/0x2d4 (unreliable)
> [    0.010204] [c0000000045bf430] [c0000000004bb778]
> trace_hardirqs_on+0xec/0x1b0
> [    0.010209] [c0000000045bf4b0] [c0000000015ad574]
> irqentry_exit+0x58c/0xe1c
> [    0.010213] [c0000000045bf540] [c00000000002a488]
> timer_interrupt+0x210/0x564
> [    0.010219] [c0000000045bf5f0] [c00000000003b960]
> __replay_soft_interrupts+0x14c/0x374
> [    0.010224] [c0000000045bf7d0] [c00000000003bd74]
> arch_local_irq_restore.part.0+0x1ec/0x224
> [    0.010230] [c0000000045bf810] [c0000000015c17d4]
> _raw_spin_unlock_irqrestore+0x54/0xac
> [    0.010235] [c0000000045bf840] [c0000000002cdd54]
> set_user_nice+0x110/0x220
> [    0.010240] [c0000000045bf8e0] [c000000000266a94]
> create_worker+0x13c/0x310
> [    0.010245] [c0000000045bf9a0] [c0000000002726f4]
> workqueue_prepare_cpu+0x70/0xe4
> [    0.010251] [c0000000045bf9e0] [c000000000232604]
> cpuhp_invoke_callback+0x1e8/0x3c0
> [    0.010256] [c0000000045bfa50] [c000000000232924]
> __cpuhp_invoke_callback_range+0x148/0x230
> [    0.010261] [c0000000045bfaf0] [c000000000234f68] _cpu_up+0x19c/0x3cc
> [    0.010265] [c0000000045bfbb0] [c00000000023533c] cpu_up+0x1a4/0x1f4
> [    0.010269] [c0000000045bfc40] [c00000000203d1f4]
> bringup_nonboot_cpus+0xbc/0x128
> [    0.010275] [c0000000045bfca0] [c00000000204b98c] smp_init+0x44/0xd0
> [    0.010279] [c0000000045bfd00] [c000000002006d4c]
> kernel_init_freeable+0x23c/0x3b0
> [    0.010284] [c0000000045bfdc0] [c000000000011b0c] kernel_init+0x30/0x274
> [    0.010288] [c0000000045bfe30] [c00000000000debc]
> ret_from_kernel_user_thread+0x14/0x1c
> [    0.010292] ---- interrupt: 0 at 0x0
> [    0.010296] Code: 4182ff74 3d22013c 3929c1d4 81290000 2c090000 4082ff60
> 3c82ffda 3c62ffd9 3884f998 38634590 4bf19461 60000000 <0fe00000> 4bffff40
> 60000000 60000000
> [    0.010310] irq event stamp: 7440
> [    0.010312] hardirqs last  enabled at (7439): [<c0000000015c1824>]
> _raw_spin_unlock_irqrestore+0xa4/0xac
> [    0.010317] hardirqs last disabled at (7440): [<c00000000003bc30>]
> arch_local_irq_restore.part.0+0xa8/0x224
> [    0.010323] softirqs last  enabled at (0): [<c00000000022b6ac>]
> copy_process+0xb24/0x1dec
> [    0.010328] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    0.010331] ---[ end trace 0000000000000000 ]---
> 
Root cause:
On powerpc, a soft-masked interrupt that arrives while IRQs are soft-disabled
is recorded in irq_happened. It is replayed when IRQs are re-enabled. Here
that happens through 
_raw_spin_unlock_irqrestore()
	arch_local_irq_restore()
		__replay_soft_interrupts()
			timer_interrupt().
Before replaying, arch_local_irq_restore() deliberately calls irq_enter() at
line 317. The reason is to keep softirqs from running inside the replayed
handlers. irq_enter() does preempt_count_add(HARDIRQ_OFFSET) and
lockdep_hardirq_enter(). So the replayed handler starts with one hardirq level
already held.
The replayed timer_interrupt() is defined with DEFINE_INTERRUPT_HANDLER_ASYNC.
It runs irq_enter_rcu(), then the handler body, then irq_exit_rcu(), then
irqentry_exit(). In a real hardirq the nesting depth goes 0 → 1 → 0 over this
sequence. In the replay case it goes 1 → 2 → 1. This matches your "preempt
count is 2 compared to 1" observation.
When irqentry_exit() takes the return-to-kernel path with IRQs enabled in the
interrupted context, it calls trace_hardirqs_on(). That reaches
lockdep_hardirqs_on_prepare(). Lockdep expects hardirq context to be fully
unwound at that point. It checks DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
at line 4448. The per-CPU hardirq_context is still 1, left over from the
outer irq_enter() in arch_local_irq_restore(). So the warning fires, and
lockdep disables itself (debug_locks is cleared).

The replay path's own irq_enter()/irq_exit() bracket is still open when the
generic entry code's irqentry_exit() tries to re-establish the "IRQs on" state.
This is not a real nested-IRQ bug. The generic entry code simply assumes it runs
outside any hardirq context.

This warning is harmless and we are working on this to fix it.

Regards,
Mukesh

[...]

