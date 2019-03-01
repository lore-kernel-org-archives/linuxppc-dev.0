Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5EDC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 06:57:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB442084F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 06:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BXWSOW52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB442084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449gG81smMzDqQv
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 17:57:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.8.71; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="BXWSOW52"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80071.outbound.protection.outlook.com [40.107.8.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449gD861xrzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 17:55:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxeZaYL5TFuB2MKzssB3K7hTPMhHjnNuwKghaoGlllI=;
 b=BXWSOW52lpPkV5RsxWE49yPtNwe3UAujl+DLi3xMp5Xw+3sDwmMhW3713/RJkS15/1hgt9U7JJgHZOpITajpkEZrhZvKjSw5zMRI10k7d2GiSCZn59LatJ5pXpkuwkDI6Sr6OZIXlmqrLtaWRUtwuJ4bTs9jCaRRpJkvzsdYaQo=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB3821.eurprd04.prod.outlook.com (52.134.16.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Fri, 1 Mar 2019 06:55:25 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 06:55:25 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: RE: [PATCH] ASoC: fsl_asrc: add protection for the asrc of older
 version
Thread-Topic: [PATCH] ASoC: fsl_asrc: add protection for the asrc of older
 version
Thread-Index: AQHUz9cJhoJPvCZVnE6C6u5MyrK9cKX2FFmAgABDKNA=
Date: Fri, 1 Mar 2019 06:55:25 +0000
Message-ID: <VI1PR0402MB339254C31997242633511D12E3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <1551407560-29950-1-git-send-email-shengjiu.wang@nxp.com>
 <20190301025356.GA1371@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190301025356.GA1371@Asurada-Nvidia.nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b45776ce-1aea-48b2-7a81-08d69e12e201
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3821; 
x-ms-traffictypediagnostic: VI1PR0402MB3821:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; VI1PR0402MB3821;
 23:Hky/79CRlKANZSSVCmTM3keOU2fJuohAdwvt1Fy?=
 =?us-ascii?Q?GYnI68vNm/CnovAjxNyDpSKiDFlBktgXcS8TwJSC1saj8uYXs3+5veKX52IB?=
 =?us-ascii?Q?uIyYmB0dcJwbuxoT0PrY1PVn4sej3j9qvKVpLLNkVwU4m3DpI3dtXqTu2hHd?=
 =?us-ascii?Q?J6DHODA6u3GaAd2YGMNmbJABpH2p9TyTz7way3kvBlOgGmkbrIBH6lGAVl5a?=
 =?us-ascii?Q?DLftkRMZa/sKNU6tnNq84fNvKVelqx0c0L+4tSjwXwbpJnBrm9AyNcsJ2Mtl?=
 =?us-ascii?Q?IYs6a6zqeL2S+EOtNp1LJFGt2cXJfrEep+OH43x5Zgsvsi+W3lIzTktK7EUx?=
 =?us-ascii?Q?7A/1g3q1WbIn8tmNHndhj2uzbiLC7SnLs7e6lYxrRd0jwfnSgzPaQjws0lD9?=
 =?us-ascii?Q?3YUhcYBzvvepFeaT4vkF7wf/iY9/fIad11kRswoRm0Ugc/3gqZuyz19t6PTg?=
 =?us-ascii?Q?nXmAkiAdKV0apuojkvU3JsEWq6OmlP4oZLLAuJaE8uvNyZ5RlKe6YHfv+I3n?=
 =?us-ascii?Q?+0wrFeW6U7uwxoBdzJslGkVZ5mhZEWlbDhoMgydxCEP6JJ9l2I4uUABy3MMd?=
 =?us-ascii?Q?zEhtk+hRGUtS6NvKF6XM8KI5fAmGxIoCMSqumwsrLWBW3Pey4dwAzUY5JEOo?=
 =?us-ascii?Q?ufav582gG/iUcpCaPhKYXF0j+mRY8HCFs0fRzcwPVe+MA7gN/nZn9LpSflmQ?=
 =?us-ascii?Q?W3RZPgCycRxZm90xEou185aKrIKKy0zKMVwXxtE9aSOIDnL8VtFIzy5CLjSB?=
 =?us-ascii?Q?FcRigD5Q3LncJ2ix9jEfz/+lMlJRfy1+AwLgk43+AIzz2d729zOTF5hDmonR?=
 =?us-ascii?Q?b5hDg+6EjIAVn5EyPDgz367lzuWhjW4Rsd8SDVArqQoTyLSr9xvyxhX18/kM?=
 =?us-ascii?Q?Dru2aumw0orAKb574sf8LdavsK6OFM5t9srUArevWu0ocbcQr8nSY2gZxrMx?=
 =?us-ascii?Q?rcAunMe0tgIAWa1p0odNJBeaTmAPBTOTriregAqe/mM84a4XSB2mEf2/pJHA?=
 =?us-ascii?Q?Ah1e2VuH/zitklfHmh2RqaE7+1iiL0QqJuntctZO2A+4jEd8X390VsRbgs4A?=
 =?us-ascii?Q?dbBkT87S7KR1wih+FM5gfwKwZM4SzIlm4nsvVi4XBT02iD8TZxez4l8a2nhs?=
 =?us-ascii?Q?PtIWF4K1D00iH4waZgrl/eNCoryo567MekG3AJuEYFZB33XI68iGZprV8FmR?=
 =?us-ascii?Q?wAqUbcnzlqu3Ms2uwK5oxnomZbM4n7FK7Zg1qmqm857yssGiwvP/ZBkpFZEv?=
 =?us-ascii?Q?FDlTtBWMXLKAz7firEdk=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB38218C98FB87B07D5524938EE3760@VI1PR0402MB3821.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(6436002)(99286004)(25786009)(76176011)(8676002)(9686003)(53936002)(7736002)(105586002)(97736004)(7696005)(33656002)(106356001)(55016002)(102836004)(256004)(14454004)(6506007)(316002)(14444005)(54906003)(4326008)(81156014)(81166006)(6246003)(2906002)(478600001)(68736007)(66066001)(6916009)(5660300002)(11346002)(74316002)(52536013)(8936002)(305945005)(3846002)(6116002)(446003)(186003)(71200400001)(71190400001)(1411001)(26005)(476003)(86362001)(486006)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3821;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AHJE/bCbX8DWaGv7WFNg1UhJaIN2pl+qnDssnp5/ZdTXdAGqlWCwvQR7Y4MEIxPvi5lE8vpIcF95bCoBzrg1SNOCKgCkApKgBXEmZP7QQyxyfLnkeLK++7HNTH0IbU5SS2DO/0wwSyvPYvIOLb+jbcnATt2B1GArc3+6MBM9bsafrb6JbXtoiTrIT38Ry2FXDnme+Dhf9BjKzTqqjXqp2qshBbBpDKt1SzSpKA4pgnyjtIu2NXqNn1MDa+IX1wDZgKHcvSViZmrhK6mDuKf5OzzQ5QyH3we7+LLOrOOcAcbukHH7iNDiZjBr7UZof5Gq2CsJYhNzdYd3v2bRiwygsuO4PpwaPWAebW3SZ0E/cyVR6+Qb999qkCHO0yBbhXNTFFG3eamjMQDrFWGsmRJX5iBTuh4VDJy/euxn5pxPJzU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45776ce-1aea-48b2-7a81-08d69e12e201
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 06:55:25.5569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3821
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
> Hi Shengjiu,
>=20
> On Fri, Mar 01, 2019 at 02:32:38AM +0000, S.j. Wang wrote:
> > There is a constraint for the channel number setting on the asrc of
> > older version (e.g. imx35), the channel number should be even, odd
> > number isn't valid.
> >
> > So add protection when the asrc of older version is used.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_asrc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c index
> > 528e8b108422..b3b3c5e15ef1 100644
> > --- a/sound/soc/fsl/fsl_asrc.c
> > +++ b/sound/soc/fsl/fsl_asrc.c
> > @@ -109,7 +109,8 @@ static int fsl_asrc_request_pair(int channels, stru=
ct
> fsl_asrc_pair *pair)
> >  	if (index =3D=3D ASRC_INVALID_PAIR) {
> >  		dev_err(dev, "all pairs are busy now\n");
> >  		ret =3D -EBUSY;
> > -	} else if (asrc_priv->channel_avail < channels) {
> > +	} else if (asrc_priv->channel_avail < channels ||
> > +		(asrc_priv->channel_bits < 4 && channels % 2 !=3D 0)) {
> >  		dev_err(dev, "can't afford required channels: %d\n",
> channels);
>=20
> I feel it'd be better to have another else-if, since the existing error m=
essage
> is against something else.
>=20
> +	} else if (asrc_priv->channel_bits < 4 && channels & 1) {
> +		/* old version of ASRC has channel_bits =3D 3 */
> +  		dev_err(dev, "does not support odd channel number\n");
> +  		ret =3D -EINVAL;
>=20
> Alternatively, I feel instead of error-out at here, should we add a HW
> constraint or at least fence it off at the beginning of the hw_params()? =
This
> is actually nothing specific to the pair-request function but a hardware
> constraint.

How about add constraint in startup?
static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
                               struct snd_soc_dai *dai)
{
       struct fsl_asrc *asrc_priv =3D snd_soc_dai_get_drvdata(dai);

       if (asrc_priv->channel_bits =3D=3D 3) {
               snd_pcm_hw_constraint_step(substream->runtime, 0,
                                          SNDRV_PCM_HW_PARAM_CHANNELS, 2);
       }

       return 0;
}

Best regards
Wang shengjiu
