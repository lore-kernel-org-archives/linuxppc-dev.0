Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47B6C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 02:56:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ACE12147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 02:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TwWo8U0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACE12147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447k3d0G1xzDqQG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 13:56:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.73; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="TwWo8U0w"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150073.outbound.protection.outlook.com [40.107.15.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447k1q2tqzzDqLS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 13:54:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TalJpR2frRG/RZqYu5oNguMmzpI9wtTro+D+AVAQSL0=;
 b=TwWo8U0wk+spxYY4/+gJDmHLuLSgOTZwH9amoSrdWCh9yqRLj5xFWtB58XxKZlmG2Ex9E5Q5uVVe3RzjVDGQ/pDuwBKjL20F6ScRiX4uzGb5lR/HxE+F4B4PTMSfqfJ3effKSo9+Zyf8xbX5tUzyxCp0L6rGM0yeCGntQnpb7pE=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB2895.eurprd04.prod.outlook.com (10.175.24.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 02:54:45 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 02:54:45 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: RE: [PATCH V2] ASoC: fsl_esai: fix channel swap issue when stream
 starts
Thread-Topic: [PATCH V2] ASoC: fsl_esai: fix channel swap issue when stream
 starts
Thread-Index: AQHUzLSQvgZScKxEQk2/qwsWCp5NqaXxBNWAgABOkWCAAApfAIAABfUQ
Date: Tue, 26 Feb 2019 02:54:45 +0000
Message-ID: <VI1PR0402MB339284333AB2589A4730770DE37B0@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <e31c31acb3c62d16e6b32682e8226c7dbc05f147.1551062751.git.shengjiu.wang@nxp.com>
 <20190225211440.GA20734@Asurada-Nvidia.nvidia.com>
 <VI1PR0402MB3392A0477A1C8CE66C47960EE37B0@VI1PR0402MB3392.eurprd04.prod.outlook.com>
 <20190226023259.GA18857@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190226023259.GA18857@Asurada-Nvidia.nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 112d905f-2218-44e2-6194-08d69b95c38d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2895; 
x-ms-traffictypediagnostic: VI1PR0402MB2895:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; VI1PR0402MB2895;
 23:jw3kOB517YIgX9kdD8fXJEsahMD4ZMVmjRdEz8w?=
 =?us-ascii?Q?54UCyywXlsQs1TJzSm8RENYCCUfOlhA+/+wuzcQ8qBBPUvSHdWCkacMrlHeC?=
 =?us-ascii?Q?SP+52Z5OEFS0AwZCRrp/8roKjPPSta+RtgPJ5xLWH75kvhk7NFweS/+TTKb2?=
 =?us-ascii?Q?NkYQm882OJOB4ibVR7MpZHvg4673Bb2/0tOOJ5jfzTWKI464cQBjiOFB1OtA?=
 =?us-ascii?Q?uw4D+O9jWP75nRCoh7FP+YkDngllD5OZNffbVhfCCmcAxStFGCxMjp25z2AX?=
 =?us-ascii?Q?TLVzBZn8OCl4qAU+TKb0uq/zWe2vhh9wR5U/hY9i3eOvIlQopwFWu4cLRCUb?=
 =?us-ascii?Q?VaeNLo6CN1n2ytqqglO7TJlzULxG4l2YN4+FTkhKLZHUtLdM9SAC0gIUo/HY?=
 =?us-ascii?Q?JARstIXiV7U0ewXiRr6TpviPqueQTcLB7sLpbTjnruF7T0KAAXavPtTCn/S1?=
 =?us-ascii?Q?FfaIXbDFxpeG782ERuY6pq6Aj0DRjOkpWI488jbWnHJGB3gCSxZ0nn/ewMpw?=
 =?us-ascii?Q?7R/kPkr9D37gH1L0gHnRKSlE46az3JmyvrqRdZChv7wHbHdlzBl2J8wXUGjg?=
 =?us-ascii?Q?cLai+JDujd3+5lhOQKkTvggulM9Pybgl7o3m/pZ6bc/z871op/fUbciRkNDK?=
 =?us-ascii?Q?ou/OjYRIJs6lJkzjk71SSVuaRCj99BAhHBaTwzrpOHKK/O08ope8YxD+Rk1I?=
 =?us-ascii?Q?uhRHcJuZ2LmvQTmbCBY9OTIeU76I4Uk8OrBYzm+ycd03lyfIW85O7bZcXofm?=
 =?us-ascii?Q?RQG8vq2KYYinTQCH917bqYaARTs/HFYKLdioL0RTZcmUGcVr7MF/iEVT8QW+?=
 =?us-ascii?Q?8S+j8AN7gNY1DoW0SSp3ad5gH7A4SkWgLN27n3tEOzSCRxhk30ZRwFgCICIe?=
 =?us-ascii?Q?X+TnguELgzIpd01d99piKv6Et43nGwDf733qN9Ge8t1e/mWcMPjYLM/PI/ZH?=
 =?us-ascii?Q?wtqJlUErYZ71i09N/v3Ou54F295TFKU6e8V7H5HCgVI1H8zkJ7C8YshU4afr?=
 =?us-ascii?Q?zx5Zgv2ljbMz43b45AWHdp2rEdAs2I+8XyAiyxDBsTZUEGdvFJrNPO0XxTd4?=
 =?us-ascii?Q?DK54FT3Kfd4eePeEVLB/C0Lv7Nhv/+uytWZJxPFdN9l6NM7xpUTyaQv+R0wk?=
 =?us-ascii?Q?nmReyIMfpEPMRVIl5PlSwU53QWXOHVCEtSWmAidv8ogjJjiwxsLf9y7jOSgV?=
 =?us-ascii?Q?uSWXh0L+V0ivYvTHl0orRpoM5aY/VwEO4XYiyMGX3fDX364nSpa+vEBu+87R?=
 =?us-ascii?Q?GileQoCMTLvFs2shDZFY=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB289525C33D0C0013B34C0A0BE37B0@VI1PR0402MB2895.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(8676002)(81166006)(81156014)(446003)(229853002)(6116002)(3846002)(186003)(486006)(305945005)(7736002)(476003)(11346002)(106356001)(74316002)(26005)(105586002)(14454004)(25786009)(4326008)(6916009)(256004)(6246003)(9686003)(52536013)(54906003)(102836004)(97736004)(478600001)(8936002)(66066001)(71190400001)(71200400001)(93886005)(33656002)(1411001)(316002)(6436002)(86362001)(68736007)(76176011)(99286004)(6506007)(5660300002)(55016002)(2906002)(7696005)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2895;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SnOIuzlvwr1GoByKhx1Yt06DzbnCwHE9YKDG9QtmEqN++l2B8ehlpzAPabDbj48VKAUou2P32uoZc/HyY7xF9YtQlxEE5iq3gXkmnlJuvwVeusjNWACm7cIg0/6HhAlqyB8YEJJ2N2BSUB8L8/0+iMErklabW9xdZfj4+Vur5N//N/EdewRKGeEoF+FXbWFZWL4v53pVSs13jt7IDne7DOgnKvtFKhXGHZOy0bTPr5GXiIORlFIhf4Xhw2sXLNV64ucTNyKnAq/8mFroXW+cNsJs8yM+tdVhilijYm61gNYm+Hylq/beuw1ovSnKMz+PsiOk+g5lKKAuog611tn840cJ8N/wSCbyb9dvCiYOxfqmG6AsE9rwuKUJ+6FTiLaancDLQYYZtkPJllIGajqtH0XotKwHQvgFKyY7IwUjfsk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112d905f-2218-44e2-6194-08d69b95c38d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 02:54:45.1397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2895
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



>=20
> On Tue, Feb 26, 2019 at 02:01:14AM +0000, S.j. Wang wrote:
> > > > diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> > > > index
> > > > afe67c865330..23bd0ad4ac31 100644
> > > > --- a/sound/soc/fsl/fsl_esai.c
> > > > +++ b/sound/soc/fsl/fsl_esai.c
> > > > @@ -54,6 +54,8 @@ struct fsl_esai {
> > > >  	u32 fifo_depth;
> > > >  	u32 slot_width;
> > > >  	u32 slots;
> > > > +	u32 tx_mask;
> > > > +	u32 rx_mask;
>=20
> > > >  	esai_priv->slot_width =3D slot_width;
> > > >  	esai_priv->slots =3D slots;
> > > > +	esai_priv->tx_mask    =3D tx_mask;
> > > > +	esai_priv->rx_mask    =3D rx_mask;
> > >
> > > The two masks only got values here. If a machine driver doesn't have
> > > a
> > > set_dai_tdm_slot() call, they will be remained as 0 and then will
> > > seemly clean those four registers.
> > >
> > Then I think we need to add default value for tx_mask and rx_mask,
> > that is In the probe function to add:
> > esai_priv->tx_mask    =3D  0xFFFFFFFF;
> > esai_priv->rx_mask    =3D  0xFFFFFFFF;
>=20
> Yea:) Please include them in v3.
Ok.
