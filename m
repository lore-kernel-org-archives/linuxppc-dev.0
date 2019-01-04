Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E1AC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 15:26:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4982921872
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 15:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q2fjgcys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4982921872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WTCN0YZwzDqNl
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 02:26:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.73; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=horia.geanta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="Q2fjgcys"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150073.outbound.protection.outlook.com [40.107.15.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WT9c4hgpzDqCH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jan 2019 02:24:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRAkauuwKhKRsyCvAGyydscEgrMcKGndbNeZuDPWp/o=;
 b=Q2fjgcysLFF06VTsMmK5UAVWIUfCpef33B8GUh82qprAbNsTKlXMzsqRSVuNBs5sd0cQ+w7lqRRwKJjBr3B3EeOWC298FGtQLN/RS+gATvyQRsgOYtev9lsCAYNhTOl/saWY64FCWThexo7GEwqrf1KhjlTGdPdZwbImAplNTWo=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3583.eurprd04.prod.outlook.com (52.134.4.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 4 Jan 2019 15:24:44 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::9c4e:17cb:deff:1c18]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::9c4e:17cb:deff:1c18%5]) with mapi id 15.20.1471.021; Fri, 4 Jan 2019
 15:24:44 +0000
From: Horia Geanta <horia.geanta@nxp.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3] crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK
Thread-Topic: [PATCH v3] crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK
Thread-Index: AQHUmQRIuiLMyqBCRUqtEmVYpQRHSQ==
Date: Fri, 4 Jan 2019 15:24:44 +0000
Message-ID: <VI1PR0402MB34853754B8F90F5904710526988E0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <ae7b64e9415874060977e32ed48b62f1f6148084.1545346337.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB3485FC2A3758BCEAC05BF3A2988E0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB3583;
 6:m7qzugfOKoXqMcHn1fnVyBi7yuqP96X5rJcJnq8HTPJK5xhdgCB8CzpdKBj6sR4GYHamf2ucDjSf3C6zkG7cldD1at8qRuP6QpxEL+SOPsql/VclXkSfGSuc/Ea/jdrU5vgMMdgvflHm5zMMF5mxRgPAe7QOtDxHGYHyjWtWGWap2wmJMLnX5O8MOxYW2nsgwTmDpdKtZ+qyy7WTuZ+9qwjxoNyOAat38eTnUaK3lJmLVl4MrmFmjTbwIiaouDW/ULsiFt4wex8kubj9p6kczM24k9RFogUKHojZpKkh659kPKxvt/Ox+3PdMWNM63u7omUz5NiNUah6pKCCMnnUUjy1NXrywvBgJ2kcPkZ31SnWG0i2RXf4RVe+D/C4Ws4DLlDOJwmhp86UCjGRPG+E7i+QiMiTL6mNsFRVAZdJ2XSUXok8hDauNZI8ZlknsaVDHipK2DhdzutWW9xjQNAX9w==;
 5:4OFEDb1AVTKUl1nvDLP7W3pWNQxRtQtqMs/YoUED+XVcYNUzgaEmbxri++IuW3IUsw/QnhBjjrYCMbt0VRBTP2hng7hq1z8qAQAEgWFSf7hHfA+portR+lQbED2F3wCqy17bXmYkiMesTtw7GwHp0/HXNPxgoAuKewsEkIQoDto=;
 7:LTvDiuJmSVPOS9qC0MhXxvIkzH9d82mwO8Fh+enRT1IHWMvDstIqxt5SwIdGQQzzLo+4mDvmeUKj3ggLnchMeaSoiph6uzqbM/BLWdq9qzk98I4S4vv9uZy5VPjQqXZqO10jiz9pRXb8oiUUbAeDFQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e749cfab-8e75-4a22-97d8-08d67258c167
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3583; 
x-ms-traffictypediagnostic: VI1PR0402MB3583:
x-microsoft-antispam-prvs: <VI1PR0402MB3583CB5DC71443367BD59058988E0@VI1PR0402MB3583.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0402MB3583; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB3583; 
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(366004)(396003)(376002)(39860400002)(189003)(199004)(106356001)(8676002)(575784001)(86362001)(476003)(8936002)(68736007)(446003)(81156014)(105586002)(93156006)(6436002)(54906003)(229853002)(81166006)(110136005)(99286004)(74316002)(316002)(71190400001)(71200400001)(7736002)(53936002)(33656002)(6246003)(9686003)(55016002)(3846002)(6116002)(5660300001)(97736004)(25786009)(256004)(14444005)(4326008)(14454004)(478600001)(26005)(305945005)(53546011)(6506007)(2906002)(44832011)(7696005)(186003)(102836004)(486006)(76176011)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3583;
 H:VI1PR0402MB3485.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xncqkIBm9nKF2+IysfBcqBnQMAZ3Ot7y8IOTnRr4ayQD07Dbt9XbpkYKv9vYi8RLGehE95ULxDrOq7CmXr5kD3d4vL/couxduBa0hwiZmjKUvAwp9pwngJM/n5MQ0wh+3zC1hFGx/wUZ3x5lkeTdXnGvzFdgadXq7ZVb6mznpqIu6D84j3JjNwhVnjW/MGOXCrbR/Rxm+mlsnJlnUDrnxi+FhduNgaimVzSnR3jpuV1L+gIuLGV41J2sQHoQzb2wUw8HcmhfxduUU/5+9C0lB6IviRc9UpnbM4cSFO/ooZkFgfHxKCXIH5Knmm3g7jfT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e749cfab-8e75-4a22-97d8-08d67258c167
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 15:24:44.5813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3583
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

On 1/4/2019 5:17 PM, Horia Geanta wrote:=0A=
> On 12/21/2018 10:07 AM, Christophe Leroy wrote:=0A=
> [snip]=0A=
>> IV cannot be on stack when CONFIG_VMAP_STACK is selected because the sta=
ck=0A=
>> cannot be DMA mapped anymore.=0A=
>> This looks better, thanks.=0A=
> =0A=
>> This patch copies the IV into the extended descriptor when iv is not=0A=
>> a valid linear address.=0A=
>>=0A=
> Though I am not sure the checks in place are enough.=0A=
> =0A=
>> Fixes: 4de9d0b547b9 ("crypto: talitos - Add ablkcipher algorithms")=0A=
>> Cc: stable@vger.kernel.org=0A=
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>=0A=
>> ---=0A=
>>  v3: Using struct edesc buffer.=0A=
>>=0A=
>>  v2: Using per-request context.=0A=
> [snip]=0A=
>> +	if (ivsize && !virt_addr_valid(iv))=0A=
>> +		alloc_len +=3D ivsize;=0A=
> [snip]=0A=
>>  =0A=
>> +	if (ivsize && !virt_addr_valid(iv))=0A=
> A more precise condition would be (!is_vmalloc_addr || is_vmalloc_addr(iv=
))=0A=
>=0A=
Sorry for the typo, I meant:=0A=
(!virt_addr_valid(iv) || is_vmalloc_addr(iv))=0A=
=0A=
> It matches the checks in debug_dma_map_single() helper, though I am not s=
ure=0A=
> they are enough to rule out all exceptions of DMA API.=0A=
