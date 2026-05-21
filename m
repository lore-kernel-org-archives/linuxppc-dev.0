Return-Path: <linuxppc-dev+bounces-21343-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD86CD5BAF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 23:29:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gM4P52s7Pz2xwH;
	Fri, 22 May 2026 09:29:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779406153;
	cv=pass; b=KTTT1D+5ltpm4S18laNh6oq2N7WscPYBvK2sltKGqw/0U3pf4QlzCfVJy3oZdtyAOy16PknNPkJD8QM3SRoOrpFbpqu8IwPiRz7ACgsWKJLdLQKOtUWn9PY+fHEVEhulhEQ9NjwM/m5TcfuuRBZNKI9tnh813HpqxEWZxuP+3WL3+uFa3xwNv67rZ850nKiKTvKlOiRVAxWzF8+BjFl3tjVfMd0opwo4JGxMGR4PZhIXAhhTS6pAkL09jN96o+cYbRY9pEgwMeR5tNsHm1zSjaQSk52VoFF0X++HEUtqN/kbwnzXCVSO3nZld/aLZFdAujl5koE7WLMUi/Pvod/DNA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779406153; c=relaxed/relaxed;
	bh=ZRaEEtcu5aoVBQcXKQ40u2+M4zW7oY2aObDk0D7HGVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgjNyrFIKJSsd2v+bGjZZgJcG1bGj1Tb7cY7lPWy98OXydMk3Vb5wQVDtSb+qm5Y65HYWxqbF7/oiW8bYib5NS+LcCUtjzrAx6NaN2fA/bHbpJgC3exTjn5oiqmJnLeHsXd2/+ZkgpFTmF7dFr9qJRYu092pUNVnJJvEobLudmBNXt+B3X3LmIGezCbQEA78gLD+nZ/ccDn3aWizXPmZjQgyVh/rnzeJZE4RZMlJqbY3+ZID7fmk4LoC4KSURqi14UaGcTNGwwYzZJGdpA5yv1x4f/+wtItS7GbgukN+kkDt/ttaeQ3fTX3ei8dn8LeTQyFq0yvnB4VTzu91FBo72A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IIaxZg7F; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IIaxZg7F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gM4P32sRzz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 09:29:10 +1000 (AEST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-67b32c695efso14099025a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 16:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779406146; cv=none;
        d=google.com; s=arc-20240605;
        b=J2o1c790SQZBrMDqrLn95fv4iRvhFdzYPAT4vH3F8FMC7iR/EPKJxAfYyHcKTEwLFX
         +dGqGx8tz9ryuBMl8+6Xb5/jYbaZlM75+PzSvM4zchkU9zheKBf7JC8Fhe3sVdNDK1NP
         QebMwpQIARxXZb1TxQRMwstCkTkzOLl3y0cOsz96KrJoZyQNZuwAuzSwBwJ2jCEkz4C8
         vjRReXYouSQORlaO5HIEDdRQFJ1K3ByqrSVh7A36aY6AKAuUkysinbWZQNobyEvtTd0y
         ftFS8Dazw17UKM7Jv8QyqNB3f1Xh/GCKSCgoFL4nW4pPkFaXuM5mk/5Hag8toxM1Xm1h
         m1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZRaEEtcu5aoVBQcXKQ40u2+M4zW7oY2aObDk0D7HGVk=;
        fh=9vgRqzPfuPglqvTo+IvhDLxywvjm2hyzCz92C2L0DgA=;
        b=i6y6UZRczcn4YNVVLNncV2VonVjifU/ZjmSg+rSdm3fW7SHXWhtkEAyFUno1p0e2hC
         618acZ52OAzYuFiXVK53zhQZgURLSaoL7ae/ieH1IA/6KU+6TWeNFRYoSPIZ1wZ+h24h
         1T3C5I5QevAuOdZGvvKAnXeoKIthIesjFleBHr7pkX0iWQIWC/WIWubeW9+UYeIkQobj
         R4pYZQamMqDp9WHQyfvkSz8XUDatinCWeWhfLmGePJxXQjogPLl4FFnCsdhOfiCyrcTB
         CDQwq52a4Nl3+Vm6bINVM3/P/ryfjA2y3XeSaup8J6d34OHbWpjeAjIstPtjnti3FS9y
         r5EQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779406146; x=1780010946; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRaEEtcu5aoVBQcXKQ40u2+M4zW7oY2aObDk0D7HGVk=;
        b=IIaxZg7FJZK5/TpNQFkmnFAw6DBlClQxWz2mh/maseI+FLth+qBzA+s59OaaEKGpej
         BB1y+hEp+X+R2p/6tTyWmHRLxirGuNzIZZ/7MVskClQofzFCapojhhq7de6aij2h3FsU
         4p3SKlZiV779lV4ScmVMZbrdoUPrq9TQxY7P0WMnjsK2fN1Vo2g52YRCXdBKLGlmXH6N
         39onWI7JPLj3ZAyM3kGoTl2490qPqHqVI8P61wMwbaJdqWNzgUgqWUoGfWG6Ou4qqbUY
         GjVpH8t41Er/aVxa21Q6SNKI8keKs5+Nmo7om13fYCqTpEeUrc5UmQjHKb3xb1Xj/Ki9
         uz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779406146; x=1780010946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZRaEEtcu5aoVBQcXKQ40u2+M4zW7oY2aObDk0D7HGVk=;
        b=qgJ/nXisjZBCUXu6vpVSHt9gOMy8QvWxgOSxT07x6k2ndhXVA2/HarfuZT5cnH7CIm
         3BxoU6t/a9KNE7OYeDpDwx7HrtmBJ/Af5/mSm8ehHV6mVB5Xm52n1AsEygrLaAhU3OZ3
         s5aV1vrcRXnGQaT6heMyl/Fu1Bw6PMuyDBushxNGHL6Biv8PmtrSh34KA4Hfayyns/sp
         FyVnuCPa3huAZAU062Fs+G9gCcD0qx0bxuIjiP8IEAM7KFbPNvK9YNDDjUHUCyk0RFDJ
         ZUv0HpKwAcc6OLpp01lFsVUHqJ03LaKxYqUJRU2xF4T3CDL4K8SvfcXgrz7rA9ft0TYV
         kLcw==
X-Forwarded-Encrypted: i=1; AFNElJ98dH3JUXk6V13IH2ljc1WNWBpbbcT0WIQPd8p0S2b/H1Qjeu2vIxpw6U2ARvfZj9RRZ+OnAJycZbP5IJk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxpVPTt4hOEvQNB0om0t+mX6Gy52ZYo7y3RgwPuuSVtqKPxhiho
	FMc9y1WH5Rz+ik08E6+g4Rd0vnOToQnoSPXvO+vFwn2F9ytPLjMQwPyEnJMGg5XGxl8BBTCC1nY
	qxDbgxzrU/J+FFNTxOdEWa2jSAraMgxU=
X-Gm-Gg: Acq92OGSKEHH7tt7T0eEbClzh9QI6QO2nyAMSFt3+fp2MVvng9zjgnF77swZf0gKGAL
	7fjtALWiN6ttUtrCpFkga44eTqz3gcIVz7Mr/udaLlLM/s2cNMoGVae40DfSFJI9Dfek/CH17qM
	vVYAI/v3gCa4K1BU2ggik/oMJPaFJItzACqWRMbUxGFMaxK2Iyh0MtX0GNDm7NrcFJzlubsQSop
	ZmHIHy+9qrjbKxBPQnFBI//U+UzLsh5NzmyJBEu2CQnFPmxIIYYNsErm+FdQdMVWyDZwLiThEIl
	v1X6/aTHhjfHdK6uRlxtq6ubMX2qynr9bNsqxLvvajaSlZpgJLs6NYDPe8z32fHOuRfffWkLES7
	EnYRYadGpn3hOer++Bn0RnQwqbLqmBVUKJaxZyor5pJFqGBzMEFPLgTI3BQ==
X-Received: by 2002:a17:907:5ca:b0:bcb:cd03:7d7f with SMTP id
 a640c23a62f3a-bdc01d009c5mr253930966b.31.1779406146281; Thu, 21 May 2026
 16:29:06 -0700 (PDT)
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
References: <20260517192856.3925-1-rosenp@gmail.com> <20260520165746.7ed10c7b@kernel.org>
 <CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com> <CANn89iK7i4u5nWxQCuURmSCJt8Sn+Q9x_ME8X+J0pF2_4OGuZg@mail.gmail.com>
In-Reply-To: <CANn89iK7i4u5nWxQCuURmSCJt8Sn+Q9x_ME8X+J0pF2_4OGuZg@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 21 May 2026 16:28:54 -0700
X-Gm-Features: AVHnY4IDG_uMXoWKwgJzup3yeBBTXO9-0wxM-YmzD0wTA1_WCxA3WbYMMHjzM7w
Message-ID: <CAKxU2N_63D7SFPkr9H9UYWif2DRW_qnV0SzZoRHWcRZtC_HTWg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack handoff
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 6:41=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, May 20, 2026 at 5:39=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wr=
ote:
> >
> > On Wed, May 20, 2026 at 4:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Sun, 17 May 2026 12:28:56 -0700 Rosen Penev wrote:
> > > > Collect received skbs on a local list during RX polling and pass th=
e
> > > > completed batch to netif_receive_skb_list(). This lets the networki=
ng
> > > > stack process packets from a poll cycle in bulk instead of handing =
each
> > > > skb up individually.
> > >
> > > GRO should be even better.
> > GRO will result in slower routing performance because there is no
> > hardware checksum.
>
> Then provide a knob or something, instead of trying to avoid GRO.
>
> For end hosts (forwarding not enabled), checksum will need to be
> computed anyway.
> GRO should be faster for them.
>
> Note that GRO also uses netif_receive_skb_list_internal()
so you recommend switching to napi_gro_receive even though there's no
RX hardware checksum?

