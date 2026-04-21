Return-Path: <linuxppc-dev+bounces-19903-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19847F8FA9A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 16:52:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0T0m3hypz30GV;
	Wed, 22 Apr 2026 02:52:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c205::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776790328;
	cv=pass; b=UpqnTD+fTyW3esBV4tAMOa3KQoLrN8uMzLnk/gjFySOZ4ajg517S4SzjM6GYlxkVwWfeNUKaENqjm0/lhcIO7QhS3IvNjefvhtgDQ5+9e+iAb1uQ8hFA4cDsvOfctffVLsaa0W0UuIs9Xt5ds6vl+aeWXyjBP+TAPPV2sTfzTOTRii27AhU+ez03Zz8P1Ud6zHFb7OAnJht+aYsC/TwXFXpGpSXaaELeH/kOOjZhpL2La1yV177yVtoXKIAmKNdGo08z7S0UMrtwR8IHPBn+7hiwkvK61g6Iw8lA/d09iAn6dMjkMwZUrMc38g8GBcQ91ig+LVCxQ5MzcaKPW9Y7bQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776790328; c=relaxed/relaxed;
	bh=Ciq3sx50Hhll1QARYT7NymVeygsVpVYw9YEXGAQNXJs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=nx3oyMUqAx5yXmKAtIkoZbYLJ2hbn7cXJMuGtIAbP+qhfkXb/jCEY1SVRqAfDrnNmEJi5vQ9+BiwAqFwvxPgEZvU9Nhy/b4Obq4NXJ/RN5PrV2/DjNvTqwe2p4GQ2UPwTP0j4BF+TzcVv9aZeqY3bO7C3ffy9yyJ0ultfdbzLV2w/tzq7in+2bwyC32h2n0o2hvuS29YIQiXkrgFWm9D0R1Vq3KJpoNW16U4xPUGmikmALZitqKRoM2NmDI0Gkmtf/uHTy1Mg9v1izWMhBq7amYcC8KLN848UJYJsob36+pzrkNb3cGXcnEWpcn+4VkEW0ETmnO8Cq8mNJ3P5odKRg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=IBMuDkP+; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c205::1; helo=lo3p265cu004.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org) smtp.mailfrom=garyguo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=IBMuDkP+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=garyguo.net (client-ip=2a01:111:f403:c205::1; helo=lo3p265cu004.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org)
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c205::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0T0l0ylRz300F
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 02:52:06 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4+5gzs2R9eILkJf/LrDuvtxnRTXy/B6mTFzPCI+shI/kkMwveKf9UpypnlfDQ5BTX2ZLNGT0WYh/prXPh6yRSsxSeGtUvVP3C+PTVrHZs9hq54NKqDR8lIS5E2TaRES7dOE3/t54FmRg+1z3pynecPqMhmKO8hl+nd/TBwgbFzz8l/Fnfdrq/deF5fUmzwvRfbDmEPC+bnkCuysEl8S7r8YrGzcNDM288P73ZJQiNu840J2+Jf2MXBgxiRMF0a8FY39eysP/AND4hhaL6mkd5qglmNZ31XqNFHUNfQibA6QkQKKAlsci8wJCo9FMHNkxfNWiRtm+RBcnHbe3InQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ciq3sx50Hhll1QARYT7NymVeygsVpVYw9YEXGAQNXJs=;
 b=WAf2WWWpgGcDF5lb75vRfWSa9iHQEBOjieGlJ5+N/G8RbhpL80jFfJBVRsSA+0nMHOCuDAsqlQxvfE2B8ods6o6xxJA7QFQmkloW+5Hae/R8ewAOfCR82/HijW2+fVvtw/hAIHS+qTmyRaZspdTGuJv2AXdoc39J2YLh30NzdQBKF4bVY/SNEkYHWXkbITQDazU6Y+7E25XIJmGyu4p/VmFX6LVNkkmKm0OckUc02kZBGx4DQ2j71ogo+oSJYUhStmjKOREWjJiO+hsWD1tbNHmVfIaCIv+OVUGaDzBLJyAYn3mXqv7YTWTBm5VBcfmDjJiMvAc10zpOKiDcjpMqNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ciq3sx50Hhll1QARYT7NymVeygsVpVYw9YEXGAQNXJs=;
 b=IBMuDkP+2IYmMPqC5Y95w7Htk6IlHAl3v/XYJz8Isj6qOL8bbVUdbyGAa+6yCm/iqTYvQrkxuKMHhVzMW3hc1HnsoROVr96Vd02fWk7IBzSF1y6uJDg5DZ+U6Cn8PriBaVTOs3JkdUec9vXX2DTelmLiJ9mYKB0rff/lyZ4VleY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB7528.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 16:51:43 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 16:51:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 17:51:42 +0100
