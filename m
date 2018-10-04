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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB11C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 14:12:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6252082A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 14:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i++SxHcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6252082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qvwf0765zF3Lk
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 00:12:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="i++SxHcE";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.71; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="i++SxHcE"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00071.outbound.protection.outlook.com [40.107.0.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QtWy4xlrzF35n
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 23:09:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=It2UVSlDoyNtJ06YCXq+N7Y104wy3XWP23LPhxulZSo=;
 b=i++SxHcEhdJTHhVfVouNSPsq3v+MWCNmC+UPwAmqo6R0hTx8CoOThmd28wn9tuJPv5+By3Rg72bcHxSMCOBAZjwOeHLczudYjmDTRuvk5ohtXgCc4XJYabT4MaZA7X887owP57yv4vQEm9Hc5gJ5g0tTgHelRIMfHg+E16r+k5Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 AM6PR04MB4792.eurprd04.prod.outlook.com (2603:10a6:20b:3::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Thu, 4 Oct 2018 13:09:25 +0000
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
Subject: [PATCH v4 5/6] arm64: dts: add QorIQ LX2160A SoC support
Date: Thu,  4 Oct 2018 06:33:50 +0530
Message-Id: <1538615031-7507-6-git-send-email-vabhav.sharma@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2648fdb2-14e7-42e4-aaf5-08d629fa9f28
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4792; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 3:azuzI0qagld7woGX9J0kqNs0b8a6L2Wl/qDNn8CG/3nOt3MhBHubIq/WGfuDiPdL+3/ZBYQOzfvNZN2loPDiTiJ2qKi010T8jWyKyaqcnUSablL1Rd6jLxAOia+Q/DLJ+XIkkXPSUKFgbtHCjdpbIXDIpUkKreLpDjiwfMuKGxY04e6gUCQSDMO6umkwoBk6fV07iQpoUhJ5ALJims1kLaFjkrKmXKnfjGu83orzswbKuyAhFdhYV9dmpe//ga+X;
 25:oTfBr1v/TF1uS1ZC6Vw9oTb+BkHrQvk4mWt1sEtTBLEt/ECgj+rag+ql2EXSQMSI14svFNrai8EMGFQ7lbpy9IC6FHOLJoiu8phZoVi+XsWDUihzyHV7IqBqAoxrWlgzJDmUAW8kmx/FZh27OiRibz6WPdVTGxX+jfSjD40R69aDCrZN/dKPvTmGT1flTTGmc4jITVAMFsCaDnk6AxFMX0Vn/qUfGPhw6QPkuU8Fev7xtUAwg+NwtTGoOPlKSuD9lsPya/hRwalMO0ZoBGxZ9UnZLfMMbEwPe6O6NsNlEu/K8H7Do1tw0l75vRpOCUotPo8JXSwDkFCRBp5KY/RsCg==;
 31:jON2RjuGII7esW1piQ6oUtjDfVob59P5Orhvlve62LeAXaKsWb1HP0ol4mi+Uawg9endUQ4+lToMoub2xjZO1lDQsNZPeFlersMiBBFYALeYLwT1K2gFXKPHLpdv+zhfzrgnwCE+qCjde1D4vLR9g+QZfa3My3qNvuz4JNdkL8hDxZpXLPnOeBH9vZ/0aYwEfIgjGBjiHY+XhF4OPB/pnU4QYqMXzmvNTnNplQXTCBU=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4792:
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 20:jB1L+EFRM6AfMUo9xFdDBaXoDHtrlTVtT3ICfI7e9Ap55seHf154mE8TKC+oAkTADpkUfC2/CV1Xhb/blS5Iz0vx0YdEyOYf8fvUylhlNa/OhPph/64EG0/ptj0mfxWOLW0ssAyf5p/lLEVbiUXoQcC7wabTSKNHNPMjdDIHXB/VvV7PkznCDxvexCLr7KChkkRzAcYq7R13/7yWAVFg4FxKbKNttQHUqLcnslWWImXKeP0LZgBls72PdGkwbrDg5v6qD4MI6o+GWrxLBiKYkwgViTs38o3sRJmNP4yXzlTZMuT7kpStIV/V9ePbBmQuYXYRSpOlr38BAsm/H5znYRhIetHqfgr8pIh3KVImmuyroaFTv0S6RQpXS/cqaMtVBQ5CVzFfXAOnTLO8akqXcCbmJBfzEtuGjJcDeN5hdR6HzSJE5TbxU0J4RURp1KJq78Ty7tapf/Pn13Filt2kwMp65BYD556qm21SDg8d6JG2/gp4h8nZS3q/bGk2KOwW;
 4:+o7QsFCO5nVQLDtN0iIATHGiHzpGYlNfiH5RW/hRai429CCZ2bZIc3qEPQzbGeKk4pi+25EhiCa6nST/R/2LgVZKv3syyI3HDk3+MqE4Q6fono6gWfos/mfiftF4ovf5/Gg7CWfmQ11OS4wfbmuKHln9HGv9WAmKTpPkrnfkMVOXo8ohzJhixfy89p6EqOBrsu24OZP6ccz8YzRGPj3YkQ6rXNEhZSaoIBduqTLyzrH9uJNCX4aUxX2cwRRYEjA8tyEFgEcylag4+bTdq4/zzsXJ+65MDiHUWKctMb4ZGMks+5ZV+FVztJRX+IIqzfSj
X-Microsoft-Antispam-PRVS: <AM6PR04MB4792786AA5A3DCCDA73B8BF4F3EA0@AM6PR04MB4792.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);
 SRVR:AM6PR04MB4792; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4792; 
X-Forefront-PRVS: 0815F8251E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(366004)(199004)(189003)(97736004)(48376002)(106356001)(8936002)(305945005)(3846002)(7416002)(54906003)(6116002)(7736002)(6486002)(81166006)(6512007)(478600001)(2906002)(53936002)(50466002)(68736007)(5009440100003)(105586002)(55236004)(6506007)(2616005)(956004)(14444005)(446003)(11346002)(36756003)(575784001)(386003)(16526019)(316002)(476003)(5660300001)(86362001)(66066001)(4744004)(186003)(44832011)(25786009)(486006)(16586007)(6666003)(26005)(8676002)(76176011)(50226002)(51416003)(52116002)(81156014)(47776003)(4326008)(110426005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4792;
 H:uefi-OptiPlex-790.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM6PR04MB4792;
 23:Erj1il5U2PaQwdmpIwey/RskznDKeVb6scV6qqMm8?=
 =?us-ascii?Q?ltYZjEiP8Bi2AX4DY4JSMUEHZDn/OusS36htGcXfJUedZP5WmbjC4Y/b0i3t?=
 =?us-ascii?Q?nZWXs7KMV+YDZAQJwv+lwoqnAwVMHRNynU2I640N9tUUF6VvCOhmBeXg3dzf?=
 =?us-ascii?Q?CWNdMc4Z81hPCNu7VmdWOiiBkNggD9C6mnCsEtEVmXcfgoZw8FUoPFNRTxgA?=
 =?us-ascii?Q?M+e7oK3FsN/ZFSCA0wT7bwEQATvuKibMXPYldpZWa/ROttFNIK3l+mcO3aCb?=
 =?us-ascii?Q?spc1o66m6b++yNYtUj4mUagMnDZQ/G06WCSF/Eq/tGL0OVwjJxHcFfHPS/e5?=
 =?us-ascii?Q?Npjaj9HFLuMvNjAno9wwzhdR4XaIFzEcTEvoVqRFX/YwJze8K/8HrM3WAUft?=
 =?us-ascii?Q?XBtcU7aoAnK1KqWDfEDUkvs+lEb1ihUcdawASxwvC+weqM4mabIMN2XoC4Bj?=
 =?us-ascii?Q?NO7mTGE1sWQ9QQET/iKwTfWEUua00E2BWtJYQANc25Rig4+WkWXP339Xg4re?=
 =?us-ascii?Q?bvWdmFlXS/DDMMncRgsbKe0EclDWcxnMJBrqJwTrag2VCN6QzkwvgjeRnd0X?=
 =?us-ascii?Q?3um/TYLxX/ulByq78/x+OzwLWzIZcWAeep8qWc/M8NUC+oEwXXAUREGx2oyd?=
 =?us-ascii?Q?QUPGWa6pfiIl12rgsvo78XIglMdSAFIs3Dmd0Ug+gPGk3w39NgwU0x8zL6K8?=
 =?us-ascii?Q?mh8DoE6cqQhdEv0INtiojbybvexhYRpI/GUKP8jhNjqlGUoEoviKWcZTpW2J?=
 =?us-ascii?Q?WW4Hma4QaWH4GY2aYljKnyUkVtMCn5RAQyTt84oCOgH5gaZPhOJkytaGw4Ej?=
 =?us-ascii?Q?7JbsEQR1FaYZ/1vlLJeASp3DKT3fCnxD3YeMPqKeBYWXW7c9M02xPO4/1ysH?=
 =?us-ascii?Q?rWoQmn+2kTyCR2CoWomXRlDBML6kQe7LRsZNTA07zvxfmB5aEfhHmRoWJdlM?=
 =?us-ascii?Q?IDee9P+CV8efMCVTBD21dcbi4jQjz+3xVeifDGu64T6+OqCRpD6/ub1mBCAI?=
 =?us-ascii?Q?aN3JQSMvmIyng1cXNSgOgpRBm+l69xdkJhUya+x/mqGdDfksSAPlSSJxI3y8?=
 =?us-ascii?Q?U7voTgyW7AEEW9esjU10ONsQme8m+8la6O9WYSEzWwZeB+fIjMICAKT345/P?=
 =?us-ascii?Q?pv3qLJV89sBfCy+FJ9WfwmqeLbUNMrR9g0ToS4BCyklSZIWnwuXjm9S+kAaj?=
 =?us-ascii?Q?Z60sRKVtqCK05z9OIfYMk+ai16xBpVEbBlpuFpngnvdYLy/a7WfixEEGpfSY?=
 =?us-ascii?Q?Xc7Jy8NzQD2O9rPopnIpRFlhKbjAv3sAywPu0F8F77SzwU6SHya4S32Fq1UK?=
 =?us-ascii?Q?LlrglCEcavmj7tNKqPEi6btyXiq1cCf14U9h5a6FRuq6cpWLTEW7MNswF+AT?=
 =?us-ascii?Q?IMnJObw49M/uRd6Ty9P0gMpV5g=3D?=
X-Microsoft-Antispam-Message-Info: bxA2lJE+/vtLxf5Iu6t+lz4oSXF9MOb+eeg+ONFD8/p62D36cGZVa4Eqo1irVECHTfH4I02AVhJZzR3lumqzb6R+0YJ4je+7DpG6xkv3OTt63R1nn1TtdrA3u+TPUfBeTwcIQa9sYUFzo+A4knBNavOgXNdiXqoFnGUI6bbPnC1lI0inZgYW0PIe7/L1O5A9hiSz6lgtpLwKuSnfLaA4rKFsu5XlE02cE/f+4I63DTCXqIdgx1W+8pl7mT40qUAGs631hYLz+afe2//A20IRstt9tfevNLOJyqbNdyXGkEQSWYFuWioSt3E6BeYYlQ7qH52XiF+58wLgE2oW8Ref9SOJ5J9GM8ycKyRNlBaYlJI=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 6:P3RV5K9QO74uNvxM4a2RYsCE8DGx87LXBWKqhuK4nCpt0cJou6NK4JAxhIt1s12cS6Itil0/OApQVJJiE2VRidi+JIw6GRwrmA5avXgiQ3h80aGPWNH+UcrBlWTkcUA8FX6Okhd8r+whd6LCplo+Vvi97tCdBpzDzXKYxFkE9VEMNX2EA4R2SEvEXzwQatocgDKojShrRQvOCJDKTaZAfrcm7d99vFUlJ9wCsnDB9S/yMEH+vvEqvLZ9tNbD8CEirNK6ULYWTwT0zXjThfDQtRfP65rPlff5tIdd+sWWs3IU5y+6J/VxpMugB0O+zTXlP1Gkbbo8bAuinxNr8PssuHLJXM3XMl+xAEWBaIN3TtRohmvZfAz/7w3aFFkGEQjweirHJHpMrWJ0vXCmVHdwRb+VXDebIamqJkREst1AUaYQK6mU5StnGajABo5V88Y8gx5xiX2LApmKRmS7EUAdlw==;
 5:aPu3K60vnFxXDWmxfgM+abjFWpzVYSKAfgUQYcXCRhKQ+TQ+TYS45neyOyufkaz3M1ahSAPxcvbAcRXPfcsiMKorAWirZnBrkQmi6vc9AuNKJXC58yb2a01PHMphMroaOLtSfH1N7XJ8fkntXtu2LGUQ/fSaiGUdUyCfpuaK75A=;
 7:5R1nZrRPWbsw7UQhEj2rbXW4wWR0+TZyotUDx/5wVqBcIp6z4xsErIIPtaHci6g2Sy8jgP3aTxNAZMRhgPpLFcPMKR+cxFI4I+6HSzJ0cXxo8hrslKwFDNoe13TuV6VOcasO6sAVQGoxkZ/FjbjiFrbfxb6i+8FAAYI8brxFY58DGh4lbYOMJnD6lobuSprcfB2epXgs3W2xrvl3wk1mCkEU2nxaTAY0ih4kCQvNSj5fi+fWivd8DL7pwi/LlN31
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 13:09:25.2213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2648fdb2-14e7-42e4-aaf5-08d629fa9f28
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
 Priyanka Jain <priyanka.jain@nxp.com>, pankaj.bansal@nxp.com,
 Zhang Ying-22455 <ying.zhang22455@nxp.com>, linux@armlinux.org.uk,
 Ramneek Mehresh <ramneek.mehresh@nxp.com>, V.Sethi@nxp.com,
 Vabhav Sharma <vabhav.sharma@nxp.com>, Nipun Gupta <nipun.gupta@nxp.com>,
 Sriram Dash <sriram.dash@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

LX2160A SoC is based on Layerscape Chassis Generation 3.2 Architecture.

LX2160A features an advanced 16 64-bit ARM v8 CortexA72 processor cores
in 8 cluster, CCN508, GICv3,two 64-bit DDR4 memory controller, 8 I2C
controllers, 3 dspi, 2 esdhc,2 USB 3.0, mmu 500, 3 SATA, 4 PL011 SBSA
UARTs etc.

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@nxp.com>
Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 702 +++++++++++++++++++++++++
 1 file changed, 702 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
new file mode 100644
index 0000000..c758268
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -0,0 +1,702 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree Include file for Layerscape-LX2160A family SoC.
+//
+// Copyright 2018 NXP
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/memreserve/ 0x80000000 0x00010000;
+
+/ {
+	compatible = "fsl,lx2160a";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		// 8 clusters having 2 Cortex-A72 cores each
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x0>;
+			clocks = <&clockgen 1 0>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x1>;
+			clocks = <&clockgen 1 0>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x100>;
+			clocks = <&clockgen 1 1>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x101>;
+			clocks = <&clockgen 1 1>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x200>;
+			clocks = <&clockgen 1 2>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu@201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x201>;
+			clocks = <&clockgen 1 2>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x300>;
+			clocks = <&clockgen 1 3>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cpu@301 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x301>;
+			clocks = <&clockgen 1 3>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x400>;
+			clocks = <&clockgen 1 4>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster4_l2>;
+		};
+
+		cpu@401 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x401>;
+			clocks = <&clockgen 1 4>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster4_l2>;
+		};
+
+		cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x500>;
+			clocks = <&clockgen 1 5>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster5_l2>;
+		};
+
+		cpu@501 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x501>;
+			clocks = <&clockgen 1 5>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster5_l2>;
+		};
+
+		cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x600>;
+			clocks = <&clockgen 1 6>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster6_l2>;
+		};
+
+		cpu@601 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x601>;
+			clocks = <&clockgen 1 6>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster6_l2>;
+		};
+
+		cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x700>;
+			clocks = <&clockgen 1 7>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster7_l2>;
+		};
+
+		cpu@701 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x701>;
+			clocks = <&clockgen 1 7>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster7_l2>;
+		};
+
+		cluster0_l2: l2-cache0 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster1_l2: l2-cache1 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster2_l2: l2-cache2 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster3_l2: l2-cache3 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster4_l2: l2-cache4 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster5_l2: l2-cache5 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster6_l2: l2-cache6 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster7_l2: l2-cache7 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+	};
+
+	gic: interrupt-controller@6000000 {
+		compatible = "arm,gic-v3";
+		reg = <0x0 0x06000000 0 0x10000>, // GIC Dist
+			<0x0 0x06200000 0 0x200000>, // GICR (RD_base +
+						     // SGI_base)
+			<0x0 0x0c0c0000 0 0x2000>, // GICC
+			<0x0 0x0c0d0000 0 0x1000>, // GICH
+			<0x0 0x0c0e0000 0 0x20000>; // GICV
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		interrupt-controller;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		its: gic-its@6020000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0x6020000 0 0x20000>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a72-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	memory@80000000 {
+		// DRAM space - 1, size : 2 GB DRAM
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x80000000>;
+	};
+
+	ddr1: memory-controller@1080000 {
+		compatible = "fsl,qoriq-memory-controller";
+		reg = <0x0 0x1080000 0x0 0x1000>;
+		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+		little-endian;
+	};
+
+	ddr2: memory-controller@1090000 {
+		compatible = "fsl,qoriq-memory-controller";
+		reg = <0x0 0x1090000 0x0 0x1000>;
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		little-endian;
+	};
+
+	sysclk: sysclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "sysclk";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		clockgen: clocking@1300000 {
+			compatible = "fsl,lx2160a-clockgen";
+			reg = <0 0x1300000 0 0xa0000>;
+			#clock-cells = <2>;
+			clocks = <&sysclk>;
+		};
+
+		crypto: crypto@8000000 {
+			compatible = "fsl,sec-v5.0", "fsl,sec-v4.0";
+			fsl,sec-era = <10>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x00 0x8000000 0x100000>;
+			reg = <0x00 0x8000000 0x0 0x100000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
+			status = "disabled";
+
+			sec_jr0: jr@10000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        = <0x10000 0x10000>;
+				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr1: jr@20000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        = <0x20000 0x10000>;
+				interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr2: jr@30000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        = <0x30000 0x10000>;
+				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr3: jr@40000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        = <0x40000 0x10000>;
+				interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		dcfg: dcfg@1e00000 {
+			compatible = "fsl,lx2160a-dcfg", "syscon";
+			reg = <0x0 0x1e00000 0x0 0x10000>;
+			little-endian;
+		};
+
+		gpio0: gpio@2300000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2300000 0x0 0x10000>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio1: gpio@2310000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2310000 0x0 0x10000>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio2: gpio@2320000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2320000 0x0 0x10000>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio3: gpio@2330000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2330000 0x0 0x10000>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		i2c0: i2c@2000000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2000000 0x0 0x10000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			fsl-scl-gpio = <&gpio2 15 0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@2010000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2010000 0x0 0x10000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@2020000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2020000 0x0 0x10000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@2030000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2030000 0x0 0x10000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@2040000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2040000 0x0 0x10000>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			fsl-scl-gpio = <&gpio2 16 0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@2050000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2050000 0x0 0x10000>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@2060000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2060000 0x0 0x10000>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		i2c7: i2c@2070000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2070000 0x0 0x10000>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		uart0: serial@21c0000 {
+			device_type = "serial";
+			compatible = "arm,sbsa-uart","arm,pl011";
+			reg = <0x0 0x21c0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed = <115200>;
+			status = "disabled";
+		};
+
+		uart1: serial@21d0000 {
+			device_type = "serial";
+			compatible = "arm,sbsa-uart","arm,pl011";
+			reg = <0x0 0x21d0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed = <115200>;
+			status = "disabled";
+		};
+
+		uart2: serial@21e0000 {
+			device_type = "serial";
+			compatible = "arm,sbsa-uart","arm,pl011";
+			reg = <0x0 0x21e0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed = <115200>;
+			status = "disabled";
+		};
+
+		uart3: serial@21f0000 {
+			device_type = "serial";
+			compatible = "arm,sbsa-uart","arm,pl011";
+			reg = <0x0 0x21f0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed = <115200>;
+			status = "disabled";
+		};
+
+		smmu: iommu@5000000 {
+			compatible = "arm,mmu-500";
+			reg = <0 0x5000000 0 0x800000>;
+			#iommu-cells = <1>;
+			#global-interrupts = <14>;
+			interrupts = <0 13 4>, // global secure fault
+				     <0 14 4>, // combined secure interrupt
+				     <0 15 4>, // global non-secure fault
+				     <0 16 4>, // combined non-secure interrupt
+				// performance counter interrupts 0-9
+				     <0 211 4>, <0 212 4>,
+				     <0 213 4>, <0 214 4>,
+				     <0 215 4>, <0 216 4>,
+				     <0 217 4>, <0 218 4>,
+				     <0 219 4>, <0 220 4>,
+				// per context interrupt, 64 interrupts
+				     <0 146 4>, <0 147 4>,
+				     <0 148 4>, <0 149 4>,
+				     <0 150 4>, <0 151 4>,
+				     <0 152 4>, <0 153 4>,
+				     <0 154 4>, <0 155 4>,
+				     <0 156 4>, <0 157 4>,
+				     <0 158 4>, <0 159 4>,
+				     <0 160 4>, <0 161 4>,
+				     <0 162 4>, <0 163 4>,
+				     <0 164 4>, <0 165 4>,
+				     <0 166 4>, <0 167 4>,
+				     <0 168 4>, <0 169 4>,
+				     <0 170 4>, <0 171 4>,
+				     <0 172 4>, <0 173 4>,
+				     <0 174 4>, <0 175 4>,
+				     <0 176 4>, <0 177 4>,
+				     <0 178 4>, <0 179 4>,
+				     <0 180 4>, <0 181 4>,
+				     <0 182 4>, <0 183 4>,
+				     <0 184 4>, <0 185 4>,
+				     <0 186 4>, <0 187 4>,
+				     <0 188 4>, <0 189 4>,
+				     <0 190 4>, <0 191 4>,
+				     <0 192 4>, <0 193 4>,
+				     <0 194 4>, <0 195 4>,
+				     <0 196 4>, <0 197 4>,
+				     <0 198 4>, <0 199 4>,
+				     <0 200 4>, <0 201 4>,
+				     <0 202 4>, <0 203 4>,
+				     <0 204 4>, <0 205 4>,
+				     <0 206 4>, <0 207 4>,
+				     <0 208 4>, <0 209 4>;
+			dma-coherent;
+		};
+
+		usb0: usb3@3100000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3100000 0x0 0x10000>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
+			status = "disabled";
+		};
+
+		usb1: usb3@3110000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3110000 0x0 0x10000>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
+			status = "disabled";
+		};
+
+		watchdog@23a0000 {
+			compatible = "arm,sbsa-gwdt";
+			reg = <0x0 0x23a0000 0 0x1000>,
+			      <0x0 0x2390000 0 0x1000>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			timeout-sec = <30>;
+		};
+	};
+};
-- 
2.7.4

