Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379B1C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 11:41:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7607D2082D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 11:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dYQnYqWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7607D2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kCNs1qXBzDrM9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 22:41:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="dYQnYqWT";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.3.65; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=poonam.aggrwal@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="dYQnYqWT"; 
 dkim-atps=neutral
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30065.outbound.protection.outlook.com [40.107.3.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kBh63bkDzDr8p
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 22:09:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBNR15C2Z2rCaxKiZgYG1XL6dAzUvvn6KEJ5fIsFg6Q=;
 b=dYQnYqWTJuLVY/ZZn3ms7Ao4jfnaDS7OWZP5XUjfGW2U4hqMLCiXtv6km/JWOjngOLFz9GS38zNn/Wbr7HEyB8BBuj+SPq/VxamQXkUR8QBqqDVqb3TfYEr46LK+EKoUFyhXxQJUMRSzHf4CzwI77CcLeqjXBQ5O5og3jfTw6AQ=
Received: from VI1PR04MB4976.eurprd04.prod.outlook.com (20.177.49.217) by
 VI1PR04MB1359.eurprd04.prod.outlook.com (10.163.166.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.25; Mon, 29 Oct 2018 11:09:24 +0000
Received: from VI1PR04MB4976.eurprd04.prod.outlook.com
 ([fe80::a425:3202:622e:7995]) by VI1PR04MB4976.eurprd04.prod.outlook.com
 ([fe80::a425:3202:622e:7995%2]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 11:09:24 +0000
From: Poonam Aggrwal <poonam.aggrwal@nxp.com>
To: Vabhav Sharma <vabhav.sharma@nxp.com>, "sudeep.holla@arm.com"
 <sudeep.holla@arm.com>, "oss@buserror.net" <oss@buserror.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com"
 <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org"
 <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org"
 <linux-kernel-owner@vger.kernel.org>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de"
 <arnd@arndb.de>, "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "yamada.masahiro@socionext.com"
 <yamada.masahiro@socionext.com>, Leo Li <leoyang.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH v7 2/6] soc/fsl/guts: Add definition for LX2160A
Thread-Topic: [PATCH v7 2/6] soc/fsl/guts: Add definition for LX2160A
Thread-Index: AQHUb2jMtnB5YzdFEU2F1umur4t5tqU2EK4g
Date: Mon, 29 Oct 2018 11:09:24 +0000
Message-ID: <VI1PR04MB4976D4A33E0561D125BE837486F30@VI1PR04MB4976.eurprd04.prod.outlook.com>
References: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
 <1540759926-3641-3-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1540759926-3641-3-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=poonam.aggrwal@nxp.com; 
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB1359;
 6:6wBhiTL3AGxbH/Rp7C9hO96MzXb6n8Wv3BmlJAAl3nyPKTeZH3zKDQYCLYHjUFR58FEHmo46Xn7wTD2zpQ1YCEueEMs41NG7sgqodAGGVNE+IqXvoeiKsCwraD7IQBWL04Se7vihKwPyjwpyw4/bxNO/z+jK40XfKPZ2lFwrCStfBbEST6U7Dw2pnfqEiBXmY/9x5hhZUKIX9ClZFW0cQGEzspDJohYxJhL3x9cNKF7NyIgohyvvdy34HfBFejP9sT+88kiAWgVNpe5HGS4OEVEHA+WM8r6ecYAlnyWM6uKqi2uADVn6lou/Tunm7dIODK/ypJVhOstMBEsthQ7b1Xkq731gioQHl3EAgIRCmABoLiU4SjupxSOVi7LNNnApMsNDh1TgYqgWmrku979BduqouX/xMsB9PMBrOjTsYxbfQ7UiGgjWUuQRTNDkFCBDHwvCfvcKbq9jPkGisM4abr1r/Ae+2vUbjBMwQ7wxcC4=;
 5:UAcrmjWun/1LpoKuDZKDszkTHxRLM6S6xYl4pZgbYNq6ZaSEtJmOhNsEC3bO7nrID48xggrSu2gmqKFs9IAJKfHWGiAVhkb7Yo9B6SNt+ubagAKTCHCv/I+rVtFC+RrtMjkmx3aZpjQdwda/XiOsw+khckuNCzBbM1is7UEU8qo=;
 7:YYkUpN37s5XE61Q+7EbzfIbQhZeqZcLOOgRx+6E+hhLhw5s/dBcsy658MFYP9nybcSK5lyEqtnmCjPxBcZkzDFUPisobt3os6mHzPHoYa4WDNEAQsq4IsqRfslJgEIhqQI3zHms0kAQyGNvu724T+A==
x-ms-office365-filtering-correlation-id: 35ccc36f-af72-4b10-59d4-08d63d8efc44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1359; 
x-ms-traffictypediagnostic: VI1PR04MB1359:
x-microsoft-antispam-prvs: <VI1PR04MB13590DAE631FD13B25328E7D86F30@VI1PR04MB1359.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(180628864354917)(9452136761055)(65623756079841)(228905959029699)(45079756050767)(189930954265078)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231382)(944501410)(4982022)(52105095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB1359; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB1359; 
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(13464003)(44832011)(6246003)(4326008)(11346002)(6116002)(476003)(7736002)(53936002)(25786009)(256004)(446003)(99286004)(105586002)(2906002)(68736007)(3846002)(486006)(45080400002)(478600001)(106356001)(305945005)(74316002)(66066001)(33656002)(966005)(14454004)(2900100001)(71190400001)(8676002)(6436002)(6506007)(9686003)(55016002)(6306002)(97736004)(71200400001)(26005)(2501003)(5250100002)(55236004)(316002)(54906003)(575784001)(110136005)(53546011)(186003)(86362001)(7416002)(8936002)(2201001)(81156014)(229853002)(102836004)(7696005)(81166006)(5660300001)(76176011)(921003)(1121003)(473944003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1359;
 H:VI1PR04MB4976.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oipseuV673D8gQYA824Z4QblrKciSu7eaKxthdS7wUprY4mzmu7M+pBFoPcyv5Kb4BZl0/6/Y8pphCUTpXBXz7QQNezDY+cMZYcJZLaOEnItp390ML5PrXx0j9df4zKcFN9TOFMdeFL7OtCMqMV/XGl6Y9n5jNskIJzLq5eA/FVBaB6DodnDhuszLfOVFLN8pqFigmiIa6suLw1AotykHx8yViEuit0LLSHbNwcpc55bEcGDIHBb1zoqVlkpx2C1KgUkRsE7RUSk90SQxXhdDCYy9rMYSpxhqNX7IxAmI17WkDgHXi/MdMUd6EahhEFA2eX3NYnGCEJj/8GbXo6MBOTeQdeK7ZOQZwTl+6u+TDk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ccc36f-af72-4b10-59d4-08d63d8efc44
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 11:09:24.4460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1359
X-Mailman-Approved-At: Mon, 29 Oct 2018 22:26:55 +1100
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
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Udit Kumar <udit.kumar@nxp.com>, Pankaj Bansal <pankaj.bansal@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 Varun Sethi <V.Sethi@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>,
 Yinbo Zhu <yinbo.zhu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.o=
rg]
> On Behalf Of Vabhav Sharma
> Sent: Monday, October 29, 2018 2:28 PM
> To: sudeep.holla@arm.com; oss@buserror.net; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org; mark.rutland@arm.com;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> mturquette@baylibre.com; sboyd@kernel.org; rjw@rjwysocki.net;
> viresh.kumar@linaro.org; linux-clk@vger.kernel.org; linux-pm@vger.kernel.=
org;
> linux-kernel-owner@vger.kernel.org; catalin.marinas@arm.com;
> will.deacon@arm.com; gregkh@linuxfoundation.org; arnd@arndb.de;
> kstewart@linuxfoundation.org; yamada.masahiro@socionext.com; Leo Li
> <leoyang.li@nxp.com>; shawnguo@kernel.org
> Cc: ulf.hansson@linaro.org; Udit Kumar <udit.kumar@nxp.com>; Pankaj Bansa=
l
> <pankaj.bansal@nxp.com>; linux@armlinux.org.uk; adrian.hunter@intel.com;
> Varun Sethi <V.Sethi@nxp.com>; Vabhav Sharma <vabhav.sharma@nxp.com>;
> Yinbo Zhu <yinbo.zhu@nxp.com>
> Subject: [PATCH v7 2/6] soc/fsl/guts: Add definition for LX2160A
>=20
> Adding compatible string "lx2160a-dcfg" to initialize guts driver for lx2=
160 and
> SoC die attribute definition for LX2160A
>=20
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/soc/fsl/guts.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c index
> 302e0c8..bcab1ee 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -100,6 +100,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] =
=3D {
>  	  .svr		=3D 0x87000000,
>  	  .mask		=3D 0xfff70000,
>  	},
> +	/* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
> +	{ .die          =3D "LX2160A",
> +	  .svr          =3D 0x87360000,
Do all  the threevariants " LX2160A/LX2120A/LX2080A"  have same SVR?
> +	  .mask         =3D 0xff3f0000,
> +	},
>  	{ },
>  };
>=20
> @@ -222,6 +227,7 @@ static const struct of_device_id fsl_guts_of_match[] =
=3D {
>  	{ .compatible =3D "fsl,ls1088a-dcfg", },
>  	{ .compatible =3D "fsl,ls1012a-dcfg", },
>  	{ .compatible =3D "fsl,ls1046a-dcfg", },
> +	{ .compatible =3D "fsl,lx2160a-dcfg", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
> --
> 2.7.4
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists=
.infr
> adead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> kernel&amp;data=3D02%7C01%7Cpoonam.aggrwal%40nxp.com%7Cd9b7c36c786
> 54cd6dc4008d63d7fee63%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C636764017001504288&amp;sdata=3DpqFMlw6yVrHrvn4YRhqj%2FmoOnSscrZu
> tcoYn3In8OJc%3D&amp;reserved=3D0
