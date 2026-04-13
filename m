Return-Path: <linuxppc-dev+bounces-19720-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20745F531CE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 21:37:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvgk34G6vz30B7;
	Tue, 14 Apr 2026 07:37:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::32e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776116267;
	cv=pass; b=Xy4QFLu/sIUO3bmPOFzFElpib1kGuoE4/5YMOg0Ja7PFfusJc8BHdigupcH6EuHE0lefqoz8q6peSCqFQH/Wkux2Z2yLEvpFAuO5VHihfUa2YfebwYG5fjhveO8d4KH/Qzwe7UW60iCGKDBh2dCa8qCF4/SB8ZeWaIBHrs7+h+SPD72q3FhB0XWr8UebT13VYbc4HpzrcIhriMXkMYgRtSGLj4FEOvEbzL02i3Y/r/XMmIqkNV2wL1SHBRHoGw13wHLwP622hA/8OuYYkDC2OEV19aX/2EHoa+MNqBD19aoAihDsrpq/7h7nQAuqazSrvm1UoCNwl9/VarPqy4Es3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776116267; c=relaxed/relaxed;
	bh=wi7gLRpNhJNBp6N3dtmB/IxXr7jq+139i4egV+abNLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEYIp3Dzi5+sb2mfLesohc8U6LVSQi6HnxzbFN6qHdp81M343KGFxruAlXLde13bIpQfjHnA06+hLLhcmYWGlAvDKF7WKuWq6UB4EhaLUdrcNFsX21VRXLQrd+JnTzZfgyWnfC31MwWNHXuAQr0g/1YGN/ifaCfZc0iuaMDRpORGv4dTr57oh4PwrFnUhbdsf0SH0wngMv4DhdDq6CYx+rKuJy5wcI005m5ZIaXPXL4LV2/67dNb4RaqzbvVLwHGLtcb030n2UTUokjwA5hzrmCNCuZr5GltwLy0V/CpAkNP48iAy+9sjlXtPYuzXXgEIoAXLMt7AMcjy0i+r4Hi9A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ofNCv5Hz; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=litaliano00.contact@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ofNCv5Hz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=litaliano00.contact@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvgk14kZwz2yv3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 07:37:45 +1000 (AEST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-488a29e6110so53528055e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 14:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776116257; cv=none;
        d=google.com; s=arc-20240605;
        b=Lx0CSjCvvHtDpPU307fGLIihqVjvETIRJaqUd869G92IWXg0Kcbkg/9IAtTgp2qtK8
         uR1g3fp0XsPTt3WKxtoCDBxVND/6mgaLhZiw/MvaCNdRw+Xlx6nDDlG0PUlPedoUlZxZ
         uqcU1WmZtpn11OS9ViVwrdo+JirGHAYc86Jro16Lk6DQYuYfeataFk+dYEKVqFTrX16S
         uqpoLQkxX1OzsoKsuRGg41xU9LlTWoPzoUh85XA9tgcP7ikjv5J/MkyJ2qeaECebth5L
         f+qX8WZ8FQQJ0EXs4/7kW4g1Ml0DpzN1yVptPS1dLqeU+T322vSvbQx08jVqMCZ5Ghq8
         dliQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wi7gLRpNhJNBp6N3dtmB/IxXr7jq+139i4egV+abNLI=;
        fh=c2jJAaPaO4RR1dOQPf3VLiRpVQjTmlazr2kvve+GCgs=;
        b=HlBmpOZfANdwlzDAi3w4jelKeorKPGwYKioBHzS0hkX+p41zTc18WZocbYTXdkF6Zq
         z1FDBGIIkZKD/yL3Z/1iUeartT8jZhHJaR2OCrp85iEC054AlEwKt0BkWb34fiq7fQWF
         /f9UvNG7uiBs4W7m5BNCHZg7lItQrzbvU8pen+z5z9MEkM14ZC1kA/AcXyv3V+Jn5DRd
         Mc+z6ihXK1jyxMZ74zCIGQs/OGUQpt5ERrkbmErmK7fKgWla4IadfIay4D0AHYXeKjCf
         Wdag/CeCJvB4lP80fUmuwkroLB1I0q/rxqxsm8TQyXwbV7oV8nKr1NqxluYLah0u0yUo
         jJ+Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776116257; x=1776721057; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wi7gLRpNhJNBp6N3dtmB/IxXr7jq+139i4egV+abNLI=;
        b=ofNCv5Hzcaa0gutkfS9xIteCk7thoEogQFWJe6TnDUqtO6eOZksokM6HR34OBXP4MG
         7ALJCmOp784Cje40/C1mAKzJnLW346cdMNiCVpcW/OQybusIuRNav+3o0f8Cb/mYKGtX
         cYfrvWar/n5BDIdcHMOOFPkgcBVRtomsDWYta275M1IToBJbsv5C7NoZGKHfT2NA4ord
         CjSIYcb5BvMcsaQLAJoZMaW0ChuC89xkQxSulF6u1zHvM8cnd5jMqIDZLhSirleeRDxj
         9lZ6Q45iz9PZx2/ZxuFhfFOQXiWVCEMfkYEjUhRVFNwiyaa0Y/IkuvHQoOJRBYSt9gbG
         x9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776116257; x=1776721057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wi7gLRpNhJNBp6N3dtmB/IxXr7jq+139i4egV+abNLI=;
        b=ffr6lwm1qn7dS8ZCHlHFzjwvmnqn4AxQAGbwdyLrG8T0QLfR+PEXgqfiQZ8Dr8+cFB
         Uspn1X2hkhDxMnyLWXs08CEtHtsPAXrbylV4nff+b/VQ/oSI8aOaWLJCJz8xlgrMphVH
         EGY/DW6TPb++tzy9ZvSQDGANcTOYbShrhsfl3R2UdSZ/QmjIklxF6ry34nN8SPR5Yv0q
         M4QQJFmj5xUTEhLg3hfqr6PCUyedezGbugeht+2DlUyqtTWHdT5QZd1sS+SCT6kcv0kb
         Z/irYo3wQiFBZOtSPeIrMzCW06wfXJGiZgN0dMLigrBTtKanbip5qru06KXlaYbWKgj5
         H0Sw==
X-Forwarded-Encrypted: i=1; AFNElJ9wRDl3uVfmffwN28C0WRrYYZDQVfcd2t3rWErixaXEUqPLxuFSAFN6lcRlMZNq1UrvMLKge4CO2017cJA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxdkx2xBcwOFHtHKjuLmchWu06gZAkvLt68Vy1sv33sqzEykC9O
	qJxdD8NpTOSUpdP7PwIez6WGUH8szZ/GxJiEhXJypJJVui6kxbBQHyYJs7JUJVpb08wQzo6Uo3o
	psHn5PXAn2ls/pcEYwsJ+ikdB1Tpue0E=
X-Gm-Gg: AeBDieuBtDa8ljsLeUUh70NqlLxu62CGU7yF28rRP/A0wRJVf+lM/5/x9rSBVLmuHe1
	a8WqOtj8C0ww15GMb+Iq8pH2vjSP5OITvfouDJpts3hvW1R2nv9QZJ0h7IZ9rKQdjGFGuPD0gDl
	7EU9nekeMnJPP2JeYBvEbcn15rC5XNTUwBxQoyLbT41b6Zue+2s95a3DqjDvifcak7GWTgnREId
	CfH9XjhmrJPX1Pfacm1rlonavm7xeTwt7CnRuxn3JYtdi5lzxvi/TiPo7t4LsPU/R9ywMraFv45
	DH75nbo=
X-Received: by 2002:a05:600c:35c7:b0:483:64b4:79da with SMTP id
 5b1f17b1804b1-488d68b27d6mr225330925e9.26.1776116256585; Mon, 13 Apr 2026
 14:37:36 -0700 (PDT)
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
References: <20260406061542.22354-1-litaliano00.contact@gmail.com> <98adc953-322b-45fa-9128-cdbe831006e1@linux.ibm.com>
In-Reply-To: <98adc953-322b-45fa-9128-cdbe831006e1@linux.ibm.com>
From: litaliano00 <litaliano00.contact@gmail.com>
Date: Mon, 13 Apr 2026 23:37:25 +0200
X-Gm-Features: AQROBzA-2amtttPoqQMTICWR8n6VoaY5m-wKf_-qIJSFHiPLEmYWhd-AdLRgdrE
Message-ID: <CAK-CEVPA-qi9CvPyurDarLT-OFtOQJDmFoe=+pE1bBBy5fuLOQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fadump: Add timeout to RTAS busy-wait loops
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000008dbb90064f5e4a97"

--0000000000008dbb90064f5e4a97
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 13, 2026, 15:50 Sourabh Jain <sourabhjain@linux.ibm.com> wrote:

> > What is the rationale behind choosing a 60-second limit?


> The 60-second value was chosen somewhat arbitrarily. Looking at

rtas_busy_delay_time(), the maximum single delay returned is 100000ms

(status 9905). In practice, legitimate busy delays are expected to be

much shorter. I was following the spirit of rtas-rtc.c which uses a

5-second limit for simpler operations; fadump is a heavier firmware

operation, so I went higher. I am open to suggestions on a more

principled value.


> > Would it make sense to introduce a helper function to wrap the

> rtas_call, along with handling the wait time and timeout?


> Absolutely, I will introduce a helper in v2. The three sites are

indeed identical except for the FADUMP_REGISTER/UNREGISTER/INVALIDATE

argument and the struct pointer/size. I will factor out the common

busy-wait loop into a static helper.


> Will send v2 shortly from my new email adri.vero.dev@gmail.com


> Adriano

--0000000000008dbb90064f5e4a97
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 13, 2026, 15:50 Sourabh Jain=
 &lt;<a href=3D"mailto:sourabhjain@linux.ibm.com">sourabhjain@linux.ibm.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt; What is the ra=
tionale behind choosing a 60-second limit?
</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><br></blockquote><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">The 60-second value was chosen somewhat arbitrarily. Looki=
ng at</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">rtas_busy_delay_time(), th=
e maximum single delay returned is 100000ms</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">(status 9905). In practice, legitimate busy delays are expect=
ed to be</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">much shorter. I was fol=
lowing the spirit of rtas-rtc.c which uses a</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">5-second limit for simpler operations; fadump is a heavier fi=
rmware</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">operation, so I went high=
er. I am open to suggestions on a more</blockquote><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">principled value.</blockquote><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></b=
lockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">&gt; Would it make sense to introd=
uce a helper function to wrap the</blockquote><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">&gt; rtas_call, along with handling the wait time and timeout?</blockquot=
e><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><br></blockquote><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">Absolutely, I will introduce a helper in v2. The three sites are</blo=
ckquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">indeed identical except for the FADU=
MP_REGISTER/UNREGISTER/INVALIDATE</blockquote><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">argument and the struct pointer/size. I will factor out the common</block=
quote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">busy-wait loop into a static helper.</=
blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><br></blockquote><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">Will send v2 shortly from my new email <a href=3D"mailto:adr=
i.vero.dev@gmail.com">adri.vero.dev@gmail.com</a></blockquote><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><br></blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Adriano<=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"></div=
></div>

--0000000000008dbb90064f5e4a97--

