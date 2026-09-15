Return-Path: <linuxppc-dev+bounces-27286-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31761C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 03:15:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkRvT4clgz3bdQ;
	Tue, 15 Sep 2026 13:14:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789442069;
	cv=pass; b=Gk3VyXLQTy4V/CcIO/VNDsXfqQ3kMe3VvWAqPK98qX6LT80VP7CwjTdBpnKkPU2ScaRjQSCDeYScO9Hqd+jWCqce4F8nNjt0oeLGJwyc8/0ZVGaxew3r8lxFhd97AYQT40i7GvHO2J7HjT9bhfkMKq7oEFz3lKXf9h4OOzfg90ocnViaYgGhJWdKJp7usFY4PKoZLjytcxjntL8CzBLuN49gWKi4UtFXRd2/bUZyYNpvr9JqybY4t4ydri5HtRiU0B1QU9EVXVrSdH6QaY7mnuUiH7DdUnAX1M/zFv+ftlTgNRF7+KfoLOtgnZDe6ooqvFCpplB7JhHVlaEYwHdbuQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789442069; c=relaxed/relaxed;
	bh=ZogL4xAOezmjA8F+JeTsfzBaeKTtrPOHSdjfQTRFq2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDMD/uw+x6+IJOG1tfGv5JIaTh3sooqQmR9GdrXbo9Hnu6w+I1HX155hGia0XPf8S16TGWYcDDySzpnsaPPLRVxlvLQGIOsmYwyFg3LGirWDDPANK/wXqrIYiAWm5XQz6G6E+aEwX3J1Jt1T75DR03muyp3M7nAWyQ5DgSIfRHLgRZDLxRVlnaa+NKPqaCAZ05r9VZjyce7q6A7bahczgeGz5dexRTy2Rubdn6MX7OvNltrjq9BftH2IK19kqHeo/ZV47KovZaTz9nGjW3KKp7c1sh99QxOkPzwgrXCgJzJuBKR9vDkt8naeNoNG8F7HhTOcMxTn31cNjBdbs6ig5A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QGZdh4Y9; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QGZdh4Y9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkRvS699Hz3bbf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 13:14:28 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iw1YT7yvs5p+y9xcxMGtJAZLNr+/84np/hKcKSOIthHSV6x3LthgCRLAFDbV8ZR/+5nYlGWXneHdp9t593ymLxcSXqgQtpa+bZQwnjciHlQM9IU+lp1DTK9Ph3Ru9DxbmQj2vp61ulI9bsnFFWtxYtcEHWWceeaGsC3przMwnbON1Dp0CRwxQUSapmjgDzc7XqtrLGOiwZ7Z+m604JkLDKKNAIQ6BjelTScMkWxtO9DxViwVzsa12H5Qh26Mbb7xNGtsrANgOk1geRxBTc3Mt2Z3cRwQQNemQiSs+YahMAfGBD6MxUvqhXaIZx6DyVpZ+7IRMWWbOgt5zrwjdrGJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZogL4xAOezmjA8F+JeTsfzBaeKTtrPOHSdjfQTRFq2c=;
 b=VRKoLc7oRhwa6bR8DvZnDk1fBCEPDxbM9CoiUSfY+ucnWpnxqu1r1hQ1ye21mB8L5CHQ5Pc8JULXXpdLBWtUt9htmjewP/Ld3Y6j2u8h4TjDpLSaDpxGNe3TNGkjG8kMMQ6kBRoIlFBDWIj8hM+H5jKkMJDpyo7zfSqQKu4DQzDTmtasniSyS20DChBQTp02XVdPfIMrjvOL9VLSZTL0Sn3UCrhbHF0nNqNCECe+MH/py0nNkBlRXlo1rcHzZa+YVBjEdVliQP97SCivSyFAO4nQX9jfxLc4XHrJHcOhLG7NAmP1za7NiYiTDihgbZxt4HbZftEfL056H4hVNMvUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZogL4xAOezmjA8F+JeTsfzBaeKTtrPOHSdjfQTRFq2c=;
 b=QGZdh4Y9ygjTFc65z9RmrS7BMMmz/wxyZQhIKDwbFeZQKsuTPn8M7IozGHehI20byk9Gp4jCyIO3+Mw8+pW8iPNk2MQRIuAdeN9bRfu1GZBU7ZgKI9n9OoK3DwCgHDdnwl85KF1eOM5iG8I2p3KiLFrtzYqKeWHVwnNUY2fCJVHkdJDj2ednoDTO7LHOsCyTPfKlSmGTOWOPAUalW9Xpi7OxqhothG4+rWTZ76hVQmUKj5aQkz/oYqYtyUA6fpYlUHAOAIucCLznI93k9eYqRH35afSrhBbKd/UqhArK4+jjV31A+ZP59JJ3fA8PcvHjKz2pg9+fMM2AIa6eucjzKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:14:15 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 03:14:14 +0000
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
Subject: [PATCH 14/17] ratelimit: assert static storage for DEFINE_RATELIMIT_STATE()
Date: Mon, 14 Sep 2026 23:13:29 -0400
Message-ID: <20260915031334.1194975-9-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915030336.1192299-1-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:208:32a::33) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 3840da1e-568d-459c-af98-08df12d76be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	3LU6skUUSbWGRQsc84UpYnVV2+weAkBM346N8cTjLdwtcqFFfZOGsY7aBbIdgLoNGOOhYtf7++LLSCfoomHde2znb2467RvpH3EnuZ50nxhjT1WK4rGowCiMpAjf9zN5Avxd2XI5ouSHh7a7/f2lebYEbDMD863sAX9v5Rs/5l2TYJXjOLRUYmn0aekbrunG0PUalB0cUWojpGHKtXQCaw8kUoXgipBfKkICCrbG1XPlCNui/TKEyUuYxlj/qA0CTud8T+Ec7Dq5pR8VeNIc1yfCM3te+iyTe9r6diAynnTYp/kMGlqfao+orx7zkT+mH+sn4+29qfpQPABKcMY3YdwZA3g4LXJX3Y/kCwqgEStxQWtDTrzzxSQPNzYCmM5tqwzr1O5LRWB3Pxthr/gyAcVES091yxpl1atYYm0QDw47H+ATp62ScN28TPkxAHGC9b593/qrCyw1wtn94ehsIfT78YkeALAZuatT4lB7f9Mj063tjXEonVCZ29Q/kYSbOGpw2YaUe9vYI/6mJMQMEu0OYOD9v3Z+JChoe+jqNbFIF+ZpfhKsbtJe1bt64QLOlruBOnPvngXqOfb0OaanaDu6W8a3UAQRdo8T4ANvgtLaSlGUMo1fx88pkrzWi6QXUG+PBAqiyTZ4TIu13h5nGHK8CdIbLnX2MuobUOIibWM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n9Vo/EO+BVqP/kVeScw2uD14/nEdP+jB81uY9uOV4ejhP+H39TutcTR7dfoX?=
 =?us-ascii?Q?SBd/WWpAGKwnwFZoQESGw4TeyT4xXCUGUgKPvNgSDfyW5X4dwKYB9BuhP9KU?=
 =?us-ascii?Q?1FtO1PfoFkmlRtDCGTZLLziBGtXcnMccgCCqJrRjNY+OKQnFddEiTwra+Wdw?=
 =?us-ascii?Q?X+1nvndUmlcOM6COMvFHvjumHniAfs22GgNw8xUPvDrB/WdjYX8tohJydkYs?=
 =?us-ascii?Q?68gFz2ayrqoohBKZLfq8da9Y4BIX7/u0hAM5qDGbCV/9QHIyo8pygu9x7+gk?=
 =?us-ascii?Q?E2QmBScmVuZpzWtCnbgi6ANgYefBHZ71BH19aYCvbIQ0b8P170YL+7phMO2A?=
 =?us-ascii?Q?uplCRpxvw43kKnlKwREZvGW06y+4TNO2DGhYOrDbcSbF8BrsBQcel5pMZmjd?=
 =?us-ascii?Q?kKSdHQsbAjaP47FYLl6ndSc6hRyN0LVNo8tsrMCBSpp49X4Z/685tya7iwJ9?=
 =?us-ascii?Q?dNsYLcDoad5n3sOjJJj7iyF4gzQnu1U+ZdTJEeDZZWGUFuXl0lykVP4r0z+1?=
 =?us-ascii?Q?bNCGvtBET3YQPS4dc4HUcRM7oDT94JBxURpemt7CMLgjitgtYi6eP+mso/zR?=
 =?us-ascii?Q?k71AB38caYTrzCcv5KEeyLKvN0Kb034x9TaF281jqP4o+vx2JxSemBmg0h3u?=
 =?us-ascii?Q?cgeUCnNhsAxYwn1CBxvjkzQ+KKjpaU77f4pC8ii9TThQtg8Kl9matcl7hANh?=
 =?us-ascii?Q?ykV2q7s9wJqQ5xghK5sbHVOgkvtA8fEAyxj7GLKR4S2IqoUHg/NhFrKtqYeV?=
 =?us-ascii?Q?ponfMP6ZMOh3/IcIbyLFkd5S0D319+L6rSTdTKDWLWuFK6Pz5tEFOAAzZchO?=
 =?us-ascii?Q?ucSUTU/Je51YGJ6ejndwRJqDcnZ5KjQ0C18qQR+BJuJtqpJphpV4Zvl7YdsT?=
 =?us-ascii?Q?01BBviRm4C7pFrU2wiNYDRuImifx8OCZC/61kGW+HRmAA4wKT/72szeAR1TX?=
 =?us-ascii?Q?+DwYgrCYWaCyb2PhHzWkz4F0dQOAvs/54bFcuiNBqHr1p15jrfPW5QvZBGxx?=
 =?us-ascii?Q?stzenRYiimaqf9ZDQsjZ0hTT+PE16xyUsiAjVkpQ81u15zZsvLMGDJiqNmbU?=
 =?us-ascii?Q?NATc52f07puvEn1w30HUlKLjOgSHQrtCzH/Aiu2ul3/3Er/xzXZ26d6on81q?=
 =?us-ascii?Q?zAfwvOvsnl1zpZ/oMPnIPVC/iFsru2s+L2O9N511TwjlufvyLh+gC/P2J7gB?=
 =?us-ascii?Q?I9lsnHYa+M+TzuI997UrG+oHCLlyTtU++RWyhpCCbzBzZ3sfLZO60Oy0diA0?=
 =?us-ascii?Q?QilI48oj9y+Ci6lBEz/Dcud9EwcnTBp4LmdSK5F6sW5KM0xgMDSlVV21n6Gi?=
 =?us-ascii?Q?PwexOEJhH3KhIEW6QNGTxK4cmBdp8QbhQ6xtr1IfLLwYeuhU+w8Db63mwIAb?=
 =?us-ascii?Q?UgEQseBsUbgmGaJSvPbrUlAflAYKGO5hbfbBlOWvOxFuUMJncwjNf44eFc8t?=
 =?us-ascii?Q?OBEbrIG7A9SeyB1Eo06YxzOKZDKF3040GpOYA1T9gTxQUltFIXg4Shf5PvX2?=
 =?us-ascii?Q?Apgq65naOakwwc8mW60fCTeUxhOZWiAJY08mj/Ww+Ya7yRkArcY21/D1uUb4?=
 =?us-ascii?Q?MVZYZGD2Z95BCrzm1UvmyykCSGLTTOMvTkxgqLXmY2jvMKSSfm6tIsYGr1Fs?=
 =?us-ascii?Q?h0+e2bO69zFtu+1qkN/EtX+wE31IfTsp3aG/KReR/KNsbZUW34jXByq4s9hs?=
 =?us-ascii?Q?pNAaxjzBf1efl2S85pS7kQXVoJne6hVpbIgAGZX/r6H7qJWX+hX6Dze+nm0t?=
 =?us-ascii?Q?o6XGnYuW+w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3840da1e-568d-459c-af98-08df12d76be9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 03:14:14.8590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMMdFNClFSKQv7mWvfz66pOq5T72507KDO51nlJlsXaA3GQPEfb6zAXHNPtF1oNJYNdfWqjNmoNrtNqnQjT6bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834

