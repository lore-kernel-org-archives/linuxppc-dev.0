Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4989C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 10:04:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69A620830
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 10:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YTiu7FCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69A620830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z1s72ygczDqQQ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 21:04:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.2.74; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="YTiu7FCM"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20074.outbound.protection.outlook.com [40.107.2.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Z1qP3S2gzDqQ9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 21:03:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRLBfBPv20dCgAuVWZtKfVCaVqXtMNaJM1UrFTBYeJ4=;
 b=YTiu7FCMzi7QcZDf+njM+x4CLhKac6TAfc9zzkjlDej1Qxxc2MS3jl2r/BkMxMExrY96fiRbQJpgAKIXQgS15HH3ngcF4lK+BHsCHtjk8zq5Ktdn+GrxZsolCCwTO2jGBVP5XA6a7+HNzp3doAgzMbgxmyGPggnRfwbYk87WyQI=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6605.eurprd04.prod.outlook.com (20.179.234.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Wed, 3 Apr 2019 10:03:03 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::59c9:fbfe:c41a:59ef]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::59c9:fbfe:c41a:59ef%4]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 10:03:03 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: RE: [PATCH] ASoC: fsl_esai: Support synchronous mode
Thread-Topic: [PATCH] ASoC: fsl_esai: Support synchronous mode
Thread-Index: AQHU6H+FV+jTCNs14EK84w0THEahmaYnnWcAgAD/3/CAAK9jAIAA6oYg
Date: Wed, 3 Apr 2019 10:03:03 +0000
Message-ID: <VE1PR04MB6479CE4FB14030288A2B679DE3570@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <1554118759-2403-1-git-send-email-shengjiu.wang@nxp.com>
 <20190401181742.GA21288@Asurada-Nvidia>
 <VE1PR04MB64799B3261D1F9F63E441769E3560@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20190402200115.GA22168@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190402200115.GA22168@Asurada-Nvidia.nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76aaf464-0d65-4922-1539-08d6b81b8fe0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VE1PR04MB6605; 
x-ms-traffictypediagnostic: VE1PR04MB6605:
x-microsoft-antispam-prvs: <VE1PR04MB6605CB108EB9D2E3ED7959FAE3570@VE1PR04MB6605.eurprd04.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(97736004)(68736007)(8936002)(86362001)(25786009)(229853002)(14444005)(256004)(6436002)(305945005)(71200400001)(71190400001)(74316002)(14454004)(52536014)(8676002)(81156014)(478600001)(6916009)(81166006)(5660300002)(7736002)(486006)(105586002)(6116002)(106356001)(3846002)(7696005)(186003)(4326008)(6506007)(33656002)(2906002)(26005)(102836004)(11346002)(476003)(446003)(1411001)(99286004)(76176011)(316002)(54906003)(93886005)(66066001)(55016002)(6246003)(9686003)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6605;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RcZJ7UIfzMs1QlegcvATnsOSwh5cm7MpCZKgvurjaQC6ZOAM/5B6ASYePj2tusiUnLQLb8M9icZcASzkJKXr0pwC0VAmWMYxjEx2PIwx19i+zlxvPA2DnZSYAqi50NHqAxd2sgxK1NHTw2xIrEFvyTtKX/YLSXsXJr6YPol+41E/SEbl1QKd182IFzu3UkC2kfKtrFKGzdY8sx7SrI787T8X9ZzPDmvqaiPEEXrUKsa2qWYsnGCkPvAsrgPVEZCrb9z4ls2R1udyo6vo/nfhbqsnF2r48beWNkT+wuGIHqKknAZdLrjrMbXDsSlMU0h1KM5B4jeKPsTzgeWDfDJ0ohq6lKTC/l5SLfG6y4jrZ6Al73u/4Or/AS0CI0I2Zw8gC5zZBqyGpq4jcFfcmJUqEzy2c4IoWtGvEHhcsSqHis4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76aaf464-0d65-4922-1539-08d6b81b8fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 10:03:03.5357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6605
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi

