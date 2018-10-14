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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E151CC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 05:21:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3942086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 05:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sMo4rQZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3942086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YRcY2DTszF3Bw
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 16:21:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="sMo4rQZn";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.3.88; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="sMo4rQZn"; 
 dkim-atps=neutral
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30088.outbound.protection.outlook.com [40.107.3.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YRRf5b53zF368
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 16:13:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjnCvdXK2QMVfPWeuHFVfqbpLGYGdcbtuwcY11WrOpc=;
 b=sMo4rQZneahSjDVj8uFRsfKndatawOISuinTsOSZO/udlRFIi9m/kFA/OJC8uosgUDyodihDQLUj/la7V2UeJAQBy3yiHoVLPmoLfA0pOeYQdK7WcZYo+87ubri9UXICnC1joCArhbW4UvRVYV3BfD1UaLl6FA/cVogix90yZYA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 AM6PR04MB4790.eurprd04.prod.outlook.com (2603:10a6:20b:3::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 15 Oct 2018 05:13:23 +0000
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
Subject: [PATCH v5 2/6] soc/fsl/guts: Add definition for LX2160A
Date: Sun, 14 Oct 2018 22:37:59 +0530
Message-Id: <1539536883-1928-3-git-send-email-vabhav.sharma@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 654b50e5-28f0-4e62-3ff1-08d6325cf1b9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4790; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 3:Zdr9cJWSkLvLL2AU0Ef/Lx3Iz64S53u/0+WkFr5Vui182ASw2ZSzr8QJNEmeRJ6xgkw3WA8kdXzx190PVBPQolxsxrnYncK8QoX3pS0NKrEz2gpTWfvko885QLkwMG4Dq6F1+PDLfekx9pl/ONmfHfp01R/9puossHN6fzNqnsCkDB4o4iBS5Gj4A2KuigLnJfB+aWs+NMd39tTdBmf7wp9i+n0nIyehBG6GHtVXztRNMeUSXP7gL/rk8Vz233AJ;
 25:80TBNJQug4Rjh4cjytOTwmYM00k/xQx1QCWCW95YLxMU71BoD3MLHtXiakoMgEkKaoWuah+9ojT9qzcE3k+u9Hz8ursrgWMw4Mnf0d4YP4wnGTTqELa7WYEv+PLEdV8WyGcTkx17QqyG6o7TMEvlraJ0aiTPNugftPkAL+iPXWq8/t2c7NkwhjkqXjNBQl4gCDOfb2HlMjqpCccpJWh7bv33ujksCXLDt/AC7G0nql6FZn00fisfZzfjeIZlrGWSTEKELa3hmSGYRB7q06RQSQF1YynW9IJZ5HpbmCmqmN56SCUbdZltA8eYM2usLL1ydhbZ73/+riU385UxsYxF0w==;
 31:Xizn4u5TIyih8cjyFDU3SrvRiwyQXpJ23Tasn1nQfAUSt9DmNhN5ont/+O0iCTnE96B48nnB/exIpuDlZ1xziIf2oRKLEivLk3g4TPBGeT6Wqp0H+vt50Lg5Dxc2WBLKXuvwtcgl+AyG1/BDSv/WFCUlH6HdktPhvvt1cIS7mkvncwCShIuDKbd59VdjIBj79hdyYYOaPE6a/yMFVtSiLewBEOaqk2g61eWliAcG1sQ=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4790:
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 20:zR/Vib1uY7iRD/iiyNqhtHHJllDWKGHbHLiDEVv40Hd75SKnk16J/epWPztFKw1IQgJh1lJranS/pkD8pbuUIWo8WjVFHgfWP9ShxK1Ru8v5mhQ1TsCiuLmX7SUAf8GcLk675VRiXu4c2CviPwhxAEliWiuPzJLWXWHINv/DgBByrimKpvbndfDaRtI5CGZ48OhZAdvgJX6s4wInM4mpFCNQZvgmviMYBfDOZwvd7qMGdxC1GeTEdBSTRAGdVh3vl+aKA2d3ZcG2vx//PU+ekaD8h94vZEMdG3+S5Cr5yISe+SBt/keNFoycG8yf7eNduEdjFvLvxDl5aCy9Ew6Z4E9wul2xX/4pSg9uXfdMuo+wW7fesTFN6C64UE/IMWZ//EYEjOvoUgi62A6XWBIyoYGyhXwXCgs7KeNGnt7b2cd1S6aCDGwTaTmSbt9ZRwJV96eLWJyOniDKBEJfRKbG54IMEK9Q368JDpHtuiiDqN6gBBs9BONkdbLlyi4Z/C0c;
 4:Q8BphgMif1ioXNrq2uUmSNnDPXJ5FSCDnlRbxGQFxiPFYtr7DvvjK1O3ORa8TZW9zo+iet6J52df0+w8mlztdIapKJjkt5Cq+tncH4VMW0n2pFRVa53A7267RjTZGPAefgPrILtUsWKKuXwmqZNAfcpc7h68/VpJS3OmC+/Rdr41mUlUf5PRk2+SRTeO7pZt19coDMfCn64KCxiFrjMVFHfIBWmi1P8TZfYzSxg3x5v6U906s/qqfcH4qJgA+edf9i0byVqjb2FaSpqc82T1Rd8R729NLzb53m2A0ip1DkNsVFSBWC2ZcCAtMBU8hVuS
X-Microsoft-Antispam-PRVS: <AM6PR04MB479035EC0F5C9DD4B78BACD2F3FD0@AM6PR04MB4790.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);
 SRVR:AM6PR04MB4790; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4790; 
X-Forefront-PRVS: 0826B2F01B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(53936002)(478600001)(6512007)(2906002)(52116002)(51416003)(3846002)(6116002)(1006002)(575784001)(86362001)(6666004)(5660300001)(316002)(50226002)(8936002)(8676002)(97736004)(68736007)(81156014)(81166006)(486006)(956004)(44832011)(2616005)(476003)(7736002)(47776003)(305945005)(66066001)(25786009)(186003)(16526019)(50466002)(48376002)(26005)(106356001)(36756003)(105586002)(446003)(11346002)(4326008)(76176011)(386003)(6506007)(54906003)(55236004)(7416002)(6486002)(16586007)(110426005)(921003)(1121003)(473944003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4790;
 H:uefi-OptiPlex-790.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM6PR04MB4790;
 23:5w9qGiLpbJob+HvPyMm3VNQ/bPv7GLNdKYyO00HzG?=
 =?us-ascii?Q?kYpqw8ZYlg/JlFj3sgvyfnU8ziqgHxtKK/AQ4Xkw+oI56J3uE6/D+aoH/2Xl?=
 =?us-ascii?Q?naK7qDK9sBl9m/+Krm0kOkZbVMh8zkL1rHJKXs/5cORSPcedECouUDRpjCsC?=
 =?us-ascii?Q?ghQbejmqBoxHnm0kExPDR32BOkIJNT6Ji1ui75M+Zpnut6+sYcxODoTspyyW?=
 =?us-ascii?Q?yBE/xLMQUfKxoHtm4oV9vM/SJ43AMo6iU0aEXVP8XD0+9qBbLbb/1fazepLc?=
 =?us-ascii?Q?1glXw5RsVHj//RD2rtbfbn/W20XFTyPQWR9yxbjo+PQjFdiSi4Hedh9pOgvL?=
 =?us-ascii?Q?MWrN4kh1LyUjNs9FjuX0G7/QFGNqF0NaPLObAF/ZeR1BZsVN9oLMG4QHt1D0?=
 =?us-ascii?Q?Uj9QKzWJZ6rLNUuYhNcq2jnU/wz9AmPaq7lB3EEr6nXJosu22sq8Z2yWsGJ4?=
 =?us-ascii?Q?+uPiCEmzOP3942IXf8zYrZxty+YCAV3PZi8JrCkkkIpZPqcoZ5dMNRmiqIuG?=
 =?us-ascii?Q?vm2SSAHF/43+BqNStda6psXCFJ7NXWT1mYB0YIjwcraYxGtFvDYmjDydx/tS?=
 =?us-ascii?Q?Y1Pw/DeHahbIpHfGjZGF6beckZwHjZmePdYD+EZvIZi7TO6B8rsuwAkyJknB?=
 =?us-ascii?Q?of5o0bHIHzTu0HGds+rP6URDw8fQfGBFS1vym/nXzo4s9yvvX0Zw/CaRBKvp?=
 =?us-ascii?Q?X2viVx1yh/H8ir5fH6U4tzjYFKeWEV5/K2ojaBQSTpuzHaYenzTn0Ln2A3Va?=
 =?us-ascii?Q?8WL0sQjOiTC7mTwQdVr+DJiTkmz9V2TJtKy2/xN+0S0MzG5SwGMKcB4rfHiM?=
 =?us-ascii?Q?UYJ96cP6Xt923QfeVCSsgqb4un2j/ytlPORnEjnAqeKL5u8Fd9L19darOLc5?=
 =?us-ascii?Q?a7mIDepMh+qn6KdXpFt1fWBgNJbxsgY6Q3VzEOGMNk+d1Li96ppS13K1h9bz?=
 =?us-ascii?Q?2HLLpD0tTZMNUmuTllicYiVgJGHDrnq8rXKxD2B31juBX6xd9Vj76fPsYaCa?=
 =?us-ascii?Q?8QSlmOxEFRoa8ZiMLlIS4fx++9ih12SXwhA6VjBEH+ByiEEl9bx2PNYdgcYQ?=
 =?us-ascii?Q?rtXo8xpG83dx+5H3UX5hTuSoqr9BFxGzxFaN0wn17tKim7qOdMDxs/VJiFFd?=
 =?us-ascii?Q?iwpT2eFvMxCLXhoEDHTDarA9icgJEXai6otYst3N/DeP0TpkWCljMLO0AbFX?=
 =?us-ascii?Q?FQniS7EK1aoFUyVvV2uRwT4l2ZD8E47awLRTAIzNF83uh9X6l9z+0kpNwdd7?=
 =?us-ascii?Q?g0VJjByXFnMf6cIK3yIc8LnsMLemvnj8jO03NeS9bjyj9SOdw5xO2Lh0+Igr?=
 =?us-ascii?Q?rhKXaBtT/j04J3RYYE+7H4guFsQ+q6amMeQ5/9uPAmh8/SPgaYU/DR4q8qZz?=
 =?us-ascii?Q?MDsKg=3D=3D?=
X-Microsoft-Antispam-Message-Info: DUp6lHG4Img3UMlwVwgqrdhg0ANADyJ7ZbQpYQ1Kk9UoWDxegCd/wdZsAoTpm72pBWeHw7jC4JJBV2hAbohnZd2hJ9lXKjA6jVNg3Zg+6AkVmiqHFTXNpfZuGkt2MgvsIb4lyzlXsGFpn9vr48klB/4gjHXczmdQ/Jetxzvx1KhsTgbQBoJaWBND1IRSKlUCvXGomMUUnqgZHPpc/WlNQXiYfuL10khsVCCpJSCHmxfQW4U23J9Z+Z2dmh7zZdD0dKE7KJNwdAzNhxj7/EoTyj7PlYz8eb0NidJItG/+cdoZaQV5HYoOpRUN+DJx68UpDW/iXTNakzSufgkUAZdmFYID2I4PUtrXrY6WqUSQ09M=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 6:U6zBGioMjk9K81bv+ze3JzWffRC6PCcdTGzCYSLrcN75JNparfFMy/HtZmsIlwYIiGCwPHJM6UcVD3BDPPB8kIyDNZyWyWfUitWDV34bjp/WJu0QTr8vqPJL6ma1sWMknuUbZwijcJym676Od/SGeZhT4hF+kSRKg696up0W8pZlWv3hKy2iwH56SJnNmjmrM8giOTQKNanVbWYKOIjBRXt+rc6z813sMnVXEbSW1TwDe3ReRGqY91VUFPon2+NhTsqDhfhquvmcmhM7mPJmyN74++nPzGJHUG0PQFrlcFZtGyLbJIxT9ii8qmoXIu7H4ZcKOdyOb8gdh7qM8fkHTAi62gdEXsGA1IosKB1/6DPnr6qa4k7KhYnE94k1UyUP2G1ygoUACdC8rbjJO19xALHvyAzq3kzfl8nyJN7GktKP+emaJ8oPh6PUKl2Y0nrfzJ4oeAd3zdM4REELdHsxnw==;
 5:r6mhLzu5lPp/TVRmHqxG5xOu2PiaxNiBizxw2wYbL7nb7lV6zhcg91JJn62YDFCJptHqchbOGf66ciRGagilDAgfS5C6ARwm1J8TMaKrANTF+JsYOJ6L7awG0DTDbfXOWa17+8VdfLuPxr+hlWUK9PKF1c/SmtgR5lxYp/znQ8I=;
 7:FgS7RMBkF0ShTAfDWgeTibiSrlJnCzKxGPjaxE+Asir7MOHgi9Y5r8W2oT7dxeLvNPNILeCFz9iMLAwT3+E69ZzzeC5P/J5HX4oCa8WGPN1twwr9L25XrJdoCQQGNvKf/1cOPsuImkQRX+o39aprvLTIOyIH/f2vlbYCo5mzRKbXEzwnWFKzUCoh35qYgw10s7xY2NGKSC7J6xiug/+uHgrvpdWAsTt9F4HIEYQkxx+jSo+fHlV5oLXPpQIZTWfb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 05:13:23.8174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 654b50e5-28f0-4e62-3ff1-08d6325cf1b9
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
 Vabhav Sharma <vabhav.sharma@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Adding compatible string "lx2160a-dcfg" to
initialize guts driver for lx2160 and SoC die
attribute definition for LX2160A

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/soc/fsl/guts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..bcab1ee 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -100,6 +100,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 	  .svr		= 0x87000000,
 	  .mask		= 0xfff70000,
 	},
+	/* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
+	{ .die          = "LX2160A",
+	  .svr          = 0x87360000,
+	  .mask         = 0xff3f0000,
+	},
 	{ },
 };
 
@@ -222,6 +227,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
 	{ .compatible = "fsl,ls1088a-dcfg", },
 	{ .compatible = "fsl,ls1012a-dcfg", },
 	{ .compatible = "fsl,ls1046a-dcfg", },
+	{ .compatible = "fsl,lx2160a-dcfg", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
-- 
2.7.4

