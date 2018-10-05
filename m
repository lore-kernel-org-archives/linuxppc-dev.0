Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAD_ENC_HEADER,
	DATE_IN_FUTURE_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF2AC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:03:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A9720875
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TbHYQ2J3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A9720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RHhR5bgkzF3KL
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:03:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="TbHYQ2J3";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.66; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=pankaj.bansal@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="TbHYQ2J3"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50066.outbound.protection.outlook.com [40.107.5.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RFTZ0fkxzF3BT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 13:23:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9sk7M1fY6KAWkHFHr6aWAAlsBCdoFLU8jQChbLc7vU=;
 b=TbHYQ2J3TN/ZYk/VMsb0IbGMm9Vv7RDFi0DW4u1x5Citncxc1LGqWP+KHqUtkZKLiQOy0opwKxMJbdqte/vCy6tSQSxLFd+iaSTgbLS0wNJxFxC9lflstLFRD2MhbbnhwqWWjGULfWHI9qcoURm30AeO0rlF9CyL+ivMqSDYOBM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
Received: from uefi-workstation-2.ap.freescale.net (14.143.30.134) by
 HE1PR0402MB3324.eurprd04.prod.outlook.com (2603:10a6:7:81::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Fri, 5 Oct 2018 03:23:25 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: [PATCH 2/2] fsl: add i2c controlled qixis driver
Date: Fri,  5 Oct 2018 14:25:05 +0530
Message-Id: <20181005085505.29024-3-pankaj.bansal@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005085505.29024-1-pankaj.bansal@nxp.com>
References: <20181005085505.29024-1-pankaj.bansal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: BM1PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::21) To HE1PR0402MB3324.eurprd04.prod.outlook.com
 (2603:10a6:7:81::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1009993-abf0-4e88-5eba-08d62a71ea4e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0402MB3324; 
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB3324;
 3:R+/y9rwxQWJbsMjGdSmPRrDHRVoBggk/PBskr0duzJgTsYYyEUEkd53kP1hlAzNLiDCE59KtmyxZ6GI9JtEz4+xCgtLexhlZbBQDjFNBXx07d0wexMB+i8agcWsB/uyjJjhV1HfOnYFikFeDEFuHyjBRJQ/4kbbvb174zzcKAaxHu0FOdVgU+qYtMpvjXwQtF8YoO/V0A1GvxEBdwsRWjtt8cORm71FXhrCwZphT50YbCulfhzHM8xd+1g66ZJlC;
 25:Lw19hom2yt0mWqouJtRi+jCn+pP3XfkDZLY/JJCHwn6vhXi82vq5aMFJ6ACrDySXyJ2lfK9jTd+qVdbmukrdvcyHOBnlpMJDIoux+SxPh9zFpDTeKzdZGPKa9tTK2ySi+PrrNk0QTReHWrJ7gOHb8Dj1OGx574rpveDsPHPKq4NvLNkUB+ECmVY9Kz1gxhMLHq9t++RDwFdT3ny645OjquW/WGGIGo5pYQOHCUFLpkFT6xI1OJ+3s/afxU1U1n/f+y1rWCrT565ZHF7OdDlW2ZfTF20IE/Wrp7HCQbEvv0nyivEvv5vqu/I4RFYV2fwdSpx9QsSRaEtnVBuhUUAFaw==;
 31:DUNxEqon984dgU1SDsIb89dCi0IQ1UUmHFq6QTt9v8k3RteapgBIzmlfWsv8J9S5hUjToSYOS27Rk2w46+hd62clKlSIzVYIWFhIvaA9aboYxzqM+XxO1kuqJ5CWHUI5wYhdksaxPiFzIButiPCGwKmuAYFJ+78me5Wz0Sl08Hlau9kJnWCGubnNTKGDP3gOhH2SeEb4AaF55CexGuJmY2njGLfMk0IKxFK89hFsVbM=
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3324:
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB3324;
 20:ExPvgbKSY2p5WPFBM+66LVLYZUlj23L8DgF/rOhF6NBYhRSsl5jwKwe0lUEY4qnUkMexq27JICZviLCPGqvSAihkHE1ZW6tkGQRIW4x8Q3h9q1qTZ6Dn3RGDKAov+2y4MgswgGux5iq4WDCRyfO2O2BQTidxpDRGQx5d+brWUl3UjoJBeCAnyGM+mDZ0LEvjJzldlyZ7gxy2T1ZIgxdF46dWd5BAG9W2c96oPmVGWUe21/8x1faP8RmTeluhIsk2bhc7RlrxqFTzE/NG7SK9LOvAheoehugiyA8zhgtQGNJMMigYcJTTg+2ZqdbEOhO+eIwrvaWxbbf3NIzIQTkHgRWswT5Hjt73JLYn7uUIIQ9MPMm8C3BwIHh5N+HPzEJbe3osphpuXgQjxFxfHK9j5rpkZ7HNxiGW/Gw02wbmfez7iRt3HqPrOg4KUiIjgskkjv1CTvy9ulDFiM241Qf1rRjfrN2BQVbXkDTRFcCCYO6mMySTu0alQxcE8gPUnxiy;
 4:JEFHFDzpKWGRmU9GLTPF0sUn4nW6JzomasbDRw7QMG57MF1ZoKlzXVYRXrd73uk8wHx5eMbBNkCdTL/YPqKZqFBkOXhXdEsVVXHfD+OWq/jKc1D2Uhd/6wz7TQtpX6LIvw8/U2jXvTI8hrkb7KPNk1Fe/5UHF6ZpnyjwtL11GZ4UxOXCg6kBHqBAvF0qEouWtsGlGnXH44ftf5+RfRmJInkKxVEubPUPbAc17uJGgbYAuG7o8EHzUqy5A0tQMMylpzJKmgVyNwEA5E2k9nzCl/4iffvcp1xbR391kE58PkkR3jFkvcwDq3ZZkSfnE0lukhTAWJwhwtFrPgrCikCSzTeHD0TaAqnfTMYVyqsqZBo=
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3324EF3DD92E3F02E168FEAFF1EB0@HE1PR0402MB3324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(101931422205132)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051);
 SRVR:HE1PR0402MB3324; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0402MB3324; 
X-Forefront-PRVS: 0816F1D86E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(2616005)(186003)(81156014)(81166006)(478600001)(1076002)(6486002)(52116002)(50226002)(8936002)(386003)(55236004)(97736004)(5009440100003)(6506007)(107886003)(6862004)(316002)(8676002)(5660300001)(16526019)(51416003)(26005)(446003)(66066001)(44832011)(105586002)(11346002)(76176011)(106356001)(476003)(48376002)(6512007)(6116002)(3846002)(16586007)(6636002)(7736002)(4326008)(486006)(37006003)(53936002)(68736007)(54906003)(956004)(25786009)(50466002)(36756003)(305945005)(86362001)(6666003)(47776003)(2906002)(575784001)(110426005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0402MB3324;
 H:uefi-workstation-2.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; HE1PR0402MB3324;
 23:OqbHDhvfHPTQmF7x1mmsX3l2ojBfyq6HsHjtNWK?=
 =?us-ascii?Q?Zygv6RL1fMOegxL8eNoiMIBVnTXhKl2boPl9vH9VyPBAvyglcHNyCy0ZcIdC?=
 =?us-ascii?Q?53NsaAtoKf4GxAmU/ymNzWmgP7ticbd9Gxcueyz/tBaR4n6cLuPGo4GdMeuN?=
 =?us-ascii?Q?OBgczC1cJ5Mv5UeJyJGPppYCPh7zkIxpCLDNtTSnhwdYOJUgal+z/Zu0gbx6?=
 =?us-ascii?Q?fx5bJDZ55VbCKI46EN6ODpJWc0buk4wpF+iITOauTjC9OXbh7uZnrDAyybyq?=
 =?us-ascii?Q?2yeEyzkSkPa3IttnitYCXfSaEiJKQ+zA606700WU9dshmfwCjFzWu19gUFmo?=
 =?us-ascii?Q?siSNpLygDOE06JKZaImeQXRV4EejOrUe+hNWHYDrLb0Vecyt7V4wPEOGFptO?=
 =?us-ascii?Q?WCzUPp73BKkhNFFhLWxkGqxuCBRO5VkPWcNuiMf5eFa4T1ZJrE0x4Hp2gbN2?=
 =?us-ascii?Q?gNVHN33oKwLY4lpPvCxlvvJDnLGVYi1oKovBpAEFyyPXhK48aV2NG+eesC2F?=
 =?us-ascii?Q?sN1OdvDO/KHB6MOrbMXNxyzuXmxKysiw8W62VQZsNcBbZPkR7B9oZ6X5fJ3K?=
 =?us-ascii?Q?WtsYSqds7KT/lHhveR/lSwXTq+tj4siF2Py1SRzj+PMYa4klYJ5W6st0TmZN?=
 =?us-ascii?Q?Z8r+kPeNkDrtP+g1QEVHWfJcY820gUKkcnHpQ9WtghBfUQmxhNJaLUGIgFQe?=
 =?us-ascii?Q?d/sADfBeNHO0WsmIbgtk5pE6c0Nob+/6VMmiSmdIYlvMfNwqfDbk095LtAKx?=
 =?us-ascii?Q?YpsX54M7o4YcuJBBKHZ/giKLSpBRkmVcnHaak+43NkraKT03MtXvQ6NvymnI?=
 =?us-ascii?Q?DzuZtct82AloqxsNsC1ofHdzD/d46hms/q8C6FivLSk/R3ttxqkqAS/AK2Jz?=
 =?us-ascii?Q?oVxANeV+HqmN3XQZfRe6Rc3omUjL8wF7RNGUkiHlZac7UUXzooPzmc2u0KAt?=
 =?us-ascii?Q?h/9z9CBl8EFzwnajV1YOuDkfLQ9LtR0ioq9SPGRfY5ePMoL/t3G3H35BK1dH?=
 =?us-ascii?Q?r1HMUu+ObfZPdmHR29N4IT/0r2eGPngCKg51SN7a2MGO7t9WkQyzZVfjqxY6?=
 =?us-ascii?Q?wtGW1GpcTqaEQiy8krt94BgQZ5OStZno6wvplxlF6LLQNeTtWatky0OL77Cm?=
 =?us-ascii?Q?S5RM8XWWL95UFvVLs9T4p8XJotcQIexMxVPjhpuDDO+eIBf4ejF8JByMmIVd?=
 =?us-ascii?Q?TkyO1IZHRTNxumQ1RD5ynzZwiiRtHHaR1v05WJ0sE4nl5A6+6lGO29t1sc4a?=
 =?us-ascii?Q?dnMYb7/UAWfdel0o7tS53q5ueFh7ElXL0/H6R/JEW3SLUtSqupUdWfGFGbVL?=
 =?us-ascii?Q?AriE11ZjvmoWOEk0i0zGfQ8CHoku8NOnGw/ePwtcJPdziUF1LDKpbeQrx8Fk?=
 =?us-ascii?Q?XyBkTHvZUr3YI0B5Z6qFxOw3QQRs8GEqJYG6xgczsw59bkLDF?=
X-Microsoft-Antispam-Message-Info: tY1yxhAO2uziOcSS2qblHCnIxt130u0NYjmvU4ur8DjKaiUiIkMSzMqHpqG3B+Q2swRSAVIYWodt0W1xn/Uz/151OAtzfNGoqiIXHP+7kwmc/SyDZnPAoPwrv1EAFZrIpOak+1K3I/shvqMyVxKDwoz95RJpUab/Sx/bRUVkraHskfYPpnU2v273T23w1eFRsJX2mfANlxWgXBSBfDh+ZeM165LU2ivl/1ScfyOrbkv+JwLMYaXbKX6Rt7OUNkeet033F12PuAPSPiRfAOkuxp/DTVyUUBOGM6H3ufzmzWysm3nOKEVR+DERzskS8Uq6j2Ez71PewyDEY0pvPH6qRoBLNK4WSVmYR6ARcJF5TjQ=
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB3324;
 6:ydz4A3iJXdm0faIbQXKF6hqXdZLwjjRjNuWuBP+h3DdWHgP0UsQclTNcBuUeTdREfLqkqFryGmCpka91BEq84BepHTNcXPtR+75PM7HQ7Y0PAFmEmbRlBfIKlB0IgHCsMIBhrbRo5BcBJ3ohEEk+bIeWd5KURxrZH4b3974kWiCi1INtwCdV4hWNTIb903lMZ1QPIuIr653Uo0CZX5LD3Gr4/XY9217HcofAGcN2kX8rLeVS0Fzpm+LTNirrfAfES7UV3eZ7KsfwI44GgIjFzCaBeo6mqWp8qGWPHEZ4kfpn89HK4GhZZ6C3dRXKoXFfCSEWs6nHahR6aSjfMR86mSMUvxbXCftsO4Jy1buTKkgjiYGsgYw1fzDZ52oquEAfh7e6XeNcm1Qxqm24DV/lEBrUOh9iZ9BwTjtYP3ahynfBseXCAmSff/ly9F6J3fkGPL/v+NU0SZTtnL0cnQ4kxg==;
 5:e5/67fhjFE2S1Ce8Fe8AFczFeo17zb5z8GlDqD4MkI+YeBUBH5i4NMWD2U5AJ04y6i1xDI8Yvftzbsp1su7ShiNvHLFu7+8coOj6jOjVwSJcXVinLuWS4yPVVyhRYnOq7LGE3JUZGDLdZ8lrwkIF5YvFizV3OxVBibGIrDc9Qls=;
 7:C+LYrGhOoHhD6eaADqd9tgBec6BE4e87v3RCM6CPlgIYeoBol/SEqKCRWzIcHZjvQnbt8ihlt2+soLRgGpmRvz2OXS+1wegOyB1PNs6GipF45j+QaBT4f7xd82vbXhFWFUN4yPK+PXFBb4sTqpYc8iBKEXvrsbGnutKz4QSTGdJ/r3h0G3mOlViwRTzZCb/12pj/DqS52u7rWBlAHitrexwiOZ7TRJnRNdKhFfq0qsawJkLfe2lORqC4IDi3rh71
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2018 03:23:25.6429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1009993-abf0-4e88-5eba-08d62a71ea4e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3324
X-Mailman-Approved-At: Fri, 05 Oct 2018 14:38:19 +1000
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
Cc: Alexandru Marginean <alexandru.marginean@nxp.com>,
 Pankaj Bansal <pankaj.bansal@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

FPGA on LX2160AQDS/LX2160ARDB connected on I2C bus, so add qixis
driver which is basically an i2c client driver to control FPGA.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---
 drivers/soc/fsl/Kconfig        |  9 ++++
 drivers/soc/fsl/Makefile       |  1 +
 drivers/soc/fsl/qixis_ctrl.c   | 75 ++++++++++++++++++++++++++++++++
 include/linux/fsl/qixis_ctrl.h | 20 +++++++++
 4 files changed, 105 insertions(+)

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 8f80e8bbf29e..c355c2cbbd45 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -28,4 +28,13 @@ config FSL_MC_DPIO
 	  other DPAA2 objects. This driver does not expose the DPIO
 	  objects individually, but groups them under a service layer
 	  API.
+
+config FSL_QIXIS
+	tristate "QIXIS system controller driver"
+	select REGMAP_I2C
+	default n
+	help
+	  Say y here to enable QIXIS system controller api. The qixis driver
+	  provides FPGA functions to control system.
+
 endmenu
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 803ef1bfb5ff..47e0cfc66ca4 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -5,5 +5,6 @@
 obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
+obj-$(CONFIG_FSL_QIXIS) 		+= qixis_ctrl.o
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
 obj-$(CONFIG_FSL_MC_DPIO) 		+= dpio/
diff --git a/drivers/soc/fsl/qixis_ctrl.c b/drivers/soc/fsl/qixis_ctrl.c
new file mode 100644
index 000000000000..b94649fb9726
--- /dev/null
+++ b/drivers/soc/fsl/qixis_ctrl.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/* Freescale QIXIS system controller driver.
+ *
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ * Copyright 2018 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fsl/qixis_ctrl.h>
+#include <linux/io.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+static struct regmap *qixis_regmap;
+
+static struct regmap_config qixis_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int fsl_qixis_i2c_probe(struct i2c_client *client)
+{
+	struct platform_device *pdev;
+	struct device_node *child;
+	u32 qver;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EOPNOTSUPP;
+
+	qixis_regmap = regmap_init_i2c(client, &qixis_regmap_config);
+
+	/* create platform device for  each of the child node of FPGA node */
+	for_each_child_of_node(client->dev.of_node, child) {
+		pdev = of_platform_device_create(child, NULL, &client->dev);
+	};
+
+	regmap_read(qixis_regmap, offsetof(struct fsl_qixis_regs, qixis_ver),
+		    &qver);
+
+	pr_info("Freescale QIXIS Version: 0x%08x\n", qver);
+
+	return 0;
+}
+
+static int fsl_qixis_i2c_remove(struct i2c_client *client)
+{
+	return 0;
+}
+
+static const struct of_device_id fsl_qixis_of_match[] = {
+	{ .compatible = "fsl,fpga-qixis-i2c" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, fsl_qixis_of_match);
+
+static struct i2c_driver fsl_qixis_i2c_driver = {
+	.driver = {
+		.name	= "qixis_ctrl",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(fsl_qixis_of_match),
+	},
+	.probe_new	= fsl_qixis_i2c_probe,
+	.remove		= fsl_qixis_i2c_remove,
+};
+module_i2c_driver(fsl_qixis_i2c_driver);
+
+MODULE_AUTHOR("Wang Dongsheng <dongsheng.wang@freescale.com>");
+MODULE_DESCRIPTION("Freescale QIXIS system controller driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/fsl/qixis_ctrl.h b/include/linux/fsl/qixis_ctrl.h
new file mode 100644
index 000000000000..00e80ef21adc
--- /dev/null
+++ b/include/linux/fsl/qixis_ctrl.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+
+ *
+ * Definitions for Freescale QIXIS system controller.
+ *
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ * Copyright 2018 NXP
+ */
+
+#ifndef _FSL_QIXIS_CTRL_H_
+#define _FSL_QIXIS_CTRL_H_
+
+/* QIXIS MAP */
+struct fsl_qixis_regs {
+	u8		id;		/* Identification Registers */
+	u8		version;	/* Version Register */
+	u8		qixis_ver;	/* QIXIS Version Register */
+	u8		reserved1[0x1f];
+};
+
+#endif
-- 
2.17.1

