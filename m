Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72171C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 05:16:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87832086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 05:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SPhVsQdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87832086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YRVZ5zC8zF39V
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 16:16:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SPhVsQdJ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.3.59; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="SPhVsQdJ"; 
 dkim-atps=neutral
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30059.outbound.protection.outlook.com [40.107.3.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YRRT6Y6HzF2Fb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 16:13:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKGpZCEFfT1qRKnJExP19+I1QM6x7Dp1yyiQ8CDptBE=;
 b=SPhVsQdJv9FxEQCjpnoCikHNOUs8FlqA9yz9XyXsODEBbFlWau1HcRwbKtfQyTO4eVmDrSu777sfqFpkv0s9KB7S9iCFATDWCLlaZY2FbIbdgxGQMJSImtBXSn2ia+hPmounUyyQ5BxLG4rIUWnVxAN3aLH5FYK5c1BcSlOBWrY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 AM6PR04MB4790.eurprd04.prod.outlook.com (2603:10a6:20b:3::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 15 Oct 2018 05:13:12 +0000
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
Subject: [PATCH v5 0/6] arm64: dts: NXP: add basic dts file for LX2160A SoC
Date: Sun, 14 Oct 2018 22:37:57 +0530
Message-Id: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::22) To AM6PR04MB4790.eurprd04.prod.outlook.com
 (2603:10a6:20b:3::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 811c6d15-fdaa-4142-0b17-08d6325ceaa7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4790; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 3:M0/+Ko3MwMPmem8tajXfV0PPE3T36PB72+8F+N/t2gs02Mg+u5O6cns/rJKOx82eDRDnPSlgCjq6Xr585encyKfYqoqp/N8dDE57nIdGHoBLlPZP/tpRZIiIY0tpN6kuR85DaHGe5qh5q4nDe/L8ELkqUHx1Zcnt9MsM1pjsiVs08ZdLvvZNACWMe9Nx1K8zHOKeQhNpx8nwUmvnVlNikzmDAeZLuFFwXfVIBF/q+buBN4quiQAiVnTVUz7n+8So;
 25:a11X4IyDb74xRMjR8FpbzrvA563WAV/KncJSegjIozPpLZ1ddQYMerPMuy6lIZyCqiA0kMQNZLR9fAUrFGufmlZiVo+sufa2mJGdI/dpTYixAF47otfVaWT70t1Ey+4tamCBM3An0zzg7o24pXw0tZ8wxmqMzsnUykFvV3/TUdvYkCfZw2Oba7IMR9sgvNPm8jr3BxRPVJ+6e87AmJxFFX1I7esNSmWGZ3w6fjLySgYtuPRKaVcw3PniLvCq9bXi0BFcec+JQ3REjH+piQPhKhfCmEasFX/ceqqhA7hXFro1ucLXNbazOUczrbpkmf+fHU+ramAU5oDoiR0PfHvl3A==;
 31:udJ04a+0xwChw1kZ/t5CRugCgJfH7YuildwJyuP0jD8F7RsK7iSTD3QsiL0oz3mpLs4ZybULH1cH5Kdus6wxATkEukuZUr4XWdt5FS3/V7AYbQqd9vDUipq3dYqgRu7jy0q7YM7r7d0AY2LyTiDpt28/rUzSpo5OjMvS8Ys0ueuSFjBbf/FQmwhJh07S0Jq5/s9VrqQ2vuUXCTuPnOXW9ED/b5FSIIO9jH4Jk0VUCR0=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4790:
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 20:YQjgajd2HCTzKtgt7qO5SW2BzJkVgAketDl9aykFkbXm/qCW/qMQcV5E92VgMRg7TxVEdKNe1QQWFfd6T0RWR2blmisjw3S1DI4DhUwb7d0MQPicDEB1r1r63Yo+C1eMhHv49D4dxlHTEsthdBCtk/y4KVZHikcRCobmn//r6o/2DJvvCLUg4MAfpULjWbNfK4Q2YKAX3vw4kawWc9i9nEzjf2DsxJdlhwDYWKyk4P07iPilLSm4qarFyGvYDYRnmGXqx4U4K8uobokRfKu9DMft7saLe1xsbEucwXhxj7PTa43LOktCczbp6FKjOnD5B9xQcqGvu2LeiX6MdMnhzpJOFAW2RxCmG5LP0fBwh5Wyaikc7GfyJZ0FLhl1OatVzwnlU4uMEHPCXXsL4Pc2k6znwgg7yt2J5aPyFFTsgTotPSalxZqPrYKmHLKo51MAlHz8hlqfz3vN9d56KXIMKNkYsmANrxPzYoB286DI5tGfxtUSum8h1tlGC3PPP+b9;
 4:PXAZi1sH7VnU7ftUcxhwM4YdVzNTajufepkA/d84y2DhKKG80yf6VcYw7odEhk/a0NX7618r3HI2BPq4qIWZep8oHLlRv6y0BCTVMZlUrOt1hPKdy60zh+Zax2grlDrsmXb1rR39gS13JkTufhRZuNFFF3hzC4w8ardFPVPdExE/5bBrFobfN+7CYRx7QSDQgD7b/MwekqpKU18UK5L9HYnPSTZdoYfsMBNgQaWaXni/SjEd9lEcPY3/4O9WoWxFailHETqZivBqx5kvyxLrPg==
X-Microsoft-Antispam-PRVS: <AM6PR04MB47903770D6469CE09E016802F3FD0@AM6PR04MB4790.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);
 SRVR:AM6PR04MB4790; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4790; 
X-Forefront-PRVS: 0826B2F01B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(53936002)(2870700001)(478600001)(6512007)(2906002)(23676004)(52116002)(3846002)(6116002)(1006002)(86362001)(14444005)(6666004)(5660300001)(316002)(50226002)(8936002)(8676002)(97736004)(68736007)(81156014)(81166006)(486006)(956004)(44832011)(2616005)(476003)(7736002)(47776003)(305945005)(66066001)(25786009)(186003)(16526019)(50466002)(26005)(106356001)(36756003)(105586002)(4326008)(386003)(6506007)(55236004)(7416002)(6486002)(110426005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4790;
 H:uefi-OptiPlex-790.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0NzkwOzIzOmtTenlvTXF0alFSUmJqZW13d1ZCS3hIdjQ4?=
 =?utf-8?B?akxHNW1VVHplaU9TNkRlNFV2YVE1Uk1USG52aGFBS21qZDMrWm9Ob0x0cUZ4?=
 =?utf-8?B?Mi9TN2JZU0xzOGxyeW5uWEJwYnB2SnpLVjFzbEt4L3lDZjdKS0NHNE9sT3F6?=
 =?utf-8?B?bzhDTGJjbkFYWmNYZElDSUZ0d2FnWVNTcWtBbmkzcEN1U1lQM1hKR2FxaFg0?=
 =?utf-8?B?TTNwL1Y0SzV3aEdtMWJDeUZYUFE0eFg4ZW0zZEdTdkdlRU8zOWlwZU5uNTJU?=
 =?utf-8?B?YVB6MUt1VEVHdjFBSTZEWm1oYVQ5cFJTdU5ZMkVqL0NTaThBWDVCNWRUUWh1?=
 =?utf-8?B?MG9maGM5U0pHbUhoK3VNOXhiRENlWlB1NTFmZlNYM2g0Z0NWZklxbzl3djNL?=
 =?utf-8?B?L1lma0FMY1VVUnNpdEVCK0grT1dRbGh3TFRFNHozQ3I3WGd3NElRV3hSMk5J?=
 =?utf-8?B?ZHFNQ1o2TEtxc2MwdHp5dGhwM1FhcitUcTBZRXlDZlJyZ3RRTmhDWjN6dlJa?=
 =?utf-8?B?TGtTMXhBaXNwdFRiQXpaaFA1M2w2M1JQRkhEWk44YTJpS0dNMnI0cnhlNHho?=
 =?utf-8?B?MldEUWRyNU9ucENRdU1SZksxTVJRZElhbTkyTlBYRlFKTzA2MGhPd3JLRzdv?=
 =?utf-8?B?eXRXL0ZIRm11bjZmYU5DQmFTR1llZmwyWlJXbGNvblZIQmlFM3ppSXFIQTFC?=
 =?utf-8?B?SmNiSjluYzNCdkxaRnhpMEVxNWo1Uy8zNWROYVpBNW5mQ2IwVUtUUU1JQmg2?=
 =?utf-8?B?THhYK2VtOUpPMFRVLzRmaHdWcUg4emZxaUhhOEZZK1dHSWxJZldjaGJmK2ZZ?=
 =?utf-8?B?clFSWlNJZURmSHUvY2RsODhHWlRBOEl3b3Q4aEEvbnB1UUdMNXdPNHFSYVd3?=
 =?utf-8?B?eE1NbVdsR3NkTkpzR05RaXlxblZjQmNOa2ZFVE5Zdm5MUnMrcmxSZ3UzZ1VF?=
 =?utf-8?B?TnFydWFuWTYxSmJBdlZOcWRrV2JVeVdPajRIc1lvS0pueDJjSUI5b2IzUzZL?=
 =?utf-8?B?ZHRzSlIwYWFUK3A3MzFlVlprNDBCcUl3OVdvUU82Sk42dHZZbDRqQVl3WERJ?=
 =?utf-8?B?UHB1VlBwV2QzeFRBbkFwZjJlR3djeW9CVUptYkFzenAyNENZMHp0VmRXN0ow?=
 =?utf-8?B?QWhHcXk0Yms1R1hKWDduS0RzUVc3Rm1USE5mRmx0UTRPUmNqeW9VS0JEeURZ?=
 =?utf-8?B?ZVlSQjVMNHo4M0tjWGh5UGNtOGlwZGUyMWhJQS9FZE9RbFFueHF3UGpWS2ZT?=
 =?utf-8?B?c1VzaGc3c2FvejBnSzJPbTVHOGdFaG9zaWh3MHdscjcvTS94U2ZqUitTdStY?=
 =?utf-8?B?WlJxRGw4MW1hSHVCczhudllPZVN5Z3VwSVVTb2xWVG1LMWp2Q1FiaXFOQ3BM?=
 =?utf-8?B?VCtpSkE1WDVlZFJzVFM2SkJEWkx3SFBKa25ucFc1WlJYR0tFT1ZKRHRYa2l5?=
 =?utf-8?B?VXRyd3NvbHB0TTBOQTZuL0VhUXVYNUZIQkgxRDVqSlUvbm1FdDR3WUZra3JT?=
 =?utf-8?B?amptemY4dzBicGdlS1NHNWNvb1ZvV2V3NFZUWi9UNnJ3QmNSYTVpcCtybXZO?=
 =?utf-8?B?RUVDREt5RUhweHVZVUxrZWxVKy9JMG55N0ZrTGtKY0MyeUtGWG1YeU85VjN2?=
 =?utf-8?B?TWJLdlJUUTBhalN3dUpQdm1ZMnlIcHVpdnFDQVhlTlQ0dlh5aGZEN3VBPT0=?=
X-Microsoft-Antispam-Message-Info: AowERvtX2hRkZZYTzNMf7wwlDKJGZXuFxxi1YKcuXrgBqFPSVyVskmuke7zNqV4e1Lnlz9eZMSBtK6vmARBg9KQGWKuhH1oO5TkEFmlY5KHKP0J6b4E2u0CuXNkCHBuev++vOmq9al+KRRMF7UREulYLuo0gx4Y5/5JyDx9GX9dbst/CknmgivkPg+2c/1OM8HiY3oDHDf7SYMJG+NnxrcDMF/2yvPzC/TMNGIif1Eqa1+uksjUWdYunqzcF+5WUeQ0S8r1ZtkHcGXbUj6V1dCwpy7YODkdQ1ATULjso/QmVRMFoBsid+IaWoGDc+9aeTOL/ehag+9by2a1kx9FLn1mm8yoorYsTIDHCuy6KNWI=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 6:eY/f3K5PJd+856i8HrpBvnw067XgJh3dT+ke06f4Fv6yXyL4PHGl1X+6ngD8EuVwnb/GeDFLKlqgcqDuJs8uLuc0l1WhRosdJbZiLKF59sBMGSQUduJpL7UYqOR90/j93wC7cy1wrbG8sQrqKrRtS7D/m7+H2bTqDLkBfooA9ng0ZgdDAbSYHhHEOJ8j0f7naqT453dwcuhmH5wmyRQTi8isQ43qu/4IKS0TPWhdQMaOWSRuOV2PsKfBSj8qaK3rmHtNIbDym+4LR0PaoB1fQCWFRNrQxMQ+yLuNDx6j2uyypRQZVQCyedxLoh+iq1OHnGy2Q2tgZpcc/+NVn/ZXJt/BMYcrPGjkYNgf81WxDdO6G/HOvTQvHafoC/f9h6u8X2gDPewQgla1UqsHkXwTBGc3gUUkBtTd3nXFBD0YrkjddzxH2ocZ9L1rPmjZpAEIJ5OYZtaYIUAaFyIl0tqaXA==;
 5:0oBWoYHKaz8fSvTQdR7AvGiXJKJpsHVdWIxO4fC0VjSmEs6RUSJOVbSY7zM9e6rXeiyg9Czjkn0zgrqejkr730nlOjf2HAeQ2v3VAlxN/5E0aaJ0XvtbgULQ713e8JiOwpYJBSyMCdb74YYgBrdG1XEH/uTU9BhYl2rTMXWKkn0=;
 7:DSS5OgLKMEGs1tHRVjlOq61AWceSsB2IYbI6WwPlPB/lW1XWsuoKRfrBTDEuc6bAs0XGTcImCaI10vgJ82cOGFTt+vb+Gh8R08vKzqLQm5yGXJQz3T1r9oqkI9ZebhoYFwNhJYD0LkXIcV1dRvf9o+ol+n8k7Xdim/YGvfNmI/4IaQTDZ3Rho3pbCOvqkCfNSFfYL92DXb4eHjrwIyNNxlRZ9bzAD6NPlVWu2MzJwMREVgyfLQUBGGbaw5De/jfU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 05:13:12.1131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 811c6d15-fdaa-4142-0b17-08d6325ceaa7
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

Changes for v5:
- Updated temperature sensor regulator name in board device tree
- Sorted nodes alphabatically and unit-address in SoC/board device tree
- Identation, new line update in SoC/board device tree
- Updated nodes name as per DT spec generic name recommendation in SoC DT
- Updated macro define for interrupt/gpio property
- Updated i2c node property name scl-gpio
- Removed device_type property except cpu/memory node
- Added esdhc controller nodes in SoC/RDB board device tree
- Added aliases for uart/crypto nodes
- Add SoC die attribute definition for LX2160A

Changes for v4:
- Updated bindings for lx2160a clockgen and dcfg
- Modified commit message for lx2160a clockgen changes
- Updated interrupt property with macro definition
- Added required enable-method property to each core node with psci value
- Removed unused node syscon in device tree
- Removed blank lines in device tree fsl-lx2160a.dtsi
- Updated uart node compatible sbsa-uart first
- Added and defined vcc-supply property to temperature sensor node in
  device tree fsl-lx2160a-rdb.dts

Changes for v3:
-Split clockgen support patch into below two patches:
- a)Updated array size of cmux_to_group[] with NUM_CMUX+1 to include -1
 terminator and p4080 cmux_to_group[] array with -1 terminator
- b)Add clockgen support for lx2160a

