Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD59AC10F14
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 03:36:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0362075A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 03:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eN4OIK74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0362075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nXLD6kt5zDqT6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 13:36:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.2.77; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="eN4OIK74"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20077.outbound.protection.outlook.com [40.107.2.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nXJQ40GZzDqLp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 13:34:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU3fBXLY6mw7U38iX3DQNW5bT0HIFKibUJCoJYqVHC8=;
 b=eN4OIK749uKEW2ACxJQF0HStmo7ZtqKEe0BR3VOaobfz2c7BJDqjdHinEO88FjNjgMD7d9Hi8LJgrFG7wVQ6WOu84/f/d6KozExZ4jsCkn+2ZC8SfxSNPYeMo5+rYmSDrz3ImbvnMs8rAAnKV/5PM1pn5Vq9BGWfwQu6MvpcpZo=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6480.eurprd04.prod.outlook.com (20.179.233.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 03:34:36 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 03:34:36 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V5 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Topic: [PATCH V5 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Index: AdT4vDx5B4gnTFqhQKuDMg1gXd8pkQ==
Date: Mon, 22 Apr 2019 03:34:36 +0000
Message-ID: <VE1PR04MB647987AA4015060E53800B24E3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7588254e-c50d-4175-997c-08d6c6d37193
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VE1PR04MB6480; 
x-ms-traffictypediagnostic: VE1PR04MB6480:
x-microsoft-antispam-prvs: <VE1PR04MB6480D83CB643EC1A1B85599BE3220@VE1PR04MB6480.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(366004)(346002)(396003)(136003)(189003)(199004)(478600001)(55016002)(6916009)(14454004)(476003)(33656002)(7696005)(14444005)(3846002)(6116002)(256004)(99286004)(9686003)(486006)(66066001)(25786009)(8936002)(52536014)(74316002)(68736007)(97736004)(6436002)(8676002)(73956011)(316002)(1411001)(66476007)(66556008)(64756008)(76116006)(2906002)(66946007)(66446008)(4326008)(26005)(53936002)(186003)(7736002)(5660300002)(305945005)(54906003)(86362001)(6506007)(71190400001)(229853002)(6246003)(81156014)(81166006)(71200400001)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6480;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LVXKC3fkZe+jqMhtlJd39jkAfAqaa8aXc4jHea4sTxIlNWEO9xDJS0Ri9Fw5ER3VWrsJRRXGJGOaxY0djY8m77vGGDi6aVHlHwf51H2DmJEO4NcxTI1w0gzvGGh46eXM8BPE68CXTGTvTUDPqPZt8FCC9LjRvjn1nGuPZ/D3za2XPJTTxLQ76JvPjYnB0hI5pDWAwvNHcbImigIynr6GowvWRQ9hi/0SEYY3eXVcGppa5W4pKyE3d9o8ccrZBZ04csQB3sC4XD5bv6JXEqG1Hkn3oCbST2P5fDCGmsMbXvGm4MRiPNlQwYIHF2bhfHVpzs7e/K/awdDP6s6U36G36JUWinuCCbdE+FofbvgAm4yp66FfNjETqW0y4AEGgIW41kp6WJI5zHorO7xpoWNDqntXg54qAL6KosUgstHHHTY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7588254e-c50d-4175-997c-08d6c6d37193
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 03:34:36.4660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6480
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi

>=20
>=20
> On Mon, Apr 22, 2019 at 03:15:34AM +0000, S.j. Wang wrote:
> > Hi
> >
> > >
> > >
> > > On Mon, Apr 22, 2019 at 02:32:35AM +0000, S.j. Wang wrote:
> > > > When we want to support more sample rate, for example
> 12kHz/24kHz
> > > we
> > > > need update the process_option table, if we want to support more
> > > > sample rate next time, the table need to be updated again. which
> > > > is not flexible.
> > > >
> > > > We got a function fsl_asrc_sel_proc to replace the table, which
> > > > can give the pre-processing and post-processing options according
> > > > to the sample rate.
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > >
> > > A couple of more small comments.
> > >
> > > And please add this when you resend:
> > > Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > >
> > > > + * Unsupport cases: Tsout > 8.125 * Tsin, Tsout > 16.125 * Tsin
> > >
> > > Since we have a ratio validation somewhere else, it's okay to drop
> > > this line -
> > > - it may confuse people since the function no longer checks these
> > > unsupported cases.
> >
> > I add this for may be in the future we forget the limitation. Just for =
a
> reminder.
>=20
> Okay. Let's use something more practical like:
>=20
> +* Make sure to exclude following unsupported cases before calling the
> function:
> +* 1) outrate > 8.125 * inrate
> +* 2) outrate > 16.125 * inrate

Ok.
