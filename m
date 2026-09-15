Return-Path: <linuxppc-dev+bounces-27272-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D4DC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 03:04:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkRgk6dwXz2yFW;
	Tue, 15 Sep 2026 13:04:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789441458;
	cv=pass; b=SEnG7snXK7oMdZ0VhdKnseRqq0tporR95T8frGheBPD7zp6be/7g4iIrKEhdrYimnIWcsTdVms3ixGlSI9gFR+uNDXcvoq6Z0zAXyRfEAFchW6dvzmuwMfXpzq85LvbcstMIhYn+xeYkFFcUTsR0cFjmeLLl3uKklhMpWY8J6a34+pMQYiOG+mHjDRHY+816AmaLEranAP+DJwDDek3wEYvyIpcNntFgQtjd+/6UVD9giAHVq5fJBG+sEh7QWj8/jQ1cVKulUcsGVEGbTa2POFLYG223jATX7/BZwTBcAOK2QTk4AKRjGQZRlyWPxx1iLvV0zfV5VuiZ7kTtDGiHQA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789441458; c=relaxed/relaxed;
	bh=I4ZEvj7XdFyu4ITXdKD6CVNsJQhdWY6NLtYLfY04LSY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JrtRoOnCyYpga9awcC2VjdW7xTUctqouYyozmAOOX4aqrHoPOUd9iwiIu6y3cVuGgDenL55WgFwd8aqx+2nYpS5xTOWqqYW0Lb3qUruBo58xDyoGqokCvA4IsG5Q4gjKjQ4R8HukvT3t7kfTuHvXz1Zpx/lTmX5An74s3+R/GNiyhMesnrpV6Nmo9jlTfZlO6YelIRTHVSZrh7obUiJIzV7tMkfBdFAlvbG87aa1cq0mQv+YS6KHYvZMX0Qyt3R6NieZ/p4CaQAYiLU4I6Y9nPxSphiunFY0Y32qMlfWApx3YxEXVc8yj+IwPQB1ZAlnPcHrWciwIhQE8o1rieo19Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=evemmQSk; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=evemmQSk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkRgh14J3z2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 13:04:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOyAOZ4LRZHRc1nJLULMavvcBjHqmr1vf/F5tHptty5bnCydBvtA3MYO4tDzps6qr7sdq1Q/2p+PGW6I99Lm9P+Mj2mWDLSBpA95Iu4fVrRFFM0KycAUu+Cb6lWDZ/xbD8AGhFoUB1JxGBFZgiPk8mT1kygU9M5t2QFh0lsL9ZyP7tcJq06keOc7ZmrBvfBiP3NqCl4a6ifmkNH9gB7Z0Qwsl3ntf2krb865TbzRWxQdko7fYPgWK3kgIbIWI2RYhKQ1XAvq9N8AcPmOt5VgXKsli7ADQmda8X+K8jkjVqZNVUgNEqgDK9WSQkNMwAacLzdM8fikMaacORswVsUtJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4ZEvj7XdFyu4ITXdKD6CVNsJQhdWY6NLtYLfY04LSY=;
 b=mQu92cHKR2zpqcGFrtg02PnJZZskNAs+T2QlUApTA29vJ5f6qZDv3E8CfGIGwSshPlh4O7dEw5i9nJk2NqMU//j7/bkqspWUVEPRLMc0y5OkeBB5dydbk3l4wkQj2j8zagZYPeFxgZeUO0RA/WUA71nbfLNtwXhNbBzZsR4nJmK4HDsbrtIxWtpqSz2U9Glk23ETnx9BVmvIkTn+uEgDlgfR3bvQcDE1BihUsgjH0duc5b/Agdw0yfyLI1aisPGrzMrKtN9ztbqj/j1WM5IPY9zZwlFmADhnvyyvv8NcsLiBBbitBMI9kdKCtPpN223HKe7/mJOxd+ZB1HAdKGdW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4ZEvj7XdFyu4ITXdKD6CVNsJQhdWY6NLtYLfY04LSY=;
 b=evemmQSk4KBUwFfLPEJ5Je9sGvmgQLEY8xBg0Zd79NAC0z4ocBnRgVUYPB/NAwUWCklO9hEGiAytSHzOSRXDLXU1G3qqlm/DMlD3ow90J7AmdbN5bVzEKzv+VRL6Lw8Cb63FzbYldRdpQqKu7/VT1jWS9U//6B0G6aKGUgtQXhPa/0lIsQaHQEzArOAUR1oS2TuHneINqH+Xslf+ggn1NvyPOI243s1JbbDiYaSUXq96NryzNao2R1YJZC8PDek/dKO3vbUqVPUnBC2Sirmpsash317bQO0lkD1GFFHSpnEHEw8zsmDocWaSxNlvkX2EyKOmMYVoZ1SCW/T0jIDnAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:03:48 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 03:03:48 +0000
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
Subject: [PATCH 00/17] Treewide: enforce static storage for object initializers
Date: Mon, 14 Sep 2026 23:03:18 -0400
Message-ID: <20260915030336.1192299-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR14CA0010.namprd14.prod.outlook.com
 (2603:10b6:408:e3::15) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: c8f0ff5e-4258-48cc-51b0-08df12d5f279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mPNn7lejcn6Sbs4IW78jh6C06SxmN64y2bcWlPUAwf1QurHDEcQDHlpJrJB15ajZ2+BU3qB2P4X2hIa8NnnQBCkdmclNMAIsyy9dc1giuGXD+j1/FnoLgrYWOXZeKpU+1Ibr2bIMkfXkCvk7yhE55QxWrVuIFZKXgkRXDncMF/WtyrvB1Ig4a216xO9detUd/qB3aa+3mhnPiF1NKRfQ+JAVW6Un4CcnIgHrcki38uIxhUyJUxhVTZJwlsrZiCR+Rl5VrfPsYQfQUTphBIzeOIyezwvtZL6Sb77OzfCr/e05fo6ixdU5mAcWWsV2aTlyqlEfWQRSvIUpvLa2MXOiczuR4LJWrwcoTBXt7wMv4rdh0oDsWwDMEI5FRQVncrkM9s/pHuKv6IVp/uoPSz1d01MBtKNTBEIfaCM4ul/HRLKxFDzCh0uaORcHJ2c/uAcrTw4udeTOgPDErfhkHlCnBm+jlaYHGlbhv/Uiomhwgwq7IY+CDOQW30u9xM3aBdJ32RmlbpNLK0IYBCy1xpVH0Npr08rGis9VnD8+OWj0g/m1qRnW1dAZ86oVkVYJrk+Yb+K/LImqQ+BIkuVoZzv9IHzr5GfVyQpWzR+OlQjuMsDa7gMQ8Xi1a8l2izmXVyZ1s5tdw+4XsgyszTvRB6xciIs1St7M/AjPJuV/XNdX1Lc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HwJ1fYGe7uXDwZ+JuHXwFv9yY1dx1/XIRgzCp/aqjzCI2Aefg+8knUYUFpZW?=
 =?us-ascii?Q?h2VyAVoPCArznKy/6cXTvtJnmGxjs3duyJTgrZa2A9dYVwj93cA66jVFK/rm?=
 =?us-ascii?Q?GOYmmrsMLd8B/UIShg88Pv5hPH43tkOaCUQoJyUyIbUjiRDgf/Vf3q8r0lbQ?=
 =?us-ascii?Q?wZH38VBN+sxpW8wsKLUnx6hWLBG/ovfJKIgq21oIM7KdybFvXxUDslRMVkaN?=
 =?us-ascii?Q?aqel38PT62Fl9SjfqsQLApNcrPRpoh3mYIIwz8eQYmTNZA41CnwRwl+n5vSi?=
 =?us-ascii?Q?A/qZuRtaTn/tIH0iqtDi0Q49Eip/+RmGjC+1EPm2YXcxas3byk07i1R0ECCT?=
 =?us-ascii?Q?9Dkf7/+1t7WTHnGeDcmyLAov+dAEKFY6lnUXGTCUUfI+qssb8gtHGIyZUywo?=
 =?us-ascii?Q?bsdrf+Nfr+fHSzQ4UBRtoTuRn+aOB/c6sWIvJpvt1MEYDpQ9RAiOJ2zMSqh+?=
 =?us-ascii?Q?fVjg6iln9SEpAuutE+ik+6kvTB4nQpusJpqRKImtq7n0qZ8gBFvi6drkraJQ?=
 =?us-ascii?Q?7oGpOyKbFB45G3jYV2HbJGpSWWdI4T3Ce76ircDYrIivf7VN1ETw2/HVrXai?=
 =?us-ascii?Q?V88a9wFCN30+gWTjZZuD8bOPzo1lE93XULgyOx5Qj/LpVk4tyg8VWt+ei9Bk?=
 =?us-ascii?Q?0H5PN675rqdILgCWFuF0u8zyfrhP87h3mOTFGRSSrDf6bAHxfss5/YPbeLBX?=
 =?us-ascii?Q?GmKBA7+dz9x7d0dFir+ZsVjsiRYdK6oMJtQUQBsQglZiH6LLmMr0ZClV6qFZ?=
 =?us-ascii?Q?A5szXvlHeU3j5b98dpx1pY0t4hYq4oVv168n9IeWAYl6cwyj2Mw/sI6BDohF?=
 =?us-ascii?Q?M7mpgqkE2hooIQM6wVGmctqKF+pks929QAwIMILQn7GQjs1H05/nJzHcIoa1?=
 =?us-ascii?Q?9lcFp/5RKZm8JYpgXH9yq73PLKWxNH41UmQH9hZlR0bVuuaGoOkUkrFCwZlh?=
 =?us-ascii?Q?YHRmaB9Sc4VcKsqc9iIohsUlnWS5xXikASRE9k+p834X0283nUz2etCem/Cu?=
 =?us-ascii?Q?cLu2el5aht4nTs/VgMV7jIuNG+hCPinzaU82rUfCUfN2umVOs2ET7HyMiNoB?=
 =?us-ascii?Q?nJzinW/3elNQ3/OZ0hsqywtGAbZeW9Mnj/chTFZXUPe2v9mvCQcAHMq52y28?=
 =?us-ascii?Q?i7Ut/lBiy+OEFblWpvG7h5TQDZShuuOSMPMcsmjxNmEJ/fC2d2HNsYgIcurO?=
 =?us-ascii?Q?mya7Zas3b71kIUWxqjZ2q8WCerz+2Lo7/i+sQiKSA8CKB4pgZhPerVjy2mn3?=
 =?us-ascii?Q?o4s6fzYzA2oXPy1VA4PpwCnYN6RuOrj+0izW1lggLxCsXt+clx25BH1ya0st?=
 =?us-ascii?Q?Ls2M2X+CwYPGeHF8fzfyryvMwqmdQrb4U6H/zBX3jaAKxM0TBCi3jpsruJqQ?=
 =?us-ascii?Q?xXhqaLhcmEWv/ldQ1gxU+g6l8KBEXWI2iUx7WFJUn2W7O7FryFP0hCvEl/xf?=
 =?us-ascii?Q?viyKpFkAhujsqDDtnk7fsTJcKaKbh8tsngLDuoXCX4RvPtYvQV14DvwnTjMj?=
 =?us-ascii?Q?TjF2/dq0gOHInU/c1Sgb0YfePcrevI2XzIfnZNVA6OOFlv4Ys+R/f1KBw+aN?=
 =?us-ascii?Q?HKnWHEkAN3swhbVgkUjG1wLtDb8Hp5sF4bEmSX0XFSA8N73ObaqdQyDAg6qy?=
 =?us-ascii?Q?PVxAjUST7elBHJTWDF/wz7kF5NKoDQR2tRVNOPt/UD22eRKwD/UW3CUx0qTV?=
 =?us-ascii?Q?cwOOUVrh++sNMfddTU98pNNNIOYHbVCGoEIio1sQv9ALg0gKSQ12mYlQ4XpY?=
 =?us-ascii?Q?Z9pjVMa1Qg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f0ff5e-4258-48cc-51b0-08df12d5f279
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 03:03:48.2413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Xt1b8oWq4hwqnRi+rV+SwJUEErefSNaOy0RVFSoNEKMX1X2tfCb2pn+OQXoRo7OLmAREb6l/8RFzSSBpjy6qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008

