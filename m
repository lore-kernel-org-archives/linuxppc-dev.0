Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29357C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 06:31:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6639A20855
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 06:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j6Xbo4xa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6639A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZY4x0578zDqBl
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 17:31:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.14.81; helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="j6Xbo4xa"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140081.outbound.protection.outlook.com [40.107.14.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZY2j4MY1zDqFY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 17:29:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcNWx5rMJyRt8bTpwRm5hAbyLF3SdUtezYc8DXHTSOI=;
 b=j6Xbo4xaKQW8IQK+GpDfPMfgm9b1VgnANqhbiSxXNKwOquJ/tJLMUeQDOdBg6KWhv0B+2E1/PHDsCCOiXLlGhBICy4e93nM9+IGhdTBWTIW6oXwwUVAWoQ1Kyq6299hGn1ktc+0nn982LNtFoUwqbuWoLo+/9XdgLEpXPx1bHec=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6654.eurprd04.prod.outlook.com (20.179.235.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Thu, 4 Apr 2019 06:29:39 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::59c9:fbfe:c41a:59ef]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::59c9:fbfe:c41a:59ef%4]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 06:29:39 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: RE: [PATCH V2] ASoC: fsl_esai: Support synchronous mode
Thread-Topic: [PATCH V2] ASoC: fsl_esai: Support synchronous mode
Thread-Index: AQHU6gUSBPA5LkR8lUK0D8ynBBQe8KYqyhIAgAC8sFA=
Date: Thu, 4 Apr 2019 06:29:39 +0000
Message-ID: <VE1PR04MB6479E9E8A536F7EEFE78A3A1E3500@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <dac7c52215b4bb09f3548bcb9246f8fe21799e38.1554285839.git.shengjiu.wang@nxp.com>
 <20190403185716.GA5130@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190403185716.GA5130@Asurada-Nvidia.nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6855c42b-f912-4655-1960-08d6b8c6ea46
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6654; 
x-ms-traffictypediagnostic: VE1PR04MB6654:
x-microsoft-antispam-prvs: <VE1PR04MB6654BF463032C293336DF4A1E3500@VE1PR04MB6654.eurprd04.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(39860400002)(376002)(136003)(396003)(199004)(189003)(14454004)(66066001)(478600001)(5660300002)(446003)(476003)(11346002)(106356001)(52536014)(99286004)(53936002)(486006)(7696005)(97736004)(55016002)(186003)(105586002)(6916009)(9686003)(8936002)(6246003)(6116002)(74316002)(81156014)(81166006)(8676002)(76176011)(25786009)(2906002)(102836004)(316002)(6436002)(3846002)(1411001)(26005)(7736002)(305945005)(6506007)(71190400001)(14444005)(256004)(71200400001)(86362001)(33656002)(4326008)(68736007)(229853002)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6654;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mpy8xkHc2T1ivRYEWwDUuKys38ivDBVV4h2+u5BgtZgjfBx9VTvS1oLHJNsRYWq3a9NaIZ/LUAT4uiIOVVbw+XYY0M2Fl8UOIs7qW5rvVvpOC+0GCjFV+Clg6p5RdsvcttWOku3seIY5/redyBR44ah4NQSwn8tH+CLisHo6Hv88S9NcuYuK0/thHrxYtH2h3ebnV/9fQVgNF6sJGPbEs4D6KsR5ljNWtOMlggbX8CVQaYmtXil9U4YBHbVabSrnCWV8YyFIo4Odt3Hg2uluGnaGrTF5DwEck3sFsUklegicIjyAitKom0QWhMhmIRkgHHeRx49ve9vzK4hPex20LNYnPSXub/NfZQ2v2O9z94/fKYLsLNhLMdHXD6xindJr4IJXWQlYpjFJZfGiRVeXYVwKx6ap04xF19QXP7dEXFw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6855c42b-f912-4655-1960-08d6b8c6ea46
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 06:29:39.1830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6654
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
> This looks better :)
>=20
> On Wed, Apr 03, 2019 at 10:07:40AM +0000, S.j. Wang wrote:
> > @@ -218,7 +218,7 @@ static int fsl_esai_set_dai_sysclk(struct
> > snd_soc_dai *dai, int clk_id,  {
> >  	struct fsl_esai *esai_priv =3D snd_soc_dai_get_drvdata(dai);
> >  	struct clk *clksrc =3D esai_priv->extalclk;
> > -	bool tx =3D clk_id <=3D ESAI_HCKT_EXTAL;
> > +	bool tx =3D (clk_id <=3D ESAI_HCKT_EXTAL || esai_priv->synchronous);
> >  	bool in =3D dir =3D=3D SND_SOC_CLOCK_IN;
> >  	u32 ratio, ecr =3D 0;
> >  	unsigned long clk_rate;
> > @@ -253,7 +253,7 @@ static int fsl_esai_set_dai_sysclk(struct
> snd_soc_dai *dai, int clk_id,
> >  		ecr |=3D ESAI_ECR_ETI;
> >  		/* fall through */
>=20
> Btw, I am also wondering if the fall through here is a bug....
> Because I don't recall that there is a specific reason to fall through he=
re.
> Can you please help confirm? Perhaps we need to submit a separate fix as
> well by replacing it with a "break;".
Yes, I think there is issue here, will submit another patch for it.
>=20
> >  	case ESAI_HCKR_EXTAL:
> > -		ecr |=3D ESAI_ECR_ERI;
> > +		ecr |=3D esai_priv->synchronous ? ESAI_ECR_ETI :
> ESAI_ECR_ERI;
> >  		break;
> >  	default:
> >  		return -EINVAL;
>=20
> > @@ -537,10 +537,18 @@ static int fsl_esai_hw_params(struct
> > snd_pcm_substream *substream,
> >
> >  	bclk =3D params_rate(params) * slot_width * esai_priv->slots;
> >
> > -	ret =3D fsl_esai_set_bclk(dai, tx, bclk);
> > +	ret =3D fsl_esai_set_bclk(dai, esai_priv->synchronous || tx, bclk);
> >  	if (ret)
> >  		return ret;
> >
> > +	mask =3D ESAI_xCR_xSWS_MASK;
> > +	val =3D ESAI_xCR_xSWS(slot_width, width);
> > +
> > +	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask,
> val);
> > +	/* Recording in synchronous mode needs to set TCR also */
> > +	if (!tx && esai_priv->synchronous)
> > +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> mask, val);
> > +
> >  	/* Use Normal mode to support monaural audio */
> >  	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
> >  			   ESAI_xCR_xMOD_MASK,
> params_channels(params) > 1 ?
> > @@ -556,10 +564,9 @@ static int fsl_esai_hw_params(struct
> > snd_pcm_substream *substream,
> >
> >  	regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx), mask,
> val);
> >
> > -	mask =3D ESAI_xCR_xSWS_MASK | (tx ? ESAI_xCR_PADC : 0);
> > -	val =3D ESAI_xCR_xSWS(slot_width, width) | (tx ? ESAI_xCR_PADC : 0);
> > -
> > -	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask,
> val);
> > +	if (tx)
> > +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> > +					ESAI_xCR_PADC, ESAI_xCR_PADC);
>=20
> Mind aligning the indentation here like the one below?
> 		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> 				   ESAI_xCR_PADC, ESAI_xCR_PADC);

Ok. Will send v3.
>=20
> Once you fix the indentation, add this:
>=20
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
>=20
> Thanks
