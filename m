Return-Path: <linuxppc-dev+bounces-19901-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B866F8FA94
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 16:01:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Rsv1Kh7z30HQ;
	Wed, 22 Apr 2026 02:01:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1332" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776787267;
	cv=pass; b=TM6puujqGIP/exSZx2SjbAMr0h15h2s7MEQuOiLOZisgX4hQaPADA+a6QfSJyQAz85x+S0e05tiSNrQz2wg25pqCue3Af0oFIE8lGQT/tcNXCaQ5xqdRJ6GB+qc9Z8/0PX0SGDnm3S8CryNrE8dF2SDk51oKFSYEwq8DNQPSd/xpDnVmFkE+4/rYK5UStGG7DWWuNtuyKGCC0d7dTluhUSy8zbvm8LVdIBXqkiwuLBBL0CTK9e95cCytAPvVDByemXkEYe3/fvtZ1d8SQPW/zroNPzrQB0BI89bpJcUfiRxbUkfx50WhLQpYSvKo73v9LkwltqHeBVquf3nPvYJ4hQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776787267; c=relaxed/relaxed;
	bh=MeXsRITH6uYFGjSpv8Ce/kRxmKLtDNrVZWdnDLB9ZX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkpxI90qKs1lxLkkyYbxTzMh0l6M56edOBbGOjNNcdjqPje35+T6fACGtFAJUMvjT+D9mDl8zfBd8tNl7I94dtpEvT9gTXhcpNbM1sF7evR8wFvwftCzLzXb/OXEhaF/V6kyToUdfmgyiRj2/cAXsGB7RrtwhBim5jOD1WIAB/VHXHjUMhyrIVwP3qZD3RQUYgtAc8MjtmhiNU9Y4Fti6c/UVASAWXmNtWMtpS3lDcSOeGxZzMmODE8MNcNlM9CJHh72mNH9RnTwERH2qg+bIaex6rJga5+KxF0sSULcsh9nQFXP2FGy6OGR4PqYXMjexkDVg211BDsWEJEgoq9/Zg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xy6X4ssr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xy6X4ssr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Rst3L3rz30Gm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 02:01:06 +1000 (AEST)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-2d9b27e4aa3so417630eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 09:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776787263; cv=none;
        d=google.com; s=arc-20240605;
        b=OloD4uhWl4S8vczjhs23Gim1+sE+piHIv1RYKubw/v1ylHfsAKA8qGepwHVSBJOXqF
         ND2S/4kgfemIFjFE+qf1Qb5Mrm2a+SqLXXNljJH8r0c16qsZySiP+kR2AhgGzC8ralAF
         6SDPcRtP7dkgtQbjMG/H3HBxG8DS0kY6WQ+/p9Lx79HpaMRND+g5AnwnFlUcw/nfYyYc
         v/KbG+HqHiFu3lvODJBcDmb8w3FJr8ceVLyrcS/eKMz8puGpyAKwOBYboSheL2e1h85E
         hs5BwY8nA0piGn8IDPzF/3bkFhToEAmW05eoJJw4B8Bud0d6yQHmIlJsWr2G601j3tib
         dBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MeXsRITH6uYFGjSpv8Ce/kRxmKLtDNrVZWdnDLB9ZX0=;
        fh=qz2cxOc4I4unjU2HiLPjvU68BSy77UPUw0p55fs7SxU=;
        b=OwfhejO/m1l+DCmzf0wZsEd/mhdGhogWkwTSqO/vqd+bNbRv2ChZUeCTm7RqVAJCxF
         3IsYvOf5vN5TKTMbdWJEDJwqt52nEktUf4eJcWuPKozN52YCNLWC0Gb5JTu6aiNhrgsJ
         6p+5BQkUs+QelpvpFsmff3dDNm9fDEceUc/GF+unDYC+cyGqgBkAiFhKbVZtBZmiMiTP
         /Ys9GssVJooQ2UfEtWAGgoYSt5hFzAxmFzY8W9fK/QAHcC1BgWkuuJkeI5945jBCQlog
         b5/XaBOW3ti5E4Y+5ugdetSEPcB3+eTX01v70fDTXqnU0vKGPjwYPKZZ6sQlON5RM++1
         tJBw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776787263; x=1777392063; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeXsRITH6uYFGjSpv8Ce/kRxmKLtDNrVZWdnDLB9ZX0=;
        b=Xy6X4ssrJtqvsTzTbGXxuBgbhWBLNgUiCkkUfXGcvGNX0dXYQME5E7nB+kM4BE1/QT
         aAfDr53k+m3FPEIqK22nbnNTeGf3g5i26ls+IjAS0/uX12w/yjYRiWKd1XbY6lusRHI5
         LQP6rfndOCbY6RPW/MPFk1u1EOf23zTAG1NZb3eobXMBd21//yKUtAjVUAprQ1Zute6X
         1kC2Ulyr2DCMhIZmtHrQwR1iGwbGt+H2kFaPYDiHx1hgYy7lc7Qacw3oZOi5gkp6Lr2s
         9Rb31YyBmbq8mYNcvqq3Y7SX9AI2wuUUDUOiEo42L6AdFDE+ik885tVbB4L3YmOZoBI0
         4oPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776787263; x=1777392063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MeXsRITH6uYFGjSpv8Ce/kRxmKLtDNrVZWdnDLB9ZX0=;
        b=QOemzQe/YJI2ogl2gN0o5QpblX81Drw10/pP2ce+hOnz/XsGCIK8Yy3xYkeGcj5fAb
         eLhkuTrJSD7j/OgZzvUUXoqI1fyL4aqLiTxiGMo0E+VO6rULo5mSoYOK+u9PD1ksYtC3
         Nh3ttLfC45XG5diP8HjiG+mBPHHqwisoZB6cIO9XmDGoFDqcna6ivQeZfVIFxHJTPa6C
         +l7IFDZjkdybg0jJcTKQqJ29aqLu7jLHYxi4LQFjYcSRZ9/Xe5IQLHi2KYstWCxM/uvh
         HFHMekexyKA/sVRj6k42yfUwsUqHCbUwM7KgkrTAnEwVRjXyRIUY4OI1HWsB+S2pDZ0K
         txJg==
