Return-Path: <linuxppc-dev+bounces-24712-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF5EC44524
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 05:30:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5KTR1t6Hz2xrL;
	Thu, 23 Jul 2026 15:30:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784784635;
	cv=none; b=SVVcoQTyXRnkXuPVjrcAnr0dx2sUQDjJmmoQhIbqQnsDg5ePZKNnQ8KbPEcqIc9IvSgKUbteRfHL0oZBN8r95Dgzh4CMmt0xGBgYlEvgc5u2LzoP/E4B6NEkCx4JJXLU8/c5K7YjOSJGxTVeQzhDRWbQBVdoU8M88sCevOvfoshCfWAIyhuWpt6If1xM+OtrWkyJndDAbYB53YOz/+BsAnZ0Cf3PNnBMohc7Kw+CJuufEnXvcg4lQWydrzoAqgHwsIt/QIHkKzqgYmsOfb6fQvQvdujik6gMd6EH1HHMBNk8n2NXVNGrSn2A26ZttWebXa2f2KWzFSLitwKQ5xhj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784784635; c=relaxed/relaxed;
	bh=Gbqp/BETAuL10zK/QjDMLkNML3uJVDKQA/suEZyhESk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzKeID1hwh8m+K5CjU1XVS0xDtdiueTrXdSjh7lnjQTFIHd4D6xAFQTFIE6+C2fNd5rKFTsHjGwXI1SYd4i9AyZzGXZBUFsPHR2NDcGlFZhZvg1wGE8ltMY3QMv9TZ/SS1nSHB+ZmppbTjrnABH+vTWprORlS58hEIc0OzZmeiWfNZ5lSVK5AW3uI9rUzU3RgDMr146zsRe5ResGuqp/ocTCkwIPWdoc8uvnffzEGnQ5yUhKSmX7ODfSupQQEdZWKcWvmSQtQxyyclE4VR0YFqzhptMZ8xJ9UmqoMj3JDyit5w27q7zGYjdDL8rXTbgbfpvFXTbOEcKWOXB+sBXiRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=BBqF0orv; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=BBqF0orv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5KTM0Cb7z2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 15:30:28 +1000 (AEST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so159573f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 22:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784784624; x=1785389424; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gbqp/BETAuL10zK/QjDMLkNML3uJVDKQA/suEZyhESk=;
        b=BBqF0orvf/og8AM8ES7racZNZxQG1vFpUv0zfycSrDEiheQpKoC62fhPSFztgs6l7P
         dFdW0acsrF+oNWsCdqmRyT0j2uWKQNSCpt5rwYpXfcPYaEepmEVaYqj3HipoXh5KpZnY
         k4UbTVtTFnj3RpatErK6ZK+l7vIsSHhPfBV+F13cLvJI3OXn6M6gahyRIAlpB8QvFcZ5
         ohKzKRIMa4qPu4h/y3RLp0tWG1nG5jVs450dsW0YM5VQ+IM5+yB21oMLzF3apJros6RJ
         5741wc4hagW+VYojfR6dLAzZGf+S9kEGTeeBZFUc9dGphAqduAxzI5ZB1VHYKtC2TUci
         f1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784784624; x=1785389424;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gbqp/BETAuL10zK/QjDMLkNML3uJVDKQA/suEZyhESk=;
        b=rD+3AgG1XItE1q9cCMT7OFiNzsfPQT5LEFSIQ2J//kvlTGCeMAFJHDMca75u5z2iGl
         0dKebJBCVLcjR6chSzCoEO8WNxQV+8v4jjQdwkbFFNV48woOGdkDpDKUuKI66IzJ+mUZ
         Ii+t/I7/IAsObz4rw+FKlSwlf6jA12G6H6dV8+DTNSdxuZBQlbz+XNwQy2KbGP7mvRUE
         JznBEMQr32LAM5WmiZz4oRpKnvCQgLx+Nyt1yzJeum4vQN39OjlA6JKzKZ30S39pQ4tn
         WPQYEWsIukqjk/tIufqHoE8QgsQ6FNih68itqo+V+sM/N7kkCxCs+Kj9SoA52+q6bor7
         QZOQ==
X-Forwarded-Encrypted: i=1; AHgh+RosE4MtGWeRVd39sBtH06wB4hvhs06pcKLxQn3MMspqYwUhwqf9P9HNQe8sZOSlduVMRpQW2ZiAzuR0rFM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwU8oD0Pr6917UDm7fFXe/dBz3Wqjq2/25pzlo3CWab4gMLFAmU
	+DyBfDvsD9May6ugc1UOOmzPtMM136tlUg1bbsBeUl/mhHfXffC5PkiolkbvF5yCEp4=
X-Gm-Gg: AR+sD116k4S7jVeduCLoXx9aHsZldqi+B0hb/ASDLWKQJpfuJxMqdszycB1ypjeGcWv
	xtURPcd64LUbLDZn5go6nzh4ByBDYTG1LPdEysYGTEij0BV7P1sydYjUx4Vpkp9OQ0G0hkxXNA6
	fRwlbjdQ3PyEl/MCXCQ8O+1y5KqWkpKBVI6VAHawUrktl6t/nPJuY8Izfykc2J8PhofB60J5/zM
	HTFnOjFPHyPlw4QMGEwjoJ3oF3XdkqF2fpZ+CKPj2D4Y7sCVkzC6alES36pNcVMSMFXzj7BYmTR
	d9oIelIX7lAwohuMoxSFCDa3ut5IuCTGb23ZKpsltWKnyJYLLggQohTyMcx5c0F02NfCrDkkq91
	vKAzSwN+WhzNCHNt+zU7v7IXPBv3B7ov1iSrybuBZyPuunRPP5lqLf1CxtHlWM/KH31JzL0aLBf
	1HHVJaOBw=
X-Received: by 2002:a05:6000:402a:b0:47f:4c9b:99b1 with SMTP id ffacd0b85a97d-47f8d754483mr1814550f8f.32.1784784624091;
        Wed, 22 Jul 2026 22:30:24 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f85bc62basm11851732f8f.13.2026.07.22.22.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:30:23 -0700 (PDT)
Date: Thu, 23 Jul 2026 07:30:21 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Shengjiu Wang <shengjiu.wang@gmail.com>, 
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 6/6] ASOC: Unify code style for platform_device_id
 arrays
