Return-Path: <linuxppc-dev+bounces-27431-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB362C88E7F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 15:55:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkmnd0PK3z2yFW;
	Wed, 16 Sep 2026 01:55:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789487733;
	cv=pass; b=QJYuFHRI+CR28CfbCxL82l8IeUtSdmMppYVn8T5tYTN+n4mL1MQ7gnRIIyXPJ50saa0IX70PooDFPDCWMKHRk5Ntr2Is5u/O8HUt1cXVk4HoRCwQ3xREX+Yl4TPgKG7o5MSV9dDqwkXj4MUJf9nVLeTK6YMLryEh3kLjG8cpTF+/2ny5x3G3IQ43tSFQk7wzn4tiJne4ODQeEHLrq4tsueQ1NK/hrr0AIT6i/m6BS6XjoZbTPD44TtLjPGIYd0QaQWpjC4K5C4hXp6Dg6NM6PkEGlXJ+wcfmFYfUmDZWhXKWfxSnH2MjuyIogWGjXqgMNTjJYsOEBLtuZY6squkwlA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789487733; c=relaxed/relaxed;
	bh=rrbhgdYHr/koFfAicxW+BKj+Kyye7vRFWomAArY1IVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AOEUVgKTA/Ng+5V5fdOW9NVCOYkHqE8T05qOnjRYrzAVK4/IAXmi5TiRWow5e6AE0KSaWBvA05m4zdLTkanmF8wvmJbFclcink7/zUBM/4+b0C6lMmPAdEWtdEuhIyVq/OXYNWy5KiiyXhRxzNBjMGr7lCxQF+pntx9KDShVSOXrC0YQngYRsvfofr0/efF2bRC7QRYMlg70kxDRi9jTEGEJlc2NYlNXh2voDfFtVEfTm4Mpq5/NxtSAJ86PFAwkibE9hQA01KICCs2iRCa8UfVZvTqOn2PSu+jOb91E8V0khSA4nPWpmX+H35/ShUKfCSawkmJXhDjMi74SG7Xx/A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=c8JadSd9; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=c8JadSd9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkmnZ47m1z2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 01:55:30 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skMRoQGuKBSp0bexXFP19qWSZwRbrMsQtnlDl+Zu5ABa4Wnnkdgqcpy9kVm8wpO4QY2ipkzRF9p1wNVkKbSGBD0U9mxly/brLdhlVj0HkaucvVQ2ymO9XvnDubKyvcGUW75BgzREP37hQxfPXbE+2UpuIOISsugNpKx7/MrjSWxbmkF+tlxpJZ3UmCKDfZdpYqrCt4lW7THlolcVGbtPx378A1kPYBmPZHlWByjeS43CVC8Cnaz8ad5CO23zsWVQ4c8T26ybdG3urS8rNidUJTbsMA+75FyHG4Us0Iu4K+ECsbKUNEXNdq5Fny2VjTSfZyQrbIvNbP1nJa2sdqvdVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrbhgdYHr/koFfAicxW+BKj+Kyye7vRFWomAArY1IVI=;
 b=g11ZlcG5CLe6GC5vaCeIGKVTtPNbImYKRRLmmvHjl/ihmmGQ0SV8wpHxSckC+VDj7v4TkbZtQkwdMkezyfwY3GluGTNPAWzQcvl2hyKvwCykCHxT/mlFDXuC/x/sZXDNW2ktyasitWeeS3HmgyFR0TNABDq6RxUPSVKAZK7H6UHYBSgCLAtYFU0dqkN8DheFyk7thuuWBJqNJsbcBmY5bj/vnN8kRojhR9cLcXHENdif9CelpeaXjameC7rLmGbLRfO0m2xeQPNa9HyZ17WwRq0Jz0caeCPtJP/9s21IKjUiPMayjJNteCBE+yQm3rO8gWo/WbgVksqDdnzjiqvocQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrbhgdYHr/koFfAicxW+BKj+Kyye7vRFWomAArY1IVI=;
 b=c8JadSd9C/P64SWFoIQNpwdPYSNGNK4oGzNajS7VsNvwIhOR4A1TdXX+7hEDtNTImsdcStBbVmLeaIGP5F6f6jcQqaEA/coSSxDf/kTHtn+yp9kcKTDyakqra1ZhsKWxYoK1FGcKVxRmKqd9hL+jLfSaQ0raCHC+QgOBHu0+93LwEv2+XZ7vaP7s+Czn+OVzHH3mPg5+PXCmHnFmxUxF0LvIgqG/vD9kFkzNEQXdQuSb5oPSpUR28MK+d20sunMXxcophd2C/IeudDrp5VZs3FkkP8/iXMLvOWzTcBGaVU6AvtcY1MQC7NIxKZGRqax78tppCaBdwqwOGYKB1uyYNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 15:54:57 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 15:54:57 +0000
