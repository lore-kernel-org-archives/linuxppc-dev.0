Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71794C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 10:18:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9092082C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 10:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h17PGEwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9092082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YQCQ0Lc8zDqGn
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 21:18:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.13.85; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="h17PGEwQ"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130085.outbound.protection.outlook.com [40.107.13.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YQ9b33ppzDq69
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 21:16:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0qIr+D+Lso3QoYvzTMU63dvhspd1KfkVxts9SMq8I4=;
 b=h17PGEwQel6488VW9oGvFdRnqi8dPuvDuUNyJ1Edk/5g8rtjKHzUGUaEBz0JA53MOLF+obC9xP1okPsiw4CdQRQ7ntQfBrtgL3qTwTuL/GNEsgxX8r8zppTtAZIBIXF4Hr0DqFvv7yVZtrNWoIuhINKhoQDH5l/2uKpMMnr1fVM=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6384.eurprd04.prod.outlook.com (20.179.232.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Tue, 2 Apr 2019 10:16:41 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::59c9:fbfe:c41a:59ef]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::59c9:fbfe:c41a:59ef%4]) with mapi id 15.20.1750.017; Tue, 2 Apr 2019
 10:16:41 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: RE: [PATCH] ASoC: fsl_esai: Support synchronous mode
Thread-Topic: [PATCH] ASoC: fsl_esai: Support synchronous mode
Thread-Index: AQHU6H+FV+jTCNs14EK84w0THEahmaYnnWcAgAD/3/A=
Date: Tue, 2 Apr 2019 10:16:41 +0000
Message-ID: <VE1PR04MB64799B3261D1F9F63E441769E3560@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <1554118759-2403-1-git-send-email-shengjiu.wang@nxp.com>
 <20190401181742.GA21288@Asurada-Nvidia>
