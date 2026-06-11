Return-Path: <linuxppc-dev+bounces-22523-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E872FCD98C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 19:41:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbtKx720Fz3bvX;
	Fri, 12 Jun 2026 05:40:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781206853;
	cv=pass; b=Eqs7l3zAO7rvKBS5m38xbUmNxk4qpPwA/Dyma8WqCWYgIck8QJKN+oI9hcXbvkFmMaIH25jjIGW//9nNzVTVq9R4o/Fs3mwYefoeOL/8mjBI/bgW0YoD1/SKSw7YVbU10jrezhXGd1MkNIFu6mn9Hf4t057AFmqsJV4iwvQnE25NaIDYULOR11SLSaRHVRUt+VPyI4h540bZMPN/yzFDaOv4Pb9jC6O66WPn8yzwQXQUIVFp7AaxPUH6tcXVeKKz/uraVozVTMZQTxawg1e+LZl6tTN16J5YPNZIAdTS5gA72Q4ILLtjTJNrD11/JAJ4H3HAM0oI8/dN+LEOcLvGJA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781206853; c=relaxed/relaxed;
	bh=EkFh2p51eaT7BtmVAeVeFv4muTy2nOgSZm7ND8ukvhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gFYzaXppC5a5qGop2X+bg57kBMldd/q+7Tmc28DBMecjz3l47LBF/RJFI6RuhuSYGskvz/Xc1tSWHtcM3L9LfgdGnFibEYiKm/DdHfqLnI7u005Q8E7iSbDTP3qi39QsTxJCch3cQP6Lgrf8Rmyaq1ZOPLKFn+XdppYehfWAE7wPcIVhYeLNsS0exzsFi1pIilgAiY5f3qb9JV4WTp9uCodbbtDmHfQWnDGqiufEMHOpqojMJiCYOHSKs3qTUoQaL4rerybHbmrrE8hxTW3mY5+urx1Tveer2o047OQ576wKjMZPaYDQjbXyggak7kySr/4XPS/XtAYbKteCDYS27A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=f9X9ZV5+; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=f9X9ZV5+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbtKw35sYz3btR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 05:40:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LytQRqpnKeplq0arpA54efZziDj2vv/HkcuxicGcgbtZsjxgXoLEnlqUwu4Qqt7EB28A+i4c0XwBUd12ML1YG01jBCvSflBS5Kxn1BHEmqwo1qgqs/KF6PoMMpbmygpwPSi6wntNG+bZbRcpNb8pQqylhOrXjhvOmi2DSg1u9fSmqSbrS6hWE+nZnQNnYlBsDsQHVPZAIkQpcM0Bc171wplbx8JlMl5w5Xa1WsoNz7hYvaG1dq6ar2NtlsPlGOohSiW+PX+RtWsxFqV5d1wiIgXcEIfuYX7R0exomlqImuKK9VzgCF+NKQXK7OpczyrZEqzeHBVvBytVN0GjBN6O9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkFh2p51eaT7BtmVAeVeFv4muTy2nOgSZm7ND8ukvhw=;
 b=l/Hyq9gNGt/EhV/hvl+f+UK4usTkIJbFVoFtUX7fNKwyeZb67ameXT4WJzdJlh1+janykfl52oHGg7ISb4plRYN4SUx7gElbNQ9rECtRu5/H8vUnquu6eNkv6XS0vYl0Dwl8x+2vX40O7OteiekEfD7CVkXRWnuvoFO3Hqq54QtocYSiQRhOH4xAKk+VUME8VD0g4zJDWekemnUIi7bCZ7pBtrxc6o8FQnGJlbNkR/1nM8TfnJLmOT9vu1WTdDLGjXl9OrzGcw1+EU8a0FDOdNJcxWSDZS1AW8Vbv9aa3Bw/slMAcAHVvccKCkXUAe/l+petHj+GSY3dRtvkFntScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkFh2p51eaT7BtmVAeVeFv4muTy2nOgSZm7ND8ukvhw=;
 b=f9X9ZV5+6DwDWNaVR+vhnHPgAZb4jAYyp0Iqo1hT7fSJatxMuDglxd+ZnYmNWpM6Dy4c0AwO87qcZZ5OnwWe/3DeC1XE4ZFPwY3E/llhSnMn2pf5xC3CaUKtyqJQnbwIxNc6ZrKHTZasv3vDPUR9Kzt4CO8+z8QjkFelPV0uP5dKKUM25yPSAEBpKfjULdD8mtVqSYDIxqBZ8VykG9ET+VSa2TQzBdZUe+dCOBpqm3TAXiFPDh1TMFnx2IEJP3dmvOJt+W0Tu/So8EuMO0TzlOcbIaug6TrhcvFNX3d0WV+hNi00+JEwwo9raTJ+HbSR3kVd/muZ5up0gGy+Zm+26A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB11017.eurprd04.prod.outlook.com (2603:10a6:150:21c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 19:40:28 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 19:40:28 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v1 phy-next 6/8] dt-bindings: fsl: layerscape-dcfg: define DCFG_DCSR region
