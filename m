Return-Path: <linuxppc-dev+bounces-23424-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1F9C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 15:48:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grh9t2mGxz2yvQ;
	Fri, 03 Jul 2026 01:48:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783007298;
	cv=pass; b=nQtIqhAQvE/LIVZC+fLAhrZRF++JuX/YmWnXHWY9Zy+GP85wC3ETC3OxLbTktccB+rVeeYisjieQJAjIEuA3Yv3DUJqKVx6k+Mv2Pvq0xEyvgB3U+MZKQSapklBbhULr/ZiKWsSNptn3wUaglyetsJDMeNrj1OAzt0Cewa6YnSuvHBAPjFTqfHOg9eIc/MindVKZQ/7K4H9WHQqzM1J+zL9/5gdrrw1nqIJAJ8J0xcAju4BHztWOZ71YtmSEwl1CfiWmFw1O+nOwa93xNd6FWZPrm+coFQECJkATubUHkS1f7DbbJRwU4ox0iz6QqTYnRo5oWqZ+ctW7Orn5hC9NBg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783007298; c=relaxed/relaxed;
	bh=luamU6SaHMQOQxEC7XNHObgMDTH2Q/I1KgnB0EFg9V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=de20Yxi2i3VaJ3vae5YesShunPBZ5a7UAfrozeOthiAl4GiiDKdOVoFMEnDz3xiGHFqBwdzj23uTrmKEEsQUZmJmmb73FIswWXoQduHeq2Ds3F2a/WxlBieejyMxoI3LA0KAC6yS2A6MKQOYhgwHjRMYwGMOffvItHLWBQuueDtRm44VWPub4aVz9ryFJCcwAgjW3LUQG/+6C0TdHmtPRwV00o7YRRi98nTs50/+76dgS6AcZhyKNGvu7gMIXnmgSDfSRdzL/G9uz+FMbD8kTc50hAqdIvbWnCiIOtKwK2zK26kKAi3HB32uYEE13IDZLToE5ZuPpi6YQK+jy0tG4Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=p2qd7Yms; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=p2qd7Yms;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grh9s4kJMz2yv8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 01:48:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVytMDFLARDZwjNyzfoiVJjPbs0DbZKLVHT0ctDUecXydb5RZ0ky8o89C7UYATg38dkc0UlaZerI1ljtJYcasPat/xEl83Xki6YYXaxZTdGtLtO0Kg2HbSVZysO5d2jwzMvVQdM/ANDUcUldFeSdHd5uYi2EmlQZTLSbOQvPvqJxYhb/sUGMMQxgV/7uZ0faHck3IbtDKO2Yz1bQvCiTnFg+4I7HXVN7iVH2qaL+EgIkHzB8DIYjPv6W/KBXtvpiRgHlKgbETgUu3JRI4v8bbd9wDSIwvf7J/+wgA5RC3TFx4De8UsrxCDJrTSvK7vsCd7rSi1M6H50Cv8n2lD16zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luamU6SaHMQOQxEC7XNHObgMDTH2Q/I1KgnB0EFg9V0=;
 b=U/odf4c0o/UmejuiQruuaAcntBIHXgukIIoUv1PHZopEKJG4SzSKJ79ckwj/EVpppQ0O8+42VH+BbNVEiyuabTudNnLcEmLk6b6CfkWlFg+z7V0BmsOjx5FCnRI2oFxb2Qqplj9Po8tZfdmW1o57gLWOt+xKpbiCzGrubZpp5D8+/MWcOz6KUMnIvsyFyogwx9DFTPy3CbHk0yqWTVp04So5VyWm6yEtRlH54s0Wku5hvAq9mpJpZGQO6/R0uqYETvoLIYItRxt+xYXmrfH8LREN0oU3DeLhxtoGdVB0dGYbh1mq0/rImGkCGjYtf0a4pjffrTjejPDwdqRsp8KOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luamU6SaHMQOQxEC7XNHObgMDTH2Q/I1KgnB0EFg9V0=;
 b=p2qd7YmseRiwJxoTvNd4/G/H1SjaA03V1ENLWBCN/YljFbXICJMhJA7ZbWL+KDU8NQoPZuuSNVBMj1GEaI9PvSQgALRGZkq3iGZwBJyqF/pIVTf0A81len70zSSm0rEne58ibqFjsrcPiqVPX4jTWI6W/z2CINnZUC08MvkBo3fhv75qLWEGe7I79XbAuG9R+Fbwyi9moCqvWW+Ksl8yL0rbi+5bF96RUUc67WsYUZkETkbyZdqSayZTbYk3IymmRMwHX8IvMQmtv8wJlzC8VLlh9vQj1HtNhR7xKZjZz+ZuSvr98j1wZebAKh7yAD+/4Rpl5KkI/4XjJZyz06FeCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 15:48:02 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 15:48:02 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <ynorov@nvidia.com>
