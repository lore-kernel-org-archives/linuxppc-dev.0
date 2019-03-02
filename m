Return-Path: <SRS0=6H9d=RF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BEDC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 05:49:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22C8205F4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 05:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pOZjwlny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22C8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44BFjY5KhCzDqTZ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 16:49:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe0c::61e;
 helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="pOZjwlny"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44BFgk3RT0zDqMs
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 16:47:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2caaRLlqxL9uVvmgGgoUsNv1HxWLirTI8ERJqaui/c=;
 b=pOZjwlnyQ/jCUqroGJTvFD8vV9M+EzScZY8v56sdZF/BQsQsIw0usWiQaL4A3Q/fTtR6UdFADzytKpoBXHDrNqb2eBEMFnnxl0Tr4E0clQaEk/Z0bmw+by048SRF1DTK1lax4jYata0+OY8gVkbAAt78ma/J/XtLeBVLFSHT6xE=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB3373.eurprd04.prod.outlook.com (52.134.1.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Sat, 2 Mar 2019 05:47:51 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.022; Sat, 2 Mar 2019
 05:47:51 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: RE: [PATCH V2] ASoC: fsl_asrc: add constraint for the asrc of older
 version
Thread-Topic: [PATCH V2] ASoC: fsl_asrc: add constraint for the asrc of older
 version
Thread-Index: AQHU0An1hGn59KuT1UaLuZVdqt/UK6X3GNgAgAC90EA=
Date: Sat, 2 Mar 2019 05:47:51 +0000
Message-ID: <VI1PR0402MB33929DC859FF2D481877B8C5E3770@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <24ebf5b610cc69f18c05e4aefa1874ae23861943.1551429264.git.shengjiu.wang@nxp.com>
 <20190301182743.GA6305@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190301182743.GA6305@Asurada-Nvidia.nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 050c93a9-fc6c-443b-0ef6-08d69ed29bcc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3373; 
x-ms-traffictypediagnostic: VI1PR0402MB3373:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; VI1PR0402MB3373;
 23:Zhy8q+6y8l5oQUt+Pjr/tDsCrhKNFWt/MiKmU0c?=
 =?us-ascii?Q?pjKtvg7Dz+BODAIjb8V5BcPwRBJMObmoUn8MXmJqwr1vG1z+w8OScH4CzjT9?=
 =?us-ascii?Q?Oz24l5JGesldZ1Bx+to7UGZ+f5ZVZ2LRNt19yGKT6k3VOCukD3egIzLne7Sy?=
 =?us-ascii?Q?3EWXx8Mep11kXlu2NhfPq/eFFOd7rpBHMEjqp88s/pCcaiI+txG54ChqqlM2?=
 =?us-ascii?Q?4puxw4Z/PWGRRpzx9UOYtXznx+nN/noQ9CLsYwU7CtX0txzjtxrGu4I2MPhe?=
 =?us-ascii?Q?q+H78oIsptuspNqWAWZXsQ0dNIYstq1nM8mdaW2aWmi0vI29h2Fbbb04mul0?=
 =?us-ascii?Q?1hPIyfvrKQkGUHDzcT3PmTRqAuGomrBk7I9TvfRPfgAZZqpKcSGyjbEBZcgu?=
 =?us-ascii?Q?XMQskC/Bej3HkYiRaJP74Ym4xi21+iZOEmHOHQwuTuxwRdKIWyPlgYkDfh/3?=
 =?us-ascii?Q?3no9bjJfor7CBndpnHeMVQ1dBQJYdWAWq25KOvTxHayvhDHpOBEv2YbgYEk8?=
 =?us-ascii?Q?Rolder5nH3IEw+VdbxvXFILXcZ7tw2cRkEk32JVPPbjMbU4vemZ2XqQVB93x?=
 =?us-ascii?Q?cZ9iJ9TgerjFIujBmoMwywA2qRiCoeax+ImH7hGaUagQcA8KpvDoRA9UmIYc?=
 =?us-ascii?Q?ykGkzBURtpfnIOVIRgi/Kgoqb6W4YSTU/jmb/bCYFs9H9494anP0AlL2lqao?=
 =?us-ascii?Q?X/uV9S+L3ABm3MvPld9Vy8qBqdvG5mKLxOXNnXdcgUQ5bzxD73HMzqDg6quI?=
 =?us-ascii?Q?fX3LsTJfyqHLhLx/PicMPyBx6gLwk8/XkXF6EKCOEOVHXqA39TPQQKJwEu9U?=
 =?us-ascii?Q?d9UIGTE1LxFMm4mJCLj0VBOW5ooLx8dilHMP6NVG4YZVuo5LFPLDM66RzROw?=
 =?us-ascii?Q?TNrG1UnWbnxbh5cprsBKX0s7Tsr0yzzHyWmMCRaG6zMmWIXNBx5/C3OIPN/A?=
 =?us-ascii?Q?oBWgHdmtdw39cojFFHKFD77oBYM12g0QkatokinG1yNzL+Ee4kdLeMFWdxPU?=
 =?us-ascii?Q?aqlY2fvsam5fbOo2QJbeCTtTch32iD1SkoKXmxCu2QI1lMQL8T5HqgwE5EAd?=
 =?us-ascii?Q?ZlfJAMwr9wcOHp0Xg0FwPmZngTWwZv9fwmNOsDVPzC3SkWeyVxYnnxzgQJB9?=
 =?us-ascii?Q?cBLU3ZB6VYGedENRxhGRPVUQqVn2qy+kKubsw+IsuZeksWkdB71tqhprnZph?=
 =?us-ascii?Q?/40e5FCwh8alN/IcyAYWkIvdpUWhKt0pgvLmnx2MI9yK6GIQpdGqWOWCvCWz?=
 =?us-ascii?Q?YeQSQfFAOW6Ys8TMMAYk=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB33733356D259B0DD44E0879EE3770@VI1PR0402MB3373.eurprd04.prod.outlook.com>
x-forefront-prvs: 09645BAC66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(366004)(136003)(39860400002)(346002)(189003)(199004)(11346002)(446003)(4326008)(66066001)(486006)(476003)(25786009)(229853002)(2906002)(33656002)(54906003)(316002)(7696005)(102836004)(6506007)(76176011)(99286004)(7736002)(97736004)(305945005)(81156014)(6116002)(8676002)(74316002)(81166006)(3846002)(186003)(26005)(86362001)(6916009)(14454004)(9686003)(1411001)(55016002)(478600001)(4744005)(53936002)(8936002)(68736007)(105586002)(106356001)(52536013)(6246003)(71190400001)(71200400001)(5660300002)(6436002)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3373;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gJAscjwEZD0wmTO50uMPLbBB6rEpbsTTVzaQhlnB/76lt+/Im95ROnT7fm4ahOGCmDVuBms7iRzwUwUKyqwFsahygwNa76fPLafT5WQ+nwAGC5rFL4FWp5lwEGES1MQP9BJ38oXtnqIw+OVlZsHcburym74Vnm93sXU4bRq3+ZzcNIt+T2QQwgjsVHHKJz17DQEZNM6AwE/xJK/0TbbaPGYc5x0EMVCdQgc95TTcHvIAIdBh5ISLF5+/q3ocjHzf4bBlWgESYlGPkkOY2w5e1pGHu5814DGvOsKhxbBXYkTsOdboqcpb+4itRkm1JCJQWg5J1tN54k7BaeoupjFy6ggG3LR/TI+clX6PJnx1SRgGPkoHQn+xz4/rPr/pWCCBQ+c80ivX0LvAbVTbuSDijvSyRfGocJwNqMtdLDZ4uCY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050c93a9-fc6c-443b-0ef6-08d69ed29bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2019 05:47:51.2665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3373
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

> On Fri, Mar 01, 2019 at 08:37:08AM +0000, S.j. Wang wrote:
> > There is constraint for the channel number setting on the
>=20
> nit: "a constraint"
>=20
> > asrc of older version (e.g. imx35), the channel number should be even,
> > odd number isn't valid.
>=20
> > +static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
> > +				struct snd_soc_dai *dai)
> > +{
> > +	struct fsl_asrc *asrc_priv =3D snd_soc_dai_get_drvdata(dai);
> > +
> > +	/* channel_bits =3D 3 means older version on imx35*/
>=20
> Space between '5' and '*'. And better to make it clear:
>=20
> 	/* Odd channel number is not valid for older ASRC (channel_bits=3D=3D3)
> */
>=20
> > +	if (asrc_priv->channel_bits =3D=3D 3)
> > +		snd_pcm_hw_constraint_step(substream->runtime, 0,
> > +
> SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>=20
> For your next version,
>=20
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Ok, thanks, will send v3.

>=20
> Cheers