On top of [1].

Declaration macros that statically initialize embedded locks require static
storage when lockdep is enabled. Automatic objects must use runtime
initialization so lockdep receives a persistent class key.

For automatic local objects, lockdep cannot use the lock address as a persistent
class key and reports "INFO: trying to register non-static key" before disabling
itself.

Series [1] introduces an ASSERT_STATIC_STORAGE() macro to enforce static
duration of an object, and applies it for DEFINE_IDA() and DEFINE_MTREE().

This series applies the same mechanism for the other structures of that
sort found by Codex.

Link: https://lore.kernel.org/all/20260911221444.1523311-1-ynorov@nvidia.com/ [1]

--

[1] also describes the preferred route(s) for the material. According to
Andrew's (and mine) preferences, sending everything together in the hope
that the relevant maintainers would ack the corresponding patches or
simply take them in their trees.

Yury Norov (17):
  locking/mutex: assert static storage for DEFINE_MUTEX()
  locking/rtmutex: assert static storage for DEFINE_RT_MUTEX()
  locking/rwsem: assert static storage for semaphore definitions
  locking/semaphore: assert static storage for DEFINE_SEMAPHORE()
  locking/seqlock: assert static storage for DEFINE_SEQLOCK()
  sched: assert static storage for wait queue and completion
    declarations
  xarray: assert static storage for DEFINE_XARRAY_FLAGS()
  idr: enforce the static-storage contract of DEFINE_IDR()
  radix-tree: require static storage for RADIX_TREE()
  klist: assert static storage for DEFINE_KLIST()
  workqueue: assert static storage for work declarations
  timers: assert static storage for DEFINE_TIMER()
  kthread: assert static storage for delayed work declarations
  ratelimit: assert static storage for DEFINE_RATELIMIT_STATE()
  notifier: assert static storage for locking notifier heads
  rcu: assert static storage for RCU sync and SRCU definitions
  sysctl: assert static storage for DEFINE_CTL_TABLE_POLL()

 drivers/macintosh/ams/ams-pmu.c              |  4 +--
 drivers/net/wireguard/selftest/allowedips.c  |  4 +--
 include/linux/completion.h                   | 10 +++++--
 include/linux/idr.h                          |  4 ++-
 include/linux/klist.h                        |  4 ++-
 include/linux/kthread.h                      |  4 ++-
 include/linux/mutex.h                        |  7 +++--
 include/linux/notifier.h                     | 13 ++++++---
 include/linux/percpu-rwsem.h                 |  4 ++-
 include/linux/radix-tree.h                   |  4 ++-
 include/linux/ratelimit_types.h              |  4 ++-
 include/linux/rcu_sync.h                     |  4 ++-
 include/linux/rtmutex.h                      |  3 +-
 include/linux/rwsem.h                        |  7 +++--
 include/linux/semaphore.h                    |  4 ++-
 include/linux/seqlock.h                      |  3 +-
 include/linux/srcutiny.h                     |  4 ++-
 include/linux/srcutree.h                     |  7 +++--
 include/linux/swait.h                        |  6 ++--
 include/linux/sysctl.h                       |  4 ++-
 include/linux/timer.h                        |  4 ++-
 include/linux/wait.h                         |  7 +++--
 include/linux/workqueue.h                    | 10 +++++--
 include/linux/xarray.h                       |  3 +-
 tools/testing/memblock/linux/mutex.h         |  8 ++++--
 tools/testing/radix-tree/benchmark.c         |  4 ++-
 tools/testing/radix-tree/idr-test.c          | 29 ++++++++++++++------
 tools/testing/radix-tree/iteration_check_2.c |  4 ++-
 tools/testing/radix-tree/main.c              | 16 ++++++++---
 tools/testing/radix-tree/regression3.c       |  4 ++-
 tools/testing/radix-tree/tag_check.c         | 28 ++++++++++++++-----
 tools/testing/vma/include/dup.h              |  5 +++-
 tools/virtio/linux/compiler.h                |  9 ++++++
 tools/virtio/linux/ratelimit.h               |  6 +++-
 34 files changed, 176 insertions(+), 65 deletions(-)

-- 
2.53.0


