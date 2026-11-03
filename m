Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47A3606A32D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AisgGJAy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJX4k6lvTz3cPK;
	Tue, 03 Nov 2026 13:06:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793671606;
	cv=pass; b=j0tDGV7baT/9XUljVLK4IVCh9GOY0Mc2xdKiOmSglYnnD2I6MVc6NjsA1cJwk5SnLftKQAKYN73ZeCvZTtoceTKMpmD/N679AYHUBoakel4obZE4Uw2iQRP14Si84mV2UozuNQ+guW4ZKqUcgueHog0XabFsFFKhqqb+GljTMvC73bVNpdVC8uY88pWeVSJSK0Weq4Buph1AiVdiyBwbTRFWWrFzf32y6xwak38eUaismd8SKhW1EgmYS4moR9DhurRCwpx5i5p/rO2Hud7fFvqIppVipOzU77/xz7P4XHSFzDI9kputdcSWOyGCoxRMG2pEaw1xVCRHPiiUIqZSyA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793671606; c=relaxed/relaxed;
	bh=t5pTCfUuYhoWGHznkKdjfHFIvH0PZ+st2aFQRFV38Ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rb7IRxZrjJ6PbHxjs0oI2f6qACJdf1J2WdfeskPmhxVElJtFMWXk4AcKYozLo4hSJLVhb+SSLUpwE8ecgjq+5jUJ2EbUT6YMROqOCXx0ezey50E4o93vmRS8KrBasTLNZhhSC31H8+4X2hBnC40v/IYG3cPiUS0ctrlAhdUCnM8bgrR+Bk57qetvaCp5Kl83zBeMnH1tFU/RRPmJSqBaDoxk7SaGcwPETdKEZdxGKhOigxk3EgTty983Yj0lLT5oYtIUxHaoWMCTMYs7OIA7my64xtIDGmKYRu6WbDyN4Ks9PufZVBOzs7jymX8T6QndJCS8QoXGGm4SjPns134jbA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AisgGJAy; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AisgGJAy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJX4j6ysqz3cPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 13:06:45 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGHliZU8HlMSHGi4VJpJgEOvq0ftYL3bdQC/eVhnzn2/UBRVMT4dsxCXxkY4/EK3lgnLBFmFdRsdso6JuknpIfbq+tmK3575Ipu8KVPMhkxXLH7NhA+KBYn5ywr1EGx+ZthToDXzNVi+Fv6OYCFUYMZQ/fka37TQJdEymADZwe93BhnJwfdmjz7h9/a4+F0yFOKGBTmDVR9z/os/1bY8dEW/cC3BQwZCI+3EsMWj95wIh5f2GwMZhb55EqX2TubUQj4zAiPxrmNFp3HAv3HeFr451b6PCzEJ9R3XkQsicO2B/ww2nsBmo2BVONlbyeujEB+QLrGI4a26fjDhsoi9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5pTCfUuYhoWGHznkKdjfHFIvH0PZ+st2aFQRFV38Ps=;
 b=VKP7IYmZC2DmJtcbQdlqzwe4eTL4uYMO1zaAXB1Gw9owCOSiQo5KekIoUkB9QLYV4IkhZg4WXgcX8mHpIK0tj/3F1d0g/cFGm2pOqx6IvaWW9zv90p/goWF1Dbl2TJsHAkzE4KVP2RD0tnPG6aT2iEgMih9JC9tYCUkG5kLcZH+5uJtNKr55SD/KW+AVtPR/84bOmHgEw1Sb/ru7q7d8SunSL9VOZwvtgRtAgt/BRpFbC2612S+SrRN7qX1sEIZ99BJR2w65QmwXvX51LqxJpkANYuuQXyoga5wR5zCEdk8hk7LDvrAAGiUluvLEevJHzzkjJis8VNUrnL+RgLuGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5pTCfUuYhoWGHznkKdjfHFIvH0PZ+st2aFQRFV38Ps=;
 b=AisgGJAya86TSeCQcvnzEWJ+hKWBXaIWVn3zSApM5smOxwR63w8uAqQ0dRTARqO6h/cDTT7IQtALx05LPfk/rJRsiWUnXkyF2ONZxkvLwK0ktt7swL/fAI/dn4Fd/ymyIG/QRPoFULC9ihR0PNQm0QICwuyrp/4prAIpQCROSoD1ti0N04aslT0v4lExPMzxCkZmVZTygS4vnHuyT6rE6X8DPd6y1d/aHyx6ug8KBx/BV6Dnji9WBk1gNl2MiDHZI6nNcFnkKkpRMzHWty/teP5kjzJkdd4RqfCuJgwe00+vWlFL3YglqN4PeFK24REL46QMF1lFk3GEh3MDZn8dfg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM7PR04MB7094.eurprd04.prod.outlook.com (2603:10a6:20b:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:06:27 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:06:27 +0000
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
	richardcochran@gmail.com,
	linusw@kernel.org
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 net-next 6/9] net: dsa: netc: check return value of ntmp_ipft_delete_entry()
Date: Tue,  3 Nov 2026 10:10:21 +0800
Message-Id: <20261103021024.3121936-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
References: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM7PR04MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0e80e3-cfad-4eb6-2784-08df394f118d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|19092799006|921020|261021123027099003|11063799006|56012099006|261009223027099003|261028144727099003|261026140227099003|261022075727099003|261026121527099003|261021121427099003|261022105027099003|10067099003|18002099003|22082099003|261102123227099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	TIyQrTv+SYZRlWrRkdav4NgYyRZ0hxqao6yiB+w2AbCJ+j5yvnRj/AfO8SNmicX0nHNcwA0DOuTHi00YnbkDibpWvo7I0ZoK2iV9V5P5nP0FWEK2UkSynroM33WhCekn3RnTTMSeC6MDceS+k96yusC8oEXgaG1d4guRsc1haQRPuXbzc8eb6uIKKmYpbjIZCo+up4K7lP3UwEFxZvzv9rQGxhWk6vguyGwHK1yY4toYBvfGMOKeMfgdAw6uxqKizk/rFzgHU4XIW6JP73ysyU+Qrfc5y/+YkCJdkOz6YS8zTc/pCDhznwUPuISx9qSz6MNuQ3BCBx0pvXKBm4XMgt0aueN+Nara3y2kcjeadwWcPKFspyV/bxdCwTY1u5wt7FX+22kg5mN8fRWCMv8MyxNGVxeMWt2F/Kkth0oAiDd8f6/ubL3h1690BN4FDU4rtoYsZfrUldzwOHHtRZppCEd1MSeqnVJQQffBY08bMpews5K3xxtRo6yUYibpqiQfp6oVBsh1hUHdocsDENOgkRV/sTQgXbz/ezQ/7d1+L7OdCCEogkk6KYVjvAn3IpzkXVgJQNBids71NRurbD66ub09XJDjusGI49ykWVSZ3YY7upDBLsh3c4zi0Kuq55jFs3HdSOGFcXtzOKNeKb0YDYoC/jqPT2QNcpv7oyDCw6ReVh73zhbbi7WfiIaanSxiLXZVIJtdYB3W5pPBfVLVMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(19092799006)(921020)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026140227099003)(261022075727099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(261102123227099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?syTdQkv2fQpvtuSUu0eJkWfqTNHtVRLdxf2+OA+dvNKn6y3DxaBcfSXCa6fB?=
 =?us-ascii?Q?EWwwiOLQmFn2/4dx2mw702zogtU8Os6yIqifjEw1TlvTyEjsPxCC6naYIt/P?=
 =?us-ascii?Q?wfx7u8Lpe988NIbkh0A0CdmMHsF5UKoSrnFj+5Q1YHli8W2t9fg12OSFE4XU?=
 =?us-ascii?Q?qE0b3roRVtQpfhc+rEMceB0k9z3OAgBd+6IjMxJTtUXCR043x3I+1yQhKjqj?=
 =?us-ascii?Q?1zJQwQwwrvjGjxBhPID7cIbx5wApgTlM9LwkvwbLku1Kj0M/bAq82pNVJiNd?=
 =?us-ascii?Q?gIioJm8hnv+km6ehd11ISfxg5OQXmijcEAFnbCRoEtP49mDfaeLtyZTUoJY1?=
 =?us-ascii?Q?rjzjtb2kEzFWoilbltOLs28N4iR/VowmVs9kEsKPqsUYOL3bQnIX9nz4wRP0?=
 =?us-ascii?Q?BkbSW9LFq8GY06XY2w7KoXDedxMsOSBkJ6Qxnrx9F1xsMTFGgq5b/j39rZe5?=
 =?us-ascii?Q?hIMTHf+gCKMW2ck5KWCHiSWqg4BdyryO3eLQVTG0apYUZX7dKts5t5MoAKHQ?=
 =?us-ascii?Q?PZgOY3m38knDSleiyVzVkLca4ngaJ4y7NUFJmVw3E2y51SnaK0PVQwMBB8et?=
 =?us-ascii?Q?LelA6rDuzhOEqiOVF2RUKvs7fOAgeGjLFJ1HBFyseNzI8IYmpGf4x2olGKpw?=
 =?us-ascii?Q?zb1z4IjW7TAl5truQmTCBwl1KkwLYl4qnmm81DVI/EeeLkBF2MevKICv9mk3?=
 =?us-ascii?Q?hiAkaqoyOn8dxXdby0cairWUwoyZ0kqT5/Smbnil1LV4pSo1I8zWYQVzdag/?=
 =?us-ascii?Q?sF297SJaKJ/o/sMZ6Ufp4rKvk5M9ugsyIKDnP6J+GlZhUs17RZwuhUGgIHXf?=
 =?us-ascii?Q?0zAy7ghVZGp5a7o3kiRtQiYmEWvCMDl7U6GP5ELRhppjjr1bqZeovtHjQ85p?=
 =?us-ascii?Q?IHahBi06nMSpxqpedAHNCjFvkH/o5SuWgk8arQjnuPelioovhHGujP6/HFHq?=
 =?us-ascii?Q?Hh4g8355PuWYjc1MhaW9B8v5LHLNvMIlntq/mWfge51701eAYIdJPAGXP+Gr?=
 =?us-ascii?Q?lBvWW1FFMckEbJVNqQPPe85ot+Zx7e+0XmECPo1XnWvxDA290V98iMGlr+H2?=
 =?us-ascii?Q?S5goUY3GdwFcOrV0MBb6zt5yWJeggtrXFb/I03Wg2RU+c191h2DEZ49MJttT?=
 =?us-ascii?Q?oHCMnYkyOP+ywCzgmT9QsRFRGt8CgVoO/58SCbbITc96nxG3F6oE2gJZzJEe?=
 =?us-ascii?Q?6MKjDv17Ecr5ZzzLdvBmlWfJPyZ4Qyns6m3owJaE7WGNj6ySHPCOp7YyY3vR?=
 =?us-ascii?Q?Ms9XbQFyD55sposr2Cti7KbDeZ3IoO0bVrWcUL5KD0LxDy6lt0sUT8i+bH2q?=
 =?us-ascii?Q?MYXtqUFozO8Oy4iqLwBhwp1rjZDGLcR8uEpOXagWkJXjMmYLuU1CuLnLqbZg?=
 =?us-ascii?Q?EbGd2AXWDQUz5854iSpK2r81ZWXqLUMwwVsAg9YtTAFqs30QlaR0XbgLCX1p?=
 =?us-ascii?Q?IpTmgd+On27pM0aViToFWfrsGP4LEyfE9DoVMKnJPnrdZLL/qapM9dfM9Bby?=
 =?us-ascii?Q?0aqP7xA9UjtP82QWSn5JO26bRHqk6v3ciG+QijRak62yPYKBdg4FMCQaCPI3?=
 =?us-ascii?Q?6geMsWJ4BRdl8TqeJ+GYt1+DoHXIkDe7lKYf74JhueIc+bA3Cq5+32h9yNMB?=
 =?us-ascii?Q?29/WLU1FKWAM+dLqjfWDcshDN+SoxyHtunyseIJjeByF48HZ12akQ//KftwZ?=
 =?us-ascii?Q?KPjfJWNVPZAdbYNlBgJhaX2Bmanmq4avPrWbz81ASlASd30dX21th6Ot0dg6?=
 =?us-ascii?Q?zI0gYRoNLY9tAHQefV8Jmdpb86991qQyyQsSn1aKn4HkrlD5ODDp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0e80e3-cfad-4eb6-2784-08df394f118d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:06:27.0661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMbgYOPiisx8kV4PsgTUBJat12HTbtDiOL82MslFTVMqBLKKtQkpQFpC0nN2PS6jlkl0Wko9ROt78M5Vt3SzZwUWIsfFsSH25Ha9wbtVY+snW3U9l05pIB9PPnvsnFcd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

The driver ignored the return value of ntmp_ipft_delete_entry(), so a
failed deletion left the IPFT entry untracked and impossible to clean
up later. IPFT is going to serve more features, such as trapping PTP
packets and flow policing, so make the deletion path robust to prepare
for these future uses.

To this end, propagate the error to the callers and update the driver
state only after the entry has really been deleted, so that the
software state always stays consistent with the hardware.

Once the deletion can fail, the order in which a rule is replaced also
needs to change. Since IPFT does not support in-place updates to the
KEYE element, replacing an existing rule requires deleting the old
entry and then adding the new one. Keeping the previous add-then-delete
order means that if the delete fails, a port would have to track two or
more stale host flood rules, which needlessly complicates the driver.
So switch to a delete-then-add order instead. This order is not
perfect: between the delete and the add there is a brief window in
which packets that would have matched the rule find no match and are
dropped. The window is very short and its impact is acceptable, so this
is a deliberate trade-off in favour of simpler software.

Another issue is that if adding a new rule fails, host flooding will be
disabled indefinitely. However, there is no good way to fully resolve
this, because port_set_host_flood() returns void and the upper layer is
not aware of the error. So if this corner case does occur, log an error
to help users find out why host flooding is not working.

Note that, a delete failure has never been observed in practice and
is highly unlikely to happen, so this patch is an improvement over the
previous approach rather than a fix for an issue seen in the field.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c | 91 +++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 31 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index c946a2b2674e..be37e29cd650 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1820,14 +1820,8 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	u32 cfg;
 	int err;
 
-	if (!uc && !mc) {
-		/* Disable ingress port filter table lookup */
-		netc_port_wr(np, NETC_PIPFCR, 0);
-		np->uc = false;
-		np->mc = false;
-
+	if (!uc && !mc)
 		return 0;
-	}
 
 	host_flood = kzalloc_obj(*host_flood);
 	if (!host_flood)
@@ -1875,32 +1869,37 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	return err;
 }
 
-static void netc_port_remove_host_flood(struct netc_port *np, u32 entry_id)
+static int netc_port_remove_host_flood(struct netc_port *np)
 {
 	struct netc_switch *priv = np->switch_priv;
-	bool disable_host_flood = false;
+	u32 entry_id = np->ipft_hf_eid;
+	int err;
 
 	if (entry_id == NTMP_NULL_ENTRY_ID)
-		return;
+		return 0;
 
-	if (np->ipft_hf_eid == entry_id)
-		disable_host_flood = true;
+	/* The command BD ring is always enabled here, with the ring
+	 * enabled, the hardware completes a command well within 1 ms,
+	 * so -ETIMEDOUT cannot happen here. Any error therefore means
+	 * that the entry has not been deleted, so keep tracking it.
+	 */
+	err = ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
+	if (err)
+		return err;
 
-	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
+	np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
+	np->uc = false;
+	np->mc = false;
+	netc_port_wr(np, NETC_PIPFCR, 0);
 
-	if (disable_host_flood) {
-		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
-		np->uc = false;
-		np->mc = false;
-		netc_port_wr(np, NETC_PIPFCR, 0);
-	}
+	return 0;
 }
 
 static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 				     bool uc, bool mc)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
