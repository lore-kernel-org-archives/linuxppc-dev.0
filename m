Return-Path: <linuxppc-dev+bounces-27289-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3A3C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 03:15:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkRvz1jS1z2ylm;
	Tue, 15 Sep 2026 13:14:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c000::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789442095;
	cv=pass; b=E19JZd47lgAdCGKWebTjzbEL8XgOGtU0M6gLics1d6MBeBCUyHARcUjrZnPetW2/iazYfEmIRgH13T7lqBqAaJ4iEgpu9ykS2gn+D2EX/AgPNq0ocXJIkFb9FY0M814xc8lhjzhayR1ZaECYDYS2+HRucz1WxK+qjo5PjJU8iV/o2HwO0gAT3sTf/Egf0NigwLPNXByYi2fUQI1Sew5aMx1n5dKh2O2U33uNdsY1L/Yd+n+bWxzX04u2VmOBkiCeLtrydpxuIEfz7jFwIFUQE6w0cD1q+ae8EUVQrGOxCsvL22NxBlWmgb95Xq2WXqtnOllA+wDpUaUskX6BaPaJbg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789442095; c=relaxed/relaxed;
	bh=FLlM/fs18Ew1p4SDbaG7B5TPIvAP6a1EQ5gO3YVRWLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ehnCt/ctp7PIHJAouRLq1gzjiqorHuy9Qp2Ke0elkhrgyHgpgnZxAKVYJ9nnabxssGd5i55gU/KANXEGMdYe6hw+1C2GDJUjsI5lb/0sb/S/CpjgVVTWZ99n1mVO22UWAe537D61jHkaF3KJYJ5jzv7o9duHLLylgx+Be4YASFvbE0hA70d4NQvGRJZgtt4m0dH2aHNOit1VoUPJzW6de88GZAvZ2KBgkbGUEZjepXrEwMDCJelD83byq3hghe40hFt9MM/W/5RLj0SWPxO+Ot0g10Mxa62HeaEfZNKCC+k8KqhXV4fd5nl4JZ72N7Orak+EUwPr1BsCDQJvkl/kyw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZUOifBcs; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZUOifBcs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkRvy4KQhz2yln
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 13:14:54 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6GmgkI4miVFrniamzA1iIhpYlud79z0jAMZ3+b7rOMUDW6StLlaPGZ4hEw5q7qBgkQx5PUUkcYecL3Iwi/H9FTt+0y7qd8lJIvR/X2bvx8aKaawFBGUAeAiyIcxqY59F0ZV6X7n/TdrjKll1V/pUxFUxqskOqPHXxgjSl4VE5Z4GKFtcnBqnf+Tk2G4q3vKnCHVV5wCuDTuP1VoseYGYrJBqLtv/NFWAQFHfqsBfkHMBnsjQ6tz6h0G85x56FGSr0iYp3G59HSxHbf2GGqD5ma2xhHK1egU1FIT8zK+dI18T+hFBqFSrZM73FJ7UKBbyKe86dpz1CiS9EenSkBC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLlM/fs18Ew1p4SDbaG7B5TPIvAP6a1EQ5gO3YVRWLo=;
 b=BPA34QoYe1CO7qmA+NwPKxJs6rlV3Jtl0FmfSqewoXbMHmKCSIUiADQhAnDJfOj7nLyYGbDz6y7OkqkAQKloEfeO7+3ADWnBTwPH7eTR2w6T0cViBVPNWH9vgKYoXYtuIC6SBIhW4VJSPw6MgaISCtCZzLho4mO7CUbpJigbBM3607YC5J/jRdQwDx9SP3EuAQIUcoq6ME3Yr103klmQmIkSlG590cQx9WRqkrbkkOr8FHeVH3bM10XtmywAaHAbKzRhSB2jsT9ERlEdWkcMEHXgPi2KrAaKK2jN5L9/q4IuPvIKqdIuGy/vB2Egm/IJlh7ty4XbRJwlbQRy1MsUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLlM/fs18Ew1p4SDbaG7B5TPIvAP6a1EQ5gO3YVRWLo=;
 b=ZUOifBcsBqQwPXEKi7GOLtBQ99Xcy8k1LCFbFukx61gmUzUbm0Bs0TGd1Kz4a2shopcmrZbdHM3T8KbvDp6geYbsp0fzzi1q+sDl7PSzFv16fUQaRic4h0r35S2u6ffnlOhG6hR9kCELXlNvAyhp1X/VlSCy1yaBMD0YcD6ZafvbJVyqwvM6rjizdb0O3w0FBoyBBvIzXRI+u9ThNV09d2k5jJ131KzfZsPOUVkclOID8Xl8QZVNfQZBBz/KuqQZ8kaOMss8mbf4vUX9MCjV2Pj63R2NXEI5vwsiGm0OTGCjXZ4JcVk5IjHJeZHkQgRhHN3bF0yct0Ou+vFlRwn00g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:14:27 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 03:14:27 +0000
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
Subject: [PATCH 17/17] sysctl: assert static storage for DEFINE_CTL_TABLE_POLL()
Date: Mon, 14 Sep 2026 23:13:32 -0400
Message-ID: <20260915031334.1194975-12-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915030336.1192299-1-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:208:23d::21) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 6daf2da6-a7e7-4b95-017a-08df12d77363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Qo1j+AvdrQ3T8IqkSwOQqtnDz3rnUfofGKb1knJaHaz/RgqNvQvXcIOY+hEpnzirJCYMyhopAu9TmRLvJPGsMOUT2+83qwSgJ3o3wNKmj3nfASNYTf+C01GKrREURVCXNdJLOlfIksRdnuE3S0LjjMIFEhpMahWnIX2BmlnsJ9cNNj0KYDPQtJ6z9KkKt3PR1WthSa8JRjl4lWyPB9zBaNeqOuCFB+NPr06pEfECsQIR7A847a37ho7tCK0R5CHppntgTp2r7t6f4BzAwm0NSwgpjdl17bf9/7a6UzSpybqxSjPHmTX6Ya41POOgEvlpJw5FEfuiMJYr4b6WiEEMP751xT1qSpLeZO/204qTZzPQsoBOnYy6zEnKYQnOzx2WtTA1kFMy1+fbYEH/ZvSKlhrnBNpUF+IoFFIw+06Uq5nEGOA4KGsxxbIZIFkx5Es9njWcPm6lkehEOOSfXlQhO4LasYnN79xZhbwGF2NmodcnORuaRlHgU2l0KApsrRnc4ui3wJHIdrbrLNRZOJTqXK4fLBYzzoRyXddPbVlXD2USpbd0jLDc6E5U50Edd2UHxat6jqghyecNZfRyI5Mu7NRh/eiFtP+BCDCb0hzOig4E1Ikm5Tl1PM5JafmGz43h2Aqrl1lseWD/DRgn5I5b+Te7le4VuLo0Wah94LNUJVM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5l1zSSIkIJQQkj4Yh9ogsri8II2nXbR7+dyn2Gl5uewrZI6MLu+UCIvt3Svs?=
 =?us-ascii?Q?77g/6flqiqsDUJjaYltjg0lWZnf/A64cImkviNpMQqVTwZU/ugLcBJo9si51?=
 =?us-ascii?Q?VZ2oI+UugFzPzef3Jes7oVZ8sVHwt/lcvvXpsAO/T//8f+99eKoV+WceZDRk?=
 =?us-ascii?Q?s/PHjOX+awh1cWzqeaSYwmo+qeOtP3cyBMK7KpPU6F14x/sdbUbL87TNwbbD?=
 =?us-ascii?Q?NEfVkOJylQAn9iJWU/cVTRwRY0NH+dlmYv+K9A6VDGF+yPAnfp4R2JbEr8yX?=
 =?us-ascii?Q?8mZ9rUNxGHf/TW6mvhT+KA4/LjPfVVmFKJm1SwAJWR6hef5p+seLr8pJOwPJ?=
 =?us-ascii?Q?Kq94uUq7mAvJN1bHLcrhLPTXMzp2JmcMRdGKrfyiVR0hkBuAfBjhvFS49Hp2?=
 =?us-ascii?Q?cePN0LUr/7Gt651bQ/H1S6eab7I8OZdcM59FtDN66xo+R4A416/OzzhVRTGE?=
 =?us-ascii?Q?EnKTYzXZ0IvK1PXTChT3hM1FPQtJmwx74ZKjjUUJS57VDmVj/nJ/VvstShAP?=
 =?us-ascii?Q?K0c1C7e7OFdF/Hp8V74Lbkt10HrYrfhVHV8W6dqwBUDSe7UXuyxqDSp3v+eD?=
 =?us-ascii?Q?zRzQm+WhHT3oh4aKiY2m4vp0BiEKpZ+fsYVYllNsEqPOSMC9CalaVil8oveD?=
 =?us-ascii?Q?yldQm19Dtu4vXwH8MxPLjmdT5BUpSS4b3ZtwYKvfnG8hUodkIpRsHavdWEV5?=
 =?us-ascii?Q?k2DQIQ/B8M31LGn6/SWPqZFNhrL6qEpGABIg2CbcKZwBo0o3zGnuuAiU+Fu/?=
 =?us-ascii?Q?a4+5oeyoQPGg1FuB9WO9IHmkIbPW5mKXKzfgNc4MzXhv9DU5CrRGaPlp7T5B?=
 =?us-ascii?Q?gv6VWFGeXdE7M89bCaUZy+OB7/Q2VvBwAW2HOq3IeH/3KPJ5/tLMFRlOTQhR?=
 =?us-ascii?Q?hUd3ka4CG/v9nfSN0NmNVXeYCbcrPxcjjeeArk+8SNvhffIgTKPxjvj2aTpq?=
 =?us-ascii?Q?lDcYQMRKNBTUt/8fOIJZIqqHwbtp2sZTq8otYn6c3gjf6zkRyOqTTUfHDf7a?=
 =?us-ascii?Q?BZdxOUDf4yeg1eXsFzBgvBqgpXohZQVCZFRYksmrwt4gkp59LACSNWbXQeNV?=
 =?us-ascii?Q?VvRwh6UMZxg9e2o23ySzZqYZnOH5cqZUNpOkxMG3E2dOG1tv4oWebe84B0iT?=
 =?us-ascii?Q?j7AmRrNObK0owP/4mWXd9MWpR24mgI9zNeTQLBPjMx2kJxETOLBpA2jTt8bp?=
 =?us-ascii?Q?Pxz0SIJeUU1DmL3qaZ/xhp2HG0Vdy7fgsja3v2D9y77NDWRZ21eO+3/PywPL?=
 =?us-ascii?Q?sKz6GEEuOMwmSDQ8ZByWKHSM3bjAdIsca3L4L7u1paRKz5LTVCfX84cDVj9v?=
 =?us-ascii?Q?xoUaVMBFmYvv8DvV15+MjIE4ueiROabe6I11wYBRrrYAnlgtRBklmgfvycWq?=
 =?us-ascii?Q?podzS8cizYt8gCIkvWHMOsRwVEci4n8Ifb4kXhlUhna/ZOZxzZgocXTKPXWN?=
 =?us-ascii?Q?QLAugcOU8/XybeNapiqAQT/nP5lpMyEhBmDB/JsDR/73YuzrwiXJJIiCYre6?=
 =?us-ascii?Q?SNTZcSW1gzdGUSFED2oDDaHg6XMbfuZgd7wLwY6ngiQFDZ1gKwXI8zAXKiyB?=
 =?us-ascii?Q?gMcICXbd6LUack8xjjW1ubi+DbQKMhe09N2DVlU5PxKc15IxrTnPrw1U7Ert?=
 =?us-ascii?Q?+yBYjV4A0qmulsvAE+Vl0AB/nqKIbNn4s8qZILJTMxJnXfwjadPy7ZyrQcqD?=
 =?us-ascii?Q?Ld3DOJlP3G778ePaBmicaLmSikTyE+9Dwp8DmXdwXsefOYO76tCBf/ZRxDTu?=
 =?us-ascii?Q?OpEopSiIPQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6daf2da6-a7e7-4b95-017a-08df12d77363
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 03:14:27.4677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULG/dxhE5t8BJXtBHDi/DnBjTp1qD8KyHEHWQu427wj3sbtl+C7HMqeLee8LLm/TBLSYihJWp++NKFAiyA+2zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834

DEFINE_CTL_TABLE_POLL() statically initializes an embedded wait queue.
An automatic local poll object cannot provide the persistent lockdep
class key expected by its wait queue lock.

Add ASSERT_STATIC_STORAGE() to reject automatic declarations while
preserving file-scope and static local definitions. Leave the underlying
initializer available for embedded objects.

Assisted-by: OpenAI Codex
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/sysctl.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index e5d7226ab6f5..be79359346af 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -22,6 +22,7 @@
 #ifndef _LINUX_SYSCTL_H
 #define _LINUX_SYSCTL_H
 
+#include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
@@ -216,7 +217,8 @@ static inline void *proc_sys_poll_event(struct ctl_table_poll *poll)
 	.wait = __WAIT_QUEUE_HEAD_INITIALIZER(name.wait) }
 
 #define DEFINE_CTL_TABLE_POLL(name)					\
-	struct ctl_table_poll name = __CTL_TABLE_POLL_INITIALIZER(name)
+	struct ctl_table_poll name = __CTL_TABLE_POLL_INITIALIZER(name);	\
+	ASSERT_STATIC_STORAGE(name)
 
 /* A sysctl table is an array of struct ctl_table: */
 struct ctl_table {
-- 
2.53.0


