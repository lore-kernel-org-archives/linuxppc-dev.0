Return-Path: <linuxppc-dev+bounces-23418-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CDDC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 15:48:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grh9b6nrbz2xwM;
	Fri, 03 Jul 2026 01:48:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783007283;
	cv=pass; b=j1Rf4rw1M+r/EqcOodJR9vH67mR1pqY6Co59rLngdlEeL5zCaywITZTVaKqMUC9jGcLyoO+IQQSCH/SG123FrKNitbOJi/uY8Ift0u+PXMfCrm3gOgnM4oO8cmxFtXWsKGJ0ZIgGcS678qrqjxTwuGXpeMNcumP13HdVsQMCseOG2MplS7H10iT9jmcIu3eZnluJDvXznsf9m4POr8PNCarjulIBVu0LtXoQ41Qmo8cMgpPy0MfYSPFVKwFLwAOamTUSHw1mOO2GeIaSLxhjbZYVEtOP7mTx6NW4n4ygQz347GOB3BIrOj2nt0mSayXritTG/20bnrgrjhuRnz0EwA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783007283; c=relaxed/relaxed;
	bh=yav8utETY6FCguycHYwbLXHTThtCgsZ4dGDEa+HsUy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eim98pXPw8ySlC00pRY6s8stQF/rqDfAuVsIHGs1BvHqpA3q3EIUhydulO3bqYBz9fEomiRHbgFlLNg2hJPw7ZvJnr1dLhGgR8N6NNkg4969bkvr076fT+daS69nT2vH7uv4ViEZ9vacKKLoHgWG88Ssly3O1wSwvopJg4BCL0ZOcIo3d6pR/4CZFnsGnRELMvFHM/JoYlYZifnOQxZFL2d/PS5owWGuZ4PTaP8elBYehdq0MjJmZcWHQFvVSE+2kmtjbggEy/pu3Kv+dfahNF7+s/gOkaZAKp6Oxn3BdXk+f8E2dkp/+HlA771bX26C0MZUDiot9n9zOB7sDLtfVw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Enwybw+u; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Enwybw+u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grh9Z1Jpjz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 01:48:01 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmJOn3JmeRQsC8HF1xNByrVSOpBUilYRMaG/YwkuJMnKPIvA+2hb/3P8u4poCgIgJhyU7GPS+fzky0HEcr9j/gXcv+Ql+Ar/VH2Fqx0DvVlkKqOWtZ5OYABX00Sv7bWNi5d9+JrX4HKAa4SMrHa3fjSogcNF4I/SznjS8P3PoHuhqK7GdFyi7l2J0jtx2kXzHXH8pcxhalkvWF2PlYVfAqMpeIRC0M3bHh4k+vEiUPpcGirjPSAkEMZWq7BQuOecaukV0YBCe2FJfkg6dXKIDbugPkE8Uu2XnYSYRMCXrTidLuPMyE3Vgvsk/K5h51hs68AsuHLyVk614rczUv8ULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yav8utETY6FCguycHYwbLXHTThtCgsZ4dGDEa+HsUy8=;
 b=lRxgKwrCuzqW/gXUP1A2Cs6wt5AP7zM9qSJEZ1QWEN0Es1b7X/qQhSXu/JkyLBx5NcCMUigXD8GS684frVi/eaZKDlbcAUcY8Yf9YbkO1EALKWQJs5gJo6pD30jT+jhZGStieBlXOoQZwpv1Lyh9qe9k6Y35Eq72g//pJtt/tfYQ0gMLzeS/3h52zl+l5kz4p6Gxx6N6vqByJkgK8U6smYQI7RObS2PnF59DlzGkZ7xWt8eyID088+s5uDJplVTj6OkYnrwPL6ClFVpyxp42FDVWFxU+mZICd7rUNfJtmo6L/KFa3yVZyruP0YMpwe3k2c7XmMqW4Tea7pUalLcYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yav8utETY6FCguycHYwbLXHTThtCgsZ4dGDEa+HsUy8=;
 b=Enwybw+ukrZW2qqCkf1pT9+VICe25xMtyogS1V/QBvyxKfla4Xc5qhwZIeWlxAA1WJ1Hx3a2GdF/kWzQJ/aWz88RBCwjaKnhvzZJ9h9UEVBFoq9G0ZjaW3LTNtflqSQIMYeomisdZmrZ6eSptjt5/6lO9GXHhBrLNCV+tvWw0MLFexsldfqUUe7ky8KrrKjmTwUb4ZsdkrjD+Zn8JgEYcpxicXzN3olJ306PMPCd9NvOp9BVzM9Zy0ECs++QjRyzwuI1HwRKXMZvs1AehR7qgn5vPWNT6q88zWr4Z87k8OkWyc3l4I5zYsd9wQyiEtmUeqnZVI3yyepveY35luZHig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 15:47:33 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 15:47:32 +0000
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
Subject: [PATCH v2 01/11] arm: Use sysfs_emit() for cpumask show callbacks
Date: Thu,  2 Jul 2026 11:47:14 -0400
Message-ID: <20260702154725.185376-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154725.185376-1-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:a03:338::15) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: 440f6ad7-f5c5-46e3-988c-08ded8513ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	VmEUz1Sd9M7XuTvK9fJBWw4q/kt1h+pfSABZ5ksrR2QSqa8vuGfkpIO8qqAAcSDpOukKCc/rL2Y7xA6bJqeF//6OtZWn/NYZJ5hgsZzuiZGc2elpBiIu/PpEwrtgSHVROCbIaHw0IwqlAgFOnQKXcBvW8UQ6zBJ4MIjqW4/bMKeSiMHYeqK2EhgXpka/m/i9lfCxolU/aSc3gqZjUgjb4Vzo9mm9mhthBxUJAO4fUvTSJuOkgT+Vms7eJLC14BF+T8jf0EbeCI9hPaJMKNRZLZ1iXYEsjeEys75OdEP8NXCvaPf8At74r8H6irntCbLwkpcgSOztptwJPeNo6Owbqm1YQMmn9vTdulKW4k02eVGNs9n3T1/DP8t4myiF9NnVLxCSQcCMiL2OfHh5AhKhJi74jwL4LwDVcqDO3P0hJ97c4aek5VxZqinVS74as9Vh73DhyYWmqhOgBGDQNtCphyU/B4gZ3nmMvLs+4rHEQguZnr/D6+aNiEI/hSLRM+StMt64syVsJ8wnMmuXaiqNvDjuiTITXgsj0rQKVicFHqVTsyFYngRSQY0GSDFCdpf3GvFCxCnneJ1FnvtEgPUQf1SL5+hawA+1Evi6SRTWPoaHmhY078mctz3QC14h/O6D+CCyLHFYkK4gi4vMkOyY8NOuSdgygqtcnR34AU9uPes=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q9ssySRqt3T0m20/GJbiQV97dHwFge9ZZk9XSBw29YQWueXvRtwhDRkk7uU/?=
 =?us-ascii?Q?OQpSDBOPLBZuoxig/1c6ioWQCKIPehXjVguMROT6O7b5j1ALAGGNec7QTq57?=
 =?us-ascii?Q?nHOiye5taj1CK+zGGSoTJTdtWmUUrS6/oZrR3indGKqCVl8qbDP3BaOZsjhr?=
 =?us-ascii?Q?HSgRP1jQ4N4NeGC1ls8zPQsYt5Og6vQ56QO2d4s3D/r2w0ELVyK8C5JHasRJ?=
 =?us-ascii?Q?oWc7yC9EVK4VXlysgzIPxYoxkbDvF2PCDTD+Jj39HpJAzR89RJzdWi+0cE1P?=
 =?us-ascii?Q?mgX1pOVe5PrLR8td/1cyTICwuMMQI4EqA1PQ9c7v5Gmh2iMeVNiz/MI9ynKA?=
 =?us-ascii?Q?fDUNkKj+s+Ot/SIl2OXo0vZOPK5rq1XnRxcLnQ9xeCOI3lIHgqhPDB8i0CHA?=
 =?us-ascii?Q?qE5ZqIFFouXhZ1qA6V8Wl516zV32rLJJsu6Js12sfidakY9nRp6Po3DG5MGa?=
 =?us-ascii?Q?z0LkkpmZn/A06f/xzlBfN87wkDmPuOG+/FJ4U4j1niojulHE7TY8et52y9/j?=
 =?us-ascii?Q?f7xXI8JpbUn9R7QhXMQwqlTtLVZmApbR13xIaJmfi8kaR9fFu5DvGn+Y4yS5?=
 =?us-ascii?Q?2gtEfW8CCVDecm/72w6+IIxmuzfFjPcJoUxAETlzkvB+ak+gnSGz/VjKM90Q?=
 =?us-ascii?Q?cUHO9ZBjCUre3C8mDArS1cdgOzqbO+gJWzL1snV04LMLzYMez5tloyOWjO1p?=
 =?us-ascii?Q?qbtN64zvZP96qGO4zPFBZXR9MSUr1pre8sHIuIzCl5CpDCEjP9kFI+PkcMtv?=
 =?us-ascii?Q?wnr+m2wlyITuh3fi3mzHhcvEPa4n58GOXMddCGHlhoL28gtA9lN91G15Ehwf?=
 =?us-ascii?Q?3gpXOFFDdeNOnb6d6enB/8NNlXdLuOCZERjyQSYvXvd3rnEiYiVpcUBL1doo?=
 =?us-ascii?Q?ivVJ/n+ebdf3ukmddtOtnroprUSkpklZWdiKrsacx0ncwABuNVOBeYuC1yhc?=
 =?us-ascii?Q?EGcx3KgOqtPefW8tm+SsVB7sbL1MbTWCVp5fvxx3e0HQ4m6QsdhiEwDhVBnH?=
 =?us-ascii?Q?5UqCoTdR8tKnRPsI7EsT9LaaWeo+dt66C8XVc2KZq1mBVXZlDmlWXFylDxy1?=
 =?us-ascii?Q?Dw+CNWLhkzeHWEQg0y7wroODiPiR1QSb7Yoej5oh84IM/IUHHjxCDGuTNlGR?=
 =?us-ascii?Q?59oy5HVPIGqc0r9OCk7YXTetptcqTjZ4q+RM6HpX5ciw48qSgSZWWNSry1Z8?=
 =?us-ascii?Q?B6bV2FoBK/dbIxpytgWv1lR68sjTCt6T7Ek+27dVQtJ0JyqtVP0VxBMjEAHX?=
 =?us-ascii?Q?sk7tAvKih57pOSXLQ3jZZNRoi/P5hH3dAVp7R/bLzVor0JxnPwAPknItaQEu?=
 =?us-ascii?Q?9W5ocz8TkV9c72VBgb1Vcgi+8wfBHnfHZMoghxctqE6ZfIDPn+sGr1Ltvj76?=
 =?us-ascii?Q?hkptFI78c1nN4ftAy5JOOFAxNnZ1VK9VL6kuz+l8TEtclliHqvMbuOIrHxR1?=
 =?us-ascii?Q?1bkbs04pqn37U2+HUh53Bjm3p6UqV1Hy1p5KKVz//LzLm/kOwrhjAkB6I/tr?=
 =?us-ascii?Q?NcNamYv0jp2DvAuz7Kl2+AtYjO8PQQhfCO2tvdeom2gUPOux1z9eNeeP/e4A?=
 =?us-ascii?Q?8Kh4PdMEBNHOVJVt9NIbEEi4HcY0ydwvGhgf5c8hXzUdblJWxgIPn1Zv9f8+?=
 =?us-ascii?Q?d7C+RSU0i5ZPI1JDW7peE0bOmBkpWmEFSVmZ8C++JC1h00uuHbPdbJhituTY?=
 =?us-ascii?Q?RdfRK2p8ic8o4d3vr4JFi5UIMN/BbGC8Cy4vYWveqAJ7jiw9kjIL9GrE2Y+s?=
 =?us-ascii?Q?0xDHsIt/IA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440f6ad7-f5c5-46e3-988c-08ded8513ae9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:47:32.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DqfVf0hEYzxYMyvMm4/CmIayjA5KfL6epsC3dlKmoatU2vh1t2ceOprYSI+HYVZ3elTQYQMAOh1uCv9cfDFP0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471

These callbacks are sysfs show paths.

Use sysfs_emit() and cpumask_pr_args() to emit the masks.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 arch/arm/mach-imx/mmdc.c     | 2 +-
 arch/arm/mm/cache-l2x0-pmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index b71467c48b87..f6d993b9b1d4 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -127,7 +127,7 @@ static ssize_t mmdc_pmu_cpumask_show(struct device *dev,
 {
 	struct mmdc_pmu *pmu_mmdc = dev_get_drvdata(dev);
 
-	return cpumap_print_to_pagebuf(true, buf, &pmu_mmdc->cpu);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&pmu_mmdc->cpu));
 }
 
 static struct device_attribute mmdc_pmu_cpumask_attr =
diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index 3d9caf7464bf..478227078837 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -390,7 +390,7 @@ static struct attribute_group l2x0_pmu_event_attrs_group = {
 static ssize_t l2x0_pmu_cpumask_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &pmu_cpu);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&pmu_cpu));
 }
 
 static struct device_attribute l2x0_pmu_cpumask_attr =
-- 
2.53.0


