Return-Path: <linuxppc-dev+bounces-27287-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CBAC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 03:15:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkRvV4QR3z3bhH;
	Tue, 15 Sep 2026 13:14:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789442070;
	cv=pass; b=GkgZ6r8mnNG38dtjzzApXxLNsJVG99DzJ0vSPtF87OECSWmT6rSi9bO6eR9B44KkD4XK/epcZe6Icb1wtdwx04f9ofikmrflWC/P7XnDCwwYGH8C6nJFNT9W+H6ql6P7YY0SK7CMD1OjZVGe0H+kF1xknAlsZhicZDQhkUtMRLnE2XSeVXPeL6ui+1/Sgn40ECsRciuiifINktIBpibLwW0E3EN0M3gP7UENW7hFg8M12V5M3ltT481ap5R7TfWu90ykGevMGPCeJ6u5stbRLWs6WeXVPX7+6yKj0/6lk1Rlxhy+n6ql6rs8vTx1ayg4aNhLWnYYn+ytf/AWMp/KlQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789442070; c=relaxed/relaxed;
	bh=d21zpOGUrU2aWSmby/wjZqj3sY8qY/SZrAPyealnRrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YHwwMGtQUsSPikx1vo5twrd1vLCmxugZpjYdT8i8OXD1V8bysxfPF3RNca2uXeaz5rMxMcRpxtmF7izMJ8yNZTx5MhnT1oJ1D7G5+HHlaq1sUbxLK9GJtn11J/auh8NIbgTXyQ59CFjvk27RbcVWTMeNfzhtF43r53DAZPtpoDEEcxsP8gQxMkb8yJy+cwhnmQRg+rzy5Q2tHUKSED7j/b97ixkTj4ovttk0wG05/humJblnrSdSJrDXrNj/SqhwbnDiHRWPgV9eT3DLuO4Vtu0CsNLm5D94+4b0+sxjGodOwSL8ZEYwcvZubMTbdhXfgTans/EtJSjYZ0mFQuO6aA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UoyOnn1k; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UoyOnn1k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkRvT5tjwz3bfF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 13:14:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8GBFJWzqZbh3G8ZmznVOvxhTqI54FYSa3JhoEChoY/8QOy0ifnpM9JsNlyYgX3JG5oZePWJogviPLlgkhtKDj8/xtlRh05/P7D0VSR3/LfeALx4412i30yi+G8Fjv8eizJtlbAKXafN61FqD3l+82UwYC0N0RsjFyo20uYo1df1QC9Kh7w4lIr4qvPTLsjB6ds0dml8V/H8NpMKPAjd7PTf+JQERD40xG3DytjNhxudHmlJtUiaqlUOtxz/dn7LSVfqCPEY/iRv7BfgGx5loK7YttobnjCBtU9BMLk2MQfm0EbB8OfTIUGZhHeghSDFlV6i+ztcz57RXIuHx3qdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d21zpOGUrU2aWSmby/wjZqj3sY8qY/SZrAPyealnRrU=;
 b=ESg/3LMYRzoGxLo/Sv6+sXipQy17h49L0YUhLeM4f5gqFDc02op6x75FWZDjFHN+o8BRZ/rbcIuRXpes0GLSFjDvuoMYASFClbdFxHdKGabPbADddhxDlhDyQFmeH95CsQKzrIyQxQD4HGne4Co119aRbkDm6VEXvUFe8sv3H9e9a+Miot8fHUhDnRxakK/wUgszUNDKLELkRWD020rS/P5LywvE9quEynfALshvYTX7XbOcyzkdwuFlsJV5kcV/kRD+X6haUnY2SKzSQZxg/NPlYwEUOPSWSrC76c0gkQgvkI4KQEkWgFpAK7Jma+W4TBhuigCw/Q092lBW2hbZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d21zpOGUrU2aWSmby/wjZqj3sY8qY/SZrAPyealnRrU=;
 b=UoyOnn1k9IJbpFKOUA35Y4MEQfKmPE6hU4H05Zp8pN+srJWHbXViVl/PJ85uN3G2eyVIqvJScfzHcTTpAZXELrkzc9xb/pVn3NIySE/GINVoT9IIq4mICCaKY/TWPrr9q1q6Kh7wByoJzukOcn3OqjrL3uFdmc7tIrLu7aqDcuZgNgUJQ8cDhpDkSI2CR/HeP+ABwjVWSviRnmU5MUKSD0xKlBVCXPET4qy2SChxdoA2mISJ+dQdCDO6JnveyxMyYOEPw7i+lIo3TI+l8mNUIY9xya8kbx3X+lsJxQm1jnmOXuzXna87zPNt+pemim7+QlIRHK11N7z2GxgqSyNnFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:14:19 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 03:14:19 +0000
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
Subject: [PATCH 15/17] notifier: assert static storage for locking notifier heads
Date: Mon, 14 Sep 2026 23:13:30 -0400
Message-ID: <20260915031334.1194975-10-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915030336.1192299-1-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0405.namprd03.prod.outlook.com
 (2603:10b6:408:111::20) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: bbdb0fa0-2b15-4b11-a194-08df12d76e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	vsklTINGWUx98QjKYQrTuyrIrhWZQnyQ3oacWKlnguqmG8TAEZt1yA5ynEsFSuhg7DEOuewV1UmrODm6a+mDS4xYzOgP+EXTgtzg/Y7ZcQ9Y1fLJ0IYr7DwWD/tbOSWzsnxx++dBs2vx8lL5eRCbafagDVjzTmEJpObd5DhRCnETgg1N/YiIxcMSvpUUiH+qEegggAc0RcIG2McqG5dkw1AWGP8kMsNVMoyKB+XkzrP+SItFLD1mVyLDmRdOWHUlcozBu4xmy9GzWWSwrECM2VtiDVTnhkAe0brWG0phcZfFnKwIGQHH9+kQkf8TMj8HXp0klNpO8ipsq7UN/9lD7yBg4tJUNBSNxrJAr8YeKVjFQyYiAs59ukLDTVCPwZ70QN+Gp3wLE6LJ0+R1mqPvYbSp31ga6orccEAhLmh8DWzeg/+f/KPGrjXqg8ftaehuPcE/BWZ1qdkSnwh6cghfZCMMO97eTg4p2BZ1U6mz5CUNRRTorLGPvJUn/IfxFsG5H5lVjfx38G10LKmyeX0dtk+pleUKLtUgBlkC2cqMHGlPdAvRyzDlVsA3hqsq1eyW8Ur1AtecJPTzxg6umd/JJy0aolAm+S2Zq9R4MfIfpBJDNJ0lsm1mLmWuYmgb8RUNE4yTTKyizWX/0bmFxC0b7xQfvk0n0PwigH/3pp6MKlQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EMWJvL6DT/5TxfzNea1jul5h4FFFPz04JR68vEGXoicXXuOOXUL4j3OLYFIn?=
 =?us-ascii?Q?2HeDeK2wbv2F0yQQw+TJX3DMTYv8QxmAT5wBL6FBLbj/d8wSXddzDBhfIPHx?=
 =?us-ascii?Q?1CO1MPNpWm8hVF3QRyfQovSJnMgsjWQ/OzidVktatEq8WbIHLkG8+qc3Htl1?=
 =?us-ascii?Q?mAqqJ1S4Pp8sP+kvxIrAeQv5V/sDHSKSTCOtT0W3/f6YXwYQYT3gUDMFXie4?=
 =?us-ascii?Q?Cc6gxAivq/F7ZQGjmVfhbc1zLLvV30+Kb8kslqMxlyZqbfjKyMYJB0FWbVr9?=
 =?us-ascii?Q?smcJxsfXf7QA7l0LeujbiVYZYyrFX9gxqHZphPk6Q1gKQXUm+cPgdjymU2Ev?=
 =?us-ascii?Q?0bfdXQRx/pfM8M3umyDfHiBE/KCPA/EjAnplA3WL1G7rrqwE/FAACI3qA0kv?=
 =?us-ascii?Q?x0cPuebYoireGhx8AgqYRfU1Vat909F0/rHSZKE74wYYwwWjqikDQDHWrZAk?=
 =?us-ascii?Q?Xxgp0nRm4TKTbEv6iHSKaivhO4SscDJ22kMmP2jNTzZQrxUyvkbqofl+y2lB?=
 =?us-ascii?Q?U4rttt3Irh3BMJwcj8F7OoEsODLYPrmcv31jZObNhrxPaskZ4+Q61R1LgZ3d?=
 =?us-ascii?Q?c6OXnABviOsdI7fvYPcexIu2mcECJ+89A7OHazkFxA24XmrER+jc2Lq8vVNh?=
 =?us-ascii?Q?DR55UHD2RUGsljeI3n9soSWLIsXqe5kBsxwMZ0mk+nDCMf1ogOaCNU1scRma?=
 =?us-ascii?Q?dGCpDnF0q/btNewCoBLiOb1m+BRrOzb+O/u6IgKmPtIdPQRynH1hP2MQ1UWo?=
 =?us-ascii?Q?CrHP8GpKAxN2MmeNHc9kQGw7Y3zGrAHhrF+aWSJQqNnkzrlTb3Oa28dbp3W3?=
 =?us-ascii?Q?4kvAo+QTLWQ0khy9vgqCq6dPxbB7FP6EjEO7Qhc4BlpIpOvoHBj2WWKnYd4M?=
 =?us-ascii?Q?K8QWBBr+jTy8+F75DGmHivjqC7ceRXsLCVCmwMkSYvZ3qnwhZrHeSSbnVjqa?=
 =?us-ascii?Q?L72Hph7D84ZPRJE/l8TntDIEXWFz8ba8WHYWJ6UtcdnZ7EnetYsRjeY62Dd6?=
 =?us-ascii?Q?yz1KTD03F/Sa1CK6ZJ0NW9dyBIwzXq/oABp2Yh96bGBCgn9QXi8qjQsdGUxa?=
 =?us-ascii?Q?JgzKbuDtMNb/kcxTyntA78bji772Q+4YKzDKq9Et+Vzfq2yS8VP1uqw4t0ok?=
 =?us-ascii?Q?mFzIISQ/C9Bl+hSfOo5WxLm2/6h5igLkv585Wo3BtRt/Tysqtolcr4ZJPgs/?=
 =?us-ascii?Q?r3jkmeGG0xFTvErvozBhXRDCD5b0KbwyoDMhPSvBP50C6C6UR+utkiGbr84w?=
 =?us-ascii?Q?A0LBhudRp1eaPbvptHod5fbKgTerc2ENFoeE3s2g+G5FaEC/aLZlgfcKX5TG?=
 =?us-ascii?Q?Yb0cnZzkdM58GWl6eQQjNzsbIyU2Y8W6J0q+etfDAI4+w2BJTzPUl27kQ0er?=
 =?us-ascii?Q?OrWY36uyGvB2JYrS4BEcUfCoo3qTmKMjPXD4ANMOBJDbjRoUvPIEuInsftfS?=
 =?us-ascii?Q?mAsvz9Sc9KbMOW3/v2zk7DFvidO1/LULxgL45BZsf9nuIyu5n/cosYFUJdUK?=
 =?us-ascii?Q?+ld8oSkj0RB3KHHPwquSzq7Loo1T9yg8eC2DU4ZKI6jQNZ1irxs7OX3wn4gz?=
 =?us-ascii?Q?mBwpr+1DloxsLjE7U3F+Nq+7wFmoilao5G85lmlB1Y4MRUiqI/ok89agWrIp?=
 =?us-ascii?Q?UK0kQbKGDPvMimH7cXwXzwg7H7hE2rN9ekVwD5tPICUSm1Nl2F5FOCLQlyTZ?=
 =?us-ascii?Q?5XZLZ+/rmkJV31wNopF6OpVCz9cFhapd28cvYAzg1F+MjLKY12xEKQmX84fk?=
 =?us-ascii?Q?BVEFXeH1UQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdb0fa0-2b15-4b11-a194-08df12d76e8b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 03:14:19.2958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDz6ibqVKeDJ1y/byhZ3J2uE0A/3iibvc3cIqAbR00mDDIQcxy2IAFzHJfnh4KXssh3W3kzm7QMnfOzHZ/Os2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834

