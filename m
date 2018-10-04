Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAD_ENC_HEADER,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EF1C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:55:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B5F2098A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L5Xot1fb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B5F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QvYB0XY3zF3LX
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 23:55:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="L5Xot1fb";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.70; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="L5Xot1fb"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00070.outbound.protection.outlook.com [40.107.0.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QtWZ65wqzF35n
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 23:09:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgfjhDhHfrta2tC0B4FDC4WaGMMoW1re9/4lFwy3ui4=;
 b=L5Xot1fb83FXjwsmEuBTjWPho4CxbDB6b//qyMJWCGc8jXUF2JJsgdiHAp0dJKO79Kv/TjykwAO9iDULwj/N8sqPdlX4Z0wn8LXdycVzOM/dipp9USqqEysx0wP3L3MV4pguMpGyHY7XqRkjydfoVcJHN1IRHtig2IYLf2Uj4K0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 AM6PR04MB4792.eurprd04.prod.outlook.com (2603:10a6:20b:3::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Thu, 4 Oct 2018 13:09:03 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: sudeep.holla@arm.com, oss@buserror.net, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, gregkh@linuxfoundation.org,
 arnd@arndb.de, kstewart@linuxfoundation.org, yamada.masahiro@socionext.com,
 leoyang.li@nxp.com, shawnguo@kernel.org
Subject: [PATCH v4 1/6] dt-bindings: arm64: add compatible for LX2160A
Date: Thu,  4 Oct 2018 06:33:46 +0530
Message-Id: <1538615031-7507-2-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
References: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::16) To AM6PR04MB4792.eurprd04.prod.outlook.com
 (2603:10a6:20b:3::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1420e1a7-0e22-4787-82ef-08d629fa91d9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4792; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 3:FNM704//CElGXyVhDQtlYDwgMYDEch0+s3JcQ9tKVZaLHD4stzw3+84IJwx66HApLvxAohoDsWmRK/KaU9LgxMLznqAKsTSQK2omnfj818oTYOH25QMT7+q9L9EIkRX6qrs4b7vPs3R5fJ8e3RDKdhV7ERJCP1PVJw5SyrCywR3TZp3XRUYOg2jKIcRfuwY5h0Yrd1A351Dz2EAAnsQF93AoT5GKrVK05Ru1+39jLJD7tIf041W/klRe9HftZLLP;
 25:Y6zcFACptgSOSq1jw+VBCVYtZkFYc1bwvp6dAMKuvrnJlLJ0W22F/8rdynYIJjm7OcM2hTidmV6Y6ZgMO/QTbez8nAz1xuKWylynq9KqM9qx/acMOI7mlbLus5yhwp/Fhi1sYh8DZGhuouSjlC0PgZl5KuxDrHbP251Ns+zTfK69uWnkt/D5P8AR0TMcP6rps3MomLDtJo+Iq5Pt23C5TRA6N3B0LMiTEAcuTC/Rgj++YX8VXshmogixTyxTQeUJ5JXptOrMmh3XCtj/r8pDCXxdDwTYD9tW/F8OzI3XYyqFGlqCpjgj76q8tcVAuAOGMdRs2MQUhq0V9l/hWMz/Bg==;
 31:UmM5evgmevO4jk0jOFzLpfbaeSPawNL4tX8Xg2BbYFZfBD3ZhJtmv7xfq1E8tDApxJpT3pOT4R/tcqFFA8KOL81jB5Xm5CaiHfOC7V5oKWt0x/HwKksumRnVvvqIwsBmH/Ms5G/nhFyXF8M3BhhoTBANDDIt4FHce2iN7pNbXNJlXD+8rdgj43kIzZiEFX2Na5oBzDcjIcoC6Q6svyXdwIw/eH/FkjIqKawyNIx71E8=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4792:
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 20:MPCV1FKQZTzBWQX5KaR3jEuycjxv3IpplILfWCpZ8gRVVtgfRYkwLZRuZjngDZlAwR+6LxflilQpmEMxz/3DIKY38oXkdxEk/Jwe4AYg5aLJeuJ0cDJnb/8mHk4AbtoCNoGBThER0r8bfb4RmLRK3QhIbMrmdjc4gqHC1pQzLAYh5mCPTrr1HDBEe6TyhwHHV4dFyMnk1Df35ZucIMHiyseljC2HQ+9oPAOgYAuj3Pi6Z5EpAgAHiDYKDURbRoUCpt1P6DKggjikRvuPajVVwX8yxjtL5TSsqKiW37Ai6F+QGQkDWFkSQ/srfTQpqqqfIpE/yCj6WGXR8qmkoL3//1gtO095iUe6LKXu7xoD6iLM0V7szzHKuf50bc/zK2kafUmYynpo5O3O3zPtL22WhVN21ltrderJkYlGvdIHyrtrJYIHJumMsjB72PHGktDkiXUuvq8ZAsVhOPbAelBR/OdwAq6gG3M3JSDUMW8iMyYTaVCG6o4/BKaYHgN/PQ0w;
 4:6t39+F3d5KuAF3O8qUbbh4tPtLrq0Wrmikk7lrFvekt6TA6q+csvlnyv9ClFJvsSw0+Vl1ae/qxJZHwk7eVBTJvAjjkzT3513klN5PhLcuVV2xyaXNTizU9oo+WA57kH1v6mqro2bwMszUajDk+4wi6+u7VfCj7EwDzwgFm7Oizqh3oWI/Lv7Ufx7l+TAZrCM+vMVRNvVGMn/1/onRrUloooI+AWGw6u4O9uSGywwC75t5/OT5uuYgYrJ+xG/bQRiegl+G/WATD2h9VzAHF/yRtAR/PAACf64aJpOUoOT5VmZLQs3Vko2C9XRhHoF13J
X-Microsoft-Antispam-PRVS: <AM6PR04MB479225EACBE22714173CAF38F3EA0@AM6PR04MB4792.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);
 SRVR:AM6PR04MB4792; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4792; 
