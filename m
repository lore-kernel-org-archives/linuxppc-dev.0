Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D383CC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 03:28:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F7B2146D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 03:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="T+mS6FH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F7B2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439Lf764vFzDr42
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 14:28:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="T+mS6FH7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=renesas.com
 (client-ip=40.107.141.134; helo=jpn01-os2-obe.outbound.protection.outlook.com;
 envelope-from=kuninori.morimoto.gx@renesas.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=renesasgroup.onmicrosoft.com
 header.i=@renesasgroup.onmicrosoft.com header.b="T+mS6FH7"; 
 dkim-atps=neutral
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410134.outbound.protection.outlook.com [40.107.141.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439J2n4GQlzDr5Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 12:30:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xwm1f3zlRr3YQLd+/bVfzuovTzr57I3xZzWacCZKIeI=;
 b=T+mS6FH7VdYEWrE2V93Zy9EXdlbRZV8jqYXS64m74gy5YVYkKvh6aKtXv/rV0OtHf29aOXyBVzpFtNhGyVMZYx+EzyrlLflNaTrEmzp2L6jVa+UiR5E7nP0z7saKiQ+c9iXFM0hYajbrsn6r1+pEumTaWqVz6rszQ288iwY+BhI=
Received: from OSAPR01MB3652.jpnprd01.prod.outlook.com (20.178.102.21) by
 OSAPR01MB2516.jpnprd01.prod.outlook.com (52.134.246.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Thu, 6 Dec 2018 01:30:48 +0000
Received: from OSAPR01MB3652.jpnprd01.prod.outlook.com
 ([fe80::1082:83c0:48f5:59a6]) by OSAPR01MB3652.jpnprd01.prod.outlook.com
 ([fe80::1082:83c0:48f5:59a6%4]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 01:30:48 +0000
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: Use of_node_name_eq for node name
 comparisons
Thread-Topic: [alsa-devel] [PATCH] ASoC: Use of_node_name_eq for node name
 comparisons
Thread-Index: AQHUjQNQk1erTpZMq0uMENTIeIX86A==
Date: Thu, 6 Dec 2018 01:30:48 +0000
Message-ID: <875zw7jvr1.wl-kuninori.morimoto.gx@renesas.com>
References: <20181205195050.4759-33-robh@kernel.org>
In-Reply-To: <20181205195050.4759-33-robh@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR01CA0099.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::15) To OSAPR01MB3652.jpnprd01.prod.outlook.com
 (2603:1096:604:58::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; OSAPR01MB2516;
 20:qIf3/8l9gKFo8f5PZ1BAe04z1zxn4ESBe6gavFLuOBj+5TVKeX52xxXifFRpsr9nAJqZguvVEw762Vc8JL628L+jVf32vAdiU+fWpXyhPwSqEMjJoGPerMSEtcVgfkT0AJQWCFPlFd4d92dYZoXVk+ZII1WkS2/a7ToVcXuVn2g=
x-ms-office365-filtering-correlation-id: 3d10c6f9-a39b-4d3b-c5e1-08d65b1a72ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:OSAPR01MB2516; 
x-ms-traffictypediagnostic: OSAPR01MB2516:
x-microsoft-antispam-prvs: <OSAPR01MB2516B039705D64E24E9E1793D4A90@OSAPR01MB2516.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:OSAPR01MB2516; BCL:0; PCL:0; RULEID:; SRVR:OSAPR01MB2516; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(6916009)(99286004)(6246003)(53936002)(105586002)(486006)(106356001)(2616005)(476003)(446003)(11346002)(102836004)(68736007)(478600001)(316002)(26005)(4326008)(81156014)(8936002)(81166006)(54906003)(39060400002)(52116002)(186003)(6512007)(386003)(36756003)(14454004)(6506007)(14444005)(256004)(76176011)(7736002)(5660300001)(7416002)(305945005)(3846002)(71190400001)(71200400001)(6116002)(6436002)(25786009)(86362001)(2906002)(229853002)(6486002)(97736004)(66066001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB2516;
 H:OSAPR01MB3652.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HgcT5AWz9/VMAKrqycOzUWUV5s4AOvVmaLATdc519FkhKv2VnkpTVvuh4ELl9em33DxWlUVhM6+pWMClUeNeyRXTqwdctJKGtmzBNrogRZEdIN5lw65iWvx7yjI+UtncHovEuXv5C7pu8DGvumnNsf8lhH9uWeqlAhm+LR9sdu4EuB9FagKXf5I9CJJ+OCodpllrYE5llB2r0RkiD4Ayn3xRklq3p4AeYN2jdDOZmiosctXGIa2R+48FKRclDkT6qQqPl4ib2QceXUqtfi9DNdchudsGjEyND+LKgrTxmp8ASDNlTDohhmr2X+hSj+3wOnnjtSI784Sp6b6+OuZR/WiErpPE/P0m3cAMfdmatA4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FFD6A0F1D3827746B1DACBD7F8675846@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d10c6f9-a39b-4d3b-c5e1-08d65b1a72ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 01:30:48.1185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2516
X-Mailman-Approved-At: Thu, 06 Dec 2018 14:25:53 +1100
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
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Hi Rob

> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>=20
> For the FSL ASoC card, the full node names appear to be "ssi", "esai",
> and "sai", so there's not any reason to use strstr and of_node_name_eq
> can be used instead.

I guess this patch is for FSL ?

> ---
>  sound/soc/fsl/fsl-asoc-card.c       | 6 +++---
>  sound/soc/generic/simple-scu-card.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

But, this patch is including simple-scu-card.
Is this miss ?


Best regards
---
Kuninori Morimoto
