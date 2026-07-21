Return-Path: <linuxppc-dev+bounces-24625-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A00C4452B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 23:17:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4YDk2Z1yz2ysW;
	Wed, 22 Jul 2026 09:16:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784675814;
	cv=pass; b=aQ5RzKMgEhoNFmSsfsNmP/QhwbHUJSGNb0qXrijE8hfwcXkzWs7gldPP6HGkXQ7geiB+v0PUpsvupH9OTWmYpZ7TeBFZ0KUa85I33Zuyx2hXH5TkmUcJjtH/CTw3PEmu4JJWJLdCRvimHQ1pFu+56dytDW8infFcGz5cn5/9E5UcayENuNkYwdAbARiERwLMfeTw/FfdAubsndjphckYdO+hO715AucxI4ePOeG+zuSj5TcLD/pu+y1enjqCpmNx3ism1kt/SCLgPTp6Dz8mMwsVZP0ZAh0xYRwEOjFLCgZrfDNycDa3S7WD7lWWM/tgIxsbzs/9P5Fm3l2jWwf0ag==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784675814; c=relaxed/relaxed;
	bh=KKegREu3glqndmGvfEg0H7wqjsqOj8GsK70+YRgf2Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRAVMowBfwY5s5FkALgKPBkaeNBmhEXCa0xh3IrkKTDmZBFdLIVSdlbHtqwgn1UmBuRnzmH971wvgzt3WoPtXgurgMAh4iadmT+HUvX4fPoi80LyD35JkoVMju5x6AgXhryK1fOB7WO+j1a3gu7drELesG1EDxWowGhWFqoD1/Ge2iWYFbatjQObmTVDIb2ou5pCk11ATgmgjjZl1LGeNhXz89R6qc3sIo3QSugS7bqCxD6XEcrBDvzFEBv9woyrxAVsHvt9CnGgiZQ5QY+mMONKAlxANG5Hq7xoNpcvbhKLAscc+FlggaaPsg/O+1RH0SFQPVRfhm2SfCBEiAZy6A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=kZ9tAUQT; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=kZ9tAUQT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4YDj0ry3z2yqf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 09:16:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAAUEOu9UY63HQcF64U8/3v6j9rpP7QVDHLIWan4gwzaMTBtZiMXVg282oO53fKCPlGFdwI4rerSr1PKStylwaEBGH5i+WF76sdRQJF8lvl5Ww148MZqxrlamdCwkFvrd4mWaJ2UuqgFNW2sVPlVeIUYW537GZDLCNTUqvH1+Tf+r8ZXf5st+fUHRk2Oi5ZiykDVEHl8I0QoWEzeE0zHZv6S5fUMk/GIK06WO2duvP1UrWqX5zvY9KYeHcWaEVOc+ncF3Vn3dWMutBf5bnrEvxfPGeMsKv4zruceP+feO15jtGydRCPQmdxQOuc+/G4li4lmzStp7Dn/REotzzqQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKegREu3glqndmGvfEg0H7wqjsqOj8GsK70+YRgf2Us=;
 b=NMP3wyVZzVcOHiTbQhIdg36u7BeKbPg7jSpPUIIp97/PS9D9TfI8ExEDvXxbwmupLM5CfnNYlDw6zYBrnNqUu5WCKAd/xlCln0cfhastwBwFizb/WeVuYgy2PgBo00XT5lzIcRYgXW/R0QiI0/bunIUYR3q3tE5KZcYj6UOle8WXmTYiOGuWV2B2TjA0ukXVT/ikb2x6sD1TJ/FIs4on9JT17jyPw7MmJXjvMlW2eNET5XvwYy7ysmbC+wUbVNevSeoojr7m6KGoXzdj+qsC9CeeER+JiRnid5Dcr+e4OW0TLLYRk4EIA8bnDnFriv7shBskS3Y0nTo8wLF6jhqQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKegREu3glqndmGvfEg0H7wqjsqOj8GsK70+YRgf2Us=;
 b=kZ9tAUQTrYFfBXF+gzyL5FKjdxTOx5mWDvefXxiFnQ66tlecafprYX+9H0P4hazxV52WbDpwRWihktWd5pz3L3myRRMbDiwkaAktT81g0/vvAAsIdhbB5YE8uE9GKGNHdkVoMEpg5nTiOuOBvZyBQvCGz5ys9KBPuwVpeaZ71QZQUISxd2tpL9n+wnvlusQ77ls+MGC4dzUl7LxUXK6GcoES4wjjVwL/tmSKeH1r0yq79GnhjgMzKl74CbU6KyYiyjY+A/dACTeFgHd1MAAihW/ZMXCFzjFRuw5VdsBaVF57q1kHhdS14/dSCpIx2wom1szFcj3JrxRwod2wD36mGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB11817.eurprd04.prod.outlook.com (2603:10a6:800:2ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 23:16:25 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 23:16:25 +0000
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
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 phy-next 7/9] dt-bindings: fsl: layerscape-dcfg: define DCFG_DCSR region
Date: Wed, 22 Jul 2026 02:16:01 +0300
Message-Id: <20260721231603.67865-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721231603.67865-1-vladimir.oltean@nxp.com>
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::15) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB11817:EE_
X-MS-Office365-Filtering-Correlation-Id: effcd2bf-ba0d-466f-59eb-08dee77e1600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|6133799003|5023799004|11063799006|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ltJVMCj8eMthBQu2qHjj/CIFz7h+8njEyibubc8t5TSBVAUlSc4uAHW0WtydDGQRNg/D/d6JaSvaOrmtDkP2NxqXwpKcp32W/eHGSqIap6KEt1hD3cofvi4VN/VsYVzSDe5ceuGJNkddg7oFRo8bzFuprUNs4UNZuYF+ONQy6BGYV+ozqnJttwhmrWzKTZjb5CV+RS7T2fWNYE3C4tlOdoe7n73S70scYgjQMYGwWwTTauowrfgBNSz/ngRUVERyMkA7yC2DKVQKth6FlaSJUaI2qBL8TBS0MN+YkDCDMGzGuGv4Bhh5PKCWa5V3vAAWBZTagJ8/06KM/bvNe/QTX+pLdUNqMgOFeaVx/vMqy1eVwpYuZpvEdSZH6wKyuKNIKipT8TXSHrOjmzqrtCnUwPLIPZF+dRZXbvB85pkFsb2+E/Z2pniHJm/k2yPdTnoc0wLV/nEhSkh8GZ5bWgVXxv6RfpUNzHaV1FBAggVhGRO+7vRlaQFLdaWZH4GEb7R3L0KA7B/uI93xQ4oKcYXzxMfvaG9OGZ/6pVto6KtOc3IgIuxtTMsDYmNi3KW/u4M2LTfYAjgKWfVNciFUnnRB9RYE6OWqjwNtIwU8e+OCGPFeNekA4Vu1qHe92Q0sOk/PsiSLc4aJCNwwLH3AFpFDeioZsLiZr/E0wE/DWaImUVM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(6133799003)(5023799004)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z5gORMieo6qS0M3aAqctk9dVSZmur+TGI5Tk/Y8WnsFZYGCrpmivJFVDHI5z?=
 =?us-ascii?Q?Cmq8g0/cnClmDmpJLSdhUDpUUrQ/+0YJjbq0Y0xcRKpVZFbAvUC7Zx6qgiwr?=
 =?us-ascii?Q?DNtSKJC0kAWOc8eitmbHoWBYs7GHTebGp+MxLPixiRV0y8peiDsdQNbVeEFt?=
 =?us-ascii?Q?BdA1XiA5KuxNMsgwULLkUrSMJW6hRdj/dXOpo6509kkdQpc0PWxqIlmXDFRm?=
 =?us-ascii?Q?yK9rocjwsv0xG5ohYtRSnjzwuSU08wt6tPLrnH+crAAZZYudCBz+XqIG6qE+?=
 =?us-ascii?Q?FJ/PHoAdwwmgWo1c98DyHsgHCGrizIUOjDGomkPJOaygvQfk27cQDpVacXrt?=
 =?us-ascii?Q?FKy/dTCyuprQztkaUVxpbqgIy0uEXOPX4kOQv18AqYj0ZtxzrHvgw5+T0LYu?=
 =?us-ascii?Q?Lr6OHjPcB+lAgv9tDUE2Egar6hT+C3rHXdVPgJoJqjQVRqWH0aOxn/ru2E0b?=
 =?us-ascii?Q?xnYlVOpYEu4FwnGuKhBPluRr5Fy2QkTmoxHeSdXNHkVbInCgXHp43vCXfFKp?=
 =?us-ascii?Q?A5IFCSpnYMYlDp4clDxWiC91A+/LfinV7nBKSzohnJDEGfeZlzI2kncd5fId?=
 =?us-ascii?Q?FZsNrmAbRnfI9ArI0XYgJPIiP3l+CpDrSQ8ZjLuYFToO1GxksXjqWQ1c0ti+?=
 =?us-ascii?Q?TGosBLTa08xq9V//QkGyx0cq09W1ia9E4b6jzN4GXb8zpAq81hCkOfSYSsIJ?=
 =?us-ascii?Q?qnkzjfbv5EH7XH97+f0HzdFyhZaTyOhFOnnYZ4ebNYwIxQLvNVNUu1q5PGZg?=
 =?us-ascii?Q?L2evboYoMnzGWR40oIsyqes//aKEmEeHtUBjtHUGcOKTqxAYpsVAGVwSRKhi?=
 =?us-ascii?Q?KAwu+i8w16Xv8N8MEaU76iu+mRf9OJzbWr0QrGAccTXXnR9ZE+/uXDWciKrw?=
 =?us-ascii?Q?IOxvHy4h3Tk4fFla0rjK8vDLmZpBoIbCPWMR5KNdAJmf/BE1KTJoydiP6za/?=
 =?us-ascii?Q?Wu53bMowVoDo0nZH6Lm7fPJd++wSxT9rulMWzFYHQZK31VxP5EdhKo7GLZtC?=
 =?us-ascii?Q?JLp4uyOEq6dYMUQf9BH1QyXP9P8rvKq8j1NBxupXySefvt3p+gKymbUdX98p?=
 =?us-ascii?Q?eYqfaNGiQ0i4SFJ9Uwcu9RTT9j2pE4Nlx3QJdGNxgJq2nOrYPnku1v+5X4UM?=
 =?us-ascii?Q?ek0FodsOO6+3qZOpMmaVuE27ViCYRI+y8eawQJ5TfElM5ibWyX6QLU8FhdKK?=
 =?us-ascii?Q?Vm3Bj+qT2JPDi1cq/CtWpBUAAe9tf9Eq25hyFMGIQvI1kDBwlTzl2joLzX8h?=
 =?us-ascii?Q?S2t7VDakI0sPL3Gkjw4oVi15S5vbcR9MkqT2AA5NK+nIelLda7xpJC69O4d4?=
 =?us-ascii?Q?FgI2QNP9GBVyFRUaFp+DkFCqY4a2UNWEELZWWDJB/yEdPsmgtctzV/u0/ByU?=
 =?us-ascii?Q?wvnGt4Hwa8CtD1nTEIBs9GY1LdHxW4XScOY7H/cnZkIJljGSfkn20yxD98zv?=
 =?us-ascii?Q?6SSlkKAV+7/jvN1glWyRUluGz1HycN9isRBlxz/sPv7sRCk2k5qK9gQhWiYW?=
 =?us-ascii?Q?RQHjwWyq30Di5G2Pmh3ZoPN/9cnwyEgQeZQuSz1gsmBL6kb2mj6ru77OLe7D?=
 =?us-ascii?Q?SZJQ2tzQmZkoTKev8yB+bo7xGmrWOsVbSQ0QlpCesqY0ki3ofbERNNV2laOK?=
 =?us-ascii?Q?kWCkJhJrkA+rWBBgmTSp0QtMSQYnFDKI2R2lxTdq2gOvTU0Y+H8HegBaVd0U?=
 =?us-ascii?Q?ynXvhPb2AdQHABbookoJ07i76Fu7osKuhcr/pIupYo7z5ETrCQkD6mzJruyZ?=
 =?us-ascii?Q?1UsJnUVXlA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effcd2bf-ba0d-466f-59eb-08dee77e1600
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 23:16:25.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QL+DJ62d2uV/qNmuaKFr4jdxE9c7BOmuGdCUwGwHGDXJFdigSHgTKPe9wGd3dJ0zOjwDcNhcR3NWm4fs3un/gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11817

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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>

v2->v4: none
v1->v2:
- add Conor's review tag
- update email addresses of DT maintainers
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


