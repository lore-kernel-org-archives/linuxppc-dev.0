Return-Path: <linuxppc-dev+bounces-27279-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490CEC88E77
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 03:14:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkRvC37g6z2yqf;
	Tue, 15 Sep 2026 13:14:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789442055;
	cv=pass; b=GyW1EWiZ2amMqT7SsLlfSuqSuWsL/275k3XvCAdIzKjPOf6+/3pPtS38UkddxGYE/7lYODS2uPARKAo7QmqY52kDy1SjfrCK5joK2e2QDHmV+cN8qaZsFaFoZmKnZ0fIyEuIWvXpeb9BXBlpReWkGJlVhy51eR+A9dCnBkJCZ4Qzs0gil7jRSmeOHFP+7lofLCjiloAjXI4J+GgNkJJAzf/xZi9rGEwb+XbB4SWsq2QTHEDhevMPscNeAiedmCNqZjLupNEE6OGU2BCImGAj1BLVM/PtCOn0UV/S4ENU5OZDGifRJVMIWbA5G19MPUOx3jUAHcUaPicCjUAT/HFAbg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789442055; c=relaxed/relaxed;
	bh=tgJTrkbSXsk/Ysc/nC1MLyJzpZtjgLsqhRT74bOiJJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V2QsgSOdov+UwwyQ4MCSWLIBPnz9lhZyZqofwPjHObnx0DVa2vaMonBtDjKZA9Mt3Pgs49C6L4G9gbwmOMxjkugIjjLda4ICJxlWlVG5VvBGY4nzcbfJ/zEzdaPHH8eItQly1xTBcfaUCcVgocwtD/X/8pgTKr69KFBBGEpSv2Srczu9ZF6hk2KlWmAxF3mg4O9iw4GdF5BpZv7635iHNaFoNYavT+I1lk2JPQ/We9bv3mgTLQpoMDDu4enfHdTHZ37l+67cQ3aj0PwVejMBqWianbgid9P22qdFAfkyfCjon/nj1SJPjTrRgqjU4vzGK4b/KYDlygIJbHKhMfniOw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XoAyOmrO; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XoAyOmrO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkRvB1sHxz2ygp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 13:14:14 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEW3A1+fKhN4tcmqOSfwZ4KzsoCTZYgDifv10deRuQZfkPs0NKiF+Au+OsSDOT4QVsZkMZ9eKu+1vi+hnFHSHqdgqd1H6eAxXcYagu5Yc0F0SInYHmnj1CO1iCuYGuShDHiaNTEZ3AZhyYFu+ORPuYcdlBzXLto+cjHqIdb/HXjxPISC22SBuM2A3IgfO2SDP8kIxn099fCWJajie6lK/VLffEh/gpe1u9NPnf2Zkfly3Uso9R41bXinTdp+YaKjwmClMtkjYx8roTtE94jpeeuaWn+QKUHhtRDkcPyrSnCIJKgAR5/Jju7a/LJMS1a4gpY00aMFQI1wC/V/gsFARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgJTrkbSXsk/Ysc/nC1MLyJzpZtjgLsqhRT74bOiJJQ=;
 b=Rxa+goYAVRSM7LebLFbRBjJuQsXuX0ynW3BbvCblJYGiwBmyDr59SBIubqXiG4IFSZ1fXjSb1Iqr/217hVpy2cY0w5op3k7iqg8SeBfYjtsRtOSrNX2Adpy7RWfjPgHL04xZ6V8TMIu7SGHdQcyyIpalrAlEwadgpZ0R9Kklv71QkkJoNftyG0uXPDxvqFrgo5JGFwx7Apc8x73GZsQWmhUF3ByGge/8GfUu9b2TWDsayOIAlriZimcg0fl2DPykLoVw1ptFz9RujRw+2dxFjbNdaIqMoZOiUl+gJaG+UO7gj78HF6Cj5ZrdTxK941nqcXpUifDqd9+dwMdZY88ZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgJTrkbSXsk/Ysc/nC1MLyJzpZtjgLsqhRT74bOiJJQ=;
 b=XoAyOmrO3mVrQ0rgMNm95Pq/X/dH16s7YxtU2hjaGDwzmgmAMvNQS2eciuv3UYiJMUPwiqGKJxTcldZO7uxlSmpd1DNSIExtyhtrEd02uIbw6uE3PgqI9bviT+z22KLpPrKpXXLHfymOkVTQnV8zOXq+07tJsGGsHknFu0M4UWcHY4JRwRD+/UnCBx3qNwuWEx2nnYfSyt7pxwDiXiQ/nGLbWyO8CaSz8PFgfA0d/wwKyo8CYKigVpYEKgCZKxk4faTThjzWpkpXznfFxQKiXUcCaLxNzy9ParHBmhJQbPzqBAZXscURA+vK2EaXb0JNNuhamBnJanzRhuULQS/bGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:13:48 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 03:13:48 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yury Norov <ynorov@nvidia.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-rt-devel@lists.linux.dev,
	llvm@lists.linux.dev,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 08/17] idr: enforce the static-storage contract of DEFINE_IDR()
