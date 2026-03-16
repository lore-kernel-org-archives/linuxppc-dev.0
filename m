Return-Path: <linuxppc-dev+bounces-18234-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4221FF4643A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 09:42:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ99V322Gz2ynZ;
	Mon, 16 Mar 2026 20:42:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773654142;
	cv=pass; b=DyD+MwWwKrN9YaTcOncVdm7TlCSQdKwAHP4Wv7xCJdy5HBv5ur3U5bUQCQdzTMCXXaCy1SJ/yUGDWAQwt8VTYnnKrLeY8ODJkGrOsYTCfUVAyBomInFu6v+8+j0p6y4h8aZKxY+ce90DVPPd42ZhZL3X3rZuCNnZwS50A9lWg0B0lej10Y5YArBZMHndwjH01uDKHKsiN1culNq/keZ2QQS1efMt8sRPB+qLKDCes+MRKfM1ldCAzo1H7tpJ5aabSheYKWs0PuWLMRaW/S6cN/AXiIU9ly/1Hs1I8LYcjrrzEeq4R/5PjG+MMB+7/tV+jkvLVQEK27uSm/jUcE4UJQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773654142; c=relaxed/relaxed;
	bh=27Pg8IakwBSGaKcOEP/92IebPrh+utdckt5wr4n1GLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M5d3hWvLxLrzLl2zTOyoECiXVc6WeJXRgJammgILxVS56Nk1b3KL4gBcDgsFs60O8WOxf8EgsURVqMor01p9UfyAaU0k5EjlaOKAiv4uXFpjW9v+WmsPx+gLG7N9ZEEGA9gO3mgGM1pK8gbZPr0A7NmVYwt4TBDnRvfuy7/t/npZOZSBCFMrJkLXMZQHrUQ7iSqc6ydRW3OtJATydQV7V6XotZhhgZy0rZGA5YNsRi/GGCage8Mk0xclZkT2C+/NrsWWKY/IUv20EKIGqmP0zHP9hlmfsCAYq/tE1bMG0O/dXRS7yepQ08QyDl9/n+cl87dYG2ZG0tf3mgRDc0KzqA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Dn6ruHJA; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Dn6ruHJA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ99T3TPRz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 20:42:21 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LK7ZrnPQfG71vO4Hj5gMyzqHU33p0ySP0iNOvAXwkgJGSLgY6HHSVYYEYjP/4/y7JBdWLLJoGWmdKcKG0WkPn1eRyAwRRP//ZeJq/tVK6eKS8XnYZ2JVFOkrsqXtnNnAP3RY8gAeHtockJY74l1StYbGFvFGCEdu/ZMQ7ZSJ3KYgNts+mcHlmYOFnvTjid68t19go6OkuXj9MdVkm/ws+IBo6fLwX0BzSXJeVLVSyHN+nM5hS2npqG1s+c05KpxMo0nWzCkiyb5SgjKhteMHeYqG7dxa5OfxLrKbhhDRfikXrvHayh/cucBkgPvWNA2py+0qJ7YZBfAN/GTyM45Ywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27Pg8IakwBSGaKcOEP/92IebPrh+utdckt5wr4n1GLk=;
 b=DiS/KXlq8+TLuhe3rA+itkdHUOhX+IBQvhVSkXwTvwcmMNIBJ78CiAh+QEIgU8/wf05XCxBAABCbWCjNL8nTC7nog9FGSQjMSV4Q/M+qfwfaeXpRMNF2XxxJu5sMOx6Cf/t0fXDP6quI7Et0V1Z0rjcpSew+sNRyO1spHxuZc3sJzLAhm6cWE6OfpvqE05HRZDWpkV4yGe0d6WwsJNfAvdpxC2YSjUwtD8zw1gqNnNHv0+n0Wbmn/pHsfJ4KjavlMIpQ3J0CSpBDh70OsTGO20YghzI366lJ+MIScRrsLQ+SJain9wWQf11J97J4rRrxeZCuHCkjpxkkfkmbT4fEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27Pg8IakwBSGaKcOEP/92IebPrh+utdckt5wr4n1GLk=;
 b=Dn6ruHJAZhuagUoEVbsiQQdbL71DvT2DvGlBVHHmnH5PXUjGwvuaVwTeTT1VIiFdyZoN8E7jNetZY7vCKbEk2pvHEdbhuLirByGbnHGo1z8+EHZiFwQYnA1qLHFENXc2MB2hDDdRrARqCzcCtGzikNvaO9WWS69PtPf68tmKEdnNYhhI56x0oBNS65Mv+CUmp/IgVbUtxN9vScEg5kvzMHxmysM/I6sNWKDbEfxPtzTtnHXng83jZPxoy8JBC26MvSm9N/pMVaKUraz1tKLmEuuve1eOK9egd1G/lPSZrOhG68vhzaReRc2UFdOzmxUMs73U+tvRfRyE69kJ3mZloA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7953.eurprd04.prod.outlook.com (2603:10a6:20b:246::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 09:41:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 09:41:58 +0000
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
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 13/14] net: dsa: netc: initialize buffer bool table and implement flow-control
Date: Mon, 16 Mar 2026 17:41:51 +0800
Message-Id: <20260316094152.1558671-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316094152.1558671-1-wei.fang@nxp.com>
References: <20260316094152.1558671-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9b97b3-1e55-43ab-20ff-08de8340447b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xixc83eN/GAmUwapIJTGvJTH7pnykNRUgxX6c5MqLGsPEEHSVo/+w8RkUiP3QoUZ6e7Es3H4JTK8t4rMk4eE1bM+EGSJ73/VqWT8str8gX3fWmvzIexhF42Qebxrlcft7MzjVz8xd0idQz5zULPe17muZWaR80NcGLegF8gSyTWKFBaslsXh8A7jW9E/yHeWYlwccJAAG7VUb2CtsrlZgj27GNLzZfw3fv0fdwFYa2UrwqCum7ssfXZukS/XCCh5SEN/DwsXp0SSf9MEw3cGJuTd/pgBJdICyVMm014rq1wXAMKsn/zK/CKFwkZNDN2NNpbS+5Y5Sx8EoA+uq662EidUdT+89VP7ASXp+NO2fwerdKgEbDxSuaAWrLFRivK4ksgRaw59OKhaO/dSgAe6j5YWXssx7ZnR7vdknruZeC/k1ojmPoD6dvNmE2PdNoxtqdcpksHrkEfikeZZ4F1eVbkWXGG8qq7ghtAmcylL+AtTArT7hIUDGyeN0fC8GrrwrXfaNnoM39PtPge+U1Cb5dPU2CvRHVuyvlJT1Wv/QcdEl3LJv7SXtsPnSWect6TQrlgihQUcTfKJBiWslWW1lV7MKit1ywECLHpgJakf1k8DGZuJzrCTAwKLmGQb9ayJpOEdIhpZXIvDd7fCIQ6S89UGZ13f2GBJujL8cp9NTTxuL2uvk/RHpugbAw0oa6GFeGXX3PslMjYX4wysMiPqosNWCo3OP954hG5IRJXuRVS6F/i9ZzPIwBrEnDrCux3ZCiSsHJmwcemD3leuYVXDgNMuGal81r5s5jFupaYf3n4CLnt6OuM8FWuX1QgBzn1H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVlmUFZhZFhVV3prZzJCcktJVUxLL3BLNkoycXg5amZsZUk2Q1I2OCtHZ2Ux?=
 =?utf-8?B?NUVrYWZnakJJWkFBODhrMWVyYnhHOENTV2k5Qk9ZWGlPeE5pNjZUYmlhNkF4?=
 =?utf-8?B?VWZtMVFtM1lLOEJsUURKZ1kydXg4ZHFUZTJQTEhaUDVmNnZpbHdLM1NUQTl6?=
 =?utf-8?B?cWJFTTdIRWhqOUFzWDIrLzhvamVtSGcycnJzbGJWZkVaejhJcXR0ZyttR0ha?=
 =?utf-8?B?bzEvT2RoUUtMay80OFM5UWdhcVlvQ3R4T2NtQlZiOHdqNkMyMnJMdW9ZcXVn?=
 =?utf-8?B?dGNja3lyOVErRzdKSHA2WlpnVGkrZ3RQZTFua2ZEd2RhT0dpem9DQWtmblNw?=
 =?utf-8?B?OEVXYjh3YTM3RHMwYVdvcjZQVW5yeno0OUVzaEJEL3o5K2hLcjU1REpQTXZI?=
 =?utf-8?B?VDN5cWNGdkRxZVI3SWlEN3dlYkxZS0VSdDZXVkRzZUxjWkNVTURkUWEzcFVR?=
 =?utf-8?B?Rmhzak1HMS9XOVdoV1pKbU1adVdWaU9VZjRDTWR3cUpKeDZienc5clVDTXNO?=
 =?utf-8?B?Nk5qYm9KeGlWc0ZqekxLOTdMakFqYlJlaStYOXVxbW53VFlTOTJKMm42dkZj?=
 =?utf-8?B?ZGpQU0h6cVV0WkpTL1poUjZwZEVVR1NOVVBIeUVxL0tOa2w5NUZ2ekcxSlV6?=
 =?utf-8?B?alZ4QXVMY3lLTUtHWGx4L283OTZ1TWQ4dlk5K3cxL0FQQzQ4aXV5Zis5L0Rq?=
 =?utf-8?B?Q0p1bGFiYnFsR25pVU9IMHA4NDc5R1VvZXljTmNHK3ZpV2p6N2ZWcTcxYU9u?=
 =?utf-8?B?Y3E2T2x6OEFzR0RrT09KdWljenhQSU15VTM2SHdHYW9YZ1FDK044bFE5cXFF?=
 =?utf-8?B?dUMwd2h5cUVaRVJ3dDFBSmpqamxxelYyQ1hIMGk0V1Mra3VjNGhqNDdBM29N?=
 =?utf-8?B?UFI1bW9zQTZqRXFhRzJPck43L3ZLWGJoTVhoQnJrdjBVU2RYdm9ELzJZVWJX?=
 =?utf-8?B?dTZOdFg2ZzYyam9Uczc2MGpVYVFrZ1ptYVZzNVViS1kralhCMVhrQVZFM0J6?=
 =?utf-8?B?ejM0bWl5ZzVRVHd6MlBoSmlkVVR5RStQMzVhaFlFbS9BVXF2RmhrWlJmY3Yz?=
 =?utf-8?B?VDAwd01EdVdRendUK3l1ZVZJZ1puNGxrZ2NINVhzV0lTVldsejZuckRQU1Rq?=
 =?utf-8?B?ZFp3OE10UzZIWGNWNTBDSWoxalJHb3ZMcVNGNTZZSTM3ZHhuWUZJRUlxb2pp?=
 =?utf-8?B?YXY4Wm1hT1NWMkFidjJCVTZkUWVPdHAwL3FsSTRwbXBCNnozNU53NVEwQTJP?=
 =?utf-8?B?cDFZU24zbVp5d2RESEZmdmtkRk00d3I0VDBDVWo2dHpCTGR6TXRURzBrYk96?=
 =?utf-8?B?TGFHNmwvN3BzWDhyNnRlRXY2cGN3TmxSSGkvVGNMQVU2SUR3NXU2YUdWRzNR?=
 =?utf-8?B?R0xkU2hhREtFaUFIVUJqZUJtZWFVcHc3OTZFZkNSdEI3NjVZazE5Q3R5Vlhi?=
 =?utf-8?B?RDlzbUVIeDhaMUVTanVZUDZnOHdTZEY1OEtTV2I1eVEvbWNIbitTbnJBVXNR?=
 =?utf-8?B?Zm5wbFJlcy9Lem1pUDhQcmJWUlk2WGpFd0hCYnVzOVd6ZDlvdlROK1Nwd0Rn?=
 =?utf-8?B?M2ZEVnBVOUErU3F2WC9zblRnMDZpRGg4NE9va2NzZEQzSVpwWC81WC8yYSsr?=
 =?utf-8?B?V2ZHYlUyeWd6V2V1cmZVVjY0REV3L29RZDE3SUFhTWFKRnZKOHk5Q1hnL28r?=
 =?utf-8?B?NkFQYUIxbThoUGVKcFhQS1VLSmI0UVN2WWxRcjNZbWoxRE5UUmFvQ3NadUpG?=
 =?utf-8?B?ZkZObEloQWZOWkZvN0xaZzJHVmxmY3lFUVJ1SG1ZTzAxRVN4dm1LZGQ3T0Fp?=
 =?utf-8?B?SnlUNUR4Y1RHUCtIbDdrMnp5SS9QM3htWm1XaDNoVUxJNGRQTy94TVRuWVFr?=
 =?utf-8?B?dk5kb3lNaGJwZ081UEx6enZYZVQzM0ptSGpuQkhNQzhYSU00UUkwZTlXTkVC?=
 =?utf-8?B?dk1FQ1RzcmMzNEovWVVhaFk0dmZiRFg1YzZZMEViUWcyUjZmY1VEQnJneERz?=
 =?utf-8?B?QXN4QzRMR2xnd1FIK3k4U1Mzd09XajgrUVlKZ3Aya3dDckpaOUxkN01JRWJ1?=
 =?utf-8?B?dXNDRm9KVFRjMHdHd2NpU3dXZXBoTFBJejN0TVNZZCtQaXBWOUQrbG5oQWxh?=
 =?utf-8?B?WW8xWXVRVDBUci83d1J5WmZSaC9zYk9nNUN6bFphcUFyUVVaUlhOckFSYTdQ?=
 =?utf-8?B?YklZL3c2RDZ5RFF1ZEtmT0llekIzV1pUL3d5aEFHOWg2Qmp6TlB4cTdCN2dM?=
 =?utf-8?B?K2R6S0xSK21KZ1ZIbFYxZEMvbVd5bWtEUVlLMjROOTd0U0c3bDB1UUR6YS94?=
 =?utf-8?B?c0k1QllNUlE3Ykx5WkhmYTJBTjNIMk9wRlZ1amJqeEhYc1hrUnk0QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9b97b3-1e55-43ab-20ff-08de8340447b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:41:58.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/xK4T5wQb1MEeso3iiVjOZqfwb3BghjXxlmF2qC/MXXyCdXhJaYLiaOTq2qeuA01jTEQrnsb6nBqZUpfJqDlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7953

