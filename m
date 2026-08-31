Return-Path: <linuxppc-dev+bounces-26261-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FF0C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:20:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYMPT3TRjz2yCv;
	Mon, 31 Aug 2026 18:20:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788164429;
	cv=pass; b=FqQQIrweO14WDVHNx01prNOnWnPPiJwT9l/PPEyYsCxfhN0V5eUKkOF/4talvpRw8C3mPgDimEvmxGj15Hj5Nln7uYCKtZU/hJ3kOH+d86PXRq6PERSETmC6swjAeNvRoo3WJjri4NXBUo0uBmAGCEk7EDjn4123t2CXna9sKsCMwjJilwMjHea9PsZQmSrQuhpZ4bsST29UCU1v+Pyha6IvPZwLKjoSZJvcxPP4u95+nbeMTS9shXI1ofMH+aZCTOeJ+UajFj2Y3FICyuxUE1d2y4AdZYMG/XecPbEsyTNdS/K3ssIFeTVFBJGjimOwhnsAM7sM/e7+3aQu5J1nsg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788164429; c=relaxed/relaxed;
	bh=shK/UDwhR2b7Fq2Lb6+pErR9r3cIGxtBPUhjXKku+pM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YD/WbFYi05t28CbGjC13BYEdc5eJWXnV/i1KecCR/wDJvZzSJjas/l8KtYY2vYRGLLjtTiIVA+npazA6b8KTdliTIYlgcoFdgEYGbaHVA+H9ElM0DzQqPTAr4Z7zap+mgyvi/J46P07WJE+Lxyc+Dy4lIr9T+iDvShOrDmVSuc8tO6UKjmZHCaX5IijdN9KF1npK5saxPJO+NY0l+j7CdLy+MT9EJcFJybi6JIoMnyY4I/MtiZx1Qvg/UnibuvdMw0O7UQzBnt1eERNdI4qpTj3T5mWQ9A8SGcM5hz5XwE0lSp5TDxHFeZgY7dwLv52c8gYRhSHQEcoduiBY5qji6w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NAD7BpD2; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NAD7BpD2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYMPR2rqMz2yxN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 18:20:27 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRSCHdyF20H4F99E4m62ZSe8SRXjw0nWyJ3jMDXOnmyj45IA6OKK4t7hRi3ofBoCZ+AAYIzMPpIbeRni0+b5Ux2kDbuKrrML6OLh7M7Wwv0iErRZisUEHEcGj8SLM8udxzT/Jb+ofUfiB7XwtTvdaPb9PCRiOr2kstjtG3jAgHvg6DexA08YveZPFu4TuY0ZKclM4l81lQ18Ri8U2Lz6BPib06X6f1Ma5NKJOj/vSqekJe7G1881QtYulVK+rs5zk7echRXa5HYFzT9wsUFyzTrcR8gvFdYzRneDfyJaDWzs7KoTHfUw5w24FzPgF5dtkh4IzKjNOURqYtwP8Lmi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shK/UDwhR2b7Fq2Lb6+pErR9r3cIGxtBPUhjXKku+pM=;
 b=iE1ailotureJUJXoehwlDK2x7iAzjz06dUy/hZ3RvHdvravLFJGBds6Q3YgrHJDHpP2C0S/A5MOXMD1g0ILSXxwyWOqG4pLaWyHTKrDa2cltajNYeXZMnwCJoYBX9xiU9ATWiNYc/MFUAMUb5qK5OvQPj3qKaQcrj+OW9T6cfgxCplk0Z7AiTCxLE2hGq9FHGasL84nwjygJwnfycDAV/Jt/4M568cKDeTL2t8h5VZhTguA12jzgKYpXpT41qrTC2eoNdrptXxpx7sLq46ntmagzMn9e1uGol3mmTjJDYPyvcWludxNDjoV42/BsQRSWCyF+vF0E55KsskJv/a9t4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shK/UDwhR2b7Fq2Lb6+pErR9r3cIGxtBPUhjXKku+pM=;
 b=NAD7BpD2fObYBDW59d+zi4lJS6fbJ71Nlc+sSOl2Gaqbc73R6Z/rofa9TxKn3asVkKvpp+0zafQmg+kCYrdK/7XtYbrMss4OvctIt9sPSVq0blI6XtyyKJVwRQVgr3fIj7vBO0WfONQ7t9kClbivb6B/nnHrlF27a4qVDzIZOXFKwIYY8pdnKK6KLhhtsOC+PwNkKBVlhaFHtlDSQHsgSjcQtJ+8Uh8u7eGmR4G9yGQdZfQj2kbXlr910c92LcIEcon3vZ+HesWYvBK8fZkFEgFo3EONP/klQjDVA00sU5+rDofbpThaTxl8HTImoEW0zigS4uA4r3N2oTMDZkfU4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by ZR6PR04MB349300.eurprd04.prod.outlook.com (2603:10a6:910:da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:20:14 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 08:20:14 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 7/8] net: dsa: netc: add PTP two-step timestamping support
