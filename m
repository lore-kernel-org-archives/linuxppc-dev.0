Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E863C282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 11:03:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F0D218FE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 11:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n9P09UKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F0D218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ltPQ0RQpzDqVk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 21:03:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.3.40; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="n9P09UKq"; 
 dkim-atps=neutral
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30040.outbound.protection.outlook.com [40.107.3.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ltMH3trHzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 21:01:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqqEVie4tjXJmZgSE1QCEoxqGvZnqDhtbXv+iffTn3I=;
 b=n9P09UKqCJ8SZOVehC80IPjZ+XZY5W0DeFW2rUGSl/2Y+DAfvgqHXDt2Pt99IgA9QL+rIqdto1Usmph/0wjVgy0BJjHC4c6g1z/hw9+DQAPqLFifdwpOyDzj9O5qPn58W3GoJaSxFj6qLvpxgAeyQ0JpZaStsJjCubpYwFWxFX8=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6656.eurprd04.prod.outlook.com (20.179.235.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Fri, 19 Apr 2019 11:01:22 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 11:01:22 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>, "timur@kernel.org"
 <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: [alsa-devel] [PATCH V2] ASoC: fsl_esai: Add pm runtime function
Thread-Topic: [alsa-devel] [PATCH V2] ASoC: fsl_esai: Add pm runtime function
Thread-Index: AdT2nwKH3TLvu6Y8ReyroQ8XH40rZA==
Date: Fri, 19 Apr 2019 11:01:21 +0000
Message-ID: <VE1PR04MB6479A85982748088CC42901DE3270@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41dbeb4a-81e7-40ff-8fa9-08d6c4b65bbb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6656; 
x-ms-traffictypediagnostic: VE1PR04MB6656:
x-microsoft-antispam-prvs: <VE1PR04MB665690802941C9D3B92B77DFE3270@VE1PR04MB6656.eurprd04.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(396003)(39860400002)(136003)(346002)(189003)(199004)(6506007)(33656002)(66946007)(316002)(86362001)(54906003)(110136005)(97736004)(74316002)(66066001)(6436002)(14444005)(73956011)(256004)(55016002)(4326008)(7736002)(305945005)(186003)(102836004)(7696005)(478600001)(6116002)(476003)(9686003)(52536014)(2906002)(81156014)(2201001)(14454004)(8676002)(8936002)(81166006)(486006)(99286004)(53936002)(68736007)(3846002)(2501003)(71200400001)(71190400001)(5660300002)(66446008)(64756008)(25786009)(66476007)(66556008)(26005)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6656;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y4IOf5pQ77u5hV6Lxr91203sfLq0Dgj481GoCJQuGsY/zRY+GM10cbH9qMNQnuKRCyTfXwbbt8qQRBM7CXm6BFW6sFMlLoFJCtHu9a+JxAQtgAxaX/FroJ7EJOsYCLPIBlRLszYvsKPan5mHe30EbIDnom6vWqIg4G67XL4kbtQxwyrVWUJdRn0sSymlf/ABV1xKPfhU3ho/LoTqtBL77cZIqYzxQXMiA8WYXzNMbItn8IMUPrl4A/xhpss/FFn46pm0FfZvWUXLNn1y5fK/T9neBFurVLVLH1F4GR4NGpsE63/G2xnOY83EV32ZnT9cTUZSuJM6P/2+whbvCMcx7u7rRVXCja0rrCecE/czT3okOgCBRUNWoQs5OO42pfC8Mdu7Bri/9p6zbwFLfkktUH/NbPWB+w0HLLhe+Vk2UDw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dbeb4a-81e7-40ff-8fa9-08d6c4b65bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 11:01:22.0823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6656
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Hi

>=20
>=20
> Add pm runtime support and move clock handling there.
> fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> fsl_esai_resume is replaced by pm_runtime_force_resume.
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> Changes in v2
> -refine the commit comments.
> -move regcache_mark_dirty to runtime suspend.
>=20
>  sound/soc/fsl/fsl_esai.c | 141 ++++++++++++++++++++++++++---------------=
-----
> -
>  1 file changed, 77 insertions(+), 64 deletions(-)
>=20
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c index
> bad0dfed6b68..10d2210c91ef 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
>  #include <sound/dmaengine_pcm.h>
>  #include <sound/pcm_params.h>
>=20
> @@ -466,30 +467,6 @@ static int fsl_esai_startup(struct
> snd_pcm_substream *substream,
>                             struct snd_soc_dai *dai)  {
>         struct fsl_esai *esai_priv =3D snd_soc_dai_get_drvdata(dai);
> -       int ret;
> -
> -       /*
> -        * Some platforms might use the same bit to gate all three or two=
 of
> -        * clocks, so keep all clocks open/close at the same time for saf=
ety
> -        */
> -       ret =3D clk_prepare_enable(esai_priv->coreclk);
> -       if (ret)
> -               return ret;
> -       if (!IS_ERR(esai_priv->spbaclk)) {
> -               ret =3D clk_prepare_enable(esai_priv->spbaclk);
> -               if (ret)
> -                       goto err_spbaclk;
> -       }
> -       if (!IS_ERR(esai_priv->extalclk)) {
> -               ret =3D clk_prepare_enable(esai_priv->extalclk);
> -               if (ret)
> -                       goto err_extalck;
> -       }
> -       if (!IS_ERR(esai_priv->fsysclk)) {
> -               ret =3D clk_prepare_enable(esai_priv->fsysclk);
> -               if (ret)
> -                       goto err_fsysclk;
> -       }
>=20
>         if (!dai->active) {
>                 /* Set synchronous mode */ @@ -506,16 +483,6 @@ static in=
t
> fsl_esai_startup(struct snd_pcm_substream *substream,
>=20
>         return 0;
>=20
> -err_fsysclk:
> -       if (!IS_ERR(esai_priv->extalclk))
> -               clk_disable_unprepare(esai_priv->extalclk);
> -err_extalck:
> -       if (!IS_ERR(esai_priv->spbaclk))
> -               clk_disable_unprepare(esai_priv->spbaclk);
> -err_spbaclk:
> -       clk_disable_unprepare(esai_priv->coreclk);
> -
> -       return ret;
>  }
>=20
>  static int fsl_esai_hw_params(struct snd_pcm_substream *substream, @@
> -576,20 +543,6 @@ static int fsl_esai_hw_params(struct
> snd_pcm_substream *substream,
>         return 0;
>  }
>=20
> -static void fsl_esai_shutdown(struct snd_pcm_substream *substream,
> -                             struct snd_soc_dai *dai)
> -{
> -       struct fsl_esai *esai_priv =3D snd_soc_dai_get_drvdata(dai);
> -
> -       if (!IS_ERR(esai_priv->fsysclk))
> -               clk_disable_unprepare(esai_priv->fsysclk);
> -       if (!IS_ERR(esai_priv->extalclk))
> -               clk_disable_unprepare(esai_priv->extalclk);
> -       if (!IS_ERR(esai_priv->spbaclk))
> -               clk_disable_unprepare(esai_priv->spbaclk);
> -       clk_disable_unprepare(esai_priv->coreclk);
> -}
> -
>  static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd=
,
>                             struct snd_soc_dai *dai)  { @@ -658,7 +611,6 =
@@ static int
> fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
>=20
>  static const struct snd_soc_dai_ops fsl_esai_dai_ops =3D {
>         .startup =3D fsl_esai_startup,
> -       .shutdown =3D fsl_esai_shutdown,
>         .trigger =3D fsl_esai_trigger,
>         .hw_params =3D fsl_esai_hw_params,
>         .set_sysclk =3D fsl_esai_set_dai_sysclk, @@ -947,6 +899,10 @@ sta=
tic int
> fsl_esai_probe(struct platform_device *pdev)
>                 return ret;
>         }
>=20
> +       pm_runtime_enable(&pdev->dev);
> +

I just have a question, do I need to add pm_runtime_idle(&pdev->dev)?

Best regards
Wang shengjiu