Date: Thu, 11 Jun 2026 22:39:38 +0300
Message-Id: <20260611193940.44416-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611193940.44416-1-vladimir.oltean@nxp.com>
References: <20260611193940.44416-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0113.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::10) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: b101c98c-8953-44d3-606e-08dec7f14a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|19092799006|366016|7416014|23010399003|1800799024|18002099003|6133799003|22082099003|11063799006|5023799004|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	lk8znkQ7uAIheSknZqAHYRFt1+f/wrS4Br9jqfLkv5uSza/QBlcV1eq3QCisTtZaCjlJT3Fl/6i6SyETaIOeQmKET/RWXu5UwHTCmiSKhGKpQPWd110kdKZmEPBdhbTt3ny5AMYOpX62Q3G66vq0QmWChWke/uYElBrkD6K4ExzatL3fVAYfjaJ6j82GWI/os74f8iVnZMvuiHWWGcJCNnLb8NAUft5wLDP8m/2ChxulJ3GROwTesXWFrRzdj89be/QBSayrMQq9z3mmKr03/h61U3eAByLsqf+Sb9Bk2PKNABgML5nuFQa7eG91xruBw1sEi/L7jlBND6mr3blmZaZpMZ1WIXqfvyh8YzJHDRbzUUcwDvmZ5FxeSf8bZeJgQljENWLgw+rShqrP7O5mpTC4Kr427dI/eS19MQy1DZ6e4QgzYVR+hrhQBDaBlV2iRj7Et5VMNPFhBfer3vME/ePrk1V+zC2Ltwyb9RSOnNH+gGlA+GtTNWNESvCxkhLnWgvWivF10yRr2x8P4rDxqlsnXWFCdJ2nkq4s1Yihq24AIUpk7WqpqZWGIun+nzElrzbgVBBJVIpy1J73/VzPYkaesuiR+5757JsI4KJ4XELkDolgHxn/XmTwyAWdh4UOyCaJnK9StdewDTbSXGPzG1eU3hrSMSj8CcL6MtQyb+vhLiJ+BxVsryhy/CwM4ttD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(19092799006)(366016)(7416014)(23010399003)(1800799024)(18002099003)(6133799003)(22082099003)(11063799006)(5023799004)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ikxcA/QQ0u07Sw4Dl5knfXhYKFov5Holj5PXtyL+lbO5COStKgDLV7GP+F2a?=
 =?us-ascii?Q?b0iZ0NMusJPq4HvNlduKPfE3op68+sg9LqTk/MOEwaae7RAtHMr2HuO7PgJU?=
 =?us-ascii?Q?vNVj+4GUJttG5pPEM7fb3mYvH0R2mDNt7srF1z25Gwgszzo70f/gSipqkiCD?=
 =?us-ascii?Q?xSxTKOfMHZpixEuct+CZD0pSlwZJIE3H4kcloDgNkvUadbJVaXCOQ8SkF2f/?=
 =?us-ascii?Q?tBwI/nxVFDJxJROr5mAVV2g5A5gRpoGmSDJXME5dNfHIG5yYD3L6XH2IyJYo?=
 =?us-ascii?Q?9uomOn1q/zAaY8du2uMvayzqpDf7bXN7Day9cH2oDASts+b4YdL8+iTv9F8V?=
 =?us-ascii?Q?ItdnfHNGArT8zGpX38AB2g7TwInnrRKTsUjBsT3WzNYaJeGPpQXFzhI0jekq?=
 =?us-ascii?Q?PQVVhoCBl2gSoHJknpDf2sP4X8QGk4ovnxVVxdmPyoa7Vn38xATFyf98c5MH?=
 =?us-ascii?Q?Pi+GM5bmUVCVN2P3bE6Gjc46sRGQQrn+phO7qDyShvH6ZAfQdsYmpMR+NPsQ?=
 =?us-ascii?Q?8/TflBS8JZg26WBj4CEj+ZmQyJBVWxotNMWNWUxIavzpdUcGYiqTYSc/8Wkt?=
 =?us-ascii?Q?wk9ilmf2kXus3XDxOD0FKPRYrtm5Sy1cToR6bZLJzvFD4NzgDhk1WEWNu74s?=
 =?us-ascii?Q?+603ACgZUQWrQhjd+gP0YtMCzJiEp3OCePoBfH2Qzd01XkiZLNB33LLflLSB?=
 =?us-ascii?Q?D11fegU1J8+vUCCZ6fbMaGnZGdBmxhMCaqiubDTBepbLnshSNxit9ufbvKKv?=
 =?us-ascii?Q?x+s9LGfiooQDfKTpcLp+aA1amZ82Rnw1yJS1+wILdz1gsVY2GGNHkS6vrzgO?=
 =?us-ascii?Q?iiDg73/aLUwcGcVfOswfFlE5Y3KA7Y6uW+fLDib7+ZY+YMdnrzamh2wSFOyp?=
 =?us-ascii?Q?xbUpcQG02c9pFaoF8DwbCTElefwFMGzzQvi18wZqg4U6T1fyNlwlzHkA6Otz?=
 =?us-ascii?Q?Ne5VjUwRRWvMyMJggjMxp21Dg1vCoAMO1GCwWpNPa/BXPk284JQhLCKlwfaT?=
 =?us-ascii?Q?qSKXA9PNrRk8j62tfkqU6VbgX/CK+RbVohFyYFwTZa63SkzpTCcMfTFiDhXW?=
 =?us-ascii?Q?Msb7RDq21kgDP5KjPY5iOXZkDRlq/72cqdv3giKwJcOiynoWghx0uav+Ppj0?=
 =?us-ascii?Q?rgeAJhoWg1R6A3XysuT2oIV65KTqSxCNfKo3FJOIwyG7y8VHNvPULiivtRYC?=
 =?us-ascii?Q?3rwq69bSM/YFyqzdBcRxSvZdw6yfXDF3WidCdMXWOk36h1i1eAjdx6EQIJcD?=
 =?us-ascii?Q?PMvMX374jHR1sBSUjJGM7SRGolcEf3kQhuQZ84CtUfIzpjkkUaLFIepwKLZy?=
 =?us-ascii?Q?LK0DiaD73g3Gci8uDi04AyEg9E/g0rpuecy03QAp3JwwdaAQqXULCKmCa4sK?=
 =?us-ascii?Q?WC+8kMfwAnMMWFpOrgrCFWg3wArOyl15EuxuOnqCiTYDCw0dhgmxc3B45Puy?=
 =?us-ascii?Q?nhNAG6LjTiDA0dfn4j4Lnl/V83EGnfkBNoRY/WMErsx8B53XCVXGJFrXWgF7?=
 =?us-ascii?Q?IpxpEXww9K2r0AJMU6odNpx7Ci0/KHwI5q6jJJ7o5wCrId9yDAMP7dlfDNT7?=
 =?us-ascii?Q?8uvsPyRGBVbnU4mjZPMG86bXdWspT86HK1N2PMHO/L0XnyOUU05wIrjUbTo7?=
 =?us-ascii?Q?yfNISvtpYyKDGX0Zn4AIfXpRSiRWto5RAABk+QT28jeOEzsG0w2kidDUSKxc?=
 =?us-ascii?Q?x8yIWRDc8HNHELxVUTJCMiK2zxr46UCCEKxUMEJlneYvizuHTCk2bp3/jU8k?=
 =?us-ascii?Q?xdvT3VpTYyYiBKRW8FY+12EPsStjjHY1dpry8q+8mTqg5ettDyi+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b101c98c-8953-44d3-606e-08dec7f14a2b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:40:28.0140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNIcArxVznbCVj9PAsFhOIngY5j7rlt0k1x7qHUEX2FQlI/Jfubl780iQnXjoyzAayd1zXHZBxACoh99BSNMdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017

