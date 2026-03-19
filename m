Return-Path: <linuxppc-dev+bounces-18412-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969741088E6C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 03:37:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbrwx1RFfz2yZ5;
	Thu, 19 Mar 2026 14:37:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773891441;
	cv=pass; b=id+nAoFGGKC+zBr9LStdHlTyvkx8rUulH0Bw2Nxu4KaV7gDnf1cPRq5oSEjMed5dlqptzNImVlghVB3vUfZwscxswr2Dk0RxHcz84KNeemUj4OBCB1OZsJRYXqmb3xplIfsbEDPFRkp7PGKCL1DOaErc7SekJfT0zNKr4DSRxFhgYtW0fvy3r+yCl0LLfNSRTMBVP/miF4breqmlDjaPfMWQCz6ZMlwWtE94aSy9SFxuoWsXo0R31zqdGLwdxwFaKypbDL+MqGX+hZOePcg67QGgsL9GxMoMMQjPc20I7ksKIgqFr8zwFIMqvEOCT8gvp5lkMcCJ/pa5b2uko905GQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773891441; c=relaxed/relaxed;
	bh=+D0hsfEfypmPznvp5gFFqmdfWNsbkFuq1/VfFspns5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hE2Mxalgqi5iHPK7M/gMhIpbW2HKPQFpKn908Zd/D3scWY0iqwLjVI4m8GI7OJhU7bBjGh8gAeDREtpQMQM+AgYNkmzpcfG478Axkf7I1vRXQTEa0wmKVHvD6DOn0S+JtRQGvCiQvioUUUr0N1osuiTIXY+NzKmPOv6UJUI/Zy74TLHWvUIR9rwtDI2BM2WxmwaIir8/T6ZD9jy6oFM1dy4ykpv+EV7Ut5pTBDno/EFJMUA7Bgj6Uqz/dX9fgLVrYiq1fliEVGZFuUQGIVL7FThHZjAw2WrjvsAgG94XPe11ZqLfwxvb+x9rarF17wfJ6E54A6qSydOXMGyRKQqPKA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IBasSnhf; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IBasSnhf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbrwv5QdCz2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 14:37:18 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTnqnOv9mRcUOqG0hJFaJYUMkW4EOM6i+OXpeM0ag1sFvQO3EuVXhQfE9BtPYhnjfGSIh9AheoBlFgXaBc1+6MwRqpkDNM4kDtuUHgH2Lhk1BFvMUKDIo3KRMkMiLoH1FABl64oZcS64h97PtDufjqXRsEAna+qWhWP5jnwKlXPI4v2E1NPvKXpvrEY9sYUWZqlYbSZIVxbj2UszowZEB7r9wnDKwYYeDlSzvfErIeJO1EM0Ozew3MtTznhzTipC5lGVZDl8NjLazEC0IjVdjgZNzzSMrT78IGztrYnlFtgS2alO9G7itzMCGH0RVV1ZWfm0xRpTKQvrAVQdxU9Qow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D0hsfEfypmPznvp5gFFqmdfWNsbkFuq1/VfFspns5Y=;
 b=mhydSsumJAXVAR7hwmHZvxAyFMJNEpLlxygf6yBiiuWyOrfoNQy1HRJoD4Nqvw5SN8TyjGSMsd2HzcRzveWt2k02immtLioUb4WgHa1BEpAmCvQALH8njSkVrsqiuuzj+Nme5YnRv4xSSpXMe0LAnOLLXz1UoRK08Wej0eLIYiheN4rpLQFZVAeTpXBoDWq6wCmwAZWANJpa5ZELtBCb5PvJue+iVEpRDUfWZxPp8pEh4128UK/LqAwqVplLUK5opAE0c0mkRr9ciRIAHbsSsC6NA/wiw1FCSy5e9zrr40YKG/da3S1Dd1rz22BjhS22zanqF0wPyq3TDXHi+VeyQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D0hsfEfypmPznvp5gFFqmdfWNsbkFuq1/VfFspns5Y=;
 b=IBasSnhfSpDZKnJ71ysx2eSdOsmTOXdBBmOIXVzVlsVpNCZpG4H8OW+d6pWeDJQTx8Yi5SU23OnDhNsSVVdvIOLsi4QH+Hld6QncUSDV4O2pJuqO9pG9VzzdeBm2h/4SlITJTAJUo6AGyp0N2r2/sMOJy5lkfZiMpQWmOXHjkFGXo97e7y4tN3cvLqGVsMYvSTQ9tG76MDqvWOAwg0qHt6G8vhSyKo+YnAR8TSJ0gD6LJ4r0BMfJ4GIv2pxwEWGxVMi1mRmPWuS4XX7jLg8uvzjBrhbOKtyQU0uUMgmnqNgR6m6nQSh3IewIDZKPxdEfHk1GLG1VkE2fgN207YO5Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 03:36:51 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 03:36:51 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Yury Norov <ynorov@nvidia.com>,
	Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/2] powerpc/xive: rework xive_find_target_in_mask()