Message-ID: <amGhHDDlwMdool_q@monoceros>
References: <cover.1784528081.git.u.kleine-koenig@baylibre.com>
 <093867d47c079d2aaab06bccaae734c54c342a7d.1784528081.git.u.kleine-koenig@baylibre.com>
 <0f625961-8e2d-4ed9-ab5a-fd95bcb4c87a@intel.com>
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
	protocol="application/pgp-signature"; boundary="oygi6rynka5zevcn"
Content-Disposition: inline
In-Reply-To: <0f625961-8e2d-4ed9-ab5a-fd95bcb4c87a@intel.com>


--oygi6rynka5zevcn
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 6/6] ASOC: Unify code style for platform_device_id
 arrays
MIME-Version: 1.0

Hello Cezary,

On Wed, Jul 22, 2026 at 07:55:26PM +0200, Cezary Rojewski wrote:
> On 7/20/2026 8:23 AM, Uwe Kleine-K=F6nig (The Capable Hub) wrote:
>=20
> >   sound/soc/au1x/db1200.c                |  2 +-
> >   sound/soc/codecs/adau7118-hw.c         |  2 +-
> >   sound/soc/codecs/bt-sco.c              | 10 +++-------
> >   sound/soc/codecs/wcd934x.c             |  6 ++----
> >   sound/soc/fsl/imx-pcm-rpmsg.c          |  6 +++---
> >   sound/soc/intel/avs/boards/da7219.c    |  6 ++----
> >   sound/soc/intel/avs/boards/dmic.c      |  6 ++----
> >   sound/soc/intel/avs/boards/es8336.c    |  6 ++----
> >   sound/soc/intel/avs/boards/hdaudio.c   |  6 ++----
> >   sound/soc/intel/avs/boards/i2s_test.c  |  6 ++----
> >   sound/soc/intel/avs/boards/max98357a.c |  6 ++----
> >   sound/soc/intel/avs/boards/max98373.c  |  6 ++----
> >   sound/soc/intel/avs/boards/max98927.c  |  6 ++----
> >   sound/soc/intel/avs/boards/nau8825.c   |  6 ++----
> >   sound/soc/intel/avs/boards/pcm3168a.c  |  6 ++----
> >   sound/soc/intel/avs/boards/probe.c     |  2 +-
> >   sound/soc/intel/avs/boards/rt274.c     |  2 +-
> >   sound/soc/intel/avs/boards/rt286.c     |  2 +-
> >   sound/soc/intel/avs/boards/rt298.c     |  2 +-
> >   sound/soc/intel/avs/boards/rt5514.c    |  2 +-
> >   sound/soc/intel/avs/boards/rt5640.c    |  2 +-
> >   sound/soc/intel/avs/boards/rt5663.c    |  2 +-
> >   sound/soc/intel/avs/boards/rt5682.c    |  2 +-
> >   sound/soc/intel/avs/boards/ssm4567.c   |  2 +-
> >   sound/soc/samsung/i2s.c                |  2 +-
>=20
> This change is outstanding when compared to patches 1-4 which follow the
> per-driver approach.  I'd expect one driver per scope e.g.: Intel's avs
> split away from the rest.

