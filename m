Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6C3C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 14:04:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E4AF218FF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 14:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jcuYC8jK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4AF218FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 441FPY5jYzzDqgw
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 01:04:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.41; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="jcuYC8jK"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150041.outbound.protection.outlook.com [40.107.15.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 441FLG2wTLzDqWM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2019 01:01:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaWLUOXAFc2s49vUjV62Rj8Iw9GxDvXTc/QlUiIb17g=;
 b=jcuYC8jKkdmo2VI6h+VbcUyZIuwThWG8D6/c9TkcHr2c3ziEVk5ZQVSrdE4s1E0nMV+Wm5+mE62q84xFsSQ3wDTb+Lu6auLsn/gnoB1oe3S2SOfQdVgw4Kh2BJVbKiREIDceVSY/8Dzsm0wRxoM3e9ia3Rlpexp1g0WzvEKpSTM=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB1614.eurprd04.prod.outlook.com (10.164.84.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 14:01:32 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::6cc1:d14c:a535:87ce]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::6cc1:d14c:a535:87ce%5]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 14:01:32 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi
 <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v5 0/3] Add NXP AUDMIX device and machine drivers
Thread-Topic: [PATCH v5 0/3] Add NXP AUDMIX device and machine drivers
Thread-Index: AQHUxTb0uwDQk32wgk2GXe6WKXXjcQ==
Date: Fri, 15 Feb 2019 14:01:32 +0000
Message-ID: <1550239285-12587-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0059.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::36) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6db44ab1-0346-4d39-02ac-08d6934e16dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1614; 
x-ms-traffictypediagnostic: VI1PR04MB1614:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB1614;
 23:wTM60nm4LIh0wknfap/7tJDIkNWu+e0csTlFi1s?=
 =?iso-8859-1?Q?3uPMYQV18IzNk8XJhEYRHi1v0ooDvHvW6Ro89xUEA/sLxV3gWVVN7ZaUXm?=
 =?iso-8859-1?Q?HP5JtJ+JynQVmfcXvdyO9MIXDu/roiMZscMw85uDf9KVYZTHSggSHN4GQE?=
 =?iso-8859-1?Q?nr6x3ryZWqk61wRfOORmroJqzWTS2TYQLmv4vz7pwJU+GjdF7Pau40YDT+?=
 =?iso-8859-1?Q?buq9f7qY6JPKzeq7MT09BJ+qLsb4QgiQiKf4e6KLWPsHYOeP8bgBQEX66U?=
 =?iso-8859-1?Q?YVl3p/vxnhl9yVWwF+fQ6JV0Z77tn8MOc0alZjm8KLQvaoRVg6GHq1EuQl?=
 =?iso-8859-1?Q?z+DG6iNpu2oQSN0Pid4euda6GVfFzM+posFcuNf6xWIJf7tWr8JGQL+yeq?=
 =?iso-8859-1?Q?u73ze0vMyLgRzxicmGjKm2qMdYusvvIqshkWHmg36HGOInaqVcokb1XQhs?=
 =?iso-8859-1?Q?AUB/FTDEWqsDOb1qL9/QKrycdFYYyQIylzAECyOmZawa0i57EB0ZFfu4U9?=
 =?iso-8859-1?Q?5JWA+gm69Ots2tgUbi+PA3xZnbYi1uV5eaJYqJc079ThQn1JirzFGoDppQ?=
 =?iso-8859-1?Q?HP0KrY7if6aY9G4q4ELXn87Eaqz99679iuUTWOFsHOxuJOdKSPboZ76hJ3?=
 =?iso-8859-1?Q?fLDIZivQLHPgWDi89b1SahCxGjnY5U7SrVIe//MiASP+8ARfQLATFHMISZ?=
 =?iso-8859-1?Q?hp5y9+joqlRGAQ2J/pddoK7/8IFED9yesoFzFo1A/ordzfjIF4Qs8YNS6F?=
 =?iso-8859-1?Q?qIBgCRXrR6z08yFPSLEKvO1u+7PY0LcL06UvrXi+MILV83XbxXDUBtCs8+?=
 =?iso-8859-1?Q?wMHFxw78b7CREygMJo8JPXMPNkA9ra94aLSY9k7DKWMuV+NActNlXICyln?=
 =?iso-8859-1?Q?R31mU9ehf1TnCTT403EJa4R+DiUtHYu0atKk7Ese/D/uLe2YLiYSVDkAL4?=
 =?iso-8859-1?Q?ScCUehY/E9Ao09slYOoZi7SZL3x0H0nDrZQBNmiRCSoYp2LQ+PIFsviGX1?=
 =?iso-8859-1?Q?Od8lianWV1+ysfAjFyUVEFrGknVNa9waoLIuVwCR8qjOzTkFbiT4L6+WG6?=
 =?iso-8859-1?Q?2BIZjwRsk71FG3h0riPw5py7JUiybz0E8fLqVlG6N6HwN5DRxBNhTfueqn?=
 =?iso-8859-1?Q?Lr0QHLsoPNqSdUrrLLdqqz0CGZoXPHQDlG9v2Ka9KsY7jqZjB1+G951/MU?=
 =?iso-8859-1?Q?zxDZZVQep56ZRabd/rqpEof7f2HN0BE27lg9RMXuIpyvnmqqylAJMPHJwa?=
 =?iso-8859-1?Q?rzwHapfp3GOFG1szmEh4IXTZMUaXYroGDVDxMsg=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB1614A89C95A85A2B276A64E092600@VI1PR04MB1614.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(136003)(39860400002)(346002)(396003)(199004)(189003)(50226002)(486006)(54906003)(52116002)(99286004)(256004)(86362001)(97736004)(478600001)(71200400001)(6486002)(71190400001)(2906002)(217873002)(6636002)(25786009)(66066001)(110136005)(36756003)(6436002)(6116002)(26005)(4326008)(305945005)(8676002)(7736002)(8936002)(81166006)(81156014)(44832011)(476003)(386003)(6512007)(2616005)(106356001)(6506007)(105586002)(14454004)(186003)(3846002)(53936002)(7416002)(316002)(102836004)(68736007)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1614;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DDoarAcvAUJxa3WCv/Q3Y3vxjoHlHqeC9+MmZwMVNS7jTDMB4GSZt3OWZ0xtCAfmKFRN0jGeZ+DRVb54KjTWO3E6oTBpyfs1ojR3rYUrEgXA8pUKp3tzYRmM+0Jr+nk+gGtxSZmm31f/FdmTp2+yo37h2iJoFCejh59TqijkfjaLH2uA9pqUntLEwR/GKD/MEEkzo1ekXdyv5yniEdj17Hhpl074Ep+1nctDFNJHGoNn45BEoK5sT11Y9yfYUqtm1y83Zutw3a55Ow7000G/3Xzl7+mN8SvIqUSPURhFNZ9oln/l2X4bqE7mqSN4uM2vMMUnaBq5hJz+U/85qS0PZS56ZQ2YaWNGw8ynBBvKiDkRbRFy84iIWZRBd96qk+sz5305BN4BPC3L0pL4Wyheben0uvY3ZuaOy4lNJisAbIU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db44ab1-0346-4d39-02ac-08d6934e16dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 14:01:30.6493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1614
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Viorel Suman <viorel.suman@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The patchset adds NXP Audio Mixer (AUDMIX) device and machine
drivers and related DT bindings documentation.

