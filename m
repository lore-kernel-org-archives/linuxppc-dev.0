Return-Path: <linuxppc-dev+bounces-22577-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2899FCD98CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 15:44:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcP2t6BRLz2ykX;
	Sat, 13 Jun 2026 01:44:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781279078;
	cv=none; b=n0nh/l7qjVzU9Ni0HTZubQjDSKKr2+sZioJgWjl1ljO8a9ImVFDN8nEnrpm9UEaDLWYXBndXhKMmqJAjWNdFiURHytDpfdrcE6XHzU4auooXGkj05CE5qcoaD4StQ0h5nqzy725CFZMlXdHIKg2a+ejfFXIpYmeUtxABWBoqMLr7iTkDhAwmI6Nhn/0EJ0v0/97GG4ZnX0bTRvcC4SYhp86ohPd6Vi/YKM7OMIsMAk0DBH9FB7CBccMXz7lPuClJTuQi5DsD7QDmcg46ta4WugIGUTfgeA3++4AxsOR1yfj4KTU8w+IPWeDOwY5kjZjwinnYfAL9YuAAPPW+CzbuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781279078; c=relaxed/relaxed;
	bh=S+0GlFsvyTIfuouEBopxeMKJCoLYJ2b9k3kt0gJUk7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PknblOWCU/HvNNbP2nxPFCR/6vYPPnC6r4Uju+AsR1LYmkLlilvVu24s+mRYByocZO2g3sV4Kvdp/O+/NlT/W6Y1wmYDThmjT2qUooFDNWujSNQmqKl679lJGT4NYT5tHOdbAUMeyk9ltctEfVA6ztUY9kMdi37AtYNmfNi9IZ2ovbeESqGdffUPoofyOOvKEp3RvScwXmTAfwy9OoAbvUBcOqG6Kg6siIs85oD9C90j/uIE2ENRcttG/Jaib7SAygvfv5/6Mblo3Pgr/HqIBkRgBWL9UODOi5sQJCMcQvBLdahaXwkOgYK5OnxJH13A04Nuzo3f7GpUZS5aI6qE7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q8pBwT0B; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q8pBwT0B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcP2s5zq0z2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 01:44:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DEA4A60008;
	Fri, 12 Jun 2026 15:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41B31F000E9;
	Fri, 12 Jun 2026 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781279075;
	bh=S+0GlFsvyTIfuouEBopxeMKJCoLYJ2b9k3kt0gJUk7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q8pBwT0BPFtm20O4KmeTbdD4ndiMr6vaHVXN0TGvVxkO7pycW0oXxmTb5IW5eaSwf
	 a0N/5zOLH/jCGgkmv/Dj7skE44FtGILz9y9HIa1knnHKakBpEE0Xun8w21Pbe1Qsfk
	 dArJ3a+F5m9F/OpB88UnqidL/qFr9OkbDdHAosTpOGtEhf4Dv7bxeMMuQrskkxSH9J
	 8+6wAO34Mzyo3vmD7Ob+kJ+rc661ZLGKpTkGtR7AfxesnFfyGawuDUsR6l82EJJIP/
	 vwI4dIQui961ieLSm5VHfy95uKQe+qcNRqclphMeu8wn95ARa8Ht4r/mOEZkRGflNq
	 Cp5qe6riCbRXA==
Date: Fri, 12 Jun 2026 16:44:30 +0100
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
Subject: Re: [PATCH v1 phy-next 7/8] soc: fsl: guts: implement the RCW
 override procedure
Message-ID: <20260612-twenty-diary-4aab5327f9c2@spud>
References: <20260611193940.44416-1-vladimir.oltean@nxp.com>
 <20260611193940.44416-8-vladimir.oltean@nxp.com>
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
	protocol="application/pgp-signature"; boundary="+oYs0Ry07OA4ycIc"
Content-Disposition: inline
In-Reply-To: <20260611193940.44416-8-vladimir.oltean@nxp.com>