Date: Mon, 31 Aug 2026 16:23:34 +0800
Message-Id: <20260831082335.1184605-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
References: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0309.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|ZR6PR04MB349300:EE_
X-MS-Office365-Filtering-Correlation-Id: f41bc2d8-c8d5-4654-4874-08df0738aeac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|23010399003|3023799007|10067099003|11063799006|56012099006|921020|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jlFkmIBBeshHbOwy5DUnB2FU+yuMjHSMw6pqzG9EHt7YMg39Jg1cWkZPgJzDOVh7eZE69YVczhzzhT93eLxU50cklix7/tu2KJxyUdEdTds87txecqjoA2qFI2V4N2aGkkWu1IudbstiCoODeHC5V9yt0zbSGnrzJA5nYLToBrACpVugTD1AfmSr4U5hBdZpJKKqeMbRBrt+7dTxhMGj49F9G+L0dfennxswPLwfrp3Kq+LjKpFfTZaSEmRDGiq1QsJVIME9WWk2VCyviwisQri8sY+4UKzpwp0PXaFgXSuIU9Gn5Zk4JtCItmia3vj+LQlYwjqRtL6cnGqxNvnX96goqYfvhYi+pB03HyguQ1qecbV/iW7kuH++vfGyBsQrGckXNk8eamc4F62nt41OcNCQx7koSU6CLkebbsWxmdoJcyayfaK+AB3z6vCHMmHpGWAb4ofgnrdru3WmW/CGN35ESeW7lXJWc8yChxHdk6kMfxSWt3CL3x3649eLdSKOmi6lP+cw2Tfq8L0lBgyfkMcWGDT20b7mZk7QZpnj3Ksv0Oy/aYQiBgjTlFPrsOOP8eiyGZnC5Wa1V3H9pcfKacWR/GEfWVn7CXV0YnTI0KJ2fNRmcbp5nL/y47dhlB2Frm/hskn/8qOJAd6Op28p4dmNbfWm/oBYYJgBzRC+JRq8J0TU7fkUAcU9oTuwuWIScnyigI3DL+WvUHAzcNbf+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(23010399003)(3023799007)(10067099003)(11063799006)(56012099006)(921020)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yrKFGH+J50O9lKll/tfoub6vnpEEsaxL3kvFwPeELjIYY0loHdKadAmYMGkz?=
 =?us-ascii?Q?oDLCl/HlfajK3HiIwjOzjDh1BdSagY9MhmdknLUisEhssmzYjd3b8pCcNPBM?=
 =?us-ascii?Q?JsKu5i+Mj00/Gp5ghOKl9CKD0pL8yDp+kufksAbYLqyattn4IHNRQgDTaVLy?=
 =?us-ascii?Q?g4gl2MIOMHlXqlWUt46nqE4bmW6nAhE9B6ujvPn4I38HNmlW2pRAVV6QReoG?=
 =?us-ascii?Q?GvKaIg+UM6NUJSs2G4+wSq0/TT2TCiKQ43VksWGU7WdDwQsZGhSpBFFtYOfH?=
 =?us-ascii?Q?Y6X0hJKt1kE0X9RWh+ONjboHjHcYQadJSlFWkzHSFIoynxcWs477uHyqZyRu?=
 =?us-ascii?Q?DBVATATAjgNSPhmfS0TS6EZkG49qrtq2ju25K5Es9dwHds7nH5I0jwksbTfZ?=
 =?us-ascii?Q?yq2Y8SMNHPEkaytK8ZGQKlyQzV03/WgObYo5vjg7W7l4NojJeUDdUTFBZcCn?=
 =?us-ascii?Q?fnmmbMX2odI6CxzvsaYqH2mW3DN2L0CeK79LKx5OTDTLOEWifwZh9MCB2KXu?=
 =?us-ascii?Q?Gi0l31kh36Egrp0FfMri3W3pAlc8Jh1TjF8argi6ZdRffJkWGwl1xyVVwPQJ?=
 =?us-ascii?Q?s+vmtqkhaCPXVcCKA5WbndzZCDpdSDn4LJsZdQ19Oim0cuDzp7/J2ffIu6Vd?=
 =?us-ascii?Q?lRg6ZPHV7y0cUHPUKGNMpw8tPFhwDGmPk7qmvBP1Brrg8pFIZHvGOFc7wWDZ?=
 =?us-ascii?Q?ytibGYGxzZ1S7GOiscp0ioL0nQRzxuDGQYCHM12SBiDFUc41Ev/n06uh+v06?=
 =?us-ascii?Q?Pe6rMsgv0tRqaDxeiTRWs92rE8pZ8oOD2V5SSuzm2fmF3jNi+5NA8evXxKSo?=
 =?us-ascii?Q?F7rmgTq9crjkURtkGKalYreOSVlq8J02RQw6xSeC97Dvk83tdrnsEReXzC5O?=
 =?us-ascii?Q?+tv+cqZcm8Z8HJt9e33o9OQ1eQqFoilXF01zzi2btDk5LtUe0UiD/0WW3hGd?=
 =?us-ascii?Q?NQ7AvVowNTXBZvJszWMJpsuM27Nb+YRdmiWIqQTOTZ8u1bxu5JNuymRjRJJv?=
 =?us-ascii?Q?TNcaURZSjAyfhrj/iJdfPX+DLZQs01y/wY4yaBu0g5X27I4Tt1vNf/JZYxLU?=
 =?us-ascii?Q?CiaNizS83opZBRQ9K8+OQT9nGYzFZEDmCDYzwoggpJNwwUfzn9nCpREo4+Q3?=
 =?us-ascii?Q?F6es0b9PgUgKevCDoh9omnlvOdxKXj/liwbAVrEwMFcZl/V5P2XUfkc0lAQF?=
 =?us-ascii?Q?2gAuYb2Zi9sS6iBUKKLBUs5HzYCMnPHYQI+wWNG2XntZWZmFu0cvu/lJWRnR?=
 =?us-ascii?Q?jGadJpT0k5Vb6MBelGfx+wqh6Y9Dz/ef7yCd8mguWr57F9o7tFtb7heOdiGC?=
 =?us-ascii?Q?aKgpCNk8Uf+7OrKrpwwoU9I1/oz0THTp5r9+LlYeSOzpHsw1oceS6glLYtbd?=
 =?us-ascii?Q?VkKefKnE6lzczR7FAwZpatA2vmRE5tMxTTlgGraDRQr14NBKsO7keQqg0adc?=
 =?us-ascii?Q?5WDtip+Rx9B4nZFBh87ORpDnVRKldalJVgT+hqeX9jPwIa3x4AI82Uo9WfUD?=
 =?us-ascii?Q?S0lF6rHXFLUEttXLVr5O0DyOr9FXIzwxfMhDQWXK+MUjbUjEuxsZrbIG/OFN?=
 =?us-ascii?Q?bSeR99GuqIZ1TRHF+Wxz23OFOdNkIFJ80v8DhEqZCt7X3J55nBxahLqpwAQX?=
 =?us-ascii?Q?L+RmsRiwAUzfZRmO+hAI+I8ArtianREP1g/aCo0PzKWUjZI8y6CuaV/veNwU?=
 =?us-ascii?Q?zVKZNGr0hVWy/XX7rl/I36YupNyLc642s5vOalJGhTVPYICIlo9sV1anxbkY?=
 =?us-ascii?Q?hCXzDAScm3jgXfx0D3SWP4KEi2rfg5mB6ui8FBoZvk5+pGJB/6Ao?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41bc2d8-c8d5-4654-4874-08df0738aeac
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:20:14.2851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7G1FExUIgyKXB/MnAmNxffgWNS5E4txfgf/x0sVZko2l8zAT4BvIKjDd5XVu9UYajIdJiTZxld+V+t87REDhWty3L9uSEd6jg3948qTgt9JjFyhjnuvHqb+4IfDYgAw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB349300

From: Wei Fang <wei.fang@nxp.com>

Add two-step TX timestamping and RX timestamping for the NETC switch.