In-Reply-To: <20190401181742.GA21288@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 873948ca-9d68-4925-d948-08d6b7544d0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VE1PR04MB6384; 
x-ms-traffictypediagnostic: VE1PR04MB6384:
x-microsoft-antispam-prvs: <VE1PR04MB6384929BFA1A81E3C80653B8E3560@VE1PR04MB6384.eurprd04.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(366004)(136003)(346002)(396003)(199004)(189003)(26005)(33656002)(229853002)(6436002)(14444005)(53936002)(52536014)(6246003)(9686003)(102836004)(1411001)(55016002)(6916009)(106356001)(3846002)(6506007)(5660300002)(4326008)(86362001)(7696005)(97736004)(25786009)(186003)(68736007)(105586002)(2906002)(8936002)(11346002)(54906003)(76176011)(8676002)(476003)(81156014)(6116002)(14454004)(99286004)(7736002)(486006)(256004)(81166006)(446003)(305945005)(71190400001)(316002)(74316002)(71200400001)(478600001)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6384;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nZlQ1W2jBQa32iheJZSNjC+ZLn2hgfVE+g2v8RF76X6qUvkYn6Hyeg6YEgpR4fG+gn4r1E7kgGvSz5RHSwSxufkKJpTwcyG9eQsvciOVP7R5cQYMYBNO5Q2CcMLxBUImpZ087Fmc7GiZtDjyfRdWG9PK7KnjA1FxtyMyjXbGHY18vTnxlI0ypUR/WrwjwL1OUBGyAZLweMdxPUVgqtZ/1nRY0Ro87hFOpTTol+x7ybS9LR9t9O93F+QMmWB1LehBcgPjqvlRrBLEEJbv23cFWvz1vSJScQ8OMoHgUBZkSD18Po/VjMCFosfmFJTS74OIEIHQwHuqqEhL162bEHWm2q0xFJSC09WIKFzeNYUBGl5xsL/8bI/USsleGBQCh/WaTbHMtA/tHFJ338SHJ3nj/hQvnkb2GEKls2C3eyzXXpw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873948ca-9d68-4925-d948-08d6b7544d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 10:16:41.6572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6384
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
> Shengjiu,
>=20
> On Mon, Apr 01, 2019 at 11:39:10AM +0000, S.j. Wang wrote:
> > In ESAI synchronous mode, the clock is generated by Tx, So we should
> > always set registers of Tx which relate with the bit clock and frame
> > clock generation (TCCR, TCR, ECR), even there is only Rx is working.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_esai.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c index
> > 3623aa9a6f2e..d9fcddd55c02 100644
> > --- a/sound/soc/fsl/fsl_esai.c
> > +++ b/sound/soc/fsl/fsl_esai.c
> > @@ -230,6 +230,21 @@ static int fsl_esai_set_dai_sysclk(struct
> snd_soc_dai *dai, int clk_id,
> >  		return -EINVAL;
> >  	}
> >
> > +	if (esai_priv->synchronous && !tx) {
> > +		switch (clk_id) {
> > +		case ESAI_HCKR_FSYS:
> > +			fsl_esai_set_dai_sysclk(dai, ESAI_HCKT_FSYS,
> > +								freq, dir);
> > +			break;
> > +		case ESAI_HCKR_EXTAL:
> > +			fsl_esai_set_dai_sysclk(dai, ESAI_HCKT_EXTAL,
> > +								freq, dir);
>=20
> Not sure why you call set_dai_sysclk inside set_dai_sysclk again. It feel=
s very
> confusing to do so, especially without a comments.

For sync mode, only RX is enabled,  the register of tx should be set, so ca=
ll the
Set_dai_sysclk again.

>=20
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> >  	/* Bypass divider settings if the requirement doesn't change */
> >  	if (freq =3D=3D esai_priv->hck_rate[tx] && dir =3D=3D esai_priv->hck_=
dir[tx])
> >  		return 0;
> > @@ -537,10 +552,21 @@ static int fsl_esai_hw_params(struct
> > snd_pcm_substream *substream,
> >
> >  	bclk =3D params_rate(params) * slot_width * esai_priv->slots;
> >
> > -	ret =3D fsl_esai_set_bclk(dai, tx, bclk);
> > +	ret =3D fsl_esai_set_bclk(dai, esai_priv->synchronous ? true : tx,
> > +bclk);
> >  	if (ret)
> >  		return ret;
> >
> > +	if (esai_priv->synchronous && !tx) {
> > +		/* Use Normal mode to support monaural audio */
> > +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> > +			   ESAI_xCR_xMOD_MASK,
> params_channels(params) > 1 ?
> > +			   ESAI_xCR_xMOD_NETWORK : 0);
> > +
> > +		mask =3D ESAI_xCR_xSWS_MASK | ESAI_xCR_PADC;
> > +		val =3D ESAI_xCR_xSWS(slot_width, width) | ESAI_xCR_PADC;
> > +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> mask, val);
> > +	}
>=20
> Does synchronous mode require to set both TCR and RCR? or just TCR?
> The code behind this part is doing the same setting to RCR. If that is no=
t
> needed any more for a synchronous recording, we should reuse it instead
> of inserting a piece of redundant code. Otherwise, if we need to set both=
,
> we should have two regmap_update_bits operations back-to-back for TCR
> and RCR (and other registers too).

Both TCR and RCR.  RCR will be set in normal flow.
>=20
> > +
> >  	/* Use Normal mode to support monaural audio */
> >  	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
> >  			   ESAI_xCR_xMOD_MASK,
> params_channels(params) > 1 ?
>=20
> In case that we only need to set TCR (more likely I feel), it would feel =
less
> confusing to me, if we changed REG_ESAI_xCR(tx) here, for example, to
> REG_ESAI_xCR(tx || sync). Yea, please add to the top a 'bool sync =3D
> esai_priv->synchronous;'.
>=20
> Similarly, for ECR_ETO and ECR_ERO:
> 	(tx || sync) ? ESAI_ECR_ETO : ESAI_ECR_ERO;

Both TCR and RCR should be set.
=20
