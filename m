Return-Path: <linuxppc-dev+bounces-25494-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459BDC5AC80
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 16:40:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGChB4Rk7z308X;
	Fri, 07 Aug 2026 02:40:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786034442;
	cv=pass; b=OnCd215NnxCuph+jOanmHX8o6YPNwJewgjWsrMLcNJ3eYc/wGzdFL/cYCBhsY78H5n+r11iQ+wEmXkN5h56lvOissRAEMLiEOKtFNmM8B1bETCk3j9sTKPuRD7swrS3NT/xTX4hyf2sp/QZvFSBB3gSsAyH4/70KUeFj3AQ3vaKEdFn0L+Pqvc5+jOd4p9fXcqhKRyUn97wGOVWHA3v7hvepEdRL8QAukljhDPav4xzd7YBAqLO2epG6d4VDewl8s0eC25rNe71PWLnKqzagmfCvY5JyzNq06NTKu+Wjp8Unvo64uIIEPPWL3f4vSfqJqr2lpW/+2zrFcqnYEnDaCA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786034442; c=relaxed/relaxed;
	bh=hPiRNVZIox1wV4o670edvUM7O5g9WqmqCCUw4mEWoTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UvhAtQbqJsh/YU07ccNpPpehKVTzdv2N8TgGp0PtgxJSYFc5bwDJWA24mNYm/1m57Cjbn2mlopDr+Bn8YV+HTlZdMlgW58Vgf3ygBQH0BR93DqTJmMPREG3WI2sQO6DWVQ/Sj8eVKeg6uNiFBXn0PcB0PY+ebIbEDwivl1ajc2OeUjnSBFeh9Vkb9dcHaxlGcUe/LNpPIPtGMCC27iUvZzcIIUwR401iZW9Sa/6pOYyfCXi+JATW1YRkroE2iTp6E1jnzKvhvxAUy0KSnxOIi0L5iuXrP1t492PQs0/auQQH9AYblBu4+cesURl+cQTREjZqWWTh5YD3vh8gOOfMtg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tDvj1Ffs; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tDvj1Ffs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGCh91R0Vz3080
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 02:40:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnWZCk3GBySXfeTONQcUtn5qssx/one4QTtE1Yy+z/DlJXmAVJiBxsWTQ0CGJp/rig91owzJgT9vCphSdDkqNoSGIPQYk9DZ+rFFxDVky+7FAbCZzwZomYK0cHi8oSRid5+UfcJAidPX8CkCgoh2Xo25RvOpFzcCD4g0+COzb7YoibJtcnaga4BRwN+41XxpJfr8bywqZigFxp9OMLVhUMyojVLzM5cqGwOA0B/umNHJ42NC+QhqNeFlGCMuQN8nLCOQjYqZNXzqR1Zq6P7wC4nMpxVpIdlj2+rUjmbZwQ1jlzXxHdtCO4nbwip5qhaMP6IRGuHlNXzCAz8NGVZjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPiRNVZIox1wV4o670edvUM7O5g9WqmqCCUw4mEWoTs=;
 b=W6uAqb4xtXuZdKD0mwzXK/EnJGGbUeXd5G+keQWweYZk4CkpiALiawZABhQZfH6jZJO/uqvBAd95GGm0b5hIHg8QaQVlFje/AL9XiXZ5um460dxEtyD412+Ey9ufyeST9yfgHV7T4j+Eo9uVuqVKm5ktV5VrLvF5CnkMCPdp3VL7TeX7O86+uQ/qLN9H9WpOMn6diybt8bfuspYTQ26VEv/yCSGPTxpfrEcPyrTwL4Zz4A5bEdrwnAzec9mgJfJU0BJAks6wNDkH0X40F/q308L04ipG7SRfURqserZTiN/EKt/w71Y5BP14ibcRyUaXOls+jE4zigTSFaVfclQ+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPiRNVZIox1wV4o670edvUM7O5g9WqmqCCUw4mEWoTs=;
 b=tDvj1FfsIl36L8tAy2+NTDTYBHQQrgvKSFbTMomAAe0B0b0FZTBbujjZEHxB4u5Y+2+Vkuy0tCj2qx91nWq+oye8pO3HKMl9ocaefURdMMZBR8f7XOo2/uqC8rj20dg8DUoHn79t2FJssHmB//SP9Ar/wCWthSri149XfHevfLHJoQoHfbrKQ4QDuruJach5DfZ5KeaKoqiRJG1jwGVhEnPXvZeOhHMO6KUbWkP5U2aU226k/eDpawl8yNsD84Qgqk+CjjHprKf/n5dUR8iaUleqXjmYQcvk8vxjthRyP+i39d1vISUu2vB72bj+4tB4la6LfvCy2uSANSLKlMNzSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DUZPR04MB10062.eurprd04.prod.outlook.com (2603:10a6:10:4e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 16:40:16 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 16:40:16 +0000
