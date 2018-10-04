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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFCEC64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 14:07:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4FB2084D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 14:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hv+BoHZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4FB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qvq02N3TzF22T
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 00:07:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="hv+BoHZ+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.45; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="hv+BoHZ+"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00045.outbound.protection.outlook.com [40.107.0.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QtWp4207zF3L0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 23:09:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENZf9WlZ9JcmInlc9Gwfp+dVJ9b/6YqEJuylq7nmdis=;
 b=hv+BoHZ+NDGWr+9ys4oOEaF1BBbk42JQNUOxl3T4ZUT9wN7KeoZcMuPo0pxTD5fI1ANkWcly1ZWocyOAwb7ah4pm95ZTI535+i+1ARkf+OzZ/B/53wN1IE3aXtlQ9rrkZ2/Kq4LF4y9p8+sHar8LjNPfpmxjRea7vNeIZMZWrJw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 AM6PR04MB4792.eurprd04.prod.outlook.com (2603:10a6:20b:3::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Thu, 4 Oct 2018 13:09:19 +0000
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
Subject: [PATCH v4 4/6] clk: qoriq: Add clockgen support for lx2160a
Date: Thu,  4 Oct 2018 06:33:49 +0530
Message-Id: <1538615031-7507-5-git-send-email-vabhav.sharma@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 72ea4354-5da1-4ff6-2db7-08d629fa9b89
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4792; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 3:Kkgz4I5HzJMOjslLgjaP5Kk5zCKzZ6fhR0rcRokahV6JXl3UME3hXSh1zb0SSK26J+2NjYve5C02W7eKJxRrL8sYlb1R7IHzCAUh/VLpSDCp24Xg1ekZIhJEtiMgNF2+MTetRNtUnXVem9M0vm3MGTDFczH6rfenaP8Qvbi5zid3e9XAGMly0y+jGcH6XWP60qQ4YZd2uaXLb/f4nk+3SYaBiZCwUBgYWbTisac4bQkqMoXPsXL+JIXl2z2ZhAkQ;
 25:Y/ru52jKOfJyIlhqC75VFveJnQ6Xx2/1U75lfZR7sGHkCn0yfZQUOVGDswMxcaCA3hP8dAAKV/Of8ezC032knxnhNBLzoVstgf18J6x+SARwcGcjGH7wHFv0N2NsdM1P+1Sl6mn5zB1oCxg3/yHnUYjZXUC5i3njiHvxCaWdKRTxDuHUfICu+2w2s6rgiYMWwKUGARYr09oVrZGV5jpSGlk3B85GII9r3ZreBOFNna41Ty8gC3OehJOvYMmushtpPohGLvYHe8Qs7LPkKWOpR/eI8mculU5Nz8SbYREIMJbJlxiD3fE/yaGElefZwY9fIIptYjV0R2mgUIU/7fFWXw==;
 31:h4D1BivSzQMX+iR94G+hX6Ger+fL0CoSygJ5GYCBlOajjzuolSFZhOXU3RMxNkLK0MGvXAITi81PyESqepiQe0R7+p9qqUWv0PoGYjO+bfFV6stlSqLXzuU0+mTCqjlwviq8A4nY53qnOYMXNlVNtTOIxP7Zcp6gPAEpBZbsR73NLxEDjzKZU7WLjVY+rIG9WhVrX+ZcundytPKq6t7U/2kQ+d0RzGcBUMaMob1GohQ=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4792:
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 20:OdhblsmVM4JMoboFz/kexLRCvpyr6O4MlRTadDubwasQOid9Rn5w6DAJA0M1YO6QPPlTVsbRKhiOUsp+NA8lmUOuygKvg/9xfQc03+qYmyKcspjShtT5hzaHwzGR+FzLEUn9taASmYCt1bgncbipHLYh+qRRdaS0/ArXnLFnkiemIoN2iGJwAOCKio4q1OrY6Zk0HBsRAFJTpUG1R3XXCS+3heQpDmzIWNHmvuuKiCmlK8P4+4hT4y9cF++rwk46lt1PXG9bmULB5vHChjEw0NcX4U97ad4/T+z5dfH8IIYWkH7DqqJqxgDM7QbpLXvMJMj2R11wY3ArncIocuylzuvNbfeMI3E5ev36IP1x8IVZHQo3AHS43D+MxOsyI5qfVVapCmRm7P42RuqBQ6k9AsnhpaJo0lhTd5MPGOr2HosFwom8J9FvGWUcqmExu+XSiqePZVhqZfEr9IKS7FggvfhPre1dE7NTNYe5uv7KF87cA7c7see7nWdfu72aFojs;
 4:aGqbPz2MhI/9l9giEB9w8ub0YyB2dDKFR5JXvWPl9fw4p7IB6s9TZa7qN37yj+yn0sa1OYyLH6nIxgF5e8aG3ahelUkqIvfHwc+KKNWOTgvf6ybUIKcYGTI5BtyaHgP6wmn3J1SyLICiMFi6bikQajYDxlJ8wGnS67dUpZNQA2jj2xxajlUz6/bM0n7KBl3rZgdX01Z5HX8kWTLGZrC1tiR1+Wy49C2T0EA+Jkkhy0LqwllMXyc7n9kvIR2yzWDO4Ao86QbpTA/NIRUnABfwvPIsWFnlGiU/orKUUlVjnJLphGbdUKTL0x7XgF2fwGgj
X-Microsoft-Antispam-PRVS: <AM6PR04MB4792267306B4515864877D7AF3EA0@AM6PR04MB4792.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);
 SRVR:AM6PR04MB4792; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4792; 
