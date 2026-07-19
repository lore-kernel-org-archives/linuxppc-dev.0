Return-Path: <linuxppc-dev+bounces-24415-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E995BC44521
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Jul 2026 11:25:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h31YC4pQmz2yQJ;
	Sun, 19 Jul 2026 21:25:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::531" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784460351;
	cv=pass; b=FHVgO0khs5reG+fbUYGWOBLBzsEbZlBCFpCkL1uQEIwdc7uYL8qJ4NHOjQ9jXqsf0N51JpMw9C6FQjP0NOJW+MXGXimej4fyRjghGZVa4/Xq0ncXim2zrIn9ZyhvuRay4BZcVOjyZ7H4zpywwDiC4OuumWxK4zDkR+O8VRGnKREEfVB3UzkuA/jJpmfXklT/PAHezBpU2a+qy3Q1Wbld9pFDXCDpGPwQ6LQtFgzD2ii/aKvlgei9+Wjtw/21kwNCWnkm0pOLQAYmFeNpX1d3RtKE/YRG21H12zu/+NJ4caofJQQKm1tXr7cwZVhREFeU+9sQsK2Yb20A1GPo+K8I0g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784460351; c=relaxed/relaxed;
	bh=HjwBEg56Cr9vHNVIU01sUWrlM5gmQ+vCUXpN04JdIto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JF7jvuaUTGGEmvuE/a4CqBfLwuzIar8xDuCB7W7wyCdEIMN66xgZ/EsuvLfKfWjZ6qAOF6116VC+m3akIzHTEWwRBUvkQyZ5j+WPFFhX8HabQ6Y/AekyLhdtoTppM68cbuseWgdQR0F91oHjFNEo+8oKedtyNtBElvL1FJ3xEg/JzkQIDrBm936CnZtgd1NPJK0uExPlE1Ah14353SKSaAAFMN2e4VFB4zqovNn4dtHyd+GdXDc1wvwx4mQzc7uGWdpJcwiV2+Br10mLI2KbYsYchzdmKdwIPdQxw3zhOAy+hWDnOxnoBFhNusG24h0nKcfYq1AIGNkWdZRmn5SRUw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o4LZxniS; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o4LZxniS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h31Y95j4wz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 21:25:48 +1000 (AEST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so9916149a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 04:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784460345; cv=none;
        d=google.com; s=arc-20260327;
        b=dOjan9Qj6VWVZVixmbsp+9iYCMbAnNauk+PHeYM18Zrj8fVdaLMZV1JnP+oesiBs60
         87LXLwxZSVHWH+snIexPDQWImRKLFut5QhVF0a3x8mdVunrzObQuV5VZJgZHSTVuGfM5
         nVKrOYeMdx9tpVXZMRLpJw5N47SKWJ16kvsyiaJZD18IX3Eat/pZJDUyjjZ/1Zi/d2w/
         W1jqo4EJ0Ec/2Ej+4druB5ZwnIAN/kEf2mVjvdIsyXMEsfAye2Ogi/BALu5zL6Q+Rd0t
         h8ctkJ970GOj4KTWQ22sUmL1d7cJs+fy/zVFlMZJB22pbUqw6J6oW/xs3Q3QHlx6kzQu
         IgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HjwBEg56Cr9vHNVIU01sUWrlM5gmQ+vCUXpN04JdIto=;
        fh=xWLZwhaEDBPW+hIzABsT5e01QhPes7B1bh6o46QU5B0=;
        b=PbbXx3DD1LVa5UlFNTSHQPvaOWmmfWtgUomfmsL8d/O9JEb/3fKPDTU4l13R3b1cWM
         qsev1AGh8fwDWVXxztB0PYbUqhMCL8nDB7cwoyBu2fuw8vr0s0nuJp72Ow4ceRfxlVz9
         +Kp9CfdUXbOuc/6IgKzd4lUx5J5h111x6VJ+jwSUNxO1dZ2qavSnpYUXDdN/9oi+SDJO
         hEPZpMbiClY+o553IEg9DuP7T1hpNM9ZzCKMVCdxetKZi30oTce9/YJxKao6jo1NESvY
         UNKcvB014UPRxGAxaHYcX20t5n74EoohTH1YPOqYfb+qiJlgbZBDA6wgKDBHW/voy22Q
         fFjg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784460345; x=1785065145; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HjwBEg56Cr9vHNVIU01sUWrlM5gmQ+vCUXpN04JdIto=;
        b=o4LZxniSrHZlnd8ntUZPTWzXKsm5ECAIJblRlcs9Pn3Sg7YTquiskRWz5+dDndn9Bo
         kkI9U4UfpxvQs5uoyJWAhc4QWTHuCyw0r9A/55p7F/PhsdKXkMsWOf89GDn1OSm5BYZF
         nP3CYorTMDlHQMDjZ3pRqwc/j9ybNwX4lDxyi0aswGsT20R4ldXmu53puBS1Hfx4G33i
         iSWM6/J5c6IiJkg8zne/z5PBIgvzo8qHbPN5EtuLey0hmPHbDicodsiuNtxhufk8XGMy
         J2WxCyQ5YG9dXZSlj35L0QVI/RsGAXYqGYFgL9x1Rd6A6ZOiskVP91s/tSEvZrtthu96
         yNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784460345; x=1785065145;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HjwBEg56Cr9vHNVIU01sUWrlM5gmQ+vCUXpN04JdIto=;
        b=LjKlg7FWU9O/EiM4QWf0QuSXMngWDVIpQMyzMPG3Uo+w45VgbAATQw90PvityCLnO4
         PcXpNfRY0DRYwymNkfmKDgBOwm5+qfLxjKdP4oOdf9co12dZD16QfyX6SPBMUhwB3sVr
         8vy6YkMs1YSP3duzP/WN9/j33AifgVOksrYXitdifOXuL70C3D+Hx9ogVR/P7YORnPWD
         Fm1q+Gb0LW+FKLnMlswTAT1DaafWR92zoFYZYNBYHeWYBourV35xounnC6v55kveKqcv
         OHi5Cgs+fXlZNhfBAQOgI31OiKFmTXIBulNNl+TsEJm5+1TAZFBxC8gs3OKaaEFkVnPu
         Z7kw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/uURCx/8uxXlKQLe3ew0lKwl4XwKbJN/6oOrZgUsVvQr3SKRclFykFJfTqYPVEXUbFbEzYMBCDbhODQs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy9cWe9zhVzZA9DtIIXyduvFO2oXf3yXOd3V7fMGIKnzIuOw27c
	ing0Rsk0mMQ5b/5mtDpDN6WWIV6bg2UPJgNHpZfXwrzo9UPjD7Xg0F2lFE+yNE27MCVwX9RVIae
	5yTTT+ZurrPWvPnR/oEJyqgRXNt5Smd4=
X-Gm-Gg: AfdE7cmyJrbP2l598iE5O9pLHirX0+QZdI0HSPUoyNy+2zgs9cgfrCpdr2Y4HUCUvAQ
	X/cFprjxoGTAiNokp+9lsemuHVvLwJN/CezPURLV17eOIGr8oCo5v2NTuode6xjgIj1B/ab6fqO
	LhUZQcJoRa2G2XmG6x+vlsjBBJdHzvGQEO5VxNsQ2HTYAEQSc7CJ/R0acqt7aZQ9k6bL+eKSIiw
	10Ox/0dmMm1D2szPrctGk6pri5xBI5rxExciixbbDf2kehSVGN1K7RnfF5YNMwJ0ufjOEBk7ucX
	PHlz01SjBBmUVCfzt1KU59b3eIEHXgQEZsKi5KnIjQ==
X-Received: by 2002:a05:6402:34d5:b0:698:3b7b:e48a with SMTP id
 4fb4d7f45d1cf-69e652f908dmr3652615a12.32.1784460344585; Sun, 19 Jul 2026
 04:25:44 -0700 (PDT)
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
References: <20260707181957.433213175@kernel.org>
In-Reply-To: <20260707181957.433213175@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 19 Jul 2026 13:25:32 +0200
X-Gm-Features: AUfX_mzTzrHRlu_CZJHA0P1GUw_Z2tfq0CbfsG-DFTqsEJDFIQx7LWbdfB3YWqk
Message-ID: <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> With that all architectures using the generic syscall entry code follow the
> same scheme, apply stack randomization at the correct and earliest possible
> place and skip syscall processing depending on the boolean return value of
> syscall_enter_from_user_mode[_work]().
>
> There should be no functional changes, at least there are none intended.
>
> The resulting text size for the syscall entry code on x8664 is slightly
> smaller than before these changes.
>
> Testing syscall heavy workloads and micro benchmarks shows a small
> performance gain for the general rework, but the last patch, which changes
> the logic to be more understandable has no measurable impact in either
> direction.
>
> The series applies on Linus tree and is also available from git:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-rework-v1
>

Hi Thomas,

I did another round of testing of this series on Alpha, this time with my
Alpha GENERIC_ENTRY conversion rebased on top of this series.

For this test I also manually applied the seccomp fixup discussed earlier in
this thread, i.e. fixing the recheck-after-trace logic in
__seccomp_filter() along the lines suggested by Jinjie/Oleg.

With that in place, the kernel boots on Alpha and I do not see any
regressions in the seccomp_bpf kernel selftest or in the strace testsuite.

One note: the seccomp_bpf selftest run on Alpha uses this not-yet-upstream
Alpha selftest enablement patch:

https://lore.kernel.org/linux-alpha/20260203063357.14320-1-linmag7@gmail.com/

One Alpha-specific wrinkle I hit while rebasing the GENERIC_ENTRY patch is
that Alpha cannot unconditionally pre-seed the normal -ENOSYS return state
before calling into the generic entry code: syscall_set_return_value() also
updates r19/a3, which is still syscall argument 4 on the normal entry path.
Doing that too early broke early userspace mmap() during boot.

The Alpha conversion therefore handles this on the no-dispatch path instead:
after the generic entry helper returns, if the syscall is not to be invoked
or the resulting syscall number is invalid, Alpha skips the call, preserves
any ptrace/seccomp/BPF-provided return value, and only synthesizes -ENOSYS if
the return state was otherwise unchanged. That was needed for the
TRACE_syscall.ptrace.syscall_faked and syscall_errno seccomp_bpf cases to
pass.

So from the Alpha side, with the seccomp fixup applied:

Tested-by: Magnus Lindholm linmag7@gmail.com

Are you planning to send a v2 with the seccomp recheck fix and any other
review fixups folded in? Is the intention to route this upstream
during the next merge window?

Thanks,
Magnus

