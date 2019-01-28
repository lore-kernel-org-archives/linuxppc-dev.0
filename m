Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8947C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 14:38:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40B620880
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 14:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="IDvrmpbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40B620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pC0t2myCzDqLX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 01:38:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=infinera.com
 (client-ip=40.107.71.47; helo=nam05-by2-obe.outbound.protection.outlook.com;
 envelope-from=mathias.thore@infinera.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=infinera.com header.i=@infinera.com header.b="IDvrmpbe";
 dkim-atps=neutral
Received: from NAM05-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr710047.outbound.protection.outlook.com [40.107.71.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pBz30kMDzDqD1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 01:36:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AUy1Wqhe2ZmBbtokWNbY47VvTdNE4OPw1fX/zGn4Cg=;
 b=IDvrmpbeGq+Fjk73eK05fEjL8rx3IkcGm2f8p46YTG1DoyroN1M8R61EuWN0gE0OWTbt4hTqkMWWTcQFTNHCYT7bPLHtve6eAEDGt4/dl4GZut3g8rL5jXzuWgfsKJKHrRMtlnn/xBnU/KDBMWrX45++GBfWrG1UAdl+4cOTV7E=
Received: from DM6PR10MB3721.namprd10.prod.outlook.com (20.179.69.153) by
 DM6PR10MB2588.namprd10.prod.outlook.com (20.176.88.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Mon, 28 Jan 2019 14:36:42 +0000
Received: from DM6PR10MB3721.namprd10.prod.outlook.com
 ([fe80::dde5:6747:ecec:62b5]) by DM6PR10MB3721.namprd10.prod.outlook.com
 ([fe80::dde5:6747:ecec:62b5%4]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 14:36:42 +0000
From: Mathias Thore <Mathias.Thore@infinera.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, "leoyang.li@nxp.com"
 <leoyang.li@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, David
 Gounaris <David.Gounaris@infinera.com>, Joakim Tjernlund
 <Joakim.Tjernlund@infinera.com>
Subject: Re: [PATCH] ucc_geth: Reset BQL queue when stopping device
Thread-Topic: [PATCH] ucc_geth: Reset BQL queue when stopping device
Thread-Index: AQHUtuj3UNEzRrgKOUG24I15ihkwVKXEb4cAgABQNtU=
Date: Mon, 28 Jan 2019 14:36:41 +0000
Message-ID: <DM6PR10MB37217EA1DBEFE3D5CEB5A85084960@DM6PR10MB3721.namprd10.prod.outlook.com>
References: <20190128090747.15851-1-mathias.thore@infinera.com>,
 <6bc7e64a-b91a-cb6e-ed65-5e412cef3a76@c-s.fr>
In-Reply-To: <6bc7e64a-b91a-cb6e-ed65-5e412cef3a76@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Mathias.Thore@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM6PR10MB2588;
 6:bDlsqdGRoT1Mq1652ifeb9N7VXIQKcONs3VjYseOBypD/KhJ7z3Ys1NcBndJIeE9eeJyyKqyLz2TT1B2iPlLLZMNaFBLjGcupRZjlNc2H0O51Nt+sTHABRe3iVCv4rvG4uKwoq5KQRU3rwEs5XQjGjKQ2W6zobLmX5ClVRNm5t6pvcGVl/EH1mtOhm1K1Qs/UJ9gfiX03FxXtnRDbL/bJ1KIosCfRqRKOnTmL/YQuXmj9XApegddCX4ICwx+zNZ0lscRAhmRsgIFY/05GXVAJxZc1B0GMsaEAi2Q1ohNXOf+iNdCzMfqxvRd34IjQLvXb81LsnZ9S7x5S8ANvQZmDzw/LNAbGyEbYAnVmPMEM2fT4dC9RGrZBqQw+ri8uZsEL7UiyNPYANGjhBJXMGJz0eF+xhqLL+REsoskm7lndlOMsRifzWHPXFMLPX5RCUKpGJYxBhlJghGAXR87noHIAw==;
 5:Rgpg5iK97cp7vGVHJ+rgmUGeO5L9lSTmaPpQSqEKgrGZAeLOECB2Ays60z2Crsc/gb4oS7smUure9uBoIZ4l4HaFQ5wVlU+jDTUYH4gnLBYv3BYyhxI8hdMNkHxkg4QB8dwMcRKLXWKKY8F+h84RW0iXPrjkoAuuzG/2KSUW8YORXAK26724RZcJckfZ623IZ6+TbV9dOSys1kpA9RJU9g==;
 7:8Wbf9F1N1v/TT3/T75CH2+7EqtMVYKqiNtRoNmARp4c2+51GW2r497bzKbS2sOKkPDR5fUbHmexiPz7F2YI22BeMw3BhN5ZwoeTvbG1t2gV5ldMonbShZsFzFgAFE0MDWpAshewu0yyyHlDiooC+Hg==
x-ms-office365-filtering-correlation-id: e56fcb0f-d8a9-4056-b7ea-08d6852e051f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:DM6PR10MB2588; 
x-ms-traffictypediagnostic: DM6PR10MB2588:
x-microsoft-antispam-prvs: <DM6PR10MB2588E3215410C250765966D484960@DM6PR10MB2588.namprd10.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(2906002)(478600001)(74316002)(66066001)(7736002)(186003)(86362001)(53936002)(2201001)(81156014)(305945005)(105586002)(97736004)(25786009)(316002)(9686003)(106356001)(8936002)(102836004)(446003)(229853002)(14454004)(72206003)(8676002)(486006)(81166006)(110136005)(6636002)(99286004)(3846002)(6116002)(6246003)(7696005)(26005)(76176011)(11346002)(476003)(256004)(5024004)(6436002)(55016002)(6506007)(66574012)(68736007)(33656002)(2501003)(71190400001)(53546011)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR10MB2588;
 H:DM6PR10MB3721.namprd10.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gs+erHLR9FGa1mzxx6/tL6k1tnYjqFMy6Y+QAohwe/Slz45Qe2ucAdRGliLzJLABsAxtfpre9+/4bbwxTH34A1xuZmUong13v9EWwXrF8ftb3WYG4CUei9QF45eMT9symbmUx7phfpedeA7MAYXq8Spswk1r713vvSYLpVIadBab8ja2entExDLnGq2WA6ioEpcYX+2s9ss7d2zVUruL31DVNjH+PO5bOb+KfCjUp8+lg5wjG7Y0i608xbOwOHxku3GFNOmzsracgr+4kJD3ZMiQ7hsl7u3tcBgfcuH52gxg9Fcdb8sXOCLaXqBNcZaXMPRBlsudW233Z2xMwG3oXmfXYBZkRZqj4NCTQBhuzPyKzlUM8qJkIW+p2ZsTH766jGXWtxUUOclli42i5hAzW9cEU3I0J8zC/BMwBlWR0nU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56fcb0f-d8a9-4056-b7ea-08d6852e051f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 14:36:41.9437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2588
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,


This is what we observed: there was a storm on the medium so that our contr=
oller could not do its TX, resulting in timeout. When timeout occurs, the d=
river clears all descriptors from the TX queue. The function called in this=
 patch is used to reflect this clearing also in the BQL layer. Without it, =
the controller would get stuck, unable to perform TX, even several minutes =
after the storm had ended. Bringing the device down and then up again would=
 solve the problem, but this patch also solves it automatically.


Some other drivers do the same, for example e1000e driver calls netdev_rese=
t_queue in its e1000_clean_tx_ring function. It is possible that other driv=
ers should do the same; I have no way of verifying this.


Regards,

Mathias

--


From: Christophe Leroy <christophe.leroy@c-s.fr>
Sent: Monday, January 28, 2019 10:48 AM
To: Mathias Thore; leoyang.li@nxp.com; netdev@vger.kernel.org; linuxppc-dev=
@lists.ozlabs.org; David Gounaris; Joakim Tjernlund
Subject: Re: [PATCH] ucc_geth: Reset BQL queue when stopping device
=A0=20

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.


Hi,

Le 28/01/2019 =E0 10:07, Mathias Thore a =E9crit :
> After a timeout event caused by for example a broadcast storm, when
> the MAC and PHY are reset, the BQL TX queue needs to be reset as
> well. Otherwise, the device will exhibit severe performance issues
> even after the storm has ended.

What are the symptomns ?

Is this reset needed on any network driver in that case, or is it
something particular for the ucc_geth ?
For instance, the freescale fs_enet doesn't have that reset. Should it
have it too ?

Christophe

>
> Co-authored-by: David Gounaris <david.gounaris@infinera.com>
> Signed-off-by: Mathias Thore <mathias.thore@infinera.com>
> ---
>=A0=A0 drivers/net/ethernet/freescale/ucc_geth.c | 2 ++
>=A0=A0 1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethe=
rnet/freescale/ucc_geth.c
> index c3d539e209ed..eb3e65e8868f 100644
> --- a/drivers/net/ethernet/freescale/ucc_geth.c
> +++ b/drivers/net/ethernet/freescale/ucc_geth.c
> @@ -1879,6 +1879,8 @@ static void ucc_geth_free_tx(struct ucc_geth_privat=
e *ugeth)
>=A0=A0=A0=A0=A0=A0 u16 i, j;
>=A0=A0=A0=A0=A0=A0 u8 __iomem *bd;
>
> +=A0=A0=A0=A0 netdev_reset_queue(ugeth->ndev);
> +
>=A0=A0=A0=A0=A0=A0 ug_info =3D ugeth->ug_info;
>=A0=A0=A0=A0=A0=A0 uf_info =3D &ug_info->uf_info;
>
>
    =
