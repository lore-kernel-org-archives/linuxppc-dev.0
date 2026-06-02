Return-Path: <linuxppc-dev+bounces-21842-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6BACD6E61
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 07:20:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV2L41HQ7z2yb9;
	Tue, 02 Jun 2026 17:20:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780384844;
	cv=pass; b=Mv3TGDHWX+nXQzSVSUg0NVFgkM31q3X1hZozYih2c8KMBlyttEle+n0LsghWEx0UB23RmMLDsGL4vuLLlaABqE6c9Bfa/aC1wQKn4jPiRtFflrF5T0WftcJiM77eO2yWP65903K7rGcgXJTyQiDYgAyvPv9yEv5VXcrztYYblCzyj4Aw2/HbbLsWITrjln8jfSLg7PIHLiEjILCIZN04AYr/7RA5R9bhZqZ7mLD4ANQ3dcbuqffc66P4UM4n4aVnfZ91e6wQtM8DzyXt0QLP/JocS4VaW95gVkQnr1yM4NnUtLKar+pjbM0Hje8dChKL/pQnrdsPFJhbrPU93wqb7g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780384844; c=relaxed/relaxed;
	bh=+wt1qg1Hlh4QRO67fvkulLEFCJ2POBDWUcK23gID59Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YliiN7lBjhA+xDNGkfw6zwAyym1JdOAphj1KaADowkhKEcdnSfJxDJ/hZOd9hVVOgH+Cot7xkndh6dJvhofai8T4NJfPEOevvfSxRYAPXsu6vGbixfW8V9YcEWF0lCUOrMa5x+Uvi+a+yN2uc1KfpQcda76oGvVvtH0zP/UBkZ3r2Y2eei0spbGxkqbIp9UiDuVbvHH+YzVbIWDbBAOg/OVA2+GBlIf5DvUuyCTTJheKHTHm44RnU3L+6siOTwVcvTJCtQ+W8Sy0eIKJAjIYvjgIKlSLPUJHaNbm5KsaMqQmRvNerskz+MtRwJNqCMPkprgESYxDYMlFqX/bHAuUzg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AQdZVND3; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AQdZVND3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV2L232xFz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 17:20:41 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saI8jaQ5VLBRkY/Ju7LQBSv2FKTRjzwrIk3x9GfAXSzg+W4BVtZ/+juX2KMltHHVzhBvgpyk6VwggTXjhUf+YWp3FN3j63RBBDBkRSg/9wzCCPgTwO4xmmlTrGU5FiGepIe/FnRTDss7Jjhmj5/jcCFk2Q3WzZacjksobmtfONjp6PojmY+fDKFp7kvo8xgKnSVrTE/wdIWrfFR1S9xxP4SmTuR1wo8p7MZCM/iQcfz0El970nmiTDKY0YvyKmgisD1ei7DYJzJgkI53T0/bC0PsqjfIJ9wfm1E02vy+1bIR33eyBdWxXM7nWAofMr8fJslau1hYo/w4Lim4bv34CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wt1qg1Hlh4QRO67fvkulLEFCJ2POBDWUcK23gID59Y=;
 b=xAwGTSxrUTubkD1EwSue607Xyc/32LDsYqq9DGTyk+/6rc509ilY1mBgMf2ZnQtXOscwG+yqiwjmYRQFq6CQJWG5dcgkSgHVlfghEaRaZ2tB082jJA+wJgbnMJkcjD1dys2EUezJHwhaSXXfroZccs4PfHHiEBvOJmvSlt6OpZU7HfH2+aXrW2RqY+iMybHXyP73kpN2eGVShqFLEOaQ64fkDxVbQFznRoxhVD1EZ/pVL+/v6rSLXtjZSsKqGKvzwV8g3TbBZr+Yzzk/YlhAE1ebPrO952fL71oacm73HemB5qhmMzI06rx26v++lDgVRvP1A4w/spV12o1FOjPI5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wt1qg1Hlh4QRO67fvkulLEFCJ2POBDWUcK23gID59Y=;
 b=AQdZVND3RLwEI2ktv6EPN0n8LGUbZ2uxrk3CwOUlE2b+4+kWBKPsd/ffRINU0ZP45RfzrlufHQMTsC9tTLeG14Q02j8/DBA/TMsBXOpn0I8lxBT+W6bOkfPj0tlpfTyyxAtqxgPjCqV98vpe8RgWjWarqwYB8gV2yciPb6xChBifEkWtkoJ3/3a6AlqFlgDlxUa/7m5c8a7oJkZhqneQ6+8s/JEf9gqdhYrvHRuTsprIZUpxYjFUxDi40c+lhn+GdUl3R6O6F/UrgJ4r0nzIGEw+ymzLRbY0ZY1FCFlwrSylkBEmvkV8zAaJd2+j7RMdz0pgcpeW3sBWL5E8otAD8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV2PR04MB11640.eurprd04.prod.outlook.com (2603:10a6:150:2b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 07:20:13 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 07:20:13 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 0/9] net: dsa: netc: add bridge mode support