Date: Thu, 6 Aug 2026 11:40:07 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, shawnguo@kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
 binding to support multiple paths
Message-ID: <anS454bPBMuKW0Ga@SMW015318>
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
 <20260804100218.49587-2-shengjiu.wang@oss.nxp.com>
 <anH5i7y3JkB1moee@SMW015318>
 <CAA+D8ANCoc5qOUvTQPRNkvrfqAY3n6x_fbfUveP8Sfv+SL1NVw@mail.gmail.com>
 <anNtgkZYhoWsSRr6@SMW015318>
 <CAA+D8APMT2eSgrc37n_YZ4PsDZ-_8h4gHsyhADGGYDpTob_g+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8APMT2eSgrc37n_YZ4PsDZ-_8h4gHsyhADGGYDpTob_g+Q@mail.gmail.com>
X-ClientProxiedBy: SA1P222CA0049.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DUZPR04MB10062:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b27a62-c42f-47e0-6e1c-08def3d96527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|19092799006|11063799006|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	cw5aupP/9pSLJKdMfsBZ1YXWV9EoSOmgeHPvdtA1pB5do7FPyGpWnHp+F3p3G49/itGXFc76C9Z6/fs/d9/RrGgIb+5SMsjs5azY+EBmivrqzmlWCKKGUd6+ZVNUnWkekUnjIxUp4oUzQjJjMo8asGQxhjSIHoYgM3wBvuCHZLUAu9tGdPDYiEp283lLJzuJKDJbzDdILY+uA8wk8quOcqvKfvYEPl96gSUv3FoJoBSRIss+lJnXk6QrsSL2aG3oJ0sUs6VPC8k9tok+cMW69I/bodZtlS3yS8Ji3Lm8GNesgSTK+yg8gUxGVqPpZZ3nzB69txvxQHO8AvvqkLihAgkucl30h6M1rFo9pLoT5eyRURshKxMkwW5QRK5Gu/u29zrJLcCQ3vXwwiCc3tdAL8ExTKg0wXZtilJy6sXeQEYHifvuk6OXtOelRwm/T0ZKqq7s8ONtdllBS4pqHM9Dwl+UYt7hu7Ekm/2iKEYQinan5so3tb2iv5iXsabr1SvIo9RdWDIJAXsuR4qDj0yJHu8qqg+k3TWPKtc72aKZDhKNYaGZlooznZ6lluSwm9mXnQ1uhMfl9DYKMuWgXh/+kCyt2wb6KKQ57HtSoEEG7UNEqMc4ohfcddWwxbrcOK60j7bigmrDdmIRnmKAGNPEZvyzEsscrjN5MvSr6SwMQnI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(19092799006)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW11Q2kvWGgydjcvY0pDZ29xUStYMXNwbWxkZitWN3AwV0oxYm84czhrZWU5?=
 =?utf-8?B?c09mb01HU1FObm1HdldNMDc5SlFFYWVGZzd5emg2REVGbytzbWUvVkNVWTRJ?=
 =?utf-8?B?WVd1T3hYQW9tUWlCU2NLb0h4ekFjY0lVQ1NJY09YMUR4M0R3MW9KeWZoTTRL?=
 =?utf-8?B?Zzl4SllOZ3VBMVJweE5uOWFoK0x3Q1p3RmRoUktocUdXdGg3RllMVnJsaWZi?=
 =?utf-8?B?N2JFeXMzbmh5WmNKVHpJMUN0NG1WQS91Mjd3N29RMTh0eHFXYUdoYVo0TDlS?=
 =?utf-8?B?Qnk5aTEwZHNMM2YxbVIvV0VZUEQzVHU5QzF2Wk1SbTVNMG5QYndhZGNzeStx?=
 =?utf-8?B?NVBMbUFMZzBxNi9kQ3REWWkyNFRDQi91WkR5dndaMXlCM05jOVhkTXd5bmlx?=
 =?utf-8?B?ZWFManJEc0RnV0xhVkRVdE0xOUJKYWtBL1IrYkxHN01nZkVyaERpcWRJUU92?=
 =?utf-8?B?ZGJYcHZlVmIrVFUwWE9wQ2JIeENXTFprU2hYaHpyWUN3T0VIdmtvMjY2YWxW?=
 =?utf-8?B?dlNScGxoNnEzSDMwVCtJZTFLWk9uTXF0YzBqbklvT3hLUWpMeXllVzJsTnRz?=
 =?utf-8?B?Tjhibm5ESzlZTWZSRnJxRWpqbURnR1I0VXNNd001cWlwTXJNTE1nSDRKenh6?=
 =?utf-8?B?THhRdXZrQmtDdEFwQ2owaEFSL2NQeTVwS1ZjU0ZYRHJGNGF3ampKOG9IYS9j?=
 =?utf-8?B?U2JFbWpnTzNjZ3pFMUdvdEVLYjR2bDhPai9UWEpraWQyNFVFR3kwSEw1NzA1?=
 =?utf-8?B?MXBHcmNQbTUwNjdRVjdHMUZNbXNpSUhKc2paQ2FvOXlxc1NDZnBoSTNLMHdn?=
 =?utf-8?B?MkVEVm16TDVYdFpmWGNYUE1wN1ZYN1VhV0pqdWdGWkRYVkp5czVDZmUwcmdE?=
 =?utf-8?B?KzVZYzZQR0RFOFYrZkJIMkpRbE5wLzlvQlpJTWhBc3hSK092cnpTQmNGQ0pD?=
 =?utf-8?B?N2N1cUtTUTVqZ1FZUzc3c29tNVdQU2dnNmpyT3dGRlVpcGJ1S25sM3Q4d2xw?=
 =?utf-8?B?UFFRTTJvcGo5K1ZGRUlkemFIaUtHREVKUXAvTHRSdG5yV1lWZzY2TGJSVE1z?=
 =?utf-8?B?RXJFOHBBa3pRR1hzT1U4dUhjNWt5Umx4bFo4M1QyZmtHL3Z3N3hUREdSUWdy?=
 =?utf-8?B?M0IveU0rUHNCWUo3WEVrQXJuTDVaa0kzTXRmWlVDbG40ZkNyL1doQk5mQzR2?=
 =?utf-8?B?LzRWWjNLVEN2WlM2Z0tTeVJ4bjg1SDBSQ0VDdTNjckRKOXJSQzkwd0w1Z0Nk?=
 =?utf-8?B?YmhXeUJZZnl2Rk1JbGV4VEtRa2FXM0EvdDJBUU52bmlFSStKcmJGRXIybEEy?=
 =?utf-8?B?aWtZOUN2cFNxWGowaitMeFRKdE1ETmczTWVCSkhjMmJoVzFQZzF1M1d4QTFV?=
 =?utf-8?B?eXRqcDVSb01BdURUU2t3cHBZMlcvcnlZZE9KSXpXTmdsemRkbjVrdi9zMUlH?=
 =?utf-8?B?L043YWdnaEw1T0Q0WEx6b2wzdEhmTFV5UXdBSUZPVzFGRG0xcVlpWjl4MkZO?=
 =?utf-8?B?aFdkWUthUUU5cEhJbC9ZdmtqVVpqeW1hSGI5aUZsS1k3NkdjNXh1S0swODlL?=
 =?utf-8?B?VGxkNHpyUjYzYlprdmExVWw1MDQ4RHR6bk8xbzBoZUdpa2VsQjdRT2JCQk05?=
 =?utf-8?B?MXgrUHhMWURvZzdGVS9hWmh1SUw0ZzJjbkZJMEkyU0J1WjZGVi9XZEZJb3I3?=
 =?utf-8?B?QS8zQ1J6Qm4wb1gzaEVRRncvekVjRy9Hb3FBTUtFK2FTQ3kvZkhjOEpiSlRa?=
 =?utf-8?B?UldHOTA1SmJPR3Nsc3RzKzlMNWZlWDlNY2hQZGF5NEVJY0tUVi80c1k3WG52?=
 =?utf-8?B?TytVa1hSRXA2SlRyREtsZHJnY3dDYXk2SUtVRktvRmpFMmtaQ3p2QS8yUldY?=
 =?utf-8?B?L3U5WkppRjlWT2FIYXJlSDA3d1V4ZVY2OE1mNFhLT1hyaWR3eXh6S0lVbitt?=
 =?utf-8?B?K2JUQUVyUm5seXRJTy9iMjZVYmxSSHFJYy9ldWtUTDM3UE9sSTRualFSZzE1?=
 =?utf-8?B?cHMrL2cxYVBpMGFuVWI1RWppaGduOXdmdDRUbDJkcmZkY2IyY1kzRFBEdTY4?=
 =?utf-8?B?SXRpbFdwOE1nMjBXdUdZSnNFRm5UNGRzUlErMjdyaStEN21oWkM4WW8rK0xP?=
 =?utf-8?B?eXExdVlNVTN4U2dNeG1ONWZmYWh5cmJlck9aUmVhcmx1NEZiNjRzTjdFb1N6?=
 =?utf-8?B?RnJPU3RqMmIyOGJBWGhqUXhhUS92MXErRHdvdjVpS2t4T04wWG1NRS9OVHB5?=
 =?utf-8?B?cER5OWlzYzZsTGdwOSt0eTVMdEhFenU2eGllNEhGVkFzMS8rWDk5TisvbHVV?=
 =?utf-8?B?dGNxZFV0K1BpdGRmdGtNRG5TQVBCd1I3ZEUzaGdyL2hTNkh2dzc1NXNSS2VZ?=
 =?utf-8?Q?I0Ka4zXltNcaScFEpjaPrPiUHpfqKbETctMlx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b27a62-c42f-47e0-6e1c-08def3d96527
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 16:40:16.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: totXe/33wWMFWu/gTa/NQIHOgw7BHnAHLqlqv04dEFGKLRxt3ykkOC4QkVa9D+uGbULF1eKyuSWUadTvRpd5giyicY01WZ+H4FI+HEm1IQjabKbEMm8YmOUT2dn7ZPzD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10062

