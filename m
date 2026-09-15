Return-Path: <linuxppc-dev+bounces-27277-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2E4C88E72
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 03:04:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkRh627n8z2yhP;
	Tue, 15 Sep 2026 13:04:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789441478;
	cv=pass; b=AeBi+Hgzezt/IP5ZPhOEzRxOnNxI/OtEJJ4acCtAON+33mJO004sCardplSAufaOw5SX5vQ/NsVXgM+a0OeRMT9BxkZaEARere3gK4vmLzGlgvvPvp0XKEoiDr1xLncTRqRtefKkJD6PQ8yS6pNfUfFDC5VWRAzi6cTni8qCtMipVh7P/vDq8g8NzoRQtPCpoWfRE8IYzX5331ELtj8H2lNKrbS+COiivG5tBpRHvuW4OEgsMmL6OfmOTyFqf/dmm1vC4pA83TnSsoWFSLC+MpNhMp4SM5xpZ7CYo+93KDkMM+iWHgfIaIkEQWOQMqGm3f8OPX7BbdW8s5itrWaVWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789441478; c=relaxed/relaxed;
	bh=0DbP9wTpu074hCEDWViXjVrnTNfXH2OLo6eyXM0GwUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gkRWwk90XoBYvTrHwHbu4SzwP3/j8qlH+SLuTGvlcoVvV779cv6IX/WA0Z18MCXZni3AL4v0s+NDlhENj6WMfgftVb+pBBirTYPexyagxIc8LSNRGddVM39dN84fsENacPc4Ei3ZoDYBAjc3MmKgCbF6QXjnIhholjSvOPWe99T8efDNXgwHByTsCUnpWjXnuMJulML4NX2ozC3kKIDKfJnoc28skTRqmPN4tRg9/rrIfYBCesJCxK/16nNLQbz+3ofTdL8muvK4h8ti2kP4+1MsfbYuzPFuI4WyNyMJdgfWZ4RPcUcaU68OV99pu+MDt7cuVQz/umAPBEIniuCM1Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MwYvzb2u; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::1; helo=ch1pr05cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MwYvzb2u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::1; helo=ch1pr05cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkRh54BCHz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 13:04:37 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqJzbZ6qISYe1SRXsUpuvCyg6PXQd2Vz/oPrKCOzwyOn3nQ3LfOcURe98LJeAkAzTPRB4TKKDbEP2eTLRnnP2mSHUsAiepHQkayNsX7joTKyPknBXhok0+TaA9l77upS0YNX0NG0WoTfokq5QHA9X4LjGYQebM4BBgEtZqOq9jdAvUfmxVXHK1uiXpphbzaSB8S8pSubZPdiEqgBtNtgUsYi76uIyiz3mjtzmEo8lQWtr5X2ygrWF9FbMELQu0pfogPpjBW8UYygdDZWukqu6SUFt7zh6ZsP1oByLbFR6CyIHBp3LwVlk6wv+k3ge1CiEFeJ6IYvTptCY8qwgIUjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DbP9wTpu074hCEDWViXjVrnTNfXH2OLo6eyXM0GwUM=;
 b=rKZK/kuDMuf2wqJbgbibXL2rqxGgY2+QqFcvuRCWKFpBuqzlW41qHW5GvnnUZdb8RJswkncHtIvQsQ17n7y541R2XPEeUrFwZZm3cbw+Cml884Y+fTs0MM/hco1DOIW8SZw3rG+rEJOZvFS3RK9EWDXRmBbR8L0TAzkFsAJ0gUa+yDJ0WDQEstqDBQxZAm1AUwqCzymh9+WCLHLKApfN5cLo5qLVt8E/QzlZxqlMeUjRqOkh+fCnJlXFgPEsC16AaDadMlW7kbopq4vcwb3nWPK/qmnVHt61xMSIpluNybWXAjdC7f3pZnJptXlNxCqav0CzD1mre4HfhDF1kEWb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DbP9wTpu074hCEDWViXjVrnTNfXH2OLo6eyXM0GwUM=;
 b=MwYvzb2uChhWvatM53Z7pgN8kZ2k7K9MFMgFkRV5gFysZ17nLOzsyQnCh7VjsG7o+IeULcZLDRLmpz40ccswV+MwDbEju0SZQNj8dn/AwQD6EOdV2YbaIYBd8PNjmzspbNRhaDnIFj4ST81CMG6Wea+XeZol+iaTDNH5Z3uL5vr0PfPULfHkGM257dUizJFl5CFQOEHWjuRS2LTNiloxkQVtF7mvW3gfeZP+lrmt29kOKJs/xMcDN+hFAAAY60Rb9zNF0XkmN5I3KxJgu6kHg8lrz6i90mvjqHALCMAziJRW6F5OlWxEGwbIlDYpY4UhoGf7eRL3K77Jm/XsBxJESg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:03:53 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 03:03:53 +0000
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
Subject: [PATCH 01/17] locking/mutex: assert static storage for DEFINE_MUTEX()
Date: Mon, 14 Sep 2026 23:03:19 -0400
Message-ID: <20260915030336.1192299-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915030336.1192299-1-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:52f::22) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f87cb82a-99c8-4e44-592d-08df12d5f93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Wey0wtmA13yGVO8omyhL1HIzen4Tm288/2OMWUNHgGbskFT7/h05R3Ods9V+uEU2RCntBj/uft4fFcJCZplPb//0kpPToA536xJcbr6jU9HKuSV+N/l3jiTYMqihWIkO/RzPcMVZjjZcH6kMFmOU+isbUkle7vj+TskZ5SvU3SJZsV67fHuGAjZuLmvfiI55k/ZpvyhyGHeBVT/xnw4/uTNE+7Oods1lcicCa7k/flGUyV4aC/6MUNqdoy+JtrtuNK5InvFTxHX27Tv/uDScN0Xe2yaGVqBgwC15ZumlslBA0bAbcpSinEeyLj+VWn19vOj/yMZ7JhqIMRcJuJlYH/ZdpCMHovnHugB2X22HIIRfBDWteN76ANhye+GWw0zp1Z6XfZ3VRaqURt1uvLERLikrgBX8HLnT4pbkkIH3KmEG/2NlKpvrskSkKMbbuY/iH6HN4L00qxqaqcxFQFaBEKWnJXfhgr8/Q+y+3bd/oSUmAbRvZH9B3TlIpRwZxOEOpreaYVarKC4fo5DMqs2jm3Mr1KeEzO8ampvI24LQKKg+bgmGIrlWK/Alqqlj09YFTZZIM80Ko66ZRqGVqlc7mIpSgiXXe7P9qAdL/fBgezDzv3FPw4DgTHS/0ktdSL8qzKE91tZff+TeA3UWlV0/q97Cb8N4QaYy81/5ARDut1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D0jYsb6nWZWGDEM3+mYL2yU3hUCAXC52fTPDKXNLOdU/QR8qr6TAXrAZewv3?=
 =?us-ascii?Q?USU3izUOfyyRUa7yrbaDZ8bOdgjULL27kTJb/iMAkIsWOwLiml6xK38GEUxx?=
 =?us-ascii?Q?UOspdRnV3YCqiFqGYTTPWVzhtmpSGxJhoinrbGO7AKUJwztpcWv2XBHgLmhb?=
 =?us-ascii?Q?4+qOrpiYkgNcuNF3yCY1KU/YIJ+iY+w0Dn6jVX2Njx3bNSLX2Rz34BdS+rnE?=
 =?us-ascii?Q?CiQxlr3rTXcmQpX8boTVbb/uwXDGQBFgfwhuHgDH8Byq3iyyLF1+X2emTfj7?=
 =?us-ascii?Q?zgl18QTC353r22I8e0Ps7mVl4Tn8RlP2UOBfsjZ0mNvKOr9kmxcNPKrDQ4oA?=
 =?us-ascii?Q?NmnsQyiHOoSlLvLktnY3i3f61pkn45zA1U33DVOxZ8pitj9W8tL7JS8Cljrs?=
 =?us-ascii?Q?IDcDrQ8RIUw1Bm5jX3ybdz7IF/f09trNro08LhsPHV6szqbR6LCujG+/VkNb?=
 =?us-ascii?Q?Hiugcnfk7WXU95O1MZz41bUr0rq7CzC0U2HLWZ+stGCvzITbWYuaJvcbDDw7?=
 =?us-ascii?Q?YThIbemMBmEg8jw3++g9DXy9GLgSQFnNOXhWQ6ccbu6hcazLx2shH+jRQnT+?=
 =?us-ascii?Q?PijHJB2RawLfnGwm1mSYumTyVozWo4SWps5vwgQ2fOehgutx9pYzScDT3O+6?=
 =?us-ascii?Q?+ycdY4y1UcX9BJBZt6hqwsQyj1jUWDkpRXPh2FBpF+i0Wf0oZLQzDiRCiz6g?=
 =?us-ascii?Q?6NEI49Dd4fap1jtjWkHOR7XHashQPQVcmunu63k4fT/i7VA39UrZeuiSIa1q?=
 =?us-ascii?Q?gjJ3L3uptzlcY+crbUp/FATizUkE22Szf3VXHazCrD89WRQvHNJg67NbyBAj?=
 =?us-ascii?Q?p0oHVXCXtNY9TiNJ1f0x2OPcGsF1gIwx/UfWK4rBnv4Ov9nmLqokIlbzWHUn?=
 =?us-ascii?Q?GsxVxlNimhs80tvVunbrQFXZvPJX8CVcz8AMC26y8ffVVABLla2us9oObvZ8?=
 =?us-ascii?Q?rspeF9OomKk1y9MtB0A5ltzGza3X+vQknDIMJr3agPvz+/OMV1LJURWE6mqP?=
 =?us-ascii?Q?gbLkz9O3pM974UTMk5pc68ACU2rwytsRSdmoWyUSF00v1OSkarEdc4Uui78R?=
 =?us-ascii?Q?wmXjseBoULmOSJrdF/1cP5+Gyp3vEmhHROQXcL5byhkm993Gqw7A4fnh4uke?=
 =?us-ascii?Q?sf4ibApjuWbtV+tcAUoxBDFqHI0lGLlSmH19Z5R8sLN+tSUcv7S2ZEWp469/?=
 =?us-ascii?Q?ufk8qisOnsQBvcLUoD2+hUty576glwHQmodX+BZzKtOcMwv7J2EE7ZIoBEPx?=
 =?us-ascii?Q?Oa6QEkOfM+cfRJZvtK4+SwVRguSSmv8UbYUO+8FNYOjGmxFPZ7vFR+xjcp0U?=
 =?us-ascii?Q?7jm0LDAqJkSqScI8LUSFIIGeLdHSvXK3huS3RbGwOutbUTwYVHUMUINdcIaw?=
 =?us-ascii?Q?ZratkrnxOGr7wFuVNQUYePFGea1+hH1g3E1N+gjXmn978HWiKXM3u0OD6AFr?=
 =?us-ascii?Q?p7GibEtKtkJ5481nspLMsAj0j8rFCMLgVJZ0oz86TdKoR83/yhqLg/h+nb6j?=
 =?us-ascii?Q?diOGuwDkYUkirDurn8/HR2xEJyUmNbkg/T997hCQM/oqQgn/SH2rMvGiUhni?=
 =?us-ascii?Q?/UU/kM4+C9EpQ3ho6UQ+gpkxkYiaKa1E4sfXBg5mqOIRiBc3QjkGsklZASWf?=
 =?us-ascii?Q?98jj6iwqhfqVDz35egnZqSuRFDSB28Ebm14kOPpZhbUT3wCaHjiW3q1rN/Jp?=
 =?us-ascii?Q?35VywzPIBRw9dgVYRt/wcZ7GtBNkHLq7/fCtQcJUsn/7JAI/7lXcVPAE+Ej9?=
 =?us-ascii?Q?mPa9A1HEzA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87cb82a-99c8-4e44-592d-08df12d5f93a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 03:03:53.0032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6scg18p9HqTXPDPtIm6pD0L570ZuG4nzDtZpAzat6xSNjvDDD3uZ84WlS9ARj9DZ7AMl39h80kFZql2VSByRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008

