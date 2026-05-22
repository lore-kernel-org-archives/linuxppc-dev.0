Return-Path: <linuxppc-dev+bounces-21418-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D325CD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 18:56:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMZHZ5Yx0z2xld;
	Sat, 23 May 2026 04:56:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779476170;
	cv=none; b=lUunlN0OIaJGZvPMcgZHTXPs3XIzOnwAjd10Q/KXrolGdtboHPCN8pGTYdeQwXElCJcg8YnluY72N2zdy8I1BXgkjWfg/Z2AsJuBNkzLKQOVwGKGb4ESgCIBQxwSb5sS0r1syeDzL9q+NxaJVnpBSl2bgOAnYRvztJrXxIQfAQ69mLJO2ohv1+nS9SVS0hwBqOlK0DmDx0kh6sk56yT5SaJ9EyXfRzGf4NOhRHtUlhwA+OibczZHyO3CyPJpb5v37Z8fVcY9cYTIPSUI3/n105yPdu4KIS0nuOvNnDnGHQH02/O43z40/hhofOIcLl+ak2Z1yW89CB/VIez0wSuiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779476170; c=relaxed/relaxed;
	bh=+wf/uINnwCK8WbvZvaLDBEegzhnbhM29i2MF7q8Btmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpRXhvZOfBsKhVG3v/RP/pB6PStd9OK26SFKHtIkVtWwsZG64+kMwN3sASQZ698G2EYcJUevdezq3AMX1XBXBhAV6ymGTP1h/kXcwfxq613CK8/Coo39gcpkeqRcjggzaJ32oYU8UtykpzMXYoMU9pxSSn8bw9H63ErDx0s4SRTd4VNUNXrTyM5N2Xd+t/Snn79TiA9075GozxAK62ppgeOPomkjMLiGDlkFMDUZI4UQK/FyRyxZqS0y19lmQmBewHY/0MASAlS+qSlQPZTsSzzM+4TSEk0VJk8hqZyMBpJWN/1W6paoS9ye6CL2eLs9NuWD3RDfOWSMMnpHYXZENA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j+o70ilw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j+o70ilw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMZHY16N4z2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 04:56:08 +1000 (AEST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-44e5624c053so4724855f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 11:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779476160; x=1780080960; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wf/uINnwCK8WbvZvaLDBEegzhnbhM29i2MF7q8Btmc=;
        b=j+o70ilw3xDOrMGzhVCSCXLrkRiuprFS0//LX+Mqctzw85djD+KoiuuaqkJDE2mTUN
         8B0fabB19Ag2jx/+iVzj/O/y/kHpQeOsRY0w3DrqI90zVrjMhVQroMh9dEbepm6Tz6U1
         1+cVzBWN8SXTN/lfVSqqdcAQGkpa1+qx65UYcsTzrtXdvrLA+TNywc51mIcxZ5PaQXvI
         uOUneDgivmqbT8YAm7Goe1ySa1e0nt/85OlRsuaMAzvzUx9oGW+jUE5R6HBWHppSaDrg
         l1lUiNaOg/lF+Ql1ES01ocAm+wenDusKdnTcF1uIu5WT27UbDQMARGDmEseOcEM+fy4V
         +1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779476160; x=1780080960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+wf/uINnwCK8WbvZvaLDBEegzhnbhM29i2MF7q8Btmc=;
        b=KlHl66/ccDBvYLnBabnXJCJ0sZIo9BP8yOhYJnL9DBXBALDkBD9ijCgyrM1BkpSeXW
         7Wpp3BWJwVxWSEEPkL9JJIWFJDA/AWK8/AUyKawX//8F0wN5Tv2jUq29xfTubpKnHx11
         pF/IZ655zZEzDrrtbkQSMeaMIqv0MFiyn+DFmArB5Cs+vdlIudjCGGNPQbFCroQUoF/h
         D2yxMrxCXG34lGCgm7DZrJtnJoM4UqndhpkkpAmjbcVTWRugPA3b83lZC1SJMS6eSg+x
         REq+s+y0dbkgJfmExlzKciq9fCgBUIhwKerlgL5bSzzuuM3u6gFa91VOIBLaWL6rGIZq
         zeww==
X-Forwarded-Encrypted: i=1; AFNElJ97xHGDg9NrwoU5Dlfo3Hvh6vctcG8WLoq859ywx4ShjgZA19Msq/9NIRSG+g9oHaolL5RKpNGkYjmgZu4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxALIqbJGUPpPVQ04Vu9F0zdWPhwxXhBSOpvwIeNlYkqmolvwaQ
	TeT4KN5HKk/VRl1ZOVwfFdNnGGxr+Rw6rRSLDs5SJ1NB5lwGeBFMCOHb
X-Gm-Gg: Acq92OGA3SotM18gQzuIHi+4qD7Y5aGa6/cwoDZd30nsGS4JumlBDZdFT2iAqRTbYor
	b90CoZPohI1gfB3Ukzm9DLQnFYd0uCsbWhH6CWT3c4OoOccy3CkvFj9o+TMOg29bGwbSqzN05E2
	eO4foJMumc4hehpZBUVCGZrpnOmdjSsyJZBI4o0QZv2W7Yc25rRHadsw/RqcsmQdcNmI8vFynE1
	INpMrydq15PrtxOIa5njmjo18XLmnbKyFZCF6hXugEZXPDZIpPPueFhGJ7kfBYyuWX/eZmPxLnq
	6HQ5QQv5m4+ILmZpslQa1aOdyUNPIjqRWhpqueuMF8b/RzhHGLnGllYfLS2wUAN2X9WRAuwW3if
	WUILKbXTCeW7oonP3NKArmdkwBLwB8gLHYeePQHO0ylnGQwrk+P0d7Mdy5sFqNkFjXcAoZ6asQI
	Ch48KfDJzgbMWlX5AP+42/7a8hSKaSz9ikhV4VuDvXautorJL5KyykXtNDMxzSdskP
X-Received: by 2002:a05:6000:2488:b0:43d:c95c:4259 with SMTP id ffacd0b85a97d-45eb38a18e0mr7563614f8f.30.1779476159924;
        Fri, 22 May 2026 11:55:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm5239833f8f.25.2026.05.22.11.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:55:59 -0700 (PDT)
Date: Fri, 22 May 2026 19:55:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 2/8] powerpc/signal64: Untangle
 setup_tm_sigcontexts() and user_access_begin()