The buffer pool is a quantity of memory available for buffering a group
of flows (e.g. frames having the same priority, frames received from the
same port), while waiting to be transmitted on a port. The buffer pool
tracks internal memory consumption with upper bound limits and optionally
a non-shared portion when associated with a shared buffer pool. Currently
the shared buffer pool is not supported, it will be added in the future.

For i.MX94, the switch has 4 ports and 8 buffer pools, so each port is
allocated two buffer pools. For frames with priorities of 0 to 3, they
will be mapped to the first buffer pool; For frames with priorities of
4 to 7, they will be mapped to the second buffer pool. Each buffer pool
has a flow control on threshold and a flow control off threshold. By
setting these threshold, add the flow control support to each port.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 130 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |   9 ++
 drivers/net/dsa/netc/netc_switch_hw.h |  12 +++
 3 files changed, 151 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index fd952b507cbd..15dd8d89f66d 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -402,6 +402,8 @@ static void netc_port_set_mlo(struct netc_port *np, enum netc_mlo mlo)
 
 static void netc_port_fixed_config(struct netc_port *np)
 {
+	u32 pqnt = 0xffff, qth = 0xff00;
+
 	/* Default IPV and DR setting */
 	netc_port_rmw(np, NETC_PQOSMR, PQOSMR_VS | PQOSMR_VE,
 		      PQOSMR_VS | PQOSMR_VE);
@@ -409,6 +411,15 @@ static void netc_port_fixed_config(struct netc_port *np)
 	/* Enable L2 and L3 DOS */
 	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
 		      PCR_L2DOSE | PCR_L3DOSE);
