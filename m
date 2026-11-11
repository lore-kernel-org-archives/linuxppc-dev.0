Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1C660A2600
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=K4dM0muh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPYQ71RZPz2xGg;
	Wed, 11 Nov 2026 17:24:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794378255;
	cv=pass; b=KkpyCcOUrVKWIbNYvfJ7ohlBM4fQBrwaA5Qt6A5C6hDlJ+C3woBtGB9INd1c7+mdud41i5C4JmXVkBW/0QWb4cjOZURQKlgEPgnDSNmDmXFUWQ+gQ+m7pTH700Z4KCnXbrp5xerg2orLW9FGQvqe9y/nfUw1HNj8/aj2asaIoEb7boJQgNTvCzuSV75LpoYXi1mtyqUiDvICJsJwhi47h+clJLV30nZcKEAqMlHKbGS2DHHA2WpaFBDEy5Ku/Drzj97YBh97VWkEpJo7WKUECZ9EXcuWjmrDCvIrqM2EY2GX/HEKzVI42DDMsUm6RrTYx6ZUUVl9W/XfZ7bo9+xMyw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794378255; c=relaxed/relaxed;
	bh=ZlIGV3CuAaJpO90aVC+63q57cDblmqLkHHniLJkWKKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJgUYks8pLQi4DoMqzyOViPcvvVjKBMx89itUraK9WhEPFf5vaIjCtu5JyS6weqhVWxxG05jKq6nX724R4DvfUURyv3y+vvm3JHeFVc9cHjJ+4WxQtwD8r+041ulLa+HNFuF9ECOnVQPX64YojoTdVIjK+lrjcn5tbBWl7khTApb3Gl1BujrurBiFxsERu5ahXt08R3nBh24L1VvdPWwPG3JbJJziOnojXR9oD6N+POCoseCqgTLxhFxkA6DLwJPru7kicqEl5BY+l7OGyOpC/wai6OIPJ0jydcy6SQrVVNDkFlJfi4qySZznkwMq5DFqGEKSpyMlfU0bVH140ES/Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=K4dM0muh; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=K4dM0muh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPYQ53pRKz2yYY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 17:24:13 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/FS0ft7rX0rENAc5zWd7lNPhmav1eFH1X9Hob3NDpN57NSlaEgUdQdnE6Nuxwb9UJRdGgcN2ImuqSOknO2ad/YPs9XornrQW0AFTVwydS9f62PupEE5IeQb3auZzzvg+qfe3MJVR1dP4+1HezyPCvxthRH9dqzpej5UeVWKWB+iij6+oaMG2hhzsO7TgA3A+hnVoCygU7TUE/XmnhIDQuUjXoKyoQOSuYbR58aw2seWX/P4izmjMml6W4YnEgrkZEeQpjiP3rR3vFdweonmfISJkpJeqrmC7BwjtC3ZiobxYaaop+S9EePcWf9y49K0zZptINXv/Y+HyLxXnAXz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlIGV3CuAaJpO90aVC+63q57cDblmqLkHHniLJkWKKg=;
 b=ctazJPGOHXSR2l5IHYxY7q/N86n8LLJhBsMJ6fjMhCyF7sHrcgH/pSTB5rdVnMfVchrsN6rVJBAMrhcL1qUEaweufX7VFXfB+38ZCcBAf1tiKhbrZW2xMZiXn9S2Nz4HiLtsPWZ4v4fMihJ4dFkimcFut4WXIDjgSfOtPjfF+Cy9jgLyVVBV3q0/A+hPR65p5O4kwElx87USRyIh1uQEmj7F+jwxnViCiJSWUv0oU2XSmNl+ogaPhio4H66uNG0nwIs8Uz+IciUqtxKqQam9WY9YxPT72UJQ22blFA0XQBjbBYihC2ki7V3auet0kdPfMVdibLEmoZr/KCr6MPGy6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlIGV3CuAaJpO90aVC+63q57cDblmqLkHHniLJkWKKg=;
 b=K4dM0muhMFUK/yU4WTq//DHZLHzSKyboLQ0reJbou7ZgPgSG7go2osDtSR0mjb0JNINP8F8CNzsNoO8tMJDotrVmZhhM7/ItheA3CS8YbYBorEmYUa+8K3Ei0A48qSE6pNmmsQlIXt6VRla5Lf23nmhER7/4vaJbh1iFpeiRmXcjDU1iWXBb2rzNP2Q1YtQlzC5Z9THws++hFaik/npyAOED5IuDGFM6asnACJwK0VRjRdGKDzlalwTuxQfUUz0bVO8xnl5243gdn186R1eMsqI2rmi9qilAXVTOhjzAY3wgNQsY3ik8xGPBGixkFvzrcfLKCRZ0a9gH1xGKUOpW5w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI0PR04MB10543.eurprd04.prod.outlook.com (2603:10a6:800:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:23:57 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:23:57 +0000
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
Subject: [PATCH v7 net-next 9/9] net: dsa: netc: add PTP one-step timestamping support
Date: Wed, 11 Nov 2026 14:27:53 +0800
Message-Id: <20261111062753.1397582-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
References: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:990:76::23) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI0PR04MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e26e5f3-f02e-4549-2058-08df3fbc5dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|921020|261026130827099003|261026121527099003|261022113327099003|11063799006|261026140227099003|261102123227099003|261021123027099003|261021130227099003|261021135927099003|261009223027099003|261021121427099003|261022115727099003|261022105027099003|261022075727099003|261028144727099003|56012099006|10067099003|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	3w6xj+VnHTDtM/vWndHlzB+L2PasJMugAwNnuCMMAiuhuV5z5aCHeWJ1Q6xCi7B96frb7TLSxjS2AcmuTEzNOjncVGeu5UnGCdfIvw+OGtdXgH+QQD5P/RKWbx7911pCoKCT9Ej5h0z5Qp7UHiJ2F854oNJ+ZcxhngdXyndhDz8tb6BE35tUKTGGZMEmuyO4gAtktQw2IGCaVBG91HSnBrggfv0882S5Api/HG7yIqLzPeiwoXzPM369HU8ugvBJrSkU9vTLnXE2x1Tt0n4l/sSaWu/Ayqa++cpla5Mk/Tzsdq+URr+8QxA3m++WpcMHpV7LA+s9M4YaOxyjC1zeGfIE9Fv1TbnRzwRDFIWO0EO9V3+eMTWVGhpRRzndU7GE0V32AKuf+hkpXskKdJq9irqaKPHGkO3z1dvkCG4cmmgeDpzOUOBQpwyaXBnponBw6qlQX3LOhNCecryGkkg7JgxGBXG0YyuIA4KtcplTaU9g7cZasgc4400cmNJnmtc4kHAmoVp8abUvgFT8/NX9/cldWg1PRjcgCyCH0mx2xACXhSZkwEjQ89GN3I9UCT1jIQbaM+l0PJWuECpdj4a06qrTAN/MN/397e6hePBVOgdfTyC7Oi+NwrMAXqE8EDTeECvFdALQtjwUR7I8aKLfacfvUw8850fQNizroMcuFjV8xKkLP3TJqWT2Cui1icuLGCsvSjLcZQvgK+VwXFb2ug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(261026130827099003)(261026121527099003)(261022113327099003)(11063799006)(261026140227099003)(261102123227099003)(261021123027099003)(261021130227099003)(261021135927099003)(261009223027099003)(261021121427099003)(261022115727099003)(261022105027099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KQla+BQ8ZoYP/Ol1IcHwpcAhAf/PPd+o2NKmjKejGJW8lHzXuKwNK361SOZn?=
 =?us-ascii?Q?0iY1H4JAn2N1Oh3uVPn/+a/xg2V5bvdW5AtYuMYWd+XIsQ4mjPAtgPGW+chQ?=
 =?us-ascii?Q?UZE7d4xWZnFhwvErAgwttbMZE+HaHTQPkffjNPOynN2fwbegdgHL3i3klFA3?=
 =?us-ascii?Q?Wz02QFzZUp7slAuhViw3VI5142FPWI8cDxfsvkTOzE8mXgRpfeP2zQWzjWUW?=
 =?us-ascii?Q?eL0GvB2hMNDA7IRwD3ENI+L5dQDbqxrj0VGMa6YZBW0exCwboQJGGW6A8+DA?=
 =?us-ascii?Q?GvnGP1wgb65ti3i/LrjbavBDnk4ozMizQJUo0g+c0kcfEcaG4nEro7DxE5kb?=
 =?us-ascii?Q?+YPEj10H6BJM6g3f8ZJkxMrwcK0tzR5N4XUJEFJgomIWFuHKsb710TzQ7lvA?=
 =?us-ascii?Q?Bs8cM0pcJ1/4fUY0S3G4llg8z7/9lScNe2X8vCVzYxKupbMdId0SrjoJhWYw?=
 =?us-ascii?Q?D/u+WWHtxna+sdOrtC+tIv5bfUTloq0jwVwS9pO5z2Z7cGub3yp/SDBTSVIW?=
 =?us-ascii?Q?Q+Yfm9ToiWIifvmvEZSBhr7GWdRfBZPXp5PROyS84swf9Ku6SJ5YRAGL4EmT?=
 =?us-ascii?Q?fFrFZOJpM/NJvtyUiHI61HzVAZwTDon8BGQVNW9nWk8XZvZp4jOxGMXA9X3K?=
 =?us-ascii?Q?frg9bFul7dsY5ng3+/KKSr5kCSxXFlX6MvsPsSYm9Zot5vQozJ/VFiFnl41x?=
 =?us-ascii?Q?NKKVSFrks5NKBLqREZes0z3NKt7DiJW3Qcva9HFDfVLObUHJ49gLL6ADyPGn?=
 =?us-ascii?Q?+Sdb09utBskKXAT/+DAnpNx0KZZXFZpQH0XpKe5Yf1ujxhnvZxjo4zh0yHRc?=
 =?us-ascii?Q?wvhfJ1XvNIHYS6YRm/genON5IKHOpSxYZeK4oR1nYlyGnqbz+9zb3RLGHXd5?=
 =?us-ascii?Q?xekOqAX9Shu5TQ+DieiyRZtXXsq+5s+Q8AvAM8kT2BnsjtFaOvTeWkYNYBU0?=
 =?us-ascii?Q?vLPVoPTO8EsdxCM0YzCMudtB460YhS+EGtFbb8h8Csykba4H3ctLL8+DCpQ2?=
 =?us-ascii?Q?hVoBJX0QjPyDKXruZpGL3dT+VUJH2BXBhJI6u4IgpPx2QoIO0jtqaYofSiPI?=
 =?us-ascii?Q?FVAR3EYue04IYyESVLUCt87aWcJw5+Gjk++yokcGSWeFcFMBxiRZ1Az+3DKj?=
 =?us-ascii?Q?FrH/GdqUZ8I/VPvsZhjNAu2UR8MDzhPIzr/fr1J5eb4fvZ/AOtXiNgMlvJ44?=
 =?us-ascii?Q?mqYhxrEzwoA8uSrKVPRloQlsQv9trG7/Y6klZkbyqicoeWCmjWZ06MehWhhj?=
 =?us-ascii?Q?5c9+pIsCQ9k77lEQhPSoewUmtbC/rmp1PdhDmOm8HM/5hdBR7uaei/HIZhRZ?=
 =?us-ascii?Q?MQW1Ctt1IVlf6XWcxxWw9JZuA2RGvxj5uuNwXnrVV+4FveP+nxQAsWfBwSSX?=
 =?us-ascii?Q?DJY8VXPAski9MtZfOzQLmFzEZYvvrv4mrCqM+t1mtkm3m/FIiP8cbCSHulGA?=
 =?us-ascii?Q?esGAosEv1WVFpzdiSQ4PiPitZ/quedT327gMK6O2YwnnSROsA/f9ORbapiyl?=
 =?us-ascii?Q?IirSRIhpf9l5aMAph5Wcrv1iTFcDQOmInnF3FT2EVOCQqVPquqC7FfaXW32S?=
 =?us-ascii?Q?Kgmj4oiGgdmNFV5+5aTWWMazUcE06YB5HZad6M7kXPhi+0tOUY2Qw01WqMhT?=
 =?us-ascii?Q?ZzNdSRCVytwL2f0xCjNQdt1IlUyD/lc9KGc+iHPc0PhFQOWQYFy8038yAv4R?=
 =?us-ascii?Q?B//BFBd5OWIf9yTpkk/PdeDNh0YRGmMRD2ySut7LVd/XhUselqxom0et8Tzb?=
 =?us-ascii?Q?mcrq8hphSrMTsmr06Fs1UoE2YKOLLIKfgIQsPUNAzxBjUs8s/uGz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e26e5f3-f02e-4549-2058-08df3fbc5dbe
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:23:57.1879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otcUNz5lIFNAJhRlNOHGJ97WV79x7CJGsnRhg7ENvrwrFhUbSONf3V1Mn8vFd2HDe4B4AO7k1QFkPMLj4Bt1rD/2YTK6Buppr4A5CWuvgRn0lsv3/zeTaxLfc7cAxtEM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10543
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
expected transmit time. When that reclaimed ID belongs to the in-flight
frame, also resume the drain from the timeout work, otherwise the queued
frames would never be sent unless new traffic happened to arrive.

The tag timestamp is only 30 bits wide and the hardware accounts for a
single wrap at most, so the correction field of the in-flight frame can
no longer be correct once it is sent out more than 2^30 ns after its
software timestamp was read. There is no point in holding the queue for
such a frame until the 5 second timeout. So when a new Sync is enqueued
while a frame is in flight, also schedule the work if more than
NETC_ONESTEP_VALID_WINDOW has passed since the in-flight frame was
dequeued for transmission. Measure this time with jiffies_64 instead of
the PTP time, as the PHC may be stepped backwards. As the check is only
done at enqueue time, the queued frames still wait for
tstamp_timeout_work if no new Sync arrives.

If the originTimestamp field of the sync frame is not in the linear
buffer of the skb or the correction offset exceeds the hardware
capability, the frame will be dropped. Frames are also dropped when
the ts_req_id pool, shared with the two-step path, is exhausted. All
such drops are counted in the interface tx_dropped statistics.

It is worth mentioning that due to the introduction of
netc_timer_get_current_time(), a new dependency has been added to
NET_DSA_NETC_SWITCH.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/Kconfig          |   1 +
 drivers/net/dsa/netc/netc_main.c      |   6 +-
 drivers/net/dsa/netc/netc_ptp.c       | 395 +++++++++++++++++++++++++-
 drivers/net/dsa/netc/netc_switch.h    |  23 ++
 drivers/net/dsa/netc/netc_switch_hw.h |   5 +
 include/linux/dsa/tag_netc.h          |  17 ++
 net/dsa/tag_netc.c                    |  69 ++++-
 7 files changed, 510 insertions(+), 6 deletions(-)

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
index e93c15f57200..ba849dfa1b80 100644
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
@@ -1699,6 +1700,7 @@ static void netc_port_disable(struct dsa_switch *ds, int port)
 	if (!np->enable)
 		return;
 
+	netc_port_disable_onestep(np);
 	clk_disable_unprepare(np->ref_clk);
 	np->enable = false;
 }