Message-Id: <DHYZLGGNTTLL.AV3V11M454BO@garyguo.net>
Cc: "Mukesh Kumar Chaurasiya" <mkchauras@gmail.com>, <maddy@linux.ibm.com>,
 <mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
 <peterz@infradead.org>, <jpoimboe@kernel.org>, <jbaron@akamai.com>,
 <aliceryhl@google.com>, <rostedt@goodmis.org>, <ardb@kernel.org>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <dakr@kernel.org>, <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>,
 <morbo@google.com>, <justinstitt@google.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: [PATCH V11 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
From: "Gary Guo" <gary@garyguo.net>
To: "Link Mauve" <linkmauve@linkmauve.fr>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260417152253.2312961-1-mkchauras@gmail.com>
 <20260417152253.2312961-2-mkchauras@gmail.com> <aedFgEicDW6LAcuq@luna>
 <aedJGuF9P2V1lOCZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aedQ629D0x-5KuKw@luna> <DHYYH903GZVW.EU2UKXD2ET0S@garyguo.net>
 <aeenqoV-dWWW3tZv@luna>
In-Reply-To: <aeenqoV-dWWW3tZv@luna>
X-ClientProxiedBy: LO4P123CA0272.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: ce77f1dd-0f9a-4e0a-d107-08de9fc64414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	XeZ4iNQS5RRXlXaPDIcEw1L2kGLg2NMrSB/oPEVg6+StF9v1NgVRJJIXacgDDez8u7YDoRKrh8VTI+9gpCxFjUKT9MrWwOHEz117tRgloXs3X5c8hVobZlxLLJRqtbG/vTiVHbgQe5FmDu+fGNQoF06UUBMN4YuOsDpaiEVWZHxigr9SX3kPwn6kXL7965MsKVB5qyaMEUA2sFSvJqVwNkInhxKnKN1MgCMKiNhaDoePD85Hdp9Uc3EVqgiB6fkukkuddbPAof8WJz2K+bwEPbCZ2CizPIlvvO1VUAgVVCOMfpB9wsZF5prxCFvqpQ4SJQRKkH+e9nl/7r/qGcbRHFpozKNxjjhN2PG6fz0DXjEzUrl6eNXsY+5ziV5A4GjTv1MNIxtDHPkn3n3gU2oXe1gDox8SQfQ/WwZdrN6Comnu+Mbssz/liqTGAakS7UsihxTIqNxnhvPPV0CkwDqOTW1rkRm3XFo9snx/c8NRoIigstpTR6pDgLvz6B3kgRqJ8OGELd/IRLYGDR2jMMmSK+RXlMaIEZrjppETkKmoKUGR3p9UmT9imRX0kYSzgAhMAW8q1k0D+lFmXWDEyIZnyIO9MCZKsu3EdNxUCG/+1Gbn6+Zgmha6r+KZVbD3MXNuKS+KqTQQnldvn8KhrSZZrgwZnzkmDRG2lEdAnN33ezEQG48KboyNGv7m5+XiUNahUsGgDSoxpJDgCoKx7Mdihhupn3BtybpzgGH5/uzOpOE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzdBcTdDeU56M3JSUWR2T1VmNzJwY0QrcjhPV2toQnBYV0hmNjVqQTZJdlBY?=
 =?utf-8?B?ZUZTQTFILzU0SXFINXZwTkRxcHlDMG1IcHhzUm5XYTNOZTZ1YXhGSnBucGJ2?=
 =?utf-8?B?SEQ1NlZ6eFlrUXJtL2p4MVQ5OWRVQVJGc3VqbDM5aG1TOEpPU3ozeVQrcmQ2?=
 =?utf-8?B?emlCWXJpc3FObUNla21VbG0wcWVsc1FqY3VMOEY3aUNHMHdtY0VXZmwyUzU5?=
 =?utf-8?B?QUlIYmtlT21CODZSRmlITzE1WDJNb285ZFZmdmVlVERqNktQWnFwMGVmanpU?=
 =?utf-8?B?S3NSemQvSzVjUm9YL1VNZzRsS2pmTVNXTk1JRU9VUFExUXduR0ZYQ211dnZJ?=
 =?utf-8?B?MWtrZjg4anFIbWdXQUZDeDYrVzYrOEdDUHJMeDcrOC8ydWlRSU1mdHVDeE5M?=
 =?utf-8?B?Yy9xLzBielJUQ1cxMFBSU1JONTloQnNIS2QrZWFHYzNpeCtvUHNZSElpQzli?=
 =?utf-8?B?WFJ5NTlyM3hDQy9zcXowR3A2K21TTVUzZjROeW9MQjZ0M3UrK3RyWTZEdGNa?=
 =?utf-8?B?K2dxSmZoWE1YOGQvWlZ0aTNJVjFVUzVSdTdZeTVtOUpTd1FIZnIvblhQRFpQ?=
 =?utf-8?B?aG1xZzIyRXVUYmhtN1hvRWxJVHFjTUl3b0szY2xPVU12T0xlRnp1Q0wzUm9l?=
 =?utf-8?B?dnl1ZnVBYXpPcjU3ejhDY2pKRjl5NTVOSGdnY2ZxR0NwK1YzWTE0VllGNGlm?=
 =?utf-8?B?R0ZhV3ZVS2RZM1BwZElHN2p1NUZNTkNjMWFyb2M3bUFqYmZpMWRWL2pmZDhv?=
 =?utf-8?B?czNCRWNDM0o2Vm9OOGpnN2hPN0dsZjIrVDlQc2NaK0lKWll3ZG8rODkrdE1R?=
 =?utf-8?B?eHVSK2tqemZucmFMQndkaE9zajM3KzNHTmIyL1VTY1pVQ0xoOHdKMUdJaXh0?=
 =?utf-8?B?UFQzMjdNMThMWHhwTVJhSWJhbERxOVFQdVlwWjJJSlRndDFNaitoV2RiejZp?=
 =?utf-8?B?QURkeG54WDFCNFJXeWgvQzk0OTlXM1lRSXhlYlFrMkhab2Nad2NFcVNEUkxo?=
 =?utf-8?B?dG93MGZObFlLbzM3VThYTDMzbDNlZVpwRGpWTFNlaG9kNjZvLzVqZmVxbk9B?=
 =?utf-8?B?WjU0M3pwdC9pRzhybUlBeWRRYVBuSEo5YS9vYzZuemwvVVN2WUtqdjd1N3pF?=
 =?utf-8?B?M1Y1MWVIVWVzclJ5TVpySTFwSTczbjhaK0ZGeGVKbkNiV3pqZjFjMndTKzBN?=
 =?utf-8?B?MW5qT0wwRlV6L1hyYkx2U2pKdy9TZ3ZVMmxxaTBsZFBpMFZxOHJ3YXhQc0VI?=
 =?utf-8?B?Yk41YzVkWDZSRFp3TUlUazFsd2ZKMGtiRjlBUEkyMXhPNjRpQ1BPWXI1NFdn?=
 =?utf-8?B?TDBmaEFoSGtDRWlmMG9jWEVLb3owcEhsSFBIMHNTWEZVS3lSTG9keXdqL3JH?=
 =?utf-8?B?NXhxOGVKVm9pazFmeEhLNTE5OE9ibzdVZ1NRSzIrTlhhc0NNd2MyQ01mMFJv?=
 =?utf-8?B?WHNwMmc5N0wrM0l6cDh2QmVtSTFSMWQzQUZXSlROSHkzKzI0V2UvQTZMQnBJ?=
 =?utf-8?B?SWx3Uk9tV2pFUmZ0emhZZFRuaTVRSEF1WFhJV0ZjODhVQUVtY1pQMjYraTZn?=
 =?utf-8?B?cDYvdHlXeDlDUXd2VDB2eGJKbkprc0NvMDBucW9NK3c0Sm5vdkVoaWMvR2FN?=
 =?utf-8?B?VzVTTEdYUEhtL1NKbGp0SnlFaVR3Q3A2Nlh6RnZ5OW1WcTJnZlNpNm40dFFu?=
 =?utf-8?B?MkVrZ0NCNkhCbW5lZnN3RmtwUmlORitRZTI5RXhBNS9qdFRNSk4wZmc4cmFW?=
 =?utf-8?B?VnFUZTNoSjRSbkdIL0pWa1hjVXprYWxUek9zZVZBN0FTT3dOTG50Z0JLcnhG?=
 =?utf-8?B?QkZJVzBpMXI3NGNLV04wR09TSFlaYW5tMmdpeDlsNWZmcEhSK0N5K1RQL1Qy?=
 =?utf-8?B?WnF6TUlyUGlrcEdwMnpySDhDdWlpV3gyc3l2QXFNOStBT3puU3JWVm1uWkU5?=
 =?utf-8?B?LzJvNmE0VEtQWnFLeGRqd0pRYTBWeEN2Y2QvTDNhT3Q2c3ZpbE92eURMemxL?=
 =?utf-8?B?M0VHb2RhOHNzQlVrS0dNb2dHNHNNK0NPYWFldGx1MjF4ZFVJRnlCdnF6dS9w?=
 =?utf-8?B?MGFTbHZia0pmQk9nMDBKbjVyNy9xb2R0dG5RdUlwYVhQV2ZJeVRSN0tucWp5?=
 =?utf-8?B?MXpMVVJVN29TcS81WTIxejZhNHM5YjluYUN3R2pJK1liRG1wZWVhenRxL0FX?=
 =?utf-8?B?eXVzekxzclVETStFVGdsTVBqNHI2UGtaWXVUUFpXRGdKZHVPTG9NRHUxdmQ3?=
 =?utf-8?B?bHRpc3VGdkJ5M3pJMEthRU0zRE9PZjg1WktEeStlV2krcjJGVnloWldmUnZp?=
 =?utf-8?B?NThQcFRUVUFpMEcvbTZLS2JVUHUxUk1oeE1lZklNYndHWXZzd25sZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ce77f1dd-0f9a-4e0a-d107-08de9fc64414
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 16:51:42.8710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaczHfyQiMAqF5toI/JMb/ki+h7/veQBcF/s4mIpXyCBLBXdLhQbfgXOMggRtZiHeledsP83Bvl5FHrcHyNuUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7528

On Tue Apr 21, 2026 at 5:36 PM BST, Link Mauve wrote:

> This works fine for the core crate, but now panic_qr also gets the same
> issue, here it is with V=3D1:
> ```
> + powerpc-linux-musl-ld -EB -m elf32ppc -z noexecstack --no-warn-rwx-segm=
ents -Bstatic --build-id=3Dsha1 --orphan-handling=3Dwarn --script=3D./arch/=
powerpc/kernel/vmlinux.lds --strip-debug -o .tmp_vmlinux1 --whole-archive v=
mlinux.a .vmlinux.export.o init/version-timestamp.o --no-whole-archive --st=
art-group --end-group .tmp_vmlinux0.kallsyms.o
> powerpc-linux-musl-ld: drivers/gpu/drm/drm_panic_qr.o: in function `<drm_=
panic_qr::SegmentIterator as core::iter::traits::iterator::Iterator>::next'=
:
> drm_panic_qr.f39a15fa3c72e9fe-cgu.0:(.text+0x200c): undefined reference t=
o `__udivdi3'
> ```
>
> From a cursory look at the SegmentIterator::next() function I don=E2=80=
=99t
> understand where the division could come up, but it=E2=80=99s actually ni=
ce to
> get an error when operations which shouldn=E2=80=99t happen happen anyway=
, it
> makes it more likely to get them fixed.

There is divide / modular by 10 code. Although, this shouldn't really cause
__udivdi3 to be generated for constant divisor, unless `-C opt-level=3Ds` i=
s used.
Do you happen to use that opt-level?

Best,
Gary


