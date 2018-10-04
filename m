Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAD_ENC_HEADER,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692B7C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 14:17:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52F620652
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 14:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SiQtLhKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52F620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qw1l3lTgzF3MW
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 00:16:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SiQtLhKr";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.71; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="SiQtLhKr"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00071.outbound.protection.outlook.com [40.107.0.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QtX63KfqzF3KS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 23:09:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bww5dCczG3MSPykoxStXx8Urb3r8pR6ZuV65KXscxg=;
 b=SiQtLhKruSEBrHxwSIqdraGCRUJjykElxrBydRXw2u0Vzz3NZymhxJo/holIgq8uZZEv1juXnKT5qqIaXfCi8LHyEppcdZNJ1+6+I+8FyJi2a6lCtklFF2/aCTjTeYqtEZHJRC/hv6Q7ZLpKUxim81RHocl6VDk2NYe/Fy6EH3U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 AM6PR04MB4792.eurprd04.prod.outlook.com (2603:10a6:20b:3::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Thu, 4 Oct 2018 13:09:31 +0000
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
Subject: [PATCH v4 6/6] arm64: dts: add LX2160ARDB board support
Date: Thu,  4 Oct 2018 06:33:51 +0530
Message-Id: <1538615031-7507-7-git-send-email-vabhav.sharma@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 80c2fc6e-920e-4598-a1ed-08d629faa261
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4792; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 3:Q3XvJb+pZAZoGQEUbR5K3sUZ6Rw8nlaRVSzi3NgYSEczvwtyBRYZo3AUzZ4IlJCE78NMLNkHSsisSi7y1cRU7VXuuLk7HzP1cJDqU72EXk+ukIj03Y+mbas4ZPQpZbCa0BeQfPpCSBhJRAjvC6eRB3vSlQOTKEUNs6E00k6yWMlD0bOu4iPp8GMlae0ZhkNBpAql5/0GQMkb4PKgETbGJnAvoX+K4oZ0M510LbeP6CdosYyyvUkvCtBEnE4ZAGDd;
 25:UWfYixiKvYcd8TZiPYbpDjH2zM93Dti73xvL6DQWFlsbK6m6fuSZekhq8XorROMa0G/KdFY7EJ/QEKFzzn2PAEgU+Z1ArH2nKi4OEw4dSoltIH4jT9IbcddEL7BfVFfX3gCF9EBj6o7CUE7/AXP8GXX9ylF0OC4EHs4HCH89XNCNDe66fQQB1uH+QhE2kWJUia4zN4DI9ezFr4UHyLsWObEKMdOzVsNQWw27+u8KlVdhXg1C15/7VTI+O9jva/bpTCuwJt9+nPKUoR4xCVp7i6jn8FDy1tNOmJzySHR/8fetzBxRTBdjnUGNK41jRG4KhhcuPQHJuahMpuTZtgaNAQ==;
 31:Ljky9P+AI74hAqFBShTlaO5BbWNvHBqOEkYDaIhXbcWaE0O+Gvh4OusoLWZryGiCKmX4vsAHOtA6J3KdcoLfzfRUFWE+p10F/T3f3ymMBMZ0O/pUWfIXhhsh8117X1kZr+iiMyfc0ClURK31mTAgd1/AAxsvImCIhYb70qgjhp2jMEejothvG3dPBhlUczjMZzEzPaYRCX39NRYhD1Eq8hyRxnzronRpaL8tkF7kv/U=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4792:
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 20:EyBNRXdP4z+pSJv0MqqmCwDtOwL0+oI7Vk7I80G899XgdtCCesQI7HzqnIP99FjTL32MnETUuObHQ0uoyZx0pOClrkQrImDH/xrAaDTSPtFvOZxNqe6UAqNON8MtL/0Gb9QuYWzTZcms/2QKw8zop+jxrbBNop2D/I+XcHRh452DUGGcbez3iEAbmPic62QR70vNiwS0j8wYRbHt/mZI/J1nOl05KCfNBUA2n00PtZghhlcIh2pVJIi62NuEMPyh2z50wQgUtDCp/IRX3tUaTBWgVRMBWFUrbWgZk9qzeUIJWCy+Go2FLgELyDOeINNiMILgunfAUbH1HM+Q84bsKssYVotnndQW2Ro22OWp2zxoGTRL65z/YN8UGv7iNSDB1WmHYw21FHjPq8CrQGvZlcny/jJV6oOuDeqeAmXsbiJ2pszUqUo99Jl1MR7i0xAUG/J83JlB8Ue8yHj/UVH4ixuIGEkvOAP3sqtB8qovK18U/HS1xOcf0hRigHiBef8j;
 4:TTXuccy1A/7K9bicOUZvi6DmC5TyciNcaHGPohlyyuLLqOisRjIHLEBq6WvQGHmnTBv9sW8yg8625hDTJt9xIz8W13Yj6ZDZ2rY9WBZU7j40zmFmv/5iLKGhfFdMls+yuBk9epikAMLgEhevXsSCi9M60+2G1vVINd1sv0/BJZgJEhbkiIcKEmNBVWAf4OsMMUwBoRGA1J7z7jTzXjOo/nOIT03x4Ll1RU17xLOZpCTz6/TokmyPzBf5nBSA2f16s655cfcT4R4FSZhZjUTqATwBtMTxwXTl7kD3Ts3JEI7ym9QrJ4Dnzq1TwILQ4Lvn
X-Microsoft-Antispam-PRVS: <AM6PR04MB47926CC661BA8B882EBA3521F3EA0@AM6PR04MB4792.eurprd04.prod.outlook.com>
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
 23:598mxCwZT2GsEsZoCbBYfEhmSe0Myu4gJRsJ6XVGk?=
 =?us-ascii?Q?AXetXwkgAJIa7dOBIQFfxQ9hXHypKpAiI0t29fDEirCaz5efRsR730VIJBzY?=
 =?us-ascii?Q?T9Oq7rcIbx2kpSNvIiE2eWBMHDafcTtoNe7hAQvnAPzAtp0M8gV/ceJ9VFMU?=
 =?us-ascii?Q?ThcJ25ybr0glVTBg1Ldx35l67YzuI8CWxK+/YWmN27n49/WEQqth5Hhh9yJo?=
 =?us-ascii?Q?NXYoSo9eFC+IzNLu+Cg4di4SVLZyFAuX/CYb5vYLCAZWK/Ykv1Kj4tGc9m1F?=
 =?us-ascii?Q?0/vTyJqRaoQS7MsCRsx1NY7V+R7Hw5J+b+vs+ukNn4az+kh1KHUMhRHPsglw?=
 =?us-ascii?Q?eMi0RpIrOLiGFxXkTnZ1ODKf7ahWSoHI31CvWeHgD/fRA2uIMhKgDACsAAu8?=
 =?us-ascii?Q?BK3JxMV0Ptl1KYgkeqlCpmFPqT57A60x6/GwpBUOXCjeUx2IgZdg2fvRNP1f?=
 =?us-ascii?Q?AkY+xO3OTz4/o9Q1GdvrkaoS+WXM33ewCyFszSOMaBRShLjubpTyB9SHMSQP?=
 =?us-ascii?Q?yLwEMeZmFrInSWrFOS7DMfVK1eT/5go5K0+VbKYMkdrUzxAKw4u3xpkxgNfK?=
 =?us-ascii?Q?7G8StE1BESsMk62tlkyM7ldvn7Bb9WcztQAlBiZUzjxluYeVMZDH7JpdAKzw?=
 =?us-ascii?Q?zEmpZZGIIMvrAo3CXfB84Zu+kWBLGkP90DFmPJMd3MoSxQVm4Wr2FO4TXLpj?=
 =?us-ascii?Q?a5N7G6LFnbFbXHHaAN5MsyEpIwYhDkVv53XS/TBEfXhJvxSQtvHbx4MdYmf2?=
 =?us-ascii?Q?N0OOJycw3QKjOumNB7wctC0XshIV/BJcEzvJsdrEhBUH6vUSSBMNUS4h1RxI?=
 =?us-ascii?Q?sTQ7ek8vvLzeI6XW73fzqJqqrvoz3GWKz9/0z6hJx5SfuYym1r8ozIsBdoNM?=
 =?us-ascii?Q?B7caGcZ3peOTuZHO0gUnbAttLwqi6uttW6E5qTSuf0l7CwG3uG+gjJ6/6Uug?=
 =?us-ascii?Q?n2cDBfHBpF/laLzslTUGbLwBO8eT1O6loPGGgme6TTGYCxzJE6JTX+qVkYvP?=
 =?us-ascii?Q?WESeSsD+d0+DbW2fT/gBm0hR/zUnIf5kRqqRJNxjs5zy7giYsqgtmQfG9xkx?=
 =?us-ascii?Q?ZAcAu/ilWK+7l0xqFnBtz9R2YCJkZAvGzk5KdbQD8MrKzgF5D5IYP2f0I2TG?=
 =?us-ascii?Q?echsFItQ2VRKCskv5tFKcmPuWgpJb2Pcp3ewj60f+Rj9lshSAsW/N3BX89ly?=
 =?us-ascii?Q?Fpjs4ZDmZw5fEI1cXG/iYXv8B4Gaz1wvAI/23lY3tF20W3OMW/fzwwEfMNLh?=
 =?us-ascii?Q?BHUzGMYygizy3RBHo+s+PQkbOimO8oBt0ED1HT2EnATn00AXWcTCI+Pt8WyF?=
 =?us-ascii?Q?+UHfFlRur8lq3a1BX2LmU4=3D?=
X-Microsoft-Antispam-Message-Info: UphZ+kgmqwgo1vucc6KIYEFVAMC7l2XYY0Y5Wl6ldBNRmhEOM2NF5HlwRsjqJEi2Pz4nJTQNumAi/UfRXd8IOUhcTaRh1mWmgy/JVKRHu0LZpTPA2cWFLNXFleuRqxoUts1162bOyQPc7h6qf4dTvuHOi6vyMfPfam/wGmqQ0fDzXeqOFaHHXtYksUw2478rsdO6yyplhdv7joramBh8a5LczrLI/QSw2aKhu2Gd4TJIDjQ9C8Dr5ZBA2uE4w+l+gkB5i9P18UqAHr6eS2V6G1Chh/VzqSlWTbJbGibpPQoa1kXWLtdhgpaMrtKUrCZsacl2dICPaRJv7QU08LgppH+7+B6waBi57HJNXxlhqVU=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 6:h2XjizkCGkPMyavGmd/xoIJeiobUZ6BsVWORJJ4dEKineALc/JUCynoWSOiOHSo2g0mQt9UiN4YmtLCQ5Hwmisj+CPOpz7YE5PLucEl0JnZ8LvOyhDyvG/JlYpmf6fpUkgR5ci87V8yZ4UNBQ6pVs4Fr5H9btOxw7LiA4HruTMQJ8oQ8k5zV6VYRO51iFvkNYTGcjhT8nmUdE5/jRfT+MTGoEkhAr7ToZ64DTLlisFhLJCFcHfb/YjnSY2nc/tClz+CIzAzUh+6dG3t0KbImiL01hMb90VL7KO/ZoyP5geB5d7ghWXkznaRyW9fmgSl2k0T4AcAQUOXD4gKR1ZE5DBV+VbMjFc1BcylWmio4upR8nZ2adNGaOR9J1xmpRYguKGlwzmuGx3TpbdfpHFpwwh3955Jx3x3idRVgGCCt1KjavRrpgMeWAhAWbmy2G+1+18X2MNrKRq6blPi2MV/Wow==;
 5:CsRgeFDjy3wsNxeFBTdXAllb9ATQvmPQih34aOw8+mUOgbBzbea+w7Vfmuu51slFXp4ldLrVBlBb4KCE4aplLd/SnOyjSuTidbFC7vmMhvXLuTSBoshTua2W/p6CPH6SGPvues+GvMQWplnSFd5y7ys2i+Y6ucFO+oSQp7JM51U=;
 7:GLCh5xc5ko0afIwagUej/1KwwpNfUKDvVEdiLLkvLC+AyuaW5RBMy8qtatozrNo4M9V2sRM+QZIcQ0pJplRob6s/xK+tVqmyL9LhsfPEhLvcntt8d7bYwMADKWgkxK7Lbil5LTGF16xOvxFWtBSWxLj3Je724PY6T3E+KhYCeHXUKm5zqgKepp2cLw+Ey/GrBSPUK5zrEVHqvR1XeCy4xSrkYx1cCaKkUei7eRUIo4/8QYqygOrPnfC5QE6ubqB6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 13:09:31.2371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c2fc6e-920e-4598-a1ed-08d629faa261
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
Cc: udit.kumar@nxp.com, Priyanka Jain <priyanka.jain@nxp.com>,
 pankaj.bansal@nxp.com, linux@armlinux.org.uk, V.Sethi@nxp.com,
 Vabhav Sharma <vabhav.sharma@nxp.com>, Sriram Dash <sriram.dash@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

LX2160A reference design board (RDB) is a high-performance
computing, evaluation, and development platform with LX2160A
SoC.

Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 100 ++++++++++++++++++++++
 2 files changed, 101 insertions(+)
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
index 0000000..1483071
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -0,0 +1,100 @@
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
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	sb_3v3: regulator-fixed {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
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
+&i2c0 {
+	status = "okay";
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
+		};
+
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
+&crypto {
+	status = "okay";
+};
-- 
2.7.4

