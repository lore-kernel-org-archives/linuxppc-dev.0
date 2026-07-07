Return-Path: <linuxppc-dev+bounces-23728-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC403C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 18:43:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvqqS1gngz2xpn;
	Wed, 08 Jul 2026 04:43:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783449796;
	cv=pass; b=Cmfr0w+tFCTAOugp9uzAaaE4inh88zYrgEQmih44VKyPM46G9bXfuNGhknplgkUGXUEwxQQIF86at+8ixlx6jXKCCIw0okKdF1YsnwnSD04wWdKWy/0BgRXAQBFA7zmk+ZV+mXV/gInNI7MFttRdDhjpxrkScg4uBb6D9BSc/fkdZuR0DgaVA/BfAMwV+76jGETF8K42UUw+5SCWcmi2iJF2fCaXrbWuRiwEhbwz3CEhS4JEzCC0jC+ZKao0AKBBhsgQFYZr1wvEc8x3wnMGWArcwuuclUoh5iz9pdv8umWVGdnNHY6iA/pVevkK3ih1Y/x1UpsA/g8kz/IJ3j8dYA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783449796; c=relaxed/relaxed;
	bh=8IIIY9pm8QsmrcsmVwRwM6OzE1/6nUvrPB27JfGzzx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c/kccIa3SRT6C4LRiQscD+7ucuSycsXQ5G9AuIBoR1W224xNSzSdEznp2zV571Hs+THt+ZJOe/TcJrn2pJE+6oEsupdCggUGheCyoeuPjrW7vIlQ+l4QsrodVQoqyFBqw4aXzyct2ta7A2t+fGNZBqhwYZQ32NxRv5X+ZVY0koNRbBCl5K8aNHvaM5zTHxILeDFXXF5+YdpTNqWwSMjiI8CXuXqkFAaBFYIvvzI8dWstoAG7PdTi3QNCIjD7f2gxoNiDZuQFJlCRrNEgsJ5Uc/z4+42/Q2yviyEuLRm5DRpJN6vYReYpSozaEzup6tA91vxnE4V8nZB9/LsII6k0hA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Hfvhbpny; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::9; helo=ph7pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Hfvhbpny;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::9; helo=ph7pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170100009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvqqP6q9cz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 04:43:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmTJ31Ct0+CUX97U2ZHkeLIC67kfdPmYljzcXQ24Eq72xGvEkrOtI5yYaSIcjiHbryxlfnUFDud1qPikhfgpVu7Asg8LGw6knYwEEg8Pzom6XlH2ceskkAzSLH5v3jrQgg1s5Bgw9tLFp35yTot6FPpxBIsmAVDepUo5ctsL7Mpjyk6F+GpBBjPrzOXEFL2SEDinpGyeriMRCNOLviJd4eBw68XjXDp66QBz61anrl2L/iRh8/Oczp02fWDutLzbS9XCtt+fJaxqMCAmxj0fvuCs26sgk6TWHspLoc+BfOtL6aQIKtE4MRkL/+VcecqPeXQzlNngHSPngoouWm//VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IIIY9pm8QsmrcsmVwRwM6OzE1/6nUvrPB27JfGzzx8=;
 b=iylyzlrc4c/wmEyxxb8Osn2/wtpafvvsCC4yT1r+wG5zsQPF2wh6HkBkM9OAJhlxz5LPDzMOPMANYrEm5CQOTvDQVIaEno6XoyquLlVFPZQ0sKLMU5bdvXvr5k687h1vgKzr38U8ahF7YdhKA4hch8SCEm9v40FJU7pggxGWvZK2DYop7sNI2X3rIOiiP61cxO08Xr6Hf5rfJS1OEPGA4klO21Ti/wFJPTXP5hCOjlBmxZc2ma+GNnyo5mxFbv1/5UG3Lpd8z94APxmJMd2e97c9CUaE2B15/y5aIw8wwm2H3Y/RCHSG7ucBIUVVdII3cgRRH6pUvQHMZOErMp/1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IIIY9pm8QsmrcsmVwRwM6OzE1/6nUvrPB27JfGzzx8=;
 b=HfvhbpnyNLIK283FnMtZc11O7Q568YHI2HJyZywHF4FZU91KTHyI2dejIn4X+I9JA0QOZ1fyNOXLr8M+FaY+TmLhGnWcHkyhFkwpuW/CyplekBCXy89HNQz5i8E2jFXPBGnH2CL+9yxvK+UZzphQILbyhnWGqJhz25pPkmovuxLYedWY4hGNNS38+MTND4n+SDLSE9jlb1mWPaaW3JRd9rE6Ktgyn1r1VDMA+DbC/cbvH/w5wLRTKe07lZqN+gmMSfyPykUWyrnbNf7xs5O/41MRn7c2owKJQ65zXETneeefJHbqrGoS8cg3ppgxh744YDa2DfvuTqIZpAHOP8QdyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 18:42:32 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 18:42:32 +0000