Date: Tue, 15 Sep 2026 11:54:53 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
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
Subject: Re: [PATCH 01/17] locking/mutex: assert static storage for
 DEFINE_MUTEX()
Message-ID: <aqlqTdtXWTFZTgjV@yury>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915030336.1192299-2-ynorov@nvidia.com>
 <20260915082300.GV4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915082300.GV4121339@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MN0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:52f::35) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b78c4d2-4795-4372-7ce8-08df1341b045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|22082099003|18002099003|10067099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	+1xKmSPNcTZOi7hVPCSp4OI4ynTtA7XbVfWvNgg6hfdkaVq3ifsSaAtiZsqVW9JPQ3/68X7YrhWZNrZOJ4sQC+tYm+oXk7e5F8Ezt6SBvksB81JbNjeULDyakZdXJf3AM36QHwl0oPAe6pMDNMw5lAKw3zSaFK171brEjiggTuvUUpihJYk+IDynjab9Smj5Ik7dvu3vCtmBqQnZxFOYiRcHOXhNOzCrVcwKv0IP7TEEXoBwNyJ3xNuOO0cENmh1t5jG0CADyc9wfdDGF6x74Fb/IdzSlVxfCSSCkL6+urt0kYzDKrwv1Ye4a5Pb3//TiBwLaJdFGEZEkRk1Xi3khicZJb9GKAVc9FcduOfZ2sLztdIuY7ILiIsVwfEovjKXD/bsHY2qMjRsUJ0N0kCgKzASu1WeGIFgEAntCEfnk2AzMwQrMRSb8MvWjSowPQ2rHJ60ttP9g1Afgk9Ris1uASszEyb2yrUfFrPpu3piJ8n9rlgdNjrrfXthqrcVvQRd0x/EW47BMM1Ab7tXdTz1p/Z5TWbU4jAJ6PiUi8Zn1lbS5U9YtORhBzYlcdvK1SOncc15xdAr9jCOmZAzotbr/hR8/dw4mqhx8k5IORjGrNECSGnw8WSGzu0tM+Rf7oqqa0LZlPMyyoH6qj4nt2MkzdDrBVq1m52LuRl8RHpnyLw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wW6VCbFVZOsJpB+zJCXRpwFbeoxnj/jiujotM8Cxk6MdXNAmigPYz8EhAas/?=
 =?us-ascii?Q?eNJFPa1FB7W8qCgGnh960JUCbT0aL/XwIxDMzAb+tSVpReMuWyzL8v8RcU8J?=
 =?us-ascii?Q?CAn6/4eQS0hKFZjFoLH3ObSNuRkV7egZ1Tm9D0ZGVP+W7VjhYpQyVmKdF1X9?=
 =?us-ascii?Q?EzJ6HpyPfQFsPDDu81SKGY4WJjkB+r20VY5Z51qXx+TF4v+YrU3muSkBzAHK?=
 =?us-ascii?Q?AJ+UcK6+zmHto8rQ1HlKsMnjAMt83aTlELkCGV/myG4XJgISTw2EPd6wuQ+9?=
 =?us-ascii?Q?F4PKIhLqumx3CL4aVXNdWjgrxNndHD3xDbfrChvYwWgAojYKSjcwG70K9/zq?=
 =?us-ascii?Q?7jsgUz32LZ/J5wJMl4gf/v5YsREYtOlsiiKDsXfkOdPjHEPizxpMAbWySQV3?=
 =?us-ascii?Q?VZrIYVLQ1hSWGVNna4BjU5HSm2d3n0CRYJYfPe12xUbZH4tE9Y/TfQT9rstV?=
 =?us-ascii?Q?MqcC4m054esGFiFtf5n3A4mUXAqDHr/WGEOoNuwsRf+T1I2Mc1VGRQvKgTlI?=
 =?us-ascii?Q?ty02PFHT8fVG+Y1MDjDRG1RnLqtNDsTs9pCVwGJuttWdjJATDTWr0gFbVL7f?=
 =?us-ascii?Q?WiAvnARGwOx/WkJEmFHL1tQJ1b0JfADtxrP/f7x/K3zwFOfpssjyKridqCoX?=
 =?us-ascii?Q?nDbPLlJ/3k7fzc0nPeET6IQH3wa+NiVpYW7xeTSdpV3NH+Ve62t5vxJxv9Wq?=
 =?us-ascii?Q?snVnqbbYREardWHh5jc1E7D3THUqWLvtsPgRaJ8l0wCX+xWhCEvdUv/6ergk?=
 =?us-ascii?Q?3Vvw5HTayGpdtws86uXEiGyv5bdL124vdQHMrx/fa3FgvCf8LxskXCN0or0G?=
 =?us-ascii?Q?QZTyNzdp6iSDvBSzMxaj0XFk/OKF+E1cXyI9B55M1/8oIYozh5MvKrGy1su7?=
 =?us-ascii?Q?0UV6R0UrgkyFe4s23bU8xD0BMO77u0PPx0wFwf0/OHp6MoZy5VwfX/KkHFwa?=
 =?us-ascii?Q?QbtT7AsEePWTmMQs6PXve+Cvw2D9aGWJYnEeHRFI2YnI13jQtmHo5BDDufTu?=
 =?us-ascii?Q?BOnBaXwXuHH6Ay09oxUbN7mqh5yATcprYc6r7xgF0H+2JzD6EPxZZom77+1t?=
 =?us-ascii?Q?/QGcZUP7qgUEv1JEL5n4Cpav/g/TqcMFSnXpGTKvX3VvPefEsENQ0IYT5P4Z?=
 =?us-ascii?Q?D0SjW82BumtoWzc/lRLDgKlFQrfN+J1wK8KbXWOEVwj+nCgBQ4UmpC1mcMH7?=
 =?us-ascii?Q?T5OY7nSJYe8icSlAxwjsEsUzJdTasdKqfijDycVAKM45iRPXdiGGBydBZz60?=
 =?us-ascii?Q?PQp3PPna0LhxOzzxOGdtiQ8G1SpoPNqp6mEWgoMlbsFtFAcIYR4opZb3UdBY?=
 =?us-ascii?Q?2hDzvpJuRXA1OHK5+blB/MVYljK+Abv0wLLo/1NWPixcTR3iU3+afMRFMEDm?=
 =?us-ascii?Q?G8+85OkzQjc8Kp1BXTGoFkjhFmmO1eFh3ait99PxecThRqMrpYvHXTKgBiRf?=
 =?us-ascii?Q?SO3nRufSp7VGh3lsQ0HWJx4/9lA9bh9Edc2O06lfazvthbH1w+OG+c18/2Z+?=
 =?us-ascii?Q?OCiwPH8KLI0/RGmWjV3L5RtD3OpUpnmr1Pp5VAg93GNOnhBaV+bBIF2hbS+g?=
 =?us-ascii?Q?PxSqq7/FkGUMi9BDFubD8FU7/5a3BoXTUyITJIVFnLwSZqbPxY6oXaRYE8Ka?=
 =?us-ascii?Q?JFL3tvXWUaLCUuktPSpqatj9dFAK3N4dXZvBPHY4MifINmJ/fXQAeK/D8ncN?=
 =?us-ascii?Q?IQ48xaULx0RQw5tpHrZt7H7xEsSlXxKtZdihbW63vHUmd+U+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b78c4d2-4795-4372-7ce8-08df1341b045
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 15:54:57.2874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIgZfvM6mynEoh9AVrD9FIBEuwOYiD3EOkIP3w+uHG72jGLJSPgCOjPEklO5yOmyRLcQeLARtdDyU+qY/SboYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734