Message-ID: <20260522195557.5fd73f80@pumpkin>
In-Reply-To: <28a7b0b9-3c17-4f76-af80-f17f4869f854@kernel.org>
References: <cover.1779441786.git.chleroy@kernel.org>
	<7c83fe5a596514a02fde37da987a48d638d0d097.1779441786.git.chleroy@kernel.org>
	<20260522121237.3089276f@pumpkin>
	<69bd69b1-97f7-41e2-934b-bed28dc2fef7@kernel.org>
	<28a7b0b9-3c17-4f76-af80-f17f4869f854@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 May 2026 14:44:55 +0200
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> Le 22/05/2026 =C3=A0 14:06, Christophe Leroy (CS GROUP) a =C3=A9crit=C2=
=A0:
> >=20
> >=20
> > Le 22/05/2026 =C3=A0 13:12, David Laight a =C3=A9crit=C2=A0: =20
> >> On Fri, 22 May 2026 11:56:02 +0200
> >> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
> >> =20
> >>> Call setup_tm_sigcontexts() before opening user access to avoid
> >>> having to close and open again.
> >>>
> >>> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> >>> ---
> >>> =C2=A0 arch/powerpc/kernel/signal_64.c | 22 +++++++++-------------
> >>> =C2=A0 1 file changed, 9 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/=20
> >>> signal_64.c
> >>> index 86bb5bb4c143..3849af21e1d8 100644
> >>> --- a/arch/powerpc/kernel/signal_64.c
> >>> +++ b/arch/powerpc/kernel/signal_64.c
> >>> @@ -873,6 +873,15 @@ int handle_rt_signal64(struct ksignal *ksig,=20
> >>> sigset_t *set,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!MSR_TM_ACTIVE(msr))
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prepare_setup_=
sigcontext(tsk);
> >>> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> >>> +=C2=A0=C2=A0=C2=A0 if (MSR_TM_ACTIVE(msr)) =20
> >>
> >> Can't that be done without the ugly #ifdef?
> >> I assume MSR_TM_ACTIVE() will be zero - so it will all get optimised=20
> >> away. =20
> >=20
> > Yes but struct rt_sigframe field uc_transact only exists when=20
> > CONFIG_PPC_TRANSACTIONAL_MEM is defined.
> >=20
> > And that would also require a stub setup_tm_sigcontexts() =20
>=20
> After thinking once more, I think we can do the following, is it better=20
> for you ?