+
+	/* Set the quanta value of TX PAUSE frame */
+	netc_mac_port_wr(np, NETC_PM_PAUSE_QUANTA(0), pqnt);
+
+	/* When a quanta timer counts down and reaches this value,
+	 * the MAC sends a refresh PAUSE frame with the programmed
+	 * full quanta value if a pause condition still exists.
+	 */
+	netc_mac_port_wr(np, NETC_PM_PAUSE_TRHESH(0), qth);
 }
 
 static void netc_port_default_config(struct netc_port *np)
@@ -640,6 +651,77 @@ static int netc_add_standalone_fdb_bcast_entry(struct netc_switch *priv)
 				       bcast, NETC_STANDALONE_PVID);
 }
 
+static u32 netc_get_buffer_pool_num(struct netc_switch *priv)
+{
+	return netc_base_rd(&priv->regs, NETC_BPCAPR) & BPCAPR_NUM_BP;
+}
+
+static void netc_port_set_pbpmcr(struct netc_port *np, u64 mapping)
+{
+	u32 pbpmcr0 = lower_32_bits(mapping);
+	u32 pbpmcr1 = upper_32_bits(mapping);
+
+	netc_port_wr(np, NETC_PBPMCR0, pbpmcr0);
+	netc_port_wr(np, NETC_PBPMCR1, pbpmcr1);
+}
+
+static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
+{
+	int num_port_bp = priv->num_bp / priv->info->num_ports;
+	int q = NETC_IPV_NUM / num_port_bp;
+	int r = NETC_IPV_NUM % num_port_bp;
+	int num = q + r;
+
+	/* IPV-to–buffer-pool mapping per port:
+	 * Each port is allocated `num_port_bp` buffer pools and supports 8
+	 * IPVs, where a higher IPV indicates a higher frame priority. Each
+	 * IPV can be mapped to only one buffer pool.
+	 *
+	 * The mapping rule is as follows:
+	 * - The first `num` IPVs share the port’s first buffer pool (index
+	 * `base_id`).
+	 * - After that, every `q` IPVs share one buffer pool, with pool
+	 * indices increasing sequentially.
+	 */
+	for (int i = 0; i < priv->info->num_ports; i++) {
+		u32 base_id = i * num_port_bp;
+		u32 bp_id = base_id;
+		u64 mapping = 0;
+
+		for (int ipv = 0; ipv < NETC_IPV_NUM; ipv++) {
+			/* Update the buffer pool index */
+			if (ipv >= num)
+				bp_id = base_id + ((ipv - num) / q) + 1;
+
+			mapping |= (u64)bp_id << (ipv * 8);
+		}
+
+		netc_port_set_pbpmcr(priv->ports[i], mapping);
+	}
+}
+
+static int netc_switch_bpt_default_config(struct netc_switch *priv)
+{
+	priv->num_bp = netc_get_buffer_pool_num(priv);
+	priv->bpt_list = devm_kcalloc(priv->dev, priv->num_bp,
+				      sizeof(struct bpt_cfge_data),
+				      GFP_KERNEL);
+	if (!priv->bpt_list)
+		return -ENOMEM;
+
+	/* Initialize the maximum threshold of each buffer pool entry */
+	for (int i = 0; i < priv->num_bp; i++) {
+		struct bpt_cfge_data *cfge = &priv->bpt_list[i];
+
+		cfge->max_thresh = cpu_to_le16(NETC_BP_THRESH);
+		ntmp_bpt_update_entry(&priv->ntmp, i, cfge);
+	}
+
+	netc_ipv_to_buffer_pool_mapping(priv);
+
+	return 0;
+}
+
 static int netc_setup(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
@@ -667,6 +749,10 @@ static int netc_setup(struct dsa_switch *ds)
 	dsa_switch_for_each_available_port(dp, ds)
 		netc_port_default_config(priv->ports[dp->index]);
 
+	err = netc_switch_bpt_default_config(priv);
+	if (err)
+		goto free_ntmp_user;
+
 	err = netc_add_standalone_vlan_entry(priv);
 	if (err)
 		goto free_ntmp_user;
@@ -1241,6 +1327,40 @@ static void netc_port_set_hd_flow_control(struct netc_port *np, bool en)
 			  en ? PM_CMD_CFG_HD_FCEN : 0);
 }
 
