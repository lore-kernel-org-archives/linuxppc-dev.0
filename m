Return-Path: <linuxppc-dev+bounces-27679-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6280BC88E75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 07:26:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmPL62kBPz3bcB;
	Fri, 18 Sep 2026 17:25:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789716350;
	cv=pass; b=MWq81cCKba1go84FfPJYN5I9BjjWn7nN3/Mf70fc55FnkabwjhXUsRRWe8elXbJvc5smB8Ht22GUl1rZLCrFz2wguPbWqc7w2N+qnsNshiPhO2LHwmmvF5VUTvkXdjnY0OkoH9kmKtuZENTjzMPPUwgLd1MDg7Fa3HgEgD6dVcvmOowpwkfUTBZfq2NvJQNiJrxR0RoL+NEAzOenMEUDukfDzPGC+YCGeIZr8ctUkWQUhGPLoZ6Rag5o1cd4JPM8jnbiNCMKY8nnUL7jBPQmt2lgEqZhfi1qXceZfwaGMQ5Ci6aloLxLuJcRLuu2zyUjGBzZQDtGpKm724V1tywkKg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789716350; c=relaxed/relaxed;
	bh=c7Auw7oJIgSbMgfNfY6LxLODD7AhWVcdBjfxjXrmpe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VaL51DaC+ol6uaK0HYv086MbVlL/gEKqmorzwVaqHGDsQqGgKzCLPqsBMmkRF9InuKqkKevYGju7y3ct0LVeSPs0PHMZv2VxJyMjjOEZL2QvGK6Ev9yUAty5jWQGs/3cyY87U1ysl7WrNH6qX+zkB4qwKJtBk6NRvEU1ZzhZ/gRDcNj027QcUmiI4cSwHD8vytXp18F1cA2tGKSuMSVbHnAsPdK0kiXZMGA/ioaaYnQQ6Bvw2mq2NgyZii8A/Xo9eU2ITPXVlnBXr6yXCoOsG8Jm3xObtCmmT69S7jOd9CBk9F8jOEIOBrrnjkMZUB1t7mMw6vu+RZZXuYj+0+fTzQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=N9zeCiig; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=N9zeCiig;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmPL44fSHz3bfP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:25:48 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUTqXjgXlQko1MsLnx6+YG7Y+4BluVfq0s89He5XqFVLYglrymf3Ugo8D020DTttx0M2+hr+lql7cyVtss3+U0SJWQ3YP2PYPvczSby5qZMAoA/IfFPIEfbDSN9OYYbuaOSmzfT3yKIdKyksK/IsZdBQN1iY3KhdAPXTWyP7C69FjGfTB2VxSpaNwH5LEmhHc5BRpZXb0Z6xN4rQ+sPtSuFByZ7WY+wpNhICODel/8UTW5/Anm8mEeRoW6W5+1zNyJbkc3rZCTJtiC4ngZ4rhrCpObD4/Ih4Prmy8Oad70QpjrLs63MPSI+MM4jRXV+hR42v2Z5ZVVsGTRE5jhPImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7Auw7oJIgSbMgfNfY6LxLODD7AhWVcdBjfxjXrmpe4=;
 b=tFr6gBR1EVB7YI7+1U/28ps5uiHLA5HDAXm9EPjotOCJnW6h5cE8AjTjEtub0GPnkDyvSWVYrtkiIqynQXE3qHwjDwOzEnWcYExe72P+bk3sUIAW9vbKfMVi6uA+apYY9RS3DGjJk8V5V8InKJ0qVIlD0bmMsHs/7nPkCI1hRaFHRLgN86qbGypWg3r2tEjvzKwryLhMLTrbPitDtyf/1KbWtwQoT0ehzS3gI6nl0Zf9DWr/HdPNMORkvGiKcVML5kO8WAkdx+68qFpeDMLuOyZd7Mc7H/UmY7PL1qmRkY+OEuf+OdbkLRoTeMLW9V4X0Sabff2bvIy9ufo/I6kNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7Auw7oJIgSbMgfNfY6LxLODD7AhWVcdBjfxjXrmpe4=;
 b=N9zeCiig8mvYKydGsBbGtGa2+XOorumPOkLMzuJDPe2WAwRPaWjS7+4Ut/cJmUi8BwZiHpmFSao9Wt0aFQZrqGaRe2XNIxYP/6SOMOWDJ4wRMSHxZnxLDsPFbzIjjlZJuoawOSIgP6/CXFwZoHoubzedt/oJ/Tcfdz9ugUeBu8U2vlweScztoMMqNShKyIyKMJouantNWebQ5P7kPOd4Pe2osf7AdCMBB6zy2dINCrMPGtjLGyn3/zIERqyYmPhrs0RH1xwpEZzJ1rESJtSYf6OqFvdSZbqmebMSpQXjk3tU+Tus5P2vCtzoSGlw/DYDaUwWgol9vSc0ifYnC8mwRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 07:25:35 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 07:25:34 +0000
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
	linusw@kernel.org,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 8/8] net: dsa: netc: add PTP one-step timestamping support
