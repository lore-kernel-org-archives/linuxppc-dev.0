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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949F4C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 14:03:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B452082A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 14:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rj0AiQcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B452082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QvkX0JGFzF3NR
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 00:03:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="rj0AiQcq";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.45; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="rj0AiQcq"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00045.outbound.protection.outlook.com [40.107.0.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QtWn1145zF3KS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 23:09:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfK2n7Ae+5RlBZd+X6EbwHtQP9Su7vGFVutmyvIpMjY=;
 b=rj0AiQcqvsumHWnI9R1try6tXjXMC+qtD4tkd2XiE44yzyOKC+qD9g3dzGXSPmOJxq5U5z+8JyoRSyU32r9XsiUaGcXPJihagZRP2/5BwBjDqD2ci84S0bnEd9SQEUz5nTqtLiZMLInwcgd9bzXMl05lFb3HlzzNfYbEWrasSew=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 AM6PR04MB4792.eurprd04.prod.outlook.com (2603:10a6:20b:3::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Thu, 4 Oct 2018 13:09:14 +0000
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
Subject: [PATCH v4 3/6] clk: qoriq: increase array size of cmux_to_group
Date: Thu,  4 Oct 2018 06:33:48 +0530
Message-Id: <1538615031-7507-4-git-send-email-vabhav.sharma@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7e02172b-e817-40ce-e870-08d629fa9841
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4792; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 3:zwtPJauQm8saEW30LamTKzCXiMz4au3IsnHpffek4ZXgc3aRgqPAkbNJjVtkfIz9aTNinyVoZwbl/RU7rWtKpTJ6lKnjSGeD74ewqMC+L8nh9pT7ZxMdbgSf6TQJiVtfMkH4qtgYZpC75gvTHNkNrAlWxljXC3V+sCnpCaPoaw8bXo9tl+jyzz1IsDqWcniSQuDWU/dYAnUgxZnI0/K5SEbI1mHiecHX4h4CJZenFcL8atOb3v4VJ4As1P4qghv8;
 25:WpP3eHjx4FuNcpOY4dxvn79nbFjeDe3qTcGdgfAGvm6zuhO05jYdwqKVL2UGDVNf4N2Wkvlgx5gYkMucGs/vyt4hzcBrjM230SalmP8a15BmCEU+jbJC1QywycXo/VPMUW7av7BYJblN3nW23Hu3DmpYtnM7UBucMJMYULhLRqAxUHikHKrfI53Df3raahfiTYGfAUDHgnM7X4EKgCkpuRLV2hFqooHyvEP58Wqyi3z8Ye3mMRN4lbzdpdqBNEYk2c6pb8tga5NPeGPsyrK/JM0A7HpFR5URvC6aTpkAbkidcIA8CFCMqYoG6K5bjzXLsOm4sLhErcye8eiA/Af0LA==;
 31:An40cQ9qpY+yyUS4+L1iN7Fpj7OIvAElwgT7L6hbc1S1U0gsPDwUTwESrH58NvpViSrlgWffXknS4PBlYC8KMnBmOEDoJIuojG/9scsRKgAB5oidJsUcvTnNJbqtqNPWVOQRdDz/RTc+b2GyiXCaaCzYDGSNh9VUDVEOIWway/jV80A6J6BmizKd5e1z/2ooDb0D/e5Wa7s6ep0gf04sTrV9PKwo2W6trR+dzwU2Hjo=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4792:
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 20:RdXiWngKfjDdkT0KjH2n2oxQy415ABreE0wWjtXROl4UhQcw8/FsvKSxJLasCGQ15IRyCz6pT3gbxbqVLr3ohO1zA6j54QEdak2JGdOWYvpWy1yiJPkaeQaBEz0TUYxMeCRGzXuC0y80J+pu9eN9EWOEWJJIB3pe5j1Jaqql8xvnyaHlELSBOW/O4wHT+6NJR34b0Y/H56GrT1HGcBaSxJsMM0l+KGEXV1sLTtxlPYHcyc8+PLOhtLp5wCtuTTvlGDxlcv6HM5S5ravisAhcCUWYyte6rwKsFbMxFqZWDfVovYU+KuU/2hzNJnZU9lFYmFWDkmRu9IBBYbEYfr2kkqRX0KLCPt4HRXyM8EgWctr5tYMx/NHizrtnEnPtt550sUh3AKQHeFRVEetq0KNbiNXeZX578Av1V8afQ5Z867lTOuVVuas/5cgpGlvZdCXqKMVtda3NAZAbw8lIPQoMv3RDulxB7G23zC5LvOSyQWeLngh+MjPWb2B2IfXhFd7i;
 4:0gPId/9hK3wzbNpfqTUG4xxOxJROxMHMAZIH9p5MdIw0CUedRiZpI8jm7ryvrvN/OQcfZmP+siitOY2ltYo9FOlQMfe18HdgSwyWdTCZMVRhRPMHxC8S5CJScQenuPrWzbn/462lAmdSF3S6EQUfmV19r7vXEDlTG/03vsEKyAyXOaOMG58Fh1Oq1w3Xy5xID5FqDx4qEPHmYiFdCJOgoblnqx9oSWYMLA/J3yfrrSPYCwt6sNmUQ8pEAok7c8qYfDMIwM/gauFRV2lpMsuTEVNMQZ8sbLXb8jatJihFP0wT1Ux8VLzeI7foZxp8bKBl
X-Microsoft-Antispam-PRVS: <AM6PR04MB4792DB7EC96917C35C7C8A2CF3EA0@AM6PR04MB4792.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);
 SRVR:AM6PR04MB4792; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4792; 
X-Forefront-PRVS: 0815F8251E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(366004)(199004)(189003)(97736004)(48376002)(106356001)(8936002)(305945005)(3846002)(7416002)(54906003)(6116002)(7736002)(6486002)(81166006)(6512007)(478600001)(2906002)(53936002)(50466002)(68736007)(5009440100003)(105586002)(55236004)(6506007)(2616005)(956004)(14444005)(446003)(11346002)(36756003)(386003)(16526019)(316002)(476003)(5660300001)(86362001)(66066001)(186003)(44832011)(25786009)(486006)(16586007)(6666003)(26005)(8676002)(76176011)(50226002)(51416003)(52116002)(81156014)(47776003)(4326008)(110426005)(921003)(21314002)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4792;
 H:uefi-OptiPlex-790.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM6PR04MB4792;
 23:N8hoEth5wF6Np7L6P3/EHlnQspNFmzonFT+Rufy5j?=
 =?us-ascii?Q?XqV4i1cBdxx49yQk1AdZMl2mRCJPhbVbLAWyz92E3r+1nK1y9vk9EdSTi90F?=
 =?us-ascii?Q?BBmh0mFFl7gNP2LfcDPrepZIiZjmPhxHrnROEzEwMU0W5KQmRN/VWomFEyLu?=
 =?us-ascii?Q?8zrmcb9EKjvjkmNJ6GVz7l6A6bJcNmqhg/CUoTPXUaoZ7b0fIkGtJwQLaU/7?=
 =?us-ascii?Q?JlvTSVsYhRCZV5o3whoN3Mqtc3PFPWwGWrb7mbARP9r/JBzkL8WcTP9mBypQ?=
 =?us-ascii?Q?Ou0X3hDXcuj2btL3unL65YyevOQRMyNiPqccIR2eF5LsWBXctl+oBI29a8OG?=
 =?us-ascii?Q?AXJDky2YaHzXUc5+/ijUS+UBwdAfPTaly4gOb+yCKUFUrHDcSSRJM+8K9/mw?=
 =?us-ascii?Q?xnDSJnELzaoCCX1uKmeKo3g3PAqbxaSpLDguzYN+WesvtzTh51exG+UcWT/7?=
 =?us-ascii?Q?uRdfPnWLH42AhyLG5yPU3ot3weRTft1Dxx8h8EtycDz9E1ZMkc9uU/NtzxnT?=
 =?us-ascii?Q?0idu5rPFhDS+NIWrfLFdR0tdhMPeO94sXnYnBZicHQvUX/c5dpRtvOHTnFlD?=
 =?us-ascii?Q?hKJYUqCFixFQ7ycGSfjityg5o1zUiVOwQ5vHvpAYW0HJ50SpFdzLswpAb2si?=
 =?us-ascii?Q?ArUKk2etvDenxCtHdfTTiZeSxkjZpDlCsy+331WDLu2OTNi12icOO2uSwkm/?=
 =?us-ascii?Q?oFnjSjC2iV0fmFo70/5egM9igmf4Cw/7fH1PxuIQOq9dRDNl7H3NkVCORStM?=
 =?us-ascii?Q?Ha6TQJAQt+XCaxKnbdwBm78//UAQm8odpGnvPEQaf43o5YbVhYOIgr7ezXoP?=
 =?us-ascii?Q?nZ2DuWyVSo5JWWrn+4ijRsCoGR1hrDmSDigPmCclQayNRmAdT9q0RfYMEOKx?=
 =?us-ascii?Q?1UAfkuHAv/bhohF3Jne6YaivRqPhZVJZfkpAT6uMKQpBiPJ9mhRNVLhdU8LB?=
 =?us-ascii?Q?cQtT0r6ckkO4yfZ5p0LBFhN5HH02uixXPxbVWDa22HLsdj4qrFIKmX4xHOqT?=
 =?us-ascii?Q?C6KVQH/PKP/1bY+IBHxoiJQSJm1a5s9NRyB/bGoO48m4XG6rxBo3aUAf7ieQ?=
 =?us-ascii?Q?rUefnRpDiGEq9K5HNuuMn9UQTEqcIdxW/HKVm9Sji4n+PrnDJhFZAAfqLELo?=
 =?us-ascii?Q?Gx0JYAwyoV7CEjgxTztkEnw+R8hkQ0w/MvcqhQSqAhdAaQEaiFY9hFuw9DNL?=
 =?us-ascii?Q?228ptNPGz6X3mX5Q9kdOEX8kH85JWCJKZ6rZ48YwYm4Hwsf+eYMwbk9SG5yE?=
 =?us-ascii?Q?nXAQks+DQDZGo8k9OLWSIRz70b3hqbMOb6vWw9VhoGp4xzY5njnPQLR0luF4?=
 =?us-ascii?Q?PPkhnNmdxpdvjTTmOoO8U2zlP+jYS7FCv2crxpEI2CFdISwwjAwB3dKqsrnm?=
 =?us-ascii?Q?lgwhA=3D=3D?=
X-Microsoft-Antispam-Message-Info: dWtm4KPyUhnCbZWKy+/0jCU0829hhHpCevamJHolLjDbjtK0z0PMAEcHcW4qKUSyKIwB0pIayjS3bQB/8gMEyFqaesjC3mcca6EG+U32GRLTJ0EKEt26gnrG/OjENt1mARtEAGI4U0QHSD3lBFhCEeLmRBRZdFvLhPC8KrhVwUIMg8ScHUbUTCvvyKH3PLlpCE8lHK00iiKi9e/JPcFOA1JqM1+hKtfUbuDexRoysxvBaUbB6xvs7rGXam31KYseR5VVkRF53cz2QXs27Ld63Fb8CFXR1llVo9FFMq6lPuNvA3v1LhwnWIO/VqtM3tGvyod4FSlismU+s05/s9BwhfdPTda6zrqWSAkNr1ctOBY=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 6:LdP2vl78E+P0YRyux8EBN9q1JV74XohjOhZd0X+koj3DCAHoxSz4Q7VJBFY45RVjdXVSScuys/HOrsLo8IksTjenoihhEEeeRqTK1gSoi1FAPxz+2KISuYTuZu/kZKdLfsgXnLCSNFHkEgupBQKakn6RPA1qzIRePAyuaW/LzDowzyyPDscsPssJ0PoVWMawT56nlbEiuix143P9zOjOcpO/OLlcZd2gSzyygp7id7rix/d1frFWjzPEoMhMRssJKxWbBJO9wWI7zuePH1h3crF6sxiqYsRbUljEjYBTSZREJ6ehyrbNsEqB+PCwzrV+DaSmbBl+S6mc055PKx2t06HzNR0nVCRyVaoTMVHvGt/A0oZeHsrCRD5fmlJu4x3bglROOz3Tx2gYmhiL5HBMIui6RfiTxUmzK/6I7Mmwal/riwL99NU4uSxa2B4zEEGELXCF76WYWcr+A078m20NJA==;
 5:h76JCH+pDRoj4FYOW7TGAAFFyiATGSV+qXXVaJRqUbGjK/DjoPZlDyPSGeRj4vtPBHHc6C++9RmmZ+zRgQQJk6REvgH5dFIVzXWBZ3ggFsr7G6UHmJnbmZpFxWjza29dTwifYc28f7L1bFVFaOPKVCQSbunzQXTFGwHpjFrzT6w=;
 7:1FC/WORb8jFjph00J9Zx/DTrmJpSkT4yZu4R2mrRxY9PkRY+opdLeg+K8U24mUD4AYfSU4KE7x8DbeScs8NiMqd80/kjmybsSn+onzCJjOUptF6HyuIewJlrqFkXpNqevmXU9sdyFoAaYAPJWhuE8qJ/buF2PA+2dLDhAtII8Hg6iQiGs01L1iuDJDWf5Zfk8kGCdgFujZ88r2CSAgJsmuCF3lE8j2q3ZOIOTIuL2Sp+UrNzhhl5MogZLC32epvr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 13:09:14.4083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e02172b-e817-40ce-e870-08d629fa9841
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
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, udit.kumar@nxp.com,
 pankaj.bansal@nxp.com, linux@armlinux.org.uk, V.Sethi@nxp.com,
 Vabhav Sharma <vabhav.sharma@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Increase size of cmux_to_group array, to accomdate entry of
-1 termination.

Added -1, terminated, entry for 4080_cmux_grpX.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 drivers/clk/clk-qoriq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 3a1812f..e152bfb 100644
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
@@ -601,7 +601,7 @@ static const struct clockgen_chipinfo chipinfo[] = {
 			&p4080_cmux_grp1, &p4080_cmux_grp2
 		},
 		.cmux_to_group = {
-			0, 0, 0, 0, 1, 1, 1, 1
+			0, 0, 0, 0, 1, 1, 1, 1, -1
 		},
 		.pll_mask = 0x1f,
 	},
-- 
2.7.4