Changes since V4:
1. Removed "model" attribute from device driver DT bindings documentation
   as suggested by Nicolin.

Changes since V3:
1. Removed machine driver DT bindings documentation.
2. Trigger machine driver probe from device driver as suggested by Nicolin.

Changes since V2:
1. Moved "dais" node from machine driver DTS node to device driver DTS node
  as suggested by Rob.

Changes since V1:
1. Original patch split into distinct patches for the device driver and
  DT binding documentation.
2. Replaced AMIX with AUDMIX in both code and file names as it looks more
  RM-compliant.
3. Removed polarity control from CPU DAI driver as suggested by Nicolin.
4. Added machine driver and related DT binding documentation.

Viorel Suman (3):
  ASoC: fsl: Add Audio Mixer CPU DAI driver
  ASoC: add fsl_audmix DT binding documentation
  ASoC: fsl: Add Audio Mixer machine driver

 .../devicetree/bindings/sound/fsl,audmix.txt       |  50 ++
 sound/soc/fsl/Kconfig                              |  16 +
 sound/soc/fsl/Makefile                             |   5 +
 sound/soc/fsl/fsl_audmix.c                         | 578 +++++++++++++++++=
++++
 sound/soc/fsl/fsl_audmix.h                         | 102 ++++
 sound/soc/fsl/imx-audmix.c                         | 327 ++++++++++++
 6 files changed, 1078 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
 create mode 100644 sound/soc/fsl/fsl_audmix.c
 create mode 100644 sound/soc/fsl/fsl_audmix.h
 create mode 100644 sound/soc/fsl/imx-audmix.c

--=20
2.7.4