Date: Fri, 18 Sep 2026 15:28:52 +0800
Message-Id: <20260918072852.501420-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918072852.501420-1-wei.fang@oss.nxp.com>
References: <20260918072852.501420-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0245.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::8) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e03512-2188-4503-66a3-08df1556075b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	dlYsqaZKdr04zeuwPpAG/v+UynMqySnbItHxNWPkWqE5qI6ONcgUxvHwF5XZUZS2bX5afbYKG0Gcxhm/k7E2GwpNupAfquCTflYuTedeSjF8+sVFzLJe58SE868ZI1nl/74JVHdtlag7avXfcQPd6Yia9MVmfhNiP7oE1PL72DtjwFiR1TC5VvlYGONiD/erFpwQY/cveiMS8WI4cjbHi0K8/TbIgIreLMOBVZKYgSOv5QtytIWQ8IBwJdnDcWiISfQ6PtYQPnZ9GUe6C/TpHNvBiCPZgq624L4hqqZLWzQJKtDl2t0SOc4fzlncy6L5GHJbykQHDP77G29AXWgsrTwxJeM71C2dikvicdoJqHLQ0YgLnOfxrR33uqN+5l3XrBSew6rtkHLrPCLblXinB+V2fw4qOYOW6LWet5LY1TBPj3JnpdVtMgUHUiUiytzzKjNUZEflXgBjxr2Xu9tIrVl5PmIO8EBezXawfwdG4tcK570kV7oXAULyj95Wl8lsqtoWpm37HHW24ViZaA/qfER/a4gh5ascM+ne2X3xZkpJc6gStgh9XgqT1BGa7r5CMSzuWlTvCANzscRXyivBjRnlo27NZTaJDby8qA4quY1q5hu2qi41oXIem8tvG7CePgveh0XlXBSXRy9wskWBWD3ZI5k+8Rf4OZG0+yaKwQ27shvlM8Zf+mZIZQHmLv6tmkwD6ZntwjNHt1eaEIc1JA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1y+nYddm8GIGRRVGH1/533tO8LfYiEbLC5KN6wVuDfH8rnJgXAw7hN+EtQ0m?=
 =?us-ascii?Q?1j5NhdLRtpSULIJ5fKLHN0wxmqccz6a6vKVozGA+nzRDUI7gt9WGQOSwtWiW?=
 =?us-ascii?Q?5C3Uj6DPCTxVAkQ9GiK3/KMmFTj08DmHZDHsBU8zRh+sDLRcN5bjn1chQgky?=
 =?us-ascii?Q?DP5SVG4hY0XwUcy+rT8X3nlBueHezvfFjCNXDMvf33FoeXeW4ihe51oNHGc4?=
 =?us-ascii?Q?pSbGanbhuypVEzWO1FEXkOi095gQhZwhd2HFHXmCbHnNsViWaAwBv+moR7Zf?=
 =?us-ascii?Q?YvTuHuy7OfUOPpdYAwSQ3ZSdZri+f+T7DtF2GcyDbLIOpjeX8AQIO3xR73hO?=
 =?us-ascii?Q?QV9VFunD7E8usdeZD5VAaMH55qwcptLCwM6pj7k27zZGmotuWLpL7rzg/Dn4?=
 =?us-ascii?Q?n2iiQ8uo22vewPK08EnjZhWqO429TkBRiQIHriJ8uUxk11/REER6aTQz1uyR?=
 =?us-ascii?Q?4ZTi4vxG849mNYw0Svq/7CFVkX5EvxiExJUQuUzFz0gTRkAl9z+9hozoNsMZ?=
 =?us-ascii?Q?atIwtegQ6HDKPCpGd9DQZtkHqKFi+w9JNdXLnDYtrTpdEyPVhsxbxCnrSBqB?=
 =?us-ascii?Q?Fo7fW3MCY+AXZ/6R0ONSGN0cN6Af7tXam8S9txERruyGTUekBzhiM6fhJps9?=
 =?us-ascii?Q?gLrvISsXzl61pVP6rJ48YAgG5wUebL1ZODS8uZVtYgZghJ6g6EYfaFYrrBf6?=
 =?us-ascii?Q?VpT6IoG3LSiSpvFFozSRmEuku/WN6fCb+Gqf3gKxuT/6IaQNvnHd+2aerG49?=
 =?us-ascii?Q?IcR489orPUv/GW62vAC9YYiOP7xaBNTlelWxfRP2wWpJ586KVCAvQzPNMp4e?=
 =?us-ascii?Q?xdrCz/+KrzZ05FCfdVwIG9dkUuseUp2AdArhLLa3kLQI7+fsl5TXIhWAb/ug?=
 =?us-ascii?Q?FXH9bm92SRBzCAWrMzYcssRbO0fXrXXFa8OLV1DcHOK8w+zEYmBRxPPbLGBy?=
 =?us-ascii?Q?A7ro6Ws6/UNIfbZ+Le627nIfL2aZKnhEGMKI89cTNuyfQkiEzHL/HB0XmifL?=
 =?us-ascii?Q?h/weP8AuRVSTCrUCNMCCI/DFhvlHZhrm4RKzt6lrRpB42vVPCPMatJ/Me7eD?=
 =?us-ascii?Q?rgsO0kQ86OxN2j8sdh5x59mCb9kbz8rmAuPUC3Qn20fcALw3OBiqY5hiWOPi?=
 =?us-ascii?Q?5twW0um31mRqJxh8QJhMmnBEGAgKaJ5Ugo7EMFH/a0hA7rHhyu4RhMe7PApB?=
 =?us-ascii?Q?+2XjGdXp+zU6M3IZu+Qvw0fyDJKFyW6mqRgD6QODB6psQ5vYoi4REi83a27k?=
 =?us-ascii?Q?WJDn3nJ+UGRuiNNW9mme7BuJpF0L7qv3nB0laklfXYJsY2BjVK3JFUrJ/Tba?=
 =?us-ascii?Q?xdtJxGdZe+LeB4MQ8SejldOGhfLJBZ2brr9hAHw9Yy8xBj4ilp1OaYPs9LwC?=
 =?us-ascii?Q?JNRkkNO5b/vdR+Me7qY1Vbee8JViMY3c9BlZJYbCKp2BJWqDDVzh3nkuiOXT?=
 =?us-ascii?Q?jEZGZByEFsSygF6B/EE1t1iHc+nqJH/Hr12TWoBdQutqUesVLuyerff3RvpK?=
 =?us-ascii?Q?E5dNU9vZqDOQNM23DNQg2ficLt8ifgWspWd5+Y1yUZr2JYFaFrzzM+jKM6VL?=
 =?us-ascii?Q?Yd2AEGSbAv73lBgWd2o0nq00goD3xCcc+WeWaPk1ZtQrs2VYHrKGrpr23K6V?=
 =?us-ascii?Q?pS36nVxz0uy8D4EJ+7z0fg0TfmgUMl5ikzRzLgMdeaggpB5PKlo2lCweYijm?=
 =?us-ascii?Q?LvA9YNNSnKvvgTiqK1t19S7W3H6iDVkov70963Fao10K6bRdpY6xro6Q6zdS?=
 =?us-ascii?Q?AvV0CHNder1rUsKnoZQUXa1XFcaJ5/7hZAIDhqoNW8WKVkv1LAV3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e03512-2188-4503-66a3-08df1556075b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:25:34.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WHi+wj0wyJ7WyhQyyvnTlTJ5QAU4h6yyG0f6+79wPptq4d+feqpga7o9uz6PKcVmZkQ7h44YrR1/ZTOc28hlYIdkYQCXtAC1bmmHoLN0xmDlUIPYsavs2AgvpOEfFRq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541