Changes for v2:
- Modified cmux_to_group array to include -1 terminator
- Revert NUM_CMUX to original value 8 from 16
- Remove “As LX2160A is 16 core, so modified value for NUM_CMUX”
  in patch "[PATCH 3/5] drivers: clk-qoriq: Add clockgen support for
  lx2160a" description
- Populated cache properties for L1 and L2 cache in lx2160a device-tree.
- Removed reboot node from lx2160a device-tree as PSCI is implemented.
- Removed incorrect comment for timer node interrupt property in
  lx2160a device-tree.
- Modified pmu node compatible property from "arm,armv8-pmuv3" to
  "arm,cortex-a72-pmu" in lx2160a device-tree
- Non-standard aliases removed in lx2160a rdb board device-tree
- Updated i2c child nodes to generic name in lx2160a rdb device-tree.

Changes for v1:
- Add compatible string for LX2160A clockgen support
- Add compatible string to initialize LX2160A guts driver
- Add compatible string for LX2160A support in dt-bindings
- Add dts file to enable support for LX2160A SoC and LX2160A RDB
  (Reference design board)

Vabhav Sharma (4):
  dt-bindings: arm64: add compatible for LX2160A
  soc/fsl/guts: Add definition for LX2160A
  arm64: dts: add QorIQ LX2160A SoC support
  arm64: dts: add LX2160ARDB board support

Yogesh Gaur (2):
  clk: qoriq: increase array size of cmux_to_group
  clk: qoriq: Add clockgen support for lx2160a

 Documentation/devicetree/bindings/arm/fsl.txt      |  14 +-
 .../devicetree/bindings/clock/qoriq-clock.txt      |   1 +
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  | 119 ++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     | 765 +++++++++++++++++++++
 drivers/clk/clk-qoriq.c                            |  16 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |   1 +
 drivers/soc/fsl/guts.c                             |   6 +
 8 files changed, 920 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi

-- 
2.7.4