Certainly more like the expected style.
setup_tm_sigcontexts() will get inlined, so it doesn't matter what values
are passed as the arguments.

-- David

>=20
> diff --git a/arch/powerpc/kernel/signal_64.c=20
> b/arch/powerpc/kernel/signal_64.c
> index 86bb5bb4c143..c70732e8002d 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -203,8 +203,7 @@ static long notrace __unsafe_setup_sigcontext(struct=
=20
> sigcontext __user *sc,
>    * examine the transactional registers in the 2nd sigcontext to=20
> determine the
>    * real origin of the signal.
>    */
> -static long setup_tm_sigcontexts(struct sigcontext __user *sc,
> -				 struct sigcontext __user *tm_sc,
> +static long setup_tm_sigcontexts(struct rt_sigframe __user *frame,
>   				 struct task_struct *tsk,
>   				 int signr, sigset_t *set, unsigned long handler,
>   				 unsigned long msr)
> @@ -217,6 +216,8 @@ static long setup_tm_sigcontexts(struct sigcontext=20
> __user *sc,
>   	 * Userland shall check AT_HWCAP to know wether it can rely on the
>   	 * v_regs pointer or not.
>   	 */
> +	struct sigcontext __user *sc =3D &frame->uc.uc_mcontext;
> +	struct sigcontext __user *tm_sc =3D &frame->uc_transact.uc_mcontext;
>   #ifdef CONFIG_ALTIVEC
>   	elf_vrreg_t __user *v_regs =3D sigcontext_vmx_regs(sc);
>   	elf_vrreg_t __user *tm_v_regs =3D sigcontext_vmx_regs(tm_sc);
> @@ -325,6 +326,14 @@ static long setup_tm_sigcontexts(struct sigcontext=20
> __user *sc,
>=20
>   	return err;
>   }
> +#else
> +static long setup_tm_sigcontexts(struct rt_sigframe __user *frame,
> +				 struct task_struct *tsk,
> +				 int signr, sigset_t *set, unsigned long handler,
> +				 unsigned long msr)
> +{
> +	return -EINVAL;
> +}
>   #endif
>=20
>   /*
> @@ -872,6 +881,9 @@ int handle_rt_signal64(struct ksignal *ksig,=20
> sigset_t *set,
>   	 */
>   	if (!MSR_TM_ACTIVE(msr))
>   		prepare_setup_sigcontext(tsk);
> +	else
> +		err |=3D setup_tm_sigcontexts(frame, tsk, ksig->sig, NULL,
> +					    (unsigned long)ksig->ka.sa.sa_handler, msr);
>=20
>   	if (!user_write_access_begin(frame, sizeof(*frame)))
>   		goto badframe;
> @@ -889,19 +901,6 @@ int handle_rt_signal64(struct ksignal *ksig,=20
> sigset_t *set,
>   		 * ucontext_t (for transactional state) with its uc_link ptr.
>   		 */
>   		unsafe_put_user(&frame->uc_transact, &frame->uc.uc_link,=20
> badframe_block);
> -
> -		user_write_access_end();
> -
> -		err |=3D setup_tm_sigcontexts(&frame->uc.uc_mcontext,
> -					    &frame->uc_transact.uc_mcontext,
> -					    tsk, ksig->sig, NULL,
> -					    (unsigned long)ksig->ka.sa.sa_handler,
> -					    msr);
> -
> -		if (!user_write_access_begin(&frame->uc.uc_sigmask,
> -					     sizeof(frame->uc.uc_sigmask)))
> -			goto badframe;
> -
>   #endif
>   	} else {
>   		unsafe_put_user(0, &frame->uc.uc_link, badframe_block);
>=20
>=20
> Christophe


