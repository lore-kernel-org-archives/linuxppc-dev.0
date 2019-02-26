Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D24C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 10:17:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629A82147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 10:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OB2PLWme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629A82147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447vs01j5GzDqWj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 21:17:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe1e::61d;
 helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="OB2PLWme"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447vj73Tg1zDqDL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 21:11:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUwFwSIdfiDEo6k9YkpeFTU6ChkELgnRTCdvU3pJ+DI=;
 b=OB2PLWmeyAAC2m430rOhFlvK/QNdRmeKRl+ffread53o1zoUhRrEEJIspVVr9Z++8cptasPlPXbutFBdUiZA6xQwzLwknr8irgsk6jU5S31Fbb21If4Pu62sZfcO6PqAlZQIM1er3wUQ3QuJiMxQi3aiYSL5NMgCdGTtt+BWSss=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 10:11:02 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 10:11:02 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "oss@buserror.net"
 <oss@buserror.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
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
Subject: [PATCH v1 3/4] clk: qoriq: increase array size of cmux_to_group
Thread-Topic: [PATCH v1 3/4] clk: qoriq: increase array size of cmux_to_group
Thread-Index: AQHUzbuTW+87PyC8B0m+Dsh6bbDYrA==
Date: Tue, 26 Feb 2019 10:11:02 +0000
Message-ID: <1551132245-6089-4-git-send-email-vabhav.sharma@nxp.com>
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::21) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37daa7c1-4c80-4633-8d47-08d69bd2b620
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5726; 
x-ms-traffictypediagnostic: VI1PR04MB5726:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB5726;
 23:z/E3++NwvvdH3AzOsMjTUk2MZDLv/SD9wciSGuy?=
 =?iso-8859-1?Q?vnIyH8EuzwvglmO+TebNn0nuwmU+tBmffDzRdTRHztUYXp+CI/I581PO0Q?=
 =?iso-8859-1?Q?/4iIcaWB/TmaYDSLKs9EdVjmep1zxrX1Vlcl3HWvxrWN6cfEoy0yoLaLxz?=
 =?iso-8859-1?Q?0dC4bBY91/F1dYwKjMGMF6hRrTlcbPZLf5RoPWd1H7cI6iDACldq/57oqe?=
 =?iso-8859-1?Q?DSCRIZSPpklhh6x1LXlMmIx2PX/GH50T0ygz7M8LiHC+k3e7a3JzslkTUx?=
 =?iso-8859-1?Q?ONuZEzn/83ym4sptCltB7/vH3AaHXS6Z+BAUqR4sj/f/r8GjqK59BAU2CV?=
 =?iso-8859-1?Q?TaCnkvbssDA4xCznD87q+W1gNLTV40CEFVFGcaB460/pEtFJiT4aC+LgDl?=
 =?iso-8859-1?Q?I60fDtdJQ4WabNVjqGUfqKGMusMhdj1ErBHHdbicA0KYZmNtwXmNzElhTB?=
 =?iso-8859-1?Q?/8RemR5j4KJbbEZFj6grvrDPZV+XPxNjAhseQ21fGWX+SSN2N4lSZbEJve?=
 =?iso-8859-1?Q?hccPdwPQAK13DV1V0s3S4ZSEe1uuaU/p6krAcGWnW27pK1Dg+BaymvE3SK?=
 =?iso-8859-1?Q?ZzTmpYObWO6VL5H+cuxm4cddmpwhRdxybiF50H39w10VkFNfPzt+VIWl+V?=
 =?iso-8859-1?Q?3gGvEuaEW+FVV+sbFG1MJmPBAYJJ25j+mY4+NymUR8eRXKemI2eJBPIIom?=
 =?iso-8859-1?Q?BNdTfP0Rn8EPMgi6erQA2zx9rmwegHAhrzg/MSjQSMSWfFPmBi84rPuyjK?=
 =?iso-8859-1?Q?U6k+fnGPogBtvc3P3pzmYfDNBNQDA009gqu8FOtfp3b7d5i4df+eL2TH7c?=
 =?iso-8859-1?Q?bjW5l4Uq0My+sXpRO/5lAvueCwuCuMJ3fA6zgH3qP5RbBchGGvSDDYZIeX?=
 =?iso-8859-1?Q?bGLHpi6z0/B/RHPMkxYJIg0lyh3WRH6avjgLiuQh0fr6r/j0CCwYWbTDua?=
 =?iso-8859-1?Q?Vt5dQvpwFlAhaAozIW+6XB5TOqVbciuuBbChbi/NadS1Em3nb39E/SFQs7?=
 =?iso-8859-1?Q?MGlQayTapaDCHD4TkpMBZ0k7VGgzLZjQz+8tzhnoQVw3vQnHvJLYK1TKue?=
 =?iso-8859-1?Q?3mf9RZxnMlYSwiECq1SlvkU78wf+fvORy/2s+DQJi9NsJ2xaGd0jp1tGxf?=
 =?iso-8859-1?Q?m+dnjVyMm497IkCEqRDseF4asvTNkiFyYhUScUei6dxIlhR5faHI9tUg/a?=
 =?iso-8859-1?Q?pa1LQTVOLmvF42H5nh2axWfiVTwXV1sNye95EpXTgfQTlb4zU8RW/aQ6P6?=
 =?iso-8859-1?Q?QWw8QrFYOIrk7rL2ZSOb5z/aI4AsOWzDdk9KsK7UjvhszHggtdR/2wexou?=
 =?iso-8859-1?Q?X3QvVLVZ2a3GoZEtO8KnUnd7pVZEbFTDGta8LRtJTj+eGFrCG4i31CdScx?=
 =?iso-8859-1?Q?a/lZ12JgUDRNTFByczD9WROAlTnDy?=