Date: Mon, 14 Sep 2026 23:13:23 -0400
Message-ID: <20260915031334.1194975-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915030336.1192299-1-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:208:32f::14) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8f39ad-cdcc-4f11-b510-08df12d75c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	7rOpFyrVmvAO8tlkEBOUtjgzSr48cw0TpHiAxq/C8dG8P5VDP4qDAMp/NCWgbX+8SF9dz677r8+M04HeSJFSxn4pKwPF+uVGbhMKvRJU0XqN1UhQpbBkRsuQXiPcxBhfbeY5Q5N5u0pJHuOgW5wXzkugSZRq6rYo4XTc0A4K/qPWn/93Rfx/X7aTX0oJcsoFJqt3GsxY2dQ3ZhqW9IKlm/r6gWjld5EgWkZ83Py/b0LHc3DRjOn7yrC9KC5FMjg/myYmOacon3MoF8X3rw/i/MiqrQf4xvqK29V95uZF+xg2CGeoTJMrRcrRyJhWVfekvRkFOqiB7K3FKNevwIhGlhi/HWEImYJJWhbOtjShlyeP6K8uPgQyGixvSUA7n4Xeq75qciANx4eioSpwbZyuf3yAh1oQN/R6XQ/IQeFoc+witxmz3b5ZdFo56PHwUf9r57HDUQAnAmgHjHdbxucQ4PYAru2s92jvbrAouNeG3g2CDU2dxUEhGCCKBdMi09hUs9uDEEB2tXq2iViPCQLT1gIvQ0C6LE24HkHiStTdg1oQS9Q5XrMXvc2Tok6flzbFRhttY/DjQI0ljMov3DEEJllFmxbWcVWiT8YQpvfXJYG0M5XE9zve7dS3fEDpBoVrbFMzNbMH/t186fEM5Ug4gYj0dxxEImtu5I+9hrbbo+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VGte8XEzn4NOoE150MDHIX052sAUVAyb+riQMS2GFH2T8EFEXlLEAmSpCiE3?=
 =?us-ascii?Q?6tYBJrF3VQt6VNU1hdq71x4DIHKSnFpiXkM27C/wFywgXiT8cNPvhZGQ2AS8?=
 =?us-ascii?Q?HzNbSw4sf0idlc2FADXj8yJp4wT0ONisWwJy/XDTyNEJSGZVT4XwSWcM/kjd?=
 =?us-ascii?Q?PgvEQlmg3dTU1hiuK2T237DHQSrof/ywO+EWg+oxGpbXbcki6OEXFgSg/TRm?=
 =?us-ascii?Q?vESIn4DN5zNsYTfJ7s+tyI2oTMg88qjAC00MY+KQwA1Prj0Udjm8gB1ydrxl?=
 =?us-ascii?Q?xBNrAIWngtEOAqxUJKtcmoGy4cHJoUOA/9U8S0SKnrSaLLinDKne5mW9Cdu4?=
 =?us-ascii?Q?SfFY/iAORvrMOMubZ44mfgM1aCMakl6J83pS/1ZHVE7FSPODMOosNlWWahXj?=
 =?us-ascii?Q?PSl+TMMETgVzYnxX8Ez4511UXm+TQdLoTcF4yr8Gp90k9+P9XVKC6nocZpxl?=
 =?us-ascii?Q?kfi4DoTd206fi50Cn7lM8BhEygs6BMdRaXhPgE3QF6L6kKeHN5+RY2w7g/X4?=
 =?us-ascii?Q?bvyZynlfxPdSnt6oywXCtNrnxdZqk4duuCGKrCHQLNPyjhA9yg5x3xjvC9qn?=
 =?us-ascii?Q?8BgvYvQ12HFcijTWvdEFjlnAK7ybZS84W0/0RmRtqzxQqPH/dDi+29BV82oI?=
 =?us-ascii?Q?YMhqiBSZWwPE+eUQ7NscxP1yI3bhmDlzIhRFoTCCARbgUCUdRyIIsMLvVcqJ?=
 =?us-ascii?Q?uI5dnEyKKhszTWuXvCM7LJqr9L6DK+iKPMVGN/iZbgDS1ofuiAsq7iobCEsn?=
 =?us-ascii?Q?1jx/JKIyuUWV5vCB+4duUktpeXYTjiLqpYK/iq7Kcq/WpNW+YpOv0Oxfln2X?=
 =?us-ascii?Q?bkozuomjRaoG6RHfiCyhaLJJIUZrbhiWY6FVttfBRuWa4f0YUuK3XFwdGQM7?=
 =?us-ascii?Q?1EWDGCWgGHg3+aHyNtZaZMrJkVZZO9YoD09dXxUq7P0Zom2tOc+ICURi6BWg?=
 =?us-ascii?Q?TQqqYCHzQD3e6sskjD3fPeNh/K430nzbdkEH8H9uGUZUdvHV6Cf5AxNNgFA/?=
 =?us-ascii?Q?JgLSB1d2ZS5T/BzAmqVmuIAoJUTIJJw0FCYA4CmG1IKejtD6W7DzclD18KEX?=
 =?us-ascii?Q?HtYUn/9VHwS7MD5rxXcKtSs6qwADZXVdp2RsUkJzuC26oVpHwn9wNGmqR/WG?=
 =?us-ascii?Q?ySHg8JXcbVCpn4tEb5AKwErec85ETUumE6cqoHkKRq9kG6PYMC7wGcVdWW/H?=
 =?us-ascii?Q?j4Wda+B8lLydW4VLp2dl/LXmTI13G2kXrENgJZBZC9uWDW3We+4y0AtjHrb2?=
 =?us-ascii?Q?BseDTfJBOtSvWpFZ2SzikHuTOBUvXqYCytVAGeldKBXK9f171ubBgZ5p4NPJ?=
 =?us-ascii?Q?LRMOS9/uogT10ADZDIJpcEtCFSjnfI1eliJOwITPnJJ7wb4MOTOO+1JdiKb6?=
 =?us-ascii?Q?6beNgF+OebF6RNrNQtS865+F5Pdi3WAqD2v48y2zpiNkFWr9eTGb0kiKGxc1?=
 =?us-ascii?Q?NcWz8onKQxHzJgnL2dyzA34lkMWGBCkHknwFMsN3IHXy6vvK78pUtiHnSxIb?=
 =?us-ascii?Q?WHsPo3BuN5wGTnjop9G7NJf8OhZ48DaXT5xfRFrODVdsBm2tNjaeQA11Gn7g?=
 =?us-ascii?Q?uoKXDueE2LsUWJMudqLbZa1yO2D984k6p4UuQeMXO/eDSKNeMNk1EDNNmx6c?=
 =?us-ascii?Q?yU71Y6HCXx4u+sEw6nwWg7/wBsYM3KpNA/hUW2YllkwKtL7nAy7q0/WXqN9K?=
 =?us-ascii?Q?UtjiVNM7d8g9Hjq9KmYogxcMvtmLrfkSv/T7SGBl6sY6EL4a+xGrFkOEBMlM?=
 =?us-ascii?Q?sSRJbeXSZQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8f39ad-cdcc-4f11-b510-08df12d75c12
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 03:13:48.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qI+SXR0SIYTnNt66L5Sa7slN1ng38WBgzEVPjtjIO8rSNARWToGTuBGNY8RGfeB3zWXW/0jGxfOdoWs8MZODgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834

