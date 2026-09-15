Return-Path: <linuxppc-dev+bounces-27284-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B3AC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 03:14:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkRvL4n1cz3bRp;
	Tue, 15 Sep 2026 13:14:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789442062;
	cv=pass; b=hbFQcymvTj56x3DTye6Ziz1DlV7PeiWjbVndQWHklIRx62mfKnCyR0qFUdJsjo716cqpZAEjofQDbPcoAgVPZx+jy7m13cv/GkgsjnUt16IBeTBpnZPFr68JC86NqjYmLhZWrfJ7TyIMdTxd9QKUzM9lrTxrbThkLqLKBAYLMWfeNctTvfteJh/kttLsk9JFjSHV4Qif1OufkmU4BIQczMTmVpliDHTmIwC0+oxoAKWRtV9xGa+D+AMrR5QIdsSdzfjmHMuRaGiaqPsAVe9iYqssbW/aRHx2chOBdeAZDg8Ub8YjAOnJ9tUVTch9QdvbkD3sG1qaAUhRlrA3RaL1AQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789442062; c=relaxed/relaxed;
	bh=WPtKB+7W8H5sbo1OJJU8Q/XHvp2ScvI344FmSp2GBeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CithmM5OTErAW+aWI5owoK2sljKfdd8Ig4pNkwHWAsqfBR0LRHIFnzcFAteo/z+LbNdEGpOlpopNm6n7T3+YACwJcRjzWDCcW6k9VicYXMyUFUoJ+D0YSUZKbOF1seytWYGJl/u0AnElN12qmmNr86KMlSn+OSBX69RlSFGe97j/ybBaCuiqFsgUSSKi5wpFXum+zaOagOTLxwCoEa8IPaCQU/nkNeViQiD5jlAV3l1RsBmipkMeakP4CLdhf3jKHfnJrje5DWMVPvQanN6Rb1iCFVGTsHJBo5kHZMdHDuLQC1Ryifbm519JV3sKVuKeJXRtWuSTIUA7fTgFGobUdA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=M5xNzmrm; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=M5xNzmrm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkRvL045Dz30gY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 13:14:21 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfQnZh2w0TSCRguPDIA15cnsx9FIlkmO+YjxRa9PNbvXFUe/swXfd1pV+g/hgjrfvyC8fIeokMvnJQ+kBUOYPL9939Mj2NqkTILxXqVBhutjj10vRhuPa2WfDNnj9JS1ndY2G2pIhrvilLTziI6ljALNPTDXQkD10g0JPxndniN7l36f/tvCVN23uWZvn2O/j05EsqO3slD14otI7KpzLqqr0AWwIUGrDv7Pb6enPR/UbxnTxw7tFtxmC4GH5+iJMM/LZdfIEnO3Du4uNCd0nPd1vv3z1EI5N7lCyBPsuOMUebb3MSKiUgMxMRbz/SJxZBJIfokJmehtFYvVOae+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPtKB+7W8H5sbo1OJJU8Q/XHvp2ScvI344FmSp2GBeE=;
 b=KaFvaNsWwy/LI8uK8e9tIHhFrH5bezOMwV0X3e+css0Da/i15WG1RaELRYFI1gGXCuN9zsgdqTaB5vJcQZLLAJJRBom0mh0P2CX2F68CP7/Q4hviIXTdhkdV1CbE+I14yjtTTufpTCdHJYdUwn5vToOJWE/eIDCeznSK4u7DKztJfpVkkFv9hmH14yJqrD0qEL6AUe9Wd54Nqm6VZyAz3DQbchFPFdSpPvBT8belntrWSkF31KGGDFSuBJdoHTpaocKdZ3P1CNdevxs2hct5LPAHrRLU5GUgugvL4VqRzt5SQK1+ZRg4lhVrvGiQ/vvBErHyWgHmoO3OEOwBL2Agsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPtKB+7W8H5sbo1OJJU8Q/XHvp2ScvI344FmSp2GBeE=;
 b=M5xNzmrmgloewumcK1FE3nD6Ig0JMXQU74hTmwKaQgjM92IClsnvqIRH6e/6NXM3nkw9IrXDbcV6M5gMb6zsJiTIXcW3xFeduq7VyzaYRztOhgn/k3lG/9OC+8MnVsKO6gRfijunJlW+RRLdrGWvSh9t1KknWE6NQN7KAVBDd8/XBZ2ZrKygEr8vAxalOHxBPYiMJJV2bmH3WNQvBLPcB06IL2ri6feYYvJ9dwo/YybIrCiiv3fHx1dttsc4yjBc+CG+V/+PsGVnbp5MK7IbTpBn409dY4bTtC/2isE7c2Y2lAfVDB+GjhvnzUTBn9b3QG07DV1lwLirLX3wa6+bfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:14:09 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 03:14:09 +0000
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
Subject: [PATCH 13/17] kthread: assert static storage for delayed work declarations
Date: Mon, 14 Sep 2026 23:13:28 -0400
Message-ID: <20260915031334.1194975-8-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915030336.1192299-1-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:408:ea::19) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 6508625d-a28e-451b-5dda-08df12d76891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xNZCZ05CokS+06mssy+aROA0AxcZ2+USI1Vh751SSSRqmtoxbQyrA9xeblHZb467e4W7Aa9VGZlPbmc7pYDhkmduzriFIIpt10A2og7kPJ/lVdaFYKYtQh4YKySQy0/k5gQ6FWYUQmiy23G3rJdqM8RiuBeSNw0AU+7WzF3syn4GLyWDr38oNRHSm536q8x3OAlMLSREmIUhu1PRcJI7IAG5AZRknPJ3hoYUWJxt20CB/6AJzd/HJRFJda0yo5L5/SOY8ZYrdA2oTrgAZsgSlavjY2dGwe9WDCoRfYESjECDXN/g01188CuQnD8Nz4diGJU3qMHY/JrOdeRcxpTA6WjKVK7OLqu9HfoRFxA3XjoGiWqNR4PdGL62hyHbopb7wjW4gA8O7t9+Aijc2BBpd9yIeN5tBf4c9P64R6rPCEcvfa5U2Jx/C7gV0ul6aybAWP8GIkfzXiyhLRe/r6pS5AmDrc0c9kW7zGsKBjyoJfOsFrlyQCFDp2WQMYejhA4MuNTJucS1OTRef9evPUuyq+mTgqVvSOwIAmAShO0vLzjuQs/rk8nYibnrIFrGHGGAM8df2TGCTBPxl4CAY2He8q/EBDzFMTzEZoAfJoPnishBGjtZb3/gQdo4myeWNKggqDcNffMah74FlNJyWQk/wYrfJjTyLSz4ifq05PzbAmw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1sqw7mA0H9+x/FUni6VumJbZUMCTk9yPjUzH4PO0BH6oicEfAkgFjfF8I7C6?=
 =?us-ascii?Q?AKxphRUh9YXSSzopj3bSPsEHKewAgUZzzxrSk+6iTGhLZU+AaCIeVvh7SUpp?=
 =?us-ascii?Q?vAwTi11QfiIfhbiJnWLPuMDwQzdUVN0XjgVd1POH/0Spu7jCDnsJM0fWA0JP?=
 =?us-ascii?Q?hJBA4DRIgA7g3+4IIgcYK2RRdBjWFSIOWSFsRTfM1FAY/WjVJ9WwZ+rbgKOr?=
 =?us-ascii?Q?jg3VSUAGcfysdH/GF6BxJgQHjyiqkjXI1A3z2cU+QVj0fsGS3XOup2207m37?=
 =?us-ascii?Q?is2DQ22Q4ne0FB+nviLq6ogBKCiJlxijSLi7T8UAfZyn2LxoP8MV9KG0CRuv?=
 =?us-ascii?Q?M+qoNWWuEW7/Pw89oBL97vy4Fh+f6gA38qwwo6SdOvZjmmcHLZdPhzBYjCyS?=
 =?us-ascii?Q?m8G/3kNrki07PFACKM4qGdZ11jW0Vsd3ENPYRzO+ncNqsrT7goQsKkdv0zNu?=
 =?us-ascii?Q?YNpiVjrjAErsZnEe8pFV3OYQZtbrqje9NCkS2YB6aETEPdth09h5bxOZz53g?=
 =?us-ascii?Q?S0ZDpsiAV/4SP+ch/G80byCuyTv4EozKciAbvqg0fm8elf1r/nRwnzh5vvlQ?=
 =?us-ascii?Q?wv6bi4yR1oB9SF6zi3ZLayc6ACxzq+L7z2vduIx6Vi6z+eu3/15vkP2onMPs?=
 =?us-ascii?Q?a9pUmQmHklt+2WNndE6CSVyLQKTCDRKVJhAeWRcGRtlczaRFmskYRR4GXD0m?=
 =?us-ascii?Q?R/ov1VSh133/wH7Qbn4+f+Qa1lTEU2+Er+E1e2JCbMaDsewHi1G03CFmqmds?=
 =?us-ascii?Q?h2Bdoule8bcrX2XoADx/8QLiKou2yf9SHyRo1DU9yvuFjdXRRQfogf0LiuLD?=
 =?us-ascii?Q?oL9L0SEGIj/t9dO37ZW9EVGsZ8qmjSN5InpmRPcSBE/RVsnD7J7AckVI14fL?=
 =?us-ascii?Q?DnSJFMYv+WtX/z2pKJqehU8waEZifuZk07SJvsniodiccTbbummlg0r8MqcB?=
 =?us-ascii?Q?x//StbLARzuXaMfDC1ZOmvmt1hPWS77Yf1FIZ2WHjmObHMD5FKfJVGnTAoVk?=
 =?us-ascii?Q?51aIfynC87+7iZNc1K/l/J0y0WJwxO6gjRYSDus9fQzybvzhcPuklH5YY53W?=
 =?us-ascii?Q?fdOQPfdMoHUJF7Of86milQ0SicxThC9BfTi9UXInEa5PmlVG+ZlTyb8sWcnw?=
 =?us-ascii?Q?E+YwaRuchL2pCRMmiAJjEGfQDArez93wshxQNe5D3j0JuGqfF0NrGvw7SZpd?=
 =?us-ascii?Q?0e4ow7IzUhj+pNZcF+CbD7eGZVDwimyIRgr1+syRM9HaSxhfHGL7kOxbvqUY?=
 =?us-ascii?Q?UUIHWYE6q1TaqgBITRKYNmbiG6gZ9LM92zeiljVs1uU23CZMR4WW464Nj/In?=
 =?us-ascii?Q?H7c/ToXKVY3pTX8nMgbpALRwSnV2tKUph+9rwfkN7wFzatcYhLrhT9tiFRqo?=
 =?us-ascii?Q?B8CUs+LwmsDtiax4ZRug4K3h/JUnwGEZXRflgFjmqeam6mGOPZtL3Ull4LCS?=
 =?us-ascii?Q?mOxrweBwOqaof6FkVdf23/0ckoMZ8oC/T8nj+h1jg0tEdRTDb1XGkdbZxrgJ?=
 =?us-ascii?Q?nNKiitrX7nwJq0FrV+CNA5u1qcak7/fHpZ5mMlTWRduxzJCH4tV04oM4bpa8?=
 =?us-ascii?Q?ha0Z/XCHMs/F3NsdK8XX92UPkTUm0t/m8XOvRQC4R/rwhWGFkrV4ukXnhb6m?=
 =?us-ascii?Q?Xd/FtEXwwEVqCcQwgCWLZpsYtjfwMI5ULvv/+XwOs7mBnXF0DLxyIFdf5TNt?=
 =?us-ascii?Q?5VNfAH/U2XZoCqel2d4DmCXxDLPXBcF2srcIO3CnRhNa2HI+Syq4gyEuX+r/?=
 =?us-ascii?Q?vH/rTUZvfg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6508625d-a28e-451b-5dda-08df12d76891
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 03:14:09.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCy+xh3J+SBrrgjrNfdGr5WrczFFXG5LADoiYcPngw6CSlcsE8/1l58PH26NSQVr2cAyiy2Y4+qTTOJ4jPkTSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834

DEFINE_KTHREAD_DELAYED_WORK() embeds a statically initialized timer.
Using the declaration for an automatic object violates the timer's
debugobjects storage contract.

Add ASSERT_STATIC_STORAGE() to reject such declarations. Plain
DEFINE_KTHREAD_WORK() has no embedded timer or static lockdep map and
remains usable for automatic objects with an appropriately bounded
lifetime.

Assisted-by: OpenAI Codex
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/kthread.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index a01a474719a7..faa9dfb2f6cf 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_KTHREAD_H
 #define _LINUX_KTHREAD_H
 /* Simple interface for creating and stopping kernel threads without mess. */
+#include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/sched.h>
 
@@ -179,7 +180,8 @@ struct kthread_delayed_work {
 
 #define DEFINE_KTHREAD_DELAYED_WORK(dwork, fn)				\
 	struct kthread_delayed_work dwork =				\
-		KTHREAD_DELAYED_WORK_INIT(dwork, fn)
+		KTHREAD_DELAYED_WORK_INIT(dwork, fn);			\
+	ASSERT_STATIC_STORAGE(dwork)
 
 extern void __kthread_init_worker(struct kthread_worker *worker,
 			const char *name, struct lock_class_key *key);
-- 
2.53.0


