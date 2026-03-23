Return-Path: <linuxppc-dev+bounces-18569-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4996D58CDF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 06:06:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffN3K1XPlz2ySb;
	Mon, 23 Mar 2026 17:06:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774245997;
	cv=pass; b=XacOlm0DSrtTcoQqhZjIYbwmbMlatrcHgWe+XNwE9JBZFPNPpGBKf7wxd6gqNFxVKEybLnxFDfgeXo43EIwsUbS98oKUqbb9latnYGGVXSadTeVONjf0eTrUlM7naZZhIEs/Z9vsqOhwPN8o6PZsHOASMQVDiHJCNeSVZVMcyTuO+rLTQUznuHBeDZ4yvCsVsKwMx6udnAKU+j0nvVCp1wkxyA2B0GcqQM5Qg1ZdQYpVAS4mX8kRpAObSURr362T894RPEpjMncjBix55zlPJYgoG/1ZEo2zdaZ9MEMCj5//MZzkpoGaC5ql0P6G+L7i/qdRgG7xCaLxqr6lZxoSSA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774245997; c=relaxed/relaxed;
	bh=+fmi5UuSl5NkRjaxWvupDcK+tsZdlaJHTTY1oHy89dw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=I3/88goq+qzZc4U/2dB4geGbNlnVQZlTlhALVeoK4YnFsG8micKYNlWVRLXQ4hdZ/tLIQE5Mp+0zs03aMIVfQ3XS1q3cuMusZxh9e3LpNQsjTI1dCpL5Sgk/ZjAs7CdDES8hZ+HrLnxhbMldtDO9DArnW+/4UhITDtRUSsHdDUfFix29ndJ0DM7qKIRVkOiglPR/845tD9HmPSJfjBggSEYaOCbxCYAg7Y6ShooCAFjHdVx3YZ4U0CjH8b4go897mKZtOJBxlh7SQOxBuPcIycyLxZ3ZwIX8dV0Ix4tru9t4GP3k0HD6j40zeKKl3zez0cvqqfyk9PctztmZ8SewFw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HpCBxP5T; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HpCBxP5T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffN3H00mFz2xd6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 17:06:34 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oggJnnODP7Mc2j2NnEMadeijak7U12J0mTMoLO26gKq+Ug3dfZmqa4VWUloqP3T0ELeE7Voj40Z0bKBCMJkD21HTKaNuHa7uJ+qEqMu84U5MHylaLqGjnYH1nma7QQMxT1Gq/dm7V4KF2Cl7gQiJ1hEZB9PeUYyNeUPzdVcP7JNrDooETfwy2NYZpfVSB3NUSc5NtsleJDDDtgj6H1GZuUCbVmstG6P8awPPdFcKAfMnLNU+CML3jMrEUWU2KMOAmQ/MExg605KEjkO0qJh/3cXrV6PZtWVj/23QdV47ZElQoRroib59gkj+xXd4Ni77QIaRgrKzIq22j5t+xObKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fmi5UuSl5NkRjaxWvupDcK+tsZdlaJHTTY1oHy89dw=;
 b=WSiVMN+hswPDckuBUIpQcDmPvXw4nfoTb+hZZccvbgx13kCJrCu+mtoUOuW356nVpUr4EDkQ1bHC5K4EqouB2DB9nFw2shVpRsJusxYqpBijJQWgoMouKhXXezMNxUrWRhvpciU9fir9ZRaGOfO8mtR775emabaxooss96bxdwjVypLdqrHZqI73gSTrTLoO2fzDePdah2ZhYcw9iINrwa/URE+O5KbO/GVUD/cKz3nah5WIc4/5I3UbFJoat48ffWEmKsAsE9T2+QTq+McWvCMrDKeCnSR++Cz/cZpqlhKBgKoOjZlhqfrH01maDtI0KN06uLiV+EkRgMAk95aTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fmi5UuSl5NkRjaxWvupDcK+tsZdlaJHTTY1oHy89dw=;
 b=HpCBxP5T3LbAgDYpNJwkHNu+g8KqHzoeU+d7a5KPaXFQZFRu0bJ+6Ie6JRKSwX+9lWNKcEBCAQSpjb+9DVGzF31S5vP6zlMcRGmDpxteRex/SWWt3IQxInmenT7nFKnH7Uav3qGDMMxYV5WVcA2e4YU6jwLskPDu2xXsyGkk3AWt5zybFMcL27E18WZ7hut5OdmKybaf08o6WDDpDBS3DOvaoWqOSAaQPW1lcRToTiu5mVV8v796nLAb8EVhvy53ENeS73MkChMD6DzZQT0g1vit5iY/1JNiCcfs16jqN95FJS33VAjh3SSyIcuioWjudz466b/fjQcijcQo4dbM1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 06:05:35 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 06:05:59 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 00/14] Add preliminary NETC switch support for i.MX94