For RX, install ingress port filter table (IPFT) rules that redirect PTP
frames to the CPU port. Support L2, L4 over IPv4 and L4 over IPv6, for
both event and general messages, selected through the hwtstamp rx_filter.
The hardware inserts a To_Host subtype 1 tag carrying the 64-bit ingress
timestamp after the source MAC address. The tagger extracts it into the
skb control buffer, and netc_port_rxtstamp() copies it into
skb_hwtstamps().

For two-step TX, clone the skb and record a 4-bit timestamp request ID
in the clone, then queue it on a per-port list. netc_xmit() carries the
same ID in the To_Port subtype 2 tag it inserts into the transmitted
frame. After the hardware sends the frame out, it generates a To_Host
subtype 2 response frame whose tag echoes back that ID together with the
64-bit transmit timestamp. The tagger dispatches the ID and timestamp to
the switch driver through the twostep_tstamp_handler callback registered
in netc_tagger_data. The driver matches the ID to the queued clone and
hands the clone back to the stack with the transmit timestamp via
skb_complete_tx_timestamp(), then frees the response skb. Non-PTP frames
keep using the To_Port subtype 0 tag on the xmit fast path.

The request IDs themselves are managed per port: each transmit takes the
first ID not currently in flight, and an ID becomes available again once
its clone leaves the queue. A per-port delayed work, tstamp_timeout_work,
drops any clone that stays unmatched for 5 seconds, which is far longer
than the hardware's normal response latency. A queued clone is thus
completed by the response handler, or dropped by tstamp_timeout_work on
timeout.

The two-step response frame carries no payload; its total length is
only 26 bytes (12 bytes of DMAC and SMAC plus a 14-byte switch tag).
eth_type_trans() pulls ETH_HLEN bytes, advancing skb->data past the
DMAC, SMAC, and the TPID that opens the switch tag, leaving skb->len
at 12. Since the tag pointer is at (skb->data - 2), the pskb_may_pull()
check must use (NETC_TAG_MAX_LEN - 2) rather than NETC_TAG_MAX_LEN.
Otherwise pskb_may_pull() drops the response frame and breaks PTP
synchronization.

Add the To_Port subtype 2 and To_Host subtype 1/2 tag structures, extend
netc_xmit() to select the tag based on ptp_flag in the skb control buffer,
and add netc_connect()/netc_disconnect() to manage the per-switch
netc_tagger_data allocation. Grab the PTP timer's pci_dev in netc_setup()
so get_ts_info() can report its PHC index, and release it in the teardown
and error paths.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/Kconfig         |   1 +
 drivers/net/dsa/netc/Makefile        |   3 +-
 drivers/net/dsa/netc/netc_main.c     |  71 +++-
 drivers/net/dsa/netc/netc_platform.c |   1 +
 drivers/net/dsa/netc/netc_ptp.c      | 471 +++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h   |  42 +++
 include/linux/dsa/tag_netc.h         |  21 ++
 net/dsa/tag_netc.c                   | 168 +++++++++-
 8 files changed, 763 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/dsa/netc/netc_ptp.c

diff --git a/drivers/net/dsa/netc/Kconfig b/drivers/net/dsa/netc/Kconfig
index 793f7691a24f..8770b65d0f62 100644
--- a/drivers/net/dsa/netc/Kconfig
+++ b/drivers/net/dsa/netc/Kconfig
@@ -4,6 +4,7 @@ config NET_DSA_NETC_SWITCH
 	depends on ARM64 || COMPILE_TEST
 	depends on NET_DSA && PCI
 	depends on NET_VENDOR_FREESCALE
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select NET_DSA_TAG_NETC
 	select FSL_ENETC_MDIO
 	select NXP_NTMP
diff --git a/drivers/net/dsa/netc/Makefile b/drivers/net/dsa/netc/Makefile
index f40b13c702e0..572b833ad80f 100644
--- a/drivers/net/dsa/netc/Makefile
+++ b/drivers/net/dsa/netc/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_NET_DSA_NETC_SWITCH) += nxp-netc-switch.o
-nxp-netc-switch-objs := netc_main.o netc_platform.o netc_ethtool.o
+nxp-netc-switch-objs := netc_main.o netc_platform.o netc_ethtool.o \
+			netc_ptp.o
diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index ae3dc487f5f8..cd2274d7c552 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -65,6 +65,20 @@ netc_get_tag_protocol(struct dsa_switch *ds, int port,
 	return DSA_TAG_PROTO_NETC;
 }
 
+static int netc_connect_tag_protocol(struct dsa_switch *ds,
+				     enum dsa_tag_protocol proto)
+{
+	struct netc_tagger_data *tagger_data;
+
+	if (proto != DSA_TAG_PROTO_NETC)
+		return -EPROTONOSUPPORT;
+
+	tagger_data = ds->tagger_data;
+	tagger_data->twostep_tstamp_handler = netc_port_twostep_tstamp_handler;
+
+	return 0;
+}
+
 static void netc_port_rmw(struct netc_port *np, u32 reg,
 			  u32 mask, u32 val)
 {
@@ -292,6 +306,15 @@ static int netc_init_all_ports(struct netc_switch *priv)
 			 * been created.
 			 */
 			np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
+
+			/* Only the user port needs to support PTP feature, so
+			 * PTP-related resources, such as skb_txtstamp_queue,
+			 * tstamp_lock, etc., are initialized only for the user
+			 * port.
+			 */
+			err = netc_port_ptp_init(np);
+			if (err)
+				return err;
 		}
 	}
 
@@ -881,6 +904,15 @@ static int netc_switch_bpt_default_config(struct netc_switch *priv)
 	return 0;
 }
 
+static struct pci_dev *netc_get_ptp_timer(struct netc_switch *priv)
+{
+	struct pci_bus *bus = priv->pdev->bus;
+	u32 devfn = priv->info->tmr_devfn;
+
+	return pci_get_domain_bus_and_slot(pci_domain_nr(bus),
+					   bus->number, devfn);
+}
+
 static int netc_setup(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
@@ -893,13 +925,23 @@ static int netc_setup(struct dsa_switch *ds)
 
 	netc_get_switch_capabilities(priv);
 
+	/* The PTP timer sits on the same PCI bus as the switch. PCI creates
+	 * every function's pci_dev during bus enumeration, before any driver
+	 * probes, so we can grab the timer's pci_dev here even if the timer
+	 * driver has not probed yet.
+	 */
+	priv->tmr_dev = netc_get_ptp_timer(priv);
+	if (!priv->tmr_dev)
+		dev_info(priv->dev,
+			 "PTP timer PCI device not found\n");
+
 	err = netc_init_all_ports(priv);
 	if (err)
-		return err;
+		goto put_ptp_timer;
 
 	err = netc_init_ntmp_user(priv);
 	if (err)
-		return err;
+		goto put_ptp_timer;
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
@@ -938,6 +980,8 @@ static int netc_setup(struct dsa_switch *ds)
 	mutex_destroy(&priv->fdbt_lock);
 	mutex_destroy(&priv->vft_lock);
 	netc_free_ntmp_user(priv);
+put_ptp_timer:
+	pci_dev_put(priv->tmr_dev);
 
 	return err;
 }