>=20
> > > On Mon, Apr 01, 2019 at 11:39:10AM +0000, S.j. Wang wrote:
> > > > In ESAI synchronous mode, the clock is generated by Tx, So we
> > > > should always set registers of Tx which relate with the bit clock
> > > > and frame clock generation (TCCR, TCR, ECR), even there is only Rx =
is
> working.
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > ---
> > > >  sound/soc/fsl/fsl_esai.c | 28 +++++++++++++++++++++++++++-
> > > >  1 file changed, 27 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> > > > index
> > > > 3623aa9a6f2e..d9fcddd55c02 100644
> > > > --- a/sound/soc/fsl/fsl_esai.c
> > > > +++ b/sound/soc/fsl/fsl_esai.c
> > > > @@ -230,6 +230,21 @@ static int fsl_esai_set_dai_sysclk(struct
> > > snd_soc_dai *dai, int clk_id,
> > > >  		return -EINVAL;
> > > >  	}
> > > >
> > > > +	if (esai_priv->synchronous && !tx) {
> > > > +		switch (clk_id) {
> > > > +		case ESAI_HCKR_FSYS:
> > > > +			fsl_esai_set_dai_sysclk(dai, ESAI_HCKT_FSYS,
> > > > +								freq, dir);
> > > > +			break;
> > > > +		case ESAI_HCKR_EXTAL:
> > > > +			fsl_esai_set_dai_sysclk(dai, ESAI_HCKT_EXTAL,
> > > > +								freq, dir);
> > >
> > > Not sure why you call set_dai_sysclk inside set_dai_sysclk again. It
> > > feels very confusing to do so, especially without a comments.
> >
> > For sync mode, only RX is enabled,  the register of tx should be set,
> > so call the Set_dai_sysclk again.
>=20
> Yea, I understood that. But why not just replace RX with TX on the regist=
er-
> writing level? Do we need to set both TCCR and RCCR? Your change in
> hw_params() only sets TCCR inside fsl_esai_set_bclk(), so we probably onl=
y
> need to change TCCR for recordings running in sync mode, right?
>=20
> From the commit message, it feels like that only the clock-related fields=
 in
> the TX registers need to be set. Things like calculation and setting the
> direction of HCKx pin don't need to run again.
>=20
> > > > @@ -537,10 +552,21 @@ static int fsl_esai_hw_params(struct
> > > > snd_pcm_substream *substream,
> > > >
> > > >  	bclk =3D params_rate(params) * slot_width * esai_priv->slots;
> > > >
> > > > -	ret =3D fsl_esai_set_bclk(dai, tx, bclk);
> > > > +	ret =3D fsl_esai_set_bclk(dai, esai_priv->synchronous ? true : tx=
,
> > > > +bclk);
> > > >  	if (ret)
> > > >  		return ret;
> > > >
> > > > +	if (esai_priv->synchronous && !tx) {
> > > > +		/* Use Normal mode to support monaural audio */
> > > > +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> > > > +			   ESAI_xCR_xMOD_MASK,
> > > params_channels(params) > 1 ?
> > > > +			   ESAI_xCR_xMOD_NETWORK : 0);
> > > > +
> > > > +		mask =3D ESAI_xCR_xSWS_MASK | ESAI_xCR_PADC;
> > > > +		val =3D ESAI_xCR_xSWS(slot_width, width) | ESAI_xCR_PADC;
> > > > +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> > > mask, val);
> > > > +	}
> > >
> > > Does synchronous mode require to set both TCR and RCR? or just TCR?
>=20
> > Both TCR and RCR.  RCR will be set in normal flow.
>=20
> OK. Settings both xCRs makes sense. Would you please try this:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -537,14 +552,20 @@ static int fsl_esai_hw_params(struct
> snd_pcm_substream *substream,
>=20
>         bclk =3D params_rate(params) * slot_width * esai_priv->slots;
>=20
> -       ret =3D fsl_esai_set_bclk(dai, tx, bclk);
> +       /* Synchronous mode uses TX clock generator */
> +       ret =3D fsl_esai_set_bclk(dai, esai_priv->synchronous || tx,
> + bclk);
>         if (ret)
>                 return ret;
>=20
> +       mask =3D ESAI_xCR_xMOD_MASK | ESAI_xCR_xSWS_MASK;
> +       val =3D ESAI_xCR_xSWS(slot_width, width);
>         /* Use Normal mode to support monaural audio */
> -       regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
> -                          ESAI_xCR_xMOD_MASK, params_channels(params) > =
1 ?
> -                          ESAI_xCR_xMOD_NETWORK : 0);
> +       val |=3D params_channels(params) > 1 ? ESAI_xCR_xMOD_NETWORK : 0;
> +
> +       regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask, val=
);
> +       /* Recording in synchronous mode needs to set TCR also */
> +       if (!tx && esai_priv->synchronous)
> +               regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> + mask, val);
>=20
>         regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx),
>                            ESAI_xFCR_xFR_MASK, ESAI_xFCR_xFR); @@ -556,10
> +577,10 @@ static int fsl_esai_hw_params(struct snd_pcm_substream
> *substream,
>=20
>         regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx), mask, va=
l);
>=20
> -       mask =3D ESAI_xCR_xSWS_MASK | (tx ? ESAI_xCR_PADC : 0);
> -       val =3D ESAI_xCR_xSWS(slot_width, width) | (tx ? ESAI_xCR_PADC : =
0);
> -
> -       regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask, val=
);
> +       /* Only TCR has padding bit and needs to be set for synchronous
> mode */
> +       if (tx || esai_priv->synchronous)
> +               regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +                                  ESAI_xCR_PADC, ESAI_xCR_PADC);
>=20
>         /* Remove ESAI personal reset by configuring ESAI_PCRC and
> ESAI_PRRC */
>         regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> It merges those plain settings so we won't need to change both sides if
> there's a modification of xCR settings in the future.

Thanks for reviewing,  will send v2.  And the ESAI_xCR_PADC, ESAI_xCR_xMOD_=
NETWORK
Is not needed in sync mode.