Date: Mon, 23 Mar 2026 14:07:38 +0800
Message-Id: <20260323060752.1157031-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|PAXPR04MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eab5480-d346-440e-bef5-08de88a240b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|921020|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QBtf2UB3VW3nZ4c5xx5M9PWLIPKvAPRPHbYEHGz4MptZvPL2Vx5Ilus+nYo8chjAP0mXhw7fPJ+euyX0z1SfPcT8TAFVymZ2/eS5wIRn0OjH20eybERg3SLRTNTH1NcW0t3rm5xmGoX9aORyQJLGCqZIbvzJ6+K5iAOY8cWaCiFPGp9VNXoThze87qV6EFyzcRZsVYiBLvcKaYlu6U24nkV4sDtHzGFnYHqs5F9YWspcB5LabqDWmivMTncqbHjMdytSjpt+vUR/AWS5kL0QVuyiaplgk7g9OhgrjTxf0wezaJLGkwLqnMXA2R21zp58NrLSK2+J06MD1ZysBLLOV6A4rZAOdpnvvr7BkTjFuU2f/z5wObQUWvHIYi+7Pl5Fk+uaihoMlJKAN1QNA9FIn1sLy8nqD5XZ9fE4O3pvgJBOViI9dfV+Z8Lxmdr6pDBJxG1MqXb9eAih0hQxR9MnoX3lgK1/8WVBDqswu7ZQHng36q8nZgoHEYH7JW3mvDe/BWfYilyUFpZGkpEhDnoV2BBSbQamUCeacS1RqEhpBUNae94ZEWtJPySNWZ2kRQw+ttTxTpp0YD1a4+I5FPL4pYFBb+d6MHffms+Dmh+I2w8xvTkDIn2bgr0AAv7XJkRx5NP6w+UCVy2JFC2F4RGOxnCTBzbAmAGSCfrq08hJ4GGhdPD0NYR2AXCt/JJapxwG3PLb1/y8sSzTwerCCWdBj0VMTRdhqHQK+3wYYO+W6k/Di3L5QGSOZEGEwMpwIl1+JXT6onXUm/KvWf9ilAGycQzY7hRrDfI6V9YEC3iEpxtdFaD5hRJKqMd6TQ/Gsf1l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hgxhRrwzE/Uc0MM35XJP+SuoP0MxZpC4Jlp5pjf5veqfFu3o9R7f2zbA+s94?=
 =?us-ascii?Q?CwmSt198uXcK6BUvqGK/AWTnaf26iFgd2JAUY38UBs+ECASoTURCJ9uXG7up?=
 =?us-ascii?Q?jP24SI/M9AVwrzd16n+pNlchg/TegUJ7ZKnr5O2fNX/jDp4iuic4xkR+NyO7?=
 =?us-ascii?Q?/TxqnKWP09lYrsZj2G4hjXGY8YGhLr/Fhz7KSWa6Hf1UVnNJCxAZY+XtoKMQ?=
 =?us-ascii?Q?HAmi/5bZhLw4fwtmRaHi7Fw6pgY2he80YT9zF0fPIEdOOqdcWVVGdFQrCU0T?=
 =?us-ascii?Q?Le1IPTVL29lrdcXM25kDoYkaKxuPOJEPXN5HXIsXxbd7SIOAWCF86GHwXgdA?=
 =?us-ascii?Q?JVqIWmEC6D4QCUFvO7J9HKqfOIeRcW8MNvMW6+Zefxn01PlxcF3RcjwaIKZw?=
 =?us-ascii?Q?Jn9rCwH7lR27ZOpPqrnxsuSHvxwC+wDnPXNb2jMvX+OcJ9XDFjOrJc86OKRR?=
 =?us-ascii?Q?dSCSCMR2Nu3s6e6e2Lq7qf0hyXtwkhTtkqTkZbs/VKZesA6YXj9CnigZj8GA?=
 =?us-ascii?Q?VGvF+SEs5l3q+oA2JFBhmwgKkZX3LjpgMj3Q5IO7m2VOOv0gI3FHV9g2ZN85?=
 =?us-ascii?Q?gkW5Yg4bTcOo/GDI5RMLepjEN83gerSrJgtXowJZiUSf1xTmwgYKRViNWwsA?=
 =?us-ascii?Q?r4W2xm05mvQ89Lv2qfp5DRR6tnJ8L0rHfK1CRIW+4llPQY5f3QaacmGiQbBY?=
 =?us-ascii?Q?bVHsVcrfKxcNXOs1cJIKa1kDUgs3vFgQr+6Ur4LV4IoVOcn2U41y5HpgLqmv?=
 =?us-ascii?Q?lkcclTgkhTrsz5v0JrtkmvrEVPsd9kPqj897zQfme3UqCYbtkw0L6o5e+WuR?=
 =?us-ascii?Q?inVsyJf4qbS6eetIdUpilQ2rWma5UOSkUXsJpZ9CSfCF3oYBDBIwaWIsTumE?=
 =?us-ascii?Q?h2vOBDpzrKwCHyMkjAXOibwXP0JD6+8qPLP5AfdP5FRrcSl00eBivsv0QOQt?=
 =?us-ascii?Q?3OuLRhu33kqK9QBUOHThnfio/OsJbxONlCNvRqrgz8Dehezk4Ph3fRF4z+Ac?=
 =?us-ascii?Q?xJGxv1kKdiWLAETjGTJIp/0vEPlWNSBPF6ramy+S4/+S4+U//4O+rwXs2DiR?=
 =?us-ascii?Q?G7TlSas9ZxH8Q558B7Pfyetm3AVO6Vo3KmAxemdVcc0a9glhD81VTRsFERTO?=
 =?us-ascii?Q?xqP7Y9ywIiQy3QH4kIWRAObX4rMZ41SPTQWkK59qqE9XnTBI6988NBhkzC/j?=
 =?us-ascii?Q?R+TJsUwd7ogBqxTGPHWdGQhcNCbO6QzzYcGWIPD6usM55msOLDYZqfEEShAn?=
 =?us-ascii?Q?5WVkWk0io49RQgSwffpWhMEjU1klKIEKP57OIny8O3JeqSMM7q29IbUheRzc?=
 =?us-ascii?Q?oVsr7leSLltRQGhPzCSU9WTG3L7rjQ2n/HrvMc3vz9xZJ2smBICkFfqokyFD?=
 =?us-ascii?Q?CyeZYLtHU4c+1n+OhVhcmZW5BAKYotAdLVKHlboQZKRt9+1lVjQeNhj46tFz?=
 =?us-ascii?Q?pIUH4xXEeeiGezmloTJiI2+m3AWoNkgvgfpXGAs0kN0QgMQhwGNsE/0X3NuL?=
 =?us-ascii?Q?rnt+x+O+cy+DIeIumErrt124+eSgcrFgOJ0FWzEoHCsCk3LTWE/G4E6A6w+i?=
 =?us-ascii?Q?QzP/HydwLnz7XZQvQeoRL1mj+RK6+a4qIXO20QA56508nOci0mRITXiG08um?=
 =?us-ascii?Q?0Q6HvUFUounKuxfNf8b4sJy6nCcy7HWhuNxB6uH3Lk91e1S5VEPr9tDWzVW7?=
 =?us-ascii?Q?IcJHLZMnQALWiHUrTz9nAgEKVVAxduV+cYvz5hx44zK2ncHT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eab5480-d346-440e-bef5-08de88a240b8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:05:59.6351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDQnVR/b1jR30fg17LcC2uzqqzQUs62ZWuCnhJyzn57Hnf2JxYXw16xONuHOaidIH94BPXhpRk4r2uRhMlVJSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911