X-Forwarded-Encrypted: i=1; AFNElJ/KqmexGwmXiOwq5NChJx90KWF10FAoHdC7G75OvFdj1/mH4UxnQFd9nOXK91y76Rk1G2+fRTmoN/T1IXI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyMfA9PL3y/MINGKSQKZdxV1BQN0Jc1lctd/rKKG1IYlmIMqOVQ
	olwsp6uTgL5ETB6dVHuJg/A8+0Gz4jdSx/K+ZwLATFW5ZCM249eZ5yCMtQA7M4YeLJfyWvhOG/Q
	ikm5wJgLbNa0aINddh7yi7eqwZ31PoY0=
X-Gm-Gg: AeBDies+5P5e78sDcvvWNsVPxmiptYOZDjLY9iRt21dChjymEWn2Q7YAF2mXIJZ0jRo
	CWEEFpx/rEWOsru18g03qwPiWALVrV9aKo2B33gTWLtD85ndP7RXklby+Rx0p4LTA7SL1m/tgfl
	KcHYdjq8fhdPnJwTrhK09mfxbAhfVz3DPenuMQjW/7KxI8soGWVAZd+TREYZIb3aBT8RGNS1vap
	URCjzVmf5RIizV9HHM6oPLUDuuApf0ivN7WJaGX2bDbfOlIA7sxqbN9cBs/nx8IdAfwEQX3XX6K
	bkqgD3qTRSfuFnKC94c+XXM0D3vW055cClmBZBcMVqn0GkDof5swQQ6b285tf4GO/1EcAMT/Bum
	mUx44rSFIVza17egXl6nWcizph3Bxz3wFeg==
X-Received: by 2002:a05:7300:1352:b0:2de:6c38:707a with SMTP id
 5a478bee46e88-2e47883d4dfmr4268950eec.3.1776787263012; Tue, 21 Apr 2026
 09:01:03 -0700 (PDT)
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
References: <20260417152253.2312961-1-mkchauras@gmail.com> <20260417152253.2312961-2-mkchauras@gmail.com>
 <aedFgEicDW6LAcuq@luna> <aedJGuF9P2V1lOCZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aedQ629D0x-5KuKw@luna> <aedpk1iaeYyKPSOI@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aeds6_8Mr_w38oYI@luna> <aeec_IzVJwlfarN5@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
In-Reply-To: <aeec_IzVJwlfarN5@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Apr 2026 18:00:50 +0200
X-Gm-Features: AQROBzCqVWnAUPlPD1KfzhDI3x1JPlxYKYFHLCv9W-Ks_qXhO7vsrFg91y4pahA
Message-ID: <CANiq72n57hMF+0cATWgUiE1ccqJPwMYw_KAu=3PNJdG3=6yoDw@mail.gmail.com>
Subject: Re: [PATCH V11 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Link Mauve <linkmauve@linkmauve.fr>, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com, 
	rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 5:54=E2=80=AFPM Mukesh Kumar Chaurasiya
<mkchauras@gmail.com> wrote:
>
> The stable support is available on nightly.
> Refer https://github.com/rust-lang/rust/pull/147996

That PR was merged for 1.95.0, so it is already available in the
latest release, no? Or do you mean something else?

Thanks!

Cheers,
Miguel

