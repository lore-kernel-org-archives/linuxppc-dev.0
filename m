Return-Path: <linuxppc-dev+bounces-22576-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A38CD98D6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 15:44:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcP2K4xnxz2ykX;
	Sat, 13 Jun 2026 01:44:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781279049;
	cv=none; b=UQWWSIE1vsEWSH5p4DmZChGAth+/D2N7iS9dwYaszS9DtHVboFTBl0Cq18A2/TTbQopCK6QdXNj/pyorX7XnZAa949hYep5SVek8/kwBuFt7NFcDIHCDv63w+CITjdEl8+iERTqhQFIiyKlcGf62kGlZxPFyCdv9I4NdWwNpwnjBvwGs3m+37Ueok+TbmopoqB4X8FiLw0Bh8sBK3JR9TvD+iUyNukwZ1NVhytaql1dLvUhsNZ5gba6p+piWnrhD4sZ4nXfwQDWlrrRosHSMIbj5wTz7SA8b+SNyHD07h0tTn/3b8/IP2k7Cw+6aG1lCTlKbsBXEvH5jFPT6ljPBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781279049; c=relaxed/relaxed;
	bh=Ua7ilpqGQ1TJZ+Bnhifl0cs54R7li+gA4PLtG5KdeuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/4y4l8GppgtEzCkrzxCng7X7py4mXJsm9muXqcVHL7pfy1j6SCm5/CsS7Hb+yCeFI7PSAcN1I0aGMtng5GtuVKJvR06UNowwiN5ruKa1A6MXXavZAWj8KR+VDffL4Z9fPKlRBZy2fC8SPLoHlpOmvSXwu2nHMNg2/stDLJ3jBLS5PcyUW/+Mo/XBwQhEAr6w01EcsMykVQFHWbkkmEIbgdI4P7TgzUHj/jeKwhKFyp1DzaO/shUeFbXjAlnEFOUXYF7slF2XKQVFZaaOkiaFL/fwTl3mqxAuuLlRrGs/dh8ELTe/MeM0iuqyrXFYAHZKqQy80+njdl1j1WaeuLpvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h91m9/RT; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h91m9/RT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcP2J64tgz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 01:44:08 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6998D6008A;
	Fri, 12 Jun 2026 15:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD361F000E9;
	Fri, 12 Jun 2026 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781279046;
	bh=Ua7ilpqGQ1TJZ+Bnhifl0cs54R7li+gA4PLtG5KdeuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h91m9/RTVoc4n7+PHfPlE/bu8XLven6nAKb35XV39yApAjaHBXzKJ8LUiHX1Ax3Uc
	 hs+12QVOwd6kjjJHbtVqYUbhAHbpwTwAT5pFJ1nP+Sh0z/nfy0DvOJYNcBQNju/VQ8
	 P04Ynl5UWyd/Y7FiICFoenOJs8qje3zDwnbGwSrCRteIPXWRqJ+I5RPoff7YUeQKum
	 036rNdlfFTMd8xwP8TnkpAhJ8pars/jTvXV2Gk1guqSQ4I9+GOgKudR2CLNTsWKdV3
	 iLGdyKn3IuvIXLxhLCWAjcln79zQPU1A7k5OmuBwMgVtAKBb5X12h4oXaUeQjm/24M
	 9ALyckPrchIYg==
Date: Fri, 12 Jun 2026 16:44:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 phy-next 6/8] dt-bindings: fsl: layerscape-dcfg:
 define DCFG_DCSR region
Message-ID: <20260612-graveyard-hacked-c65d54a1ece8@spud>
References: <20260611193940.44416-1-vladimir.oltean@nxp.com>
 <20260611193940.44416-7-vladimir.oltean@nxp.com>
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
	protocol="application/pgp-signature"; boundary="Anvk3G/afIgQqFuh"
Content-Disposition: inline
In-Reply-To: <20260611193940.44416-7-vladimir.oltean@nxp.com>


--Anvk3G/afIgQqFuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 10:39:38PM +0300, Vladimir Oltean wrote:
> In Layerscape (Arm) and QorIQ (PowerPC) devices, hardware peripherals
> are accessed by the CPU through a portion of the SoC address space
> called CCSR ("Configuration, Control, and Status Registers"). All
> hardware IP blocks have their registers mapped here, and the Device
> Configuration block makes no exception.
>=20
> However, there exists a secondary range of the address space named DCSR
> ("Debug Control and Status Registers") which, like CCSR, also holds
> registers of hardware IP blocks, except the DCSR contents is hidden in
> all public reference manuals.
>=20
> The intention of the CCSR/DCSR split, to the best of my knowledge, was
> to place the functionality that is too low level for normal use, and
> which is necessary only for debug, in a completely separate address
> space which can be hidden.
>=20
> A use case has appeared where networking SerDes lanes need to be
> reconfigured at runtime for a different protocol (example: 10GBase-R to
> SGMII), and the architecture of the SoCs does not normally permit that.
> The Reset Configuration Word (RCW) is a data structure read by the SoC
> preboot loader (PBL) which contains stuff like pinmuxing and SerDes
> protocol mapping for each lane.
>=20
> The RCW that the PBL has loaded is visible in the DCFG block's normal
> status registers (from CCSR), as read only. Turns out, the RCW is also
> mapped in the DCFG's shadow register map (in DCSR), in a write-only
> form. Writing to the RCW registers from the DCFG's DCSR space to change
> what the PBL has loaded is called "RCW override".
>=20
> It has been validated that the RCW override procedure is necessary to
> reconfigure the networking data path when a SerDes lane performs a major
> protocol change. It changes some internal muxes which connect the PCS to
> either the 10G MAC or to the 1G MAC.
>=20
> Defining the DCSR area of the DCFG as a secondary 'reg' array element
> allows operating systems to perform RCW overrides. Since it is
> introduced late in the binding's lifetime, it is optional. It can be
> identified by name, but also by index (first 'reg' is CCSR).
>=20
> Note that while all SoCs should have a DCFG register block in DCSR, we
> only need to expose it for the SoCs where the RCW override procedure is
> known to be needed and has been validated.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Cc: Conor Dooley <conor@kernel.org>

Where did this email come from btw? get_maintainer.pl result should have
+dt in it.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Cheers,
Conor.

> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml     | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcf=
g.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
> index 3fb0534ea597..fc14fd0bf84b 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
> +++ b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
> @@ -36,7 +36,20 @@ properties:
>            - const: simple-mfd
> =20
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description:
> +          Customer-visible DCFG register map from CCSR address space
> +          (Configuration, Control and Status Registers)
> +      - description:
> +          Customer-hidden DCFG register map from DCSR address space
> +          (Debug Control and Status Registers)
> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: dcfg_ccsr
> +      - const: dcfg_dcsr
> =20
>    little-endian: true
>    big-endian: true
> --=20
> 2.34.1
>=20

--Anvk3G/afIgQqFuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiwpPQAKCRB4tDGHoIJi
0iTkAP4y8yskNE7dxgDzs/Wxh5ly8vIUHNi1EsapV2wtvfvMrwEA//4T48+aL7mC
/esW1vHzfucr882C38bIUCbZewcjhgE=
=NKQc
-----END PGP SIGNATURE-----

--Anvk3G/afIgQqFuh--