On Tue, Sep 15, 2026 at 10:23:00AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 14, 2026 at 11:03:19PM -0400, Yury Norov wrote:
> > DEFINE_MUTEX() uses a static lock initializer whose lockdep class key
> > requires a persistent object address. Reject automatic local declarations
> > with ASSERT_STATIC_STORAGE(), in both the regular and PREEMPT_RT variants.
> > Align the VMA and memblock tools stubs with the kernel declaration.
> > 
> > The two automatic mutexes in the WireGuard allowedips selftests already
> > call mutex_init(). Replace their redundant static initializers with plain
> > struct mutex declarations.
> > 
> > Assisted-by: OpenAI Codex
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> >  drivers/net/wireguard/selftest/allowedips.c | 4 ++--
> >  include/linux/mutex.h                       | 7 +++++--
> >  tools/testing/memblock/linux/mutex.h        | 8 ++++++--
> >  tools/testing/vma/include/dup.h             | 5 ++++-
> >  4 files changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/wireguard/selftest/allowedips.c b/drivers/net/wireguard/selftest/allowedips.c
> > index 3e857e6fb627..ecb2908228e7 100644
> > --- a/drivers/net/wireguard/selftest/allowedips.c
> > +++ b/drivers/net/wireguard/selftest/allowedips.c
> > @@ -257,7 +257,7 @@ static __init bool randomized_test(void)
> >  	u8 ip[16], mutate_mask[16], mutated[16];
> >  	struct wg_peer **peers, *peer;
> >  	struct horrible_allowedips h;
> > -	DEFINE_MUTEX(mutex);
> > +	struct mutex mutex;
> >  	struct allowedips t;
> >  	bool ret = false;
> >  
> > @@ -499,7 +499,7 @@ bool __init wg_allowedips_selftest(void)
> >  	struct allowedips_node *iter_node;
> >  	bool success = false;
> >  	struct allowedips t;
> > -	DEFINE_MUTEX(mutex);
> > +	struct mutex mutex;
> >  	struct in6_addr ip;
> >  	size_t i = 0, count = 0;
> >  	__be64 part;
> 
> This should probably be a separate patch.
> 
> > diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> > index 734048c02f4f..2f2d95f3097c 100644
> > --- a/include/linux/mutex.h
> > +++ b/include/linux/mutex.h
> > @@ -11,6 +11,7 @@
> >  #ifndef __LINUX_MUTEX_H
> >  #define __LINUX_MUTEX_H
> >  
> > +#include <linux/compiler.h>
> >  #include <asm/current.h>
> >  #include <linux/list.h>
> >  #include <linux/spinlock_types.h>
> > @@ -84,7 +85,8 @@ do {									\
> >  		__DEP_MAP_MUTEX_INITIALIZER(lockname) }
> >  
> >  #define DEFINE_MUTEX(mutexname) \
> > -	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
> > +	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname);	\
> > +	ASSERT_STATIC_STORAGE(mutexname)
> 
> My tree no has ASSERT_STATIC_STORAGE. Please repost when that lands?

It's on top of:

https://lore.kernel.org/all/20260911221444.1523311-1-ynorov@nvidia.com/

Check the cover letter for more details.

