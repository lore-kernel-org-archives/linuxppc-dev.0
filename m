Return-Path: <linuxppc-dev+bounces-27278-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F555C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 03:14:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkRvB0fNcz2yFW;
	Tue, 15 Sep 2026 13:14:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789442053;
	cv=pass; b=acLs9lB5qtardpIcKO6HUeWLKGHj/oqTgYV2Wxrw4TzZkVh69nU17Tn8bbo1mUP1eB5LsadtM1QsLrem5SdqzSaGSlR1mE7CO6k2ozVnYbBey0bd2fDk2UxFuv4v3RljFqKcdAnQHdvrjzqUSDzUlDJuw0MQ0z2e9VxKAg0UQ77+GDmnVICBWNqTPfw3msKERB20IRA6FY8UDizy+QmU7r41wivcaAQ1GEksUxlXIY8jxkiHvQLO5W+qFtCV6/QeKCKHpKJO6jL2NtwtIbrtUIOzUEIaG3QZcQmYb9Ze20oFfKkg1a225K7icVO3ogw83/MDkiQfmE24un7x24LO3g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789442053; c=relaxed/relaxed;
	bh=dqRyWUarxerox1+/UpOmKP1szaDVGaDMR23jroEMFj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Viu+Qg1G+4ND7PCvA2ZUr1vgk04wqpM3EmuK9JDYfB1c3t5nonU+h35tUy1uOBMdq3RaMQPoQu4/KeKKjA6d3OVkmhIlX6tVNF6POuAblzBsVUgjDkc6CmSl5j7jol02c4IEINFxWxfzJ7UTKhQdqHftPHUxnL0bA3MPft1Vi1x0uCyih8qJ507TqNCKihxpyi0LfFjzNJb2rO48DqCz8CEkNV5uGluweyDgF6gjz4hxfJu9Bx5SogfG46on7H25nOposw29U7++PIEGzRz/BHF+tRItRhVbNh3XGXWF+VXRhBbX19PE0gTTJrry4oA4tzrv0HmmSnR9yXnkXOIeuA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NYjcGaMj; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NYjcGaMj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkRv86HLzz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 13:14:12 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBqX0MhONTAsWGCZi43m1LDhqSV3TFqEUErruxKKioVOW6/IPiR29/3quIW810J6xsEYyJcknpPE4EbeqQfegPl5l1OwQ58fdP6j1NLOXSndi/Bj7DJxa+CoaDNhW2YqFWGyPmj3vQ9OBqMveTY2dGBumHIgRWokIxKplLT2FC7EPZPdReVDXHo+rK7JesNRlTxepdsTeFYIzkB3HTfLBfu5IMDCu2gjpJrVQzny12YB4rVjGzLeSK44MxDbKrltCaiJd7x6GPfaEpA153D70J9nkkoCok7wtG1Ry/M7gPHl/8w/U1mvQj7zQRYxaiS1qFihxHOO/K2OMY68XYZ3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqRyWUarxerox1+/UpOmKP1szaDVGaDMR23jroEMFj8=;
 b=VSBnw5qmfQnTnIHrZFYl5Nbb/n2d/DpMZi+rshg6zy1jSoJnwQpweUzcD14O8oAN1PY3+U4VY+pHiN3RYI7qHKy2/EmxaSn0uRbpipxnRKKbYC0KqLHGOtx9Ay/wpmRxsKfCAdb4SHAwuCH9aem51R9fKuYRGo9wOgy+G99rDVc1/51gfItPRiJUsH02aH1rHloPwvCwJQRuraoPTCiHLGfVbsCTgL90v6dWZv8BmOm+wYEJdBQAcH+lrPrEqc6aI/M59/xF6mTNkp5W/ewKkk4qazkw9usf1HN8mrTa4dokwAFZ0w0MatS0ql40dQXB28qkvfvhcFn9O+YJ1sADTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqRyWUarxerox1+/UpOmKP1szaDVGaDMR23jroEMFj8=;
 b=NYjcGaMj3if2jftwR5RBvlcyeThgu20WdTtiiP+qrc0QnzzrukqD5VELP0yOBOKSnBGuXRCff01nzwV3/ZUW0+oVZG7zk9pQ2eGkbBC+im+B+o2uUwrKTHkPbqHNP8hT7OPMA1PPR+uPvms9ep67AhkStFaKgfoRqRBssaAICD/W7AF/TC6hs8nu7vUshaXvrdU/TogUnuQINKCgIBj06orxrzj3axsNu4rBNO2XkZxZenmlUz0ms4ogDwaiOzN3e8ze0Mou7TAauc35frcwlrSMNunXBJjxfjAoT43LbvRhjvjF6wCJ363Lr1koQic2bFvWmYZJ2YxP59co9TaEIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:13:39 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 03:13:39 +0000
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
Subject: [PATCH 06/17] sched: assert static storage for wait queue and completion declarations
Date: Mon, 14 Sep 2026 23:13:21 -0400
Message-ID: <20260915031334.1194975-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915030336.1192299-1-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:408:ff::10) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 6ebf14a0-690a-470b-2fe4-08df12d756d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ujyqsv8Mqu+RzMSRTubhAvIjC+pSD+Y3sdRtDBO/n39giiuPlJMBXGmZdOEeT0I+leInLRB8J/fTyydAG54ZlO9PQ01owGs2Gt+xn9pI53OHJ1O9VC4BnrcMkQnV70aFYp84qp9gKRdVyIYP4h1bj9yv1iCY5nxvUsFy5e1prdlf00IEuzCTNqm9g5SZlynBM9YZ+9520ElXmjNVMC4KeJsPuxvbboDQ1Z59WPDp/wVStKzudDrXrmz92RrpxrhiBliGkUNnuWxXppHPMucEQdmOkJIA37JhkR9gEtVilGX9kXsCb47X4bneFV4ZVkQkR3QDHXMkeQc6pGNJm4m70VmaWtrQGa1V8qBNrpSMYtvVE4bd9gcgFt4RTiY3FxOT+rZ10l4Vrouo0NOh+mLBSmXN2MIQPhbyAWt4ScrB+V6rzlM8qRvU0UZJKE4Gsoed3bDrJDcuaUBOA6/nls0p+ajLNQMbsP34on3ewS+w93gCYarBNwd4y0p0bLE68RPpRZa4lzgfQ3vX3kgVzNOdmZV7U4wDCIsd0d1+zVDpASGjyWAzVj7TdEP0Lh0NS1j04L1y/pA6IalAB3kH/fMtOo9+01djFPtNp0jF2r+Vq2t9kQiVeKx9BmfBPgZGTmWpxm3OyZdYrgehz+kgCmBrhL3KJwYghxgNOcOB7U2pxTM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GwQ0nzLyGOSpnO4x6m1AwRPoycDPenQAJwOp3HCgmO5Rx4gV4cUTIyLuTjcd?=
 =?us-ascii?Q?e9WR7oDZjUm+rFdlII830gr8AF4UkT0qsgDgLBOfNu14emhfqlxd0GAEwwuT?=
 =?us-ascii?Q?ScDvP+lrwLY4/p+kkGmVlWqV/nzIdBHkR1z6IP5UqF8bIl7GJQQVeHSj/oAS?=
 =?us-ascii?Q?J7I8o0vI+BLZSuu50JuEbD53ThufULWIZOMi1rcQLlfg8BcZJJs7N6+kyQmQ?=
 =?us-ascii?Q?F6uyrxJqA1kW4xDrPIr38rL4cHrtJE7nv46rZuszNdk5bdQL4JFKrO4bx+oD?=
 =?us-ascii?Q?AahxHPpwRvTDb5DSAWBOXIrvZmJwyTx6yv2nm+fyCOJN8kOpRWFoJg0xGWqO?=
 =?us-ascii?Q?Ptvx2NhtfdTbIuRnwNNrzi+BwG3Rv3Lfyy8+e+FDRFgW7jmaNENrR1D6Tt7z?=
 =?us-ascii?Q?Vq0VQ1TbjnN/Jp9jnsHWcZh4j8YYAubQppTfJV9zQKiGbg8/vUoaTqMP68h1?=
 =?us-ascii?Q?LkDnWEqu0vwpb3hH3Dh6NfCR1nVQqW00tkS7aCmHc5Q322SYRoCTtHd0b/nd?=
 =?us-ascii?Q?wunSVLuaycrodKAfirqbdjgYihzUxAtIpPR4kdi+5LCEtI9fUId6iTaYwDS1?=
 =?us-ascii?Q?1wGHm/na81xBfd++O1DCOOGfwjtk6+1cIT11pkYVH/e/q6X8pRran74Mqnr5?=
 =?us-ascii?Q?ZdO0xAv0jU+kxG+cdcqJZE2kwnbcbHKoJx2mheXFKemjfi59Be3CkeySOf5l?=
 =?us-ascii?Q?DS/mir8udq3wnPvC6HS3UoOgnW5U0CIld3wCIng6rMyDdjC81GUqKuFpWPVV?=
 =?us-ascii?Q?gucji7rT7s+1MaxdRVPfPKX2MXeDHABrQ0QrkC64HKlyiLgeF0cbDHUO51Ho?=
 =?us-ascii?Q?l08oQKEUrpzNdZGVR5vaA5G9iziDxRtDYQ6qWpBSVoANR9BPTUr1LGrBq/p3?=
 =?us-ascii?Q?U3Pi+BOiy8OjuYInqvEQuawTjl5dFKEQNeSKNLF/ZNtVoAM7SxKOVjbO0CIo?=
 =?us-ascii?Q?k7y1T2IKO3tAYcedz536hm3j6JdmbQCkn0txfmzhmehYURRuFC71BC4dQrK0?=
 =?us-ascii?Q?bgiO+sQhzoztGVHHSWr8/46zAVf2oxXjPncGGnK/eGCi2TCRMIKYDcRj+8aA?=
 =?us-ascii?Q?8D0xGAGI3NGb/KqNcBlqrE7aQMnt7J31ChB31+stDYacjDGaqVU9UK7PbOp3?=
 =?us-ascii?Q?laniq/gvDP5by/IOG27WvDojkAfJGCKOrkZkJBaevZb3KpZoWYqk8WJvZBRZ?=
 =?us-ascii?Q?WYCCA41A2yTX4IWouzsC8d73PwmyT6VLxNcAEvHtB6/Td6h0PS7xy9idrqs4?=
 =?us-ascii?Q?HpFVrNc/5hSFQuZ7hMCjgYWkv47YmABqg9f42nKuKmSwnSGmnxu3CqiqXgRp?=
 =?us-ascii?Q?FJfYpiwC3wGAEyw9ORk1zyYwTsxQEgiUNPwpt7uww8j5XSBVBTV+stlM/8eK?=
 =?us-ascii?Q?kxQLN1V9F0M/VcxOLr+ZxZbPAolOJ/m8cKN0JRTgbe38UxtlnPl/yd74pOr0?=
 =?us-ascii?Q?LdsmVAEMJsiaQKInhwc0MZuoU3TYzRTAhA04/053GvtsEWmHMd5yxeLZ2y7u?=
 =?us-ascii?Q?HHOz8/K/vXVTugKwbvtXr5IZZjRo9U7css+TL48ZXQM51JWr+9W11t8geOYS?=
 =?us-ascii?Q?hVf6MPEPqFPudEnPO3ZJ2blf8qRS7/ImQ095AbnaiCDC7U4YhuSV2iCNV+0Y?=
 =?us-ascii?Q?B1l3NKRnjFNIhNbSax6EznsrNVpx2PjG/sDm2TI6u0HN4Vs4yEwca6KQtej/?=
 =?us-ascii?Q?VeuZ/FgvO8WIXjbzKuVUmVYWaesHFsf2RL7CuHKj5Bw4q7bOxbjsS3XUDxGt?=
 =?us-ascii?Q?DKj8XDP93w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebf14a0-690a-470b-2fe4-08df12d756d2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 03:13:39.5945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F227rWTftCNds1bLAmXuJ9ypEQHbFJoVXfzgyM1if7ZeV0RA0vWTuPu4huoGwpJJ7VX1izhWmxwACme9kZ54Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834

