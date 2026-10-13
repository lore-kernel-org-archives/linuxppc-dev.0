Return-Path: <linuxppc-dev+bounces-29475-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712E5CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 11:18:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4TH45Vxqz2y8p;
	Wed, 14 Oct 2026 22:18:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791902001;
	cv=none; b=TuK9Q2SMwZvFjrW354I+8OHqxjVH2RTLvxlL/c4WozRIJwQK3WydNZpQ/yl0pG8/rBaacw6+9Gd5UHdhWd3cT+qhbS6JiX3kWqfGNlLgj0FxCU86vzlTNsAc6yehlNSDtkinEnT0Zovr5u0fU9uRpx18E3LDy/5gY1q9RL6n4yXvtm618TfXYR4SuAVAc4YvN6j2TJ3iBCjexGr4WXWJ9r+3/d7rRvvpcOyCXOaq12NbaJOA8qvlHkPB90H8ZkxY0WlDVMzttN/Rcjv7NpuPvsCzZMnN6qFK97e1O+vkXP76xTSYh0HFlO6ghiu8lp6ITtDQPKsyKtBCtsLlplCduw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791902001; c=relaxed/relaxed;
	bh=2D70tRlN9hXWyqkkdtTDdIyLlgX6luaffedR+k/mZw4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=LnAjTJYFLrTfTQ8laOFeCo8ueqCn6heye+VazxeIsNDwrIa+St6c29vg67MfLA9C7D14ST88LP6Wv4LsTO+lIszdmMp1runhd2HZaKbLC9fCJdzSle2Q2p40+AJY7VeYAVhdHEUyZ1UVsJWHiMg66L2xIv3vsP2H/cXbCTWasted8VrrCKoROMgnJxuCJc1UXEs6s4PJ07yxu/kKR2dttK6J3P4Z2FTAnmhXTEQrKmp+rD8u6pNbatzNx0Etn0TrK4IKclTxMm6do38EFNZgNLSOWlFnc5bc47HgsjlEgCtcf2+kAM/M2enhHQZM33uZ7+C9FEKWGNFjyyzh2ZaMTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M0o9Lj74; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M0o9Lj74;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com [IPv6:2607:f8b0:4864:20::132d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3xdq6Ctlz30Tf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 01:33:18 +1100 (AEDT)
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-3282db206d3so800703eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791901995; x=1792506795; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2D70tRlN9hXWyqkkdtTDdIyLlgX6luaffedR+k/mZw4=;
        b=M0o9Lj74ocil2qhi5LAn/DcWhjVww1sG3sLPkulamnKw+tKXno1TlwDKa5KLgJLtsr
         NV+xurE95gDLsDzpFfB2HCANaT9YyZ6ECwz3h/9sefI83IdYQcHEDZBM18i2wqpYpIWk
         dcN18j4VKn60xweFoGHZ0PDCryJkQiDiOdJfOTSKSTTb7Vr8DWZiGoLRBA0tlwUg/KXI
         bxX2w6IH57eJP8VdJYcPGGgcn25rWRK1FCoLnokZhwanEPhE8vm5M3GRQooUv8NwMo6o
         LHxqzt7oNuiJgQ5h84wLNFFgPwEROqDdf+s/kfVorDxcKN4an3pC0A3aJCduHZZnWDdo
         enwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791901995; x=1792506795;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2D70tRlN9hXWyqkkdtTDdIyLlgX6luaffedR+k/mZw4=;
        b=UARDXwpE51GUeRTFuUfsazE8iMWnhBiOmLOo4Y/4fgISdIVMKXTg9KgeSjfDRdP3VJ
         3zf5jXSDeLduMVtXGCj85gtM6BnUpAfNaL2X9kEF9/HTZcBOHDWt+dSQfpAG1IxSEIub
         B4d2OKEKc94c8thOcaicCBTZ6L8j0KF1SkIz9eJGW1Lxxqe4ZeTCT25uUYnbmdFnhjVT
         PW72OmcbPsh4azAhUhv7ZvFRCFPPepHiRhpyDXnohsU2jbtEGNOHVpxcuBLieWscbOBF
         6iNVrK+oiZpuSm1XOYlgB4li1UoJkHuviTw7MOwDGPCigONY8XePjK7mp6DpipvhKS2p
         jFrw==
X-Gm-Message-State: AFq9FYKXYs7myCNxoBxYMzNMzDGp6P3GnQ4+MRDXKKviETHFZijg5O+I
	93sQ1YY0t0zzu0Q3NR8k4zDd3Jujs48ChzZZ+wH0ESi8IvDRX3UxnWOw
X-Gm-Gg: AYBFou05t4dnjxo9WqdcFFEozHn0JoSXe0Sano3eZl5xr+wJQXWJrSs/3Rk5EY4im1Q
	NolSg3NbZU3UeVNNNPX05sNJEz9p6xG0IVeej96+5LQT1cckeS62ooR72PPR7qrDLiMMpnJVIQF
	FWatwDv0Rp2/k4yQwHxeOFsMsP3knpRJDoz8gUaQqdwHA3rVcwm60L9TnRdttalNY/tGSlSWXtU
	X0gAXWbWflHriEHaBxUaFjKALZwqevRuzejRNkxRhz4dZfoGs4x9Fnc6HtiwJgqMMyCL6JXRaes
	5aV5MWPEMLhI8YgAvyb1G/uAC75YmYXgHnzEX+uTc9pccDe2kiSWoE3eK5TtzaHCKMXiSVhAaVr
	3A67AFsOicUeHCL1gInwcQsI1xxw1Mf6IaPXRrLRF4r2gnIVWqChIjjDaJ7qZindOmrdQL649B7
	AYhyGhoYr4XmQlbyBmYmf0FvkxKnNPJ4ZuVSNc/CgGfaygwRdSFhqEbv/Pap9p+NArfRgNfWjeY
	qWtMwLz
X-Received: by 2002:a05:693c:821a:b0:35c:813a:1c81 with SMTP id 5a478bee46e88-35c813a23b6mr2871023eec.18.1791901995288;
        Tue, 13 Oct 2026 07:33:15 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca6d20dsm47942824eec.12.2026.10.13.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:33:13 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] KVM: PPC: Book3S HV: Take SRCU read lock around kvmppc_h_page_init() call