i.MX94 NETC (v4.3) integrates 802.1Q Ethernet switch functionality, the
switch provides advanced QoS with 8 traffic classes and a full range of
TSN standards capabilities. It has 3 user ports and 1 CPU port, and the
CPU port is connected to an internal ENETC through the pseduo link, so
instead of a back-to-back MAC, the lightweight "pseudo MAC" is used at
both ends of the pseudo link to transfer Ethernet frames. The pseudo
link provides a zero-copy interface (no serialization delay) and lower
power (less logic and memory).

Like most Ethernet switches, the NETC switch also supports a proprietary
switch tag, is used to carry in-band metadata information about frames.
This in-band metadata information can include the source port from which
the frame was received, what was the reason why this frame got forwarded
to the entity, and for the entity to indicate the precise destination
port of a frame. The NETC switch tag is added to frames after the source
MAC address. There are three types of switch tags, and each type has 1
to 4 subtypes, more details are as follows.

Forward switch tag (Type = 0): Represents forwarded frames.
  - SubType = 0 - Normal frame processing.

To_Port switch tag (Type = 1): Represents frames that are to be sent to
a specific switch port.
  - SubType = 0. No request to perform timestamping.
  - SubType = 1. Request to perform one-step timestamping.
  - SubType = 2. Request to perform two-step timestamping.
  - SubType = 3. Request to perform both one-step timestamping and
    two-step timestamping.