The ordinary wait queue and completion declarations statically initialize
their embedded locks. Automatic objects need runtime initialization so
lockdep receives persistent class keys.

Add ASSERT_STATIC_STORAGE() to DECLARE_WAIT_QUEUE_HEAD(),
DECLARE_SWAIT_QUEUE_HEAD() and DECLARE_COMPLETION(). Keep the _ONSTACK
variants usable without CONFIG_LOCKDEP by expanding to the underlying
initializer instead of an asserted declaration.

Convert the two automatic completions in the AMS PMU driver to
DECLARE_COMPLETION_ONSTACK().

Assisted-by: OpenAI Codex
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/macintosh/ams/ams-pmu.c |  4 ++--
 include/linux/completion.h      | 10 +++++++---
 include/linux/swait.h           |  6 ++++--
 include/linux/wait.h            |  7 +++++--
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/macintosh/ams/ams-pmu.c b/drivers/macintosh/ams/ams-pmu.c
index 1c3ce39e9a59..046a7d5dc5b2 100644
--- a/drivers/macintosh/ams/ams-pmu.c
+++ b/drivers/macintosh/ams/ams-pmu.c
@@ -48,7 +48,7 @@ static void ams_pmu_req_complete(struct adb_request *req)
 static void ams_pmu_set_register(u8 reg, u8 value)
 {
 	static struct adb_request req;
-	DECLARE_COMPLETION(req_complete);
+	DECLARE_COMPLETION_ONSTACK(req_complete);
 
 	req.arg = &req_complete;
 	if (pmu_request(&req, ams_pmu_req_complete, 4, ams_pmu_cmd, 0x00, reg, value))
@@ -61,7 +61,7 @@ static void ams_pmu_set_register(u8 reg, u8 value)
 static u8 ams_pmu_get_register(u8 reg)
 {
 	static struct adb_request req;
-	DECLARE_COMPLETION(req_complete);
+	DECLARE_COMPLETION_ONSTACK(req_complete);
 
 	req.arg = &req_complete;
 	if (pmu_request(&req, ams_pmu_req_complete, 3, ams_pmu_cmd, 0x01, reg))
diff --git a/include/linux/completion.h b/include/linux/completion.h
index fb2915676574..b514b5555722 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -9,6 +9,7 @@
  * See kernel/sched/completion.c for details.
  */
 
+#include <linux/compiler.h>
 #include <linux/swait.h>
 
 /*
@@ -50,7 +51,8 @@ static inline void complete_release(struct completion *x) {}
  * variables.
  */
 #define DECLARE_COMPLETION(work) \
-	struct completion work = COMPLETION_INITIALIZER(work)
+	struct completion work = COMPLETION_INITIALIZER(work);	\
+	ASSERT_STATIC_STORAGE(work)
 
 /*
  * Lockdep needs to run a non-constant initializer for on-stack
@@ -70,8 +72,10 @@ static inline void complete_release(struct completion *x) {}
 # define DECLARE_COMPLETION_ONSTACK_MAP(work, map) \
 	struct completion work = COMPLETION_INITIALIZER_ONSTACK_MAP(work, map)
 #else
-# define DECLARE_COMPLETION_ONSTACK(work) DECLARE_COMPLETION(work)
-# define DECLARE_COMPLETION_ONSTACK_MAP(work, map) DECLARE_COMPLETION(work)
+# define DECLARE_COMPLETION_ONSTACK(work) \
+	struct completion work = COMPLETION_INITIALIZER(work)
+# define DECLARE_COMPLETION_ONSTACK_MAP(work, map) \
+	DECLARE_COMPLETION_ONSTACK(work)
 #endif
 
 /**
diff --git a/include/linux/swait.h b/include/linux/swait.h
index d324419482a0..caa3028d1dd0 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SWAIT_H
 #define _LINUX_SWAIT_H
 
+#include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
@@ -64,7 +65,8 @@ struct swait_queue {
 }
 
 #define DECLARE_SWAIT_QUEUE_HEAD(name)					\
-	struct swait_queue_head name = __SWAIT_QUEUE_HEAD_INITIALIZER(name)
+	struct swait_queue_head name = __SWAIT_QUEUE_HEAD_INITIALIZER(name);	\
+	ASSERT_STATIC_STORAGE(name)
 
 extern void __init_swait_queue_head(struct swait_queue_head *q, const char *name,
 				    struct lock_class_key *key);
@@ -82,7 +84,7 @@ extern void __init_swait_queue_head(struct swait_queue_head *q, const char *name
 	struct swait_queue_head name = __SWAIT_QUEUE_HEAD_INIT_ONSTACK(name)
 #else
 # define DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(name)			\
-	DECLARE_SWAIT_QUEUE_HEAD(name)
+	struct swait_queue_head name = __SWAIT_QUEUE_HEAD_INITIALIZER(name)
 #endif
 
 /**
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 7e215330199c..5c7d49187396 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -4,6 +4,7 @@
 /*
  * Linux wait queue related types and methods
  */
+#include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
@@ -57,7 +58,8 @@ struct task_struct;
 	.head		= LIST_HEAD_INIT(name.head) }
 
 #define DECLARE_WAIT_QUEUE_HEAD(name) \
-	struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
+	struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name);	\
+	ASSERT_STATIC_STORAGE(name)
 
 extern void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *name, struct lock_class_key *);
 
@@ -74,7 +76,8 @@ extern void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *n
 # define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
 	struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
 #else
-# define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) DECLARE_WAIT_QUEUE_HEAD(name)
+# define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
+	struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
 #endif
 
 static inline void init_waitqueue_entry(struct wait_queue_entry *wq_entry, struct task_struct *p)
-- 
2.53.0