DEFINE_MUTEX() uses a static lock initializer whose lockdep class key
requires a persistent object address. Reject automatic local declarations
with ASSERT_STATIC_STORAGE(), in both the regular and PREEMPT_RT variants.
Align the VMA and memblock tools stubs with the kernel declaration.

The two automatic mutexes in the WireGuard allowedips selftests already
call mutex_init(). Replace their redundant static initializers with plain
struct mutex declarations.

Assisted-by: OpenAI Codex
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/wireguard/selftest/allowedips.c | 4 ++--
 include/linux/mutex.h                       | 7 +++++--
 tools/testing/memblock/linux/mutex.h        | 8 ++++++--
 tools/testing/vma/include/dup.h             | 5 ++++-
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireguard/selftest/allowedips.c b/drivers/net/wireguard/selftest/allowedips.c
index 3e857e6fb627..ecb2908228e7 100644
--- a/drivers/net/wireguard/selftest/allowedips.c
+++ b/drivers/net/wireguard/selftest/allowedips.c
@@ -257,7 +257,7 @@ static __init bool randomized_test(void)
 	u8 ip[16], mutate_mask[16], mutated[16];
 	struct wg_peer **peers, *peer;
 	struct horrible_allowedips h;
-	DEFINE_MUTEX(mutex);
+	struct mutex mutex;
 	struct allowedips t;
 	bool ret = false;
 