To_Host switch tag (Type = 2): Represents frames redirected or copied to
the switch management port.
  - SubType = 0. Received frames redirected or copied to the switch
     management port.
  - SubType = 1. Received frames redirected or copied to the switch
    management port with captured timestamp at the switch port where
    the frame was received.
  - SubType = 2. Transmit timestamp response (two-step timestamping).

Currently, this patch set supports Forward tag, SubType 0 of To_Port tag
and SubType 0 of To_Host tag. More tags will be supported in the future.

In addition, the switch supports NETC Table Management Protocol (NTMP),
some switch functionality is controlled using control messages sent to
the hardware using BD ring interface with 32B descriptors similar to the
packet Transmit BD ring used on ENETC. This interface is referred to as
the command BD ring. This is used to configure functionality where the
underlying resources may be shared between different entities or being
too large to configure using direct registers.

For this patch set, we have supported the following tables through the
command BD ring interface.

FDB Table: It contains forwarding and/or filtering information about MAC
addresses. The FDB table is used for MAC learning lookups and MAC
forwarding lookups.

VLAN Filter Table: It contains configuration and control information for
each VLAN configured on the switch.

Buffer Pool Table: It contains buffer pool configuration and operational
information. Each entry corresponds to a buffer pool. Currently, we use
this table to implement flow control feature on each port.

Ingress Port Filter Table: It contains a set of filters each capable of
classifying incoming traffic using a mix of L2, L3, and L4 parsed and
arbitrary field data. We use this table to implement host flood support
to the switch port.

The switch also supports other tables, and we will add more advanced
features through them in the future.

---
v2:
1. Use raw_smp_processor_id() in netc_select_cbdr() instead of
smp_processor_id().
2. Remove netc_port_free_mdio_bus() and netc_free_mdio_bus().
3. Correct the mask value in netc_port_set_mac_mode()
4. Rename net_port_set_rmii_mii_mac() to netc_port_set_rmii_mii_mac().
5. Check the return value of ntmp_bpt_update_entry() in
netc_switch_bpt_default_config().
6. Add some comments to avoid false positives from AI review.
v1 link: https://lore.kernel.org/imx/20260316094152.1558671-1-wei.fang@nxp.com/
---

Wei Fang (14):
  dt-bindings: net: dsa: update the description of 'dsa,member' property
  dt-bindings: net: dsa: add NETC switch
  net: enetc: add pre-boot initialization for i.MX94 switch
  net: enetc: add basic operations to the FDB table
  net: enetc: add support for the "Add" operation to VLAN filter table
  net: enetc: add support for the "Update" operation to buffer pool
    table
  net: enetc: add support for "Add" and "Delete" operations to IPFT
  net: enetc: add multiple command BD rings support
  net: dsa: add NETC switch tag support
  net: dsa: netc: introduce NXP NETC switch driver for i.MX94
  net: dsa: netc: add phylink MAC operations
  net: dsa: netc: add more basic functions support
  net: dsa: netc: initialize buffer bool table and implement
    flow-control
  net: dsa: netc: add support for the standardized counters

 .../devicetree/bindings/net/dsa/dsa.yaml      |    6 +-
 .../bindings/net/dsa/nxp,netc-switch.yaml     |  128 ++
 MAINTAINERS                                   |   11 +
 drivers/net/dsa/Kconfig                       |    3 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/netc/Kconfig                  |   14 +
 drivers/net/dsa/netc/Makefile                 |    3 +
 drivers/net/dsa/netc/netc_ethtool.c           |  192 ++
 drivers/net/dsa/netc/netc_main.c              | 1561 +++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c          |   89 +
 drivers/net/dsa/netc/netc_switch.h            |  155 ++
 drivers/net/dsa/netc/netc_switch_hw.h         |  356 ++++
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  |  188 +-
 drivers/net/ethernet/freescale/enetc/ntmp.c   |  391 ++++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  120 ++
 include/linux/dsa/tag_netc.h                  |   14 +
 include/linux/fsl/netc_global.h               |    6 +
 include/linux/fsl/ntmp.h                      |  233 +++
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |   10 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_netc.c                            |  180 ++
 23 files changed, 3638 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
 create mode 100644 drivers/net/dsa/netc/Kconfig
 create mode 100644 drivers/net/dsa/netc/Makefile
 create mode 100644 drivers/net/dsa/netc/netc_ethtool.c
 create mode 100644 drivers/net/dsa/netc/netc_main.c
 create mode 100644 drivers/net/dsa/netc/netc_platform.c
 create mode 100644 drivers/net/dsa/netc/netc_switch.h
 create mode 100644 drivers/net/dsa/netc/netc_switch_hw.h
 create mode 100644 include/linux/dsa/tag_netc.h
 create mode 100644 net/dsa/tag_netc.c

-- 
2.34.1


