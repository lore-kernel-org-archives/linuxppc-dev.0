Return-Path: <linuxppc-dev+bounces-27285-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C031C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 03:15:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkRvS4lpmz2yhP;
	Tue, 15 Sep 2026 13:14:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789442068;
	cv=pass; b=BkmYsl5fjzgooNMjGvY9yGG74AyEkQUILP1Ca17dmCzuAvd1MZ+JJppGNdSSZoqCCIaj/nqCtbeyjy93z/bcieW2HQMVa2DGVNsN/NpAzGRitxW3E/0PD81GJEzF9XZmt6i8E/O4ohDzUlHFVZo9+SaoC1YxlZTyUBg+qwkxBaUzUUSjcn8W4fL9lCCqb1BBqMvNQ9kP9994VVrVWLdnJSUpJqIckNHV/daJWYgZ+hVhyV+kB4ec3kjw5KZnSbWC5Mv7NJWna3/lDC/h8jws015OKXI++n6lZIPUYQlSacX5DzAQt1x/GZ4hf67iFGHByb2rfZvkn2E95YaTaQAR8w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789442068; c=relaxed/relaxed;
	bh=mOh45PQ1guvyokDHmGc5oZcIXFe6sbxgT/e5DfNjIls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YddDU4OqCEByyn6t5JP/IioFc41OBvi8gInGsFj2fQQl/pFusrso48lg2uJEi/F/SdhYNhjd8RykQ76n9Y3AXEn4UPyMDZ1Nf2XMVnZlcD5kMKwTKbhu6SKOr5nntxKFPEpzmAoD7WSc2dD6G+Ph+7ndz3vFGwqF8GrlQQ4LSkrsB+EL7A8mxShTQXHAzkApvcK8XIm7qVNDD54KJRgpWf93jQbv2GrrEasno/BZcXAsASZrcHDRI9J5SH1uM1wGnpqLZyPcXZZ6kQBmy/5d4l08HpByZ5rn/rXSrW9DXy6CY+SOSW6OJp+HcNRpGMFrxryDMFDKoHeD7MetUSSzwQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XECGza3x; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XECGza3x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkRvR3G59z3bbW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 13:14:27 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8OZzcJp8XVt8zzRRMmZiFv6i/QbLpeWQ9LtsdtcC1TyTOiRa6M4z3ElMMbJFRlmrt52AhrxJzN5zpaMDFllpV6lUQjE7lqA6XSKc3UwcJ2dxNzW0qZyBXbUX8NM4j8aFnx3pPo4PCSbQdckUsyjTkEOZbTOPGqmVOaj4JljS3D+gGNoI00bl4s6wxsK34g0PNOjeTAGxTOdZGnpirqmr8dHmwkmTza4suyXep+h91kUhukQsH5jSU+/w85MAd1Jk72NodGRQhA+EzzyCGC6NIOWwv6iQrN+yzJhPAXSw6abp1YiZ2Hy5GTrPEDR6WpwT2dEim6B49RvBbImlrar9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOh45PQ1guvyokDHmGc5oZcIXFe6sbxgT/e5DfNjIls=;
 b=qcej4PiUA9m7Jd/Pt9znTvMPMfNtplTH4Em8sJKAsZegUMZo9jNexEvz3fWfSk92uLWfkG6FwHmXZSj9yo8F31zLAu65TlhiLdi1p3kyChgn6WH2gJnn4dNXl1NdX7l6GAZZ4jxMdZkicD1x/WPnQI1XqFgQR3I0JhZCSUjAHdTLXXqIOTSvxUDId8R84dCVoZroOQ47N8cI2KoMCz1imTewo40tlVnJPJIJtN5gqdEEo2RzSGX5cHCsA1JTbDD/Ufd0Q7JSm9qtYqr1Jge3wjxzf2Lr3pvXqqlOSrk5KLoFSdONDEZECYZYdD9Rqijx7MT+krcUjUICtzzAlwdtfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOh45PQ1guvyokDHmGc5oZcIXFe6sbxgT/e5DfNjIls=;
 b=XECGza3xFTRds++v2cKaSz4gQa15MfI33qynl1cyJt032ifj2VvlbZBlql8Fv/u11GPx6KmLiY4CXsqDjYOr1y1qR9XozGxygW2G/ZydIAP23pjw2/gvqBFRNO54SZTMAJB//1215+GzfPkMlM4tuX+mtpoYF31DLlnt711dHgyDgSRJaSoB+diZ8qPuPVXuK/tU6V9gPj/u6jAyo5A6B6ubrNvNjJW/6xYiH2l+FM5xC5l+L1nr2p6OjlLzm+Fi/iScKf9S4cXU19XcMtA+no2UOPCMr6/hfcvoYu+wpLa6bh9Bgr8K8WQHmGYga4oKOWP0huPCIcHvwdKG0UnEhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:13:44 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 03:13:44 +0000
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
Subject: [PATCH 07/17] xarray: assert static storage for DEFINE_XARRAY_FLAGS()
Date: Mon, 14 Sep 2026 23:13:22 -0400
Message-ID: <20260915031334.1194975-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915030336.1192299-1-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LV3P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::26) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: e1f243ba-da4e-4a2b-dad8-08df12d75956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2Y8Yoz8+cArf9amARJOTPKR0hu7m+D+0vjBlQRHsF+X2LR4CimBZ8cbcxGg3Aiv0VMD9nTGn6i/JLrKfrJ2yqIK0c6Zh7EQ+vOtwqgDUfG+9iDs2AR70Hb/RoR92sE/RbiqiF3bnG2uowiA23FZbXD6AB49swidYgVihZ2tmUJdMHt1uNwi17FCvn7X+B7uAYN1dusxfTMBoUMBPyF1hDa4WgwwYVfWLMxDYxsbR+sH5eI/yT/15agpcQXdFy9QkwgE/Cy+e2V8xAqgEBfw1B7dFKvdFmUEs1deIWOdRlJKbNFRd1xF33oqVKaHG/EJhK5Za4Zpmq2O9xFO/STI6IttEFhgxOh02x4uuqwfi6rFnCQnyj/nB91dpypCbDYDRsEsobGNoZcS3trvB6eb4lNFmHWjWAdb+3oiCiJeOlici8XmvaaAa5aZv4trUj0SzoXTq+UbMHg+KHYAQdFCDKok+PoEWF5dZwFeLGYpBy6U52xNQi3FM+E5kRbs5g4Wx1l/U+scKlplSARzIyIVUlv43aYH0Q195g5vO5ZKL/846qAk9xMijqro9g0OrBXn8Vs08w9vfYpbqt7duhXiMWkQcla6hshW2YdwF2yz2Mw1EqHS8Wv4+ACSbTYhQFwF1Yi7CoupYiovczELZPOdRlwXo8TXeb86o5f2NCHpJAwE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?86t0Ols38gxBUZ/uyBErePbeXhxfgGOQPkqyM1jHaWQVfFLTdBE3l3n3J7S5?=
 =?us-ascii?Q?SKg9YSo7DjdW+sAiKkqGnlDXo94VXOzcjJ2LLr2lf/jRde54Iq3dqRyEyBKw?=
 =?us-ascii?Q?gY0AiioHwRjiyR2o7yvZxW0ifJwGv3XF4xPCxHdehptqygq8+1Z7zgj9NxHT?=
 =?us-ascii?Q?cVac2fu76MVb04FehocUFB8WPhjBizlZjrdRNMumoopYNP4Tznf4UCS4Ei/D?=
 =?us-ascii?Q?CcnO18jITTKttlB7K8Uu1bdSTmXs1Zq1jVqCnqZTlsgRRmqBXV88uPjcnor2?=
 =?us-ascii?Q?AjjP8NEbg24Y3oWmAayi0W1Al8K+99gnNIs+E0CR57IcXqLU5I5qzp4lzJFL?=
 =?us-ascii?Q?Jgnq2X6F5Pm4/sGQ33Wm/k19q7wLfHwWKrW0UVVqwgDMzkK5tFeYeMA5QJpv?=
 =?us-ascii?Q?f6PZDB/PaIb+SjUFTHvT4cqmQzJlqT02DfsF+3rAlaiaePszOcQ+bWWZ99BX?=
 =?us-ascii?Q?VlXk9j2ZZHCy8lLzKN4YEElAue5Q09b5uJ44cWuRkd+8J9iVFvmaRYqkVETL?=
 =?us-ascii?Q?FoBGWKXuC29066pFlQJzNEdgzv1NWSLlMCJ6ymQom/iq6Txq9mC9tx3r05TD?=
 =?us-ascii?Q?ThxUEWCnyPFXMZVk1lf9KxgwebJDljotrZaRbB5esI6rkk+m8ojtcDfzC13r?=
 =?us-ascii?Q?pHQooo3dG/zoTEB6OOI35KcHYtnQc7idGMuzTsbas16KJeCggkSAGWXAs2zw?=
 =?us-ascii?Q?p+WgxFGOIJi1zFVFIr83V/IJXG5hmZsP/WNXSZ2AaMEow6Kilv/A9o6jSRJx?=
 =?us-ascii?Q?KhoSM6rUSKo7dVbb/EDSc5boJbe9ENpX8vAsMqhsmNkj287auYmPw6M5jR5X?=
 =?us-ascii?Q?lLosQ6inCZSxNuAhx4crcttQhvjjffYSf6RoUbvVw6ox77ghG2y9hpe3Wjbf?=
 =?us-ascii?Q?EQ3zrOs+yFJvzCQKigB1JzZ6QFje7BK+ae8eAr8QSHuva08ge0PQH68kZUUi?=
 =?us-ascii?Q?QhZAbmRAbA52ZwvyGVwEQPqouxe90k+z7uZVVK2e+isPaa04vO5qvYeqkEQ1?=
 =?us-ascii?Q?NpCn1VD72BZA7d7ezdbMYIfeNOxKqM3adHJ5bROyR5wFQpr9Zv2Ch0e8iyOy?=
 =?us-ascii?Q?bc5qwDIPd6XwRX4Hvl8D0wv4huFckS+AS9V4vncg9TN7/osMZazs/PjT15Lw?=
 =?us-ascii?Q?R121G7MkkGrOQLuqJ3kzyElOsMEAQjyiODrDgIsITXTSeZGhirjNwlzY7ZDs?=
 =?us-ascii?Q?n7ixYniCkV9daJyACxrhA6jsGG/Cs6MhqpBXQd87yHnuFH4u2LK62ERkfr9d?=
 =?us-ascii?Q?AVmHkQUBrTM69AUj/xDubgLvAE1lHO11tpdq1qlvESMktKPUlBP2qyIqG+lB?=
 =?us-ascii?Q?Bv8IpnsZgxZYSR7AEEqPA+8V4prCSCWAxVllvkXrmYrkurtfkS73LUwsKeqW?=
 =?us-ascii?Q?R5iAVWRiaSBaKHFEQszR21tfCTObY7D4lK7HvgYAHSMD2/hvtWhcDZNAUD/G?=
 =?us-ascii?Q?bgNOxxv9+ABwND0G6zIZTrRgROxNFnCEAtwwYT3bXrAjsLlW5WdzzpOKFeIf?=
 =?us-ascii?Q?4Ii0D3vZIXInbQJcog2LIm1Jendn13L2oq4vb3Scm3wfvSEtxxRy35vAqmzF?=
 =?us-ascii?Q?FRRwua6okpwURhr6dIQDZd1KaAjtomwqxn5eKbkwdebtH6oLJqoAnzzktUfH?=
 =?us-ascii?Q?OKaBJDsd7t9gOmzjS7F0OkjsIrn7BGqKxl+du6tR0z0wyBsm/EKtEDyvvXKG?=
 =?us-ascii?Q?en3aKqah6HAMaiqxHSROteSKQKfRPhS1jPVtIWqSjWbJxakaNVvLN5cvg23e?=
 =?us-ascii?Q?0WhIxTMXOQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f243ba-da4e-4a2b-dad8-08df12d75956
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 03:13:43.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFCVL9XPe07WXVi+nq2gI7EAOXogvaWs1P1da8zRpNk9wApAx7MtdDIlqgweCslt8ojshxe/wgviJjWA4nsStA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834

