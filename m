Return-Path: <linuxppc-dev+bounces-28658-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D018ACA5FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 15:20:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwbGD26b4z2yYf;
	Fri, 02 Oct 2026 01:20:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790868052;
	cv=pass; b=m15dkmPmRnpmN4wzwZj+ecWtZgO1sEU/yJeHPnFAyylbuqqtEeThGTb94yK86p9rscEzKM1unCFPV8hu4B9EipDw+sO7jIAeiaHPlg16s8TdCnCdeGZu1oHF+mYyjLWom/sEleKpaEGcqsfW1/Pg3SMOxon7WCenoyecECUe4iqqnvKuQzIx9TXOQN1Dm8VlxDzOHlsfnchPVOgWSPJP3CfCGkY1bp9FGoKBWlW6d8KKAoq4pH/LYS+VZKjg07ij9QJRhtG1fj34O2RuAbC0wW2OEDxUH+MIX8rIjAMBP4jgvpgbPl4TCNJuw8RB+GO6Wn8BSljvBVDnJOCB2QASjw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790868052; c=relaxed/relaxed;
	bh=3YYTZjhEwZJ0TssF+378TwKS+eN8c2aSblt03yjYGts=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=T6TsfjDX6OOzRK+XlZavJbCB33RjP+eHFXsExm/72s1fM1ALummq889V4KIzLctDPAk2VBTXGjNkOCz2BxL98sbvj+XVWnFBqLFejPlIMvFUGKmMfOC9K+zoC508OxnoKznJEgv9cJWfJJdnaW9DGSy8tNJheg/f/AV0ykCnikdH87THWfGM8rZ4vhImM7jiWiFy9CFZGgE/umQDVTy5AKshfMD8PSYNecgvJkYfMMQF4nUJ90BtCJiEwg2sSMFtWIrYO6UsOXHzWSG+MvqclU+GxdEj5OVSsU/WDdKG7xMHWE3LF4KbCi9wSzJ0Mfvc6eZhFbE0JBAaC9xH5PcC8w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fl3LHCQB; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fl3LHCQB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwbGB4XRtz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 01:20:49 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mft82P24ROJQJ7BRJZ/lx47/m2yH8qJcgQD+Yg31FeHE3tSga1ahqlpS5ZGVJphqHX27LlNTQV6mQzbZuS+8zNUb/m5aGqGbmYhkpN7ppCiln5e/cDmm2Xc6N9qTdk5Ke9aZ1EydrfqY4u4rJaGwXxfo7Bgbb3DpH7hihkMCWC2U7s3X3Clunhb3PeEZjaGMhF9bJC8HgKhH3G0p2L6arwKfGoGfdWM49ycWM9tl0ku+UM3haGJ+vAVKt6JnpHAzdsHlc16u0DcVHUP0bcy+qMHWebBslNlcVAiEYOEKnkvFWghD8pKAWp3dnFctmSo+tE+ANcBC+mMMu4jf4E/qYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YYTZjhEwZJ0TssF+378TwKS+eN8c2aSblt03yjYGts=;
 b=N6gH5bPztY3IR2R1irbhNu8Y072VuOKTk8zViJ00l+ebyjRq5wLzdWPjl9mXGwv9clVmv9MQFFm3MmBb8ONskDM9OQnjhKyFeVdcuCoGERCtrhmIMM4QAMhX3pS6eDWGcHWw4phF45IUjCFaVos4jL0jgihq+Q+mKadbyUMavnv8hx8hOoW2/rb0bQY78nAs4EWhGKgrBrm1MfOQER9BL4zmnEb96MmEMSArOHID2D7tSlab4SGtQ413KeeOoqgysI9loBIgJeAqrsOEJCBqmbruJLM8ZxxfR2vdyUZmW066kKLYCuCOVSJY6qXFcsgRG0xxyVQD5XWGWdid7djwiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YYTZjhEwZJ0TssF+378TwKS+eN8c2aSblt03yjYGts=;
 b=Fl3LHCQBWqKJbFnXWWWxejTowVjxnRbMRIwV1h1qPj1y83DQU6+iy9gATfEhSBNX18H/62tA46KkomoiXmmnp26MvoeQPcF6dxQyUn4ohLzj3gNlUmWLdHayYFIAhjTVIL9SCqx6iMPqefsIHms+t7QMzzLmQmbraQTUSJmrKvhFn4pTkLn1puMeEGP2Bvki+V3LtuYLeXYgYW0bNHYKa/qQqEKo435R7sO4UhfOWWDP+YwsX0uMLQb/lB+GANvD/cG2ufmt664tW0lHfuTEP3cZs71ZKU0SXPmCOUrGueTt4MSZ3A0WzixNbRZELmngA487Mi1/WR8oRFcYKc8kNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by IA4PR12MB9835.namprd12.prod.outlook.com (2603:10b6:208:54f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 15:20:21 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 15:20:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 11:20:17 -0400
Message-Id: <DLTLQ9NOBV36.1D1MY7SZABEQP@nvidia.com>
Subject: Re: [PATCH v3 23/40] mm/mlock: clear VMA_LOCKED_MASK over mmap
 callback
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-usb@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <selinux@vger.kernel.org>,
 <linux-sound@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-scsi@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
 <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
 <sparclinux@vger.kernel.org>, <fuse-devel@lists.linux.dev>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Jann Horn" <jannh@google.com>,
 "Pedro Falcato" <pfalcato@suse.de>, "David Hildenbrand" <david@kernel.org>,
 "Mike Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Jonathan Corbet"
 <corbet@lwn.net>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" <leon@kernel.org>, "Paul
 Moore" <paul@paul-moore.com>, "Stephen Smalley"
 <stephen.smalley.work@gmail.com>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Nico Pache" <nico.pache@linux.dev>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>, "Barry
 Song" <baohua@kernel.org>, "Lance Yang" <lance.yang@linux.dev>, "Usama
 Arif" <usama.arif@linux.dev>, "Kiryl Shutsemau" <kas@kernel.org>, "Doug
 Gilbert" <dgilbert@interlog.com>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <mkp@kernel.org>, "Jaya Kumar" <jayalk@intworks.biz>, "Simona Vetter"
 <simona@ffwll.ch>, "Helge Deller" <deller@gmx.de>, "Sebastian Reichel"
 <sre@kernel.org>, "John Hubbard" <jhubbard@nvidia.com>, "Peter Xu"
 <peterx@redhat.com>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Oleg
 Nesterov" <oleg@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "Arnaldo Carvalho de Melo"
 <acme@kernel.org>, "Namhyung Kim" <namhyung@kernel.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Rik van Riel" <riel@surriel.com>, "Harry Yoo"
 <harry@kernel.org>, "Juri Lelli" <juri.lelli@redhat.com>, "Vincent Guittot"
 <vincent.guittot@linaro.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Will Deacon" <will@kernel.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Nick Piggin" <npiggin@gmail.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Muchun Song" <muchun.song@linux.dev>, "Oscar
 Salvador" <osalvador@suse.de>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, "Jan Kara" <jack@suse.cz>, "Marc Zyngier"
 <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Anup Patel" <anup@brainfault.org>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Janosch Frank"
 <frankja@linux.ibm.com>, "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, "Gerald Schaefer"
 <gerald.schaefer@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, "Andreas Larsson" <andreas@gaisler.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>,
 "Matthew Brost" <matthew.brost@intel.com>, "Joshua Hahn"
 <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Byungchul Park"
 <byungchul@sk.com>, "Gregory Price" <gourry@gourry.net>, "Ying Huang"
 <ying.huang@linux.alibaba.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Chris Li" <chrisl@kernel.org>, "Kairui Song" <kasong@tencent.com>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Nhat Pham" <nphamcs@gmail.com>, "Baoquan
 He" <baoquan.he@linux.dev>, "Youngjun Park" <youngjun.park@lge.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Qi Zheng" <qi.zheng@linux.dev>,
 "Shakeel Butt" <shakeel.butt@linux.dev>, "Axel Rasmussen"
 <axelrasmussen@google.com>, "Yuanchu Xie" <yuanchu@google.com>, "Wei Xu"
 <weixugc@google.com>, "Chengming Zhou" <chengming.zhou@linux.dev>, "Michal
 Hocko" <mhocko@kernel.org>, "Miklos Szeredi" <miklos@szeredi.hu>, "Xu Xin"
 <xu.xin@linux.dev>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org> <20260917-b4-mmap-prepare-vma-flag-sanify-v3-23-4583d8a23bca@kernel.org>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-23-4583d8a23bca@kernel.org>
X-ClientProxiedBy: MN0PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:208:530::27) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|IA4PR12MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6be638-2fff-4211-ba76-08df1fcf81f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|921020|4143699003|5023799004|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jaggmSVI0Yi/kMtwqe189sppnG6OCckWiwx5CBpo5r1EAvxQyk5XDECHBQE15zN2nk4wPAjnog/l7Mwd77PoH9lIeya28ZvECDZMzI3JPc/Ufd7nUX9LVCCWCUb+BP5So3/CpugHUICE9BCavKHLTrchAnP26Khn4xJWE3y5II499hOR6tRPTvwSEAnUPQPba52K+A/kWGzNimUv2s9ftW5IO/bPIz9q+wgEaXzytmgGCpMG8XjTNP2+h6PleU5qJrXzqsSCiwfvFePGh2GYtVR3seKBgVRRkQupZPCmcaElNPaQf7vhdD1VMNDRUFl3y5zQ63LKy91UIei731uv1fwdpj7FSbX7FS7Kiru/R9rkrzDmF1jRcSw0KvkSOF3Oq+ub7RLmRtgbyL5BsdUmGu2b6c2IMtUZeI2cY5KM/u+wx82GEXIMpdHLExmHriJqknnhN+S0KShDfx+2kCHM+wZKFwcgqrkCcecpLcnzTNJ+nEzEjuIfMH8GM+W8y85aVpU/QAEqRI//vTANA0Lq8IQBVjbsDQ/R7WuvG09uIE5scgKecKkEKpg0Xm9elOyCa6cJmQkynaIbPXhO8xZOWiAcGAS3NG4Gn8BT5UoDHctx/dmGpSysLcuPEucDAuDB+whFc0xvhtscRuKdAcdNNBFY/vrKlqqqk3/Y96rtzi9vNHhdg5kukM2qIQnTgw4Oo28qQsQ6L31HSwqah7EqgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(921020)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlNwd3ZsSXFyRXNrZS9xTzBGVVhtUVZpMHVzaFhJUG04em9TVjc4Rm4wMlpn?=
 =?utf-8?B?eTNjUFVKS1JTaGlRYXorV1JtWDdkM3JFOFc5c1BuUUx1V09ZUHc0YWVTaGsv?=
 =?utf-8?B?eUVYTFg3dmhaNzBjclR3Ny9tVFZYd3JwZmpBQWU2RGN5M0FXSzRnZXlQdWxz?=
 =?utf-8?B?Y1p6MHhTWVRCbjRzdkdVNEZ0ZVpVeTJiRjA2T1dVU1hVYkl6NnBMRFpyZGl3?=
 =?utf-8?B?RFpPQXNoYURjMEFHRGhBM0lpQy9ualBrcGVIVU5KOTJOVWxDVmh1S2RmVXF0?=
 =?utf-8?B?eitYNmF5VDRtL3k5UVhrL2pBS1FLcEY3SFhaQTNqMzJGUmRjNVM4bFo5R0hG?=
 =?utf-8?B?YzRnU2c2bzZGSEs0WDRVUERRQXZkd0NTQWQyN1NEYXVUUXVOTXdQalJkWjRP?=
 =?utf-8?B?RS9RK0Rka05sTWxkNnhHWHh6Z2FsZEt3Mk9rYXl5bmNNOXhLL0tHQ2crSkRk?=
 =?utf-8?B?ZndGM0lFcFhmZG9ZTlFXYlBXeUFCN2ttL0pKWkltUUlwRHBRWnEwUlVXMFE0?=
 =?utf-8?B?V0lmMmxIbE9OcGdUSDFJZG9KNVFYd01zaURDTVhTS2dUUkJDQkRlVkhqMS93?=
 =?utf-8?B?QStLbUZBWHVldjlXSDVkU2puZEhQbzAwRWJSLytNSGw3WG5idXEwY2djcTd1?=
 =?utf-8?B?clVjZjZ3cy9PKzZ4TkZwdHVWWTFUN1p5VVRrMm0raUM3dUpFMS9rN3ByM3o4?=
 =?utf-8?B?WmtRQXc0MlB3UmlGTDF6MHQxVmZteTE1MHlaaHhlMU0rdy9XVnRrQmdnNTh2?=
 =?utf-8?B?TXU5REJ6STVIbmNrMVc5RUdyS0dqaEg4V0dIdzZ5MSsyQ05jSFREUHhqNnFu?=
 =?utf-8?B?UDNobXY0OFZFUUNPYzBzaFh0Wnl1RTBBZ3JpZnQ5WU1SeC94MEpiWmUrbWo4?=
 =?utf-8?B?eS9GeXRjeDl4WXZWSTh3Z3JrclBGU0pwSExWVHhNMnB2Nkl2WnArMS9pbnV6?=
 =?utf-8?B?UG5WTTYxWDNKR25sdFRGMXpQSXZ6K21sRjZzT1pMQmxMZzd2TDliMloxQSsv?=
 =?utf-8?B?Q0UrTnpMOTV6bWlTdEh3YUIxK0tJWFh3b1RkeDBTVFcwY2hiWHd1cTM4WTFU?=
 =?utf-8?B?WkJYK0hpbnYxTnh5RitLRFFyVmVaVnVJbUw4V25TaW9JZ3QwWjdGbjhQc3pF?=
 =?utf-8?B?ZVUrcTF6SlBoNHIvWlk3a0dUM2NqK1RhTkIzY1BmbkFLalpENGVQTktYdDMw?=
 =?utf-8?B?cDdNbEVJRXk5NW5TS0d1NzU3TEdtOWJTQ1RrWXlreUhEbStLZmhtaEtWOHhC?=
 =?utf-8?B?cUZ0UlIzRS9IcGNtcUZiNmxzNVZrT3lGcVJBUlkxZU1jSVljcmM0M0gwTG9E?=
 =?utf-8?B?S2JHU25tZVlFc3c1VzVJZXBzOUtxdnF6TUMwRjFGQ1BMK3htWlNLMzA1RG1U?=
 =?utf-8?B?S2hKMjJUZXBZM1RUbmdVakZLeE1jNThjakw0ZFRNeXUxY1VsbjVsOUNrUGIw?=
 =?utf-8?B?VlVCK1UxN211YzZBeFo4OGFuTWRzUUJDakx2WDNSNHo2djFscTNsUTlUOE5y?=
 =?utf-8?B?UjFEaXJlSGdjNzJTMGgwM0lpajNEN25ZQjhxZTFXQ3hkRWlyKzdkb05SUjFZ?=
 =?utf-8?B?MzR3aldOSTB1R3YxaWxnRXU0NGU5cSt2dzVnNG14anBPRDV6UHdFTjcwTWhM?=
 =?utf-8?B?Wnp2S2IzcUZrVWdrYU1mNDdQSmxiajBpb2E4cDBRcmdERElwVTZzTlpoaFBC?=
 =?utf-8?B?aDVDbm4yTXhHbGlRZWZBVVdMMjJsTGxxd1p2RHF6YTlmNWJsQ01CdU15NFY5?=
 =?utf-8?B?RUtNOFY5M096d2VzU1cyQlN2YUpzeldMb2JiOGZVUnFLZmF5ME9mMjd5YUpn?=
 =?utf-8?B?cnhsNElGR1MrTlNSK0xMbVRtU1RBbkpndmM1S0h0K2h6OTB3cEZoSUtUMmMw?=
 =?utf-8?B?ajVNUlVFUlNES3Rqays1ZnI1ZGVHcm00cGtCQWNxMGlyRm0wbitGa0oxa0Z0?=
 =?utf-8?B?bms1eUxGUXdQTy94VjdSYmJOM1Uxa29MR2g0VkE1aktha3l0Q2hyOE5tb0lF?=
 =?utf-8?B?YjhnMXdPVTVPa3dFSlF6NFNneDBCM1dIbmFiSDh2N1NxVXBzejRWTE00WjdF?=
 =?utf-8?B?aEtNdUV0Vk5jTVdzOE9Gdmw0dEcxU1Rac3MyOWFuQzJRNVBKU0JxSElZelR1?=
 =?utf-8?B?SUE4VEM5L2p6YTVOeFlrd24wWFUreHFJWnlseTh1YWxWSkVMYWVDOFlYb1E2?=
 =?utf-8?B?STQrOW1ZbzUvZmRZSmgwd0xqNHZ3Qm1MUFdyZStGNDZBYzBNMkRsU3dscGJK?=
 =?utf-8?B?YTNyWlRRL1pqS01HcFFQY20xd1NJQ092RVcxVFhpbEs0RXFXRFVERHpJQmdv?=
 =?utf-8?Q?IqSsC3edk8y+16vvja?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6be638-2fff-4211-ba76-08df1fcf81f1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:20:21.1045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKyEl+LchyHI+qS0cD8Tp8KYqsx2vovGmnMCqIhnqBCaRhEMrkFwMWxOOMrt6ov2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9835

