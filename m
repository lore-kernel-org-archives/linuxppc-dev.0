Return-Path: <linuxppc-dev+bounces-19453-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E450D105D98C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 00:12:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr3Rj2X9Tz2ydq;
	Wed, 08 Apr 2026 10:12:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775607169;
	cv=fail; b=IRYYzenLMGAxwOxH8EzMemeiXCmJw8xgLjEOx0/bHop39QsJ+ln4Fee73I2v9sRbqQCdjaPE2hXb3VQ4WoyCnq0jpzTHEceCySGhFH6GpdVJyG0T6ceeaFeDj4gxHkoEz49D8t82MHBD6acEexFUi5eq5sovU+gqPSw0VzW5oZnR5C0TfHLAn6zjCow6iRJBRpJoS/qL6wTnp/+gKRT0zwTB5UFGWJNgOlS2mKHJTOCO9YV+gMwmBdbnXnI7H6FARf3ALGBnBivmeSJGGP9E2XG/hcq4wBlDYN1urqHRKRS8IADP8K7k/Op7KSIWtJ4+Mk1yedx0WXVn0eZa7nit9A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775607169; c=relaxed/relaxed;
	bh=LdAuWVuWrRO37JWN/cy2Bx5UOdQitpd/FJbA5mtlrgw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PmY4Y1sLqm00i2+oeVhJXlPJfucSDF1/f4dUY23MEPGEolP4dFJiuy332h3oj3EVy+L0YZTvwVcci4M+V1yxIxuV/SKFJGZ1KKa/s9e9BNo8BZeaBUKcJUhg8yF45bzOueYooHNA8RO+ZWju0d/xYKikpi3ZDMjX3s0wue9zLWZnRbFt85MSEzA0nVOsUnsLXRZ5+8QbKi2xPuzthDOKZL3f66gxwW0UhlNtdjVhbd4mMte7rWDr+HMJcCWy+UBmw4mFiL8GP9k5b1sxO6z2KOCbPifJTHcLgttcexCvZKa3NBugp7B2+uskUItTLF2CPhsChWTsCzD4hWP1iQgbGg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UQmB7qsY; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UQmB7qsY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr3Rf1B3Fz2ydn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 10:12:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775607167; x=1807143167;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=C43aQq1kqWkkm0ME4HglPVywST/amGCACvhXHZo6Xjs=;
  b=UQmB7qsYB5Ohiuiizg6W8gk6FyYHptCicYGQ1vUHj9WPqQRf6lE2HL8m
   yqlurbjnZ3PwIDZ1lQ/wtz25mYxkO0lkfGq7262/1Sg7s9zqEEC2y9wvi
   7LaZfKQnJBvKXhx/pWBCJlLM1u17U377wvkK4rVIpbv01uzULlwQS4Lv0
   fJ9PNny8SEvVTG102KAm6rj3PT+uSiPHHe+IehKRd0Ygv6paL2PAcT5Op
   2bLcHpZ8MhV5n3mIHbOsl5qPQ20HbqjVryKinVkniuPekhSQrdbjnKV5r
   tFh/6Srk7/yccy2BBQXIcAFF/YlTloJrPBZi34PD0VoRH5URc9LxaOY0j
   g==;
