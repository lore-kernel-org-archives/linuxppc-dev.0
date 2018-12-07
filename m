Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A6CC07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 11:49:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0432083D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 11:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unwm1oiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0432083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43B9jd2K1hzDqM3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 22:49:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="unwm1oiN";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=thierry.reding@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="unwm1oiN"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43B9fT2mDlzDqsw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 22:46:24 +1100 (AEDT)
Received: by mail-ed1-x542.google.com with SMTP id f9so3452887eds.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Dec 2018 03:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YQVhFedNKIcX5C3M5v5vQqKHdNP/jZsJfdiEpUfk9TY=;
 b=unwm1oiNV0qsga6ccKGjCKGz0OxyZIlSrEsBMJLbsHBIrzMURBAnWlOvVyt996/mkT
 ZnItnTo8zwkLCXJsl1dCGaDxBIdbBs26EIs5IpVwj7DvrSuYHEuElZ2v3DIaRmJnuFH5
 saNSb12WbBJF8I6ZJqCyr54wpu8D3buBEyGp5geSGyi3pq4ffW8DtUXzlLxAh452cD/V
 jTcxfk6Mavf0KnR2fgvIdHlZD2vpdO4LtGEj283LWgvNMyGPSf8H5DyoIta3xZywUmLS
 t4mo+nf7XY3XkMr7qzNKQ0U5yFOMpQHK9ruPfDthlbPHqIjfbO2/j3UuxZj+MAkt8Gav
 ZP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YQVhFedNKIcX5C3M5v5vQqKHdNP/jZsJfdiEpUfk9TY=;
 b=gr8mcB32CJiKZTRfQcuDxY01b4XXv8IZ3nDtRo6PRRI+P6NNLEpZWWZsnxqkPIVZZs
 9/ssX1Sg7RVOHUji6mnz2L83ZzQSM1GsYSPqBf466OFKzoonR5uCiBY00EHVQ2CiMKr9
 FjPGi8lPW7ZSpqE5US+iS0DgDyh7uAgu/MYfC+vxJ5zEliqGtgTHfslCRTWQlpVAVTAE
 68OMoBzCHSCFHPqAr96oCu3X5JrDth43iNIkEWh8eF7SkGJf4/3k7mPiF4oILF3OgXYF
 eodfBSW8I0pUw8HuDgwZoBQT4g+OI21YvZ+tC7PiXlV2SYdzafq1SSZRNMOZT5uFUX6i
 wNWA==
X-Gm-Message-State: AA+aEWagj/O/dcUS3OycLfT2bwQgZcTndg3rVN+3/cNi0HcpWzYaTMRN
 eufJhkWyRxKwuIkzvnrhTAw=
X-Google-Smtp-Source: AFSGD/UDeWLELCLWfio77QCnXgRqEs8Reu7HKw/dY9SGWtrTthPC7tEuJ1HFxtKw7Vb7GdLvJvq5nw==
X-Received: by 2002:a17:906:12d3:: with SMTP id
 l19-v6mr1722572ejb.74.1544183181719; 
 Fri, 07 Dec 2018 03:46:21 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id 13-v6sm505342ejx.39.2018.12.07.03.46.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 03:46:21 -0800 (PST)
Date: Fri, 7 Dec 2018 12:46:19 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 30/34] dt-bindings: arm: Convert Tegra board/soc
 bindings to json-schema
Message-ID: <20181207114619.GB30719@ulmo>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-31-robh@kernel.org>
 <20181204085022.GB25962@ulmo>
 <CAL_Jsq+NWVoFzBCYVwu-YM_90mYUdgmaW4ctJim2LkxfpRbg=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+NWVoFzBCYVwu-YM_90mYUdgmaW4ctJim2LkxfpRbg=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, Grant Likely <grant.likely@arm.com>,
 linux-tegra@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 04:38:44PM -0600, Rob Herring wrote:
> On Tue, Dec 4, 2018 at 2:50 AM Thierry Reding <thierry.reding@gmail.com> =
wrote:
> >
> > On Mon, Dec 03, 2018 at 03:32:19PM -0600, Rob Herring wrote:
> > > Convert Tegra SoC bindings to DT schema format using json-schema.
> > >
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: Jonathan Hunter <jonathanh@nvidia.com>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-tegra@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/arm/tegra.txt         |  65 -----------
> > >  .../devicetree/bindings/arm/tegra.yaml        | 101 ++++++++++++++++=
++
> > >  2 files changed, 101 insertions(+), 65 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/arm/tegra.txt
> > >  create mode 100644 Documentation/devicetree/bindings/arm/tegra.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Docume=
ntation/devicetree/bindings/arm/tegra.txt
> > > deleted file mode 100644
> > > index c59b15f64346..000000000000
> > > --- a/Documentation/devicetree/bindings/arm/tegra.txt
> > > +++ /dev/null
> > > @@ -1,65 +0,0 @@
> > > -NVIDIA Tegra device tree bindings
> > > --------------------------------------------
> > > -
> > > -SoCs
> > > --------------------------------------------
> > > -
> > > -Each device tree must specify which Tegra SoC it uses, using one of =
the
> > > -following compatible values:
> > > -
> > > -  nvidia,tegra20
> > > -  nvidia,tegra30
> > > -  nvidia,tegra114
> > > -  nvidia,tegra124
> > > -  nvidia,tegra132
> > > -  nvidia,tegra210
> > > -  nvidia,tegra186
> > > -  nvidia,tegra194
> > > -
> > > -Boards
> > > --------------------------------------------
> > > -
> > > -Each device tree must specify which one or more of the following
> > > -board-specific compatible values:
> > > -
> > > -  ad,medcom-wide
> > > -  ad,plutux
> > > -  ad,tamonten
> > > -  ad,tec
> > > -  compal,paz00
> > > -  compulab,trimslice
> > > -  nvidia,beaver
> > > -  nvidia,cardhu
> > > -  nvidia,cardhu-a02
> > > -  nvidia,cardhu-a04
> > > -  nvidia,dalmore
> > > -  nvidia,harmony
> > > -  nvidia,jetson-tk1
> > > -  nvidia,norrin
> > > -  nvidia,p2371-0000
> > > -  nvidia,p2371-2180
> > > -  nvidia,p2571
> > > -  nvidia,p2771-0000
> > > -  nvidia,p2972-0000
> > > -  nvidia,roth
> > > -  nvidia,seaboard
> > > -  nvidia,tn7
> > > -  nvidia,ventana
> > > -  toradex,apalis_t30
> > > -  toradex,apalis_t30-eval
> > > -  toradex,apalis_t30-v1.1
> > > -  toradex,apalis_t30-v1.1-eval
> > > -  toradex,apalis-tk1
> > > -  toradex,apalis-tk1-eval
> > > -  toradex,apalis-tk1-v1.2
> > > -  toradex,apalis-tk1-v1.2-eval
> > > -  toradex,colibri_t20
> > > -  toradex,colibri_t20-eval-v3
> > > -  toradex,colibri_t20-iris
> > > -  toradex,colibri_t30
> > > -  toradex,colibri_t30-eval-v3
> > > -
> > > -Trusted Foundations
> > > --------------------------------------------
> > > -Tegra supports the Trusted Foundation secure monitor. See the
> > > -"tlm,trusted-foundations" binding's documentation for more details.
> > > diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Docum=
entation/devicetree/bindings/arm/tegra.yaml
> > > new file mode 100644
> > > index 000000000000..66493892ffc1
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/tegra.yaml
> > > @@ -0,0 +1,101 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/arm/tegra.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >
> > Could you explain what these are? They give 404, so I assume they are
> > more like placeholders and not actually used?
>=20
> Please read the documentation in patch 2. They are used, but aren't live =
URLs.

Okay, thanks for pointing that out. I wasn't Cc'ed on that patch, so it
took a while to hunt it down.

> > > +
> > > +title: NVIDIA Tegra device tree bindings
> > > +
> > > +maintainers:
> > > +  - Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > +  - Peter De Schrijver <pdeschrijver@nvidia.com>
> >
> > Not sure how you got that list, but probably from git history. I think
> > it makes sense to replace Marcel and Peter with Jon and myself.
>=20
> Will do.
>=20
> > Other than that, looks fine to me. Some of the enumerations below look
> > somewhat hard to parse, but I suspect that it will become second nature
> > in no time.
>=20
> We can add descriptions and/or comments if that helps. I didn't add
> them if not already there.

My comment was regarding the schema syntax with the oneOf, - items, etc.
That's all new to me and difficult to read, but I'm sure I'll get used
to it.

Thierry

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwKXYgACgkQ3SOs138+
s6GutQ/8CGUawOVXWa2O3RRFvjPZq9Bl151N7gluvIlFcVkD8TNspGoYaTDxSc9r
2GnDUorHpU3mroiOnB1mDvCuPvrWwMmLgI+7fPSIkMJ5wCC24qFjSMvEXgzVCeu+
JaZL4VxICnKxWtrlPRlDfFlLuOP91Zgj+sT2zBK517m3gbjFWN1im+42+lrNsO60
tNLIJyFAUkGjtzNYPNFKJxuW8+Ubgl33S5pRPNmRpuImb6Pmou0LMRYM5l3R8dvj
5+yeHXiKgwi25HNXIaa9+Kc9ouBOaR+cqY2+fI4VelaQ07Ip+eURXed7tDZrm2h3
0wgkBAwuBh9AlIhP0njOTw72b1s6UHZ18o6yFYzaGr3tQej504ZPf49BI9TTa/Ws
Pp0FRrIuKa3bpOlEL+Z04VYbV0erjIC5bb8eqJrJiKXE9EAKequjVcHBDtuhUGiG
pTEm1dXpCplN8RJRHazTksM9AygJxqmF+0vlQI5E/utjQEjfm3WYnDsmZNZ5yJQD
I0vd65LKeMGu32lm1S9vVrlLbwHwcL3/tgly++A2EwjD8OrNCw8rXDNvicK+sJ9E
sBB/67Jay2JviIHRhPeHyZuCpe9mxXZEKaMi+WpEdOED4miar02/fejWpjDRrYnt
eU4soLlgiTj/KP+ihgQXtQWGTE7pbuCUPXHYll+v/GcWPuTKiss=
=/353
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
