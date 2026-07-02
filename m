Return-Path: <linuxppc-dev+bounces-23456-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512AAC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 22:39:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grsJc45VQz2xRw;
	Fri, 03 Jul 2026 08:39:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783031984;
	cv=none; b=FOz7TeMzEwND7e+GlgS82pnC76bbnF78kFYvc9iPq78vcFU2qGjinWI2+goEymSpZ7CaVbngSdbycqx1rUaQQFlA23ooFR7P1Dezg3Xw9j32TaIsQNlGyGqWf3g/XZqh5tqUSaDVELuPC+MnzHgw45udrzGZEpX8xKa9JNgcBO13hbZir05bmiSoyZvidNlphZL7l3L7QjhKuCbm3IfwV4SrUYNNRVHXcj6SZmS4HUbY810nijFg/BpAy+tEtRbujDxhZQpkXrEiZ1gbBjICQ4g+P9owKWJ6Ym7VJBP6zajbuAzfNrAaH1EzIo1RIgRH9/RmewpU3R+snoArP2MNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783031984; c=relaxed/relaxed;
	bh=jUEFO2dYlrUsHq/npRyqqQfPXBIu9PI/KDflitAC56U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMz2e6uFbqZ97DXcqL5WopolQHrdSCL2EdxWQ8ECq4aOpCi+sW+cCJv2G3J2vBO82cghsBbgtn9vGJt5dNWD8IyD7+QWFBuRfS4DIHZODbBnm3nVzjRz5jyMKtK/DH+sfumch4LidaQDUfybWtO+PoM5ky6K0l9P4yi2SDtL7P1vEe1AeC7UWnwoK/19J+2e4Lwuv0Wofu3b4Ii4715Ny3n8aEllAFOGJhfcpdONuo5UXjPw/p4pV+uiLKDitcAQ79sqJjJn7h8nwVfFjrwWMHAlQln8oc157wfhVWEC51Q624p22a+Siub65TxdzkbMP9MRTiQgZ6JeoMAwIZ7vhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EAOQ62Pe; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EAOQ62Pe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grsJX0Ymcz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 08:39:37 +1000 (AEST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-493be1b9682so17155095e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 15:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783031969; x=1783636769; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jUEFO2dYlrUsHq/npRyqqQfPXBIu9PI/KDflitAC56U=;
        b=EAOQ62PeCfSPA0iGtauKDOLUFWBptOgPssX4tS+KGcnL4UxUPXQjtCWa48KvARfAuq
         IY7YP12Vu79UvNRJQDr5zw10WlgOHj8A0hQBVA2ufJVIsrWQWBshwraw3kXIC0Y2OP0D
         eVfNH3585t2lYrY8jyTLErvvP1Tra19oIYV7xcejhcQJw0SHG6QgDk4GJ6WWlbRO1FHq
         S8L+QTGPOS3UrMVm3Km+1UOhHiNuNGR/aOBkAYQ2O58VtgYgQ7SI7ZJ0yOZEytVgSS/W
         k9etpjSad78f1boWo9BdecdMV0o0+8Dmu4i0mmrGjvMF+78CyLXGzWv9RrkpJ2nhcgx2
         rgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783031969; x=1783636769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUEFO2dYlrUsHq/npRyqqQfPXBIu9PI/KDflitAC56U=;
        b=KxCnKZsjLCoo1joXffMjNTDKSqFC9nV0Tp5Z3o9sbKSJB56KZ0jblOlxHND5YlUqmP
         Tk2EgEyX5pu+43hmuMY40iiV8XxERg0uhu5lNz1gqIKl/vD9FD+Rb4l7WxVidUPRWtBU
         eQ92RcQlu5twvK/4Jw/lW2pypfcIydKMRyUAZo0p9UzdQlEIO0fkD0k0QTj9hqM39tWT
         aOWZGBPgR+uROEW9+XbjHoQHRwVMhmMNxeC1sDSQPpb00xTG8hFmtZZsJQsPTKCMj2Oi
         idQZ2bXokbtP+diVISLpA6cpR6t0Hz/9vVj21LCh87qNG7R5EWTtIpf5JvYIMQz47DYP
         B88w==
X-Forwarded-Encrypted: i=1; AFNElJ8ftHzJvskwpGbZmPeq5WxW1Cz5FBbuKlM57Pzo0ClMyFDIk4U57VBu2y3STu7jv1RJYhQ5GrhOyl+ygQY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw8dkkIe/AaHbqUybIVwoc2J9xHR9dFT8WLSw9LS6kSYJxJmPta
	pusDJe4RW8dKJzY1iFbSMgH/5L3LQlIJprnq8y6IEOrOGCQ5kD0sDOwW5XU/oHIpYUw=
X-Gm-Gg: AfdE7ck6y2Ulv0FrSxuIvrHCLKiEBEsVDV36gA6uSDR7zBZfFi1OcmZXZ3+jWl/MMzv
	E32PQE/jW2miqAumqcWy3btMCdE7HiPIv2xhpsb5UdyZKzh50iGLGLGSM4hpGRSl+pL4KibXQKN
	O6T21XZuhK0tE0sHucO2aYFE04G1vrDIgHCeyOvpxl6++5T0gXUUjl02RL1FbpbIHboVS6OV/zW
	MqSAJSxVx0NIcbKB2RC6UI/NjXOaIkkRLLmQsqYrLq4SoNKRk1SaBYxq55EggYh3l/uTF9lN13F
	EV8ix5g1hMN1xv0RRR3Z1McWBC9j+fTkF6xRCVJEFv6G3izvUIE5P364glOw0WCfm0Fc5xRP6GF
	4x9z8IMDfRyLIZiMboKYLf62hi/AC4OBhIebu0D12+pqrB4KJrIX0tcZ18eCcYCq+8NybkJWRt3
	RXWLAv6h8+bLyBd0Cf8g==
X-Received: by 2002:a05:600c:6692:b0:493:bb6b:5bda with SMTP id 5b1f17b1804b1-493c2b983b8mr111151595e9.29.1783031969110;
        Thu, 02 Jul 2026 15:39:29 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493c635c41dsm155275235e9.5.2026.07.02.15.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:39:27 -0700 (PDT)
Date: Fri, 3 Jul 2026 00:38:18 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] USB: gadget: fsl-udc: fix dev_printk() device
Message-ID: <akbmlZKNiF2z90F-@monoceros>
References: <20260702141536.90887-1-johan@kernel.org>
 <20260702141536.90887-4-johan@kernel.org>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nulx3wvnaf5kt2p5"