+static void netc_port_set_tx_pause(struct netc_port *np, bool tx_pause)
+{
+	struct netc_switch *priv = np->switch_priv;
+	int port = np->dp->index;
+	int i, j, num_bp;
+
+	num_bp = priv->num_bp / priv->info->num_ports;
+	for (i = 0, j = port * num_bp; i < num_bp; i++, j++) {
+		struct bpt_cfge_data *cfge;
+
+		cfge = &priv->bpt_list[j];
+		if (tx_pause) {
+			cfge->fc_on_thresh = cpu_to_le16(NETC_FC_THRESH_ON);
+			cfge->fc_off_thresh = cpu_to_le16(NETC_FC_THRESH_OFF);
+			cfge->fccfg_sbpen = FIELD_PREP(BPT_FC_CFG,
+						       BPT_FC_CFG_EN_BPFC);
+			cfge->fc_ports = cpu_to_le32(BIT(port));
+		} else {
+			cfge->fc_on_thresh = cpu_to_le16(0);
+			cfge->fc_off_thresh = cpu_to_le16(0);
+			cfge->fccfg_sbpen = 0;
+			cfge->fc_ports = cpu_to_le32(0);
+		}
+
+		ntmp_bpt_update_entry(&priv->ntmp, j, cfge);
+	}
+}
+
+static void netc_port_set_rx_pause(struct netc_port *np, bool rx_pause)
+{
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_PAUSE_IGN,
+			  rx_pause ? 0 : PM_CMD_CFG_PAUSE_IGN);
+}
+
 static void netc_port_mac_rx_enable(struct netc_port *np)
 {
 	netc_port_rmw(np, NETC_POR, PCR_RXDIS, 0);
@@ -1305,7 +1425,17 @@ static void netc_mac_link_up(struct phylink_config *config,
 		net_port_set_rmii_mii_mac(np, speed, duplex);
 	}
 
+	if (duplex == DUPLEX_HALF) {
+		/* As per 802.3 annex 31B, PAUSE frames are only supported
+		 * when the link is configured for full duplex operation.
+		 */
+		tx_pause = false;
+		rx_pause = false;
+	}
+
 	netc_port_set_hd_flow_control(np, duplex == DUPLEX_HALF);
+	netc_port_set_tx_pause(np, tx_pause);
+	netc_port_set_rx_pause(np, rx_pause);
 	netc_port_mac_rx_enable(np);
 }
 
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 4b229a71578e..7ebffb136b2f 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -32,6 +32,12 @@
 
 #define NETC_STANDALONE_PVID		0
 