X-CSE-ConnectionGUID: NRhwHEY2So63lF/IDI/Tsw==
X-CSE-MsgGUID: 9NyM/5X+S9CKGWsdFxc9cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76462854"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="76462854"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 17:12:38 -0700
X-CSE-ConnectionGUID: hbHUVRD2T6aCDYrhKAVWVA==
X-CSE-MsgGUID: Ard2GGRyT72NW+vNOmYraQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="227297994"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 17:12:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 17:12:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 17:12:37 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.21) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 17:12:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7uruFyTgvlEdWBvIH2uJDerqkbdMf0zAxhRbzeR3wKu7es9ZJ1KEEi4hEschiwiYv3oMSdXJb13e9mQ6Itbp4oVj5fkp3jYx8RFLQ7H2yijT42kixMXgwqBsIxlaDVhlOLm+smysuuTaIiSdYhQyttF6ZUO3fHvRb8ih8GcKmew9yz5Ii5izlzAwJBGVU+EnF9ahso30ZeDfbBeGgmIVA2YDX+L4XUPdDemN5iXqluL9ZktU1vCB8IxrbnjxrjYMSC0SgMq1k/iDykXYexJDCHmg/pbHpoRlKJA0xT2G5+Ve51JQPl70FGupzsu5C8mMe/Ywq2PAA9/xv+GuKqmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdAuWVuWrRO37JWN/cy2Bx5UOdQitpd/FJbA5mtlrgw=;
 b=mOLD/vo4yYuSeRqHbd7tGqr4hWGaJACXYymFpsuxGrruoHrJP2TH5CNiIfS0FAZUzU2jSYLUvD502jjPyoP0WOg33n9e3DGnlSzkZaYjKUiDTHEq2H1a6GzanqqEf312AR3Hk2P1fkMD3wzeRRhcmPHShde6/V9GEPy7bpT6smyjzsSZtzcHDJpMWcROjUozUZp3JOjb+1NALwUGbdhwbN2HY7A4ivSNxXabNGmroFv9P/GPilYF/0fZsHzhM2AiHO5hIwsI6GUyquGmzoSaWmV5/+4C+r7QU7819x9MHhGBQ4TjCTTOlzwiX6PUeVKwby5RNSRwACnfIT1lVrg/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 8 Apr
 2026 00:12:33 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 00:12:33 +0000
From: Peter Fang <peter.fang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Nicholas
 Piggin" <npiggin@gmail.com>
