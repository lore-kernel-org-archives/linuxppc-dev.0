Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394B3C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 15:19:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7567D21871
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 15:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DzQPMAzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7567D21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WT2y3lDyzDqP0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 02:19:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.8.47; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=horia.geanta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="DzQPMAzc"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80047.outbound.protection.outlook.com [40.107.8.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WT1C4ydxzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jan 2019 02:17:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYKzSWSYwcftzoeOdqVyiFQ+oEhqpAgfvnV/vI0jHWo=;
 b=DzQPMAzcjZhxYejFEfSXxdIoD+AKxrc+LrN2i5OZ8TmQhGZTrRjwiychYuhdmrUNhfHwc8afe9sro04sV2xpSTXx7SLXYdA0Ej2UkaX6e5Jj+eABM2yiWkOu3XB+UP9XKFCqcWfSwao8TAXI1ZGFkDagTP1qM1TsPJzn//E8U5w=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3807.eurprd04.prod.outlook.com (52.134.16.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 4 Jan 2019 15:17:25 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::9c4e:17cb:deff:1c18]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::9c4e:17cb:deff:1c18%5]) with mapi id 15.20.1471.021; Fri, 4 Jan 2019
 15:17:25 +0000
From: Horia Geanta <horia.geanta@nxp.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3] crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK
Thread-Topic: [PATCH v3] crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK
Thread-Index: AQHUmQRIuiLMyqBCRUqtEmVYpQRHSQ==
Date: Fri, 4 Jan 2019 15:17:25 +0000
Message-ID: <VI1PR0402MB3485FC2A3758BCEAC05BF3A2988E0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <ae7b64e9415874060977e32ed48b62f1f6148084.1545346337.git.christophe.leroy@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB3807;
 6:R50IUijGmnRo9yM4b4OfTaMiWekpyGwLixKsZ4ZfbHnkqaQUA3ZinJStzVXLhjpy1lXB85fAGLbHu1ayin016Uu49Sga4AOqU/FPpPLhklmpnqVsGomPzdx6dmV4rZySHGC2o1WmrfMzxBm7U3VO5fKYmuAGiZub7I1Gj5jU6NlRTslzpGtE16JdXZk0lbaazMwhfaatrw9rJ48SJMSykXw9e4GDbUHpCxHeNRafeRkYgR6OOHzmVXj914wadzkau1n2CQzpv6KLN8oDd0fS28adm6pjXcfijG72+gY1oLw32otP4rtiupiswdkFD+DMp3DbLTuFsjt6WiaWtH5mjSn7WfUXJfyJ50t5OtJ+LvAR+jvp+x3mbzWjkAGDMxOSCdd2p/me+s06RIBvJq3Q8oS4KR51Y7pj0mCfIr/JLinsz5lrRmwcwj/00lrc4gXqNWhw/5z1J2S+UK3fB4D4OA==;
 5:iG56CrVDfjnl6LfkMcHPwB8j0jtHxnteHwNFcS6RqIErMdEh/IAmhrPwflEpgWqLzHAfqNRmvFq9VDEZKTfh1lu8po+fzJhxmbPAIlryTNAz1X1eKFUVLxoEAK5KOyvkwUl9oO2gMrh84lb6yketii+MGvxXIP9g++u/BD/kyVA=;
 7:kiM343ROrXlD9ceOZhyZA0hKgHscDVkuhccoyOtjGPSFZlncvNYuVMP4B39P7kOiAeDNB8e851SeVxu2QfH5QX5ops3C0/Qgl8o7xUxYIeuI7VY/H5js1yDCg/S/9dfBwRwd83sKb4yTBCRWyVpl5g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 765904e9-2f23-4f0d-f2fd-08d67257bbe5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3807; 
x-ms-traffictypediagnostic: VI1PR0402MB3807:
x-microsoft-antispam-prvs: <VI1PR0402MB3807B0E2FE738C038E96959B988E0@VI1PR0402MB3807.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0402MB3807; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB3807; 
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(189003)(199004)(33656002)(229853002)(478600001)(68736007)(3846002)(6116002)(6436002)(14454004)(305945005)(2906002)(9686003)(55016002)(53936002)(81156014)(81166006)(8936002)(7736002)(8676002)(106356001)(25786009)(4326008)(486006)(476003)(6246003)(105586002)(26005)(186003)(97736004)(71200400001)(71190400001)(446003)(74316002)(5660300001)(110136005)(316002)(54906003)(76176011)(575784001)(6506007)(86362001)(44832011)(99286004)(14444005)(53546011)(102836004)(256004)(7696005)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3807;
 H:VI1PR0402MB3485.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8CwyPvZXRzvWTuF0eKxn7WZtD9UOlwjz2M/oLk8/S3lCoxSBfxSGACeJfRGO1BzAx1rBJyfzKs/+2IHAALJNC3OzwkqefLReec4D8lIrHb3SzsrV3abBQJTOIEbnlaWBNqmlbcUszKudAkdIyN80z6I4HOSRiIaIam2glZk151KA8hyXN/aI0mQdSv4ANF83wL03CuKQeHEI4JnF4bmXvJnrTKe8MQCuHrkZZwjbMy9ZpuM14smT5T20GToVL+70Ihaq081SLykud1vnkZM67PDT9tOv98MQNiTrRGer+RbUF6ZknNGU28SXgDtqj/yI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765904e9-2f23-4f0d-f2fd-08d67257bbe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 15:17:25.8783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3807
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
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/21/2018 10:07 AM, Christophe Leroy wrote:=0A=
[snip]=0A=
> IV cannot be on stack when CONFIG_VMAP_STACK is selected because the stac=
k=0A=
> cannot be DMA mapped anymore.=0A=
> This looks better, thanks.=0A=
=0A=
> This patch copies the IV into the extended descriptor when iv is not=0A=
> a valid linear address.=0A=
> =0A=
Though I am not sure the checks in place are enough.=0A=
=0A=
> Fixes: 4de9d0b547b9 ("crypto: talitos - Add ablkcipher algorithms")=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>=0A=
> ---=0A=
>  v3: Using struct edesc buffer.=0A=
> =0A=
>  v2: Using per-request context.=0A=
[snip]=0A=
> +	if (ivsize && !virt_addr_valid(iv))=0A=
> +		alloc_len +=3D ivsize;=0A=
[snip]=0A=
>  =0A=
> +	if (ivsize && !virt_addr_valid(iv))=0A=
A more precise condition would be (!is_vmalloc_addr || is_vmalloc_addr(iv))=
=0A=
=0A=
It matches the checks in debug_dma_map_single() helper, though I am not sur=
e=0A=
they are enough to rule out all exceptions of DMA API.=0A=
=0A=
> +		iv =3D memcpy(((u8 *)edesc) + alloc_len - ivsize, iv, ivsize);=0A=
> +=0A=
>  	edesc->src_nents =3D src_nents;=0A=
>  	edesc->dst_nents =3D dst_nents;=0A=
> -	edesc->iv_dma =3D iv_dma;=0A=
> +	if (ivsize)=0A=
> +		edesc->iv_dma =3D dma_map_single(dev, iv, ivsize, DMA_TO_DEVICE);=0A=
> +	else=0A=
> +		edesc->iv_dma =3D 0;=0A=
> +=0A=
