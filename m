Return-Path: <linuxppc-dev+bounces-21657-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A139ACD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 18:38:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRFbr66z2z2yf5;
	Fri, 29 May 2026 04:38:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779993480;
	cv=pass; b=h7PvCtmzvXTc5GLeRyqatBci8t4j30RUHjyU8JwRtmlfG8TnvSHmlp6aWr6zI2zzCumkwhXKS/YEb9+lfld+ep1+WfZT4X0jFxBEyPU4Y+2xQ9t57QEGVkkaE9WKJpQmrsOM6LXpnfSZW5lyvYpcWj6aKCTcOGs8g4OwaeUz0L6sk2bou9nj1iEiDWATR8l79vqRU5rc81bC5Q97hRF3Yesnx/zvEGGaK6bYo4wEnAKnjD7tpaTIy+t8tM7nrge+1ZE+uBv4hiIshLoO2IIDosEECjrCmJVN9wiQ2TpTVbjspsLgL3J5nIrzV2s9aLLwMDy5c6aACbSaaAFeM+X7zQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779993480; c=relaxed/relaxed;
	bh=qIoFM+OyOLECxtWPJ4oU8CzlPdf3KskHGLt8MQx8B7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=imI2S8bXjcPRewTH49lFPljWiCz4hPJJRdU65T05OaAOmlMxmU7dQLowAM8m+XZ7bg7e2TSN/BVVMdQA7mcW9GCxqqoadpuFMbliaNhTYDunN8DPtpzWG7OggbczhVVPhHd2sJIcrRli07fha4QXVL5hBBlEqzDWrjYQwd+KYtcyjf+h97S58c2ZMlShEwImeoM1w5XkHgYwzyZ0XVz78uI5j7iR2qXliJU4/igYnAGcCFiLxMLqK9TSWK0w852UTd/5vz5e2kp+qk0aDDiohQRnFqpRQgXxg9BMUGt4d2o0yaiyk7AZ8Jf1RcJk6HCfV+HZa6VbNzu2X7MQdikVQg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GeeC//0r; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GeeC//0r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRFbq6MlGz2yZ8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 04:37:59 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXMuFFsFRdpRplgzClR4C41UEG9NdO/GiiWPrEk5skIA2bGkA/KwNki4tvsEuWKR73BVie7N1/GXgvuk+VqVKIi2rNrIvnMVo14PN8wyb762QoKBS7zGccq6XsjwXut6Mpd6KGsQhj9PsswX4UH5SBqG8yKodOOea5bNoJcyTcYFGDUAQxmEyBUfADxnYwc2OQkqQKJcEy/6ARo/g24LjkAQ5MAWlY8NON8BZkBVeUJ9ap/9rbEpjUL7WPBdGqfQPZ8ZCDiUxVFGRx4AaLY1fECuCP9Tr+gKBDyFidlWSfRyJp0TlYtyvQLEV5nZvvF2X3bfUtrr4tSzLwer4Ax/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIoFM+OyOLECxtWPJ4oU8CzlPdf3KskHGLt8MQx8B7s=;
 b=kFDxBqNJ5iBmrXAHSM+ECw4xWGzj+yxqBlP+6k1lZ143SdXYU88TxBLQq2OJ/AgW64VTdv1J1lyjTe0S6Df+ThpMWubLmS+DPt9ePN+0xDmLtllRiCgPiNJB1BEni0LMILWBTbYBLQz4sT2dlKSefbbv4h89yaw9fuTAboE+kyFU9zWhZhAUSp5StKsY5Qtxz6rl24KtCjgRY+fFdljafsnMuwoaqm2rUOXFmItdQG2GpM62W4ZIpUhOZaDEWqLCb4mTsc2KduR+gJDae/T8YgKTS71QZLS/zcHNWjpzm6y6BgYCVjCVDSQRTyvk+M2Kx1bz8XOkFYFW0ObnLCoF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIoFM+OyOLECxtWPJ4oU8CzlPdf3KskHGLt8MQx8B7s=;
 b=GeeC//0rkKBkSB4cvFsLV9b7zkvlffKC/SMnwlNeRuhg0EimertNmRgEk5wPtVfFDw38P9ohzkTe7xbwmWzbl+O5g5P6FRmkn/BWNDpyyAL5Mg8tHKUT8kbsZJUSc17s5fUJDgovD/EwxgIo1qrCYGltutJ8UscfDa3WEDe9XKJa71Qq7jFr1WZtHM+9iT10Onf2v40ZDKXbWx74iqngyAszCccvmijgDJ8YQwwSoPObNwMXebsYPatALrafuXNCFURP7O+s2NTKntveJsrPLNsPcfBFnvtR+BJ/xI8/BRY0sz2TKEZpJQArgry7vYHTON7WU4aM5D11dct1Kd8aAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Thu, 28 May 2026 18:37:20 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:37:20 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <ynorov@nvidia.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Linu Cherian <lcherian@marvell.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Yury Norov <yury.norov@gmail.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Ma Ke <make24@iscas.ac.cn>,
	Chengwen Feng <fengchengwen@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 15/16] thermal: intel: Use sysfs_emit() for powerclamp cpumask