From: Wei Fang <wei.fang@nxp.com>

Add one-step Sync offload for NETC switch ports and advertise
HWTSTAMP_TX_ONESTEP_SYNC. Frames that are not one-step Sync still fall
back to two-step timestamping.

Each port has a single PM_SINGLE_STEP register, which holds the offset
of the correction field in the Sync frame and tells the hardware whether
the UDP checksum needs to be updated. As the register is shared by all
frames of the port, one-step Sync frames have to be sent one at a time.
Therefore, let the tagger hand each one-step Sync over to the switch
driver, which queues it on a per-port queue and drains the queue from a
work.

For every frame, the work reads the current PTP time, programs
PM_SINGLE_STEP, writes the time into the originTimestamp field and lets
the tagger insert a To_Port subtype 3 tag carrying the lower 30 bits of
that time together with a timestamp request ID. The hardware captures
the SFD transmit time, adds the difference between it and the software
timestamp to the correction field, and sends a response frame echoing
the request ID once the Sync frame has left the port. Receiving the
response schedules the work for the next frame.

A dropped frame produces no response, so reuse tstamp_timeout_work to
reclaim its request ID after 5 seconds, which is far longer than the
expected transmit time. Since the tag timestamp is only 30 bits wide
and the hardware accounts for a single wrap at most, also schedule the
work when the PTP time has advanced beyond NETC_ONESTEP_VALID_WINDOW
since the in-flight frame was queued, as its correction field can no
longer be computed correctly.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/Kconfig          |   1 +
 drivers/net/dsa/netc/netc_main.c      |   7 +-
 drivers/net/dsa/netc/netc_ptp.c       | 361 +++++++++++++++++++++++++-
 drivers/net/dsa/netc/netc_switch.h    |  23 ++
 drivers/net/dsa/netc/netc_switch_hw.h |   5 +
 include/linux/dsa/tag_netc.h          |  17 ++
 net/dsa/tag_netc.c                    |  69 ++++-
 7 files changed, 477 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/netc/Kconfig b/drivers/net/dsa/netc/Kconfig
index 8770b65d0f62..7c930579f1c9 100644
--- a/drivers/net/dsa/netc/Kconfig
+++ b/drivers/net/dsa/netc/Kconfig
@@ -5,6 +5,7 @@ config NET_DSA_NETC_SWITCH
 	depends on NET_DSA && PCI
 	depends on NET_VENDOR_FREESCALE
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on PTP_NETC_V4_TIMER || PTP_NETC_V4_TIMER=n
 	select NET_DSA_TAG_NETC
 	select FSL_ENETC_MDIO
 	select NXP_NTMP
diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 03200fc63a09..af39a71aece0 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -75,6 +75,7 @@ static int netc_connect_tag_protocol(struct dsa_switch *ds,
 
 	tagger_data = ds->tagger_data;
 	tagger_data->txtstamp_handler = netc_port_txtstamp_handler;
+	tagger_data->onestep_sync_enqueue = netc_port_onestep_sync_enqueue;
 
 	return 0;
 }
@@ -94,7 +95,7 @@ static void netc_port_rmw(struct netc_port *np, u32 reg,
 	netc_port_wr(np, reg, new);
 }
 
-static void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
+void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
 {
 	if (is_netc_pseudo_port(np))
 		return;
@@ -1571,6 +1572,7 @@ static int netc_port_enable(struct dsa_switch *ds, int port,
 		return err;
 	}
 
+	netc_port_enable_onestep(np);
 	np->enable = true;
 
 	return 0;
@@ -1588,6 +1590,7 @@ static void netc_port_disable(struct dsa_switch *ds, int port)
 	if (!np->enable)
 		return;
 
+	netc_port_disable_onestep(np);
 	clk_disable_unprepare(np->ref_clk);
 	np->enable = false;
 }