Well, patches 1 and 2 primarily follow the one patch per type of change
approach that happen to only affect one driver each. In the v1 thread I
was asked to split out split out the amd/acp bits which resulted in
patches 3 and 4. (And just now I notice you also replied and asked to
split out intel/avs, too, which I missed. Sorry!)

Conceptually I think one commit per driver is the right approach[1] but
most maintainers/reviewers seem to favour one commit adapting one thing
for all drivers in a subsystem. And in my experience no matter how you
make it, you get a reply to change.

Will split out intel/avs for v3 and maybe hit the sweet spot then.

> Nitpick: s/ASOC/ASoC/

Fixed in my tree, so will be correct in v3.

Best regards
Uwe

[1] My reason for that is the "one atomic change per patch" philosophy
    that allows to document who reviewed/acked what in a fine-grained
    way and allows selective reverting and backporting as needed.
    The downside is that the number of patches explodes, but git is able
    to handle that just fine in my experience. "commit count" is missing
    in https://markcarrigan.net/2026/06/18/the-museum-of-meaningless-metric=
s/

--oygi6rynka5zevcn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmphpusACgkQj4D7WH0S
/k4QMAgAiodEGJ+3wdZbbFha1cyeXY/4KnGWZwIGS91iUn/fGAugHIQjGusXDdlf
MK7Bm5B6RFc0nJmVRuK+dlVyvBjWnDiaqrcvEgW5iiGHt0e2d4B2yEu7aNVj1PDs
wuPQOThaBv7yf9NP9ddxiGofvSIuKVv7TxVf+Qf/OQjSyYseX57zpPS9h19m71vl
aVVtSUNPiwoeUnQWkRsq/qWZgnOeUrQTyXQekkv7uz1N43QnOnmb3m3iBX+mI1AN
TAfJQ2rTyMYEyIZfvwHe4nD5Nz4TpjStRk1BmH/HE8616DR4stk5Ts4tvSv1f6KT
qRSBSo9+7iG4nv7Avnq6gwIf7pTisw==
=tSnN
-----END PGP SIGNATURE-----

--oygi6rynka5zevcn--

