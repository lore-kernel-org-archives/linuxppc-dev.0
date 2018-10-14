Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAD_ENC_HEADER,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A071CC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 05:18:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1740B2086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 05:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BN9O0slt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1740B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YRYL19B3zF38m
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 16:18:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="BN9O0slt";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.3.59; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="BN9O0slt"; 
 dkim-atps=neutral
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30059.outbound.protection.outlook.com [40.107.3.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YRRX56b3zF2Fb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 16:13:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNAoU90hyRgTYmnBg8AmWlGc/EOTNs63c6mLi3C6sCI=;
 b=BN9O0slt5WyOFV8Be8uG+INujBPpa93HD9K1NKKtAPjm6aFIA+awqW6wmmbVixRt1ZxkNkC9CHYJl1XI9p4zkLelW2lrd9yZ2jpy9vZlyqbKP6jYSAfA/KyTm+7gRSlKNtlaXTwre7fEyVZ3f18amEgEpct96GxgVjVEnk9ZKpc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 AM6PR04MB4790.eurprd04.prod.outlook.com (2603:10a6:20b:3::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 15 Oct 2018 05:13:17 +0000
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
Subject: [PATCH v5 1/6] dt-bindings: arm64: add compatible for LX2160A
Date: Sun, 14 Oct 2018 22:37:58 +0530
Message-Id: <1539536883-1928-2-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
References: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::22) To AM6PR04MB4790.eurprd04.prod.outlook.com
 (2603:10a6:20b:3::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 577cb077-aa05-480a-b780-08d6325cee21
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4790; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 3:+oistKxic8FzJSN5V0SH7F0QM6cYO/95G5UX1t4ez9fvfSBuAoAUg5EoaYDUFmvmjxUNuMJwf6s1yrYf+nWUGwUXFrXD+691gok/neBl8fIbpxGAY4J95ZvAmcRHe8P5XNGn23x++wK+jRRCxjmkekz+s+YqtKDlymP1znL2YsgAOhirlmE6Exbax1O74jWhf18alijKbFm+zL57syXfzy04SV9/JqftphaaCs7H3g12HqOreyIx2djsDdQawA+/;
 25:HC5XM2iTboNhgWnqwFWRASnBty3ANB5jNOBmLMzAfuaoXMRa6tzbfuygdWavNoa6YnIke7+d/Vy6Od110dRKkSWX5crWIazhV6+LM/JpxQcYP+k6V3s5XjsbhBKRMRFr6qcy+infraJ4wljINRPjgnuqotpaGHltc2xHO8Yyr+BKJCKAtjwQk+s3dQ3icmIDM7KZUWkBJUkAOEv5F8TMJYA7DptObjAqDNwdkqm3OqjBkbYC8ZvuRdrsOtG3Jz6iim/lTSb4t3JHlCbXjMHL7/ENvZgVIx/yKWOEdg/CmZWGj5CC7hF0SJvaDhHeb2EypuHh0iDF4c3zPUgXl9r3hQ==;
 31:lRiPckwJD8ZhGbmcrhwrDBpiDUg77Kx6ifcPdBeVGK7ZyTf0zkdVqZ/rZgAZR1gB31ynhc3zcflQYXjEFscWBMvdE2vGF5aTPkzA2FTbLNI2GZTCKzAAjsx8NsDNV/7GVlCY5nxki2cUFduuk0PMQfUUWc8Wl1Mk9/oQzPEUxbiDEOB2w99Fd0yhpBa7paDfK7CMZiplwOQNe5rUAN1nynFqxkzPpj/TYJYFv8poYiQ=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4790:
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 20:YuN6/ySw2PR94FFnlJYCgww8al2JYFoR/IgFvNwqWxMSwTL7Z6kmC9AdmC8qmrGZO9MxorPvFtEr9bLF+MKvsr86CdVdkXiQl2xCUxswV0T0lwjmf3onOcHbPPkN3kjCAnWu4gqCQD+p/wGfzA1doSQ3//Q4XoKS3oQ4j6pNjT/Xxb9F4EpjkVcJJ7bwNhZ0kCw95odNpr6Y3xO5UjN2FC1kmDxEIdF0MDun7X6EmWv9hjmnXP0tHCIVZRJ4two5+1ZPjTjWoqQ2vz6uDC4tS8DFpMW7udTfzPJLBtBXot4h9bWsD0fbmNqG11KeMC/FyAcQRtWquz8sGQTX3SssMbFrd3nqQxv8cfcxjBEtkOK7qmAF/DKxMxpT9Iatt/Cg3SErpKS19e90+z0xrn/dE3EyR/e1ExVjPFoctsuf2raPAH4xl5BlJxLtscrh9PqjXPO5cDXg7+Hv4EvMXM5eZGl2ZGNk28wGbn4PDDFwp6YbWHK+XmR6DfQYvfWsfJqN;
 4:uXLWviujzmHmMXU6SPWN2D3yRwXitU07lak+FlS/g4QI2dAXagLOrEfERGfDuKCeSmoBpU2L6KTco6mTGT36eSshB2PUWV0PxlPPmymuRz6VCeSD2iAaobSLt3cedoOhYppg3D2pF9jmkvQGQuMC8j8LqJORRk4sovat3msn7Y9iZ2sTJ2oOSfeTOn5gzgBbwL8FcficKYYmYKWKi1OK/KKtwRG428BGakiYuVQo3MTBA7QjMEWWUMh/lCSMfrVb7ukXOq6ihVJopQjAoRKKV1mXKnC+8vC64qXAEa1Vcxz6C55ceNbtPruxXftHe9F5
X-Microsoft-Antispam-PRVS: <AM6PR04MB4790AAB37F5F5EFB9E752076F3FD0@AM6PR04MB4790.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);
 SRVR:AM6PR04MB4790; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4790; 
X-Forefront-PRVS: 0826B2F01B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(53936002)(478600001)(6512007)(2906002)(52116002)(51416003)(3846002)(6116002)(1006002)(86362001)(14444005)(6666004)(5660300001)(316002)(50226002)(8936002)(8676002)(97736004)(68736007)(81156014)(81166006)(486006)(956004)(44832011)(2616005)(476003)(7736002)(47776003)(305945005)(66066001)(25786009)(186003)(16526019)(50466002)(48376002)(26005)(106356001)(36756003)(105586002)(446003)(11346002)(4326008)(76176011)(386003)(6506007)(55236004)(7416002)(6486002)(16586007)(110426005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4790;
 H:uefi-OptiPlex-790.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM6PR04MB4790;
 23:LRHZZIFK0Zc+m8hYyzasK8mZchHgZYlwj7kSfR6u+?=
 =?us-ascii?Q?+ZWnSkIxgvKiUqUfeg52pfpPkS/U/F5ko6cfNi/WDBHut0debmPM9+u+pcs9?=
 =?us-ascii?Q?5k0jM9JtqaDahEiHj88EAfWKDzegC71OV4hBmMPUPLBuNfcebzpY+QTzdYNe?=
 =?us-ascii?Q?E+Hk50HMXBSM3T7YYbB/adHpx0zHhYasPpbFg90SkgqSPSCM5y+33h/47Jbq?=
 =?us-ascii?Q?iI3xG2MfQcZk9r5FxJtrIuh54NQHMTDgncrovDt81utf/xBlYuTE9kfEW/O5?=
 =?us-ascii?Q?/tpFPY4Q0vUJtZMC3nlBjfNHxxoXMEuJcKHPPG50oSeBIjCkYhkCIsbKi0ld?=
 =?us-ascii?Q?J1YfH+t5KGhCefMocQZr7Q+Uip6MJnGJM6ySFZSjoy4gdEZP/qhSTyUt/pfM?=
 =?us-ascii?Q?Eg1TNC8CZ2X06c0KD2dRN3WjH84hRb5gtLKq5dTUs/HUGfYCjXueIe1/GvRQ?=
 =?us-ascii?Q?nNeH1kvImGk/Z97PNfiuRL4m92JT+8DLSjmhQ+YGcWAPUU1mxOgBMP3OiCwg?=
 =?us-ascii?Q?5sWYcLsX1bAPnDMATORAMEEBUr0LDC+yYhjT+CatzrqJd4//jL12TAEKup86?=
 =?us-ascii?Q?4u/+nI4v9gSb6x4X8LeJekMuPS2r1P/h60YUZ6LYf7OZiVfw+bkTXQTnfRIu?=
 =?us-ascii?Q?JPK6hiQ3MbjC0gpuZfq5IQctvkN1Eq1t7/9uhZ6VISNOoOYCLxbO7O9tL/oA?=
 =?us-ascii?Q?uCNpO/brT8rXbrDQdpJgrtv2dy2OpbKdk5HSBlUFBXlbp3ro/xn0k7xGNDxc?=
 =?us-ascii?Q?9/9d0w3576haigXxhBssZAUl9vc1p5RmQ/yJyep3QKbVTb9PVkXraYK30vNj?=
 =?us-ascii?Q?AIK4+sKmsKZUoCYSnExhN+ftRgq1w+3WqQ3DCecsXUtmfidQZB6tRtTS9qc5?=
 =?us-ascii?Q?nopUXkZQbw4oz56mJ7Y6cxQaJRpu4T3oWz8MBs2Zvp5XUZICkSHBI4Bvg8Xq?=
 =?us-ascii?Q?ccEudQCwl/9rZKyru3ZtWlZdxp/quYtqzQUu3a15Xjc1lsaza8u7Nt20+P1a?=
 =?us-ascii?Q?8GeAG+JeU9U4EfWTK/MksLECoz8eV61Jl36NNzoHdDHRtZwlzmdbDNUROaFm?=
 =?us-ascii?Q?PCfb7COkE6mEaP7EAjZEvXaRW/ywK90INO3mcsDvfBaUSIUaTybRYejfgPR5?=
 =?us-ascii?Q?VOYY9tnXPOA2cXqX1hyyqVvRNh8boIXaNVITqsYC1ahcAlXdlBvcBnjw6NUE?=
 =?us-ascii?Q?LM2oj4lJVA3DNIg71qGrZa9C8CkJs3QLfyAe4dB+s5bF2rXYLPxzWvgWS+OJ?=
 =?us-ascii?Q?YiSJPvn6h/YxOldEuSDGM+wjKTuhkhBCRqfrbbZmzM0FF3XPFEP3zwIWvqVI?=
 =?us-ascii?Q?pTHiI/l5FwRhxqmamYnwPY=3D?=
X-Microsoft-Antispam-Message-Info: 7F7Ry42xNiO2BShxPj4ORJLufw4P2kimvgnYmiSZHV0wlz2OsRv90Lj/fl2vw7ten6fzp4QQN5S0H5nfJPMdtppWN1gIEjZZYyi/W3+b/OPnn7hb30ALmuuS0nKOZhshIG/hbFAW9nBvNbcvbrxlpDhnS/Hn885RQKc2kQfQWAI2ja3lWOnFwTkHa47h5LH8B7lJ6vJ4k9p16VSYaF0u1woW53jeSnC59zqCoFMUtpuFjZp2hkEhR6liHy4b+bl7bANb4Yo6QKjKiZ8dsxjB1mJu1D8P+6TcO8uGsvzb0nIXoyNmBFjUeA1QhWbPa4kcKs4W3beuQ73uJ3JUWLuwUjxp1HQPOTt2VDSUwdmpapg=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 6:LKquQBHdteXH9YYAaBRInM8R9a+LzC5bhWscRZ30t/hSYyNsUFGKfyaG37+bpkhodLYnWPAhPCdnTiMPlv8IF6KD60wwu10+SGHECAdaQ7Rp8KUB5lSAJMIvinDnJMCn1hrF87NKXV8p+R0jaPewiKevBPHyOqxgMB0s/XXi34R31i2qPE4vci6ZArzzO82gMDcuC+O1Phl0lSyZ2kDc+wDxcaxhyL3YayJOSFQXtglZdbMlkDUagpfKDgSKUX4SIhU21vMpt2blJCRO1BszXu0jb4yC8aEbvm1Kvuw0+Ofv329DBKz1huT4NZbrDRnblWR/WQIk/dccWXOkwvB6wDG63YJpm5nq5apzpioMz1RbS9GwN2klfj6ofh0vCuboMyLogNMZoCcp+A/+r2MMt0Vzp1XE0l6BZIxNRgcQQLfAPVnSOMqn5jiZvAHrBzDuOjOyeEAJRk/87rQyACCwxQ==;
 5:PQMbEYVxyyQN0UeB3eTcmFRVDmwxEeYG0W7VIpTSNLlqdG25uxHRvo9IN7KiYQ0MmXGu9cgSt0j98/zDYhRDvwa/wkft2/i4/ZWV0LXLIu6q/m8oyM3d45ak41lCYfWFNvylf3Z0tQBKcu7w1t95ogeO7bVsOZNjm4qFVYUiSPw=;
 7:1lvav0WTe+eB41TtD4KeDF9K4xzJPSOjMaJNQpZzxIf5kl6ILV7vYsyXQTncuY9D1MnxKspswum0lSggNKM061aZIliuJXKoeM61eZLfyo3yr781/3V5PYAW3E/IjLhauLuAYrMxt+AT3l6WpN9shZ75OQlwP/5lSLG0L/EIZK30sJaO1lVAq8FT/4umhzeByHMULrU1w8YgHj60bNhZSOpZ7FMtub5KTfJMpIQxtkfg1PjXrgMhBIDIIPUbBtPy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 05:13:17.9563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 577cb077-aa05-480a-b780-08d6325cee21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4790
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
Cc: ulf.hansson@linaro.org, udit.kumar@nxp.com, pankaj.bansal@nxp.com,
 linux@armlinux.org.uk, adrian.hunter@intel.com, V.Sethi@nxp.com,
 Vabhav Sharma <vabhav.sharma@nxp.com>
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
index 8a1baa2..71adce2 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -130,7 +130,7 @@ core start address and release the secondary core from holdoff and startup.
   - compatible: Should contain a chip-specific compatible string,
 	Chip-specific strings are of the form "fsl,<chip>-dcfg",
 	The following <chip>s are known to be supported:
-	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
+	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a, lx2160a.
 
   - reg : should contain base address and length of DCFG memory-mapped registers
 
@@ -222,3 +222,15 @@ Required root node properties:
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