@@ -2441,6 +2444,7 @@ static void netc_mac_link_up(struct phylink_config *config,
 	netc_port_set_rx_pause(np, rx_pause);
 	netc_port_mac_tx_enable(np);
 	netc_port_mac_rx_enable(np);
+	netc_port_enable_onestep(np);
 }
 
 static void netc_mac_link_down(struct phylink_config *config,
@@ -2451,6 +2455,7 @@ static void netc_mac_link_down(struct phylink_config *config,
 	struct netc_port *np;
 
 	np = NETC_PORT(dp->ds, dp->index);
+	netc_port_disable_onestep(np);
 	netc_port_mac_rx_graceful_stop(np);
 	netc_port_mac_tx_graceful_stop(np);
 	netc_port_remove_dynamic_entries(np);
diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
index 2e743443ca03..1bc0f0956206 100644
--- a/drivers/net/dsa/netc/netc_ptp.c
+++ b/drivers/net/dsa/netc/netc_ptp.c
@@ -11,6 +11,15 @@
 
 #define NETC_NUM_TS_REQ_ID		16
 #define NETC_TSTAMP_TIMEOUT		(5 * HZ)
+#define NETC_MAX_STEP_OFFSET		0x1ff
+#define NETC_ONESTEP_QTH		512
+/* The 30-bit timestamp of the To_Port subtype 3 tag lets the hardware
+ * account for a single wrap, so the correction field of a one-step Sync
+ * frame is only correct if it is sent out within 2^30 ns after the
+ * software timestamp is read. Past this window the frame is beyond
+ * repair, and PM_SINGLE_STEP becomes safe to reprogram.
+ */
+#define NETC_ONESTEP_VALID_WINDOW	0x40000000 /* ns */
 
 static void netc_port_tstamp_timeout_work(struct work_struct *work)
 {
@@ -68,12 +77,276 @@ static int netc_get_ts_req_id(struct netc_port *np)
 	return ts_req_id;
 }
 
+static int netc_get_phc_time(struct netc_switch *priv, u64 *ns)
+{
+	if (unlikely(!priv->tmr_dev))
+		return -ENODEV;
+
+	return netc_timer_get_current_time(priv->tmr_dev, ns);
+}
+
+static void netc_port_set_onestep_control(struct netc_port *np,
+					  bool csum_update, int offset)
+{
+	u32 val;
+
+	val = PM_SINGLE_STEP_EN | FIELD_PREP(PM_SINGLE_STEP_OFFSET, offset);
+	if (csum_update)
+		val |= PM_SINGLE_STEP_CH;
+	netc_mac_port_wr(np, NETC_PM_SINGLE_STEP(0), val);
+}
+
+static void netc_port_program_onestep(struct netc_port *np,
+				      struct sk_buff *skb)
+{
+	u16 correction_offset = NETC_SKB_CB(skb)->correction_offset;
+	u16 tstamp_offset = NETC_SKB_CB(skb)->timestamp_offset;
+	u64 tstamp = NETC_SKB_CB(skb)->tstamp;
+	u8 *hdr = skb_mac_header(skb);
+	bool csum_update = false;
+	__be32 new_sec_l, new_ns;
+	__be16 new_sec_h;
+	u64 sec;
+	u32 ns;
+
+	/* Update originTimestamp field of Sync packet
+	 * - 48 bits seconds field
+	 * - 32 bits nanoseconds field
+	 */
+	sec = div_u64_rem(tstamp, NSEC_PER_SEC, &ns);
+	new_sec_h = htons((sec >> 32) & 0xffff);
+	new_sec_l = htonl(sec & 0xffffffff);
+	new_ns = htonl(ns);
+
+	if (NETC_SKB_CB(skb)->is_udp) {
+		__be32 old_sec_l, old_ns;
+		struct udphdr *uh;
+		__be16 old_sec_h;
+
+		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			csum_update = true;
+			goto update_timestamp;
+		}
+
+		if (unlikely(!skb_transport_header_was_set(skb)))
+			uh = (struct udphdr *)(hdr + tstamp_offset -
+					       sizeof(struct ptp_header) -
+					       sizeof(struct udphdr));
+		else
+			uh = udp_hdr(skb);
+
+		/* For IPv4, a UDP checksum of zero on the wire means "no
+		 * checksum". For IPv6, its UDP checksum is mandatory and
+		 * never zero.
+		 */
+		if (!uh->check)
+			goto update_timestamp;
+
+		old_sec_h = __get_unaligned_t(__be16, hdr + tstamp_offset);
+		old_sec_l = __get_unaligned_t(__be32, hdr + tstamp_offset + 2);
+		old_ns = __get_unaligned_t(__be32, hdr + tstamp_offset + 6);
+		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
+					 new_sec_h, false);
+		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
+					 new_sec_l, false);
+		inet_proto_csum_replace4(&uh->check, skb, old_ns,
+					 new_ns, false);
+		csum_update = true;
+	}
+
+update_timestamp:
+	__put_unaligned_t(__be16, new_sec_h, hdr + tstamp_offset);
+	__put_unaligned_t(__be32, new_sec_l, hdr + tstamp_offset + 2);
+	__put_unaligned_t(__be32, new_ns, hdr + tstamp_offset + 6);
+
+	netc_port_set_onestep_control(np, csum_update, correction_offset);
+}
+
+void netc_port_disable_onestep(struct netc_port *np)
+{
+	struct sk_buff_head free_list;
+
+	if (!dsa_port_is_user(np->dp))
+		return;
+
+	__skb_queue_head_init(&free_list);
+
+	spin_lock_bh(&np->onestep_lock);
+	skb_queue_splice_init(&np->onestep_queue, &free_list);
+	np->onestep_state = NETC_ONESTEP_PORT_INACTIVE;
+	spin_unlock_bh(&np->onestep_lock);
+
+	cancel_work_sync(&np->onestep_work);
+	__skb_queue_purge(&free_list);
+}
+
+void netc_port_enable_onestep(struct netc_port *np)
+{
+	if (!dsa_port_is_user(np->dp))
+		return;
+
+	spin_lock_bh(&np->onestep_lock);
+	np->onestep_state = NETC_ONESTEP_IDLE;
+	spin_unlock_bh(&np->onestep_lock);
+}
+
+static void netc_port_purge_onestep_queue(struct netc_port *np)
+{
+	struct sk_buff_head free_list;
+
+	__skb_queue_head_init(&free_list);
+
+	spin_lock_bh(&np->onestep_lock);
+	skb_queue_splice_init(&np->onestep_queue, &free_list);
+	spin_unlock_bh(&np->onestep_lock);
+
+	__skb_queue_purge(&free_list);
+}
+
+static void netc_port_onestep_work(struct work_struct *work)
+{
+	struct netc_port *np = container_of(work, struct netc_port,
+					    onestep_work);
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_tagger_data *tagger_data;
+	struct sk_buff *clone = NULL;
+	struct sk_buff *skb = NULL;
+	int ts_req_id;
+	u64 tstamp;
+
+	spin_lock_bh(&np->onestep_lock);
+
+	if (unlikely(np->onestep_state == NETC_ONESTEP_PORT_INACTIVE))
+		goto purge_onestep_queue;
+
+skb_dequeue:
+	skb = __skb_dequeue(&np->onestep_queue);
+	if (!skb)
+		goto set_onestep_state_idle;
+
+	/* Clone is a ts_req_id token only; its payload is never read, so
+	 * sharing the buffer with the mutated original is fine.
+	 */
+	clone = skb_clone(skb, GFP_ATOMIC);
+	if (unlikely(!clone)) {
+		kfree_skb(skb);
+		goto skb_dequeue;
+	}
+
+	spin_lock_bh(&np->tstamp_lock);
+	ts_req_id = netc_get_ts_req_id(np);
+	if (unlikely(ts_req_id < 0)) {
+		spin_unlock_bh(&np->tstamp_lock);
+
+		/* Re-queuing the frame and immediately rescheduling the work
+		 * would busy-loop on system_percpu_wq and burn CPU until an
+		 * ID is freed, so drop this frame and move on to the next one
+		 * in the queue instead.
+		 */
+		np->onestep_state = NETC_ONESTEP_SCHEDULED;
+		schedule_work(&np->onestep_work);
+
+		goto onestep_unlock;
+	}
+
+	/* PHC is unavailable, drop the whole queue */
+	if (unlikely(netc_get_phc_time(priv, &tstamp))) {
+		spin_unlock_bh(&np->tstamp_lock);
+		goto set_onestep_state_idle;
+	}
+
+	NETC_SKB_CB(skb)->tstamp = tstamp;
+	NETC_SKB_CB(skb)->ts_req_id = ts_req_id;
+	NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
+	NETC_SKB_CB(clone)->ts_req_id = ts_req_id;
+	NETC_SKB_CB(clone)->ptp_tx_time = jiffies_64;
+	NETC_SKB_CB(clone)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
+	np->onestep_tx_time = NETC_SKB_CB(clone)->ptp_tx_time;
+	np->onestep_ts_req_id = ts_req_id;
+
+	__skb_queue_tail(&np->tstamp_queue, clone);
+	if (!delayed_work_pending(&np->tstamp_timeout_work))
+		schedule_delayed_work(&np->tstamp_timeout_work,
+				      NETC_TSTAMP_TIMEOUT);
+
+	spin_unlock_bh(&np->tstamp_lock);
+
+	np->onestep_state = NETC_ONESTEP_IN_FLIGHT;
+	spin_unlock_bh(&np->onestep_lock);
+
+	netc_port_program_onestep(np, skb);
+	tagger_data = priv->ds->tagger_data;
+	tagger_data->onestep_sync_xmit(skb, np->dp->user);
+
+	return;
+
+set_onestep_state_idle:
+	np->onestep_state = NETC_ONESTEP_IDLE;
+purge_onestep_queue:
+	__skb_queue_purge(&np->onestep_queue);
+onestep_unlock:
+	spin_unlock_bh(&np->onestep_lock);
+	kfree_skb(skb);
+	kfree_skb(clone);
+}
+
+static bool netc_onestep_timeout(struct netc_port *np)
+{
+	u64 expire_time;
+
+	/* Use monotonic jiffies_64, as the PHC may be stepped backwards.
+	 * Add one tick since the ns-to-jiffies conversion rounds down, so
+	 * the software window is never shorter than the hardware window.
+	 */
+	expire_time = np->onestep_tx_time + 1 +
+		      nsecs_to_jiffies64(NETC_ONESTEP_VALID_WINDOW);
+	if (np->onestep_state == NETC_ONESTEP_IN_FLIGHT &&
+	    time_after64(jiffies_64, expire_time))
+		return true;
+
+	return false;
+}
+
+void netc_port_onestep_sync_enqueue(struct dsa_switch *ds, int port,
+				    struct sk_buff *skb)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	spin_lock_bh(&np->onestep_lock);
+	if (unlikely(np->onestep_state == NETC_ONESTEP_PORT_INACTIVE)) {
+		kfree_skb(skb);
+		goto onestep_unlock;
+	}
+
+	if (unlikely(skb_queue_len(&np->onestep_queue) >= NETC_ONESTEP_QTH)) {
+		dev_dbg_ratelimited(np->switch_priv->dev,
+				    "The onestep_queue of port %d is full\n",
+				    port);
+		kfree_skb(skb);
+		goto onestep_unlock;
+	}
+
+	__skb_queue_tail(&np->onestep_queue, skb);
+	if (likely(np->onestep_state == NETC_ONESTEP_IDLE) ||
+	    netc_onestep_timeout(np)) {
+		np->onestep_state = NETC_ONESTEP_SCHEDULED;
+		schedule_work(&np->onestep_work);
+	}
+
+onestep_unlock:
+	spin_unlock_bh(&np->onestep_lock);
+}
+
 int netc_port_ptp_init(struct netc_port *np)
 {
 	/* Initialize to invalid entry IDs */
 	for (int i = 0; i < NETC_PTP_MAX; i++)
 		np->ptp_ipft_eid[i] = NTMP_NULL_ENTRY_ID;
 
+	spin_lock_init(&np->onestep_lock);
+	__skb_queue_head_init(&np->onestep_queue);
+	INIT_WORK(&np->onestep_work, netc_port_onestep_work);
+
 	spin_lock_init(&np->tstamp_lock);
 	__skb_queue_head_init(&np->tstamp_queue);
 	INIT_DELAYED_WORK(&np->tstamp_timeout_work,
@@ -116,7 +389,8 @@ int netc_get_ts_info(struct dsa_switch *ds, int port,
 				 SOF_TIMESTAMPING_RX_HARDWARE |
 				 SOF_TIMESTAMPING_RAW_HARDWARE;
 
-	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON) |
+			 BIT(HWTSTAMP_TX_ONESTEP_SYNC);
 
 	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
 			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
@@ -342,6 +616,7 @@ int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
 		return -EOPNOTSUPP;
 
 	switch (config->tx_type) {
+	case HWTSTAMP_TX_ONESTEP_SYNC:
 	case HWTSTAMP_TX_ON:
 	case HWTSTAMP_TX_OFF:
 		break;
@@ -379,6 +654,9 @@ int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
 	}
 
 	WRITE_ONCE(np->ptp_tx_type, config->tx_type);
+	if (config->tx_type != HWTSTAMP_TX_ONESTEP_SYNC)
+		netc_port_purge_onestep_queue(np);
+
 	config->rx_filter = rx_filter;
 
 	return 0;
@@ -395,6 +673,66 @@ int netc_port_hwtstamp_get(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static void netc_port_prepare_onestep_sync(struct netc_port *np,
+					   struct sk_buff *skb,
+					   u32 ptp_class, bool *twostep)
+{
+	struct netc_switch *priv = np->switch_priv;
+	u16 correction_offset, tstamp_offset;
+	struct ptp_header *ptp_hdr;
+	u8 msg_type, twostep_flag;
+	bool is_udp = false;
+	u32 pkt_type;
+	u8 *pkt_hdr;
+
+	if (unlikely(skb_linearize_cow(skb)))
+		goto set_ptp_flag_drop;
+
+	ptp_hdr = ptp_parse_header(skb, ptp_class);
+	if (unlikely(!ptp_hdr))
+		goto set_ptp_flag_drop;
+
+	msg_type = ptp_get_msgtype(ptp_hdr, ptp_class);
+	twostep_flag = ptp_hdr->flag_field[0] & 0x2;
+	if (msg_type != PTP_MSGTYPE_SYNC || twostep_flag != 0) {
+		*twostep = true;
+		return;
+	}
+
+	pkt_hdr = skb_mac_header(skb);
+	correction_offset = (u8 *)&ptp_hdr->correction - pkt_hdr;
+	tstamp_offset = (u8 *)ptp_hdr + sizeof(*ptp_hdr) - pkt_hdr;
+
+	/* Ensure that the entire originTimestamp field is present in the
+	 * linear buffer of the skb and the correction_offset must be within
+	 * the hardware capability.
+	 */
+	if (unlikely(tstamp_offset + 10 > skb_headlen(skb) ||
+		     correction_offset > NETC_MAX_STEP_OFFSET))
+		goto set_ptp_flag_drop;
+
+	pkt_type = ptp_class & PTP_CLASS_PMASK;
+	if (pkt_type == PTP_CLASS_IPV4 || pkt_type == PTP_CLASS_IPV6)
+		is_udp = true;
+
+	NETC_SKB_CB(skb)->correction_offset = correction_offset;
+	NETC_SKB_CB(skb)->timestamp_offset = tstamp_offset;
+	NETC_SKB_CB(skb)->is_udp = is_udp;
+	NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
+
+	return;
+
+set_ptp_flag_drop:
+	/* Drop instead of falling back to two-step: if it is a Sync,
+	 * one-step offload will not be executed, the timestamp in the
+	 * frame is inaccurate, which may affect PTP synchronization.
+	 */
+	NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_DROP;
+	dev_dbg_ratelimited(priv->dev,
+			    "Port %d: PTP frame dropped in error\n",
+			    np->dp->index);
+}
+
 static void netc_port_prepare_twostep(struct netc_port *np,
 				      struct sk_buff *nskb)
 {
@@ -449,6 +787,21 @@ void netc_port_txtstamp_handler(struct dsa_switch *ds, int port,
 		dev_dbg_ratelimited(np->switch_priv->dev,
 				    "Port %d ts_req_id %u which seems lost\n",
 				    port, ts_req_id);
+
+		return;
+	}
+
+	if (NETC_SKB_CB(skb_match)->ptp_flag == NETC_PTP_FLAG_ONESTEP) {
+		spin_lock_bh(&np->onestep_lock);
+		if (likely(np->onestep_state == NETC_ONESTEP_IN_FLIGHT &&
+			   np->onestep_ts_req_id == ts_req_id) ||
+		    np->onestep_state == NETC_ONESTEP_IDLE) {
+			np->onestep_state = NETC_ONESTEP_SCHEDULED;
+			schedule_work(&np->onestep_work);
+		}
+		spin_unlock_bh(&np->onestep_lock);
+		consume_skb(skb_match);
+
 		return;
 	}
 
@@ -472,6 +825,7 @@ bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
 void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	bool twostep = false;
 	u32 ptp_class;
 	int tx_type;
 
@@ -487,6 +841,9 @@ void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 		return;
 
 	tx_type = READ_ONCE(np->ptp_tx_type);
-	if (tx_type == HWTSTAMP_TX_ON)
+	if (tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
+		netc_port_prepare_onestep_sync(np, skb, ptp_class, &twostep);
+
+	if (tx_type == HWTSTAMP_TX_ON || twostep)
 		netc_port_prepare_twostep(np, skb);
 }
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index a1f4b1bc04cb..624cf323c9a6 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -87,6 +87,13 @@ enum netc_host_reason {
 	NETC_HR_PTP_TRAP   = 9,
 };
 
+enum netc_onestep_state {
+	NETC_ONESTEP_IDLE	= 0,
+	NETC_ONESTEP_SCHEDULED,
+	NETC_ONESTEP_IN_FLIGHT,
+	NETC_ONESTEP_PORT_INACTIVE,
+};
+
 struct netc_port {
 	void __iomem *iobase;
 	struct netc_switch *switch_priv;
@@ -102,6 +109,17 @@ struct netc_port {
 	u16 pvid;
 	u32 ipft_hf_eid; /* Must be initialized to NTMP_NULL_ENTRY_ID */
 
+	/* Serialize access to onestep_queue, onestep_state and
+	 * onestep_tx_time
+	 */
+	spinlock_t onestep_lock;
+	u8 onestep_state;
+	u8 onestep_ts_req_id;
+	u64 onestep_tx_time;
+	/* skb queue for one-step Sync frames */
+	struct sk_buff_head onestep_queue;
+	struct work_struct onestep_work;
+
 	/* Serialize access to tstamp_queue */
 	spinlock_t tstamp_lock;
 	/* skb queue for TX timestamp frames */
@@ -213,6 +231,7 @@ static inline void netc_del_vlan_entry(struct netc_vlan_entry *entry)
 }
 
 int netc_switch_platform_probe(struct netc_switch *priv);
+void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val);
 
 /* ethtool APIs */
 void netc_port_get_pause_stats(struct dsa_switch *ds, int port,
@@ -244,5 +263,9 @@ void netc_port_txtstamp_handler(struct dsa_switch *ds, int port,
 bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
 			unsigned int type);
 void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb);
+void netc_port_disable_onestep(struct netc_port *np);
+void netc_port_enable_onestep(struct netc_port *np);
+void netc_port_onestep_sync_enqueue(struct dsa_switch *ds, int port,
+				    struct sk_buff *skb);
 
 #endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 1404ae41c7bc..37d1dd7ec2c7 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -203,6 +203,11 @@ enum netc_stg_stage {
 #define   SSP_10M			1
 #define   SSP_1G			2
 
+#define NETC_PM_SINGLE_STEP(a)		(0x10c0 + (a) * 0x400)
+#define  PM_SINGLE_STEP_CH		BIT(6)
+#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
+#define  PM_SINGLE_STEP_EN		BIT(31)
+
 /* Port MAC 0/1 Receive Ethernet Octets Counter */
 #define NETC_PM_REOCT(a)		(0x1100 + (a) * 0x400)
 
diff --git a/include/linux/dsa/tag_netc.h b/include/linux/dsa/tag_netc.h
index 5a567af20094..baf0f93bd994 100644
--- a/include/linux/dsa/tag_netc.h
+++ b/include/linux/dsa/tag_netc.h
@@ -10,7 +10,9 @@
 #include <net/dsa.h>
 
 #define NETC_TAG_MAX_LEN			14
+#define NETC_PTP_FLAG_ONESTEP			BIT(0)
 #define NETC_PTP_FLAG_TWOSTEP			BIT(1)
+#define NETC_PTP_FLAG_DROP			BIT(2)
 
 struct netc_skb_cb {
 	u64 ptp_tx_time;
@@ -18,6 +20,9 @@ struct netc_skb_cb {
 	bool rx_tstamp_valid;
 	u8 ptp_flag;
 	u8 ts_req_id;
+	bool is_udp;
+	u16 correction_offset;
+	u16 timestamp_offset;
 };
 
 #define NETC_SKB_CB(skb)	((struct netc_skb_cb *)((skb)->cb))
@@ -26,10 +31,22 @@ struct netc_skb_cb {
  * struct netc_tagger_data - NETC tagger/switch-driver shared operations
  * @txtstamp_handler: Called by the tagger when a two-step transmit timestamp
  *	response is received, to deliver the timestamp to the switch driver.
+ * @onestep_sync_enqueue: Called from the tagger xmit path for a one-step Sync
+ *	frame. The switch driver takes ownership of the skb and queues it for
+ *	deferred transmission from process context, where the shared
+ *	PM_SINGLE_STEP register can be programmed and the PTP timer read. The
+ *	tagger must not touch the skb after this call and returns NULL to
+ *	dsa_user_xmit().
+ * @onestep_sync_xmit: Called by the switch driver to transmit a deferred
+ *	one-step Sync frame directly to the conduit, bypassing dsa_user_xmit().
  */
 struct netc_tagger_data {
 	void (*txtstamp_handler)(struct dsa_switch *ds, int port,
 				 u8 ts_req_id, u64 ts);
+	void (*onestep_sync_enqueue)(struct dsa_switch *ds, int port,
+				     struct sk_buff *skb);
+	netdev_tx_t (*onestep_sync_xmit)(struct sk_buff *skb,
+					 struct net_device *ndev);
 };
 
 #endif
diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
index 6b492451d092..c1c0ffee75c1 100644
--- a/net/dsa/tag_netc.c
+++ b/net/dsa/tag_netc.c
@@ -18,6 +18,8 @@
 #define NETC_TAG_TP_SUBTYPE0		0
 /* SubType2: Request to perform two-step timestamping */
 #define NETC_TAG_TP_SUBTYPE2		2
+/* SubType3: Request to perform both one-step and two-step timestamping */
+#define NETC_TAG_TP_SUBTYPE3		3
 
 /* To_Host NXP switch tag */
 #define NETC_TAG_TO_HOST		2
@@ -32,6 +34,7 @@
 #define NETC_TAG_FORWARD_LEN		6
 #define NETC_TAG_TP_SUBTYPE0_LEN	6
 #define NETC_TAG_TP_SUBTYPE2_LEN	6
+#define NETC_TAG_TP_SUBTYPE3_LEN	10
 #define NETC_TAG_TH_SUBTYPE0_LEN	6
 #define NETC_TAG_TH_SUBTYPE1_LEN	14
 #define NETC_TAG_TH_SUBTYPE2_LEN	14
@@ -44,6 +47,7 @@
 #define NETC_TAG_SWITCH			GENMASK(2, 0)
 #define NETC_TAG_PORT			GENMASK(7, 3)
 #define NETC_TAG_TS_REQ_ID		GENMASK(3, 0)
+#define NETC_TAG_TIMESTAMP		GENMASK(29, 0)
 
 struct netc_tag_cmn {
 	__be16 tpid;
@@ -57,6 +61,12 @@ struct netc_tag_tp_subtype2 {
 	u8 ts_req_id;
 } __packed;
 
+struct netc_tag_tp_subtype3 {
+	struct netc_tag_cmn cmn;
+	u8 ts_req_id;
+	__be32 timestamp;
+} __packed;
+
 struct netc_tag_th_subtype1 {
 	struct netc_tag_cmn cmn;
 	u8 host_reason;
@@ -129,17 +139,69 @@ static void netc_fill_tp_tag_subtype2(struct sk_buff *skb,
 	tag->ts_req_id = FIELD_PREP(NETC_TAG_TS_REQ_ID, ts_req_id);
 }
 
+static void netc_fill_tp_tag_subtype3(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	u32 ts = FIELD_PREP(NETC_TAG_TIMESTAMP, NETC_SKB_CB(skb)->tstamp);
+	u8 ts_req_id = NETC_SKB_CB(skb)->ts_req_id;
+	struct netc_tag_tp_subtype3 *tag;
+
+	tag = netc_fill_common_tp_tag(skb, ndev, NETC_TAG_TP_SUBTYPE3,
+				      NETC_TAG_TP_SUBTYPE3_LEN);
+	tag->ts_req_id = FIELD_PREP(NETC_TAG_TS_REQ_ID, ts_req_id);
+	tag->timestamp = htonl(ts);
+}
+
+static void netc_onestep_sync_enqueue(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	struct dsa_port *dp = dsa_user_to_port(ndev);
+	struct netc_tagger_data *tagger_data;
+
+	tagger_data = dp->ds->tagger_data;
+	if (unlikely(!tagger_data->onestep_sync_enqueue)) {
+		kfree_skb(skb);
+		return;
+	}
+
+	/* Hand the one-step Sync to the switch driver, which takes ownership
+	 * and queues it for deferred transmission from its work. The tagger
+	 * must not touch the skb after this point.
+	 */
+	tagger_data->onestep_sync_enqueue(dp->ds, dp->index, skb);
+}
+
+static netdev_tx_t netc_onestep_sync_xmit(struct sk_buff *skb,
+					  struct net_device *dev)
+{
+	netc_fill_tp_tag_subtype3(skb, dev);
+
+	return dsa_enqueue_skb(skb, dev);
+}
+
 static struct sk_buff *netc_xmit(struct sk_buff *skb,
 				 struct net_device *ndev)
 {
 	u8 ptp_flag = NETC_SKB_CB(skb)->ptp_flag;
 
 	/* Fast path: the overwhelming majority of frames are not PTP frames */
-	if (likely(!ptp_flag))
+	if (likely(!ptp_flag)) {
 		netc_fill_tp_tag_subtype0(skb, ndev);
-	else
-		/* ptp_flag == NETC_PTP_FLAG_TWOSTEP */
+	} else if (ptp_flag == NETC_PTP_FLAG_TWOSTEP) {
 		netc_fill_tp_tag_subtype2(skb, ndev);
+	} else if (ptp_flag == NETC_PTP_FLAG_ONESTEP) {
+		/* The switch driver takes ownership of the one-step Sync and
+		 * queues it for deferred TX; the deferred work tags it subtype
+		 * 3 and transmits it directly to the conduit. Return NULL so
+		 * dsa_user_xmit() stops processing this skb.
+		 */
+		netc_onestep_sync_enqueue(skb, ndev);
+		skb = NULL;
+	} else {
+		/* NETC_PTP_FLAG_DROP */
+		kfree_skb(skb);
+		skb = NULL;
+	}
 
 	return skb;
 }
@@ -326,6 +388,7 @@ static int netc_connect(struct dsa_switch *ds)
 	if (!tagger_data)
 		return -ENOMEM;
 
+	tagger_data->onestep_sync_xmit = netc_onestep_sync_xmit;
 	ds->tagger_data = tagger_data;
 
 	return 0;
-- 
2.34.1