Date: Tue,  2 Jun 2026 15:23:04 +0800
Message-Id: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:4:297::18) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV2PR04MB11640:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fc0300-71dc-4014-18ac-08dec07762ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|921020|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SuVzfPEBV+MEVCaCnVGUGu1N9UU0YWBca4jfdYNcLfB7uxsjSYu0oaqgck0+e41gQ6CFLO0D9cTtZeiM3kC3YEuW0NrMzNx/IK93e/44/6ZotkHBnG1jt7k69KLaNRRm/JMS4KkDIHBabQzZlfD46CCnYTk2YMhImm2149QNUCU/BztbCXdr0a+3NDl2nj94uWJARvuQ5WtZSYE58qew5oTWnsglVATuUhMN3fMZyNLCCZsdAjB/aBQfzAA0jQZxzq2a3WekpWDPZwL5ti3C/z5sjml5+TEX0Gp5C6eb5IoixZ8v6ArX2I5V7wvnhY7dywFy1R6qPnBmHtT0iFt4uRjBAQblhdsjimDKUK84f+HRMkKskS7MWLORSaxam31B1JHeLYWhXGTgXow0SrepVJLGqUObBiIdCUuQEa6UySxfmklvnwG/2JKsLO5ekeYYWoUfWeT1A07NPd7yX8SVtomoq2b56uYCoDnva45kKG00CuHDml8B8b3XsMWSHdcriPIUaTrQDtwnkeii5Wgne/LDc0FQQMvTI7Wn3ITOVJBCMYFq0B4D3ZAhLTS1MvVpPtiArbYml7BlVIXt5TVaY75LyzBI4Esg6g7sj4gLKCHLFvGA9Nrbo7poVRVOS0lIes3/3lDL4ZCfJWe3gpwu6/atfIICaii9pWR01Whof+i6zsauzQLPNBfqCSPvQ9+chksdlKBL5VJWGXIXF2ytN3960y8cRTHXp6qG38BG9YUehK3zT/S13SUMhd5L7bLj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(921020)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ze5cwFbkszmcg427rVZZHElkPdZfwr4vhnI0bNFpXjIw3qOzk+eb/XLcXQri?=
 =?us-ascii?Q?bC5aLXDMdmk8hUeyakAD5rr1+ovDVJRIHWIsUk5fJuDxSRlWb2HWDGlrmbXx?=
 =?us-ascii?Q?jR1UAv2Cj8lsx1puMk9NDXqp/pDBZdRVPLUKMLzQCIe49kAIlmlT6yqoHM2S?=
 =?us-ascii?Q?3JbMRRWYR/KnOsQqVsoz/VmAP5dB8oWwjq+T3vU3Fd5v/+ihY4qY3zsxo8Cv?=
 =?us-ascii?Q?kVFA2WMMvUNjiYBtf5YMU9nbfmL0beGGvqbLV1D0jZRVNPBpq84aJ6Es0e30?=
 =?us-ascii?Q?1lIjPElNtpfmk48C/M1JCAUWL7q42cBc/+63JyNBI8S8ZiefIdhfPNrcUQOo?=
 =?us-ascii?Q?v5MxiJhEwepn7fWlhOvK9SaDt44U7tws5zOT/Ysa0OrVxvC7KvtJy+CWowWN?=
 =?us-ascii?Q?oG/zHJoD0mPHYxATkeEnfCT7srhGuzKqngkXUbE6GFfMQD9XpAm0+O8nTEFq?=
 =?us-ascii?Q?egwTeT9BP7+NwDbDSc3fenBVA8PKmqn/v6ST5yykNAEbebw82VJjYhD725cu?=
 =?us-ascii?Q?Yg/HJCx8E8GxTrO/LcY96L4DhxNRwfXaxr4HQd264nT6v8LAacFONl70Fbf5?=
 =?us-ascii?Q?9siCj9U+DnUsou6xoK+HhBOE/GM3jEhjaVGlcVzVA31lV+SY3vYZolff6uwD?=
 =?us-ascii?Q?xUzcbFHNVWKQbXQ3BrP0RNEfWdxEs30rLxMQF3cWbZgZ7vsWQZu2TdDYbcf3?=
 =?us-ascii?Q?BRJ+49CpifJvOuq91q0XSgzmqhVpGdKXS+PTDIeWGUWM4MCZbwRy9GhqMb+1?=
 =?us-ascii?Q?o0YNYAEhOAxb52SKsCu9R09cO8UFPrEwWNqEf6LTn/L3gJ80uxX2bDeHQWKj?=
 =?us-ascii?Q?Em29FNxvgkfIMOxXvOk2RapaZrFe0F1wNCV41iz9BP2KHs2kf7Rit1oNLrhN?=
 =?us-ascii?Q?iJ+96ue8tYvaZh7yVpFvLGBXpC4fTIAAwR5I1R9SoYe7MQcH1NTdhfgKHzgd?=
 =?us-ascii?Q?jESrlazJIzGiSc614ZtQjVmsF594RsZgKfDWrwp3+WENBECL0DXqt7C/41EP?=
 =?us-ascii?Q?H15zD7s4POdFSPivghhb63/5mndwaNzGfsYulhum4goNHurz40yj8X0Vn4MS?=
 =?us-ascii?Q?3tiYzirm3OTupoXXsZxSA2Nqcp5jCal8oU3Pr31YaDSzyn8b2RJX2wFffUgr?=
 =?us-ascii?Q?Og8C8lMUmKpUkf0+CJ0GpXLvfpjG/zQ89m/uPsjl6gsxcZu9Lo5Muu2CHSXF?=
 =?us-ascii?Q?sG7Mhf5MfsAZs6Ms4jTRVKT8IEYHg7bcqRlkeoNbhMSyM+TQmdGTMEp7hBVr?=
 =?us-ascii?Q?wP2r2EjHscjvRAz/REhGknsfgufnLfT9VVF4g52DkWKl8cRbRFiDz4SSryxZ?=
 =?us-ascii?Q?XziPLtR2Ms8r+yyHA6pzUSi0JPZuFTI9w5H9nxF7CsfkU1yzRj8K0KGSSLLd?=
 =?us-ascii?Q?Tm+ftcMWZgLVCbzIvLuO7LoLdriS/byQN9GjkbV4f6MmvbNjSzfKqIf9mz6Z?=
 =?us-ascii?Q?B5kh0Rvsn7c0TUeXmUuXhbbGWEnum8Tx1LHBI4FjbMTZYTJLpjPzL9SLJLcr?=
 =?us-ascii?Q?RtainliqMnOAvWIpUdAjZShLH2hL5QKea/edjqwk0IuoZAO7VFeqmkZ7vmr4?=
 =?us-ascii?Q?CQKbz0IKrmWBnK6B/0cPzNwjfMyu0kujtKyxU06HFbbRPvnjxCvhCM47lUdG?=
 =?us-ascii?Q?vdC6aN/TybUEB047GccXguDPYTJP50stUH/iwmWRxivjwSP02UcmGflLQOYe?=
 =?us-ascii?Q?ZzOoXvjwOLXwq3lNZC4LA1M7byisahNJa+fEB+pNwpjXKyeMqS4d0dNYsmzj?=
 =?us-ascii?Q?H6NBgQCGDJAH5f7g7v7DvoZUNuYLR1yLLxe5wlEiAitzPK33LPQH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fc0300-71dc-4014-18ac-08dec07762ea
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 07:20:13.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dHrtXc6qM4KwJ1wcVcNNDrrt69M723Vc/4l5girDYEW89Rmgg+5BtKNL4xcNwcGptdqns0tlKrxKWW4beUqAG7mObPjg2cNauUnxQQckoaNmrjTz6pMDQw6hZ1/a33B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11640