X-Forefront-PRVS: 0815F8251E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(366004)(199004)(189003)(97736004)(48376002)(106356001)(8936002)(305945005)(3846002)(7416002)(6116002)(7736002)(6486002)(81166006)(6512007)(478600001)(2906002)(53936002)(50466002)(68736007)(5009440100003)(105586002)(55236004)(6506007)(2616005)(956004)(14444005)(446003)(11346002)(36756003)(386003)(16526019)(316002)(476003)(5660300001)(86362001)(66066001)(186003)(44832011)(25786009)(486006)(16586007)(6666003)(26005)(8676002)(76176011)(50226002)(51416003)(52116002)(81156014)(47776003)(4326008)(110426005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4792;
 H:uefi-OptiPlex-790.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM6PR04MB4792;
 23:L9aQuIpbSMBeFVq+Ng/ed9TdlTu1HmWZdY93KtQsV?=
 =?us-ascii?Q?7/jYPZwZrbjz1dipB1Q+8Gy+dPEfPYLLl7ASiiaRWwCBhKsn8rFDyNrdaC1R?=
 =?us-ascii?Q?danM0AkD/XRD8qXKWmcl7SmayW8NDpYB09uJqmGfG5wWhrXDJIfdMVb7qXKi?=
 =?us-ascii?Q?cZiXoXKbYS/vHsqEVojuxDhAtSDkxoXfLFfe855By2aEyJanINuVkDlurUr4?=
 =?us-ascii?Q?wiuyTWiqUz+vWWBgYmOfBZc8RXbYMIpasRxppLJ8HdjQy15l80yya/EruG5L?=
 =?us-ascii?Q?YnvH1kkYEIKzeuZwr6BjmxNCWjMja7f9tpEEFPZ7+iHJ/blkZOQnh/FJglru?=
 =?us-ascii?Q?db2DtpDzwmk8nP8FIRhawp6mOft+FpxbaK3OMydkr9FTjyYQbwIrzaedmANE?=
 =?us-ascii?Q?INyCBaPX1GT3JXUAUsj4Ua7Zr/HXoFKhBaLHy98D5459kJ3SQzTPh5hH/2wT?=
 =?us-ascii?Q?xOFPVq3M/WlGXIrjRMErXkvzr6Di155WheGv1TIlHn43LkjzIBYD/Ji+ORd4?=
 =?us-ascii?Q?LJIgkVZO7OQdNOGac9J9JNR2TmMYnF++7H2jT2OJ4ToZsrvdzMS4p1UX0FW5?=
 =?us-ascii?Q?JZ4QnmVOnjJyIksT3Vn2bQO8fsRxISKDJT24DHXZUtz27GUPFCYlSzXHsuEz?=
 =?us-ascii?Q?8U/6sFyBL0jMN+kvVgtehFcQO77N9eXKQRSuWJWf4Av/K/GVRLIhV9B/xNTQ?=
 =?us-ascii?Q?0xVpJZRqnuKwKKqv2Y/e2a1mHvrCdZ6LyC8dYI+bFRUdbgZ3SutUjr2iv091?=
 =?us-ascii?Q?2cUICXlCwBqss26oHx7nrl5XpCgUfFOhLhMMYu4aFjP2GyBCD4lQfGOhgy36?=
 =?us-ascii?Q?CjSdm4bNIpcyL1guVMm3x2j20NoeQGMUfz3y9Fbce0MvPCPj4ErcU5LcLFDv?=
 =?us-ascii?Q?ZIpLAgYG5Iw2AKM2cyhrAv4l3hrXK+9pAGXPwE3L870XIGy+Eze6QCDIgmEr?=
 =?us-ascii?Q?hVyshz/GzGlVOWgk/O+G0OgoXPbKxvbpuHGypp1QiH11VxMj70mTGnOSCM0G?=
 =?us-ascii?Q?A9z1gJ/TxDCOUvh+MawwVuT7Y+FvhBQ34V8NxTPTJXtQ41m+oNJ4jO1KiFzk?=
 =?us-ascii?Q?utPqG2MVDHbepEUw01LImqTPkyyP+e5D+u1IbMdpERvhLjEv8rjpc/Y6ctlP?=
 =?us-ascii?Q?0zym5GPpSKy+V1Gc8yVLKdEQvQ521lLq/UiGXNVnhr8CK8qbA9KQoxN2XKom?=
 =?us-ascii?Q?/YhV6B2Mg2Lf6KW7q0k5Ob6vFomE7O9ck7Imq3z+WOuy3GLbDDYQKnO+DyyT?=
 =?us-ascii?Q?oZG+e/5AbMDo97zz524VmZePirO5LMFzEN5xNJmCODRxYotjO5r3XKK6XxpB?=
 =?us-ascii?Q?Nj1Y7F7B9Ig3DuMuOveGq4=3D?=
X-Microsoft-Antispam-Message-Info: 57ta9nucewFuQYG7NYpNVc6c1Q5meOjJbMzTTirRdSMhWQXz8sYEEdubmEJPXFAuRkkaAp5pPlNSRt8kGX1sbX7Je0YluQrbMFe2K8aDmgruDj+M1w+p7Y547OQJXeTsByahep0RRqabvAufHPLJBoLz7oByI/Qe6Hc5+1CyFrjLi+N8AQ2TSIJ4IddJUYwyTWbumFH/JMOQRYQmn0HNImZBrcRIPzk7HXSJAG2+21EAh0DqePTWg+E8VqAaKZhvIzWnkuX8mipVqGDcqiKRgaMXmzBoijiEEph+iAKGQro3ZQ+g4cuKsPkHfBmO9OjJZPIShY86+az+tjq1vEZtKhuZQyzdWpfVDKz4koEJFdY=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 6:P9lVNorIRzW8dS8SstyBuxoGhPqX8+IfXDs3VmV2BQvTSMEechmMhbMjNxg52rTIZ4WENbr3eEheoYK2J3sdrUCJO7BhfxG/La4djViUEwMqe6YpJ3JopajptU7U/V82afWwRNJly20k/hSF2YSFj+2S/E5rmhhm3wODKJ0WeucGuqLuZRikbfdkqWBMQINqd6guToPc/UP+j1cBPe2VQdI1ZtkfjWlt0uOj1ZBTeAU3ciJotyBWXztsmZpPCq+cCIC6Gxbnkx9Sak6oULmLB44sLA11UBBUqBGWMjNFqlWhE5K+iImciwPuBPW1nHeLmrv+PDpw7wstdffAt3TT3eYJDEYJ7Dvi6++deYqCkROhEtzyh39QaMOwqYWyoXRgnorFa+moZ+lLFRUCPrbtuQniFmbR9JCBJL5aCB8E1LgTZMQXMXErxdTJibCLybviHInwvTwwwQ7WYrNxpDGT9A==;
 5:G6fV7QNrkSoPJi96Y/Sm1qjlKLB3trH8+U89ETFag6ZVfyryxyrHYlyXVeCm7S5OxOoiWDamR2siyA3n5GTW+uIU8WYpasPdugWaVqJ+H9T6tLq1NmjLPTrN0M5XdGWneLrp7Eu7xdtXogXsaTt6MLG9Ho6X2v2YwCFn4Q9B8EE=;
 7:BDQXAyHJn6nGvjG070iwJUAgzOSSLmR8mgHgq6in6XowCDg3IMMhK2H4t3wB59r/KFwNKc/oyMfmtjN7l2kITVasDRIpUjoGb8qzO2yzx3ns7LPTOk5rne24EXYsA/+46hy2qqgQa3i2R20AOD9vI4LWZYEybJngkGVdNcteJt99z0TKaHhWMehiIRAa0rBOanp6wtLIxC9dy7+LZMc4xRULhKfFOALc0A0Jz+V2nZ1RXjD7LG95lWbdNO/S1rt0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 13:09:03.8140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1420e1a7-0e22-4787-82ef-08d629fa91d9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4792
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
Cc: pankaj.bansal@nxp.com, udit.kumar@nxp.com, linux@armlinux.org.uk,
 Vabhav Sharma <vabhav.sharma@nxp.com>, V.Sethi@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add compatible for LX2160A SoC,QDS and RDB board
Add lx2160a compatible for clockgen and dcfg

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.txt           | 14 +++++++++++++-
 Documentation/devicetree/bindings/clock/qoriq-clock.txt |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index cdb9dd7..4f5d55b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -126,7 +126,7 @@ core start address and release the secondary core from holdoff and startup.
   - compatible: Should contain a chip-specific compatible string,
 	Chip-specific strings are of the form "fsl,<chip>-dcfg",
 	The following <chip>s are known to be supported:
-	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
+	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a, lx2160a.
 
   - reg : should contain base address and length of DCFG memory-mapped registers
 
@@ -218,3 +218,15 @@ Required root node properties:
 LS2088A ARMv8 based RDB Board
 Required root node properties:
     - compatible = "fsl,ls2088a-rdb", "fsl,ls2088a";
+
+LX2160A SoC
+Required root node properties:
+    - compatible = "fsl,lx2160a";
+
+LX2160A ARMv8 based QDS Board
+Required root node properties:
+    - compatible = "fsl,lx2160a-qds", "fsl,lx2160a";
+
+LX2160A ARMv8 based RDB Board
+Required root node properties:
+    - compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index 97f46ad..3fb9995 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -37,6 +37,7 @@ Required properties:
 	* "fsl,ls1046a-clockgen"
 	* "fsl,ls1088a-clockgen"
 	* "fsl,ls2080a-clockgen"
+	* "fsl,lx2160a-clockgen"
 	Chassis-version clock strings include:
 	* "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
 	* "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
-- 
2.7.4

