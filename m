Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFC0C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 06:49:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F9F218D9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 06:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AzJS5zy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F9F218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448RBV4PhtzDqP9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 17:49:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.4.77; helo=eur03-db5-obe.outbound.protection.outlook.com;
 envelope-from=diana.craciun@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="AzJS5zy+"; 
 dkim-atps=neutral
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40077.outbound.protection.outlook.com [40.107.4.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448R8Q6cpSzDqJK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 17:48:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiChuE7AVX3zqnTlq0dyupDVP7HfSZWJWmFdiY2xmW0=;
 b=AzJS5zy+k7q5sCvtRiSwN5n5n/p5GZHaFbxgaGZ8Cyhbmhqa5DNR0hiHT3qvS216/EialMW7fMFOaGYEth5vuFufoz9TFkLxah9DuUdjmgRMSipeU7LdLUnCmslJsCqPFkQ+IQffSxPVHcEvg0UFU5pDC44nJ4cYkuJVvOX7cFs=
Received: from VI1PR0401MB2463.eurprd04.prod.outlook.com (10.168.64.146) by
 VI1PR0401MB2256.eurprd04.prod.outlook.com (10.169.133.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 27 Feb 2019 06:47:59 +0000
Received: from VI1PR0401MB2463.eurprd04.prod.outlook.com
 ([fe80::54d1:19d2:40bb:2ffa]) by VI1PR0401MB2463.eurprd04.prod.outlook.com
 ([fe80::54d1:19d2:40bb:2ffa%2]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 06:47:59 +0000
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/fsl: Fix the flush of branch predictor.
Thread-Topic: [PATCH] powerpc/fsl: Fix the flush of branch predictor.
Thread-Index: AQHUzf+5VIZw7d5mQk2/6tvrH4vMMg==
Date: Wed, 27 Feb 2019 06:47:59 +0000
Message-ID: <VI1PR0401MB2463466309756C7D038F0DB7FF740@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <dccb392cd3e2b1825608576ecf2487cc5d84466d.1551205086.git.christophe.leroy@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=diana.craciun@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b633792-5fb6-4b0e-9960-08d69c7f8342
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2256; 
x-ms-traffictypediagnostic: VI1PR0401MB2256:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; VI1PR0401MB2256;
 23:UA7MIKpEsH/6fzHrJikZCTm/rDeZxF7TLfBFe1p?=
 =?us-ascii?Q?0o4HIDAHOB1tALjGsfnc34Q7GENToOEMhaiwqz5qyfoevmSa1txO39s7/ajy?=
 =?us-ascii?Q?PkGe1wE4daOIn1DRuSB4Y2/FiNXeM04a4sGgrE5qpL6iETHiSPfBqZvj0v+G?=
 =?us-ascii?Q?6aX9OzTQIFJRG+a1X2ArP1250f/U5m3MRCixti/FfRcn9dTJx2FZUUjhrWkf?=
 =?us-ascii?Q?ckNNAzJ64SHQJj0o89ph4MB/C5uo81cmh6BYTedcJJqCi+ZBlrod2tFnXhxd?=
 =?us-ascii?Q?YqTaJ31xPAbYnP/hcImN2Z2dXPgsboYP9oDGT3Dcc25FHBMokIGAK60wkFlC?=
 =?us-ascii?Q?DaBpAWrAaXEnquxqyngfnMJK33Lv7o/y9dnCoAgyey2Bj5BAJ1wa71wp1KqW?=
 =?us-ascii?Q?AxIWYLCdi4QxZFyRXmeewdaIH23ss12G38J5Z+Pfod5EMkcE8Cu9DY/ARqwd?=
 =?us-ascii?Q?zqqU2qTXsFF1hytcQ+97YNmPYdrg1PT4uplQm4Z6r8dqkbbPpOXYbh6zLRO9?=
 =?us-ascii?Q?FPH5BLFOCi6IPEvm91cM44A+4kN9KVAdCZEQK1ueE4kNxMkqpBljEdMYpvMT?=
 =?us-ascii?Q?M/jesPt3flqssnFJCqp4pKFN8tcEyPEEFBBK0InP3q/XuWDJXBdhKINLd2oE?=
 =?us-ascii?Q?K1Qcs/bjaaYx9F8XlyHGUr8EJuWikirOcvw2gtClOC7ouEMwpL3HcFplKDZ5?=
 =?us-ascii?Q?dvlf5FxqirqaSOl6gXlcLkwlMZzIK/lg+HqV1i+BrCmF7x+0CkmeDXUEwQh4?=
 =?us-ascii?Q?CJToPPIB3A401mpM3s8ERzle0nLx+yOz3ZmSr4loO6outH7xAlzeLHGJboA4?=
 =?us-ascii?Q?GeBA/FmRgaZGyp6C2loBNOaJj+6dDsGNgR+9rFKZnQ67D+jF0j7TEy8SqpSb?=
 =?us-ascii?Q?SupwVwIeC0gT47o6t1NqobpjL2qk4A/rGi6/jRAE+rTLJ9HpcqGU7W4Iarj3?=
 =?us-ascii?Q?w82WvdUDApm5KMBkJIVl5FCAEjAIc0aiDTclkLsY8tXY39R2PIDEIyivoWJ6?=
 =?us-ascii?Q?TTPGvNretFXe/LiLYvLAY4bVGhk6TJwySqWtJ3T3tHtqo9gaMeyf2VBJz02R?=
 =?us-ascii?Q?U8JVpDHuQVcCQ5oxCYG0z2JPe/HlhGDDzDKYAQxhyFGKuQwIDhEbCnx+LAFC?=
 =?us-ascii?Q?N2RO2YRwcGny1JAcooIopqslpNpqtZcG/9xi6SB6YdaREyPvO07af6bwwWCT?=
 =?us-ascii?Q?0OYiN7LG8+wVZ1wOGoXNILP+LiMizzAfU4j/aeH8uxC2ZRdVJq2SKtOR/iw?=
 =?us-ascii?Q?=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR0401MB22560FDE8C10E2CC0DE7292BFF740@VI1PR0401MB2256.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(136003)(39860400002)(376002)(366004)(189003)(199004)(26005)(476003)(446003)(486006)(6436002)(33656002)(99286004)(229853002)(7736002)(8936002)(256004)(66066001)(7696005)(8676002)(76176011)(102836004)(2906002)(81166006)(53546011)(6506007)(81156014)(68736007)(97736004)(106356001)(74316002)(305945005)(105586002)(6116002)(316002)(14454004)(3846002)(9686003)(86362001)(55016002)(478600001)(5660300002)(54906003)(53936002)(52536013)(71200400001)(110136005)(4326008)(186003)(71190400001)(6246003)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2256;
 H:VI1PR0401MB2463.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mZCfhNYTRVsoA0e2GEoqXvPIxpwh+dPdGW7qD+y9idiS1EhaFAw/7QRkROmdPbtqCQtW5ZVouIpiOBUN/LawYRaEphAStyTHZiFTo9ALk9//cFkpNl/VCJzqyt85tSdBzw/iZ4wstlEmSRkFvm8HCWcetjJLQpIcd4k0LANHd12owKYaYnSyNSJlwusmcAzOIFgd0di6KdYVSWIH9ub2QOGVX9JOP5d3cwEmyWXKXjmiP5ZCzO5Dy2ooTjIuKoIGWyQWEdmZnpdwROogvZHa3sCt2+9Zda9P+Ylqx3/bWxgkowyTPzWONXxnfC4H2tIsUIY3Oa9cuAv5FmEJaBEE6+GbBTLg8fdAW3Jw8dFPzpHbCTJWw6a/qoUtI/URZOvVq9CfTem78Z/4l6o5AcU3ICfoe9isG4OqD2rcUgAvW9Y=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b633792-5fb6-4b0e-9960-08d69c7f8342
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 06:47:59.5462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2256
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

Reviewed-by: Diana Craciun <diana.craciun@nxp.com>=0A=
=0A=
Thanks for fixing it!=0A=
=0A=
On 2/26/2019 8:18 PM, Christophe Leroy wrote:=0A=
> The commit identified below adds MC_BTB_FLUSH macro only when=0A=
> CONFIG_PPC_FSL_BOOK3E is defined. This results in the following error=0A=
> on some configs (seen several times with kisskb randconfig_defconfig)=0A=
>=0A=
> arch/powerpc/kernel/exceptions-64e.S:576: Error: Unrecognized opcode: `mc=
_btb_flush'=0A=
> make[3]: *** [scripts/Makefile.build:367: arch/powerpc/kernel/exceptions-=
64e.o] Error 1=0A=
> make[2]: *** [scripts/Makefile.build:492: arch/powerpc/kernel] Error 2=0A=
> make[1]: *** [Makefile:1043: arch/powerpc] Error 2=0A=
> make: *** [Makefile:152: sub-make] Error 2=0A=
>=0A=
> This patch adds a blank definition of MC_BTB_FLUSH for other cases.=0A=
>=0A=
> Fixes: 10c5e83afd4a ("powerpc/fsl: Flush the branch predictor at each ker=
nel entry (64bit)")=0A=
> Cc: Diana Craciun <diana.craciun@nxp.com>=0A=
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>=0A=
> ---=0A=
>  arch/powerpc/kernel/exceptions-64e.S | 1 +=0A=
>  1 file changed, 1 insertion(+)=0A=
>=0A=
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/e=
xceptions-64e.S=0A=
> index 4549ce8d4637..49381f32b374 100644=0A=
> --- a/arch/powerpc/kernel/exceptions-64e.S=0A=
> +++ b/arch/powerpc/kernel/exceptions-64e.S=0A=
> @@ -338,6 +338,7 @@ ret_from_mc_except:=0A=
>  #define GEN_BTB_FLUSH=0A=
>  #define CRIT_BTB_FLUSH=0A=
>  #define DBG_BTB_FLUSH=0A=
> +#define MC_BTB_FLUSH=0A=
>  #define GDBELL_BTB_FLUSH=0A=
>  #endif=0A=
>  =0A=
=0A=
=0A=