From: Wei Fang <wei.fang@nxp.com>

This series adds bridge mode support to the NETC DSA switch driver,
covering both VLAN-aware and VLAN-unaware operation.

The NETC switch manages forwarding through a set of hardware tables
accessed via NTMP: the FDB table (FDBT), VLAN filter table (VFT), egress
treatment table (ETT), and egress count table (ECT).  The series extends
the NTMP layer with the operations required for bridging, then builds the
DSA bridge callbacks on top.

Since all switch ports share the VFT, so only one VLAN-aware bridge is
supported.

FDB aging is managed in software.  A periodic delayed work sweeps the
table using the hardware activity element mechanism, with a default aging
time of 300 seconds matching the IEEE 802.1Q standard.  Per-port entries
are also flushed immediately on bridge leave and link-down events.

---
v2:
1. Remove ntmp_fdbt_delete_entry_by_keye()
2. Add settings for cfge.cfg and cfge_mc in
   ntmp_fdbt_update_activity_element()
3. Remove the wrong comment from ntmp_fdbt_delete_aging_entries()
4. Correct the description of ntmp_fdbt_delete_port_dynamic_entries()
5. Add generic function ntmp_vft_set_entry(), which is called by
   ntmp_vft_add_entry() and ntmp_vft_update_entry()