CC: Yosry Ahmed <yosry@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <kvm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Peter Fang <peter.fang@intel.com>
Subject: [PATCH v2 0/3] KVM: Fix and clean up kvm_vcpu_map[_readonly]() usages
Date: Tue, 7 Apr 2026 17:11:27 -0700
Message-ID: <20260408001137.3290444-1-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:40::24) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
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
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|BL3PR11MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: e31dc2a2-4d70-4daa-37a1-08de95038837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: GpvsPs0HCeutXJNn+riiIDtdt6fWHyl1no5aMMbKpvYQMwo+K8VQguOlT02CQn+derUzRpxRVKpWJ5LrWJ25RNS3wq/8yBqtaIaX5+4mGQt5BZ/1ApgzoQuKLK656YRtOG11jqIH0d1a7tqOUl/TyKKjDOheP1HVDp40FXT3d8JCbCpidhH6mm3ht3nOCsW9y0QQ0HgnhzvqhO8g+Ja3qZ8nz/Uagil0VJyPSE5R6czv2HBy4zSfJb1OCoCMqDnNjYCNAubSJlBBj491kg7YxP++bpc3NadAK8cj9hxeTLUrmGEPfbAwmijMlE+078pO6/EfbqzdBRfLc5DOldwpFEkm5MDZxSAb9xFGFmYP7QfKG66/9OY3Ri6XCNg52thWy6bAQBNyZj+QNj1NL3i5u5MWjqKxk3xPep+AdXLHdrXzb9jypUNIfg26YgpT37sk0UmrzaOfqhK+kWuDHwWppclO14eQYnOhfWakNXO/2hJSUYoCildGsAP5+znMkL89qZ98Kc1XsSBfieup2iq4FWrUWbU5vqLj9AT1EiVIG0oifjcnKTdcFQgS6Dquf3XKvHYA3tqvc6QbIrPQ7jaPyToXSqkA05e16fVpzHIGtxA56fALfA/OqNR6xHcJWaQWCzfd1WzgwqenJQQAR6wYw6NHDGpBz5DIMNztmY5qmc786B+6ljMzEf/RkH8Dup/riPYTi2qsprf66l4HMlouAuGn7DysoXa8udOcaNL+bRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KjBmuQKBd5PmtT2FV2fvgbAdv6GyC7yYec7XSMkGkLN8VkbgVH+LASKN0tvB?=
 =?us-ascii?Q?OF9DwNNxnhVg2u2p0LGyf8HCyolp/TEEt5fzlZV9SjPC4j3qMdhR6QM3IPB+?=
 =?us-ascii?Q?3NsRErVryXLj4S+fZFriznn6QN7HM6n6Re0fjHZq3rChMFmaGpbC/I9wQyj+?=
 =?us-ascii?Q?b7hm1I8hAIYzZAf7gspKVoVZWEfswUMx8467DxdUACj+V+QEOPhCqfD/wmhB?=
 =?us-ascii?Q?uFZDUhHkLrr9e2Hs0OhEKUgGVdSk9U3hrHmhAvTQB1RmpHRARAnWWk5o913R?=
 =?us-ascii?Q?Fd+JYvFxMDQ85g8kXW9TJeB+Yk4orOrFLCP/lZHBRGb0ic58Q50Jn/pA5L4a?=
 =?us-ascii?Q?MMIKoAw6A+vSSalojezlQk/JjfZ1xs/yuHQ/g24paz360u9z7IpUFfP10gvh?=
 =?us-ascii?Q?/84LTxE/mmJeBEDd9Nz5/OfwJuct0iiag5z3bIbGSST/VIePhASStJI2HILG?=
 =?us-ascii?Q?LExgX6g4uGuGQDD5VtkDURLkeJ1QpMnemIoGzXyEcUZMQVWVoYCUpBYmF5zk?=
 =?us-ascii?Q?VPm6ljPc4VJu1o4B9xrHuFhGE9Eeh7lDTyjziZqk11i0hbO/IblAsV8zpN0O?=
 =?us-ascii?Q?X/ODS7WpNPTvpkuoNujNEWNLoF//cL1bQvwg9xtUrT+tRabIRhEeZ46QmKb4?=
 =?us-ascii?Q?fAo+0n/4TkFntRdhRdJtj563ouBTp/mTqV/UjlHUUuTV3RyYGiriIRWACfdE?=
 =?us-ascii?Q?pIvzOUBDPNsve75XIt/5ODe1sA8RzKHKzPosc6p9d4VSWoXT+fxIvbbfWObk?=
 =?us-ascii?Q?UVUtxO73hjrDrxkaRq1hMw1FSB8113G3kTqGO5VkCamanTKZeaNRx8i8sXY2?=
 =?us-ascii?Q?XtoAySagJwAAS5MvGsWBmTDeZ1pDv8GULBZCU9IPeVaveeqlOLiSzdpcOY53?=
 =?us-ascii?Q?1iYHow8URbIjzBnuaJiU60KfjvFaXwaMwrfZ2j5Ske+tYL93qPA2lVpzJmrP?=
 =?us-ascii?Q?PNdohGbCeSf6b1NskI2yWJrsX7ad2JjUiWkwxkbwAYPhK9kxLhvueQ9VlLe+?=
 =?us-ascii?Q?vCBfpN8kz6fNQtOLhatdoPnn1XkZT0mc0fVPCPu+pv9YRiRcT+YT93CgiY/m?=
 =?us-ascii?Q?y78HdEKbIbnfOcypQQzQkopy2/xuSEqkTJ8KCmEIdhsCUHlWk7ZLZiKzZPUL?=
 =?us-ascii?Q?Px96eQ2iU9TG9zhcW1UwuAj3gNeGsDoqPblcWylotJVbA+w87PgutL36Te1x?=
 =?us-ascii?Q?QUjRzErTcwPG0RWXIt4ESQplS+B94peRFlbVpJ5718ME+y0B48sBklSBHgEH?=
 =?us-ascii?Q?JVkbFb2almblDa2ncsv93MMcvnhyWIOrG8J5kefsX33cwN+Tpgzv4H3nXdfR?=
 =?us-ascii?Q?T7WWprjKMmXZJM1rrui35ImKHfb5jUMimw7uT2sFWPZWIRu7YNXBQQggW2AR?=
 =?us-ascii?Q?JT2JkbnvgUBdEl+ENSDJ8cDQZPrujLHBs8IfC/z3iMoXDz4CqWG+Dl2QnN9K?=
 =?us-ascii?Q?KQLlID6rigC78+x3VRa6h2o2kHSraOWEG5EjKTN0UHqrE+Rm1E+1uJfHpL/S?=
 =?us-ascii?Q?8l1LvZ1No9ePvqXT3yU5vnGkxKHQXAQlzAO+LEHKuAeSf0TbsmJdHFMOu4ho?=
 =?us-ascii?Q?E6WKm7GHS5YRj+gTSJ4ECetg/IUEqVzJ/cxa1gmal/7OBn4RKsWEuqlqlVoK?=
 =?us-ascii?Q?fmR6s49SAZUkLjnjNjGPTYlZL8KLgFUjFlk8FRR0TMoq1AziC+/PSD6Noyti?=
 =?us-ascii?Q?i2ZsPI3hGwpoDdHjrjWS8XjhViALIqi8dph0yc3jerHF1+RUaLk5cNpIlJNe?=
 =?us-ascii?Q?qwrgoMxSlA=3D=3D?=
