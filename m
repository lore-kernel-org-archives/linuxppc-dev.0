Return-Path: <linuxppc-dev+bounces-18238-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B56D58B07
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 12:27:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZDr81KjDz2xpn;
	Mon, 16 Mar 2026 23:27:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773664056;
	cv=pass; b=bjvGf7XffarzpJmDxW6fE0h6wj+rUdV5PEouUmagsuEdzLqqjEHQDW0V8vr6N0/NYgkun82S3txF1MfT+U3ABu7Oj1BcUcs3KohiJT7gcBhMvvfYHK2F+BXjcxK6zBU6VHY3vtISw5pOuLAEz0PCIluDS3xxhpJ4Euii0uFZyn6uzs6oYC1t2CfdyX2JunStTWy98JC6OYkMGI1VTcev7S/ciJS5fcW9Gf7iwTaVM/1rYJe6PvnOrsQT1C7tTLAWuVJne+7+YXOhzw1o6tnbHkSd6oDjFE2fPJ6wP1vr551riMiflJuM95EhTantWG03yTKc/doyhaQ5ZC/pwEE8Cw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773664056; c=relaxed/relaxed;
	bh=yXPVx8tZmEUGsO7BZr5w+XXCMNwcunqUZgCOrtBcpwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hz7EbwwFd7Na9Ju/sf+Y9PzJOM4K9qPbaqqO2RuIuFk5+BCCU/6rWtWMJvJyNYYSRWPpClywvPn+aGHUviUyHmQFzBLv0W5isOyIv+fei6isn1Y19YCXt3M7y/WeVnLN78UAvQJeS4GMaHr0dsHbqk501C3ybw99KsLLp0g6OGPm/pMjZ03KcOJHqrbhuzlxDFuE/W/tKd716VKi1PgtJdwlJCQZdv7wzAsIWs4aChlez1L0iu3utnkLfpmAm/07qOe0ExVaJL+qh7hlKjIs/yBWgeUOHa9IOGlcr4KxB71RBnBytMlSNgJsVSR+fZVaN/9xDbLORuGNSUV4cpIyFA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=OKKyGAy2; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=christian.bruel@foss.st.com; receiver=lists.ozlabs.org) smtp.mailfrom=foss.st.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=OKKyGAy2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=foss.st.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=christian.bruel@foss.st.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZDr54zV3z2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 23:27:32 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsbYuCGJv8Np9DS5+skjXLVbpNB1fb5fU6L5tVXIZd3IyfSKm2JCwBLH5diXHoWEKv6gmeLEXDMF9KT9IWD8OFmTzAoa6GXOB+Nybowuldhp6/FDg6V8kbBXbvgLnZH6JV0kTkG5rJH7SjKVH9bXbJcB03SelrpPSzGvAgOL0q2XEELagu3KC5fxQ1j7p+WRrfm0CUl/j8mYcyEeFhcWoQwXdOs8G9EcuEKUFSzxJ9vtCeLvbUbhyY3H0VoSfjYq1XgEkUzSIVG69+PTaQtN7n5g9XYcaOzQJ3+J/2aymA/g5/iot3uW8qamuydCG1MIbFWBPjgxKy5yy0jA3mAhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXPVx8tZmEUGsO7BZr5w+XXCMNwcunqUZgCOrtBcpwQ=;
 b=A2d65HKFQsf9r4DaGlBy03nVW8xPN4dbz6kVTCublPa3yqyPMtSJAX06ZRil7iIhMR295vBzciDgGmPBndwbJohqz2XLqFV1z0T+mvOHojp5Xt5lNRxtTKrEE5iqVXWIYDS9RlvdzSqlghkPBTlpROcIhwPMTaXQ4f4jWcnnAOguEJOjoAi1I6WgrC1yLWLuLeYw3kjz9heaV5D5gpJ8JffB1Vu+s2jXCNJJlN7yLDUu/hxPd+A5zNidgLhu2NI75rZrQYmUQg+x7uUh/gROGiYN2k99DDOHmXUAdBAsWS9qnX9QRZJJS2rmcFiYaOacfEanotYdeJuDPXpMTRwcpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXPVx8tZmEUGsO7BZr5w+XXCMNwcunqUZgCOrtBcpwQ=;
 b=OKKyGAy2mT2mVYANI7jTouW0qXFEyoSfAX3oqKR0jQMQC/hD2sKJ7oBOMJN/0xxYirH0D6YHtr735DSFTl5htrdqcZks5fCneDRnECt8Pt/TNlr2q5Rof/g8fAbdMq//DqZoRwZDYz58yH354LxHgMxsf5LSq3ZV6U0VVc+7dr14TXpob7kjapc1TVqZnRJne7f+x+Hw1M1bza4+vgaRfwdACcyuVEfzFj1f/evQfRF/dvsug99MX8R4wRRkwMG9B7EaId0sNqVOBNl51g+SX4yj87XkbzejJM1iVJOO7bISY2Ltnf1BEyGSCAJPPVER08J2lNA61CvFpsq7ZM7WqQ==
