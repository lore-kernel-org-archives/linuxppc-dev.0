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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE36C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 05:26:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C5920881
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 05:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OsXYytUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C5920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YRkM4PGmzF3BV
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 16:26:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="OsXYytUt";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.3.56; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="OsXYytUt"; 
 dkim-atps=neutral
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30056.outbound.protection.outlook.com [40.107.3.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YRRr7532zF3BT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 16:13:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9hMqqThZ68alsJmloQ2lTVQ1zkW/136SvAplbvzl3M=;
 b=OsXYytUt6oiagcEbSy2CacCmr+bUpUYmEO/rkM5XmogxalWtc4327yTgU6YEaM3QkVbzbn/oLEyAHSxewbq2l8sdslWsd+yJns7qEOXfjEzVsYCH6wKUXxb/YEMu/Tqr/6ZAStJKuK+hcpUPcj7++WzxGC/YN++uq4RN9zO7QxQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 AM6PR04MB4790.eurprd04.prod.outlook.com (2603:10a6:20b:3::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 15 Oct 2018 05:13:35 +0000
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
Subject: [PATCH v5 4/6] clk: qoriq: Add clockgen support for lx2160a
Date: Sun, 14 Oct 2018 22:38:01 +0530
Message-Id: <1539536883-1928-5-git-send-email-vabhav.sharma@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6a2cc02a-4f06-4915-a633-08d6325cf903
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4790; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 3:sDHDGzm1g5Lv8jctNE1kZXVF0VOkownX5ijgjmZRmMd6BF4eEQHrAwk64Uqcnt8SpOdK/vHJUBgLx+gNUtYRSdIje+uKmBrSMX82J+IunnfG7Idmfvi5qvgKAA9uiJV1HduHZfQIL6fYo1avVvQt+Rqi0rR961t35O51URUVW3byGo0lrsAs2Gdyx7Ug/O9Ibjt5/h1qDN2zAUOsnurI22jYvAJzm7ob9Y2gtRHHZkmwEjEWrUPSotAg5OWZTz+/;
 25:zNGSq3dyQZK1yoasLZBPGteTlbLxr28C+vqkJVcgIZw/l95sDGr7r018mFa9yZSa2lzc8mT5O1IOGDMf1uotF0FgPmKtHKQwvAcHzwYvIR4Lmz7Tc1Dwf1mrLAp5wPKEgbiW9j2fiDgvWNJq0FYh7wyF7b5Nn8kT9pGMaolWK++fVlK4VnX9MCMJgB7e1NmSlJ6AqzDL67HGrgq44rMn6uLP/srj63iv9AzNYiX/bPERIuHyb0zIdrXL0NKyI1tecMZ3lLNaf3z5piPdXtdNCmKKMOX9lXO5yX88LAFsZprY559pkuNOAIRknpLbs2hZ0kOgikWMaXkY49pVJKsqlw==;
 31:7UbLQacQ9zS/rtPf/dmKu9GTa6d79kpdkege7q86rJ6SY+VwyHlAYj0M5XP5bMtqIaOLpuqEk4m5tZuS9xFL4mJ53ST1D2yEeyBxoVHpshXC5xTtAVEPfcJQQeWZhjFNUl3wFXN5ryYMVTzGPvpEvHAQG4mCCH/e7LBtt5mHEpkoQdJVisAuASITM3lXDxkildMs/YJBcuyr5L6IRcnLqq/Z5VYLsI21BFBGGd40Y48=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4790:
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 20:kDqT82M2nvsI9UBf/UIqA8URdS80k32TevElyGvtAFtA4NaCIYjNabysCCRReKsvm/Yv8LsvBQLWGyEz15TLJnB/ZIBFKeDVPXdjJ088ZLFzxCYN+veNNSqai2f43Bkr8x6Gphiswhmap1icR5LKXH3mv9M56HtZOf9/skYz0jAGM1mPPjA6M33E4h8snPvwTNtFBRnrD+wIM68BqwPa1UkVT5tRWVFAPUksb1cDBOr97Srm6vb7VUYA+vBfw/l7G6WrrKnnPosBi+jGqZfTdLYOIVr8Jk2EKVj8W04d+w1RxFz9+EzxNAVpAAn0tdkaW/Zje7dKBk2eSeTN/3fLiLTNOzB32LWjJ0vIm6iP7ym1/kcdXKXNJ+fsRyyz3XoSqMOGrZXIcBTBj+EbLPen1alG+JFeEFw/icOis/h9v8MwkHYk13/kRRK8C3lJkpvED+2h1HGJEKttPO3uAisjof8v7TGcV7sztpPXAj2dQaTQc00O1GBwvfjgdftcfAFG;
 4:DkPSKgF0ZS3qGC71t+qoYzjtZiMdcSy4UXDqVIk4iyw4o8iQXIIpdbaB7xfueP8SbOCNnIHXFl3lEjXVPczeW7halvavXW9zgUYXthBJv6IM4q8BzmIWf47E+PnxyiMJaUV+JnwWSHqKsx6ezKh0rwNfHVGXlHSHh8N98uDJO/4c5U8ojDjXFyADyjk82E2eOc5cWVo1ggNyh8RAGvNQd5lOxDiXVVbezYB9jIx+7cUiWX9VG5KINw3E+QVhegVw9T51e1ABQVnvrBzdnqU47lJUfkDIDqytoHJvJ4Q6eTeyEZzTBs7hL2FHVXZyrD0S
X-Microsoft-Antispam-PRVS: <AM6PR04MB47903E8459A147431CFFB1FCF3FD0@AM6PR04MB4790.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);
 SRVR:AM6PR04MB4790; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4790; 
X-Forefront-PRVS: 0826B2F01B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(979002)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(53936002)(478600001)(6512007)(2906002)(52116002)(51416003)(3846002)(6116002)(1006002)(86362001)(6666004)(5660300001)(316002)(50226002)(8936002)(8676002)(97736004)(68736007)(81156014)(81166006)(486006)(956004)(44832011)(2616005)(476003)(7736002)(47776003)(305945005)(66066001)(25786009)(186003)(16526019)(50466002)(48376002)(26005)(106356001)(36756003)(105586002)(446003)(11346002)(4326008)(76176011)(386003)(6506007)(54906003)(55236004)(7416002)(6486002)(16586007)(110426005)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4790;
 H:uefi-OptiPlex-790.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM6PR04MB4790;
 23:5n1NqLOkcyZ+1EG4BI9TneCjjgrPKe4oqbDI61xYS?=
 =?us-ascii?Q?avx8LjMKPOpXeUzAhZFYGQ9VOMYTB91Jf1xkX+yHFHdiUTmBzV3LWvCk2P85?=
 =?us-ascii?Q?caC+WFrqpqkpKbmTAQ4d50StbQxRKZEbXh1OoHxgSs69wf4PFb233BLxLPm2?=
 =?us-ascii?Q?GoYEjJOkqnPIcmvLKTHXYqTbBWvpQ9/UaxR8OIajSqlIT1qKzZbJcZuxMFTi?=
 =?us-ascii?Q?infUAEtz2NQLHITYJzab4t5w7h7CpmdpIfJoGvoYIrZSI20sjs/+zExctAu2?=
 =?us-ascii?Q?RZnmnq9YsBNwexMsnBlfDhqOU1nVqrgbRQjAkeXINt6liWhjBO8ShJzrvcjh?=
 =?us-ascii?Q?vRLVJ6LuqgO4P0nXbCBSDAEDJ7bFKk3T9U3gjy4icbSANIcyJ/X69YTB+Sd1?=
 =?us-ascii?Q?QhQeFfe7VrkPnrQ48Z436IrlYzkyQGH22hU882AEt3c3mccbBh4jwk/CPqBt?=
 =?us-ascii?Q?shBPckIPlgQ6ad9YM5yHy096AM0IMAdeIdI5fi6iKEbYctCPHmeV6GBNkCA8?=
 =?us-ascii?Q?VOi4X8sUwceQUJm8Zw0HFQ5/EW2rt5fe+sK3iT18M3ZrvkTV2Jnr2k7Xxsbl?=
 =?us-ascii?Q?igOrvr9eki4aGyfRsoCccaycI3sBKHNSg2hYLeRqvzcKFo3tcScz4xx15GlP?=
 =?us-ascii?Q?CTMY6JbVuZmWG4S+ZMX1iHc2acJp5dKNVyRWOW1fb+PJpPYNjk0zUm46BvQW?=
 =?us-ascii?Q?3r24SXofoLuSS8asWlwhMgPXlFo/Sl5879EicQ5CI9eBoFBMxf+2+Ze3n2L8?=
 =?us-ascii?Q?bT/jk/zHflffC/mIdSHChjAr+QvctDFmDBftFfRubqeMv+tsBMp/tZORf3Br?=
 =?us-ascii?Q?KdLjZBfIUZakUzyE/3nyd3olXUDLU+Jkc497jKaGYacyuEA9EJiuL4hrh0/S?=
 =?us-ascii?Q?yvvRf2mhoAoxeiFExYUTPymz8EYX1aB0NqrRHB6n0W5gs5/zjgnrtc0rlJEv?=
 =?us-ascii?Q?eMq35eRUq3X5NCTn6D0sJGCN1L6ESPb+7x6oyY+P5g3A4ZpxPqhKbLJ/W1Ep?=
 =?us-ascii?Q?rkYLLb2kIyvH8ePSZ2hfwxteMbPJYf1EuRju/3/bhghsCKyqdMj14DMFcmHt?=
 =?us-ascii?Q?SLsxOrGes8nYm+rVGjC0AZa347XcNj1V0GpXttL2lbJwgroxMU3lxScER9b8?=
 =?us-ascii?Q?ub5yeCohVXyUx/K6aiahZZNJvsmHyGJWQB17zhbvjxoYwgvoPCWuDrNyIGgB?=
 =?us-ascii?Q?qf/f+OnWo1uiEopPusJzVSoSKAXX8LgaUgtjafDx/toBtJqEBMIgoaASX4vY?=
 =?us-ascii?Q?rVT2HvxF8J3WhJf099ezu31FNwh2xvDPqnXTu/LTWO4XaWey+mhCsDhFjYNv?=
 =?us-ascii?Q?+v3UqFRnecJMCdRMfuZAY5whbfr4On4fo6OQcprZc+UL3KGoz/q/4IcYFTkC?=
 =?us-ascii?Q?8Rqyz32ofHitysg9plnd3kvzzR9UzU/zBqKakSLXWSL0edj?=
X-Microsoft-Antispam-Message-Info: L4zr1VCersf7u3xIfLXsQDQ/Z48tqm4zH/oRJe6ygPTZTFAviD/SCOqDwpVbm/dXyHaf1oa1abWcZQKQ9BXp03P7KNWkAORDvbZTlXFNfSSCst6Jz4NpiwTlfZy9lpMgkSXfuGexg7jp2EEwmUtx1ikXYwi23nnEoDae6Or2/O/UDlZGf03V1bNjFOUtYRxoXaNZCP5HZOfrafFACf9aVxh6COpOyJhJPqq0YWDOuQH7GR8RpuPSm9Bt3ELYOrUGQUnGMKTwxHFVuOA8dELjOJdViF7JqURSz6sEB2GYIlo+2RUOG50sTsAGAmfbK24O8u0k6U4UZkmPosR84WiA+6lS/C2VhrsRk66N8HM8hzs=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 6:10ulJmmopEak43GYD9EbHqX9O5inzN+iGF4fMBUXlJEw8RDQIZCYxqgaO0K0V3scDwfn7/gbxiqkRnJMZLWimez7+J9EVkd1efYWvBp3ydXuw/GTu59ylKFYk+1NddwQaGqQ5XyRt0TA+DN1mUiOnOHDVupq1RBr08uo1umzC2U0qcfhitiv8nxEnPpuQ7kttiiynF0GnvIlLeXuVOB+BYVbvxOVrkUOwjggGL14J9SJCCLxItuafc/Bt6ENbQQWPpWG1aZmLEnL8wo+ZR9ADbgajclL3OthPsKE5cr5jAHJ/SwPOCKJ4Vo8nIBZwPtvZwPxAWpbf099ne0snJiUzZKaQtpIxH7m/d6rrWHkwlf33STEdOGwvmBlzoKKrokDSGk0aw1PNz4iiB2bGgrl3OVciABH7hlwrd81amyAmiwrO/ngp1jOXLwhNURtsqwjS5YNnVJd0Fl+rn0wyswVqA==;
 5:XgC6kvvTpA+8rWiLlZQNdNO3Wz1lHM/CkWrgZwxpkSX36QnyLFJ5BUb4zPf3f/RLxopxi0M+73+NlrKs33DtKuHra5Qax9WPysoBLOMhzLd/1uncV3jmJbHAGWCI4XSbJmu1Ogjw9hazLgd62mviHMAFtiELu56HBgQdeh+JC6Q=;
 7:8yYOEab/+HHlwhNoHnxs+r1bmR2xPYyUAW5Wh2oxtTGypoZ5FNEEgxBlGtpF4K5vOGu/RACsf2H7A3ksuP9MHSedk0z4rJE+PnLcsO5aKqTvkokmQj/k+isKE+iFtF4mNHTZ3l3LcNyNTnEbNyeuryB6FPlqvxHeyb173rlLr9FxvwHsG5+zmgJk8yOpRfUsmoO8+YyKdzBDCKACa58KulER6SFGJvCJPo6chDW9qxWwLx2QFTcyr0I3Iexm4uf1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 05:13:35.8799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2cc02a-4f06-4915-a633-08d6325cf903
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
Cc: ulf.hansson@linaro.org, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, udit.kumar@nxp.com, pankaj.bansal@nxp.com,
 linux@armlinux.org.uk, adrian.hunter@intel.com, V.Sethi@nxp.com,
 Vabhav Sharma <vabhav.sharma@nxp.com>
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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