@@ -2567,6 +2569,7 @@ static void netc_mac_link_up(struct phylink_config *config,
 	netc_port_set_rx_pause(np, rx_pause);
 	netc_port_mac_tx_enable(np);
 	netc_port_mac_rx_enable(np);
+	netc_port_enable_onestep(np);
 }
 
 static void netc_mac_link_down(struct phylink_config *config,
@@ -2577,6 +2580,7 @@ static void netc_mac_link_down(struct phylink_config *config,
 	struct netc_port *np;
 
 	np = NETC_PORT(dp->ds, dp->index);
+	netc_port_disable_onestep(np);
 	netc_port_mac_rx_graceful_stop(np);
 	netc_port_mac_tx_graceful_stop(np);
 	netc_port_remove_dynamic_entries(np);
diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
index 0bcc01ebf01d..738855bd4bbf 100644
--- a/drivers/net/dsa/netc/netc_ptp.c
+++ b/drivers/net/dsa/netc/netc_ptp.c
@@ -11,6 +11,16 @@
 
 #define NETC_NUM_TS_REQ_ID		16
 #define NETC_TSTAMP_TIMEOUT		(5 * HZ)
+#define NETC_MAX_STEP_OFFSET		0x1ff
+#define NETC_ONESTEP_QTH		512
+/* The 30-bit timestamp of the To_Port subtype 3 tag lets the hardware
+ * account for a single wrap, so the correction field of a one-step Sync
+ * frame is only correct if it is sent out within 2^30 ns after the
+ * software timestamp is read. Past this window, the in-flight frame is
+ * already invalid, whether it has been dropped or not, so PM_SINGLE_STEP
+ * can be reprogrammed for the next frame.
+ */
+#define NETC_ONESTEP_VALID_WINDOW	0x40000000 /* ns */
 
 static void netc_port_tstamp_timeout_work(struct work_struct *work)
 {
@@ -18,9 +28,11 @@ static void netc_port_tstamp_timeout_work(struct work_struct *work)
 					    tstamp_timeout_work.work);
 	struct sk_buff_head free_list;
 	struct sk_buff *skb, *skb_tmp;
+	bool resume_onestep = false;
 
 	__skb_queue_head_init(&free_list);
 
+	spin_lock_bh(&np->onestep_lock);
 	spin_lock_bh(&np->tstamp_lock);
 	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp) {
 		if (time_is_after_jiffies64(NETC_SKB_CB(skb)->ptp_tx_time +
@@ -31,6 +43,16 @@ static void netc_port_tstamp_timeout_work(struct work_struct *work)
 				    "Port %d ts_req_id %u which seems lost\n",
 				    np->dp->index, NETC_SKB_CB(skb)->ts_req_id);
 
+		/* If the timed-out skb is the one holding the in-flight
+		 * one-step frame's ts_req_id, resume the drain. Otherwise
+		 * the frames queued on onestep_queue would never be sent or
+		 * freed unless new traffic happened to arrive.
+		 */
+		if (NETC_SKB_CB(skb)->ptp_flag == NETC_PTP_FLAG_ONESTEP &&
+		    NETC_SKB_CB(skb)->ts_req_id == np->onestep_ts_req_id &&
+		    np->onestep_state == NETC_ONESTEP_IN_FLIGHT)
+			resume_onestep = true;
+
 		__skb_unlink(skb, &np->tstamp_queue);
 		__skb_queue_tail(&free_list, skb);
 	}
@@ -43,6 +65,13 @@ static void netc_port_tstamp_timeout_work(struct work_struct *work)
 				      NETC_TSTAMP_TIMEOUT);
 
 	spin_unlock_bh(&np->tstamp_lock);
+
+	if (resume_onestep) {
+		np->onestep_state = NETC_ONESTEP_SCHEDULED;
+		schedule_work(&np->onestep_work);
+	}
+
+	spin_unlock_bh(&np->onestep_lock);
 	__skb_queue_purge(&free_list);
 }
 