@@ -950,6 +994,21 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
 	mutex_destroy(&priv->vft_lock);
 }
 
+static void netc_free_ports_resources(struct netc_switch *priv)
+{
+	struct dsa_port *dp;
+
+	dsa_switch_for_each_available_port(dp, priv->ds) {
+		struct netc_port *np = priv->ports[dp->index];
+
+		if (!dsa_port_is_user(dp))
+			continue;
+
+		disable_delayed_work_sync(&np->tstamp_timeout_work);
+		netc_port_purge_txtstamp_queue(np);
+	}
+}
+
 static void netc_teardown(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
@@ -957,6 +1016,8 @@ static void netc_teardown(struct dsa_switch *ds)
 	disable_delayed_work_sync(&priv->fdbt_ageing_work);
 	netc_destroy_all_lists(priv);
 	netc_free_ntmp_user(priv);
+	netc_free_ports_resources(priv);
+	pci_dev_put(priv->tmr_dev);
 }
 
 static bool netc_port_is_emdio_consumer(struct device_node *node)
@@ -2425,6 +2486,7 @@ static const struct phylink_mac_ops netc_phylink_mac_ops = {
 
 static const struct dsa_switch_ops netc_switch_ops = {
 	.get_tag_protocol		= netc_get_tag_protocol,
+	.connect_tag_protocol		= netc_connect_tag_protocol,
 	.setup				= netc_setup,
 	.teardown			= netc_teardown,
 	.phylink_get_caps		= netc_phylink_get_caps,
@@ -2453,6 +2515,11 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.get_sset_count			= netc_port_get_sset_count,
 	.get_strings			= netc_port_get_strings,
 	.get_ethtool_stats		= netc_port_get_ethtool_stats,
+	.get_ts_info			= netc_get_ts_info,
+	.port_hwtstamp_set		= netc_port_hwtstamp_set,
+	.port_hwtstamp_get		= netc_port_hwtstamp_get,
+	.port_rxtstamp			= netc_port_rxtstamp,
+	.port_txtstamp			= netc_port_txtstamp,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
index 34aeb6fceb3c..4fd0ce6770c3 100644
--- a/drivers/net/dsa/netc/netc_platform.c
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -50,6 +50,7 @@ static void imx94_switch_phylink_get_caps(int port,
 
 static const struct netc_switch_info imx94_info = {
 	.num_ports = 4,
+	.tmr_devfn = PCI_DEVFN(0, 1),
 	.phylink_get_caps = imx94_switch_phylink_get_caps,
 };
 
diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
new file mode 100644
index 000000000000..f55010f46819
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_ptp.c
@@ -0,0 +1,471 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC switch driver
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/ptp_classify.h>
+#include <linux/ptp_clock_kernel.h>
+
+#include "netc_switch.h"
+
+#define NETC_NUM_TS_REQ_ID		16
+#define NETC_TXTSTAMP_TIMEOUT		(5 * HZ)
+
+static void netc_port_tstamp_timeout_work(struct work_struct *work)
+{
+	struct netc_port *np = container_of(work, struct netc_port,
+					    tstamp_timeout_work.work);
+	struct sk_buff_head free_list;
+	struct sk_buff *skb, *skb_tmp;
+
+	__skb_queue_head_init(&free_list);
+
+	spin_lock_bh(&np->tstamp_lock);
+	skb_queue_walk_safe(&np->skb_txtstamp_queue, skb, skb_tmp) {
+		if (time_before(jiffies, NETC_SKB_CB(skb)->ptp_tx_time +
+			       NETC_TXTSTAMP_TIMEOUT))
+			continue;
+
+		dev_dbg_ratelimited(np->switch_priv->dev,
+				    "Port %d ts_req_id %u which seems lost\n",
+				    np->dp->index, NETC_SKB_CB(skb)->ts_req_id);
+
+		__skb_unlink(skb, &np->skb_txtstamp_queue);
+		__skb_queue_tail(&free_list, skb);
+	}
+
+	/* Reschedule if there are still pending clones that have not
+	 * timed out yet.
+	 */
+	if (!skb_queue_empty(&np->skb_txtstamp_queue))
+		schedule_delayed_work(&np->tstamp_timeout_work,
+				      NETC_TXTSTAMP_TIMEOUT);
+
+	spin_unlock_bh(&np->tstamp_lock);
+	__skb_queue_purge(&free_list);
+}
+
+int netc_port_ptp_init(struct netc_port *np)
+{
+	/* Initialize to invalid entry IDs */
+	for (int i = 0; i < NETC_PTP_MAX; i++)
+		np->ptp_ipft_eid[i] = NTMP_NULL_ENTRY_ID;
+
+	spin_lock_init(&np->tstamp_lock);
+	__skb_queue_head_init(&np->skb_txtstamp_queue);
+	INIT_DELAYED_WORK(&np->tstamp_timeout_work,
+			  netc_port_tstamp_timeout_work);
+
+	return 0;
+}
+
+void netc_port_purge_txtstamp_queue(struct netc_port *np)
+{
+	struct sk_buff_head free_list;
+
+	__skb_queue_head_init(&free_list);
+
+	spin_lock_bh(&np->tstamp_lock);
+	skb_queue_splice_init(&np->skb_txtstamp_queue, &free_list);
+	spin_unlock_bh(&np->tstamp_lock);
+
+	__skb_queue_purge(&free_list);
+}
+
+static int netc_get_phc_index(struct netc_switch *priv)
+{
+	if (!priv->tmr_dev)
+		return -1;
+
+	return ptp_clock_index_by_dev(&priv->tmr_dev->dev);
+}
+
+int netc_get_ts_info(struct dsa_switch *ds, int port,
+		     struct kernel_ethtool_ts_info *info)
+{
+	struct netc_switch *priv = ds->priv;
+
+	info->phc_index = netc_get_phc_index(priv);
+	if (info->phc_index < 0)
+		return 0;
+
+	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
+				 SOF_TIMESTAMPING_RX_HARDWARE |
+				 SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
+
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT);
+
+	return 0;
+}
+
+static void netc_port_del_ptp_filter(struct netc_port *np)
+{
+	struct netc_switch *priv = np->switch_priv;
+	u32 entry_id;
+	int i;
+
+	for (i = 0; i < NETC_PTP_MAX; i++) {
+		entry_id = np->ptp_ipft_eid[i];
+		if (entry_id != NTMP_NULL_ENTRY_ID) {
+			if (!ntmp_ipft_delete_entry(&priv->ntmp, entry_id)) {
+				np->ptp_ipft_eid[i] = NTMP_NULL_ENTRY_ID;
+				continue;
+			}
+
+			dev_err(priv->dev,
+				"Deleting PTP entry 0x%x (type %d) on port %d failed\n",
+				entry_id, i, np->dp->index);
+		}
+	}
+}
+
+static int netc_build_ptp_ipft_keye(struct ipft_keye_data *keye, int port,
+				    enum netc_ptp_type type)
+{
+	u16 src_port, frm_attr_flags;
+
+	keye->precedence = cpu_to_le16(NETC_IPFT_PTP_PRECEDENCE);
+	src_port = FIELD_PREP(IPFT_SRC_PORT, port);
+	src_port |= IPFT_SRC_PORT_MASK;
+	keye->src_port = cpu_to_le16(src_port);
+
+	switch (type) {
+	case NETC_PTP_L2:
+		keye->ethertype = htons(ETH_P_1588);
+		keye->ethertype_mask = htons(0xffff);
+		break;
+	case NETC_PTP_L4_IPV4_EVENT:
+	case NETC_PTP_L4_IPV4_GENERAL:
+	case NETC_PTP_L4_IPV6_EVENT:
+	case NETC_PTP_L4_IPV6_GENERAL:
+		frm_attr_flags = IPFT_FAF_IP_HDR | FIELD_PREP(IPFT_FAF_L4_CODE,
+				 IPFT_FAF_UDP_HDR);
+		if (type == NETC_PTP_L4_IPV6_EVENT ||
+		    type == NETC_PTP_L4_IPV6_GENERAL)
+			frm_attr_flags |= IPFT_FAF_IP_VER6;
+
+		keye->frm_attr_flags = cpu_to_le16(frm_attr_flags);
+
+		/* Set IP version bit in flags_mask to match IPv4 or IPv6
+		 * packets
+		 */
+		frm_attr_flags |= IPFT_FAF_IP_VER6;
+		keye->frm_attr_flags_mask = cpu_to_le16(frm_attr_flags);
+		keye->ip_protocol = IPPROTO_UDP;
+		keye->ip_protocol_mask = 0xff;
+
+		if (type == NETC_PTP_L4_IPV4_EVENT ||
+		    type == NETC_PTP_L4_IPV6_EVENT)
+			keye->l4_dst_port = htons(PTP_EV_PORT);
+		else
+			keye->l4_dst_port = htons(PTP_GEN_PORT);
+
+		keye->l4_dst_port_mask = htons(0xffff);
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+static int netc_port_add_ipft_ptp_entry(struct netc_port *np,
+					enum netc_ptp_type type)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct ipft_entry_data *entry;
+	struct ipft_keye_data *keye;
+	u32 cfg;
+	int err;
+
+	/* The previously configured PTP entry may not have been successfully
+	 * deleted, so there is no need to configure it again.
+	 */
+	if (np->ptp_ipft_eid[type] != NTMP_NULL_ENTRY_ID)
+		return 0;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return -ENOMEM;
+
+	keye = &entry->keye;
+	err = netc_build_ptp_ipft_keye(keye, np->dp->index, type);
+	if (err)
+		goto free_entry;
+
+	cfg = FIELD_PREP(IPFT_FLTFA, IPFT_FLTFA_REDIRECT);
+	cfg |= FIELD_PREP(IPFT_HR, NETC_HR_PTP_TRAP);
+	cfg |= IPFT_TIMECAPE | IPFT_RRT;
+	entry->cfge.cfg = cpu_to_le32(cfg);
+
+	err = ntmp_ipft_add_entry(&priv->ntmp, entry);
+	if (err)
+		goto free_entry;
+
+	np->ptp_ipft_eid[type] = entry->entry_id;
+
+free_entry:
+	kfree(entry);
+
+	return err;
+}
+
+static int netc_port_add_l2_ptp_filter(struct netc_port *np)
+{
+	return netc_port_add_ipft_ptp_entry(np, NETC_PTP_L2);
+}
+
+static int netc_port_add_l4_ptp_filter(struct netc_port *np)
+{
+	int err;
+
+	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV4_EVENT);
+	if (err)
+		return err;
+
+	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV4_GENERAL);
+	if (err)
+		goto del_ptp_filter;
+
+	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV6_EVENT);
+	if (err)
+		goto del_ptp_filter;
+
+	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV6_GENERAL);
+	if (err)
+		goto del_ptp_filter;
+
+	return 0;
+
+del_ptp_filter:
+	netc_port_del_ptp_filter(np);
+
+	return err;
+}
+
+static int netc_port_add_l2_l4_ptp_filter(struct netc_port *np)
+{
+	int err;
+
+	err = netc_port_add_l2_ptp_filter(np);
+	if (err)
+		return err;
+
+	err = netc_port_add_l4_ptp_filter(np);
+	if (err)
+		goto del_ptp_filter;
+
+	return 0;
+
+del_ptp_filter:
+	netc_port_del_ptp_filter(np);
+
+	return err;
+}
+
+static int netc_port_set_ptp_filter(struct netc_port *np, int rx_filter)
+{
+	int err = 0;
+
+	netc_port_del_ptp_filter(np);
+	np->ptp_rx_filter = HWTSTAMP_FILTER_NONE;
+
+	switch (rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+		err = netc_port_add_l2_ptp_filter(np);
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+		err = netc_port_add_l4_ptp_filter(np);
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+		err = netc_port_add_l2_l4_ptp_filter(np);
+		break;
+	default:
+		err = -ERANGE;
+	}
+
+	if (err)
+		return err;
+
+	np->ptp_rx_filter = rx_filter;
+
+	return 0;
+}
+
+int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct netc_switch *priv = ds->priv;
+	int rx_filter, err;
+
+	if ((config->tx_type != HWTSTAMP_TX_OFF ||
+	     config->rx_filter != HWTSTAMP_FILTER_NONE) &&
+	    !priv->tmr_dev)
+		return -EOPNOTSUPP;
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_ON:
+	case HWTSTAMP_TX_OFF:
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		rx_filter = HWTSTAMP_FILTER_NONE;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+		rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+		rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+		rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	err = netc_port_set_ptp_filter(np, rx_filter);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to set PTP filter");
+		return err;
+	}
+
+	WRITE_ONCE(np->ptp_tx_type, config->tx_type);
+
+	config->rx_filter = rx_filter;
+
+	return 0;
+}
+
+int netc_port_hwtstamp_get(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	config->tx_type = READ_ONCE(np->ptp_tx_type);
+	config->rx_filter = np->ptp_rx_filter;
+
+	return 0;
+}
+
+static void netc_port_txtstamp_twostep(struct netc_port *np,
+				       struct sk_buff *nskb)
+{
+	DECLARE_BITMAP(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
+	struct sk_buff *clone = skb_clone_sk(nskb);
+	struct sk_buff *skb, *skb_tmp;
+	unsigned long ts_req_id;
+
+	if (unlikely(!clone))
+		return;
+
+	bitmap_zero(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
+	spin_lock_bh(&np->tstamp_lock);
+
+	skb_queue_walk_safe(&np->skb_txtstamp_queue, skb, skb_tmp)
+		__set_bit(NETC_SKB_CB(skb)->ts_req_id, ts_req_id_bitmap);
+
+	ts_req_id = find_first_zero_bit(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
+	if (ts_req_id == NETC_NUM_TS_REQ_ID) {
+		dev_dbg_ratelimited(np->switch_priv->dev,
+				    "Port %d has no available ts_req_id\n",
+				    np->dp->index);
+		spin_unlock_bh(&np->tstamp_lock);
+		kfree_skb(clone);
+		return;
+	}
+
+	NETC_SKB_CB(nskb)->ptp_flag = NETC_PTP_FLAG_TWOSTEP;
+	NETC_SKB_CB(nskb)->ts_req_id = ts_req_id;
+	NETC_SKB_CB(clone)->ts_req_id = ts_req_id;
+	NETC_SKB_CB(clone)->ptp_tx_time = jiffies;
+	skb_shinfo(clone)->tx_flags |= SKBTX_IN_PROGRESS;
+	__skb_queue_tail(&np->skb_txtstamp_queue, clone);
+	if (!delayed_work_pending(&np->tstamp_timeout_work))
+		schedule_delayed_work(&np->tstamp_timeout_work,
+				      NETC_TXTSTAMP_TIMEOUT);
+
+	spin_unlock_bh(&np->tstamp_lock);
+}
+
+void netc_port_twostep_tstamp_handler(struct dsa_switch *ds, int port,
+				      u8 ts_req_id, u64 ts)
+{
+	struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct skb_shared_hwtstamps hwtstamps;
+	struct netc_switch *priv = ds->priv;
+
+	spin_lock_bh(&np->tstamp_lock);
+	skb_queue_walk_safe(&np->skb_txtstamp_queue, skb, skb_tmp) {
+		if (NETC_SKB_CB(skb)->ts_req_id != ts_req_id)
+			continue;
+
+		__skb_unlink(skb, &np->skb_txtstamp_queue);
+		skb_match = skb;
+		break;
+	}
+	spin_unlock_bh(&np->tstamp_lock);
+
+	if (!skb_match) {
+		dev_dbg_ratelimited(priv->dev,
+				    "Port %d ts_req_id %u which seems lost\n",
+				    port, ts_req_id);
+		return;
+	}
+
+	hwtstamps.hwtstamp = ns_to_ktime(ts);
+	skb_complete_tx_timestamp(skb_match, &hwtstamps);
+}
+
+bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
+			unsigned int type)
+{
+	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
+	u64 ts = NETC_SKB_CB(skb)->tstamp;
+
+	/* ts == 0 indicates the hardware did not capture the RX timestamp
+	 * of the frame.
+	 */
+	if (!ts)
+		return false;
+
+	hwtstamps->hwtstamp = ns_to_ktime(ts);
+
+	return false;
+}
+
+void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	int tx_type = READ_ONCE(np->ptp_tx_type);
+	u32 ptp_class;
+
+	NETC_SKB_CB(skb)->ptp_flag = 0;
+	ptp_class = ptp_classify_raw(skb);
+	if (ptp_class == PTP_CLASS_NONE)
+		return;
+
+	if (tx_type == HWTSTAMP_TX_ON)
+		netc_port_txtstamp_twostep(np, skb);
+}
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 020e3661b866..b214eeb202b0 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -53,10 +53,16 @@
 #define NETC_FDBT_AGEING_DELAY		(3 * HZ)
 #define NETC_FDBT_AGEING_THRESH		100
 
+/* PTP frames have a higher priority, so a higher priority is defined to
+ * prioritize matching (The higher the value, the higher the priority).
+ */
+#define NETC_IPFT_PTP_PRECEDENCE	0xf000
+
 struct netc_switch;
 
 struct netc_switch_info {
 	u32 num_ports;
+	u32 tmr_devfn;
 	void (*phylink_get_caps)(int port, struct phylink_config *config);
 };
 
@@ -66,9 +72,19 @@ struct netc_port_caps {
 	u32 pseudo_link:1;
 };
 
+enum netc_ptp_type {
+	NETC_PTP_L2,
+	NETC_PTP_L4_IPV4_EVENT,
+	NETC_PTP_L4_IPV4_GENERAL,
+	NETC_PTP_L4_IPV6_EVENT,
+	NETC_PTP_L4_IPV6_GENERAL,
+	NETC_PTP_MAX,
+};
+
 enum netc_host_reason {
 	/* Software defined host reasons */
 	NETC_HR_HOST_FLOOD = 8,
+	NETC_HR_PTP_TRAP   = 9,
 };
 
 struct netc_port {
@@ -89,6 +105,15 @@ struct netc_port {
 	 * require initialization.
 	 */
 	u32 ipft_hf_eid;
+
+	/* Serialize access to skb_txtstamp_queue */
+	spinlock_t tstamp_lock;
+	/* skb queue for two-step timestamp frames */
+	struct sk_buff_head skb_txtstamp_queue;
+	struct delayed_work tstamp_timeout_work;
+	int ptp_tx_type;
+	int ptp_rx_filter;
+	u32 ptp_ipft_eid[NETC_PTP_MAX];
 };
 
 struct netc_switch_regs {
@@ -143,6 +168,7 @@ struct netc_switch {
 	u32 num_bp;
 
 	struct bpt_cfge_data *bpt_list;
+	struct pci_dev *tmr_dev; /* The PTP Timer PCI device */
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
@@ -207,4 +233,20 @@ void netc_port_get_strings(struct dsa_switch *ds, int port,
 			   u32 sset, u8 *data);
 void netc_port_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data);
 
+/* PTP APIs */
+int netc_port_ptp_init(struct netc_port *np);
+int netc_get_ts_info(struct dsa_switch *ds, int port,
+		     struct kernel_ethtool_ts_info *info);
+void netc_port_purge_txtstamp_queue(struct netc_port *np);
+int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack);
+int netc_port_hwtstamp_get(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config);
+void netc_port_twostep_tstamp_handler(struct dsa_switch *ds, int port,
+				      u8 ts_req_id, u64 ts);
+bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
+			unsigned int type);
+void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb);
+
 #endif