On Thu, Aug 06, 2026 at 01:27:51PM +0800, Shengjiu Wang wrote:
> On Thu, Aug 6, 2026 at 1:06 AM Frank Li <Frank.li@oss.nxp.com> wrote:
> >
> > On Wed, Aug 05, 2026 at 02:57:59PM +0800, Shengjiu Wang wrote:
> > > On Tue, Aug 4, 2026 at 10:39 PM Frank Li <Frank.li@oss.nxp.com> wrote:
> > > >
> > > > On Tue, Aug 04, 2026 at 06:02:14PM +0800, shengjiu.wang@oss.nxp.com wrote:
> > > > > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > >
> > > > > The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
> > > > > The existing binding exposed only a single generic audio-graph port,
> > > > > which cannot represent independent conversion paths when multiple pairs
> > > > > are in use simultaneously.
> > > > >
> > > > > Add a ports container that enumerates up to three sub-ports, each
> > > > > representing an independent conversion path:
> > > > >   port@0 -- conversion path 0
> > > > >   port@1 -- conversion path 1
> > > > >   port@2 -- conversion path 2
> > > > >
> > > > > Each sub-port references audio-graph-port.yaml as before. Hardware pairs
> > > > > are allocated dynamically at stream open time; each active stream
> > > > > direction (playback or capture) on a port consumes one hardware pair.
> > > > >
> > > > > For backwards compatibility, keep the old single port property but mark
> > > > > it deprecated. A schema constraint (not: required: [port, ports]) ensures
> > > > > that both forms cannot be used at the same time. The binding example is
> > > > > updated to show the preferred ports form.
> > > > >
> > > > > No existing upstream DTS file for fsl,imx-asrc uses the previously
> > > > > documented single 'port' node, so this change does not break any
> > > > > in-tree device tree.
> > > >
> > > > if no existing upstream DTS file use it, you can direct replace with ports
> > >
> > > That is to avoid any downstream use of the 'port', so not directly replace it.
> >
> > Does downstream strictly run DTB_CHECK ?
>
> I don't know if anyone downstream uses the 'port' or not.  so keep it
> in this file but
> mark it is as deprecated to avoid any impact of this change (add 'ports')

Prevent new DTS use "port". If upstream have used it already, we have to
keep it as deprecated. But no upstream dts use it yet, simple remove it
can successfully prevent a new dts use "port".

Other downstream tree is not well reviewed. We needn't consider that,
especially in bind doc, which define ABI, not make "real" function broken.

If you want to delete driver code support, it needs consider more about
back compatiblity.

Frank

>
> Best regards
> Shengjiu Wang