In-Reply-To: <20261012082922.218799-5-gautam@linux.ibm.com>
Date: Tue, 13 Oct 2026 20:01:51 +0530
Message-ID: <y0c1r7s8.ritesh.list@gmail.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com> <20261012082922.218799-5-gautam@linux.ibm.com>
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

Gautam Menghani <gautam@linux.ibm.com> writes:

> Since there is no srcu read lock around kvmppc_h_page_init(), a
> "suspicious rcu_dereference_check() usage" can be triggered by running
> host linux with CONFIG_PROVE_RCU=y and the following code in the guest:
>
> plpar_hcall_norets(H_PAGE_INIT, H_ZERO_PAGE, phys_addr, 0);
>
>  =============================
>  WARNING: suspicious RCU usage
>  7.0.0-dirty #227 Not tainted
>  -----------------------------
> ./include/linux/kvm_host.h:1074 suspicious rcu_dereference_check() usage!
>
> other info that might help us debug this:
>
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by qemu-system-ppc/2093:
>  #0: c000000354197ab0 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x10c/0xaf0
>
> stack backtrace:
> CPU: 30 UID: 0 PID: 2093 Comm: qemu-system-ppc Not tainted 7.0.0-dirty #227 PREEMPT(full)
> Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.60 (NH1060_158) hv:phyp pSeries
> Call Trace:
> [c00000033e1bf430] [c000000001b3dbd4] dump_stack_lvl+0xc8/0x130 (unreliable)
> [c00000033e1bf470] [c0000000003da964] lockdep_rcu_suspicious+0x1f4/0x290
> [c00000033e1bf520] [c000000000231424] gfn_to_memslot+0x1b4/0x1c0
> [c00000033e1bf560] [c00000000023637c] kvm_clear_guest+0x9c/0x110
> [c00000033e1bf5c0] [c0000000002714a4] kvmppc_h_page_init+0x160/0x1a0
> [c00000033e1bf610] [c00000000026c040] kvmppc_pseries_do_hcall+0x1930/0x1940
> [c00000033e1bf6d0] [c00000000026fb18] kvmppc_vcpu_run_hv+0x268/0x800
> [c00000033e1bf7a0] [c000000000246b30] kvmppc_vcpu_run+0x30/0x50
> [c00000033e1bf7c0] [c000000000241ed4] kvm_arch_vcpu_ioctl_run+0x364/0x530
> [c00000033e1bf860] [c00000000022b870] kvm_vcpu_ioctl+0x1b0/0xaf0
> [c00000033e1bfa50] [c0000000009b4514] sys_ioctl+0x144/0x190
> [c00000033e1bfab0] [c000000000034330] system_call_exception+0x170/0x370
> [c00000033e1bfe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
>
> Fix this by taking a srcu read lock around kvmppc_h_page_init().

Looks good to me. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