DEFINE_RATELIMIT_STATE() uses a static raw spinlock initializer, which
requires a persistent object address for lockdep. Automatic objects must
use ratelimit_state_init().

Add ASSERT_STATIC_STORAGE() to the declaration and align the virtio tools
stub. The virtio tools use a private compiler.h, so provide the same
assertion helper and its unused attribute there as well.

Assisted-by: OpenAI Codex
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/ratelimit_types.h | 4 +++-
 tools/virtio/linux/compiler.h   | 9 +++++++++
 tools/virtio/linux/ratelimit.h  | 6 +++++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/ratelimit_types.h b/include/linux/ratelimit_types.h
index b19c4354540a..977fdfff5926 100644
--- a/include/linux/ratelimit_types.h
+++ b/include/linux/ratelimit_types.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_RATELIMIT_TYPES_H
 #define _LINUX_RATELIMIT_TYPES_H
 
+#include <linux/compiler.h>
 #include <linux/bits.h>
 #include <linux/param.h>
 #include <linux/spinlock_types_raw.h>
@@ -40,7 +41,8 @@ struct ratelimit_state {
 #define DEFINE_RATELIMIT_STATE(name, interval_init, burst_init)		\
 									\
 	struct ratelimit_state name =					\
-		RATELIMIT_STATE_INIT(name, interval_init, burst_init)	\
+		RATELIMIT_STATE_INIT(name, interval_init, burst_init);	\
+	ASSERT_STATIC_STORAGE(name)
 
 extern int ___ratelimit(struct ratelimit_state *rs, const char *func);
 #define __ratelimit(state) ___ratelimit(state, __func__)
diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
index 0f25db473f55..3c1eca4a4380 100644
--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -15,6 +15,15 @@
 
 #define __aligned(x) __attribute((__aligned__(x)))
 
+#ifndef __always_unused
+#define __always_unused __attribute__((__unused__))
+#endif
+
+/* Enforce static storage duration. */
+#define ASSERT_STATIC_STORAGE(name) \
+	static typeof(name) * const __always_unused \
+		name##_storage_check = &(name)
+
 /**
  * data_race - mark an expression as containing intentional data races
  *
diff --git a/tools/virtio/linux/ratelimit.h b/tools/virtio/linux/ratelimit.h
index dcce1725f90d..c15c82a5ca21 100644
--- a/tools/virtio/linux/ratelimit.h
+++ b/tools/virtio/linux/ratelimit.h
@@ -1,4 +1,8 @@
-#define DEFINE_RATELIMIT_STATE(name, interval_init, burst_init)	int name = 0
+#include <linux/compiler.h>
+
+#define DEFINE_RATELIMIT_STATE(name, interval_init, burst_init) \
+	int name = 0;						\
+	ASSERT_STATIC_STORAGE(name)
 
 #define __ratelimit(x) (*(x))
 
-- 
2.53.0