In Layerscape (Arm) and QorIQ (PowerPC) devices, hardware peripherals
are accessed by the CPU through a portion of the SoC address space
called CCSR ("Configuration, Control, and Status Registers"). All
hardware IP blocks have their registers mapped here, and the Device
Configuration block makes no exception.

However, there exists a secondary range of the address space named DCSR
("Debug Control and Status Registers") which, like CCSR, also holds
registers of hardware IP blocks, except the DCSR contents is hidden in
all public reference manuals.

The intention of the CCSR/DCSR split, to the best of my knowledge, was
to place the functionality that is too low level for normal use, and
which is necessary only for debug, in a completely separate address
space which can be hidden.

A use case has appeared where networking SerDes lanes need to be
reconfigured at runtime for a different protocol (example: 10GBase-R to
SGMII), and the architecture of the SoCs does not normally permit that.
The Reset Configuration Word (RCW) is a data structure read by the SoC
preboot loader (PBL) which contains stuff like pinmuxing and SerDes
protocol mapping for each lane.

The RCW that the PBL has loaded is visible in the DCFG block's normal
status registers (from CCSR), as read only. Turns out, the RCW is also
mapped in the DCFG's shadow register map (in DCSR), in a write-only
form. Writing to the RCW registers from the DCFG's DCSR space to change
what the PBL has loaded is called "RCW override".

It has been validated that the RCW override procedure is necessary to
reconfigure the networking data path when a SerDes lane performs a major
protocol change. It changes some internal muxes which connect the PCS to
either the 10G MAC or to the 1G MAC.

Defining the DCSR area of the DCFG as a secondary 'reg' array element
allows operating systems to perform RCW overrides. Since it is
introduced late in the binding's lifetime, it is optional. It can be
identified by name, but also by index (first 'reg' is CCSR).

Note that while all SoCs should have a DCFG register block in DCSR, we
only need to expose it for the SoCs where the RCW override procedure is
known to be needed and has been validated.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
---
 .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml     | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
index 3fb0534ea597..fc14fd0bf84b 100644
--- a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
@@ -36,7 +36,20 @@ properties:
           - const: simple-mfd
 
   reg:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description:
+          Customer-visible DCFG register map from CCSR address space
+          (Configuration, Control and Status Registers)
+      - description:
+          Customer-hidden DCFG register map from DCSR address space
+          (Debug Control and Status Registers)
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: dcfg_ccsr
+      - const: dcfg_dcsr
 
   little-endian: true
   big-endian: true
-- 
2.34.1