DEFINE_IDR() is documented as defining a statically allocated IDR. Enforce
that contract with ASSERT_STATIC_STORAGE(), matching DEFINE_IDA().

Normal IDR operations use external synchronization and do not acquire the
embedded XArray lock. This change enforces the declaration API contract;
it does not fix a lockdep failure in ordinary IDR operations.

Convert the seven automatic IDRs in the userspace tests to plain
declarations and runtime initialization. Two already use idr_init_base().
Keep direct IDR_INIT() and IDR_INIT_BASE() initializers unchanged.

Assisted-by: OpenAI Codex
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/idr.h                 |  4 +++-
 tools/testing/radix-tree/idr-test.c | 29 ++++++++++++++++++++---------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index e2a4b6298511..d0393b7fe985 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -55,7 +55,9 @@ struct idr {
  * An IDR defined using this macro is ready for use with no additional
  * initialisation required.  It contains no IDs.
  */
-#define DEFINE_IDR(name)	struct idr name = IDR_INIT(name)
+#define DEFINE_IDR(name) \
+	struct idr name = IDR_INIT(name);	\
+	ASSERT_STATIC_STORAGE(name)
 
 /**
  * idr_get_cursor - Return the current position of the cyclic allocator
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 6fcba5b5870b..4668c6a4f6ea 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -33,7 +33,9 @@ void item_idr_remove(struct idr *idr, int id)
 void idr_alloc_test(void)
 {
 	unsigned long i;
-	DEFINE_IDR(idr);
+	struct idr idr;
+
+	idr_init(&idr);
 
 	assert(idr_alloc_cyclic(&idr, DUMMY_PTR, 0, 0x4000, GFP_KERNEL) == 0);
 	assert(idr_alloc_cyclic(&idr, DUMMY_PTR, 0x3ffd, 0x4000, GFP_KERNEL) == 0x3ffd);
@@ -79,7 +81,9 @@ void idr_alloc2_test(void)
 
 void idr_replace_test(void)
 {
-	DEFINE_IDR(idr);
+	struct idr idr;
+
+	idr_init(&idr);
 
 	idr_alloc(&idr, (void *)-1, 10, 11, GFP_KERNEL);
 	idr_replace(&idr, &idr, 10);
@@ -96,7 +100,9 @@ void idr_replace_test(void)
 void idr_null_test(void)
 {
 	int i;
-	DEFINE_IDR(idr);
+	struct idr idr;
+
+	idr_init(&idr);
 
 	assert(idr_is_empty(&idr));
 
@@ -150,7 +156,9 @@ void idr_null_test(void)
 void idr_nowait_test(void)
 {
 	unsigned int i;
-	DEFINE_IDR(idr);
+	struct idr idr;
+
+	idr_init(&idr);
 
 	idr_preload(GFP_KERNEL);
 
@@ -169,11 +177,11 @@ void idr_get_next_test(int base)
 {
 	unsigned long i;
 	int nextid;
-	DEFINE_IDR(idr);
-	idr_init_base(&idr, base);
-
+	struct idr idr;
 	int indices[] = {4, 7, 9, 15, 65, 128, 1000, 99999, 0};
 
+	idr_init_base(&idr, base);
+
 	for(i = 0; indices[i]; i++) {
 		struct item *item = item_create(indices[i], 0);
 		assert(idr_alloc(&idr, item, indices[i], indices[i+1],
@@ -229,7 +237,8 @@ void idr_u32_test1(struct idr *idr, u32 handle)
 
 void idr_u32_test(int base)
 {
-	DEFINE_IDR(idr);
+	struct idr idr;
+
 	idr_init_base(&idr, base);
 	idr_u32_test1(&idr, 10);
 	idr_u32_test1(&idr, 0x7fffffff);
@@ -360,7 +369,9 @@ void idr_find_test(void)
 void idr_checks(void)
 {
 	unsigned long i;
-	DEFINE_IDR(idr);
+	struct idr idr;
+
+	idr_init(&idr);
 
 	for (i = 0; i < 10000; i++) {
 		struct item *item = item_create(i, 0);
-- 
2.53.0