DEFINE_XARRAY_FLAGS() statically initializes xa_lock. For an automatic
local XArray, lockdep cannot use the lock address as a persistent class
key and disables itself when the lock is acquired.

Add ASSERT_STATIC_STORAGE() to the common declaration macro, covering
DEFINE_XARRAY(), DEFINE_XARRAY_ALLOC() and DEFINE_XARRAY_ALLOC1() as well.
Convert the automatic XArray in the userspace iteration test to xa_init().

Assisted-by: OpenAI Codex
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/xarray.h                       | 3 ++-
 tools/testing/radix-tree/iteration_check_2.c | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index be850174e802..9b9a5eea006d 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -321,7 +321,8 @@ struct xarray {
  * initialisation at compiletime instead of runtime.
  */
 #define DEFINE_XARRAY_FLAGS(name, flags)				\
-	struct xarray name = XARRAY_INIT(name, flags)
+	struct xarray name = XARRAY_INIT(name, flags);			\
+	ASSERT_STATIC_STORAGE(name)
 
 /**
  * DEFINE_XARRAY() - Define an XArray.
diff --git a/tools/testing/radix-tree/iteration_check_2.c b/tools/testing/radix-tree/iteration_check_2.c
index aac5c50a3674..f798603a6f28 100644
--- a/tools/testing/radix-tree/iteration_check_2.c
+++ b/tools/testing/radix-tree/iteration_check_2.c
@@ -54,9 +54,11 @@ static void *throbber(void *arg)
 void iteration_test2(unsigned test_duration)
 {
 	pthread_t threads[2];
-	DEFINE_XARRAY(array);
+	struct xarray array;
 	int i;
 
+	xa_init(&array);
+
 	printv(1, "Running iteration test 2 for %d seconds\n", test_duration);
 
 	test_complete = false;
-- 
2.53.0