Atomic, blocking and SRCU notifier head declarations statically initialize
locks or SRCU state that require persistent lockdep class keys.

Apply ASSERT_STATIC_STORAGE() to ATOMIC_NOTIFIER_HEAD(),
BLOCKING_NOTIFIER_HEAD() and the common _SRCU_NOTIFIER_HEAD() wrapper,
including both Tree SRCU and Tiny SRCU variants. Leave RAW_NOTIFIER_HEAD()
unchanged because it has no such initialization requirement.

Assisted-by: OpenAI Codex
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/notifier.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 01b6c9d9956f..4f6330360df2 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -10,6 +10,7 @@
  
 #ifndef _LINUX_NOTIFIER_H
 #define _LINUX_NOTIFIER_H
+#include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
@@ -114,10 +115,12 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 
 #define ATOMIC_NOTIFIER_HEAD(name)				\
 	struct atomic_notifier_head name =			\
-		ATOMIC_NOTIFIER_INIT(name)
+		ATOMIC_NOTIFIER_INIT(name);			\
+	ASSERT_STATIC_STORAGE(name)
 #define BLOCKING_NOTIFIER_HEAD(name)				\
 	struct blocking_notifier_head name =			\
-		BLOCKING_NOTIFIER_INIT(name)
+		BLOCKING_NOTIFIER_INIT(name);			\
+	ASSERT_STATIC_STORAGE(name)
 #define RAW_NOTIFIER_HEAD(name)					\
 	struct raw_notifier_head name =				\
 		RAW_NOTIFIER_INIT(name)
@@ -126,12 +129,14 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 #define _SRCU_NOTIFIER_HEAD(name, mod)				\
 	static DEFINE_PER_CPU(struct srcu_data, name##_head_srcu_data); \
 	mod struct srcu_notifier_head name =			\
-			SRCU_NOTIFIER_INIT(name, name##_head_srcu_data)
+			SRCU_NOTIFIER_INIT(name, name##_head_srcu_data);	\
+	ASSERT_STATIC_STORAGE(name)
 
 #else
 #define _SRCU_NOTIFIER_HEAD(name, mod)				\
 	mod struct srcu_notifier_head name =			\
-			SRCU_NOTIFIER_INIT(name, name)
+			SRCU_NOTIFIER_INIT(name, name);		\
+	ASSERT_STATIC_STORAGE(name)
 
 #endif
 
-- 
2.53.0