Date: Tue, 7 Jul 2026 14:42:30 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>,
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
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
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
	Xu Yang <xu.yang_2@nxp.com>, Linu Cherian <lcherian@marvell.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
	Chengwen Feng <fengchengwen@huawei.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Yushan Wang <wangyushan12@huawei.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org, x86@kernel.org,
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-fpga@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-cxl@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 00/11] lib/cpumask: get rid of
 cpumap_print_to_pagebuf()
Message-ID: <ak1IltLSvhw2xj2H@yury>
References: <20260702154725.185376-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702154725.185376-1-ynorov@nvidia.com>
X-ClientProxiedBy: CH0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:610:b3::12) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: a9fe8075-5163-4391-bea2-08dedc578130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	NxpmzHpLRHbkpQwIcSIbqnmUt1oSohXxde2OGgxei0cGQUG0PntrEJZuhETYGiDkfQkSrhL90K9iaUdXgb7Lmvk0FpHYsDiYegAwjmh2PYkgS0paPwYWxovWF3etkfsvgC575c2uC1+AbSZpPyGFkKmHBp+8heQlQk+XM0m8V/Q4U0R/3OJt7VTQOFdWp9d7ZJe0EBl6gk6QsSA9C2TMr0mzQtt7Ct6iOa15KPkm1Y0/ZqfWFdmqyokl4lUlN2Fk6oODKPoNdEE4lvVcTRkb0GrkPs/TgpabINay7QUgayipdxmKGlRlA9m5FAxHlC1sJi04lllmjuBKXH5wU2Qyhi1rhUWcMYHj03k1IAFTkf+HmnbfatkjtlJ3EjjOApqrTtFDB77Ooj+AZwuVgQiSWM7xnri+o50Qgk4F8z/U2ph2aKq5avzKyscbhLgQOZVTYlmBjD0eC5EuMoSWXycvW02femTwdL/v3wOTei+1H+kd44iQGMmrm4nM/vjs9Nzs1WDDMsKgnl0x+gonK8YTnZ+BXD4Bo5ugM8PSFWQYWvd97C/o/ZTyHhYg+WlMUQW5J+IkC7GufPiM7MTS1v9rbnH7Cb0c0iKYBTDQQnvZJi/PWnUGIWIAZuMzaC8jdKZvjM79sihzbWiN9syqiR7IFhfSyz0F0uFXoKUMrRPYM6U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SiQzI8ohKs62x9Az4vlIly7jtkeb1zq7fA+N8Y4QXsU61R7rOL2lPYxQZrJV?=
 =?us-ascii?Q?jP7N+OUGHezZWOqNG/LoH5SUHQzpeU3DN2iv01A5qCWtqxiGFrUdkP/WVTYY?=
 =?us-ascii?Q?ag86fU/SBiF26PIDjxOXkIVIkOJYXWeSE/+U8dUBQHXI38pTnU3cLgtR5k3a?=
 =?us-ascii?Q?TMDzZ5ajUwGstujZN4hJi+nGZlMJEfmPUHGHl4Ug8FNXlkisEhdIO2IqDJLl?=
 =?us-ascii?Q?WAU8x41BDPDuwLYkSn3tKoWz94Rq7eBA/+kx3cMg8AQXhvIaxDpq+BbbEyLD?=
 =?us-ascii?Q?WyXKA0Bg1L/ob8eaQiAp07uaxAzOaEKWPXHEb4y93BXynfLoR4lV4maDG0RT?=
 =?us-ascii?Q?FMCiiZrmoJr5seo0du/jwMovnBkeer4TV8WCj4xcMKR9YkgOP/t2NN97u7x9?=
 =?us-ascii?Q?wtKEIKN3Exs79ezHOg8haKhW7f5JcCmi+Jr60sYIbJCeRaF4TKnQi2NZgrcQ?=
 =?us-ascii?Q?mbU86xNacK2UJ4u5QriD33CiMjlgwbd9/ZqSgdg0Xfz6wK6r8mlhYx2mdEYQ?=
 =?us-ascii?Q?e8NV3+VcqyPrqTzlOKpHONruyACX5W6UNaBUNCnGfpj4RVETdhU4FwKq/l7E?=
 =?us-ascii?Q?HizgZWA87T+4saJQ1OHCw0zy7xo9QAoprQUxOkZj/x8zlYsa8olqBooTThug?=
 =?us-ascii?Q?XtXTolV/G6yN0dhX9idQ/qb9pJVV4+YYcUhXldKPUNZxo6sR6PAenoS4UkMR?=
 =?us-ascii?Q?qvGypU0jO1wGKVOkQI75LusZ6WvOrQqrGJjxbzktl7Bzcb3+UCq7W4YMI8Tn?=
 =?us-ascii?Q?+0SCpqUjGVWeQJH5a/0jTuxeG1TGJzJAcnC5Dl0TU4BIB7Njy/A3BX8YXH/R?=
 =?us-ascii?Q?WcusWrkSKkU4CxJICvLYbUrCEOwfyLG5gMMBsz75Wa7vKmWMRoJ/HajiSwDt?=
 =?us-ascii?Q?sLWXsO20+oAFm3BQg7ewE5Ugc8OAGL00DBfH3Nw0JefnNNwCW3PThWs/Wwer?=
 =?us-ascii?Q?eWEo3cnHdPCm0KVOxcjfk3ICWg7aRFT1ULay1y4c4L5vZyxr2ltI8d/hp1lW?=
 =?us-ascii?Q?HIoa65wmbpVUmFT6DggUgCq6iuyks3jl7nJ0xkRRIrsZ3sDVLSdf/I4tXemx?=
 =?us-ascii?Q?SLwRekoK0bn9gx6cQFVQ6XZV0xuMDVSdZYfaMwjAbp2KtxjJMGenE/hi6T2D?=
 =?us-ascii?Q?Dp3wF5Rm01fFzulYcl0r8IvrQm2ip7ZazotHt/zQ4UZ2JVgJZYmK4IHgBVh/?=
 =?us-ascii?Q?BBUeK+5nJrCyfYxUsF35C8Itc7M4cH4QiICtKk9lNVxIc2Q4JqODoKdMdtDB?=
 =?us-ascii?Q?hpfmREYiRPwHE1T+2dmMWX7WCGcfXNCKvFLv2tMRWiVPIINgd4b66QYUPQUY?=
 =?us-ascii?Q?dWXcDUfKkC5TyFXUdYLt2vX/72zJS6qJP/ZfuVxMn9MJHYtHrNID0W2fVu9S?=
 =?us-ascii?Q?gALekxfX/Y6MVNjd0sdzCajc7HIFptn3zGIUeB4Qh4JIB8q2o5lwBLu/a1yc?=
 =?us-ascii?Q?7KGU+O8XVRe0gMr5V1lctB/X9rDPIaRlKdYjyP/+stqcqdnWHE4diBFIgR7D?=
 =?us-ascii?Q?TevUlbhUhTGr1Dk4bAUoWJB91OS+m9yM5lE3sIjZ9d3eRlkjsPdomyWKViYr?=
 =?us-ascii?Q?gjjLcSVlh6It5NIVUojhSIgRw7rKXIfUpDN1R7WYShiCww6NVRlD+h63FQlO?=
 =?us-ascii?Q?7BPZLNOTGSDFbZ4G6/lgY2dIqJnIX85aJwFrns6W8Bq2TEISe+AOc0Ge38Tz?=
 =?us-ascii?Q?GTq5lrSUyvCAF+HoUWUAk2uh8pytRVQ5bMGCvLEP4IDtgX5B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fe8075-5163-4391-bea2-08dedc578130
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 18:42:32.3185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJ94FGIl5fGyIsMqJde9xM/7YwLuqHPmfqSuXko5YdDmTTaQuMcbWQZX6PT8XmAvMMaaqUt/VzshdNwEyjxqQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281

