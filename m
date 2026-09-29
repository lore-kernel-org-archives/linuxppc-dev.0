Return-Path: <linuxppc-dev+bounces-28427-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A29BCA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 01:37:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv1512V5Hz2xbQ;
	Tue, 29 Sep 2026 11:37:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:39::2b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790645845;
	cv=pass; b=L+DYXYYxetlvu5Ya4pZ8XfSrq+toSVL1RCWIk+7v5tpScgQS7XEAwL2fAtBO5n5+ma5o78mJjALAUrXrTEzKHZkGKD9oeroYjBrTHVAn2lg58j3u13bAQ6EhC/4IlF990906SboQsfcKDotdX+sK8pkSXlgOLloXlHeU/zazUop0WDr5TNHHoHBPjNbvzEo4qUxlsm8dHn1cUAVjIY6rmIH5bT1f5f0LkMevd6pkvRr5P8CCLOkvSCI+7Zw7Fne1d5ara6cuenYz2kq2HTl597tfJFze+yjKlH+0+oElXenDbUpX/DrQyVYvE/WQ3JILlv/jLVpkZZaib8ZP0+vRyA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790645845; c=relaxed/relaxed;
	bh=rnkVO0aoE0KnX2d76+g96XFlNkoLJdwXuRaJYCNLsiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXhzGzb3w44k8ygb2EKdhxY7/AgIv93d6uzLeuvywoWo/icbpdpruwVV3haadzp6zCItGUxsi+5C7pbvh5NPudyGGQ4Py5/NrLuJsFfe+peGERCtXscyUV6Oy/mlu/athn3wgx/qCoyfZUzGCgS7cfb4To+rcGEVk13kKHgNZHqJ3SaaywDkXkcdFlgj+5eLrWonk+2yU4uxdVVDjlGP8F8YdTjMZIxZZOHrJIka6XRGyYcfh3wBH/OGzX86yMwNDML56DW6WHFdir/1qEnBwHenEqTNVc4+LTeCD2fhKjm5ZGOB2jylcXRbg1/u24fQ7EyfBLdbJ4ulcbLjxNX1pQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dcOBlfCT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::2b; helo=mail-pj2-x2b.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dcOBlfCT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::2b; helo=mail-pj2-x2b.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x2b.google.com (mail-pj2-x2b.google.com [IPv6:2607:f8b0:4864:39::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv14z5Pmtz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 11:37:22 +1000 (AEST)
Received: by mail-pj2-x2b.google.com with SMTP id d9443c01a7336-2e2c7eb3b8cso644575ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 18:37:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790645839; cv=none;
        d=google.com; s=arc-20260327;
        b=UrH4kpRpnD08yTFEXzaMoMVNir7tQ+L5Y4uiFLuiY7mkDxmYA/bVwGGFA7BTTFT6Yq
         A4tcqJO0PgbThPDdUePeBD4IEG7PDGZaqEFN9/AzCb+bYjZpF2OGFfGW86mVgIGMiKBU
         vC9MkhXhJtCKi+5jmAxgJRZOkhv2enELAuQ7nW2aU6l+uMwugdf0ol7I3IVsi8r02mHo
         4kJkCKZrz4tWh+/5BejPT2e+PIs7aa5b+GZjV1a70ULNH5sIn3byIMM/sHVQaLmcZYb3
         lK2WDHySRhDvCmkcV20U14e5z+WQ4j7S+mnl0lRhK0YnSK0OGTnAO9bvGYvruWEkDseS
         aOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rnkVO0aoE0KnX2d76+g96XFlNkoLJdwXuRaJYCNLsiw=;
        fh=0pt+UEMPOEWB/YuRmi1ArbgxLIHzW/n5eGtkGcarU/I=;
        b=O40vINWAwU7rzh1209DF8HGgoUwrnGKDdE24WBMmuoU9EqeYDcGdVR0qGmz3/yVX7L
         R6Z2ypdN2EqUkWyLx0IvoW4Kroiw3hu9lfRouMRGiqsb6zZI6e2SXsbm+YKhbeYHA54B
         H8VF5G2LrucPIIWmmwvHD1TFQEzHvpP4+NeR9W+I97iLzz84+Cw8TSxoc8VHGgPpI13u
         ARN+Xq9z/zA1GnEqSLRSwivUTL0g6xXn0LVsGYSkA5DJFZ/TPuH8RNr1cpXnCrrGGskZ
         /zGepNyMr6O8uCdqOjf1f0MuzG6MiqYDKePCP5+lNz+iEPstItR7y4YO+cZA416fwqtR
         kB5Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790645839; x=1791250639; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rnkVO0aoE0KnX2d76+g96XFlNkoLJdwXuRaJYCNLsiw=;
        b=dcOBlfCTXgrj87c9KS78iB7NH7RsA8+fqlXf1w/feo73Mw8A2HjG6A56nYjHWhcphh
         3MzXiw44Z9u4ufyt8HNTmwM+jnLklRIcwfupUDckxvLt5hIWGm6h1dfZo3Ek1lJ+Mnqy
         cTZRroq693aPBsIyN1sZuFPmmZCEjvmAsVV3roFqxccQxbZyY/v9iTxV6FAEUtiEZpat
         WM/7/gAQKODBxtUe7CS5fzg6CxBbJVJepLLDSwr7DtTR4ns9aWYj8X7QhRJPrwmkM52o
         XXaZaDdo428oAey3phJ1BDTv5IO82HIjMJwIxhUFfHHmc3aptKvr/jfGhmHVj748Krd8
         LU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790645839; x=1791250639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rnkVO0aoE0KnX2d76+g96XFlNkoLJdwXuRaJYCNLsiw=;
        b=xj0gNYjsste3+XMzJeehzehuR6/cVriVxrH/KhV9FYKA7N4zqlbxMjm8QE3UEIJgQU
         +hIj7EKqOgUm4hjVY7iLEhgtia8EjqFg1kSFTDy6Zijc7ufAjafLuKZvREyshBB4vwzp
         cRAgqd75p31lkkWmCB2Fu6TW0HGXv7a+vfjmVhD3DpO6QosBiy/6fFcZjodgz5Kqvwuq
         5tkS4y6Seju+Ce2Xmnanroi6aeIEZMdiL8mA4PbG9CbVeOu3SqGYmzPYn94tx+slkz0t
         8R6UD5J3H3q1CUHXICQDPNishbKJgvTV2YS7BKT5d8exed8riHj7OF4AeIfMehJ9UkJO
         opuw==
X-Forwarded-Encrypted: i=1; AKwUvBypRit9JM8L16KVvqgqQ+Wwhj6vhDTMFBl6ga5PuGi4kR1qYJRHZw+G3W5phQ9XNQljplCk76JjU2upBQs=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK1YJaxYEe7txbOH/yuAnG7jzh3LWT/w44uFgeJFy6Jf9Cx2AIU
	FGe5Gx5Yiw4LJ5n9KJ39NxsZYoVvOLd+6+M33eoDhhAZKKgTnBLIEIUjJlACTDY820Pr8aN9O6h
	rJiAM32DSc9D7KEfXhd3HpEZqVUIgwkg=
X-Gm-Gg: AYBFou1ZtNgfqc8KL3kE6wV42jwRnl0RDW8l0YfNJ9OFcHGQkfzoODYJpsN7z9sKb93
	JO+ttJJHfdLM9JlFsZmwTD5Mf3aT976BAGmKg8yMj7jjIbZdfjA02AncK0y/fF9trEOJ/5IrLOv
	NfQlRnDWDjk3p/TVZrcK4b9ecYX//ztJxwmMXyV25MriKVTvR8fZZIvCdo9yG6c0b6EOo7nbw/4
	8bHwFfse3uUrKCqEpw99XDFd5HuEfp+422+gPfnAWdgb/t9jNVFl8QpUaS/NLh9Oe1MEnrvdmpu
	552y61jrJvd3i6chD8ZSTWR2aRxAEAB9tks/CqyAyBMqNcDklqxQ1Ps=
X-Received: by 2002:a17:903:3c4d:b0:2dd:c100:b2c6 with SMTP id
 d9443c01a7336-2df7dc506e7mr124008955ad.49.1790645839130; Mon, 28 Sep 2026
 18:37:19 -0700 (PDT)
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
References: <20260928061727.1844167-1-shengjiu.wang@oss.nxp.com> <7be95093-1e29-45a7-9860-5605763baaf2@sirena.org.uk>
In-Reply-To: <7be95093-1e29-45a7-9860-5605763baaf2@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 29 Sep 2026 09:37:05 +0800
X-Gm-Features: AclHuK-gi7etBZa6zDkid3kRxBB448XKArKELjgsns_Uu77zQnT7DY8d5A5ELVQ
Message-ID: <CAA+D8APNVx1P0G2pPJ3W9u0eY2pqsKeV0Ar0Aau9AeR5mYgpgQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] ASoC: fsl_asrc: expose individual DAIs per
 conversion path
To: Mark Brown <broonie@kernel.org>
Cc: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	shawnguo@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, 
	perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, Chancel Liu <chancel.liu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 7:26=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Sep 28, 2026 at 02:17:27PM +0800, shengjiu.wang@oss.nxp.com wrote=
:
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > The i.MX ASRC hardware supports three independent conversion pairs
> > (A, B, C). The driver previously registered a single DAI with generic
> > stream names "ASRC-Playback" and "ASRC-Capture", which prevents
> > multiple independent conversion paths from being used simultaneously.
>
> This and patch 5 are not threaded with the rest of the series which
> really upsets b4 :( .  I'll fix it up but please look into your tooling
> here.

Thanks.  There was an error in the thread, the patch 4 and 5 was blocked.
Then I resend patch 4 and 5.

Best regards
Shengjiu Wang

