Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017D1C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 10:02:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C852218B0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 10:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RuvUO580"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C852218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Q2Pw0dR2zDqS0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 21:01:56 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Q2MX41zWzDqQL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 20:59:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="RuvUO580"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Q2MX1kyPz8tC1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 20:59:52 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Q2MX195Sz9sRG; Thu, 21 Mar 2019 20:59:52 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.8.45; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=diana.craciun@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="RuvUO580"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80045.outbound.protection.outlook.com [40.107.8.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Q2MW4kNPz9sR0
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Mar 2019 20:59:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVwvLWb5SGcyFX/R/n+YxDAub8LdZ4Cfdenk2oX8/mI=;
 b=RuvUO580CW1serjrgi/Qbgll20XPZ9xT+kSuUnCX8d2kr3FfJ6a83X7k3WzC1Z1sLjNb3izC4k7oIG60yfoRWnMqYEWlOhEnVNYQwW8Jdm8mqz4+RSK0IJbo0PGxy3IWmnJGbJ9zmtdy6AiQ7G+SWY1mVx1zQa7lt7gEw9CfTnU=
Received: from VI1PR0401MB2463.eurprd04.prod.outlook.com (10.168.64.146) by
 VI1PR0401MB2447.eurprd04.prod.outlook.com (10.168.64.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Thu, 21 Mar 2019 09:59:40 +0000
Received: from VI1PR0401MB2463.eurprd04.prod.outlook.com
 ([fe80::f0ff:e4cf:6d0d:ea88]) by VI1PR0401MB2463.eurprd04.prod.outlook.com
 ([fe80::f0ff:e4cf:6d0d:ea88%3]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 09:59:40 +0000
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc/security: Fix spectre_v2 reporting
Thread-Topic: [PATCH] powerpc/security: Fix spectre_v2 reporting
Thread-Index: AQHU354JJdCj+7cM80Sl+e4QIsK12Q==
Date: Thu, 21 Mar 2019 09:59:40 +0000
Message-ID: <VI1PR0401MB2463B217338C6F7CFDEB74EBFF420@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <20190321042433.20454-1-mpe@ellerman.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=diana.craciun@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 084962ca-5a74-4c34-ab94-08d6ade3ef76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2447; 
x-ms-traffictypediagnostic: VI1PR0401MB2447:
x-microsoft-antispam-prvs: <VI1PR0401MB2447788D43422E214EA8C7D8FF420@VI1PR0401MB2447.eurprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(6116002)(3846002)(476003)(99286004)(97736004)(2906002)(52536014)(25786009)(14454004)(5660300002)(74316002)(106356001)(110136005)(446003)(486006)(316002)(105586002)(478600001)(54906003)(7736002)(229853002)(71190400001)(86362001)(15650500001)(71200400001)(53936002)(102836004)(14444005)(256004)(55016002)(6506007)(7696005)(53546011)(9686003)(76176011)(81166006)(8936002)(305945005)(8676002)(6436002)(68736007)(81156014)(4326008)(66066001)(33656002)(6246003)(2501003)(186003)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2447;
 H:VI1PR0401MB2463.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:3; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tXg1f4WKQ41XM99yVMphXsPnwcMDwBoZRuFC3mYhB7OZr9liilYBnzhhyczoGrvtXDFzsmJT1LgdPyezO587kil3BKY/ZgMxezSlOpm+im40zh/QbeyFHXkTL4NM7x8LSCjIHxRIe7YZ+sAoTMIf3c1roJaJ2HWAmFg39uB6yORdFDClf23EA5epJJ1m5LGzRjNaaGIAhDFfWGDRtV/2oaXkl1Rle2qAXiD0qwL2BxvYVVNeZch9y0pgNLYwbePFaoEj3rM78Dp1kNbhdFETx9Ij1BpNREY7juVQ8mC9ilGDUl9StmzzngzCTeDr4Y/ep0b3lrZrfIkL7ECJv0F44SSgS1cSrCCeidtvDmPQJpoyDq6Tp/dMj+Mvyb9+ahJy4KfVieUzZxomKw+WSks3+hwiElEtbm1ijgYVaMbLElI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084962ca-5a74-4c34-ab94-08d6ade3ef76
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 09:59:40.4285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2447
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
Cc: "mikey@neuling.org" <mikey@neuling.org>,
 "msuchanek@suse.de" <msuchanek@suse.de>,
 "andrew.donnellan@au1.ibm.com" <andrew.donnellan@au1.ibm.com>,
 "dja@axtens.net" <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Reviewed-by: Diana Craciun <diana.craciun@nxp.com>=0A=
=0A=
On 3/21/2019 6:24 AM, Michael Ellerman wrote:=0A=
> When I updated the spectre_v2 reporting to handle software count cache=0A=
> flush I got the logic wrong when there's no software count cache=0A=
> enabled at all.=0A=
>=0A=
> The result is that on systems with the software count cache flush=0A=
> disabled we print:=0A=
>=0A=
>   Mitigation: Indirect branch cache disabled, Software count cache flush=
=0A=
>=0A=
> Which correctly indicates that the count cache is disabled, but=0A=
> incorrectly says the software count cache flush is enabled.=0A=
>=0A=
> The root of the problem is that we are trying to handle all=0A=
> combinations of options. But we know now that we only expect to see=0A=
> the software count cache flush enabled if the other options are false.=0A=
>=0A=
> So split the two cases, which simplifies the logic and fixes the bug.=0A=
> We were also missing a space before "(hardware accelerated)".=0A=
>=0A=
> The result is we see one of:=0A=
>=0A=
>   Mitigation: Indirect branch serialisation (kernel only)=0A=
>   Mitigation: Indirect branch cache disabled=0A=
>   Mitigation: Software count cache flush=0A=
>   Mitigation: Software count cache flush (hardware accelerated)=0A=
>=0A=
> Fixes: ee13cb249fab ("powerpc/64s: Add support for software count cache f=
lush")=0A=
> Cc: stable@vger.kernel.org # v4.19+=0A=
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>=0A=
> ---=0A=
>  arch/powerpc/kernel/security.c | 23 ++++++++---------------=0A=
>  1 file changed, 8 insertions(+), 15 deletions(-)=0A=
>=0A=
> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/securit=
y.c=0A=
> index 9b8631533e02..b33bafb8fcea 100644=0A=
> --- a/arch/powerpc/kernel/security.c=0A=
> +++ b/arch/powerpc/kernel/security.c=0A=
> @@ -190,29 +190,22 @@ ssize_t cpu_show_spectre_v2(struct device *dev, str=
uct device_attribute *attr, c=0A=
>  	bcs =3D security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);=0A=
>  	ccd =3D security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);=0A=
>  =0A=
> -	if (bcs || ccd || count_cache_flush_type !=3D COUNT_CACHE_FLUSH_NONE) {=
=0A=
> -		bool comma =3D false;=0A=
> +	if (bcs || ccd) {=0A=
>  		seq_buf_printf(&s, "Mitigation: ");=0A=
>  =0A=
> -		if (bcs) {=0A=
> +		if (bcs)=0A=
>  			seq_buf_printf(&s, "Indirect branch serialisation (kernel only)");=0A=
> -			comma =3D true;=0A=
> -		}=0A=
>  =0A=
> -		if (ccd) {=0A=
> -			if (comma)=0A=
> -				seq_buf_printf(&s, ", ");=0A=
> -			seq_buf_printf(&s, "Indirect branch cache disabled");=0A=
> -			comma =3D true;=0A=
> -		}=0A=
> -=0A=
> -		if (comma)=0A=
> +		if (bcs && ccd)=0A=
>  			seq_buf_printf(&s, ", ");=0A=
>  =0A=
> -		seq_buf_printf(&s, "Software count cache flush");=0A=
> +		if (ccd)=0A=
> +			seq_buf_printf(&s, "Indirect branch cache disabled");=0A=
> +	} else if (count_cache_flush_type !=3D COUNT_CACHE_FLUSH_NONE) {=0A=
> +		seq_buf_printf(&s, "Mitigation: Software count cache flush");=0A=
>  =0A=
>  		if (count_cache_flush_type =3D=3D COUNT_CACHE_FLUSH_HW)=0A=
> -			seq_buf_printf(&s, "(hardware accelerated)");=0A=
> +			seq_buf_printf(&s, " (hardware accelerated)");=0A=
>  	} else if (btb_flush_enabled) {=0A=
>  		seq_buf_printf(&s, "Mitigation: Branch predictor state flush");=0A=
>  	} else {=0A=
=0A=
=0A=