-	u32 old_entry_id;
+	int retry_num = 0;
 
 	/* Do not add host flood rule to ingress port filter table when
 	 * the port has joined a bridge. Otherwise, the ingress frames
@@ -1908,7 +1907,12 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	 * will be redirected directly to the CPU port.
 	 */
 	if (dsa_port_bridge_dev_get(np->dp)) {
-		netc_port_remove_host_flood(np, np->ipft_hf_eid);
+		if (!netc_port_remove_host_flood(np))
+			return;
+
+		dev_err(ds->dev,
+			"Failed to delete host flood rule on bridge port %d\n",
+			port);
 
 		return;
 	}
@@ -1917,19 +1921,33 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 		return;
 
 	/* IPFT does not support in-place updates to the KEYE element,
-	 * we need to add a new entry and then delete the old one. So
-	 * save the old entry ID first.
+	 * we need to delete the old one and then add the new rule. If
+	 * the deletion fails, return immediately.
 	 */
-	old_entry_id = np->ipft_hf_eid;
-
-	if (netc_port_add_host_flood_rule(np, uc, mc)) {
-		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
+	if (netc_port_remove_host_flood(np)) {
+		dev_err(ds->dev,
+			"Failed to delete old host flood rule on port %d\n",
 			port);
+
 		return;
 	}
 
-	/* Remove the old host flood entry */
-	netc_port_remove_host_flood(np, old_entry_id);
+	/* Restoring the previous configuration is pointless because
+	 * .port_set_host_flood() returns void, so the upper layer cannot
+	 * detect the error and the RX flags have changed. Furthermore, we
+	 * cannot guarantee that we can successfully restore the previous
+	 * state.
+	 */
+retry:
+	if (netc_port_add_host_flood_rule(np, uc, mc)) {
+		if (retry_num++ < 2) {
+			usleep_range(100, 110);
+			goto retry;
+		}
+
+		dev_err(ds->dev,
+			"Failed to add host flood rule on port %d\n", port);
+	}
 }
 
 static int netc_single_vlan_aware_bridge(struct dsa_switch *ds,
@@ -2094,6 +2112,8 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
+	bool uc = np->uc;
+	bool mc = np->mc;
 	int err;
 
 	if (!bridge.num) {
@@ -2105,6 +2125,12 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	if (err)
 		return err;
 
+	err = netc_port_remove_host_flood(np);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to delete host flood rule");
+		return err;
+	}
+
 	netc_port_set_mlo(np, MLO_NOT_OVERRIDE);
 
 	if (br_vlan_enabled(bridge.dev))
@@ -2118,8 +2144,6 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, vlan_unaware_pvid);
 
 out:
-	netc_port_remove_host_flood(np, np->ipft_hf_eid);
-
 	if (atomic_inc_return(&priv->br_cnt) == 1)
 		schedule_delayed_work(&priv->fdbt_ageing_work,
 				      READ_ONCE(priv->fdbt_ageing_delay));
@@ -2129,6 +2153,11 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 disable_mlo:
 	netc_port_set_mlo(np, MLO_DISABLE);
 
+	if (netc_port_add_host_flood_rule(np, uc, mc))
+		dev_err(ds->dev,
+			"Failed to restore host flood rule on port %d\n",
+			port);
+
 	return err;
 }
 
-- 
2.34.1