diff --git a/include/linux/dsa/tag_netc.h b/include/linux/dsa/tag_netc.h
index fe964722e5b0..da200e3ba8ad 100644
--- a/include/linux/dsa/tag_netc.h
+++ b/include/linux/dsa/tag_netc.h
@@ -10,5 +10,26 @@
 #include <net/dsa.h>
 
 #define NETC_TAG_MAX_LEN			14
+#define NETC_PTP_FLAG_TWOSTEP			BIT(1)
+
+struct netc_skb_cb {
+	unsigned long ptp_tx_time;
+	u64 tstamp;
+	u8 ptp_flag;
+	u8 ts_req_id;
+};
+
+#define NETC_SKB_CB(skb)	((struct netc_skb_cb *)((skb)->cb))
+
+/**
+ * struct netc_tagger_data - NETC tagger/switch-driver shared operations
+ * @twostep_tstamp_handler: Called by the tagger when a two-step transmit
+ *	timestamp response is received, to deliver the timestamp to the
+ *	switch driver.
+ */
+struct netc_tagger_data {
+	void (*twostep_tstamp_handler)(struct dsa_switch *ds, int port,
+				       u8 ts_req_id, u64 ts);
+};
 
 #endif
diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
index df72a61796ad..d46576ae2f75 100644
--- a/net/dsa/tag_netc.c
+++ b/net/dsa/tag_netc.c
@@ -16,6 +16,8 @@
 #define NETC_TAG_TO_PORT		1
 /* SubType0: No request to perform timestamping */
 #define NETC_TAG_TP_SUBTYPE0		0