6. ntmp_ett_add_or_update_entry() is split into ntmp_ett_add_entry() and
   ntmp_ett_update_entry(), and add generic function ntmp_ett_set_entry()
7. netc_add_or_update_ett_entry() is split into netc_add_ett_entry() and
   netc_update_ett_entry()
8. Remove "entry->untagged_port_bitmap &= ~BIT(port)" from
   netc_port_del_vlan_entry()
9. Add pvid check in netc_port_vlan_filtering()
10. Improve the comment in netc_vlan_unaware_pvid()
11. Change the error code in netc_single_vlan_aware_bridge() and
    netc_port_vlan_add()
12. Add comments in netc_port_vlan_del()
13. Add ageing_time_min and ageing_time_max, and refactor
    netc_set_ageing_time()
14. Remove fdbt_acteu_interval from struct netc_switch
15. Update some commit messages
v1 link: https://lore.kernel.org/netdev/20260527100217.794987-1-wei.fang@oss.nxp.com/
---

Wei Fang (9):
  net: enetc: add interfaces to manage dynamic FDB entries
  net: enetc: add "Update" and "Delete" operations to VLAN filter table
  net: enetc: add interfaces to manage egress treatment table
  net: enetc: add "Update" operation to the egress count table
  net: dsa: netc: initialize the group bitmap of ETT and ECT
  net: enetc: add helpers to set/clear table bitmap
  net: dsa: netc: add VLAN filter table and egress treatment management
  net: dsa: netc: add bridge mode support
  net: dsa: netc: implement dynamic FDB entry ageing

 drivers/net/dsa/netc/netc_main.c              | 918 +++++++++++++++++-
 drivers/net/dsa/netc/netc_switch.h            |  33 +
 drivers/net/dsa/netc/netc_switch_hw.h         |   6 +
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 440 ++++++++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  18 +-
 include/linux/fsl/ntmp.h                      |  60 ++
 6 files changed, 1454 insertions(+), 21 deletions(-)

-- 
2.34.1