+#define NETC_IPV_NUM			8
+/* MANT = bits 11:4, EXP = bits 3:0, threshold = MANT * 2 ^ EXP */
+#define NETC_BP_THRESH			0x334
+#define NETC_FC_THRESH_ON		0x533
+#define NETC_FC_THRESH_OFF		0x3c3
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -90,6 +96,9 @@ struct netc_switch {
 	struct ntmp_user ntmp;
 	struct hlist_head fdb_list;
 	struct mutex fdbt_lock; /* FDB table lock */
+
+	u32 num_bp;
+	struct bpt_cfge_data *bpt_list;
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index a2b0c1a712f8..7ef870fbba4d 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -12,6 +12,12 @@
 #define NETC_SWITCH_DEVICE_ID		0xeef2
 
 /* Definition of Switch base registers */
+#define NETC_BPCAPR			0x0008
+#define  BPCAPR_NUM_BP			GENMASK(7, 0)
+
+#define NETC_PBPMCR0			0x0400
+#define NETC_PBPMCR1			0x0404
+
 #define NETC_CBDRMR(a)			(0x0800 + (a) * 0x30)
 #define NETC_CBDRBAR0(a)		(0x0810 + (a) * 0x30)
 #define NETC_CBDRBAR1(a)		(0x0814 + (a) * 0x30)
@@ -163,6 +169,12 @@ enum netc_stg_stage {
 #define NETC_PM_IEVENT(a)		(0x1040 + (a) * 0x400)
 #define  PM_IEVENT_RX_EMPTY		BIT(6)
 
+#define NETC_PM_PAUSE_QUANTA(a)		(0x1054 + (a) * 0x400)
+#define  PAUSE_QUANTA_PQNT		GENMASK(15, 0)
+
+#define NETC_PM_PAUSE_TRHESH(a)		(0x1064 + (a) * 0x400)
+#define  PAUSE_TRHESH_QTH		GENMASK(15, 0)
+
 #define NETC_PM_IF_MODE(a)		(0x1300 + (a) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
 #define   IFMODE_MII			1
-- 
2.34.1


