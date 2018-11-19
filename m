Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C30C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 07:13:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8DC32086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 07:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WvG07yuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DC32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42z0Rt4XRnzF3RK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 18:13:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="WvG07yuQ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.2.70; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=madalin.bucur@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="WvG07yuQ"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20070.outbound.protection.outlook.com [40.107.2.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42z0P92lbDzF3R7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 18:11:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pqJmDXhKcfcw5q3BcuWv6cxkyhnHnb2X+/J1Mnk/kY=;
 b=WvG07yuQfJPtepwRQ2SX1NvwhpHhgKv36OcZL4qHk+vK0cwBRtHl/E8BmoGXSeIvwwC3ENNV0YP5c7SvOlqtQ3BU0hRw2U9emCfsWoRCT4h2MlhkR18pLmpoz9fjOpywuwe0gtum6C5J52Jdj3VU1/X4ahAq84tBsvrm4+MyObA=
Received: from DB7PR04MB4009.eurprd04.prod.outlook.com (52.134.107.22) by
 DB7PR04MB6011.eurprd04.prod.outlook.com (20.178.107.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Mon, 19 Nov 2018 07:11:00 +0000
Received: from DB7PR04MB4009.eurprd04.prod.outlook.com
 ([fe80::6c2f:c491:5101:7e8a]) by DB7PR04MB4009.eurprd04.prod.outlook.com
 ([fe80::6c2f:c491:5101:7e8a%3]) with mapi id 15.20.1339.026; Mon, 19 Nov 2018
 07:11:00 +0000
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: David Miller <davem@davemloft.net>
Subject: RE: [PATCH v2 2/2] dpaa_eth: add ethtool coalesce control
Thread-Topic: [PATCH v2 2/2] dpaa_eth: add ethtool coalesce control
Thread-Index: AQHUe24lC3EXIiTmj0ac6v9A0T9Uk6VTWDiAgANewAA=
Date: Mon, 19 Nov 2018 07:11:00 +0000
Message-ID: <DB7PR04MB400914664928CDCD6797F151ECD80@DB7PR04MB4009.eurprd04.prod.outlook.com>
References: <1542126591-5114-1-git-send-email-madalin.bucur@nxp.com>
 <1542126591-5114-3-git-send-email-madalin.bucur@nxp.com>
 <20181116.194219.2027125174407236599.davem@davemloft.net>
In-Reply-To: <20181116.194219.2027125174407236599.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB7PR04MB6011;
 6:ChYv2pI7RusXJAvIRIQBKRhVcVQQ0m4Nvqj4+25j3cKefY7JjoQ+T6K0v9G+7WsWvnlodGEd0A0ehzd9wtFKEqNBQd6xxYqffcy2+s9ywsDzUTWPhSlJcWwJR4xqZkJ6jv+QMndo7UOh2wvmbwkzrk9WzvjJ5Yq9Emtio/DEzsg49CTGwOdegZAqZQp4NKVc7MZPXKo6s5sBjp3BfMiOAejyiJK4nLuhCCKFpiebznu6+JKVy+3JcKRn2/namV6rFNmrvF/JKGtF/dSe7hqFpGZseIqD3MXQj3GRxFmDkKIogIoaP6Dzuzbqhh+9FGAYVf5PpBCbqfjvy+uc8R90VnADtcu27fVg3pQxDHYmwIOXhDPvOsFKYVLsqKDQxNRqBOxOCnk60wv8b2iXec6ozsftVrUVJAwRd3FUgjhbk2Ipwoyc4lGxa865iA2G0fodbwPjen1AA/6coxGfU7z5MA==;
 5:BLpz7j5FpWp2M6kHr2jHjHgTy21dQwqMwqBiR1AdIJkLRenQiKVcyeKY9ZJ4wlTYE3DWx3HYdSD8I62FAEywutzYUVX3AGcJ81E+sE/doO/zqjWETTVIY3W3xtjjdoMcjIdf7eAXZX+6ZFJkZt+oB1+AwTu/gVxjPJqJwH1AtiE=;
 7:xd2vNJkxOesM9lGS7dcrTSpFr9ajUwxqwvS5aQe4zpVvwbX6XeQ65aRd2MPuZZNJ4JTSzIYBp5VkWWBdqy95JmX7ypnnFYm8rxbxgST/rjdmnGSmVDrqnRGHwBhXBL7KoqO9cMAPJIRQehFERE0a7Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2b7994f5-101c-49c9-f2a1-08d64dee2903
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR04MB6011; 
x-ms-traffictypediagnostic: DB7PR04MB6011:
x-microsoft-antispam-prvs: <DB7PR04MB6011F7AA46C834DD8E974791ECD80@DB7PR04MB6011.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:DB7PR04MB6011; BCL:0; PCL:0; RULEID:; SRVR:DB7PR04MB6011; 
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(396003)(366004)(39860400002)(376002)(13464003)(189003)(199004)(71200400001)(71190400001)(478600001)(54906003)(316002)(102836004)(14454004)(97736004)(2906002)(26005)(33656002)(25786009)(256004)(4326008)(6246003)(53936002)(9686003)(105586002)(68736007)(55016002)(106356001)(8676002)(74316002)(186003)(2900100001)(446003)(6116002)(3846002)(6436002)(7736002)(6916009)(486006)(76176011)(7696005)(66066001)(6506007)(99286004)(305945005)(476003)(11346002)(81156014)(5660300001)(8936002)(81166006)(53546011)(86362001)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB6011;
 H:DB7PR04MB4009.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f3HKMFov5VAws8bJLxXBfMo8yXIRtgYZRGl8n9yq9slZVFDlgydPKNnvKEDluydGv2g4NudKzqkDxyG1ssybgd9XDjadIBWv+YOLYtndjuYoTNouLKQoIXZPJWCbCMW2q20vaFoIm/EEABEUeJLDnWyCxCVZZhrtnrbsx7b/iaivztMFBBcWAn/k3EW8OKGI/+yHcdlU4PZ71sYJq0niF6qd8ulrpYBfVyCjpt6p2MXXY5csqvRfzVEInmNvumr3fSIcneiNE0Me3RahWeqhfV4dZOvXe1IkOd1kFubutxE1gjpiEd/j1gDjqeZlSGxllD0Pocb1/mppG+FBWtSrJFTNY9Qs5e6+11t6q8bfdEc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7994f5-101c-49c9-f2a1-08d64dee2903
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 07:11:00.4558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB6011
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Roy Pledge <roy.pledge@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> -----Original Message-----
> From: David Miller <davem@davemloft.net>
> Sent: Saturday, November 17, 2018 5:42 AM
> To: Madalin-cristian Bucur <madalin.bucur@nxp.com>
> Subject: Re: [PATCH v2 2/2] dpaa_eth: add ethtool coalesce control
>=20
> From: Madalin Bucur <madalin.bucur@nxp.com>
> Date: Tue, 13 Nov 2018 18:29:51 +0200
>=20
> > +	for_each_cpu(cpu, cpus) {
> > +		portal =3D qman_get_affine_portal(cpu);
> > +		res =3D qman_portal_set_iperiod(portal, period);
> > +		if (res)
> > +			return res;
> > +		res =3D qman_dqrr_set_ithresh(portal, thresh);
> > +		if (res)
> > +			return res;
>=20
> Nope, you can't do it like this.
>=20
> If any intermediate change fails, you have to unwind all of the
> changes made up until that point.
>=20
> Which means you'll have to store the previous setting somewhere
> and reinstall those saved values in the error path.

Thank you, I'll come back with a v3.

Madalin