Cc: "Russell King" <linux@armlinux.org.uk>,
	"Frank Li" <Frank.Li@nxp.com>,
	"Sascha Hauer" <s.hauer@pengutronix.de>,
	"Pengutronix Kernel Team" <kernel@pengutronix.de>,
	"Fabio Estevam" <festevam@gmail.com>,
	"Madhavan Srinivasan" <maddy@linux.ibm.com>,
	"Michael Ellerman" <mpe@ellerman.id.au>,
	"Nicholas Piggin" <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Arnaldo Carvalho de Melo" <acme@kernel.org>,
	"Namhyung Kim" <namhyung@kernel.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
	"Jiri Olsa" <jolsa@kernel.org>,
	"Ian Rogers" <irogers@google.com>,
	"Adrian Hunter" <adrian.hunter@intel.com>,
	"James Clark" <james.clark@linaro.org>,
	"Thomas Gleixner" <tglx@kernel.org>,
	"Borislav Petkov" <bp@alien8.de>,
	"Dave Hansen" <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Chanwoo Choi" <cw00.choi@samsung.com>,
	"MyungJoo Ham" <myungjoo.ham@samsung.com>,
	"Kyungmin Park" <kyungmin.park@samsung.com>,
	"Heiko Stuebner" <heiko@sntech.de>,
	"Xu Yilun" <yilun.xu@intel.com>,
	"Tom Rix" <trix@redhat.com>,
	"Moritz Fischer" <mdf@kernel.org>,
	"Yicong Yang" <yangyicong@hisilicon.com>,
	"Jonathan Cameron" <jic23@kernel.org>,
	"Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
	"Jason Gunthorpe" <jgg@ziepe.ca>,
	"Leon Romanovsky" <leon@kernel.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>,
	"Will Deacon" <will@kernel.org>,
	"Jiucheng Xu" <jiucheng.xu@amlogic.com>,
	"Neil Armstrong" <neil.armstrong@linaro.org>,
	"Kevin Hilman" <khilman@baylibre.com>,
	"Jerome Brunet" <jbrunet@baylibre.com>,
	"Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
	"Robin Murphy" <robin.murphy@arm.com>,
	"Jing Zhang" <renyu.zj@linux.alibaba.com>,
	"Xu Yang" <xu.yang_2@nxp.com>,
	"Linu Cherian" <lcherian@marvell.com>,
	"Gowthami Thiagarajan" <gthiagarajan@marvell.com>,
	"Ji Sheng Teoh" <jisheng.teoh@starfivetech.com>,
	"Khuong Dinh" <khuong@os.amperecomputing.com>,
	"Yury Norov" <yury.norov@gmail.com>,
	"Kees Cook" <kees@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	"Aboorva Devarajan" <aboorvad@linux.ibm.com>,
	"Ilkka Koskinen" <ilkka@os.amperecomputing.com>,
	"Besar Wicaksono" <bwicaksono@nvidia.com>,
	"Ma Ke" <make24@iscas.ac.cn>,
	"Chengwen Feng" <fengchengwen@huawei.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Yushan Wang <wangyushan12@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org,
	x86@kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 08/11] RDMA/hfi1: Use sysfs_emit() for cpumask show helper