+/* SubType2: Request to perform two-step timestamping */
+#define NETC_TAG_TP_SUBTYPE2		2
 
 /* To_Host NXP switch tag */
 #define NETC_TAG_TO_HOST		2
@@ -29,6 +31,7 @@
 /* NETC switch tag lengths */
 #define NETC_TAG_FORWARD_LEN		6
 #define NETC_TAG_TP_SUBTYPE0_LEN	6
+#define NETC_TAG_TP_SUBTYPE2_LEN	6
 #define NETC_TAG_TH_SUBTYPE0_LEN	6
 #define NETC_TAG_TH_SUBTYPE1_LEN	14
 #define NETC_TAG_TH_SUBTYPE2_LEN	14
@@ -40,6 +43,7 @@
 #define NETC_TAG_IPV			GENMASK(4, 2)
 #define NETC_TAG_SWITCH			GENMASK(2, 0)
 #define NETC_TAG_PORT			GENMASK(7, 3)
+#define NETC_TAG_TS_REQ_ID		GENMASK(3, 0)
 
 struct netc_tag_cmn {
 	__be16 tpid;
@@ -48,6 +52,23 @@ struct netc_tag_cmn {
 	u8 switch_port;
 } __packed;
 
+struct netc_tag_tp_subtype2 {
+	struct netc_tag_cmn cmn;
+	u8 ts_req_id;
+} __packed;
+
+struct netc_tag_th_subtype1 {
+	struct netc_tag_cmn cmn;
+	u8 host_reason;
+	__be64 timestamp;
+} __packed;
+
+struct netc_tag_th_subtype2 {
+	struct netc_tag_cmn cmn;
+	u8 hr_tsreq_id;
+	__be64 timestamp;
+} __packed;
+
 static void netc_fill_common_tag(struct netc_tag_cmn *tag, u8 type,
 				 u8 subtype, u8 sw_id, u8 port, u8 ipv)
 {
@@ -97,15 +118,60 @@ static void netc_fill_tp_tag_subtype0(struct sk_buff *skb,
 				NETC_TAG_TP_SUBTYPE0_LEN);
 }
 
-/* Currently only support To_Port tag, subtype 0 */
+static void netc_fill_tp_tag_subtype2(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	u8 ts_req_id = NETC_SKB_CB(skb)->ts_req_id;
+	struct netc_tag_tp_subtype2 *tag;
+
+	tag = netc_fill_common_tp_tag(skb, ndev, NETC_TAG_TP_SUBTYPE2,
+				      NETC_TAG_TP_SUBTYPE2_LEN);
+	tag->ts_req_id = FIELD_PREP(NETC_TAG_TS_REQ_ID, ts_req_id);
+}
+
 static struct sk_buff *netc_xmit(struct sk_buff *skb,
 				 struct net_device *ndev)
 {
-	netc_fill_tp_tag_subtype0(skb, ndev);
+	u8 ptp_flag = NETC_SKB_CB(skb)->ptp_flag;
+
+	/* Fast path: the overwhelming majority of frames are not PTP frames */
+	if (likely(!ptp_flag)) {
+		netc_fill_tp_tag_subtype0(skb, ndev);
+		return skb;
+	} else if (ptp_flag == NETC_PTP_FLAG_TWOSTEP) {
+		netc_fill_tp_tag_subtype2(skb, ndev);
+	} else {
+		kfree_skb(skb);
+		return NULL;
+	}
 
 	return skb;
 }
 
+static void netc_rx_tstamp_process(struct netc_tag_th_subtype1 *tag,
+				   struct sk_buff *skb)
+{
+	u64 ts = get_unaligned_be64(&tag->timestamp);
+
+	NETC_SKB_CB(skb)->tstamp = ts;
+}
+
+static void netc_twostep_tstamp_process(struct netc_tag_th_subtype2 *tag,
+					struct sk_buff *skb)
+{
+	u8 ts_req_id = FIELD_GET(NETC_TAG_TS_REQ_ID, tag->hr_tsreq_id);
+	struct dsa_port *dp = dsa_user_to_port(skb->dev);
+	u64 ts = get_unaligned_be64(&tag->timestamp);
+	struct netc_tagger_data *tagger_data;
+	struct dsa_switch *ds = dp->ds;
+
+	tagger_data = ds->tagger_data;
+	if (unlikely(!tagger_data->twostep_tstamp_handler))
+		return;
+
+	tagger_data->twostep_tstamp_handler(ds, dp->index, ts_req_id, ts);
+}
+
 static int netc_get_rx_tag_len(int type, int subtype)
 {
 	/* Only NETC_TAG_TO_HOST and NETC_TAG_FORWARD are expected in RX,
@@ -129,11 +195,22 @@ static struct sk_buff *netc_rcv(struct sk_buff *skb,
 	struct netc_tag_cmn *tag_cmn;
 	int tag_len, sw_id, port;
 	int type, subtype;
+	void *tag;
 
-	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN)))
+	/* eth_type_trans() pulled ETH_HLEN bytes, so skb->data sits 2 bytes
+	 * past the start of the switch tag (past the TPID) and skb->len is
+	 * ETH_HLEN bytes shorter than the original frame length. The longest
+	 * switch tag is NETC_TAG_MAX_LEN (14) bytes, but since 2 of those
+	 * bytes are already behind skb->data, only NETC_TAG_MAX_LEN - 2 bytes
+	 * need to be in the linear buffer. For the To_Host subtype 2 response
+	 * frame, whose total length is only 26 bytes with no payload after the
+	 * tag, this check is the only guard against a too-short frame.
+	 */
+	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN - 2)))
 		goto err_free_skb;
 
