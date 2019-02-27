Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43A4C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 06:32:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A47218D0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 06:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AqEcO/KD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A47218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448QpW2xMzzDqNn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 17:32:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.6.76; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="AqEcO/KD"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60076.outbound.protection.outlook.com [40.107.6.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448QmC2QNBzDq5Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 17:30:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0m1GYISN0DwhTdbZq2ELx3cth4vwZGiWo+l05kcQktU=;
 b=AqEcO/KDShbqkLOj9Ba1kkGqkRZGmr7/Jol4EyB/OA6wMAkgupTaYF8w74VknI+2BOTjkG8dSSGQcnQZPXx6zMlmyTJ1Yu8zlmvi3WIrF+TVzHISkqO92aYTMgcWwTL+5BiJ7oHdLd4oR+Bb2zLOFY0X2v8+nrbI2u3M4OjECxA=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB3326.eurprd04.prod.outlook.com (52.134.8.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Wed, 27 Feb 2019 06:30:24 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 06:30:24 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: RE: [PATCH V3] ASoC: fsl_esai: fix channel swap issue when stream
 starts
Thread-Topic: [PATCH V3] ASoC: fsl_esai: fix channel swap issue when stream
 starts
Thread-Index: AQHUzYEZNqiYMhmT3kyzaOJ9QeioVKXycwAAgAC9qhA=
Date: Wed, 27 Feb 2019 06:30:24 +0000
Message-ID: <VI1PR0402MB33926551CFE8DA8621C367F2E3740@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <6a5f6ddf5c1683106b0cadd5691cd2d9cfe2c997.1551150582.git.shengjiu.wang@nxp.com>
 <20190226191057.GA24082@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190226191057.GA24082@Asurada-Nvidia.nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e60ff17b-3ed4-42cc-f5bb-08d69c7d0e7e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3326; 
x-ms-traffictypediagnostic: VI1PR0402MB3326:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; VI1PR0402MB3326;
 23:1vfUIzV/SCqAkc0/HeT5eYWm/eBmhaR2IoUsU99?=
 =?us-ascii?Q?g1bC4r8szbYKAVTFiyj1oBnTvh+urXSEahipBYDq3NnhLER5zurHmX2QoB4M?=
 =?us-ascii?Q?W+24dJ3VGFjxYgY9MIU+V7+F+dQgqyupCbOLRxXEvczao62rEXg6WfM0illl?=
 =?us-ascii?Q?RcveMJuhkNmgE4jkSmT9Ztol/65t+d6vK+dJxisVbvGDJPhfvT8k2tZ9Weo9?=
 =?us-ascii?Q?DRa0xpsGJ5Lf7qo3wGF1//vT3JsPOYKi10oG99C0yMx5KiwY2I3nTjuGjkJm?=
 =?us-ascii?Q?B/8cBmEmtmV8ug0SU/t64D5x+n4wuupy4P5JZVL/Kdr0cvWTF6jC2qmwK0aF?=
 =?us-ascii?Q?y7wdEqdV4jfVA7NX5y/P/ixsWfU9W/1PdHrQYWvJVb82HK+xG05kWgXsl/oo?=
 =?us-ascii?Q?vqFbXYpVZ0fBULkVvHOEEBJX7IcgB5fF6dPWsgO9+f5V8sE9vpVvc0pYbarb?=
 =?us-ascii?Q?PQt6VQw2zLb6HKuTdoU2pDrFwXtmdS4ZC/IVUV2ml+bXGDRyuLaEXZ6tPXTe?=
 =?us-ascii?Q?V5LKb4sTpnMxenn06JfGCGaEIMkWPEV9Mk2LcLauQ8etHJm0y9bmkWvNVnd9?=
 =?us-ascii?Q?Z60CbF8bZSfacy3fP3afLJT5mXhTm7dA8TL+FVgl6n6DZXSc4iRa9YmaeAiY?=
 =?us-ascii?Q?NHm0lkIAsGCb59X8ngtzk2EAsVNMkvbjcCX/1ic5AZsvo/J42zrWTn4yg1p7?=
 =?us-ascii?Q?QHA40UrPLvP5SjQIvHXh4ouuhlMd2aV1/rGtFMOU0mLrnOVHQeDY3hJy5obY?=
 =?us-ascii?Q?cFM340r0wDJTv7eoqFSSgZqzj2C2YxFK2fotl70NC1Xmp9+oD+ER4jlAPwOQ?=
 =?us-ascii?Q?g/EEIvpbtbRoFptJ6k4GOFk6eiUpDVYBH5m79lczuq8eIhwx8lGhpWavg9gl?=
 =?us-ascii?Q?j+S7I1FcffXFeXNDHeRLYxH2ycLK6+aik539PSMaJ6Fr7UkC9leKRSKu9cFw?=
 =?us-ascii?Q?KBCvnY8wSwo8vlMJhydAmR3htO/rAjP8fF1gLf5x/8JAGbo48Xbn5dS8aPdt?=
 =?us-ascii?Q?jxhgwhkSlUczeGtLxrK1DwbiaFF/tUQyjFjHYi31aNEg6c1tHUo1PxEE28z7?=
 =?us-ascii?Q?DcA+FqN5gUuxWMaUwZJRpJDoDwNIvBwsWFBP2Z79L3NiAe6jJfTpOG6o8wEd?=
 =?us-ascii?Q?pule6gjDW6D5tJIYzw8xY7X1xM+atn9jkWo9iic9b1rV11RKtz1acISW+cVn?=
 =?us-ascii?Q?684Qyv5GHw991cBq0NzGhrzOgiqumvgAoouNtCve3GSh1Rxdk0lOkyGxZzwz?=
 =?us-ascii?Q?NUBNp6FnBU8YONOdsS28=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3326AFA4C5A3A62040EEFEEEE3740@VI1PR0402MB3326.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(86362001)(6436002)(478600001)(229853002)(68736007)(71200400001)(6916009)(9686003)(71190400001)(11346002)(446003)(476003)(105586002)(106356001)(4326008)(486006)(66066001)(1411001)(25786009)(305945005)(7736002)(186003)(33656002)(74316002)(26005)(97736004)(256004)(76176011)(14454004)(55016002)(81166006)(54906003)(81156014)(2906002)(8676002)(6246003)(14444005)(3846002)(6116002)(6506007)(102836004)(7696005)(52536013)(8936002)(99286004)(316002)(5660300002)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3326;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zkujqIL51DxWNi0CbIy2w/+EkbKmDn5bgxGgTZ9GRHn8kj+QooSkdmOgyZrZCjIF19oDsYHUoTrdl7lshJrx38fnbphlX9sMXDK7rhE3pDNKHuIARUfQ7UsmTJ9L7qSezjhl0vMC4A914+WKiH69xA7Da9FZM4O4wQLjjzEipk97ThhxRIHhbkHRGZYNvyCKTYBJ43TPVCWGn8izAn0kNEb98mJ6NuB3/xNBq5hvr5V98UxtA782ev0U4d2sKo4Ak2Uf9dAHtUNfh9sEQb5HiiQkiB7hyrXoLed+P14viYLb777INrjbXRZfxBOYT6tB5YrGGeUcOQJrUiMc6hx0Bf1aakoGHseLGDRd0gLsoRGz7xcH5szthbTxL7zIIXXHOyJ1TPLBtSmRX1VAehpUn3j90lKU9A7GEKAmmxf0cvU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60ff17b-3ed4-42cc-f5bb-08d69c7d0e7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 06:30:24.6469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3326
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

Ok, will send v4.

Best regards
Wang shengjiu
>=20
> Hi Shengjiu,
>=20
> Two more trivial comments inline.
>=20
> On Tue, Feb 26, 2019 at 03:12:25AM +0000, S.j. Wang wrote:
> > There is very low possibility ( < 0.1% ) that channel swap happened in
> > beginning when multi output/input pin is enabled. The issue is that
> > hardware can't send data to correct pin in the beginning with the
> > normal enable flow.
> >
> > This is hardware issue, but there is no errata, the workaround flow is
> > that: Each time playback/recording, firstly clear the xSMA/xSMB, then
> > enable TE/RE, then enable xSMB and xSMA (xSMB must be enabled
> before
> > xSMA). Which is to use the xSMA as the trigger start register,
> > previously the xCR_TE or xCR_RE is the bit for starting.
> >
> > Fixes commit 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
> > Cc: <stable@vger.kernel.org>
> > Re> @@ -361,21 +363,13 @@ static int fsl_esai_set_dai_tdm_slot(struct
> > Re> snd_soc_dai *dai, u32 tx_mask,
> >  	esai_priv->slot_width =3D slot_width;
> >  	esai_priv->slots =3D slots;
> > +	esai_priv->tx_mask    =3D tx_mask;
> > +	esai_priv->rx_mask    =3D rx_mask;
>=20
> Not necessary to have tabs before "=3D"s.
>=20
> > @@ -611,12 +606,23 @@ static int fsl_esai_trigger(struct
> snd_pcm_substream *substream, int cmd,
> >  		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
> >  				   tx ? ESAI_xCR_TE_MASK :
> ESAI_xCR_RE_MASK,
> >  				   tx ? ESAI_xCR_TE(pins) :
> ESAI_xCR_RE(pins));
> > +		mask =3D tx ? esai_priv->tx_mask : esai_priv->rx_mask;
> > +
>=20
> Please add a line of brief comments for the reason why we are doing this
> here, something similar to the commit log, but should have:
> 1) Clear xSMA/B 2) Set TE/RE before xSMA/B 3)Set xSMB before xSMA.
>=20
> Apparently having this mask settings in the trigger() does not look very
> common, so I believe a line of comments would help a lot.
>=20
> You may add my Acked-by in your next version:
>=20
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
>=20
> Thanks
>=20
> > +		regmap_update_bits(esai_priv->regmap,
> REG_ESAI_xSMB(tx),
> > +				   ESAI_xSMB_xS_MASK,
> ESAI_xSMB_xS(mask));
> > +		regmap_update_bits(esai_priv->regmap,
> REG_ESAI_xSMA(tx),
> > +				   ESAI_xSMA_xS_MASK,
> ESAI_xSMA_xS(mask));
> > +
> >  		break;
> >  	case SNDRV_PCM_TRIGGER_SUSPEND:
> >  	case SNDRV_PCM_TRIGGER_STOP:
> >  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> >  		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
> >  				   tx ? ESAI_xCR_TE_MASK :
> ESAI_xCR_RE_MASK, 0);
> > +		regmap_update_bits(esai_priv->regmap,
> REG_ESAI_xSMA(tx),
> > +				   ESAI_xSMA_xS_MASK, 0);
> > +		regmap_update_bits(esai_priv->regmap,
> REG_ESAI_xSMB(tx),
> > +				   ESAI_xSMB_xS_MASK, 0);
> >
