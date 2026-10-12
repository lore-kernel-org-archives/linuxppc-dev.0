Return-Path: <linuxppc-dev+bounces-29293-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A69CA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:28:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3Qvd2Jcwz2xyk;
	Tue, 13 Oct 2026 05:28:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791829709;
	cv=pass; b=AJopif7gV3SWnGNmvpY1zJdv6Yg0VTfwQTaIaZuGBbR8jLH2jJ1wqzjnXal/nh1+M4CHKXA37D8a+sOGCDXGzgg8SNY6SEtqMyJhIG2RbLpSE3FLIn+BLl9Gny3DmSlNzNohwXFHWDyWjpIvhvG4pf7TeBUIcPJVClaPweumMRHJBYey9kA/Q32s3xv8xnZapiHx6W9s1mHBUm+EE/G/T/DrEK4C4pOSjAb8s9B7V/yOp3YRkCMsiWVydEjsX9KmL5EZS8FiZi8NhsUql2de/DDzstRUaEoxnyC0MJ5N/N45DxkTNFxKHcsDiFCQ41HjpNe2DBFW082/lUhzfKuW4Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791829709; c=relaxed/relaxed;
	bh=X1HT9Pt+o9MrzBBoQCfbPBHKtSg9tMq6DaY0MoNl9E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hs9mM17xm3RAin2RikekE6BZNFqx1EWY29sC9mpIM2lwKzIdvDw++0Cib1Wl0elixcxvjgkSIGYpD5SBS7HMcvSsy/HUbYsNB9PioAEzhBiT5SfsEHAjLkZncYYtUCQLxjD1qBbZF9fxYXWMvOuIL7OgM0v7qo7bDiWhgaf4xNfLEe/Fn46NwxxOKBUfhOcS1UtBQZ9u1y/7WDNxQSEwAynvblmo8nTPf4w8XjgstyywsOw4zduF4LJiapJVwxOasiKQv7DjUs0RPZ2UCcLoqRKkLW1Uum9k4gV9YcEEeMhDNgBH3pE36rhXZc0IScpErRY2q3CV3Jd8cPLC0axPzw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HPMwp31P; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HPMwp31P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3Qvb6QmKz2xnv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 05:28:27 +1100 (AEDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-c2e8e738ae0so344296466b.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 11:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791829704; cv=none;
        d=google.com; s=arc-20260327;
        b=SnOXZBkzrI5jXXTJLt24EIFVkwTDUyx9lpVD4L/bfYWNxJEJmEk17/4+Item/dC0VV
         wjIc4KN6DAsf4pkjf/+qXbrU4FI/lRBvg+IvOyTOxTGJMkiYSeqvLelSq6eBxkFbvmIW
         8DhUSl39f0aHpD9Fjwvn3DyyVinY5q0JimtIKSGwFlgPjTeiIf/BLJz7ux3GZ+kbWyAM
         NbuWMk9J3IOxiobWe12taMFWN2zf+5N233ygBFEsa0sAnsH9gPWBm1x8ImKYqYsPejbU
         XHUc9UiKXiZ0PkyKReh5wMVF3t6YIQm4SwMmgf8UuJtQ/CaCkG+PSexo8Ns8UodsD1RD
         DO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X1HT9Pt+o9MrzBBoQCfbPBHKtSg9tMq6DaY0MoNl9E0=;
        fh=JTZ9cu29awM4EnLP6O2sUrrlQSUYp0sUyGKz5kVoD/w=;
        b=gkVyEMhc561JW3TjrDRT/i7IgYVgGY7AtMaFxtedhcfRJCZHFwx8LyLgGZ8ywp0uDX
         9effwew5qTdUQV4J3bowwF8qnLC7IsRky6vpM9sWsKtS1Lpyv7+zCcPxPV53vAQ5h4BI
         OaLdGz2q3V0rRx62TIqg6UqeTydnlH3QtngDI+Zn731jqgzTwgB/lzRsrPjcdYBDjFPN
         7lGGGX6UXmMawkP5wqOC4SCM5+8JU9Esh0NYDyrQGbov/nl/UsHKTrwBEdbM4xRM+X2+
         jBkMLynmmJsaQDRGtZYghruzBju+RbB+DQ50BthlTD4d+T2zs2Qh2QlEFUYu7LCm924b
         xx4w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791829704; x=1792434504; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X1HT9Pt+o9MrzBBoQCfbPBHKtSg9tMq6DaY0MoNl9E0=;
        b=HPMwp31PxV6xHxsMNSiVDcYGCHoAfEAT82xoT9urRzZqhxmR8b1zLUY36EKH8tvaFs
         qDn60de3F/F31LickuM2aLH4uZGZxzgyGuKbs9xzp1XWkLRo/jq1lpuIpZpwZ4hDsebo
         16HNv+AatOoRnTOvp9RiQNOYD9OXQURsGL32Fk+JQedIVLk9gwP3VdkCF5mN6+9++DFe
         Es78hK0ZYfGTK2lFk+WQ/E7qwY15UND9ffY9fa3vtAUkOIf/yikfoCrQGAXQTZ4T7p4T
         IUf7uXFA4H+acihtRUFkEkzzmqsT1+30byVaTcmaEZ3gzr5gIkwdWV0XOmmtriW7e7U8
         FF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791829704; x=1792434504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X1HT9Pt+o9MrzBBoQCfbPBHKtSg9tMq6DaY0MoNl9E0=;
        b=K4QOvmgSykDaPZHPfYhCPQR/tmlffaKmfhvk1X8pmt6zTvZkV6Tgz4i81pqPnTcV59
         20tcUCSWMAVc8XpzyTNlvf/aCnCcPv+2bVzwLBauZdy9JsP2/yf2us7/WGt2W4jcQntp
         KLbwXb2I+O/fAAmWZF1CsLdow7LamWFwEvcxEVlygxf/UbGvjvFXwKPA196aONZFFwHo
         2FvUcyWSp10/00D7gn0ySfR3R2IzJep+dey9UumVppnEwK+G+uT4SDMwAUaNtI/TjOUb
         O7nO4Q5BYPFTZLmXAPJWoT77oVvySziVw2Tsg7SElafGmn3yB9S88jgOQEBxqJ5+Sejx
         iuHw==
X-Gm-Message-State: AFq9FYJaZHHhnQuNPNG0HSFQ6AedVckStXQ9XQohSVQF+COLCMvbpXpA
	WswYQ+7BLtYdJUgJgUibWDmrFwayYIYTBShMGsIStNLFCw0Ad3/Kn0nqzQUHPC08g8ae5qUwkHi
	9HSjDKrVuKcVu7PvHDdqslGmA10RnsZg=
X-Gm-Gg: AYBFou3KwwcsD4HIYAgsTLsUlK+CoNBUZak+5q9tq54jX3cQsw/ESh/sUNNwOAfUwhk
	sULw90zTKg7PlKrG/Jw3ty1HOTsmfez1/Xg3UX35IrNE7NjF/mZqolpOwzFxYCwPlplsgBubQyU
	VkuCfRG4H4yevpEx0wjg5YnQrWfJ67V82J+cAtTxgk1Bzsz6bBQ4FnGZTimnnqhnO4poCKzJ/i8
	7FnuT4wvw7EX0vCVm9GnEoNHO+45XxYCTKz8kKittuXCERnnJiUt4Nm0DN9YSDLkA+jtO4sSiex
	NaxP5d6Aay0HUCUHX/icv5AM8MsF1EL8QaZcKBkgXHqvzZPvFgQaGYTOFtkORUR0AHt4Zo5K5ew
	tsHe5RxZKoy3ryuGo7KDekB4Onvvw9Iw0AjMA6LGLbAITaTJxTSrgUhHwLw+QJxzFNJmGp6KMZ3
	k9vfg5j8/fEBrUMhaQ1a2wWjrY65mJe85mHazGCWPzNHNOy21XsBiunMmYgSkwYD31t4FDlHG0H
	eDP
X-Received: by 2002:a17:907:6d16:b0:c26:1649:47ab with SMTP id
 a640c23a62f3a-c31a9f8d2c1mr953059566b.33.1791829704105; Mon, 12 Oct 2026
 11:28:24 -0700 (PDT)
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
References: <20261012180052.55578-1-rosenp@gmail.com> <a877ad04-c4ed-4e32-a1eb-da524146be14@kernel.org>
In-Reply-To: <a877ad04-c4ed-4e32-a1eb-da524146be14@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 12 Oct 2026 11:28:11 -0700
X-Gm-Features: AclHuK9om4-s7JbX2EeWgr9wdpDS-k9VE1RFDW2IRINiiqHf6FMCUdMdoAcCjcc
Message-ID: <CAKxU2N-VQ9fWGvdNvyZ7te1gp08qMSvbSpgLrKRkqDO+Y+bYwg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/lib: prefetch ahead in __csum_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 11:18=E2=80=AFAM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 12/10/2026 =C3=A0 20:00, Rosen Penev a =C3=A9crit :
> > __csum_partial() walks the buffer linearly and reads each cache line
> > exactly once. On cores without a hardware prefetcher, such as the 464FP
> > in the APM82181, every new line is therefore a demand miss that stalls
> > the loop. Packets received by non-coherent DMA are never in the cache,
> > so this is the common case for GRO checksum validation: when routing
> > TCP with GRO enabled on a Meraki MX60, __csum_partial() takes about 30%
> > of all cycles and is the top entry in the profile.
> >
> > Issue a dcbt four cache lines (128 bytes) ahead in the main loop.
> > dcbt is only a hint and never faults, so prefetching past the end of
> > the buffer is harmless. Lines that are already cached, for example when
> > checksumming data the CPU just wrote, are left untouched.
> >
> > Measured on a Meraki MX60 (APM82181 at 800 MHz), single TCP stream
> > routed through a qca8k DSA switch, iperf3 median of 5. Only the dcbt
> > was toggled at runtime, in the same boot:
> >
> >                LAN->WAN               WAN->LAN
> >                Mbit/s  csum cycles    Mbit/s  csum cycles
> >    before      495     30.5%          439     27.2%
> >    after       599     15.3%          520     13.7%
> >
> > That is 58% less time spent in __csum_partial() per byte.
> >
> > The prefetch distance was chosen with an earlier, slower driver
> > configuration (median of 3, Mbit/s):
> >
> >    distance    LAN->WAN   WAN->LAN
> >    none        370        341
> >    64 bytes    430        381
> >    96 bytes    438        397
> >    128 bytes   438        385
> >    160 bytes   434        386
> >    256 bytes   423        383
> >
> > Prefetching the first lines before entering the loop made no
> > measurable difference and is not done.
> >
> > Assisted-by: LLM
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> csum_partial_copy_generic() does the same, so your patch makes sense.
>
> Wondering if you should use MAX_COPY_PREFETCH instead of hardcoding value=
 4.
li      r9,MAX_COPY_PREFETCH*L1_CACHE_BYTES /* prefetch distance */

LLM comment:

What changes per platform: MAX_COPY_PREFETCH is 4 on every 32-bit
config except 8xx, where it is 1. So 44x, 47x and e500mc behave
exactly as before; on the 44x (canyonlands) build the instruction is
still li r9, 128. The one difference is 8xx, which now prefetches 16
bytes ahead instead of 64. That fits how the copy routine already
treats 8xx, but I didn't benchmark it.

My comment:
I don't have an 8xx device so I don't know if this works properly there or =
not.
>
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
I'll keep this in v3.
>
> > ---
> >   v2: reword commit message and retest numbers.
> >   arch/powerpc/lib/checksum_32.S | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum=
_32.S
> > index cd00b9bdd772..5a14d45c7b9d 100644
> > --- a/arch/powerpc/lib/checksum_32.S
> > +++ b/arch/powerpc/lib/checksum_32.S
> > @@ -43,6 +43,7 @@ _GLOBAL(__csum_partial)
> >       bdnz    2b
> >   21: srwi.   r6,r4,4         /* # blocks of 4 words to do */
> >       beq     3f
> > +     li      r9,4*L1_CACHE_BYTES     /* prefetch distance */
> >       lwz     r0,4(r3)
> >       mtctr   r6
> >       lwz     r6,8(r3)
> > @@ -52,7 +53,8 @@ _GLOBAL(__csum_partial)
> >       lwzu    r8,16(r3)
> >       adde    r5,r5,r7
> >       bdz     23f
> > -22:  lwz     r0,4(r3)
> > +22:  dcbt    r3,r9
> > +     lwz     r0,4(r3)
> >       adde    r5,r5,r8
> >       lwz     r6,8(r3)
> >       adde    r5,r5,r0
>