Added in bitmap-for-next. Thanks.

On Thu, Jul 02, 2026 at 11:47:13AM -0400, Yury Norov wrote:
> cpumap_print_to_pagebuf() is the equivalent for the "&*pb[l]" notation
> in printk-like functions. In some cases, it makes people to create
> temporary buffers for the printed cpumasks, where it can be avoided.
> 
> Get rid of it in a favor of more standard printing API.
> 
> Each patch, except for the last one, is independent and may be moved with
> the corresponding subsystem. Or I can take it in bitmap-for-next, at
> maintainers' discretion.
> 
> On top of -next.
> 
> This is the resend of:
> 
> https://lore.kernel.org/all/20260528183625.870813-1-ynorov@nvidia.com/
> 
> Except the patches merged in 7.1 cycle. I'm going to apply the material
> in 7.2 unless explicit NAKs received.
> 
> Yury Norov (11):
>   arm: Use sysfs_emit() for cpumask show callbacks
>   powerpc: Use sysfs_emit() for cpumask show callbacks
>   x86/events: Use sysfs_emit() for cpumask show callbacks
>   cpu: Use sysfs_emit() for cpumask show callback
>   devfreq: Use sysfs_emit() for cpumask show callbacks
>   fpga: dfl-fme-perf: Use sysfs_emit() for cpumask show
>   hwtracing: hisi_ptt: Use sysfs_emit() for cpumask show
>   RDMA/hfi1: Use sysfs_emit() for cpumask show helper
>   PCI/sysfs: Use sysfs_emit() for cpumask show callbacks
>   perf: Use sysfs_emit() for cpumask show callbacks
>   lib/bitmap-str: get rid of cpumap_print_to_pagebuf()
> 
>  arch/arm/mach-imx/mmdc.c                    |  2 +-
>  arch/arm/mm/cache-l2x0-pmu.c                |  2 +-
>  arch/powerpc/kernel/cacheinfo.c             |  3 ++-
>  arch/powerpc/perf/hv-24x7.c                 |  2 +-
>  arch/powerpc/perf/hv-gpci.c                 |  2 +-
>  arch/powerpc/perf/imc-pmu.c                 |  2 +-
>  arch/x86/events/amd/iommu.c                 |  2 +-
>  arch/x86/events/amd/power.c                 |  2 +-
>  arch/x86/events/amd/uncore.c                |  2 +-
>  arch/x86/events/intel/core.c                |  2 +-
>  arch/x86/events/intel/uncore.c              |  2 +-
>  drivers/base/cpu.c                          |  2 +-
>  drivers/devfreq/event/rockchip-dfi.c        |  2 +-
>  drivers/devfreq/hisi_uncore_freq.c          |  2 +-
>  drivers/fpga/dfl-fme-perf.c                 |  2 +-
>  drivers/hwtracing/ptt/hisi_ptt.c            |  2 +-
>  drivers/infiniband/hw/hfi1/sdma.c           |  3 ++-
>  drivers/pci/pci-sysfs.c                     |  7 ++++---
>  drivers/perf/alibaba_uncore_drw_pmu.c       |  2 +-
>  drivers/perf/amlogic/meson_ddr_pmu_core.c   |  2 +-
>  drivers/perf/arm-cci.c                      |  2 +-
>  drivers/perf/arm-ccn.c                      |  2 +-
>  drivers/perf/arm-cmn.c                      |  2 +-
>  drivers/perf/arm-ni.c                       |  2 +-
>  drivers/perf/arm_cspmu/arm_cspmu.c          |  2 +-
>  drivers/perf/arm_dmc620_pmu.c               |  4 ++--
>  drivers/perf/arm_dsu_pmu.c                  |  2 +-
>  drivers/perf/arm_pmu.c                      |  2 +-
>  drivers/perf/arm_smmuv3_pmu.c               |  2 +-
>  drivers/perf/arm_spe_pmu.c                  |  2 +-
>  drivers/perf/cxl_pmu.c                      |  2 +-
>  drivers/perf/dwc_pcie_pmu.c                 |  2 +-
>  drivers/perf/fsl_imx8_ddr_perf.c            |  2 +-
>  drivers/perf/fsl_imx9_ddr_perf.c            |  2 +-
>  drivers/perf/fujitsu_uncore_pmu.c           |  2 +-
>  drivers/perf/hisilicon/hisi_pcie_pmu.c      |  2 +-
>  drivers/perf/hisilicon/hisi_uncore_pmu.c    |  2 +-
>  drivers/perf/marvell_cn10k_ddr_pmu.c        |  2 +-
>  drivers/perf/marvell_cn10k_tad_pmu.c        |  2 +-
>  drivers/perf/marvell_pem_pmu.c              |  2 +-
>  drivers/perf/nvidia_t410_c2c_pmu.c          |  2 +-
>  drivers/perf/nvidia_t410_cmem_latency_pmu.c |  2 +-
>  drivers/perf/qcom_l2_pmu.c                  |  2 +-
>  drivers/perf/qcom_l3_pmu.c                  |  2 +-
>  drivers/perf/starfive_starlink_pmu.c        |  2 +-
>  drivers/perf/thunderx2_pmu.c                |  2 +-
>  drivers/perf/xgene_pmu.c                    |  2 +-
>  include/linux/cpumask.h                     | 19 -------------------
>  kernel/events/core.c                        |  2 +-
>  lib/bitmap-str.c                            |  9 ++++-----
>  50 files changed, 58 insertions(+), 75 deletions(-)
> 
> -- 
> 2.53.0