Date: Wed, 18 Mar 2026 23:36:44 -0400
Message-ID: <20260319033647.881246-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0744.namprd03.prod.outlook.com
 (2603:10b6:408:110::29) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 73cbde03-e2ad-41ba-cedc-08de8568c1f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	ejq6483lgTLoAzyWSHizvjGaL63lKjViXdPv+W5lOxZEcK4oIMVsgh85rvNrXAhMRNPlqn7z8jpCNrge7uMYV98hql2qEaIF3dksy+cVM9U3HQ0YJ2OnJBDj3GaiYiSoUnSmvrhpqcr1Pw/uButpLvl0LigaRa46b7U59+c9RpsogMFaZEgzXJmTErdzrjWM40/ZDBgPZGi6c9/BdyNM1+Pn4UH0OPhWXLvbT+1HwNdwHSC7IfPCa35RSG+V/+WVir2KVYuoB+IgJu+tNvD3Ez1z7z0fOM3JIP18/bqjyNgFkYs4UZt/f/0XQaohLc4ayizom1D7i8S0JTIEC6u7lOzhSC1HUT5dDf/+mPJPIjn5Vvkng2z4Cu39KPgdUK6/YlMUe6S13qVfSqtD68e4fGPy8jV0Sp2cHZycwJq5nIcVKvx1MoHwt/EfSzgQcMOpwgR8cCO7zxcUhzCE3vU3fWquJSuBPXRfm0DQcgZk26eQrv1q1/kXgFeDi1J+Eptq53zdwVsWd185sWDeo6UnFYiTJp13AVQN58zdnSUElm2pCOJdGtZ+pb77iJDMZMSmQ1l7SfT2jLZ6XCpcpl0weglio9BjTrB9YfyeXP5YOHAbgdNGVWfyCUnvfrfN+q0xBYLc3EYfT0dBH/RVyvkvWcY3fMHMp71B7xrQa1p+SqptUyL/I4qe0H3YTo/QlKXu3QZMaXXAzzFxhyah/5yOcZqamYG/2sOgVeUDLcbfFOB4cqRWafel4PVLjrsYQMEpDQQtEl6BfMBE/fxU+uxZ8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rbl5sAxJ76eokhEvTPyM8br7oy0E3Ro1FsqsjW0oA8e+voO5pyHv3ru89If7?=
 =?us-ascii?Q?ip+Sl6m5I/VvCg84CVw6ZZygytTZhohR+rY2cMeaW5tSaJlZT35tfvHO88Vh?=
 =?us-ascii?Q?Rs34XjSn19Xnh7nBwnJS6q9MfWUh+xYFRAiIiQZ79V2uYDKTNFvroPZDFNyw?=
 =?us-ascii?Q?+R7ugfX+6RRqq+T/DOEYbu2zWj/fRyJ6jCW6AcDpWjMWafxBnmUG6AGP5ydv?=
 =?us-ascii?Q?0aVzMdrG8ZS5OhtJ0Y/S3kD9CebpuEwNYPzAFjm2bzGRPyMVpE82SnxWhkVs?=
 =?us-ascii?Q?9Tm/LLmP+jf828z9U2XfIoQEEs8PwqWVTHor5f7lKQ1BPXnLwaLsFpERlRn0?=
 =?us-ascii?Q?79pcNn9Ffsr9nGkpW5I+hWuhlL0LNQsbxXxVaeDqge0Od3mRLnkUEePkFFvK?=
 =?us-ascii?Q?SItRmkDalrskJIDGeHEDSaEC29zZe7HGogOOirwvWYyukokeOYtN0qMMFEtK?=
 =?us-ascii?Q?Em4m/7dJ8K4c+BJx8xY5vraexd6BqfbYc0w55nKqMIoswrtMbew3Jx2wanVA?=
 =?us-ascii?Q?57e4eB+hx8i2pHyYVzX5lScrdXdpPNASTGhcEAD6y4pu7XnrwlKTkzpW3jCq?=
 =?us-ascii?Q?Vw5jDL0Hw0glOCJ9Tn/1rBxC90UDEd8CMmpefZ2apehkYmX3M5Lnu6kYyjic?=
 =?us-ascii?Q?22kg4YR48vQFbfUOChT/qIpLqF0I//eLGvbgwBHp5sSSeOmGkKl9zAd0eOSY?=
 =?us-ascii?Q?/TiSYp0MopeU4iGWYT4WgE5fqkVOcLVwk+/NDHk5IBynWIlMOQAO132FWlqE?=
 =?us-ascii?Q?utEdhvjVgBA0erQ1JTmedpMJBliAddoOV+N4Yqxvc1R95vA7TD/Yvfr1zPgX?=
 =?us-ascii?Q?wr1D3Y4V8zQX3Zjt4yIr6xbEU6GWztciS4I1K9kfzS93CAsNxDhTVX9HdESf?=
 =?us-ascii?Q?r269M2CYm/Gg158FsUErZ1h3oPHsSBv5KCY2VoZhzimSxe76/49J4vdUSNGJ?=
 =?us-ascii?Q?IVMnaKmt4v8NQvCxx+NFdDZGcIVNVhXWlBMYjdsJSK2EQ5zh5wSfU+HB5eAJ?=
 =?us-ascii?Q?M9oyez68NLvvVA0MtWV/q7Ux532o9RBOPScjyBb3P4lqrc6iIGnylzbkUfoV?=
 =?us-ascii?Q?LXAtXVmkmyEJmexe8dWd9ZKbB5UIQMPnahevowglarHBgtDUNJ7JA05mm7b0?=
 =?us-ascii?Q?V5c/543si7jyaA7NA7yGvADQAnm3SDrTW/pYbSMQAuuApJl59+ftv3DEApXv?=
 =?us-ascii?Q?o6nSPKU4tlLQaDrjpF8g228sgKfE6EMe7aV8j6AHdYCholMBebTs8BxQkKif?=
 =?us-ascii?Q?IgDRRvFydRAxzfhecNmmj/pKi1OTiInb0OSwIG2J3kIAfDSkaJj/6diU/6uv?=
 =?us-ascii?Q?0suPkFBY8A/oOvuIU0cJ/h6l+fjpSIHrjoo+3hzDRl2RF7z8im7QhN1Gr/hR?=
 =?us-ascii?Q?qwSFR43Q1hBXZQa4vuHHUmMCpE263OxB4yL3K2qYUao1W4rZBDoY0uLDwegD?=
 =?us-ascii?Q?akIPJTUS11AIOl5iIyX05bniFb/DB7e10rpTCYSkxBjdHqh/fJZtR7wk8Bdc?=
 =?us-ascii?Q?fnp1RhhrZQMgqqqm/qo6ghIk4Ch2j5X/hJJgEG6xw2XFNedm2kjirMlOTQBV?=
 =?us-ascii?Q?IAO4P+dSUGRVfchR78YrDUFWxdLQEDKIglvRsuLaeVlSTaIXzzi7ll9cxYVv?=
 =?us-ascii?Q?LLR9unmZYEtqfnUdjJezMDXAMoxBwtIl1FcnvhghfOHmJld9Rgu7F+8O8bYV?=
 =?us-ascii?Q?7BUxftHoGecLRyTHEEQOQVPF1Hblf/owyhaDPqQxTrkAIvWAy7tOb5hpuVIL?=
 =?us-ascii?Q?NYu2fXje3OeQXUcbcKYbxrg5Wx7eBHkAI3hLa71gp3GI0IDmcMRn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cbde03-e2ad-41ba-cedc-08de8568c1f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 03:36:51.1623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/ct7pIJciCdhSsq/XHxTRQT4wNdEVpWCo7ruVSAX/EDOtzgbrf5WjNPeobd5FY2llWISQHI2GEjesXVjAeUFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199

Simplify the function by switching to using a modern cpumask API.

Yury Norov (2):
  Revert "powerpc/xive: Fix the size of the cpumask used in
    xive_find_target_in_mask()"
  powerpc/xive: rework xive_find_target_in_mask()

 arch/powerpc/sysdev/xive/common.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

-- 
2.43.0