On Thu Sep 17, 2026 at 12:22 PM EDT, Lorenzo Stoakes (ARM) wrote:
> Currently there's a confusing mess around VMA_LOCKED_BIT and
> VMA_LOCKONFAULT_BIT.
>
> It is permitted for drivers to set any flags they like, with the VMA
> already possessing lock flags.
>
> This results in the absurd situation of a VMA possessing both
> VMA_SPECIAL_FLAGS and VMA_LOCKED_MASK flags, which is not permitted.
>
> This has resulted in mlock_vma_folio() having a very silly check for this
> scenario to work around it.
>
> There is no need for this - just clear the flags before invoking the hook
> and reinstate them afterwards if they are required.
>
> Nothing relies upon this being set during the mmap operation.
>
> mmap_prepare is unaffected by this so requires no fix.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/internal.h |  9 +--------
>  mm/vma.c      | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 8 deletions(-)
>
<snip>

> +	/* If VMA flags still valid for locked mask, reinstate. */
> +	if (vma_supports_mlock(vma)) {
> +		const vma_flags_t mask =3D
> +			vma_flags_and_mask(&map->vma_flags,
> +					   VMA_LOCKED_MASK);
> +
> +		vma_set_flags_mask(vma, mask);

It took me a while to figure out vma_set_flags_mask() is an OR
operation.

> +	}
> +
>  	map->vma_flags =3D vma->flags;
> =20
>  	return 0;

Otherwise, LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>



--=20
Best Regards,
Yan, Zi


