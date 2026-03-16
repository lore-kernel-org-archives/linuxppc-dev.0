Return-Path: <linuxppc-dev+bounces-18239-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DE0F506C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 12:41:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZF8J5hKpz2xpn;
	Mon, 16 Mar 2026 23:41:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773664896;
	cv=pass; b=mKawJcLAEdBDiPeI3Y66YStz9D1EAkWkCdIVu6JtkUmpaiZUwudasX0Fn1a1UIyf1GrKGE9/AFwLnXYNepupvpjIuKSHANqb9OMysUghx45IDocJFUQ/q5ZRDuJvvRmFHzpt9QnQ1Yb/heJJ39logH0p3COYsajxNgiu16fdCSb8qFghfYu5qAIWR+9GeYsG1bbO/tb1L9XDk0Ljri4tzo4TkzSXg0d9M1PYwDAxCu0mXfoYuRi8rZZROeIAkeue4S99JF05GrIvl027UFvKQatB+X+X4BOPHKSfE+68j05aDhWBqmLnuru+ZxImSpZ+P0dKTxrdcCeNNDW/lXdm8Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773664896; c=relaxed/relaxed;
	bh=vFeTKtO1ufI5gH/H4m5HJwsDUC2IS5k935VF2z9Nx1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l3sLlBF6lszryMZY8EZ+BrXX8/zOubqXHPSeIYIlX4Za7JAGLswK7J9C0M0alUGAoqFIAoncWSqlbqzLBx3mPGdrRuQKhtQswubD5ZqFGDWobronUPxQtQcg4L2Dgy0e0xi0uqNElkNm6jhIaRUlZoYOXGXNksYmM5gq2R6R9GfJWjKGuhxAxfSrMTpSy4ijdYAXaKjgmW+7rlXYMGVFZs5L9euHs7XA7dDGVvJsutFwG9lVuhqaL7bhsEgQ7t1F5j79Y1sm4KFZtp20eOaJIdbh1teS+QRYLUvxJNJx2M80L2MU3bzHyevHMGZPKwjsjyOU4L1RRV93CyA7nCvvMg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=liO/lMAS; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=christian.bruel@foss.st.com; receiver=lists.ozlabs.org) smtp.mailfrom=foss.st.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=liO/lMAS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=foss.st.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=christian.bruel@foss.st.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZF8H5nsgz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 23:41:35 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plr7mGkKohhlBk72S6qefmuQMGhdGq5t2UDSZIkfwj6yQRpxACWuKG6ZPy2O99It1Vy5NhLYL9hpkpac8nCnAKxeBSfKISdMGz5Ffu+FP624iAtCYtWfkJOAn72jpJmmTFu25VgwBkYeyEVjzTPYdCuRGkKSbQ5IYcqXM7W8tNCJpgZm9R7NgS2fvsN8cjqOT1vWhzBuHSWILZL29dy8TEjrarPVzYz0qCi17xGF7UpP3YdAe4lhzixk5aByglqnJDP5MWo1a+H/Y3yuLS/yvQJMmb9W4WvJJDgVNF6zu7AUJDL8bZbKMesPM2KtYNCfmwwjY++f3W/TEa5VJHjRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFeTKtO1ufI5gH/H4m5HJwsDUC2IS5k935VF2z9Nx1c=;
 b=Nan0sTpyKOJkK7EooSRfsBToB/vCA36ze6ixdDqy0B7e/BwxKyNZXIu23pdQoQiDZNWxtbkmdMa+KsMhhG1rrfgNNUeLtJSisJDmc1BpBbRc2FB7SOvpJlt/ArnyKky9qB1w82gw7S8/7plik6jwCXCQplQgcq9zmy5+V9RmBe2rjvA9msHQ+H6opLOyapA/unYRZTkg+6Pg6KjwldBCgOqCqqFCDbIpnxmduDv4Jx5ccZ/uHpU8QfHsfi89sHyhUvNOQMGB+bKcVKUuIPuLq79z45+G16OMQR4ON0DxsC+ECr7EY09YXj/ZNQcmlGpEtuPT1cfGInkGGLTTiC63kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=valinux.co.jp smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFeTKtO1ufI5gH/H4m5HJwsDUC2IS5k935VF2z9Nx1c=;
 b=liO/lMASiQtS7DjhTtyfORdBJkSHW3/jVOr6IEyHK7yBjzm5ORKGeKI/ZMi80jY6NeH6iGh6LwdhmAD9fiQREkWfU+PfeCOSfw2uHRxqSXUGbHql6BueymhKo3DwSxtWsf9vokCAX7p0GlcSkrLfx8QeDOBlVYbabrS3NjkmjBZ2HeJ+C218WZr4hCOzcy2zdNMUz1NZV9iQiS87hhI7M0HnlikEDARE+ust61G4JoF+gFnJ71xp4c0PlAeANogTF4PojjJjNNgQzRBU9v3g8+v6xN3J/Uql+l/yz6jjm2k0YeDxCrpe9ltTzWQDbFexa6EWIQIkdRBYKZAcAXK7YQ==
Received: from DU6P191CA0049.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::8) by
 GVXPR10MB9428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 12:41:07 +0000