Content-Disposition: inline
In-Reply-To: <20260702141536.90887-4-johan@kernel.org>


--nulx3wvnaf5kt2p5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/4] USB: gadget: fsl-udc: fix dev_printk() device
MIME-Version: 1.0

Hello Johan,

On Thu, Jul 02, 2026 at 04:15:35PM +0200, Johan Hovold wrote:
> A change replacing custom printk() macros with dev_printk() incorrectly
> used the gadget struct device instead of the controller struct device
> (including for messages printed before the gadget device name has been
> initialised).
>=20
> Switch to using the controller platform device with dev_printk() so that
> the controller device and driver names are included in log messages as
> expected.

I don't know about "expected", because before 6025f20f16c2 the affected
device wasn't included in the message at all. But I agree that using the
not yet initialized device isn't nice, so:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Thanks
Uwe

--nulx3wvnaf5kt2p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpG6FYACgkQj4D7WH0S
/k4wnQgAgH+bRzd/g47MZIWPVDUm/GIRllQkmHGQpbbPtH1l42O12kHnutcWShhF
29ExqURXwq7jY9SaSKB0Eoiv7kVto2Y0I3VVL9qTWA9icwCt1KRzjXjyxrMSWxwe
OgBxCb+cTzVfSM3D2ZXbP3ZqY3BVoxLc1M4aAlfO0G6lwaGJ2tWmaOxRR5P3n+le
f4GuNJP9DVvSw5TSyY4vUliDPLwN5g3MLfeYEcpaqDav4eW1bPKTpC7itWX2jdTY
6iTNkWRxiEYLn/VbmPca1SusZ4ViA/0hHIIjJDD6BNYm6IyzaCq37abkiI9w0z6e
hfxRl+hHKTWLLbm2i2JNy6Cznx4DaQ==
=JsLz
-----END PGP SIGNATURE-----

--nulx3wvnaf5kt2p5--