Date: Thu,  2 Jul 2026 11:47:21 -0400
Message-ID: <20260702154725.185376-9-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154725.185376-1-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0128.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::13) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9620c6-d2ef-42b4-d3e8-08ded8514c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	NdtEVEidIhob4DwIoMQjh1LHuYaYFWSf8olsMYYxGDwu88ZLjudBbvosS1z9HTXnJ57IxDchuR/R0nEp/+XO+LYAeSb1B7YX5eSoOYYP2fhnJcJJ0zLa7xmQao2w3Kt1GOwP2KlMtzLZWpDm+Mqg/wiKjqrdONGjq862mVVUXS4T4Ky5OK30O8xqrFY58ys+whiGnS1bCljvlLTwYUCcRT2eeW5JBiA3QyfvJg8ID6Oq92WJEX2EoqkCCICdvjt14fmwuinuQo5UN+LMyJsVjmG5KH2uiA/mp50WbE4kOBSIIuiZ9wHX0StUmZnGUX9EWM9r6PJZfnEoPFeiee58H85E9zz4gnIbY766BmpjOb8+qCQfONy7Xy9B5YKUwCH3z8qJWOgvmhHE82Mi8vFmiSc7wcN4MNylVImXpOgjjEeaINS4mV+3h3dOCHHVQ4+YtOTWKKCd293PqPTfYx4deDqsXiptW+A/TZ0xMR14aSbQAHeShkB2PYOL/cNHVM+av4WPkz4eEDrTHORZGlRuIkT8rUrkMNEdU1czgQ3A11uj9blg+wYzXzjPQI6CzNReinPJR7W8kfPhQrtcYhL2NCdHP6p2Zuvtogl86S+4Em8ZgqM0IrztzGGidZPRmwEAQudyLmME33Wx4KZckJPexh8AarSpd94A/7/34fM/a9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xiIHzoS2szdCoQNUwq17hhUKtuIblT5e4SJ4ubbzhNVdaDrUJS6oP2ozH/ia?=
 =?us-ascii?Q?+u30pvI/uiqkGPeZqhQyTY08ziqqaPkHvh0bGHRKBX/1ENbbcKov2PScvAmJ?=
 =?us-ascii?Q?AU3Q7Lwu4qH1XlVUZIAyS1HIcAaKS3T4Bjo4Q6N0PfU0LdQPI7HcwNesaVDf?=
 =?us-ascii?Q?zRJwHzjPLp52UhC2Xh0iFjAvZuy/okuBMhMihrKeuBvXTDXX6ACN+jEw3dao?=
 =?us-ascii?Q?rhceFt/jiUbkWx4UCZnRjKmj1SMc0C57GVQpXs7a8WxlE8Xs1cneadPcLsaj?=
 =?us-ascii?Q?ukDcdfTFWPmHInfn9MYnTdJ5NVZIyvbl9daHJ1IpCldm+ebxSJxzqsm9M+RG?=
 =?us-ascii?Q?+FeGsGmlBiaV9Fl9doDzWZcfyEfaS4XFIcLy5UcTRzpyH6uYZsm5NCJs0O30?=
 =?us-ascii?Q?B+oK9epn7tG/uiaMkf3S+2Y6zqF36HUeAqayXbD/5AbNUqFtj2mowS6sJrP6?=
 =?us-ascii?Q?5uGvVdmG+bdQdNo81nRN/xLcXBYmNcvEqnQZF2Fg05zz3vwtWzNgEjR0hxba?=
 =?us-ascii?Q?uVfXIorjOeL4VH7cC7maimT54qEEErCWruury02xp8zWdieNqOc924BqZ7m0?=
 =?us-ascii?Q?Ep5gim/WhpFZ8EaZqlL3mgta04208vOR6NRvqOKevM9KuT3EY4EaWBxUIqOQ?=
 =?us-ascii?Q?th2E3iqBNBkS5C++PtTmFTeSqrZGxFejMB6sH/GM3tve40fhzWeE3YqW4YZz?=
 =?us-ascii?Q?Ttd3B0vpbCFlQX35pfQNzzAFwMnt4QWKOBNEq9Q0uPGb8kZQ2UMq9QaafPxj?=
 =?us-ascii?Q?lDXKC9SwjumIn3qXTGbFjtcqd39Oc82CRDS59F7G9d25S0tp+s1DVoEL11A9?=
 =?us-ascii?Q?Gda4B9hYrojqScqHoNEFWa+qe/N0O17sK4rcLk4nrfOZKTIrttr7Wd+uv1mn?=
 =?us-ascii?Q?pTNFfi5LadCiFLnECnwYiuJkFbCOokdF9RZ47+YLZD7pKqeKpEad5KNvuY+9?=
 =?us-ascii?Q?ZorCy5u/r8nkVskI+inatmefnxsNeMiLnZbm8RLvt5iYBln8RG/yEg5RMbyo?=
 =?us-ascii?Q?k/DAXYqI2/wHI9E4+ofu9YcqywhZEcy+yQ7h3QMidLJV7u6Mz5AxpR1OcWns?=
 =?us-ascii?Q?rWKTNlzXsco/2KphnN2nTsM286JcZ/efSFu2zz2mx/zeBcHIk+OhqPIiC4Ei?=
 =?us-ascii?Q?mm3mJm4K7zkHr95N8U6ljPgzbJVdjZaQ5MucJUYcG7lBvlElav1l40ftMcrB?=
 =?us-ascii?Q?26HXQ8Oqz2dkUUL5W/nhuC3M5ndh/k9liYVgISlKinkjy+ua5p5Kt40U4cDj?=
 =?us-ascii?Q?ZS6gbrZSaPoi2KZFMrAWTeDjUB/Im4yM+JCOU52gv1QSccDqJ9qRNgiSoKGp?=
 =?us-ascii?Q?MlnLK5kS8sBd6sDEVZyS/MAVGtfrZuAZ7ryKKN9qLgnTjeXcGwRQKV58xP48?=
 =?us-ascii?Q?y3w/TCkKnfMq3p/1V4lQHmpSUtodxZn1Lr76Nc6LXT+SdS9z8hzcIjpW9VDy?=
 =?us-ascii?Q?OtEmgojSHhgY5v4DjPcUg2GJl4eAPSV44RVGwiOBt/+YnF8DNMU/ab0NXY21?=
 =?us-ascii?Q?OJzYnUe1dI5btJNiIfD9HulArN2Bz3eNxm5O1JeiEIhwXiTRMAaUg2feeXyJ?=
 =?us-ascii?Q?NEz3joxbY4JM/xE2IFagRIQlFCRsr5I5We6crhcs1jXmeZftCWzmFMGd7vk4?=
 =?us-ascii?Q?vYBZ8rZyJeXrJwuXnGFEt4vuL3eeJmK0kHxVkhX6x2IszGbW6rcpKLyGTSlS?=
 =?us-ascii?Q?FJjljeI8vMFN19fbDGufn67D5KUZjXUgnFVlN1QtECIkzq2tI58Nz58FSgeY?=
 =?us-ascii?Q?tDyt2Ke8Vw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9620c6-d2ef-42b4-d3e8-08ded8514c8f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:48:02.2848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXqfKIPcevNOLB9mFz7Sr56JeXk4HolLJoj4WlTbmed8jAws3UlS73qjxdaY/ZD6gI8bsC/HzvmX1ys5QH0dBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738

sdma_get_cpu_to_sde_map() is used by a sysfs show callback.

Use sysfs_emit() and cpumask_pr_args() to emit the mask.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/infiniband/hw/hfi1/sdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index cfd9dd0f7e81..f253c8ee182d 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -11,6 +11,7 @@
 #include <linux/timer.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
+#include <linux/sysfs.h>
 
 #include "hfi.h"
 #include "common.h"
@@ -1049,7 +1050,7 @@ ssize_t sdma_get_cpu_to_sde_map(struct sdma_engine *sde, char *buf)
 	if (cpumask_empty(&sde->cpu_mask))
 		snprintf(buf, PAGE_SIZE, "%s\n", "empty");
 	else
-		cpumap_print_to_pagebuf(true, buf, &sde->cpu_mask);
+		sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&sde->cpu_mask));
 	mutex_unlock(&process_to_sde_mutex);
 	return strnlen(buf, PAGE_SIZE);
 }
-- 
2.53.0