--+oYs0Ry07OA4ycIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 10:39:39PM +0300, Vladimir Oltean wrote:
> From: Ioana Ciornei <ioana.ciornei@nxp.com>
>=20
> Add support for the RCW override procedure which enables runtime
> reconfiguration of the protocol running on a SerDes lane. The procedure
> is done through the DCFG DCSR space which now can be defined as the
> second memory region of the guts DT node.
> Support is added on the following SoCs: LS1046A, LS1088A, LS2088A.
>=20
> The procedure is exported to the "client" driver - the Lynx10G SerDes
> PHY driver - through the following functions:
> - fsl_guts_lane_init() used to notify the initial / boot time lane mode
>   running on a SerDes lane.
> - fsl_guts_lane_validate() used to validate that changing the protocol
>   on a specific lane is supported.
> - fsl_guts_lane_set_mode() which can be used to request the RCW
>   procedure be executed for a specific lane.
>=20
> Since the RCW override procedure is different depending on the SoC, the
> private fsl_soc_data structure is updated with two new per SoC callbacks
> (.serdes_get_rcw_override() and .serdes_init_rcwcr()) which get used
> from the generic fsl_guts_lane_set_mode() function. These two callbacks
> hide all the SoC specific register offsets, masks and values so that the
> _set_mode() procedure is straightforward.
>=20
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Cc: Conor Dooley <conor@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org

Wrong CC list for this specific patch?

ta,
Conor.