-	tag_cmn = dsa_etype_header_pos_rx(skb);
+	tag = dsa_etype_header_pos_rx(skb);
+	tag_cmn = tag;
 	if (ntohs(tag_cmn->tpid) != ETH_P_NXP_NETC) {
 		dev_warn_ratelimited(&ndev->dev, "Unknown TPID 0x%04x\n",
 				     ntohs(tag_cmn->tpid));
@@ -156,17 +233,50 @@ static struct sk_buff *netc_rcv(struct sk_buff *skb,
 	if (!skb->dev)
 		goto err_free_skb;
 
+	/* skb->cb may be used to store hardware RX timestamp, so it must
+	 * be cleared before processing to avoid data pollution from the
+	 * previous layer.
+	 */
+	NETC_SKB_CB(skb)->tstamp = 0;
+
 	type = FIELD_GET(NETC_TAG_TYPE, tag_cmn->type);
 	subtype = FIELD_GET(NETC_TAG_SUBTYPE, tag_cmn->type);
 	if (type == NETC_TAG_FORWARD) {
 		dsa_default_offload_fwd_mark(skb);
 	} else if (type == NETC_TAG_TO_HOST) {
-		/* Currently only subtype0 supported */
-		if (subtype != NETC_TAG_TH_SUBTYPE0)
+		switch (subtype) {
+		case NETC_TAG_TH_SUBTYPE0:
+			break;
+		case NETC_TAG_TH_SUBTYPE1:
+			/* To_Host Subtype 1 tag is 14 bytes, ensure it and the
+			 * EtherType behind it are fully present in the linear
+			 * area before netc_rcv() calls dsa_strip_etype_header()
+			 * to strip the tag.
+			 */
+			if (unlikely(!pskb_may_pull(skb,
+						    NETC_TAG_TH_SUBTYPE1_LEN)))
+				goto err_free_skb;
+
+			tag = dsa_etype_header_pos_rx(skb);
+			netc_rx_tstamp_process(tag, skb);
+			break;
+		case NETC_TAG_TH_SUBTYPE2:
+			/* This skb is a hardware-generated response to a
+			 * two-step transmit timestamp request. The tag
+			 * driver must free the skb after processing.
+			 */
+			netc_twostep_tstamp_process(tag, skb);
+			consume_skb(skb);
+			return NULL;
+		default:
+			dev_warn_ratelimited(&ndev->dev,
+					     "Unsupported To_Host subtype: %d\n",
+					     subtype);
 			goto err_free_skb;
+		}
 	} else {
 		dev_warn_ratelimited(&ndev->dev,
-				     "Unexpected  tag type %d\n", type);
+				     "Unexpected tag type %d\n", type);
 		goto err_free_skb;
 	}
 
@@ -190,16 +300,48 @@ static void netc_flow_dissect(const struct sk_buff *skb, __be16 *proto,
 	int type = FIELD_GET(NETC_TAG_TYPE, tag_cmn->type);
 	int tag_len = netc_get_rx_tag_len(type, subtype);
 
-	/* The RX minimum frame length of the NETC switch port is 64 bytes,
-	 * and the frame is received by the ENETC driver. From the hardware
-	 * perspective, the receive buffer of RX BD is at least 128 bytes,
-	 * so the switch tag header is guaranteed to be in the linear region
-	 * of the skb.
+	/* The CPU port of the switch is connected to the ENETC, so the frame
+	 * is received by the ENETC driver. From the hardware perspective, the
+	 * receive buffer of RX BD is at least 128 bytes, so the switch tag
+	 * header is guaranteed to be in the linear region of the skb.
+	 *
+	 * When the subtype of the frame is NETC_TAG_TH_SUBTYPE2, it indicates
+	 * the frame is a hardware generated timestamp response, which is only
+	 * 26 bytes (DMAC + SMAC + tag), so the frame has no payload after the
+	 * tag. Therefore, there is no need to parse the protocol and offset.
+	 * For other types of the frames, they are all received from the switch
+	 * ports, and the RX minimum frame length of the port is 64 bytes,
+	 * frames shorter than 64 bytes will be discarded by the hardware and
+	 * will not be received by the software.
 	 */
+	if (subtype == NETC_TAG_TH_SUBTYPE2)
+		return;
+
 	*offset = tag_len;
 	*proto = ((__be16 *)skb->data)[(tag_len / 2) - 1];
 }
 
+static int netc_connect(struct dsa_switch *ds)
+{
+	struct netc_tagger_data *tagger_data;
+
+	tagger_data = kzalloc_obj(*tagger_data);
+	if (!tagger_data)
+		return -ENOMEM;
+
+	ds->tagger_data = tagger_data;
+
+	return 0;
+}
+
+static void netc_disconnect(struct dsa_switch *ds)
+{
+	struct netc_tagger_data *tagger_data = ds->tagger_data;
+
+	kfree(tagger_data);
+	ds->tagger_data = NULL;
+}
+
 static const struct dsa_device_ops netc_netdev_ops = {
 	.name			= NETC_NAME,
 	.proto			= DSA_TAG_PROTO_NETC,
@@ -207,6 +349,8 @@ static const struct dsa_device_ops netc_netdev_ops = {
 	.rcv			= netc_rcv,
 	.needed_headroom	= NETC_TAG_MAX_LEN,
 	.flow_dissect		= netc_flow_dissect,
+	.connect		= netc_connect,
+	.disconnect		= netc_disconnect,
 };
 
 MODULE_DESCRIPTION("DSA tag driver for NXP NETC switch family");
-- 
2.34.1