Received: from DB1PEPF00039230.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::5b) by DU6P191CA0049.outlook.office365.com
 (2603:10a6:10:53e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 12:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF00039230.mail.protection.outlook.com (10.167.8.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 16 Mar 2026 12:41:06 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 16 Mar
 2026 13:43:24 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 16 Mar
 2026 13:41:04 +0100
Message-ID: <5e485218-becf-499b-8a07-d25358504807@foss.st.com>
Date: Mon, 16 Mar 2026 13:41:03 +0100
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
To: Koichiro Den <den@valinux.co.jp>
CC: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
	<cassel@kernel.org>, <Frank.Li@nxp.com>, <vigneshr@ti.com>,
	<s-vadapalli@ti.com>, <hongxing.zhu@nxp.com>, <l.stach@pengutronix.de>,
	<shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <minghuan.Lian@nxp.com>, <mingkai.hu@nxp.com>,
	<roy.zang@nxp.com>, <jesper.nilsson@axis.com>, <heiko@sntech.de>,
	<srikanth.thokala@intel.com>, <marek.vasut+renesas@gmail.com>,
	<yoshihiro.shimoda.uh@renesas.com>, <geert+renesas@glider.be>,
	<magnus.damm@gmail.com>, <mcoquelin.stm32@gmail.com>,
	<alexandre.torgue@foss.st.com>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hayashi.kunihiko@socionext.com>,
	<mhiramat@kernel.org>, <kishon@kernel.org>, <jirislaby@kernel.org>,
	<rongqianfeng@vivo.com>, <18255117159@163.com>, <shawn.lin@rock-chips.com>,
	<nicolas.frattaroli@collabora.com>, <linux.amoon@gmail.com>,
	<vidyas@nvidia.com>, <shuah@kernel.org>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@axis.com>,
	<linux-rockchip@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260124145012.2794108-1-den@valinux.co.jp>
 <20260124145012.2794108-4-den@valinux.co.jp>
 <b2b03ebe-9482-4a13-b22f-7b44da096eed@foss.st.com>
 <tkfhaovpmaoodo35attvmbnpukcqgmwyrxmfgiwjy2dga65cgl@hmj4mx2n44ki>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <tkfhaovpmaoodo35attvmbnpukcqgmwyrxmfgiwjy2dga65cgl@hmj4mx2n44ki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.130.77.120]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039230:EE_|GVXPR10MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: 40765379-7348-4900-8e15-08de83594b29
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 QqAcbgBlXt6JRa8dGSi2Cxdiu6q3lBdEv0/nJ4sp9M7FHeF5cUmCuVrOSmEqjvwn+CVZhG8IOpeBxpnovf+xL5mxjamgTPkJ5kojPmXyjFeHILkoC2neCROylq7YiZkh/NbpBOYzaM+6qgPBGo4VhZ01lg6n3qiGKZ7umw0q8isEoDRa2LiWTTOBrag79phrLurCgkzkBC7xYvjDxRhYm71nLFUYx0M8On+AD4Ylgxavqvs1jG5OXfBeR/phXf040DsGZmWZU0t2V3SVKU6UFSUFMAGN+FmsnPDGgOqNMx+eN+Yq/P+qh5nbo6PhwzknMeTCxs59ceyZ+NZdFDbw0ZMMxl6/X0SVWb40uIwGG/QtthmCbR7bjPR8U7pJblPAL7MUgU75I4MLKixSqcWhtXZjlPse4R3jxryUWlEwkUqFhRWeuTb4mx0979CkgICSdnMlwvAznj0RC5qB07dm5Kjnkjs7XHkXqhb7MUWzpU1S9sISSHoVDoyrzppWxtPuDOlNqQ6WITFQ6y76px51fgOHsML8Ec7g5L242zYhFcqoLPraRV61EAXNIwd12oixkjBBJbUKTe36VYVJQqFxsZxt9XgQtSeb84gzpy+uXlH58TF5mg4TsjKPeiE231PR3gwB/XWxxyD7a9XLVDbyi8ty4qQnGf8yMp7EO6w8SyBcnZNSQxw+2T3WsboMOlN7aZyiRv4CEgKuh/Cnud2dyPSsonBSvlrK10whyY1gysMSfRia2EZsg5l34n/dHjRk9/DpBYbZ/Ffoktl4YH8MYA==
X-Forefront-Antispam-Report:
 CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 myyTgjPCpS6E9Wq7PZExwdOA/nLUpsH32pzqkeb2Ityek2ZD6/RtoZRmKcPOGJ2MlrIiC5cbVWH0LqTa+0vFAof+AtA9zgZoO9euVtBY4nPjmO1OF7gIuTGFZ/+RkMtqWKmgZAXp2nV7AVp3GWNNMklMpIGXYL8LEI9ZMPi9dIUocHij+5OWLFvjf7VvxukYzN6XdJa0BsdT75KXAhi6kYVCIyiZW8dxYNTZssRpJvQDDEO9MYadsjXe3Cb7odvx9M/+jplwnSC7Fask53tqL899njMgiQoVS2VwkzDpuBzA50MkQ8Ik8Dhw+yKKzO0IxsQ974zjfJhGWrRsRqq6vvzlUF7xRGMGgw3+sL2D46VhhBPH2iulbB9t6OXGOlmrE/D4GMPpFJvUpmxYAHaGFx3vTrvxb9DkIIJTXHZsL6B9C2gWcutDnBzLyPByHpY/
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 12:41:06.8725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40765379-7348-4900-8e15-08de83594b29
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9428

Hi Koichiro,

> 
> If I understood the problem correctly, would something like the patch below
> address it? My expectation is that the subrange mapping test would then fail
> consistently on platforms that do not have enough free IB iATU regions.
> 

Thank you for your patch. Yes, now the bar subrange tests fail 
consistently, so that is enough to say this is not a regression.

However, I think there was a clear BAR missing somewhere before running 
the tests in the EPF driver, as the BARs could be reallocated during the 
other tests. This is not due to the subrange tests, but the EPF test 
driver supposes a 1:1 BAR/ATU mapping. Now this assumption is broken. 
I'm wondering if this could be improved to make the subrange tests pass 
on all platforms

Cheers

Christian