> ---
>  drivers/soc/fsl/guts.c   | 286 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/fsl/guts.h |  20 ++-
>  2 files changed, 299 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 9f2aff07a274..23ec5750080c 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -15,6 +15,30 @@
>  #include <linux/fsl/guts.h>
> =20
>  #define DCFG_CCSR	0
> +#define DCFG_DCSR	1
> +
> +#define MAX_NUM_LANES	8
> +#define MAX_NUM_SERDES	2
> +
> +#define LS1088A_RCWSR29_SRDS_PRTCL_S1_LNn(lane)	\
> +	GENMASK(19 + 4 * (3 - lane), 16 + 4 * (3 - lane))
> +#define LS1088A_RCWSR30_SRDS_PRTCL_S2_LNn(lane)	\
> +	GENMASK(3 + 4 * (3 - lane), 4 * (3 - lane))
> +
> +#define LS1046A_RCWSR5_SRDS_PRTCL_S1(lane)	\
> +	GENMASK(19 + 4 * (lane), 16 + 4 * (lane))
> +#define SRDS_PRTCL_NONE					0
> +#define SRDS_PRTCL_XFI					1
> +#define SRDS_PRTCL_2500BASEX				2
> +#define SRDS_PRTCL_100BASEX_SGMII			3
> +#define SRDS_PRTCL_QSGMII				4
> +#define SRDS_PRTCL_PCIE					5
> +
> +#define LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1	BIT(14)
> +#define LS2088A_RCWSR30_SRDS_CLK_SEL_XGMII_Ln_S1(lane)	BIT(6 + (7 - (lan=
e)))
> +#define LS2088A_RCWSR30_SRDS_CLK_SEL_MSK		GENMASK(13, 6)
> +#define SRDS_CLK_SEL_XGMII				1
> +#define SRDS_CLK_SEL_GMII				0
> =20
>  struct fsl_soc_die_attr {
>  	char	*die;
> @@ -22,9 +46,19 @@ struct fsl_soc_die_attr {
>  	u32	mask;
>  };
> =20
> +struct fsl_soc_serdes_rcw_override {
> +	int offset;
> +	int mask;
> +	int val;
> +};
> +
>  struct fsl_soc_data {
>  	const char *sfp_compat;
>  	u32 uid_offset;
> +	int (*serdes_get_rcw_override)(int index, int lane,
> +				       enum lynx_lane_mode lane_mode,
> +				       struct fsl_soc_serdes_rcw_override *override);
> +	void (*serdes_init_rcwcr)(int index);
>  };
> =20
>  enum qoriq_die {
> @@ -138,9 +172,13 @@ static const struct fsl_soc_die_attr fsl_soc_die[] =
=3D {
> =20
>  static struct fsl_soc_guts {
>  	struct ccsr_guts __iomem *dcfg_ccsr;
> +	struct ccsr_guts __iomem *dcfg_dcsr;
>  	const struct fsl_soc_data *data;
>  	bool little_endian;
>  	u32 svr;
> +	enum lynx_lane_mode lane_mode[MAX_NUM_SERDES][MAX_NUM_LANES];
> +	bool rcwcr_init_done;
> +	spinlock_t rcwcr_lock; /* serializes concurrent writes to the RCWCR */
>  } soc;
> =20
>  static unsigned int fsl_guts_read(const void __iomem *reg)
> @@ -151,6 +189,28 @@ static unsigned int fsl_guts_read(const void __iomem=
 *reg)
>  	return ioread32be(reg);
>  }
> =20
> +static void fsl_guts_write(void __iomem *reg, u32 val)
> +{
> +	if (soc.little_endian)
> +		iowrite32(val, reg);
> +	else
> +		iowrite32be(val, reg);
> +}
> +
> +/* Some fields of the Reset Configuration Word (RCW) can be overridden at
> + * runtime by writing to the RCWCRn registers contained within the DCSR =
space
> + * of the Device Configuration (DCFG) block. The layout of the RCWCRn re=
gisters
> + * is identical with the read-only RCWSRn from the CCSR space.
> + */
> +static void fsl_guts_rmw(int offset, u32 val, u32 mask)
> +{
> +	u32 tmp =3D fsl_guts_read(&soc.dcfg_ccsr->rcwsr[offset]);
> +
> +	tmp &=3D ~mask;
> +	tmp |=3D val;
> +	fsl_guts_write(&soc.dcfg_dcsr->rcwcr[offset], tmp);
> +}
> +
>  static bool fsl_soc_die_match_one(u32 svr, const struct fsl_soc_die_attr=
 *match)
>  {
>  	return match->svr =3D=3D (svr & match->mask);
> @@ -167,6 +227,97 @@ static const struct fsl_soc_die_attr *fsl_soc_die_ma=
tch(
>  	return NULL;
>  }
> =20
> +static int
> +fsl_guts_serdes_get_rcw_override(int serdes_idx, int lane,
> +				 enum lynx_lane_mode lane_mode,
> +				 struct fsl_soc_serdes_rcw_override *override)
> +{
> +	if ((!fsl_soc_die_match_one(soc.svr, &fsl_soc_die[DIE_LS1088A]) &&
> +	     !fsl_soc_die_match_one(soc.svr, &fsl_soc_die[DIE_LS2088A]) &&
> +	     !fsl_soc_die_match_one(soc.svr, &fsl_soc_die[DIE_LS1046A])) ||
> +	    !soc.data || !soc.data->serdes_get_rcw_override) {
> +		pr_debug("RCW override not implemented for SoC\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!soc.dcfg_dcsr) {
> +		pr_debug("Device tree does not define DCFG_DCSR region necessary for R=
CW override\n");
> +		return -EINVAL;
> +	}
> +
> +	return soc.data->serdes_get_rcw_override(serdes_idx, lane, lane_mode,
> +						 override);
> +}
> +
> +/**
> + * fsl_guts_lane_init() - Notify guts module of SerDes lane configuration
> + * @serdes_idx: zero-based SerDes block index
> + * @lane: zero-based lane index within SerDes
> + * @lane_mode: initial / boot time SerDes protocol for lane
> + *
> + * On the LS208xA SoC, the RCW override procedure needs to be aware of a=
ll link
> + * modes which are configured on a SerDes block.
> + */
> +void fsl_guts_lane_init(int serdes_idx, int lane, enum lynx_lane_mode la=
ne_mode)
> +{
> +	soc.lane_mode[serdes_idx - 1][lane] =3D lane_mode;
> +}
> +EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_init, "FSL_GUTS");
> +
> +/**
> + * fsl_guts_lane_validate() - Validate that SerDes protocol is implement=
ed and
> + *	supported on current SoC
> + * @serdes_idx: zero-based SerDes block index
> + * @lane: zero-based lane index within SerDes
> + * @lane_mode: requested SerDes protocol
> + *
> + * Should be called before actually requesting the RCW override procedur=
e to be
> + * applied using %fsl_guts_lane_set_mode()
> + *
> + * Return: 0 if RCW override to protocol is possible, negative error oth=
erwise
> + */
> +int fsl_guts_lane_validate(int serdes_idx, int lane, enum lynx_lane_mode=
 lane_mode)
> +{
> +	struct fsl_soc_serdes_rcw_override override;
> +
> +	return fsl_guts_serdes_get_rcw_override(serdes_idx, lane, lane_mode,
> +						&override);
> +}
> +EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_validate, "FSL_GUTS");
> +
> +/**
> + * fsl_guts_lane_set_mode() - apply RCW override procedure for SerDes la=
ne
> + * @serdes_idx: zero-based SerDes block index
> + * @lane: zero-based lane index within SerDes
> + * @lane_mode: requested SerDes protocol
> + *
> + * Return: 0 on success, negative error otherwise
> + */
> +int fsl_guts_lane_set_mode(int serdes_idx, int lane, enum lynx_lane_mode=
 lane_mode)
> +{
> +	struct fsl_soc_serdes_rcw_override override;
> +	int err;
> +
> +	err =3D fsl_guts_serdes_get_rcw_override(serdes_idx, lane, lane_mode,
> +					       &override);
> +	if (err)
> +		return err;
> +
> +	spin_lock(&soc.rcwcr_lock);
> +
> +	if (soc.data->serdes_init_rcwcr)
> +		soc.data->serdes_init_rcwcr(serdes_idx);
> +
> +	fsl_guts_rmw(override.offset, override.val << __bf_shf(override.mask),
> +		     override.mask);
> +	soc.lane_mode[serdes_idx - 1][lane] =3D lane_mode;
> +
> +	spin_unlock(&soc.rcwcr_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_set_mode, "FSL_GUTS");
> +
>  static u64 fsl_guts_get_soc_uid(const char *compat, unsigned int offset)
>  {
>  	struct device_node *np;
> @@ -193,6 +344,128 @@ static u64 fsl_guts_get_soc_uid(const char *compat,=
 unsigned int offset)
>  	return uid;
>  }
> =20
> +static int ls1088a_serdes_get_rcw_override(int index, int lane,
> +					   enum lynx_lane_mode lane_mode,
> +					   struct fsl_soc_serdes_rcw_override *override)
> +{
> +	/* The RCW override procedure has to write to different registers
> +	 * depending on the SerDes block index.
> +	 */
> +	switch (index) {
> +	case 1:
> +		override->offset =3D 28;
> +		override->mask =3D LS1088A_RCWSR29_SRDS_PRTCL_S1_LNn(lane);
> +		break;
> +	case 2:
> +		override->offset =3D 29;
> +		override->mask =3D LS1088A_RCWSR30_SRDS_PRTCL_S2_LNn(lane);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (lynx_lane_mode_uses_xgmii_mac(lane_mode))
> +		override->val =3D SRDS_PRTCL_XFI;
> +	else if (lynx_lane_mode_uses_gmii_mac(lane_mode))
> +		override->val =3D SRDS_PRTCL_100BASEX_SGMII;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ls1046a_serdes_get_rcw_override(int index, int lane,
> +					   enum lynx_lane_mode lane_mode,
> +					   struct fsl_soc_serdes_rcw_override *override)
> +{
> +	/* The RCW override procedure has to write to different registers
> +	 * depending on the SerDes block index.
> +	 */
> +	switch (index) {
> +	case 1:
> +		override->offset =3D 4;
> +		override->mask =3D LS1046A_RCWSR5_SRDS_PRTCL_S1(lane);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (lynx_lane_mode_uses_xgmii_mac(lane_mode))
> +		override->val =3D SRDS_PRTCL_XFI;
> +	else if (lynx_lane_mode_uses_gmii_mac(lane_mode))
> +		override->val =3D SRDS_PRTCL_100BASEX_SGMII;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ls2088a_serdes_get_rcw_override(int index, int lane,
> +					   enum lynx_lane_mode lane_mode,
> +					   struct fsl_soc_serdes_rcw_override *override)
> +{
> +	switch (index) {
> +	case 1:
> +		override->offset =3D 29;
> +		override->mask =3D LS2088A_RCWSR30_SRDS_CLK_SEL_XGMII_Ln_S1(lane);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (lynx_lane_mode_uses_xgmii_mac(lane_mode))
> +		override->val =3D SRDS_CLK_SEL_XGMII;
> +	else if (lynx_lane_mode_uses_gmii_mac(lane_mode))
> +		override->val =3D SRDS_CLK_SEL_GMII;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void ls2088a_serdes_init_rcwcr(int serdes_idx)
> +{
> +	u32 reg;
> +	int i;
> +
> +	if (serdes_idx !=3D 1)
> +		return;
> +	if (soc.rcwcr_init_done)
> +		return;
> +
> +	/* SRDS_CLK_EN_SEL_XGMII_S1: SerDes Clock Enable Select XGMII Serdes 1:
> +	 * Enables to select GMII/XGMII clock according to
> +	 * SRDS_CLK_SEL_XGMII_Ln_S1
> +	 */
> +	reg =3D LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1;
> +
> +	/* We need to configure the initial state of all lanes for
> +	 * the SerDes block #1
> +	 */
> +	for (i =3D 0; i < MAX_NUM_LANES; i++)
> +		if (lynx_lane_mode_uses_xgmii_mac(soc.lane_mode[serdes_idx - 1][i]))
> +			reg |=3D LS2088A_RCWSR30_SRDS_CLK_SEL_XGMII_Ln_S1(i);
> +
> +	fsl_guts_rmw(29, reg,
> +		     LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1 |
> +		     LS2088A_RCWSR30_SRDS_CLK_SEL_MSK);
> +
> +	soc.rcwcr_init_done =3D true;
> +}
> +
> +static const struct fsl_soc_data ls1088a_data =3D {
> +	.serdes_get_rcw_override =3D ls1088a_serdes_get_rcw_override,
> +};
> +
> +static const struct fsl_soc_data ls1046a_data =3D {
> +	.serdes_get_rcw_override =3D ls1046a_serdes_get_rcw_override,
> +};
> +
> +static const struct fsl_soc_data ls2088a_data =3D {
> +	.serdes_get_rcw_override =3D ls2088a_serdes_get_rcw_override,
> +	.serdes_init_rcwcr =3D ls2088a_serdes_init_rcwcr,
> +};
> +
>  static const struct fsl_soc_data ls1028a_data =3D {
>  	.sfp_compat =3D "fsl,ls1028a-sfp",
>  	.uid_offset =3D 0x21c,
> @@ -221,10 +494,10 @@ static const struct of_device_id fsl_guts_of_match[=
] =3D {
>  	{ .compatible =3D "fsl,mpc8572-guts", },
>  	{ .compatible =3D "fsl,ls1021a-dcfg", },
>  	{ .compatible =3D "fsl,ls1043a-dcfg", },
> -	{ .compatible =3D "fsl,ls2080a-dcfg", },
> -	{ .compatible =3D "fsl,ls1088a-dcfg", },
> +	{ .compatible =3D "fsl,ls2080a-dcfg", .data =3D &ls2088a_data},
> +	{ .compatible =3D "fsl,ls1088a-dcfg", .data =3D &ls1088a_data},
>  	{ .compatible =3D "fsl,ls1012a-dcfg", },
> -	{ .compatible =3D "fsl,ls1046a-dcfg", },
> +	{ .compatible =3D "fsl,ls1046a-dcfg", .data =3D &ls1046a_data},
>  	{ .compatible =3D "fsl,lx2160a-dcfg", },
>  	{ .compatible =3D "fsl,ls1028a-dcfg", .data =3D &ls1028a_data},
>  	{}
> @@ -250,6 +523,8 @@ static int __init fsl_guts_init(void)
>  		of_node_put(np);
>  		return -ENOMEM;
>  	}
> +	/* DCFG_DCSR is optional */
> +	soc.dcfg_dcsr =3D of_iomap(np, DCFG_DCSR);
> =20
>  	soc.little_endian =3D of_property_read_bool(np, "little-endian");
>  	soc.svr =3D fsl_guts_read(&soc.dcfg_ccsr->svr);
> @@ -296,6 +571,8 @@ static int __init fsl_guts_init(void)
>  		goto err;
>  	}
> =20
> +	spin_lock_init(&soc.rcwcr_lock);
> +
>  	pr_info("Machine: %s\n", soc_dev_attr->machine);
>  	pr_info("SoC family: %s\n", soc_dev_attr->family);
>  	pr_info("SoC ID: %s, Revision: %s\n",
> @@ -305,7 +582,8 @@ static int __init fsl_guts_init(void)
> =20
>  err_nomem:
>  	ret =3D -ENOMEM;
> -
> +	if (soc.dcfg_dcsr)
> +		iounmap(soc.dcfg_dcsr);
>  	iounmap(soc.dcfg_ccsr);
>  err:
>  	kfree(soc_dev_attr->family);
> diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
> index fdb55ca47a4f..176842531241 100644
> --- a/include/linux/fsl/guts.h
> +++ b/include/linux/fsl/guts.h
> @@ -13,6 +13,7 @@
> =20
>  #include <linux/types.h>
>  #include <linux/io.h>
> +#include <soc/fsl/phy-fsl-lynx.h>
> =20
>  /*
>   * Global Utility Registers.
> @@ -91,9 +92,15 @@ struct ccsr_guts {
>  	u32	iovselsr;	/* 0x.00c0 - I/O voltage select status register
>  					     Called 'elbcvselcr' on 86xx SOCs */
>  	u8	res0c4[0x100 - 0xc4];
> -	u32	rcwsr[16];	/* 0x.0100 - Reset Control Word Status registers
> -					     There are 16 registers */
> -	u8	res140[0x224 - 0x140];
> +	/* 0x.0100 - read-only Reset Configuration Word Status registers in
> +	 * CCSR, or write-only Reset Configuration Word Control registers in
> +	 * DCSR. In both cases there are 32 registers.
> +	 */
> +	union {
> +		u32	rcwsr[32];
> +		u32	rcwcr[32];
> +	};
> +	u8	res180[0x224 - 0x180];
>  	u32	iodelay1;	/* 0x.0224 - IO delay control register 1 */
>  	u32	iodelay2;	/* 0x.0228 - IO delay control register 2 */
>  	u8	res22c[0x604 - 0x22c];
> @@ -131,6 +138,13 @@ struct ccsr_guts {
>  	u32	srds2cr1;	/* 0x.0f44 - SerDes2 Control Register 0 */
>  } __attribute__ ((packed));
> =20
> +void fsl_guts_lane_init(int serdes_idx, int lane,
> +			enum lynx_lane_mode lane_mode);
> +int fsl_guts_lane_validate(int serdes_idx, int lane,
> +			   enum lynx_lane_mode lane_mode);
> +int fsl_guts_lane_set_mode(int serdes_idx, int lane,
> +			   enum lynx_lane_mode lane_mode);
> +
>  /* Alternate function signal multiplex control */
>  #define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
> =20
> --=20
> 2.34.1
>=20

--+oYs0Ry07OA4ycIc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiwpXgAKCRB4tDGHoIJi
0ntBAP9M3qAsl/D+DcH4DwKQGnY7o3dHsy84BKRl/REMqNbhHgEAyh1KBXxdecCi
UP7ZwuAIECLNF8kS0ZtRizU1Xd8TpgY=
=5z05
-----END PGP SIGNATURE-----

--+oYs0Ry07OA4ycIc--