X-Forefront-PRVS: 0815F8251E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(366004)(199004)(189003)(97736004)(48376002)(106356001)(8936002)(305945005)(3846002)(7416002)(54906003)(6116002)(7736002)(6486002)(81166006)(6512007)(478600001)(2906002)(53936002)(50466002)(68736007)(5009440100003)(105586002)(55236004)(6506007)(2616005)(956004)(446003)(11346002)(36756003)(386003)(16526019)(316002)(476003)(5660300001)(86362001)(66066001)(186003)(44832011)(25786009)(486006)(16586007)(6666003)(26005)(8676002)(76176011)(50226002)(51416003)(52116002)(81156014)(47776003)(4326008)(110426005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4792;
 H:uefi-OptiPlex-790.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM6PR04MB4792;
 23:cFYPpPGGe2+BGnBwUqW/FRp7AUH6IfHnj25Yp23D9?=
 =?us-ascii?Q?o8aHkp7HJwHr/zdPCbdQAucRsBte+zTxOvzfUNvQbiowmYY7hv3aof2Hp/tR?=
 =?us-ascii?Q?CCoWNhJYcMdha757W+JNhCfIBl9y8W4t/H7RQsTy9T2AZm6VgJ7eFDWTRD0B?=
 =?us-ascii?Q?NNa5X65RDW7f3fGghhUCpI3+6u+aEgIwKbhKn/T/mpVrxHdYaqAlLazwZLff?=
 =?us-ascii?Q?GJ4FNStY++HYFC1TG3w6yeHftHuqRbRefKjqw34KTySjN9AqzWSvr2bR7Yhp?=
 =?us-ascii?Q?fhCvXpuBNltI3HUi4wyHjzBvP2aCbwuYNImn+sLjqKVcNQprgGq1TXyfARV7?=
 =?us-ascii?Q?9PDxih5+vKdjuyzxqoNsAOR9+pAc5iXIZN66NyDgiQxvumqR8RU4iPASZc4h?=
 =?us-ascii?Q?X8swFmdKAC0ZF4bnQl3K/QdFeZhTF3pMjW9rOd4NT4O9uq2gpekc9wRmdNrM?=
 =?us-ascii?Q?exbNy+jg9gZfb2UUO5oNn9LO8k6PP1vAbTvaJA03gMNHgCcBvqg1pck4tejX?=
 =?us-ascii?Q?cSofGgcBLVm+obDBoOwelRVc/9Q3HOf7nRGps5Hti8ygyPdi6ihLaRZfkKTr?=
 =?us-ascii?Q?65xvXAyJ+YmnY4+r+sopDVItMdV/tAFS+XMirT/6Ex1jG0eE3IGu2+OoKOrO?=
 =?us-ascii?Q?NgfMbyB7s+hDXcfpUUuIFQWdU/zkMOa2I9WHEXV3VfrrZc93bGLPFnx97wWJ?=
 =?us-ascii?Q?QJ66QxH8+JUJLZTRGW34QKRtaff3yHav051Gs1eD5N/7bklUqx/yPpbGnRJ0?=
 =?us-ascii?Q?DowdG2lrD0BQXvyv+/fHZWvG7TQDoWIdlZUtADvbatIlEu+lcL9tCQLxS5iu?=
 =?us-ascii?Q?KTQpwgXT2qnSfYUWfWLbQB6MQfnU/1nJYfquiuhScC7eIyOOu0a7xhYsCgak?=
 =?us-ascii?Q?NaXsz1tFuserhdSNPdAZ7T/Esza7tKlarTaOd6L2VmklUN4Ugapj2H4tNc6g?=
 =?us-ascii?Q?peAlvmYXf1valE0V/LkaSc2u7FWjtyfM2HMiN9m8ltCEd/TPSoOJjKAaIZKN?=
 =?us-ascii?Q?1DLucyuUo15LzacnrqlpIudU7WU9gckceW1LGpLiKcU5Ekzf6mPJzifOkCtS?=
 =?us-ascii?Q?4mnyGGZB1FB96Df8RcKOubZqhA8Aej/n1dS0qJP0ff3MuFcHDDP2r+VVydum?=
 =?us-ascii?Q?0Q3wAz3tY88OVXu3kW93Oguw7U4S9ijVYePNJyK9zz4igU4OgOJLDx9ro7QQ?=
 =?us-ascii?Q?JeWuoZKzwOKb7H+ma0bPxEnMyxiIcPf5V0yDtczFPn/IaYgQOs/aGgiqCa7S?=
 =?us-ascii?Q?ZAdLEzidMHvEQyRXzufCnTdD1MTydmNbGax4kogf6SS0Z/2yYec2cjHUtmAJ?=
 =?us-ascii?Q?fyiZZxrcj6PNGtCXWxbphA=3D?=
X-Microsoft-Antispam-Message-Info: VStcfQuOJgqW19Rwwf0izz407n9T/kAcfTs12QPHnXmkIojh1WApdLXxniU6phBZdluMc3iGQqz2bOMROu06+hPseMJ3GipSjrniDb7mWv6rWkRvYmmQCcmXQISRlF2AmeCojyM6ejx22boI8ZmkxiJqUozS0MTy/hySSk0JRZ+5+rjoL7vDmzV6JuFEDE6bBEHGPdoWo/BEaO/6p6nYlq2raq8TiyGT9k28ZU2VrceCOIemM1mX0pnBY23/gK1ZA04n0+IDGIISxQkOGyjVHrJq3ngWV5PfIAOYFRKuSsBLs0pYcdBrSZ7ePhBWZJXRZlCQ927uHa3jncNFgHJOnBL7dKOsJ/HswuIAiWQ0qZ4=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 6:tAae30KYK1se3axK1Svy6dkjlsWneaQhaCqNNkBmcCI0jxMUM6MynIBHYJk3i+O2z8KVgVO5ttHPAJwQGn66rYorEfbai2S38ROhlkg5ppHQaphV+NNxweZVYNOqBSqXupuB4gr8esc8LMNVumFyHi2a+Qi0r0yURMwri7pXWDr99obj89bnXKfDnne7ymKO/rSN6eqgQrZcG/o4kk52E1PU8FPRuOhlVYGtqxWsTXqRmOS/dyzpQDxVbXn9m82Xjqcyd1sJ97+JwCuFFlm3K4pqaxvBuPsUyA0+Wc5xw0C1L+xcTZuRThFYsNAfqc9sK6DV7nShiQ5kEr2/H+BpiNc5IYRVFHPCdK2awakz8Npdk0BG5sASx1pAiQBEOZmxeIKoA/OfmBMcQlDi3IK6xiPGuW91cxQKEPhsmwo48WZCDSXo8CKAVAC5EBonW0mjBnZoqfz0Y3i1TSCi2lrBeg==;
 5:rXEDrzIif4KCVIOMCs8VDGH/z6xNSun9xbu69x4NUTMBpMtokcts8WI0IZtmdbF+GVZgEu7X/ZC1a2pp7XC5KWOzCtAsSGd0xx3vVM1/FvtmcUB2Ey+vcqit4T9iVurHj8yaKUsmzeA8MVCcBxtYLatpSllYTOk74vK5AD/4j7M=;
 7:PPFdclUq8HHVIx6oZHhgIPVWC+AK7mlRQ4s4dc8YVwu9viPlMim70HEOs7uHjEe+kC64rlPnx5+X9fTz/cqA82YhRk+6NIcpGMWP1NoJwOkgztDk/Dxf/692/UpxiZj1SgAoyXzsKwHZ7diVuR3F+dycmidfoGE2F626K4XYeAHgIpSjBOPuCr4F7qJr6PhlT9rOT6g/3bS/JnBre9K5d2ssgB1cdqe49uvogS6BloE5gjZlvEbxJvNhK73vSXc6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 13:09:19.7835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ea4354-5da1-4ff6-2db7-08d629fa9b89
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
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Tang Yuantian <andy.tang@nxp.com>,
 udit.kumar@nxp.com, pankaj.bansal@nxp.com, linux@armlinux.org.uk,
 V.Sethi@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Add clockgen support for lx2160a.
Added entry for compat 'fsl,lx2160a-clockgen'.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-qoriq.c         | 12 ++++++++++++
 drivers/cpufreq/qoriq-cpufreq.c |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index e152bfb..99675de 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -570,6 +570,17 @@ static const struct clockgen_chipinfo chipinfo[] = {
 		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
 	},
 	{
+		.compat = "fsl,lx2160a-clockgen",
+		.cmux_groups = {
+			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
+		},
+		.cmux_to_group = {
+			0, 0, 0, 0, 1, 1, 1, 1, -1
+		},
+		.pll_mask = 0x37,
+		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
+	},
+	{
 		.compat = "fsl,p2041-clockgen",
 		.guts_compat = "fsl,qoriq-device-config-1.0",
 		.init_periph = p2041_init_periph,
@@ -1424,6 +1435,7 @@ CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1088a, "fsl,ls1088a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_lx2160a, "fsl,lx2160a-clockgen", clockgen_init);
 
 /* Legacy nodes */
 CLK_OF_DECLARE(qoriq_sysclk_1, "fsl,qoriq-sysclk-1.0", sysclk_init);
diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 3d773f6..83921b7 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -295,6 +295,7 @@ static const struct of_device_id node_matches[] __initconst = {
 	{ .compatible = "fsl,ls1046a-clockgen", },
 	{ .compatible = "fsl,ls1088a-clockgen", },
 	{ .compatible = "fsl,ls2080a-clockgen", },
+	{ .compatible = "fsl,lx2160a-clockgen", },
 	{ .compatible = "fsl,p4080-clockgen", },
 	{ .compatible = "fsl,qoriq-clockgen-1.0", },
 	{ .compatible = "fsl,qoriq-clockgen-2.0", },
-- 
2.7.4

