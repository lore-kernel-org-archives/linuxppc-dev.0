Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2511CC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:49:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8413820827
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XdzN13vG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8413820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YnXf2djVzDqS4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 20:49:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.1.49; helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=horia.geanta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="XdzN13vG"; 
 dkim-atps=neutral
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10049.outbound.protection.outlook.com [40.107.1.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YnVg3x12zDqF0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 20:47:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On8ICrgJkbEUzsxeC2y8dv7ul6hjSiKkbX6E5QOEi4g=;
 b=XdzN13vGOrEoCWZcBDOwH+VIpKrKeL23f53OjduljsT8L/ts6aHUopaFVmvPlDi+PhNOVojI/cdveS19W82iOHD9TCL5jDmzYRHozUkuMiGkBZRNi9LRgURgPS7YH3GM6wSbjy8vciUHdpXNNez1bHY+EAtAZfMFMtkuEDyckok=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3824.eurprd04.prod.outlook.com (52.134.16.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.10; Tue, 8 Jan 2019 09:47:31 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::9c4e:17cb:deff:1c18]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::9c4e:17cb:deff:1c18%5]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 09:47:31 +0000
From: Horia Geanta <horia.geanta@nxp.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 1/2] crypto: talitos - reorder code in
 talitos_edesc_alloc()
Thread-Topic: [PATCH v4 1/2] crypto: talitos - reorder code in
 talitos_edesc_alloc()
Thread-Index: AQHUpx9U2UgnBhsXrEyEQzxfOR/K1Q==
Date: Tue, 8 Jan 2019 09:47:30 +0000
Message-ID: <VI1PR0402MB3485608DF1B37BB7C740DD36988A0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <5ed91db5e2976a4c260465c3d027acc9affd2d2b.1545445924.git.christophe.leroy@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB3824;
 6:NJQ4MHmnPQVX4tYi727ZGWzyzWhbDCDZ8L0695zFx8MWsdIc19vldXXOnkrOfDTL0QaKbGtOXYJNaL1ffrxmiHWu+l2vOdASJK3TsJHgGD1y4LYbAqMeY5OSOaFQuJRTuBSIYyg5ZD3WehH5m9hrzZrY7aABWVeDiQVXF8oSN9ZRAQAUsxKQDOX/4UfDsWSbZrCGYAPzwxzcP2yfkRowW5X847/AOWKbloIkV6k+32qh2ra5SfkNR5GP6ukDyXMD+g3KkbU4dygE2tg3B9XbQ2yFQXxTug52n7AIZl/1dsj12gMWp4ZlQ7MSFjh/NBEyul+o/lEUR44FkFvQaMEdj9EOzCrlSd3SIA8MxWUIqYv2XlQkVVgHbUUw7ZqFL5buIds8EWllwqfPHLUvwpBWCUSLHYjB61BykSrbb1Tn2HzT/gqvnRiDv+ReYjzqUo0p9XEUY8B9MkeW+PBi8WH2Mg==;
 5:+F3UBqXWpkzvkDF5m99U8xfiZOVEAylwwGala5e/sunVf8QoQh187v1V9OzhOSTB9J9Ka6ntqHDr5Vqiu+ncoojSRM5lQaA7IaS3xcV4x6/z3yYNOanVhRCToe6D9Y8vvvl6+a8+p8q+bTBOMc4V0hLdl/PSDLp9WpsRY3Kvt6y2PaUeqvmi+8bZ5OJi2gerG9MW4K0tasQzmjic2COZnw==;
 7:WJjRLxP1O8Sac/8ey5yPazefcIZhQJL6xYZRHKpdZfA4CvGeBL9sSKsMQRF+YEf2/CYw4DPtZayFtnung/De4okvn9Lb2qWF1vU+cVaO57ptLxEfBMBWltc6D/WilIityDeu4uyxPyWwY6GXk8+lTg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a845eab7-56a0-4c0a-a156-08d6754e4edc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3824; 
x-ms-traffictypediagnostic: VI1PR0402MB3824:
x-microsoft-antispam-prvs: <VI1PR0402MB38241F192714F82D7A846FD4988A0@VI1PR0402MB3824.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0402MB3824; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB3824; 
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(396003)(366004)(136003)(346002)(189003)(199004)(55016002)(5660300001)(102836004)(486006)(110136005)(229853002)(97736004)(54906003)(7696005)(74316002)(186003)(6506007)(53546011)(68736007)(99286004)(86362001)(316002)(71200400001)(71190400001)(6436002)(3846002)(76176011)(81156014)(8936002)(8676002)(106356001)(476003)(81166006)(14454004)(33656002)(256004)(2906002)(478600001)(446003)(105586002)(6246003)(6116002)(26005)(9686003)(44832011)(4326008)(53936002)(25786009)(66066001)(305945005)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3824;
 H:VI1PR0402MB3485.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BLApUqWy8m3W6PslOiuj23CSxFxMQvNNej/yFizX1mxos3d9OR62wKGgV5lYanmXqHdUywErv/FAlMEHeALdPQUnMLyTj6iGkUbrUV76ndx2wAYNxWI/KoImciC66DmWDPibfOviestasHNwPzc5O4tEMt7EoQys9wmY3kTCaVg9sLZbiQaLm8+VPbo+hsWpINJaukFiF5mi+0ckXQL1+4C9jbYIOvfdStk9t89s+9aMraDzVdw4cen/lDJe7xU6/bqNAAOe0N8vlc4fbFGaJytNNA1/AXvUb1fJQxi8zSy7kpCuqYVXHOB6Fg/V20q1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a845eab7-56a0-4c0a-a156-08d6754e4edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:47:30.9534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3824
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
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/8/2019 8:56 AM, Christophe Leroy wrote:=0A=
> This patch moves the mapping of IV after the kmalloc(). This=0A=
> avoids having to unmap in case kmalloc() fails.=0A=
> =0A=
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>=0A=
Reviewed-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
=0A=
Since patch 2/2 is Cc-ing stable, this one should do the same.=0A=
Herbert, could you append the commit message before applying it?=0A=
=0A=
Thanks,=0A=
Horia=0A=