x-microsoft-antispam-prvs: <VI1PR04MB572690A221C17D324D04F5E4F37B0@VI1PR04MB5726.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(6116002)(3846002)(50226002)(4326008)(26005)(99286004)(6506007)(386003)(316002)(54906003)(110136005)(8936002)(8676002)(102836004)(305945005)(36756003)(25786009)(53936002)(6486002)(81156014)(81166006)(478600001)(6436002)(44832011)(2906002)(6512007)(71200400001)(2501003)(71190400001)(66066001)(106356001)(105586002)(5660300002)(14454004)(7416002)(97736004)(256004)(14444005)(446003)(68736007)(7736002)(76176011)(486006)(86362001)(2616005)(476003)(11346002)(2201001)(52116002)(186003)(921003)(21314003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5726;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9A5U+6l1GJuAkyzCBySGyA26Zis4m8gF3tRGOeMazvgsVGVRj/Je42bt+ZeCahuPnRqWPkRgT4NBR3/dqSXiHmj8CzZ6zTkCVBorUidvZ2g4fUFMTKIsNcdObmxjGFxQofWARMx9ozecYYkp5BU3OsqFz+F25OF150IFng8+55DpiZmS00RufrwRqxCSiHoo8Cd0BFVgQQ+Uet1+l3H/+lbTmL5L5ki/5RRqiiyRVGvfl1REd+QgliLfP0P6nXcUC6OqVuBlBxeDDp0zITOjXLbUasIsodEQOWyN5kXY+WJQupb8b4q4u9MwGsPOVPxz3vo1AmoARLZ6bulswDwXkZ6xaHtC3CozIW6R8JEblLrO3LQb737gdt9BD48+5T+9G0tlAAeWIaJ9rx74mg+KI4MUjupl3xDU8IlfaM7dVlc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37daa7c1-4c80-4633-8d47-08d69bd2b620
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 10:10:56.9592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5726
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
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 Vabhav Sharma <vabhav.sharma@nxp.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Increase size of cmux_to_group array, to accomdate entry of
-1 termination.

Added -1, terminated, entry for 4080_cmux_grpX.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-qoriq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 5baa9e0..e75194a 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -79,7 +79,7 @@ struct clockgen_chipinfo {
 	const struct clockgen_muxinfo *cmux_groups[2];
 	const struct clockgen_muxinfo *hwaccel[NUM_HWACCEL];
 	void (*init_periph)(struct clockgen *cg);
-	int cmux_to_group[NUM_CMUX]; /* -1 terminates if fewer than NUM_CMUX */
+	int cmux_to_group[NUM_CMUX+1]; /* array should be -1 terminated */
 	u32 pll_mask;	/* 1 << n bit set if PLL n is valid */
 	u32 flags;	/* CG_xxx */
 };
@@ -601,7 +601,7 @@ static const struct clockgen_chipinfo chipinfo[] =3D {
 			&p4080_cmux_grp1, &p4080_cmux_grp2
 		},
 		.cmux_to_group =3D {
-			0, 0, 0, 0, 1, 1, 1, 1
+			0, 0, 0, 0, 1, 1, 1, 1, -1
 		},
 		.pll_mask =3D 0x1f,
 	},
--=20
2.7.4