@@ -499,7 +499,7 @@ bool __init wg_allowedips_selftest(void)
 	struct allowedips_node *iter_node;
 	bool success = false;
 	struct allowedips t;
-	DEFINE_MUTEX(mutex);
+	struct mutex mutex;
 	struct in6_addr ip;
 	size_t i = 0, count = 0;
 	__be64 part;
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 734048c02f4f..2f2d95f3097c 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -11,6 +11,7 @@
 #ifndef __LINUX_MUTEX_H
 #define __LINUX_MUTEX_H
 
+#include <linux/compiler.h>
 #include <asm/current.h>
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
@@ -84,7 +85,8 @@ do {									\
 		__DEP_MAP_MUTEX_INITIALIZER(lockname) }
 
 #define DEFINE_MUTEX(mutexname) \
-	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
+	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname);	\
+	ASSERT_STATIC_STORAGE(mutexname)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void mutex_init_lockdep(struct mutex *lock, const char *name, struct lock_class_key *key);
@@ -124,7 +126,8 @@ extern bool mutex_is_locked(struct mutex *lock);
 }
 
 #define DEFINE_MUTEX(mutexname)						\
-	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
+	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname);	\
+	ASSERT_STATIC_STORAGE(mutexname)
 
 #define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
 
diff --git a/tools/testing/memblock/linux/mutex.h b/tools/testing/memblock/linux/mutex.h
index ae3f497165d6..d1a52d6dae80 100644
--- a/tools/testing/memblock/linux/mutex.h
+++ b/tools/testing/memblock/linux/mutex.h
@@ -2,7 +2,11 @@
 #ifndef _MUTEX_H
 #define _MUTEX_H
 
-#define DEFINE_MUTEX(name) int name
+#include <linux/compiler.h>
+
+#define DEFINE_MUTEX(name) \
+	int name;				\
+	ASSERT_STATIC_STORAGE(name)
 
 static inline void dummy_mutex_guard(int *name)
 {
@@ -11,4 +15,4 @@ static inline void dummy_mutex_guard(int *name)
 #define guard(mutex)	\
 	dummy_##mutex##_guard
 
-#endif /* _MUTEX_H */
\ No newline at end of file
+#endif /* _MUTEX_H */
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 4c58487b764e..f2cdb9185ef9 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -2,6 +2,8 @@
 
 #pragma once
 
+#include <linux/compiler.h>
+
 /* Forward declarations to avoid header cycle. */
 struct vm_area_struct;
 static inline void vma_start_write(struct vm_area_struct *vma);
@@ -435,7 +437,8 @@ struct vma_iterator {
 	}
 
 #define DEFINE_MUTEX(mutexname) \
-	struct mutex mutexname = {}
+	struct mutex mutexname = {};		\
+	ASSERT_STATIC_STORAGE(mutexname)
 
 #define DECLARE_BITMAP(name, bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
-- 
2.53.0