@@ -68,8 +97,283 @@ static int netc_get_ts_req_id(struct netc_port *np)
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
+		uh = (struct udphdr *)(hdr + tstamp_offset - UDP_HLEN -
+				       sizeof(struct ptp_header));
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
+static void netc_tx_dropped_add(struct net_device *ndev, u32 cnt)
+{
+	for (u32 i = 0; i < cnt; i++)
+		dev_core_stats_tx_dropped_inc(ndev);
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
+	netc_tx_dropped_add(np->dp->user, skb_queue_len(&free_list));
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
+	netc_tx_dropped_add(np->dp->user, skb_queue_len(&free_list));
+	__skb_queue_purge(&free_list);
+}
+
+static void netc_port_onestep_work(struct work_struct *work)
+{
+	struct netc_port *np = container_of(work, struct netc_port,
+					    onestep_work);
+	struct netc_switch *priv = np->switch_priv;
+	struct net_device *ndev = np->dp->user;
+	struct netc_tagger_data *tagger_data;
+	struct sk_buff *dummy_skb = NULL;
+	struct sk_buff *skb = NULL;
+	int ts_req_id;
+	u32 qlen = 0;
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
+	/* dummy_skb is a ts_req_id token only, it doesn't need any payload */
+	dummy_skb = alloc_skb(0, GFP_ATOMIC);
+	if (unlikely(!dummy_skb)) {
+		kfree_skb(skb);
+		dev_core_stats_tx_dropped_inc(ndev);
+		goto skb_dequeue;
+	}
+
+	spin_lock_bh(&np->tstamp_lock);
+	ts_req_id = netc_get_ts_req_id(np);
+	if (unlikely(ts_req_id < 0)) {
+		spin_unlock_bh(&np->tstamp_lock);
+
+		/* The ts_req_id pool may stay exhausted, so re-queuing and
+		 * rescheduling could spin the work forever. Drop this frame
+		 * and move on, even if that ends up draining the whole queue.
+		 * This only occurs in the extreme case, once the ts_req_id
+		 * pool recovers, later frames are handled normally and PTP
+		 * re-converges.
+		 */
+		np->onestep_state = NETC_ONESTEP_SCHEDULED;
+		dev_core_stats_tx_dropped_inc(ndev);
+		schedule_work(&np->onestep_work);
+
+		goto onestep_unlock;
+	}
+
+	/* PHC is unavailable, drop the whole queue */
+	if (unlikely(netc_get_phc_time(priv, &tstamp))) {
+		spin_unlock_bh(&np->tstamp_lock);
+		dev_core_stats_tx_dropped_inc(ndev);
+		goto set_onestep_state_idle;
+	}
+
+	NETC_SKB_CB(skb)->tstamp = tstamp;
+	NETC_SKB_CB(skb)->ts_req_id = ts_req_id;
+	NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
+	NETC_SKB_CB(dummy_skb)->ts_req_id = ts_req_id;
+	NETC_SKB_CB(dummy_skb)->ptp_tx_time = get_jiffies_64();
+	NETC_SKB_CB(dummy_skb)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
+	np->onestep_tx_time = NETC_SKB_CB(dummy_skb)->ptp_tx_time;
+	np->onestep_ts_req_id = ts_req_id;
+
+	__skb_queue_tail(&np->tstamp_queue, dummy_skb);
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
+	tagger_data->onestep_sync_xmit(skb, ndev);
+
+	return;
+
+set_onestep_state_idle:
+	np->onestep_state = NETC_ONESTEP_IDLE;
+purge_onestep_queue:
+	qlen = skb_queue_len(&np->onestep_queue);
+	__skb_queue_purge(&np->onestep_queue);
+onestep_unlock:
+	spin_unlock_bh(&np->onestep_lock);
+	netc_tx_dropped_add(ndev, qlen);
+	kfree_skb(skb);
+	kfree_skb(dummy_skb);
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
+	    time_is_before_jiffies64(expire_time))
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
+	if (unlikely(np->onestep_state == NETC_ONESTEP_PORT_INACTIVE))
+		goto free_skb;
+
+	if (unlikely(skb_queue_len(&np->onestep_queue) >= NETC_ONESTEP_QTH))
+		goto free_skb;
+
+	__skb_queue_tail(&np->onestep_queue, skb);
+	if (likely(np->onestep_state == NETC_ONESTEP_IDLE) ||
+	    netc_onestep_timeout(np)) {
+		np->onestep_state = NETC_ONESTEP_SCHEDULED;
+		schedule_work(&np->onestep_work);
+	}
+
+	spin_unlock_bh(&np->onestep_lock);
+
+	return;
+
+free_skb:
+	kfree_skb(skb);
+	dev_core_stats_tx_dropped_inc(np->dp->user);
+	spin_unlock_bh(&np->onestep_lock);
+}
+
 void netc_port_ptp_init(struct netc_port *np)
 {
+	spin_lock_init(&np->onestep_lock);
+	__skb_queue_head_init(&np->onestep_queue);
+	INIT_WORK(&np->onestep_work, netc_port_onestep_work);
+
+	np->onestep_state = NETC_ONESTEP_PORT_INACTIVE;
 	spin_lock_init(&np->tstamp_lock);
 	__skb_queue_head_init(&np->tstamp_queue);
 	INIT_DELAYED_WORK(&np->tstamp_timeout_work,
@@ -111,7 +415,8 @@ int netc_get_ts_info(struct dsa_switch *ds, int port,
 				 SOF_TIMESTAMPING_RX_HARDWARE |
 				 SOF_TIMESTAMPING_RAW_HARDWARE;
 
-	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON) |
+			 BIT(HWTSTAMP_TX_ONESTEP_SYNC);
 
 	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
 			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
@@ -331,6 +636,7 @@ int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
 		return -EOPNOTSUPP;
 
 	switch (config->tx_type) {
+	case HWTSTAMP_TX_ONESTEP_SYNC:
 	case HWTSTAMP_TX_ON:
 	case HWTSTAMP_TX_OFF:
 		break;
@@ -368,6 +674,9 @@ int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
 	}
 
 	WRITE_ONCE(np->ptp_tx_type, config->tx_type);
+	if (config->tx_type != HWTSTAMP_TX_ONESTEP_SYNC)
+		netc_port_purge_onestep_queue(np);
+
 	config->rx_filter = rx_filter;
 
 	return 0;
@@ -409,6 +718,67 @@ int netc_port_hwtstamp_get(struct dsa_switch *ds, int port,
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
+	/* Ensure the buffer is linear and writable so the packet can be
+	 * parsed and updated in place. Otherwise, fall back to two-step.
+	 */
+	if (unlikely(skb_linearize_cow(skb))) {
+		*twostep = true;
+		return;
+	}
+
+	ptp_hdr = ptp_parse_header(skb, ptp_class);
+	if (unlikely(!ptp_hdr)) {
+		*twostep = true;
+		return;
+	}
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
+		     correction_offset > NETC_MAX_STEP_OFFSET)) {
+		NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_DROP;
+		dev_core_stats_tx_dropped_inc(np->dp->user);
+		dev_dbg_ratelimited(priv->dev,
+				    "Port %d: PTP frame dropped in error\n",
+				    np->dp->index);
+		return;
+	}
+
+	pkt_type = ptp_class & PTP_CLASS_PMASK;
+	if (pkt_type == PTP_CLASS_IPV4 || pkt_type == PTP_CLASS_IPV6)
+		is_udp = true;
+
+	NETC_SKB_CB(skb)->correction_offset = correction_offset;
+	NETC_SKB_CB(skb)->timestamp_offset = tstamp_offset;
+	NETC_SKB_CB(skb)->is_udp = is_udp;
+	NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
+}
+
 static void netc_port_prepare_twostep(struct netc_port *np,
 				      struct sk_buff *nskb)
 {
@@ -448,6 +818,8 @@ void netc_port_txtstamp_handler(struct dsa_switch *ds, int port,
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct skb_shared_hwtstamps hwtstamps;
 
+	spin_lock_bh(&np->onestep_lock);
+
 	spin_lock_bh(&np->tstamp_lock);
 	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp) {
 		if (NETC_SKB_CB(skb)->ts_req_id != ts_req_id)
@@ -460,12 +832,27 @@ void netc_port_txtstamp_handler(struct dsa_switch *ds, int port,
 	spin_unlock_bh(&np->tstamp_lock);
 
 	if (!skb_match) {
+		spin_unlock_bh(&np->onestep_lock);
 		dev_dbg_ratelimited(np->switch_priv->dev,
 				    "Port %d ts_req_id %u which seems lost\n",
 				    port, ts_req_id);
 		return;
 	}
 
+	if (NETC_SKB_CB(skb_match)->ptp_flag == NETC_PTP_FLAG_ONESTEP) {
+		if (likely(np->onestep_state == NETC_ONESTEP_IN_FLIGHT &&
+			   np->onestep_ts_req_id == ts_req_id) ||
+		    np->onestep_state == NETC_ONESTEP_IDLE) {
+			np->onestep_state = NETC_ONESTEP_SCHEDULED;
+			schedule_work(&np->onestep_work);
+		}
+		spin_unlock_bh(&np->onestep_lock);
+		consume_skb(skb_match);
+		return;
+	}
+
+	spin_unlock_bh(&np->onestep_lock);
+
 	hwtstamps.hwtstamp = ns_to_ktime(ts);
 	skb_complete_tx_timestamp(skb_match, &hwtstamps);
 }
@@ -486,6 +873,7 @@ bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
 void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	bool twostep = false;
 	u32 ptp_class;
 	int tx_type;
 
@@ -499,6 +887,9 @@ void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
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
index 5a8e57b01f35..ae5e24c91f1c 100644
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
 
+	/* Serialize access to onestep_queue, onestep_state, onestep_tx_time
+	 * and onestep_ts_req_id
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


