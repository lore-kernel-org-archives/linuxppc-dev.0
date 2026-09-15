Return-Path: <linuxppc-dev+bounces-27274-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD60C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 03:04:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkRgm6w9jz30Nl;
	Tue, 15 Sep 2026 13:04:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789441460;
	cv=pass; b=cRQkN+utlovLolgLJ8BSIXzsJO5y/agmr46nWz8halW4zQFa6BdRyXJQlG3Gz5xQWvXtbQowfkKgJy859SVuHV7+fRMlgeiv8FhmRC0vKgvbPALB8j0nVyFF0o6WTKT0fOUL+um+wf3cJs1Ob5LA76P24hi+N49yiZyWrJTnI+3bNmEKK32r3hmhPcObzIAQGqfQgrza6IHXQ5HTvb+wNlfemWsCeh73K/9lV9DqOJFhi4cSRxKpnITQSnKRSryLoU2pJk8x2QLqw1ITL2guglb8MINKxc8Bjy6I0jaUo97lh7QVV9snmZOxwdu7rdTxeMQ7n48AEsmig3UWUTsX/A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789441460; c=relaxed/relaxed;
	bh=jNPbKRyhs71id1HJsi9Z4YSUAMCDkiufWj4RbyWelZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TcF7iGOTmwQYKUkudrJEiWK+gMxail0JcjPJQpbDDhLbcWdoGA9V3rNrYi+6j7F9En0mtbTrNmuZLLp9ovgXgbXB4mbsptlWBUKw24W6Q6hpsDcCX5YtQcMFvAb38p9kcnHn45Ea2e1yX31JOwdm+5Ab6Ma7jhe0GdkPgdi6+4ZC/gXwhmsoyAYGwqboF6MeNznTQKmBHqSGdeZvlMQhWiSkXlbTsLJ0Nvs4tWDZcaaiYAopG09Fq0J0zrFFDlxhXFgFVom0cn5611457eW5LC2R+HEqR17mD8MrWHgeI2c5kkdzMmuBNoetqQFVvjGVdIteXMnFSaYaTw8lZQYcKw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=e1R6BrHx; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=e1R6BrHx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkRgm02Skz2yps
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 13:04:19 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqmIpA7gn21hu/egX9ZaxXCp4fKmJ5wxBNM5TKZmeqjhhNIshTvuGiz8HJ+U5yCtQPYsHulYy7pp3pnz94VikvTT3lwfkeI+okq8yg3mWImpgd3PtH0icxd4mU30N7iOunjhaBO1KB5b4GNb3YDv27bHj31ZsgSQMWcwtxwF+L6hXvELngqBe4FJngC14OfAdbzDYNfnYp+70JRVcShRLA0H0BN5zMPWUNZnfNlQ6IVRKQfL1jXUIFufnhjfd4lbskltOBUwWzh8XryQScu4e54YuElob6KzuZyNZam/BspEVZt1g/FInmMgrDncOzYR+u6f6vM2Rc4UUA/GmdsUCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNPbKRyhs71id1HJsi9Z4YSUAMCDkiufWj4RbyWelZA=;
 b=ksAlXXwf6zDFL2PqMGSuMtgP2fY27hE2muNFtH90apSLLJZxLcb0Kt036iU1E4Da8YuH9uXswIvpQPdd9U11kqK280GfqSEf1eKsdsixwtlpT8lZJajKO0qHhKJkEV8b28h/PKTdD9D2p+7tPd+9XDNwZOVHcSVhI/OYCqDIWl5jAg+Q4aHaSbG/ltdMgggBrqalezFJBpF2Pz9+62kZ2ZKM0+IELuUNJ1pRqCNGRhY5+RShWPWP44OEApE11XQNad3n7yLJ/nydzVdyF1Bfj2HDdukvo8QSuk0eqpsR5uRCAOAcpjW/xDKvmIpE31l0xLP/7ei1kZ9pR1fazKxcQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNPbKRyhs71id1HJsi9Z4YSUAMCDkiufWj4RbyWelZA=;
 b=e1R6BrHxwVJvdrUJlD5eoSUJxyYRKNoO1MDN1AWpgbjM4EBOlU1JpAnqqJ5f5bFXqMB3UgBZt15syYjQpGez7nO/aAAfw2zSAfcCofY/4cB+fj9hFejX4Wyt1g5sjRTIalAApCr6WML+F0iY3g7vBqzL/Kv/pzJuAfadV8Wd1FShZOteNvq4iZzkhznRkOic4rk4k0GKHRdO7HyIHshHrTfKd8Gy5+QJUG08d1k8kPlYZ5orOG7PUglqmhhQquTow0XPZbv3W6adS2ThPtAoRGeBo94B3pTadqk9NS3jSw67GRzINGhxkBvKmOp7D4J7ajnmCGcOv/xhXYVlotINlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:04:01 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 03:04:01 +0000
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
Subject: [PATCH 03/17] locking/rwsem: assert static storage for semaphore definitions
Date: Mon, 14 Sep 2026 23:03:21 -0400
Message-ID: <20260915030336.1192299-4-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915030336.1192299-1-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LV3P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::27) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2c159e-50b8-41ba-d826-08df12d5fde7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	D8cm5BBi40lOb9KPyoeX2BUv0p7DeHN6tN6fivd2g6sEgnDbRTUrKrAKSkGPuBv+uk9IJTAxPF42SVx52pq+XwqJKilp+Apd51PW5ZLYlMEvgcVewCn4dugwAoFnKzSMqYStuAnKFA2n6zp5Rq9Li+OhrytyszXRKduQtubMlCrxuBX7YvCHJK0E/7gNYmoMLQgqV7zgzmBVizMRQwMDw4e0bAGPL/5itMGrnZVQNnnjs7H60gdApOso7+FBRvX+Sz3TVhgPEXbUqgNoA8SO2mSAX+hF/vo5nQGKBBvrx7d3uH72jLfsF62j/DukSdG+JwC2vqU9lcubxudHZ4D9xr3VD26TJurOAjKSWw/i3HkVSNpBO8mwTMmWx5kk31W6iQgP3S2eLVojqSN3Ck2OA6vJnWJtx/dUeNkzHc0itBU197LT7628n3E6mc7iTb0dEvWtniSTLO39bReFVRpA67PwnTgc1TjM8eq3u+0OMCpKhZenyGUr8JPK6bUN3bNGLh2O5Rw1Jh3YWrkcwOqTs8RVhY097Yf51MKuHZb/v2kjgnIob/DNWY4NUk5gGpLofx5xoEJ4k0WbBkgmMyk6hOO3UBMIp+Gb6MVYeKwb9T/fYTRBauLGN75W08SSg/lRzDv6Xhbbu642rG/TEoMq8DXQdVfZ9/Q+9+wWns7FOq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jBHyy77KwjNY7+nmThMXTKFeRZkEqpz35COCV/XXxVBoQCUeQnWM1N4p2LiH?=
 =?us-ascii?Q?VC3mpNKVL9Kh+5eVG8LiLkpSqqH7r69cDfisO9+AlcfdH9isblAmZgvsndG1?=
 =?us-ascii?Q?vBbuBuGvDeu4CcZ5EMNOsGtgIoa6kc6sfMopgT9fefSVPx0k5aOSRaC8swVp?=
 =?us-ascii?Q?pdhuyu9Z33ZmqB/5NQmMkKQcKK9eCRtzg3zriqbyoJuY0Cx3QD0JSExmtN5z?=
 =?us-ascii?Q?VNFnM98Zx7f/mDRUZAPderNzDIx6/EmGJ4WLmYvDn1tlB+fHKSdemJ/jaLys?=
 =?us-ascii?Q?87khFpZM7291qPLC61PVwT2HztmRL6S5deH0AFxaU28esNwxAwXl5ZU6fLqe?=
 =?us-ascii?Q?rNE3YJk5XLYga/tA3w9Vhjgr1h/gXGgN/mrjWYc3j17G6S5QWsssxlYVu1ng?=
 =?us-ascii?Q?o9sKR5OQ579jmFUpay3gAkB4HQDIbR0Ue6MxHkVe17xUiTb18FN3omquq1In?=
 =?us-ascii?Q?XPYiFZTQiO3D03F+34GLAMebCFlFLOVAt+ySaE10ZjqbyP88GcFWopj7El9D?=
 =?us-ascii?Q?Ga3J17V9qshHQ9+2us66bse7h1zjQnn/Ggg8Nqy21FkNyNddpYg5ydnuESmm?=
 =?us-ascii?Q?IfabziO6zJ6ASGz8T8tPuIDtOBqsJu6iZtWwguLA0ZRsnWosMIzTl06dWLGF?=
 =?us-ascii?Q?hfQiQSVviUS8avrU96tIVwbLJ82OcbowvVTkgCHD75Zy5C1oG62Teyzzf/wJ?=
 =?us-ascii?Q?GbtDtfrwe5wvh7oA69mkAiWUuqQBiFxOvrbWguUqSkkfWBjLabxB+IK0dAzs?=
 =?us-ascii?Q?TpfGU6VoFMxjVJPMGZMa3PVuKSJjehUuINraC7d8pf5V+of9jSKdmnR1xMT7?=
 =?us-ascii?Q?Cidx0n9pGq08HhvPwPHWLNjEbck1H20RRW/UiesBEmHEYcdZrpbHwU/us6Ua?=
 =?us-ascii?Q?mgWah//FhoUY+RtmfwMlYVTHKSFR9SfnI77IHnHTo/vpy7GjciGhEZRvCVTR?=
 =?us-ascii?Q?5qRCkPHjMMQLdolVdBg9W1asYlyhNqDd+asIpJ86DSVMuH80iJX00BgW6FOG?=
 =?us-ascii?Q?KbH8hmb0JGNlVtYrkn+Wm5aGSnTDp+OtGEazH41Zk7vw7c+nB2Pe3xrYKr1l?=
 =?us-ascii?Q?JGy4777a9+6z/ThmO55yFD4oiRtnLK6eQvnUzy9WoiwmrBH9BGY6cVelG66u?=
 =?us-ascii?Q?1gVuG0ngetWz0Wjhglghwu9HJNvb2FOvjniuyG7FO7/wN8I4K4DWMta47TWg?=
 =?us-ascii?Q?UCn8KjdWXF1ytwpDMIuG5a6wS+Ixjm/sbSJN6wAg/amNiM7yrhORFGj76sM4?=
 =?us-ascii?Q?wHyPVGnvMZT23HR3ZbfNNmYF2WrSEGomHswSWUy6lf3hOMK+LA8m3N7W4naN?=
 =?us-ascii?Q?YN2aq3s6iNr5E7HK3mWX1By43unUMv3tx+eNnBpbOSTQHNJ0tz5C1JqVcPap?=
 =?us-ascii?Q?hdy3vQZ/ioL/zJPdoq+ypKz1JDVEAz91LzxMPWFtW0gqh6Hso3VpjSSTJwjZ?=
 =?us-ascii?Q?WtA7U9LFUeYhe9+SPfWrc1fDWbEjRcmIVWgJaYwjlakv2JfaqzcCApNN40mL?=
 =?us-ascii?Q?B++QfFp+AwpOfeNcITYFJa2YdZMYGNWDSsJDaW95oq7JGRELrBE1cHJnj0Ga?=
 =?us-ascii?Q?iry2bxCkzbxn2ZiSTHY8I6CaOheumqPs4jKQQs3+V03QdzllfxQtE0W6/zcQ?=
 =?us-ascii?Q?MCXUWUxH2ZpshTK+GBMNw1zRQ1UzqykEDgTdgjvjqehpTzaOI7kagysyLbkV?=
 =?us-ascii?Q?r4aQ2w6JU+D5eNAzx/uvezXRhK+DIBMwpFGCICDirSchuTyX+lhPdtKj+rIi?=
 =?us-ascii?Q?8jMwf8cfWw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2c159e-50b8-41ba-d826-08df12d5fde7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 03:04:00.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTD2hrwD2UuN40PgS1fN/oNq4wxEkyp4XpEfV2xNhvqvv8njY5hR/aYCuJ6qQ+P4s+mxHoS9iq6QsfO5HZnPJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008

