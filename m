Return-Path: <linuxppc-dev+bounces-27430-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4A8C88E7F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 15:54:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkmm82k1pz2y8m;
	Wed, 16 Sep 2026 01:54:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c111::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789487656;
	cv=pass; b=UG+ZHhvzSuYWoNmByazhUn2yrx8mqYVICE4hmKsO62H+lId4xrCGJoIlW/lqYaqyBzMvfrul5S9RrKUe/K9a3W6b9HMrbhYLmiXY/AJzwD60poWcHAhe5uFKKn6UWRaeXqLxfotGefEKst6CNOkwCI1glp1J9BdzUJ0s8z6xD6OkjpVHr9VBFV6KpKWGjIpXN3TiyRTaEOgA1qOHwGjpL4KXwAZbwcXdJY84vI0h20LGO4ByA1kMCEAuNfBX4QoZsjnfjcfr54NZZOcq400iOnZSxPH7ofYMw40gclYPH9+ZQk9zHs/F4ttDd6uvWqPT8tQV4LNbLWxS33wzHRI5Cw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789487656; c=relaxed/relaxed;
	bh=LcHuBiVKAZ0fpaCeLr1myHlzqWosgg3CQFg0zLYOEKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ly/MGNuGjKB7Mbe6PrEKsITijf37SlHpnxw0RZe/yO3zodSvriIkruwTbAWAoeNuqHQeIRy//qfhV703M5v/O9M4rTfkGG6nK7eNhTDkg4CyTvY5suh5xSMReWNNSu6o3JyMGA7qgQcZ41m8/pU9hByoCBnIGv/znrGJrChtAOceXVjzDWmpOpa0LrDx1GcsmLybCxi9XDfKGP4vIDVbQlrlwR7tylC9iottrO1HeE6XAIrVWFdfXuvyuRJL2Q1MG7J63herJOHqG9yJT5SWZTRLt5+58S+J7BozOZcXZxCpjVupPYsEbO8Q4yaZJiIeJJb3OmgiCz1RI3++qbOVkw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=I6CD6OGg; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=I6CD6OGg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazlp170110009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkmm66x8Sz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 01:54:14 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQ5vM1dxwRqkeCTpiy2hrY0hkFjMDY/q02iCMgbTsGKNhI9zXJWXme045NU7QRaTdi2sWT8BOi71GRWUKWao+zTHc0nEoI8CiolAyLFY4l1p3eoD+J1Sv2zgkwnxCY/2MgqGX1lQfViW77A3JRiJh3dqk/CXDkNFLxeM47CLaJAchWgkzAabBZl9YLNNCA511NFMZayt+R2vjt0FJSxa2cDkTvqjpV8qJ/aV0PbkBdYeXeuRA67x9HK567XkdD4eUiJi/YyVTjZrC01M7B/V9ua8NdFbU6NBm2T/iUG5IhJn7cMKPnNDQD44tM1jMoIQmO+rKbwtTimaO7Icp4gsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcHuBiVKAZ0fpaCeLr1myHlzqWosgg3CQFg0zLYOEKI=;
 b=hV4XzKGOIM/k0QOxU8TLYB8ZBcKKC2NPBW+RtiAOv2HhKuBaQRHFu92FAPROPAVMthf14Y+0Bp456FIz3TAmVobmQjxKG7h+HO+k35LyT5IlxJNarJCSEnkFrbsTEL5jcp/mQXriLAz/uE/cb7eyfWZe3C5Rvkcht4aZizPXtV2PZAjVDpxxlcFXg31aJzIpbm1kUETr9QBsHVtohkiZnDE5DOfNQPCAOH+PWeAzBPfThG+Lv+fOW+Yw9PWW5LuSroH1ONJr8/264kv8/g4GtV9nVf1FLja+qBl7meMsqk/jNYlOBdF53FlAj36g7K2LbAnpPh3j3qt0SL4LLEem/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcHuBiVKAZ0fpaCeLr1myHlzqWosgg3CQFg0zLYOEKI=;
 b=I6CD6OGgf6kN/spLwN0AIDEYAfYnPjBCFB+QJhr3xzku7Qw0MjTDR2pAh7uDao2M6Lp9EpTxUpFumKBSzreeSm2BxhrSZOjFZAsEhsg1Rc41+bVDPXkKg+j039E9r3lZrsBoiKl3cPTpVGwOyP9q3QkFG/w2OYwyX3kajwN0fZN38gKOdDLvh3c5b3G3YIrUsBpahXcgvQR5YJi9lAK5Z5rjgHG4ycoWTwOioLGD+6zdTuF/ayxldRicmrhbg/wON52wr9isp120P6q8/P1vPGSCb2aXJIY0ob6a0UC0RaxruOLsKe53RS/dvVgyxRJhMuIkLP+O9NIM7+GGeJv8Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 15:53:37 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 15:53:37 +0000
