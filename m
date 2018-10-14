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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D2AC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 05:31:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1567920842
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 05:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a0ga+Ewn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1567920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YRr971HQzF31V
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 16:31:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="a0ga+Ewn";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.3.40; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="a0ga+Ewn"; 
 dkim-atps=neutral
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30040.outbound.protection.outlook.com [40.107.3.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YRS512PgzF2Pp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 16:13:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv0EnvO8kXX71+WZmbyEZ5jXDcBP+JBLAwdHi0fq7QE=;
 b=a0ga+EwnM2cvO/zk/cRhNeMt/bdAmO43fpdDR10Rp2/8PEAZ2reJLcR4pOkiIuODKwMMBnVwk51L4JcXy90ETErozhp4hs4QmGJ7VDxmj4jbMyyicqjIJkkHnF+tTcCfK+pbrk4Gscxu+QOp9t7s7qIY23UIWjqzhq7/KmVCXsg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 AM6PR04MB4790.eurprd04.prod.outlook.com (2603:10a6:20b:3::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 15 Oct 2018 05:13:49 +0000
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
Subject: [PATCH v5 6/6] arm64: dts: add LX2160ARDB board support
Date: Sun, 14 Oct 2018 22:38:03 +0530
Message-Id: <1539536883-1928-7-git-send-email-vabhav.sharma@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25678a4c-bbfe-42be-7b09-08d6325d0165
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4790; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 3:e9DTD8B2hGAeKvKAQEUHCmuH+hUeAvByyO98qqxdNvin+uDvLYA4/RLsoO0iCH4+5J7Eul3Y+Itgu5dc2v+r8+63BmQTgY0Lu77oeuIpxPxkEsJeRNAnniqop5/FU9BRJmZRYpOeKUEPFDAFvDNGNs6VF9VeG8wH8xqhjsYjzSDJMOnOQwZ82UAy/ogjJRLofzixlkHciyWtTB96bn6hRwNDDE9ZDyxpcjid22D3p5pa+x8eEPC0R3zs4+n6jWC+;
 25:lrtg+o8AdrrELtbY0OK0kUToxEYxNGw7S5pbGOJ9NCQUQYRYYeSFtqwQibRqvdhNoS62WA7GNjxUADM2ZBkVv5UIYJ+qhsb9UxLun0R1vmRcj8fdR+3SkLcq3nZOfwR3E0o+KGhIpgFH4EyvuqviJRQeRLV2UWCAV6SwFdQ1eTY5TMXybcUIZhpKo64EPyyemEnUJSA/x9oS3o0EMkQcCT2IywPa0J51dvErEXb8KoHZuwmYc85As4hvMKrxVUwuoXNLNB9hNRVgA4byVoT2RNJO9zaSURVO9L97CgtTzIl2XMY0dxztvmiVqLfIUDkHDD1EI+Okqxipi8HfHfZX4A==;
 31:Ggp4FL+Ql8Ul8Qqq84S+PYL9PlIBMy+XQBwgC7Y6GS6F+hcWh5qr2CSWZJ/J/qmc8/Z2qdXwo6T/Hy6KBH3qNOO/qVV+E4d0xVuK0b8luJ+3c8LuazuPYmlJ+lzD7dUX7jye+pK6sD9wsYialQGQpPcVWwc8wfk1xrc8c8dCKp4fUQZ9J8xLi1kAvzB20HmlGO6gJl3hxwDrgTDge2ZoCufFJtExLJqbE4VD1hLXzfY=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4790:
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 20:SyrxfSvUSBjOhgAekBx5GLhU4vV7nW1Oj/Mt9xdTeizN3B+EkNiSjPBZQqZp2I+qTVPjqsuRZkOEQEXt2xCa/ZHiJ03PDk16m32fAbHjyy2Rg/60s+XrnCe0yCpIgzBzewY1aIFfqYxCP3R+TBJPSTeoTapSLmt3LEk2RKaY97FQ8rdsEiOuffqFopfQWqceri1zpbAinfVJ//yJIDsC7Hbq0BF4mjR0tvdkdriq/hYt20a2mH1OqBUx766evJ0yFFSiysgrXn9rjmeBPjB7LuZm8cn9ekFRgM3cg0QGwF+rKYGGh03XA9kZPM4+b7FFfV/AcC/WzlEl5qTKY3OPjtZeDcf6SVqcqJlyXssd+Y0V6lPBp49K8l0zits29addaaFUeS3lqPBdq7Ii1Ve3mTyBrDuuLqx6CexHMXsYUj6JH1qT2fcLeoshIy/Y7eCgnnW8KvCbg5GzmiSmNoyioscC0YO3axrVWeakZ8vG2wxO1PJz2/GOD7rtcwv4XvLC;
 4:pk7S0PUc5f1SOQESXFWgUlylEviuJMa9PWj5SwrLl8IhRPuK/awzMxkHjRvdRno3QG648schGGubRnAB0wy4xYVE/5cE5chIV5Id17hKH1BhOOl1QXxW0qX8jX69nuGmK19lw/i+k5Ooyt/QQmaX3gWdTmE22xiQmGIdKt4IHiV34qfZdqlrR4tc4M1qZgiVGfdFBIjpUXlIR9Kl3iGp//YC54LMKeaNwS/Yx+kdJaE6FM/0kzt6/sVSkbgPQeV5sHpbhHx7/IEQbGk9hLMwJz7tLTTAHngdODPoMLggcCxmojRAksgbIQWmR+ja0qcP
X-Microsoft-Antispam-PRVS: <AM6PR04MB47906A42898B5A2F0A294680F3FD0@AM6PR04MB4790.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);
 SRVR:AM6PR04MB4790; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4790; 
X-Forefront-PRVS: 0826B2F01B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(53936002)(478600001)(6512007)(2906002)(52116002)(51416003)(3846002)(6116002)(1006002)(86362001)(6666004)(5660300001)(316002)(50226002)(8936002)(8676002)(97736004)(68736007)(81156014)(81166006)(486006)(956004)(44832011)(2616005)(476003)(7736002)(47776003)(305945005)(66066001)(25786009)(186003)(16526019)(50466002)(48376002)(26005)(106356001)(36756003)(105586002)(446003)(11346002)(4326008)(76176011)(386003)(6506007)(54906003)(55236004)(7416002)(6486002)(16586007)(110426005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4790;
 H:uefi-OptiPlex-790.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM6PR04MB4790;
 23:YbqoxlPMTbujm00k/MOgjnXYMXRJYQiTkoLiV+orr?=
 =?us-ascii?Q?kgUAOoPlgV4ku597xemPqJdyiux1wbUapi6qXX5fX4ATjj67OUNbG7qpOzqs?=
 =?us-ascii?Q?U/qiIGqBJcMWLakTJEnmids8AXwuzJ8aEi7NabB6/IuDp6EqDM6QmkndlR8I?=
 =?us-ascii?Q?0XosMwwQ4B4SD0ku9erUTa59UOBBMFX/DBm9hb8/X1OVmdwoDnFkvhYDh7ac?=
 =?us-ascii?Q?j7fRbdsbJjyrfNR2KP7/uxVer4ajX15NxLMOYlbXrub0ZtEiD8bq0dXtdYaQ?=
 =?us-ascii?Q?3updLJLp9sx82HwS6QdxgokJRuLiUYOj6ysx770jykVF5wgxrpE8FmiYEzEw?=
 =?us-ascii?Q?ULE0FgwvgtVcfqnWzr8PpDRP/NLT66jVtQCKFA2bjGora+9eI96YVFHHif3U?=
 =?us-ascii?Q?AVgnFTVQWGjUGaWhknE+3LcjGUKtVSqQIn/Cgq1TYJRvtnEKWUgFNjLkrtiy?=
 =?us-ascii?Q?6FEhPp1c+Il8M64+9ZRkx1Gsmp9xQKQXrUWMMPZXrhbTB8G7a9ZMG4kgdm94?=
 =?us-ascii?Q?GKuT4mYLttYEzsZqV6/VZFeozSE0MdmgsP7aF5CsYHuCNupDNjozMl9Z7R3n?=
 =?us-ascii?Q?83prsNu0TOUyGThd4PzN16sHzBAcGJryHVtNgl7VqgK1t1UyXNZ2iIgbkEBB?=
 =?us-ascii?Q?NbZJ1jHbailJbfo++jt5BZVxitHMvUrNbjNnmFWiq0TxTRPIGD04qd/zdBTy?=
 =?us-ascii?Q?rYTBMMQclbOIeduG0Nz85RTb3qISNKqxGNkGQQyXxObwNY8jIyX8hYUe0bhd?=
 =?us-ascii?Q?wjsVBrEmlYP583neY93a5OZqPXLDsa0+AhWssbAX4xVCGIfGdMxhrBXDTSsm?=
 =?us-ascii?Q?2FBx19fUhVoPuGP8W1IDypRz7La6cSdbG/sobNQuzawkkprTe9zfYe5UdJoW?=
 =?us-ascii?Q?b4vP716H1LWRr8IhnMqN2BI3blXtbtkji1DewoLvoKl75rlG4GFYRP2e+U4U?=
 =?us-ascii?Q?cPYhYRItR5vdFd5XHg8CVYcKg5AGVaDkFoyAD+EAA96pLMqY1b0wfkKuK9v3?=
 =?us-ascii?Q?zLzIfWUQcv7RqYgflthyAuKJ6WVwS7j7snjXxOYLk28UtlUXIWwel5zAq9hG?=
 =?us-ascii?Q?Fqw2bi84dwy36gUcKgORiDLTjGx0qm2+Ty8MYDBfbp/n5pVpx7Yf8CEH32Fe?=
 =?us-ascii?Q?RKzcWgwtmVlFpwX8uYSpxSq1x58UMt/hE8sNS3miqavnS09VXFbuIlM+I8yv?=
 =?us-ascii?Q?dTXIje9Iwd9VxoYTqYppPJk9vkjnOs0qnPg9M4MUaw2kWvINZTv4KzkCtPWa?=
 =?us-ascii?Q?T+TGIkayXBoBrp2+AbpAzUCmM7tH8pLCl+dJp+LJRKtYLglRWPchT7DrCqEH?=
 =?us-ascii?Q?n79bzNpKQdlYvPUXJZyxIA=3D?=
X-Microsoft-Antispam-Message-Info: 0ZBfAsDyfiG2u4l19hg3dCgY3oHbmgpeH8OFpfJ33rG+mFE+ULpm8jjpHJ/vJHfQZ1CKnQI3CD6qDGbn6W+CT0uZ2w1rYasBAA8LJTn8wuaaSarbfx5gEqzbuGNY0NZnxjC7xOIk+4RnNyhM8Qle+JySpZA1mkdcgbhC+XXOpD3YkM50Jg7noAG+sc6qWNu0tYILoxHDxDfZ2OKkFYJ7Y6DJHUVo8vXkFpMmXnwnkrjrRvJVfxXa/tRL2ZwlAHSiyDoPtq54Ei6CBBeYQaGwVWkd2MNtmHEj0eI9zXfDnfS1x7mEUELjcOke6WNyjL4kW1nv2unduAdZNUz1AD/Z6m8R8UC3TakmBbHkKgdjKG8=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 6:kFaH+54+LA2+DaG5+QrirLp0yeEVe/Wub9nh17TLI2Vj1l8kxDtYusrpnOemv0y8ffb3d/tSlRjobd/73CBJ7pxPYRO9cgxzyegNCGIEeZxS6grTMAnlMCLzenl1Cy+urdqnjLRkarRINxvIZlrzoSnfHFhO7wbYF+I7vte8/qbW+K5Oe/W8YzHrqk4zCH0WBy1LvYvhArG2B5v8ebnlNMrJnUqUdijLKTbOblmA4ayOT+BBjVHcsLfQgY/32Z93FS8ZwoadPbG95IyHhr3MZxO+D1FvKPFtfleped68LP848kDHEvY8/6kXYZP8oNe7ekd+NfBG/PcY4/9h1Fwh41dDIdcBkO+0GhWtKhrmIN/8qeJRBvNNhVvevgHLVlRJ43D+6NWSGSJ/+rFwC6xbM308/khwKqjNFnfZyJdXQ8nF2XNVy8ubJN/YsdN22HC8Q8TSN5iP4OZiTWAqdMh9ig==;
 5:iTiLETMy0/y5DXrcsAiUddpaDB/anRQIqOyEFZqHbAPm3g4axFrA8++GwdkL1DHDRA1si+U1gXHtNNm7Gl+0ypcKzH1Ja49cMUpcG3pC0of+XGu0lHjBo7+T5Y+owCtxkniBsSbRvBuGt3p/jpJG/u4VSddMcjStRnev7ntJTzg=;
 7:Wop3VDZKTAaAG3snI5+RzdgG6kV2Rl55LTeNf4JGTg1z5h4b6WkBw4/Cg1WrIEhJLnqt+f8+qKgaaEmw1WVzOdUt9TBZX5vZ3Z+cpRFbcBYjfo8eVyNieIKThWoSa273XGogbEeV1eLZJacWYV0XOve2EmHUWqNrEOMq1scX0+AdaH3eDqCOcTJKxnpEKB86yYlbkGuj7uhzpZGucmvp/u+E+vIN9AH/A+JFSxs956wVTRStvZqrLLI6s0GM8ALM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 05:13:49.2844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25678a4c-bbfe-42be-7b09-08d6325d0165
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
Cc: ulf.hansson@linaro.org, Horia Geanta <horia.geanta@nxp.com>,
 udit.kumar@nxp.com, Priyanka Jain <priyanka.jain@nxp.com>,
 pankaj.bansal@nxp.com, Zhang Ying-22455 <ying.zhang22455@nxp.com>,
 linux@armlinux.org.uk, adrian.hunter@intel.com, V.Sethi@nxp.com,
 Vabhav Sharma <vabhav.sharma@nxp.com>, Sriram Dash <sriram.dash@nxp.com>,
 Ran Wang <ran.wang_1@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

LX2160A reference design board (RDB) is a high-performance
computing, evaluation, and development platform with LX2160A
SoC.

Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 119 ++++++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 86e18ad..445b72b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
new file mode 100644
index 0000000..6481e5f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree file for LX2160ARDB
+//
+// Copyright 2018 NXP
+
+/dts-v1/;
+
+#include "fsl-lx2160a.dtsi"
+
+/ {
+	model = "NXP Layerscape LX2160ARDB";
+	compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
+
+	aliases {
+		crypto = &crypto;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	sb_3v3: regulator-sb3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "MC34717-3.3VSB";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&crypto {
+	status = "okay";
+};
+
+&esdhc0 {
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+	status = "okay";
+};
+
+&esdhc1 {
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	bus-width = <8>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9547";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			power-monitor@40 {
+				compatible = "ti,ina220";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			temperature-sensor@4c {
+				compatible = "nxp,sa56004";
+				reg = <0x4c>;
+				vcc-supply = <&sb_3v3>;
+			};
+
+			temperature-sensor@4d {
+				compatible = "nxp,sa56004";
+				reg = <0x4d>;
+				vcc-supply = <&sb_3v3>;
+			};
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	rtc@51 {
+		compatible = "nxp,pcf2129";
+		reg = <0x51>;
+		// IRQ10_B
+		interrupts = <0 150 0x4>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
-- 
2.7.4