The static rwsem initializers rely on persistent lockdep class keys,
both for their own maps and for embedded locks or wait queues.

Enforce static storage in DECLARE_RWSEM(), including PREEMPT_RT, and in
__DEFINE_PERCPU_RWSEM(), covering both public per-CPU rwsem declarations.
Automatic objects must use init_rwsem() or percpu_init_rwsem().

Assisted-by: OpenAI Codex
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/percpu-rwsem.h | 4 +++-
 include/linux/rwsem.h        | 7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 39d5bf8e6562..680c3efc14c8 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_PERCPU_RWSEM_H
 #define _LINUX_PERCPU_RWSEM_H
 
+#include <linux/compiler.h>
 #include <linux/atomic.h>
 #include <linux/percpu.h>
 #include <linux/rcuwait.h>
@@ -36,7 +37,8 @@ is_static struct percpu_rw_semaphore name = {				\
 	.waiters = __WAIT_QUEUE_HEAD_INITIALIZER(name.waiters),		\
 	.block = ATOMIC_INIT(0),					\
 	__PERCPU_RWSEM_DEP_MAP_INIT(name)				\
-}
+};									\
+	ASSERT_STATIC_STORAGE(name)
 
 #define DEFINE_PERCPU_RWSEM(name)		\
 	__DEFINE_PERCPU_RWSEM(name, /* not static */)
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 6a1a7bae5f81..faf52c0c8dd3 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_RWSEM_H
 #define _LINUX_RWSEM_H
 
+#include <linux/compiler.h>
 #include <linux/linkage.h>
 
 #include <linux/types.h>
@@ -111,7 +112,8 @@ static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *
 	  __RWSEM_DEP_MAP_INIT(name) }
 
 #define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
+	struct rw_semaphore name = __RWSEM_INITIALIZER(name);	\
+	ASSERT_STATIC_STORAGE(name)
 
 extern void __init_rwsem(struct rw_semaphore *sem, const char *name,
 			 struct lock_class_key *key);
@@ -164,7 +166,8 @@ context_lock_struct(rw_semaphore) {
 	}
 
 #define DECLARE_RWSEM(lockname) \
-	struct rw_semaphore lockname = __RWSEM_INITIALIZER(lockname)
+	struct rw_semaphore lockname = __RWSEM_INITIALIZER(lockname);	\
+	ASSERT_STATIC_STORAGE(lockname)
 
 extern void  __init_rwsem(struct rw_semaphore *rwsem, const char *name,
 			  struct lock_class_key *key);
-- 
2.53.0