Date: Tue, 15 Sep 2026 11:53:36 -0400
From: Yury Norov <ynorov@nvidia.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
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
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	rcu@vger.kernel.org, virtualization@lists.linux.dev,
	linux-rt-devel@lists.linux.dev, llvm@lists.linux.dev,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 00/17] Treewide: enforce static storage for object
 initializers
Message-ID: <aqlqAG5csUPFcSzQ@yury>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260914231418.b15ec01f7225cf460f6e515a@linux-foundation.org>
 <20260915102401.3c56aa95@pumpkin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915102401.3c56aa95@pumpkin>
X-ClientProxiedBy: LV3P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::32) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 96645693-18de-43b5-1df4-08df13418132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|6133799003|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	d93qJc/QuT2rjbcJj2BRBeNsqLTjh3OrN8BCMIbyCQM9bGQhvxhiz/Xdw9H3KX+WEETMXCNV1bvy6cANZz/p0P7mAIkmLVukJA0t0LCIczMpsXWVsBbEXyNbSMOGw6CTrCypw2d3i/Myfw076do+S+ZKQqrs/oKKJyy2xa3Q+BdOEqGJ59bRcZ48ZvQqQdSoJJhnIFx8DW5ZJDWwotHJWjv7FxufwbbPRM88AfVacusbMzRsNJl3V/PdazCv25POMf8CKQbQ0xM/eekGBgyftEDwp12qaoewkZLXBqs2olWorzIVP6LoL1J2X/GawJASTXfLjU3N0F1KZjFk+Zkdw5ULo3CXrz8e1mwhDznE0hLi+G9aaRES277JOSBr69K51vcTckoBa1Itq9gOY66h0u42kpVw5BNRhfz/iYpYrDB1WdNeukAvRyaslIf1zfkPUhFqlXrgy8t5GuJEa6siy0cbG1zXJSLuXUV0NQxvUI1fvNk4PTA5X6O9i1BL6tJG1l0vgSK3adSF693OA2uwWtXGWYjxX42seJhsY2VYYlDab/hBh1sGMGicARwWWotOtCKSNbpA2Xwzmj9RjLIUEECAvjeHEa2GFWEBjgmSpgI/iL+6sqGrx9S2wmUUJJMf5cE4hOnPFwUCWDlaIUSS/5LIYx6OLS49gzItGC377f8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4OFgHVTW8HAL8iD3NNGVIKY6JppEMbxl8qtf4EYb6qhyOWuhn+LWbG1vTehz?=
 =?us-ascii?Q?Y/CK2tjNc0sXtu7Tvpc4C1S1WSmENYCkRzloS53zF4AJd/qNih8r55pafUNn?=
 =?us-ascii?Q?6AHi2/4wbprvnZCk6ireeqVY9v+YFSnTq6XhGdXeR5mtegrRyYfQaes4L/KX?=
 =?us-ascii?Q?IgihDqM0Wg8tCc7lS0MaMorClUeSQE1KDusBJJylC3+wgMhmqN3FdwuwnEMe?=
 =?us-ascii?Q?HJcj8+INyJcwneNu3sbtUmaFwZ4vBEjwDnp24u/h2zcgaA3BmJxNnLawrlyY?=
 =?us-ascii?Q?B4RecEybkxf1jWnooyUo3NEx7oHcdxfZDCSZg6boItTmlZJkgHAPtAo12Iar?=
 =?us-ascii?Q?6CftdUZ8Pt7bXs4rGh5ZuGaPc8AyCIm1NuIPUmZHmLbT/cDqzSH2km9a8KzE?=
 =?us-ascii?Q?p7hJgcq97gdVxh4DORSDz5m+p3sGYVFsvUKLDTrFxoKF5FXkwQzD3RNVe5NS?=
 =?us-ascii?Q?W67J4eSYJi/2oJf2tD3UmFefEq2wRl9+tyknv5R6DclTqeiJ+qTBQxjoGXd5?=
 =?us-ascii?Q?cwotGdP3CCEys1mR/9eKQcQdFHvNnj/ahTrM2zbfUfeu7iIo+9z7dFnCYHzy?=
 =?us-ascii?Q?Pfg+SHCdE3vu1jT23szVOjjsdnxb8yWZM/+Bqf7R7hrAeeGXsgzld7xqa+I0?=
 =?us-ascii?Q?Zl7ymI59DsjI1QbaHqh+MFARWNpgKtkkYdQHzD3BBceE3u2Zbbk5Ao+mVLT+?=
 =?us-ascii?Q?kGtow3S5L2KaI6B4+0zqJ0j3WhF8hHY4YErhej+l6SgrlkLmVOOuvHv0+hEF?=
 =?us-ascii?Q?8pVLxI9bp5bHZDaepRbHq6jcCjTW01yw+3BUndh5OJn+5bylWApJ+OBhNIi4?=
 =?us-ascii?Q?MaCJKmnh1ed9yfurltKdH68p3k0Zu7p5yyNCiAJoFkZ+jy3rwm8sk3ZAxhOJ?=
 =?us-ascii?Q?lT2ngdpu/aAkaJZomsiR+7L+I61Pxnmu+DS9cI0LT8EH7hCmFTz1lLgYm5v8?=
 =?us-ascii?Q?zhC9rgZ4Ieub9wjrXoMVuxX+9LsngHuViFTy5r8Lmtqi8wHCtKolGmbqy0uJ?=
 =?us-ascii?Q?HpmDH0XayFHZCiRZjPjhtl9XG32qgD0YJ/3x/1mG/OLcY0z46OelIBfZvIdI?=
 =?us-ascii?Q?ffZqdsCu3faqBWR9UpSGLHS0SGMA4MHOKgx7D7wGezffPiXjo0+wquUZbvK1?=
 =?us-ascii?Q?lhowiaEe+G2z7989dHevm2uE1yBxlSh8A+Cn3T9zqjj26K1vd8C2Je9JU08x?=
 =?us-ascii?Q?SHjJgxOpZrB1aj4hJC0mVj6Sgo0vXTbn7KEXFT0WQ74Ccw8FoxyDAmon8yz5?=
 =?us-ascii?Q?iIKar//b0xusBbOPu0mdg8Zx5OjQ/pGj2+qLocoSYQ49nxKVwtjbK/RsP9eT?=
 =?us-ascii?Q?RpFg8oYOH188PWJkD1eJq5cTNrld9ObVA25LhuM+cxj+5LpSJMRnv98uzJW6?=
 =?us-ascii?Q?bo8p/Swhf0+pN8I3eTbjJ1fyGvSe6YOY0wiaJrSxl8PYYvEfiYNCGU7pawwo?=
 =?us-ascii?Q?9teQYf/I2PjYUnxXOkc1gs/sa4N5NZMLuGbq8+hkqwZUGwpCFca81uOS6rT0?=
 =?us-ascii?Q?q9gNOEidBZx+DxRg9cHeVAxYWpnWJ2n1fnDXj4Y0AHLP2lGDoEAaDGfz522q?=
 =?us-ascii?Q?Xi6Hmv4amhJoPn4+hqKIwvpLCPddKy1mWdWlzE4tvdCS2xNTnogXm5frJosq?=
 =?us-ascii?Q?5l8V0kBc+opmFBvmEmyAN7zauZpy1HAmu9sUDbBU0ddN/3ug03/ll55hRAP9?=
 =?us-ascii?Q?nWP3ELw2jzBD05LlpPTkkkknAQ9JIq7rBVM2mFgNXkCjppM1215ExISy5MBH?=
 =?us-ascii?Q?0saeDTI2Ow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96645693-18de-43b5-1df4-08df13418132
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 15:53:37.3269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOOEBUdiMPdo94hOTsWhrIBDwu1Hv5iXG48S7cL29VtakwzKnY1EzNnlDRkstcRcwqi9nwUlVC04YX1RhggatA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329

On Tue, Sep 15, 2026 at 10:24:01AM +0100, David Laight wrote:
> On Mon, 14 Sep 2026 23:14:18 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Mon, 14 Sep 2026 23:03:18 -0400 Yury Norov <ynorov@nvidia.com> wrote:
> > 
> > > Declaration macros that statically initialize embedded locks require static
> > > storage when lockdep is enabled. Automatic objects must use runtime
> > > initialization so lockdep receives a persistent class key.
> > > 
> > > For automatic local objects, lockdep cannot use the lock address as a persistent
> > > class key and reports "INFO: trying to register non-static key" before disabling
> > > itself.  
> > 
> > So why haven't we been buried in reports about this warning coming out?

I have no answer. Maybe because lockdep isn't enabled by major distros...

The original report came from i386 randconfig. It looks like a combination
of some luck and a new code, probably attracting more robots attention.
 
> Are there any code changes outside of testing?

ams_pmu_set/get_register in patch #6 for example.