Received: from DB8PR06CA0059.eurprd06.prod.outlook.com (2603:10a6:10:120::33)
 by DU0PR10MB7360.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:444::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Mon, 16 Mar
 2026 12:27:04 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:120:cafe::74) by DB8PR06CA0059.outlook.office365.com
 (2603:10a6:10:120::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.22 via Frontend Transport; Mon,
 16 Mar 2026 12:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 16 Mar 2026 12:27:03 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 16 Mar
 2026 13:29:18 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 16 Mar
 2026 13:26:58 +0100
Message-ID: <004f0397-6b86-4a0e-9dd8-29293fb43ffa@foss.st.com>
Date: Mon, 16 Mar 2026 13:26:50 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/8] PCI: dwc: Advertise dynamic inbound mapping
 support
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Koichiro Den <den@valinux.co.jp>, <jingoohan1@gmail.com>,
	<mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <cassel@kernel.org>,
	<Frank.Li@nxp.com>, <vigneshr@ti.com>, <s-vadapalli@ti.com>,
	<hongxing.zhu@nxp.com>, <l.stach@pengutronix.de>, <shawnguo@kernel.org>,
	<s.hauer@pengutronix.de>, <kernel@pengutronix.de>, <festevam@gmail.com>,
	<minghuan.Lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
	<jesper.nilsson@axis.com>, <heiko@sntech.de>, <srikanth.thokala@intel.com>,
	<marek.vasut+renesas@gmail.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<geert+renesas@glider.be>, <magnus.damm@gmail.com>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<hayashi.kunihiko@socionext.com>, <mhiramat@kernel.org>, <kishon@kernel.org>,
	<jirislaby@kernel.org>, <rongqianfeng@vivo.com>, <18255117159@163.com>,
	<shawn.lin@rock-chips.com>, <nicolas.frattaroli@collabora.com>,
	<linux.amoon@gmail.com>, <vidyas@nvidia.com>, <shuah@kernel.org>,
	<linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<imx@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-arm-kernel@axis.com>, <linux-rockchip@lists.infradead.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260313181858.GA1427542@bhelgaas>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <20260313181858.GA1427542@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.130.77.120]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D05:EE_|DU0PR10MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fdf3841-643a-4f1a-4692-08de83575482
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 qiJphQ11jsS5Or1DWD5TVOYxuUwA9G/w27HRBXq5sXheUkeFmm5fY5/xc1V0EFPD0N88ab3uHnp2FTPpmNB98fBJlEcq1M3oRT9+wQ0XzOvC1i4a6JhDbKHGRB2zGgfQx/lWL4K9tW1GfgCpX+de5Xl/vqFRtV79jGvHodauXDGhGkWCTYsjIziRyqKlwLvz0nh362iOM/fMGEDi2oWPEj5YRZO96j3pGWR2NI7afW1CjJr86AABLjSKd/pmbAce/SmP4GANGKmT2fsifLxK0TCls5CIMtRzRg1rWLTbCCDGwd9juqsfaO6ur6cu4vIrSIKONn+f5BL+X+c6NiscMuSmfTsnVzAzMW+VZxFApSkVqf9DOzqNDIFVgb1AZx9MXWqVBrzdrnst33HGDEBtDyq6vuLNA4aHan8uWBRKH8JwGhX1otvoAIR5NzIDCTot9X0D5ZxM1Ny9Fs/begTfqWEFVc9iBvYs468IO4v6SNNZ9vWA14jInsJEj5ybYEANJF/ENB7RXtfyBYiTmz8Q7pT6hdEIyDRjuoulU/y6grLSLXpcZU4rNPFj8YaHUj7D9w23tQGVrTk8cDw7moJcBRzuRUZYorM9Pk4MYjyWbRyT5S1RjD3czTXJnJIG1nqkMo2FWUDSoVXUVmJLuJR9/mSPoCQHl6KxfNsIiyH8/RNwGzeZnZhLhEX1MnPTX90Ryuj1QDJmdn1lYtMxBrfa+LzZmXIZpEEfxuXMu2pM3bF2Zh6/U8QyhwDbB85KAodtHSTQK0/kVmdFBew79Lb99Q==
X-Forefront-Antispam-Report:
 CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 O+y6cixgVYTv+K2i1qubjbolSYJOW9O4mVPhdpFbxKOM6jupnZH3nZ2YBPeWhnXtboEm09MwnnAgR9rYSDvXDgEpMrDyYmLsT2P/8qQEnK5gRCWZx4Pkp1PpfPYAZ6AZFk+IsLARMlZiqGee0aRTjxGVNXjY+pSdU+zxNy+fMhTzmsfLt6Mnu9vTOGlPkgwWiIYNdFNEX5X9cezpYCVQgjfw3gQuWljTyIbuimXBRiZn7BM1vyZaJj2yRrxmXkpdPUtRFBdRIj8+4WNJPAm7PWvL0Jw6WZhJF946RIF7dNs2XA4S2MyugiJm61auIjUfxc1fgmVIJQjtO4iNVGA4l29Rl9Cg+5bPFdGKH0lCa0FNKiT47iXafQqksV6uSU6lAxTpOucjrjFpAjacxzyCH9g5OEZqB9TkHjahh7g0/byrEZCpOP/IaOLyUVsQu+MG
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 12:27:03.5651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdf3841-643a-4f1a-4692-08de83575482
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7360



On 3/13/26 19:18, Bjorn Helgaas wrote:
> On Fri, Mar 13, 2026 at 04:59:26PM +0100, Christian Bruel wrote:
>> Hello,
>>
>> While testing after this series, I encountered regressions on the STM32MP2,
>> which I am unsure how to fix. The failures depend on the order in which the
>> tests are run.
> 
> c0f1506f6354 ("PCI: dwc: Advertise dynamic inbound mapping support")
> appeared in v7.0-rc1, so apparently we added a regression in v7.0?  Do
> we need to revert this?

With the rollback Koichiro proposed, the regression is now confined to 
the EPF bar subrange test, and possibly to platforms that do not have 
enough ATU entries (this I am not sure). Let's wait a bit to see if we 
can fix it.

Cheers

Christian