X-Exchange-RoutingPolicyChecked: quMUGBK8nKvVZYN6hHWFDNqmlipaW56bJ8f4Q94fKe6zcJAdN4LXBsRwnfK05Xog7l2qWHa4XbDU9miX+Wj9JZHZ6JuAdmdpvs/QYVC0XLNb0z912CfDkmTQ1uwggZQQZFsrribldaxq4H6ydvDYrOUVlc6zNrCFYEVAKHDlcx7dpBAsuRtw9HNKD+4sInHrRRKjyApADCJw0xy0OnJZzN3o5BSXgr+jTH9vUJI9fc3gFnqybTKIucJ25OhpiJLiOhE2s2/9GFdzwDEwPKfH+MUcAUjh7o7k7T7xk2x/uGuuRS+IpXeRQ/VFLZgOdcIuB01QolkVaD9ebSzN27eKpA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e31dc2a2-4d70-4daa-37a1-08de95038837
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 00:12:33.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrHWROIMaVXlkpPE+TPyLHmeijtW851OixJrizwLMTekTOhjScfsFjqScvkOCt8LFqWjSYFOOkTFEF9HtfvSRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

kvm_vcpu_map() and kvm_vcpu_map_readonly() are declared to take a gpa_t
in kvm_host.h when they're supposed to take a gfn_t. First fix the
function prototypes, and then refactor them to correctly take a gpa_t,
reducing boilerplate gpa->gfn conversions at all call sites.

No actual harm has been done yet as all of the call sites are correctly
passing in a gfn.

No functional change intended. All changes are compile-tested on x86 and
ppc, which are the current users of these APIs.

---

v1 -> v2:
  - Rebased on top of latest kvm.git#master
  - As suggested by Yosry, refactor the APIs to reduce boilerplate code
    at call sites

v1: https://lore.kernel.org/kvm/20260325092001.613025-1-peter.fang@intel.com/

Peter Fang (3):
  KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
  KVM: Move page mapping/unmapping APIs in kvm_host.h
  KVM: Take gpa_t in kvm_vcpu_map[_readonly]()

 arch/powerpc/kvm/book3s_pr.c |  2 +-
 arch/x86/kvm/svm/nested.c    |  4 ++--
 arch/x86/kvm/svm/sev.c       |  2 +-
 arch/x86/kvm/svm/svm.c       |  8 +++----
 arch/x86/kvm/vmx/nested.c    | 11 ++++-----
 include/linux/kvm_host.h     | 46 ++++++++++++++++++------------------
 6 files changed, 36 insertions(+), 37 deletions(-)


base-commit: df83746075778958954aa0460cca55f4b3fc9c02
-- 
2.53.0


