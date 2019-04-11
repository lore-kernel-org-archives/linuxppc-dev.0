Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA69AC10F11
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:03:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5862A20818
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="khEw/nqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5862A20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fm7d18WQzDqP2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:03:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.3.45; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="khEw/nqL"; 
 dkim-atps=neutral
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30045.outbound.protection.outlook.com [40.107.3.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fm5r38pqzDqDL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 13:02:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juKRbcJBDVfJWnESmcC4CMZd+KUYxGa0Jzu3IFPXSsU=;
 b=khEw/nqLO1PTdB6dzK2JcZqLzjGDvArS658fo56ZXuzfz6el5cnC5OxZBmjWhryLWtD2NWiHNQXGIPvXyD/gNQZYJtb9cXQ//DpMlLe7XpB7EdebdIAdrSxFk1wiTT2H5O5ZwiAp1JxyhTBaq/SDQTeo0yOfVL7s5ypbO29O1Gw=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6381.eurprd04.prod.outlook.com (20.179.232.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Thu, 11 Apr 2019 03:01:59 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%6]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 03:01:59 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>, "timur@kernel.org"
 <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>
Subject: RE: [EXT] [alsa-devel] [PATCH V3] ASoC: fsl_esai: Fix missing break
 in switch	statement
Thread-Topic: [EXT] [alsa-devel] [PATCH V3] ASoC: fsl_esai: Fix missing break
 in switch	statement
Thread-Index: AQHU8BLtuyaSqwLtUEumJqBn1/TugQ==
Date: Thu, 11 Apr 2019 03:01:59 +0000
Message-ID: <VE1PR04MB6479352259003E1CAF7E7AF0E32F0@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <f1b910498324783f39b66a229c4abb80738097de.1554951087.git.shengjiu.wang@nxp.com>
In-Reply-To: <f1b910498324783f39b66a229c4abb80738097de.1554951087.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59ee3d37-ecf6-40d6-7d5f-08d6be2a107a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6381; 
x-ms-traffictypediagnostic: VE1PR04MB6381:
x-microsoft-antispam-prvs: <VE1PR04MB6381E83346F7A02F5F158498E32F0@VE1PR04MB6381.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(71200400001)(106356001)(316002)(2201001)(4326008)(110136005)(105586002)(97736004)(25786009)(71190400001)(9686003)(81166006)(229853002)(2906002)(81156014)(33656002)(14454004)(86362001)(4744005)(8936002)(68736007)(6246003)(6436002)(53936002)(55016002)(3846002)(6116002)(102836004)(5660300002)(52536014)(476003)(7736002)(508600001)(305945005)(26005)(14444005)(2501003)(256004)(74316002)(11346002)(446003)(76176011)(66066001)(7696005)(99286004)(486006)(186003)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6381;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E0bZdocfVniMLZQghlV+XCyqUucYXVSAmdGsKLcbf+GA6v4O7yFaoNSIshG85UGZGUxvFc1kQ0xPvodd+tJUf1bHrTbK9aneH1JHcx0QwWgwdjV/tSqIrbYFa8wVm+PfnTWvz6ECAGp3O3p/uuSmysSFWDmSgGoP5wsrN1u6HSOamOx+jMsEx7ARymuFjPGMx6+nnjs5DbAv4gsnieqkaanrknrHuBVZcWKh7ZOzZHAWr3MLew3/sIoOr5KpyY9y3E55mmiz40LEQD8jGf4uhWq3py7ntSopf2cxgm1VYxYD4nwG7DyeTIT8dVZUfcY0wa5ejbQtTcfO+TTIOmGs9FD7HQHcMur+eEw4RfRIn8zA9YPzuPaROufrq83EvK8It9wKOHenSJAkH1TjmRIAb22ZA9+yHnu4NthN01gocfQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ee3d37-ecf6-40d6-7d5f-08d6be2a107a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 03:01:59.2189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6381
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi
>=20
>=20
> case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be independent
> of each other, so replace fall-through with break.
>=20
> Fixes: 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Cc: <stable@vger.kernel.org>

Forget to add Acked-by: Nicolin Chen <nicoleotsuka@gmail.com> , will send v=
4, sorry.

> ---
> changes in v3
> - add cc stable
> - change the subject
>=20
>  sound/soc/fsl/fsl_esai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c index
> 3623aa9a6f2e..15202a637197 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -251,7 +251,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai
> *dai, int clk_id,
>                 break;
>         case ESAI_HCKT_EXTAL:
>                 ecr |=3D ESAI_ECR_ETI;
> -               /* fall through */
> +               break;
>         case ESAI_HCKR_EXTAL:
>                 ecr |=3D ESAI_ECR_ERI;
>                 break;
> --