Date: Thu, 28 May 2026 14:36:22 -0400
Message-ID: <20260528183625.870813-16-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::9) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba9cd3d-6cfd-4a8f-a184-08debce826aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|22082099003|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	x+AbHb3Ta+9VSzGAj5hSfXt+9NXON8jX1Rt6nuQl6IyFYDDVjd3+thvKyuOTI21d0D/ooJPILTs13hNQ0yNR9ufpeR/Xqxo717VuMvU7Yd6ku1gWGUBKnS/KAJg838Kfp/9IAYYaSHcWcctz74CVIHzbP0PGvCZKQOlHdyN9SYFcdvJZsnPq7/rwkFWC27lDy/OzS6q3EzOBhClqKQ9DwsqcI37KnkDXJ6EA4esZtxzp7kvJNwxRqeCoBD6EgPzp1NjMqBPnkZxvzONPsN0HLW4H3+FV3g7LABj6QMpnpbMX24RC887yhyWLpEGBe8vjKxmr6wX+pS4XWY4ohSx24yJ05yUCLgyfwZP61oQOHBhvCkMsx8XqZrcdOLbXyUbtCx3OQCWPajNESTKImW8T/7SVDgqjNYUSgqL+cbdNRzkU1JKbi2+bBUh1KK97juxfahECCposBJizZTiTewjSQZuvtGF92v1qxyitRdW3vPuRhgTztQbmUB9QOdr2n4lRMjWJfD3gV3t7Qehj6+oqtj3HK6XXxw9Oem1UMr1AFkyavwLoK0Ow8Uoq8FRE6ejb7EPiYO5ksNMNbEhjrloYhvXCJ5ISmOX0TcKMyTREKGxGARcoW6vxe7GfR5OKVPREe8zc128ZAvE3JENG6zfRXFOjsTcSj4WTgC1mxyPdnAYiTn0HrlR+38cIoalr8uGX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uLkXRtjVx56PyGXzv0qAppOCKb0fB0DtefE7e0IBvlTypFNPJquMVC4AvHIK?=
 =?us-ascii?Q?+vSh1bCVIkePZgEKJnkwTLqBN8JYuJKIdaE5eUD1KqxSWHowt+6p3UZcHBMd?=
 =?us-ascii?Q?k0noupxl2N6sSNuBo5SgnVNYaQ5Rhxl/L10fw0u0f+99GVtm9ptVH5MCtVog?=
 =?us-ascii?Q?jI/snt5tVUCYpYbz4jmACuGktaY6RMPgRpOtWgq8Xcv/mfFY5cfNN3jHO9rH?=
 =?us-ascii?Q?mji82WtXZPwnl7G11M7HpRz0neE+D8I9NBYb09TJcTsJlaK+GnY5TAb9t6Eg?=
 =?us-ascii?Q?3XvxSD5FwsLZrmtl6M5iWvPy/H++tF5Hhb9W4tiP3OIDNaQWmROg48t+EuSV?=
 =?us-ascii?Q?mMCxZRbJtOIcDxEA8m/7Lc0nbAkBS8l0kPgI9BmZkV7mnZGjIdMXXoz54kuK?=
 =?us-ascii?Q?o5sIJFcqB6AptWyYYplWjGIzdvIRdb5mpnyKUbz2Z3Nftg7F3k0Xhm/Xjcl/?=
 =?us-ascii?Q?j/tYD18oh9fjsSZDp9lYbbI4hCelZ1qONwtnm/QtzZVz658mzNzPHUiilwUI?=
 =?us-ascii?Q?/aJbIxAXacIw0Klw/DKgklCTYnaIZMaG+GHl0l1uYOlo8Vk8xOdCo2X8ZaIF?=
 =?us-ascii?Q?CkpPzkWM72xMuIvZSfKRd/B3PTTkIoDOBDfnKSGdan7WVr30Uv3Lv2MNL++6?=
 =?us-ascii?Q?Kw0uY2YS07Ofphov7wD0Jg9Mbp1pVxmxOZVSAGpzG6lDbSCWckQN+yPoIDOv?=
 =?us-ascii?Q?MponrIXk8zb6jL0IZ4+CPBdWoslXFDasVP4P2dmtiWxqKJc7PtOftvHIj28o?=
 =?us-ascii?Q?ztd3jA0hEofvKtmY9TiOxJbxpPtMFE3hMEjzZfmq+GTtb3BYU/fh9YY+YMFu?=
 =?us-ascii?Q?asZR0ZdnmPyOSulFLUito646n/oRjuc7ztrmu+WlnsOQzrN+s6Tid06aGlY1?=
 =?us-ascii?Q?Ckydv1bmJb1Ib+Vb2Hmm62PyR3u9g5lzZU9/43Ew5TwCF+5GFbhz+b7v1cM3?=
 =?us-ascii?Q?ykXoWD9cllrKfOb7BYld1CsTiIbGZzMXJY/obmvBX96CBWrcbaPZvXw/IoQ7?=
 =?us-ascii?Q?f7hDsFpNz/+YPd4252j2oMB8TqgXEo9bIBv7+cf2jAnI1TPA9skdid5oFuu1?=
 =?us-ascii?Q?GIoJKl1xl2FcvlD86f0LR3sQWl+OAiZsBYzvTCPwpR4p2Sj6RZOxgHGDOaWh?=
 =?us-ascii?Q?dKAmTwv2qlOnH1KcdmVPyPboOKfLbf9ccJhEpyZPjkSmoB2lyHNv4jk0X7Ds?=
 =?us-ascii?Q?xzoSsW/z5siU1rxymFA9wh1MnJ3jlBD6F9LAVPxDYrM4uchDQ99NebyU77ng?=
 =?us-ascii?Q?OFxn/pt2UoDyc/pkDXwmqF4jBzDMBjDaGsEzYSj15heXmMZ9OUE3sPJTLjSl?=
 =?us-ascii?Q?8gGVN72rrGsdEF3dLMRSDVmhw/3RK0D5qnOGxyhCZStcrRYIK6Zxo1MK5L/f?=
 =?us-ascii?Q?Kct5S7g+PpbNFGBjiVV7lrOoU7663KtsVXVeJMSycR6SAtovIIMxRZ5uet2A?=
 =?us-ascii?Q?NIumwvbNF5DW31000wW/Ye7d9qps/4ETafpmKePB9MPGBYezs9jLLX/zvJfL?=
 =?us-ascii?Q?Z3dGpJ0/qL2nmIvyF6RInLVNe0pNiP3hJdTRg/j5gci1hRgXOZzYM9wSkwV1?=
 =?us-ascii?Q?uObeqBJUeEcV5EuHSfCq1umCDNswRwPO7UnZuNuP8pu94M+70Xv0FccRn7mu?=
 =?us-ascii?Q?9N+gY/Ax/tngNV82KEWlKXPnDV+H6G21XQj/7YJmpm57XFIaJyI6rGMxscb7?=
 =?us-ascii?Q?iG6WLWzF7uqwWGcL1i+CjWkHgLI49Aj7xYL/Ytbq5Z12W2+i+QbDLzixXrNW?=
 =?us-ascii?Q?kCPA1blYyiAQ7/Kpf1NqCX2DwhLNXH9Xq4OTHIJ/bVhFzxtf91Qz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba9cd3d-6cfd-4a8f-a184-08debce826aa
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:37:20.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiICBKvKxEVXExv7p9hNmiEiIRVi0OhY7MubGR9YJeGyGhCb0HtPaoOGOb7b3/5/4H0Gh6aWUH4bKErUZbh+gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389

cpumask_get() is used as a sysfs getter for the cpumask module
parameter. Use sysfs_emit() and cpumask_pr_args() to emit the mask.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/thermal/intel/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index ccf380da12f2..bd7fd98dc310 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -200,7 +200,7 @@ static int cpumask_get(char *buf, const struct kernel_param *kp)
 	if (!cpumask_available(idle_injection_cpu_mask))
 		return -ENODEV;
 
-	return cpumap_print_to_pagebuf(false, buf, idle_injection_cpu_mask);
+	return sysfs_emit(buf, "%*pb\n", cpumask_pr_args(idle_injection_cpu_mask));
 }
 
 static const struct kernel_param_ops cpumask_ops = {
-- 
2.51.0

