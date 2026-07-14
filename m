Return-Path: <linuxppc-dev+bounces-24180-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84454C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 02:46:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzkGF4hZFz2yMn;
	Tue, 14 Jul 2026 12:46:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783997189;
	cv=fail; b=Wo/tRUVWdiYzQ9krtyeKWE78MmvkpwqsADyS4mUobvfBe9ZKFbYWx9iAaNj8MXRW93GbY6bN1a1awN9kkjBllozfoYz/FkmIZOsrJ2lI00euy7hIeaI9ls+1Bj3v4sBLp2npeec0i+F8fG1ZB+e+zyzn6Js7MtXMgdeur8zAcrZyJtGmRikz5rF9RhPUjau/uNceR2fScUksmMxY8vA0NA4Yq6ZW1x5akGDTGld/DgfB2PMMpj6b68gdeHA3SJr/jPVSohy4GHXXN5RrKS3bL27WUcPudWNXgLxIcBQwuPD+gKmllJwvKGYVeuMgth75VqK8kFW7lriTGJ5uHDZOwQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783997189; c=relaxed/relaxed;
	bh=un7ZYzh1i+G6hP9TI+HMat2toh4xZkSUW7LpwBibRgo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iva/OPwgtncOdAKEOgoBue2fxLuCI2unGjx3VVrMJ8QnjjYtD6HQX6W708Qj9dsbRTegyakNAGNL+mmnS/q3ffpKwhWET0oYFFE2AYXBvCz2/vPJ/X3D8B6tt2goh4myWAhR2eaJLC7UiRXVhFgOrcXdoITf2Xn/myEPuk9fhzWMC8IsXKI0eln7GKwnTgX9DXTzvS7tv279KGS+zrWI+fJP3vST7EQIjcY8sg+VuXDDALR7vReE+8oqaaYvf87ZU6dkBBrMWD8ftYKYVJuKlo0nQgp9BQ5IkrG8rXqvymwa9etIV2AWoW60YRlQZDiqz6/Iod8jwnMvwLUtdHm0fw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e2iUvgQ0; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=alison.schofield@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e2iUvgQ0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=alison.schofield@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzkG970tcz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 12:46:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783997187; x=1815533187;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xpTuT8XRb6/yyGQE0xiOlX2GrXaX9mT2pg5aIEwPFQs=;
  b=e2iUvgQ0vuXEHVCTqUms7xUw2NqgRpJdmf+I5iD/ztB3h6Q9WLVZF/Fv
   ClErKffy+9g8LSkua6uH6m5bsgh8gQGNSO2X2sn7aT6aG2FDEzg5FP90v
   l+gpr8mg3NzZrdIwi3lDVQ4SaM60kUr5xMuuLY6K2zxMElSG4d7f+QG5h
   gCBQoLCqbKi+Nuo072PQQ+HrmSM+fvxEbKULFiG8AMd+EBWoZXlsN2it3
   g7TmWpin74nidCr4Q0WnuZ+XruryqLsUZSh7pUI5y3rAsLyGov6jTGIMj
   7jaXiwcSykzHSWjyE3LdrtqbhH7ssLMXOHpnpz2d89kEFUsisW2qwXxma
   g==;
X-CSE-ConnectionGUID: ESK8j4QXTHqUsWHnM1kkSw==
X-CSE-MsgGUID: 2sBmWSqnQP6w/v5tJNAdqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95259678"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95259678"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 19:46:20 -0700
X-CSE-ConnectionGUID: ZNLsEf6bTk2vZHuXVcSS8g==
X-CSE-MsgGUID: VKaUUhx+Te2kmNMYtYVYHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259299724"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 19:46:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 19:46:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 19:46:18 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 19:46:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftgxS10Yq8AFqk/1xwZBION0H3MxmjAQq94zBu2Y6cv5t6sSky0NL0ob/rWF8ugMHyl8R9+zB4zYJhLapaNMMLBY90ZNCvqOJkAzX8Ea4Retahm14MBV71vuWLAWsowE5TlStnJg5eq9rodGNwgA9W72LyfJpgar0wPj0rUP3WHD/7+O1pEpzrmnF+XbUGg53z5mTd/E3uHH94Qnn6067Img2Rl/RuVeY1vghw3w1cKO1moKbTb8sKgIoeCGa5qwgITNBX10NBvpv9axlxQMnn4EndTsMe5VFW2//tNRlyzOOpOJU4rgu9Vt0DV9+0iAvrDJhGKS8QPT+1TxLoA7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=un7ZYzh1i+G6hP9TI+HMat2toh4xZkSUW7LpwBibRgo=;
 b=xSLIg6meR+f3siZkvzPp+JScYCWpj32JwbeAe19xmbLKqt7yCFl8k05kJD7OUTGZj7ZSl+kgPLCzEC84zY/RTVabMbsehH6jLHZLL813DUABXDflwz3BOgzfZJ6dyylDzP4UwIZzGlaBIQNVnNc3I1KN0PhjfIaxr32c8P24/+ybyl89CHw0eba7YWpw4A3h0sahr85qOKZ3MFLFgbCuNCHHiIt83no915tKiam+4KwA+ZwchWVnRS2NviKdSyuMF18+WNckCVloUSTcQFDHjbsqX8FyTjcuL6yKxjYWJ7x2xkmAyXNTKVAFhBfcBuKQx3UNYsfGrz3vBTIVSYNR6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB8527.namprd11.prod.outlook.com (2603:10b6:510:2ff::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 02:46:10 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 02:46:10 +0000
Date: Mon, 13 Jul 2026 19:45:58 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Saket Dumbre
	<saket.dumbre@intel.com>, "Davidlohr Bueso" <dave@stgolabs.net>, Jonathan
 Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
	<iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, Bjorn Helgaas
	<bhelgaas@google.com>, "Rob Herring" <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <Dmitry.Lamerov@arm.com>
Subject: Re: [PATCH v7 06/10] ACPI: APEI: GHES: move CXL CPER helpers
Message-ID: <alWi5hvXYT0-ZPyV@aschofie-mobl2.lan>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
 <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-6-8b3a85216cef@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-6-8b3a85216cef@arm.com>
X-ClientProxiedBy: BY5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ee00e8-f266-4f81-f174-08dee1520f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fZ5jYHi/JddAaRCridCku+UK4XiWo4Vrwo2hYoEAIR5yUiMSX59xU+JIlhZMjoOFAaqKNWPqA9Ni5v4+sLHAVNKKoypiNm4lihlrRrlD9ncyl+W2GFCkotSBFBrEAMjISsLfCS90rP1h0ra8R+iwe8nTXl5ymD+RzCc+8/EJLoIVcKdBbxrZcROz5ALf+S59j0l3X3RLPuVWh7QFE9Jebfc2GQ0oHJFbn+Q6jZqnVrd/OSG7hzRfL5nHH6cDIxaSywMWzTumVJ342dGCoTRFCKyoVa15+enN5Rgt8ApaagD1GBmA7L2gr9tDUjRKxFiVmK6dO1YMWOZpcKkASPWlhq9Dl3hJ6RDRXRdZkjPgmmp+xqtKup/YjFsUYsu/BqotZgBGmOW0UY/TSMzbMt/Bj795kF8QzfYLSQwNN4CtYQX8ERQQrzfFpvyuNc+ZKk37dTv26r9KA8b9rzK2RXwAmqXz610S825UZibLMQyW8kP9cCUvMklbZskW1j9UH0mdNXXpur+6isTaHR/p/C+wX4bb5HrzIFHKMqaN7/5Kr/SIi2jyex5WlyJvt8vWDbXxCJQHP7LWshL/atEWi5Xb4No/O2sJTVyJ2PkH4B3D373wBqBruJ2NtFq2/BRt5dH4QrYvoXEF4+Adk7rbrdbjyz7eadHdv8Mqvr13890NXgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6l23LwfO0TYeDPANReGZYjHSukkB8Ddqwjihq1QdKt2rXY2+jopEp6vgNUnh?=
 =?us-ascii?Q?E7ZNrNtdTgbow7hzWW7RMvl0vU+NHFaO2PslFvgFVEL0n36xtJybFvYwC+oa?=
 =?us-ascii?Q?BprgEvRIq76Ec3lgKMUo1KV7lWacPXuI6Kxx7UIR+C8RdSV5DeYK+NF6vjym?=
 =?us-ascii?Q?mG7qwiOcE+4PXmBbbqdTgoX6MuZTq0QN03wETMQO+X4IeAtf3hvRxs+b7hvd?=
 =?us-ascii?Q?+Bq70c6LmCvazXVcrx1OOSBJO83wnihIm3KOXn3BoRlIpwUXzTrFMbuUguRw?=
 =?us-ascii?Q?y9uJDwxNEibCgb/LuxNPnCFzVsknPnR2vPlu+2DRX1ypcIcB3Zv2atDIgark?=
 =?us-ascii?Q?vu6J76wEXqjiaSH0DMnuJiK6/DhZPusfdzZFv/HrztmdzQp0hJ5EBrgEmS+2?=
 =?us-ascii?Q?/fBOVbr1WCpDDQevmHiKCO8CYt0SNz3/UT0KOa4LgUwHzHji6fVtIeVOrizB?=
 =?us-ascii?Q?3gKoEdCgBCbWMOI6LxtmRBGFPBp/s1YYCxcUrsFrqRlOL+cSoART7lqfsRxW?=
 =?us-ascii?Q?/9CSz9hivoixjwe+FRZiY1+jRQdxL+Ynv6uuA3ErT4SrV+/2cu1O96/gZqVG?=
 =?us-ascii?Q?pINIJ9yNOU0rNa47v5xPSVNNKejN0e2ZVnf9ZOkplj9yBbUHqH1nX497qgWS?=
 =?us-ascii?Q?ey6OIRK0adYez9fLiiaEZsNab4LiLPdlz9nnsQbSNth8HKVC8UzKBu8qtx/p?=
 =?us-ascii?Q?fveffSLhcOdgxa9MKbMa2GLfmvSQLXFXDX7lhdadYgdb0Inf3kQBQAa3ks76?=
 =?us-ascii?Q?JHBkSwvEk1kgDCk9TEr2LcUZ1mHGDHiqfia7ur0a+1HMAybV/y1AIDKDVPS0?=
 =?us-ascii?Q?/RNK8J8UkjXsYQodapVbnbKxlQPAO48x3YtGnZ6TX8ezGmpr0xEldeni2uMs?=
 =?us-ascii?Q?bT+Vr4Htog/7v1fTWr9Sajm1a8x+O9j4edc2lZrpI5qqV+woikzN6AEkVMbd?=
 =?us-ascii?Q?Gjq/dMTV18XX35VxbED8dj5HD2QM7P6AawRDFLRkwZiKJCY9iFM+UVny4BGX?=
 =?us-ascii?Q?VLJv4eff+84wXDNnurBey3804vXnhIlHa5godW6CJbR93o+gaAXWI+U1TSqe?=
 =?us-ascii?Q?/WS9n00T4y/GB0BM/BnskJOU2AK1P4LDEcVuYCEvt+ngaZinArsT0ytfDhGf?=
 =?us-ascii?Q?Dju3beO3ZqBkhLmUbjKyekj8EEJeKOjoDIJN80oRk88nhEC0qXmd3X7DQKnO?=
 =?us-ascii?Q?N+ojjbR8uNAoQMQvwt17SzweU08Kgvv9Et0cjkfRuZEi2ofy58/HWQF5Wogr?=
 =?us-ascii?Q?P1xgJ1xbc+jaBOvsmrpxQeb/zvKh11OQICKOawBeIjqdrtlnZz/RTn+lZvJJ?=
 =?us-ascii?Q?OroFNmGVytOfmg8ZeyuTSlPl58Prn6UJIUgcK0ilGZ6fIPB4udOs4h3oq5sj?=
 =?us-ascii?Q?11SyGLqnNCKWRIZLaksT2kBS3avRj/89vtguJ/hitNv4lhv2m6HA9zhbayT4?=
 =?us-ascii?Q?ODyoBOeIGaOBBveRvnr8YwZOpgbPf+goFWOuQKsaOUyOUVDEL0vdn6hJE6Pv?=
 =?us-ascii?Q?yk+ma12+zODXw6L2vqSkZKg3ZL/+K9c4mo43z5IDL9b4UB1vHs2bd9ps4iWw?=
 =?us-ascii?Q?mmSerwlUk+biDaeNtlfnIs6fKru3MC5B2f625AYpe2wu5mV/Y9t7SvooHzA7?=
 =?us-ascii?Q?eCw1ot2szGA1Qs1YRUYvaovsHDSyWbM6//D9ZeKdjFT089egLWS9YqRU+uFp?=
 =?us-ascii?Q?ValViRP0j+DT11eO3CJRgts9VhKMYvOvVQc/RDYdJtXouMZSsqg7lYrSWXiI?=
 =?us-ascii?Q?PZq3YgQL2BEm1zUHlFQjWI/USeX815w=3D?=
X-Exchange-RoutingPolicyChecked: o4FgiaD5ZDXo4l6YluG4Wb/7L6C6u09Rt1bKUZjDX2avbd2xtEid7D3tsO5D/S7nGoXZYlV3/wctaaAEyQDmDFIqVBDCU/oHo0nhYO54QTub5ukmh1uQ4dmfC0kKgVyQX/qpKsC24OsWjsIdrGOeWW8K3pzqy1MJjPJM9Km5Q97BC+HrI+GIapBNPMrXgfoTkdopinLHkMin8RO8HNHPw7yb2k6OAkKEGt+1EBWxXFkSnhojAaZfLAXa/e8ly4c03Nt+1fHK/bBX95FuUU9eRAUYyBra4Wz8+bX3Txso0e2/uzy5hBHczEPWWiwhKfmK5NjJxCB+l95/MZBSskNbRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ee00e8-f266-4f81-f174-08dee1520f63
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:46:09.9270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hVBg/WXxDvuaEorvxHAxXD2+5b7d2H6oHb7/e2Ir/guDlUsDo3c50u53tywZ7IvuMwZc91TRpcQ7PooDZQ66FvtL/uduZTDfkC/gH+XbOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8527
X-OriginatorOrg: intel.com

On Wed, Jul 08, 2026 at 02:59:05PM +0100, Ahmed Tiba wrote:
> Move the CXL CPER handling paths out of ghes.c and into ghes_cper.c so the
> helpers can be reused. The code is moved as-is, with the public
> prototypes updated so GHES keeps calling into the new translation unit.
> 
> While moving this code, also add CXL CPER section length checks and use
> spinlock_irqsave() in CXL register/unregister paths for locking
> consistency.

NAK on moving and changing in the same patch, and esp in a patch
whose subject only says MOVE.


> 
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> ---
>  drivers/acpi/apei/ghes.c      | 180 +++++++++++-------------------------------
>  drivers/acpi/apei/ghes_cper.c | 135 +++++++++++++++++++++++++++++++
>  include/acpi/ghes_cper.h      |  11 +++
>  3 files changed, 194 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 07e4001ea8d7..2a83d326e692 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -383,138 +383,6 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>  #endif
>  }
>  
> -/* Room for 8 entries */
> -#define CXL_CPER_PROT_ERR_FIFO_DEPTH 8
> -static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
> -		    CXL_CPER_PROT_ERR_FIFO_DEPTH);
> -
> -/* Synchronize schedule_work() with cxl_cper_prot_err_work changes */
> -static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
> -struct work_struct *cxl_cper_prot_err_work;
> -
> -static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> -				   int severity)
> -{
> -#ifdef CONFIG_ACPI_APEI_PCIEAER
> -	struct cxl_cper_prot_err_work_data wd;
> -
> -	if (cxl_cper_sec_prot_err_valid(prot_err))
> -		return;
> -
> -	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> -
> -	if (!cxl_cper_prot_err_work)
> -		return;
> -
> -	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
> -		return;
> -
> -	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
> -		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> -		return;
> -	}
> -
> -	schedule_work(cxl_cper_prot_err_work);
> -#endif
> -}
> -
> -int cxl_cper_register_prot_err_work(struct work_struct *work)
> -{
> -	if (cxl_cper_prot_err_work)
> -		return -EINVAL;
> -
> -	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> -	cxl_cper_prot_err_work = work;
> -	return 0;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
> -
> -int cxl_cper_unregister_prot_err_work(struct work_struct *work)
> -{
> -	if (cxl_cper_prot_err_work != work)
> -		return -EINVAL;
> -
> -	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> -	cxl_cper_prot_err_work = NULL;
> -	return 0;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
> -
> -int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
> -{
> -	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
> -
> -/* Room for 8 entries for each of the 4 event log queues */
> -#define CXL_CPER_FIFO_DEPTH 32
> -DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
> -
> -/* Synchronize schedule_work() with cxl_cper_work changes */
> -static DEFINE_SPINLOCK(cxl_cper_work_lock);
> -struct work_struct *cxl_cper_work;
> -
> -static void cxl_cper_post_event(enum cxl_event_type event_type,
> -				struct cxl_cper_event_rec *rec)
> -{
> -	struct cxl_cper_work_data wd;
> -
> -	if (rec->hdr.length <= sizeof(rec->hdr) ||
> -	    rec->hdr.length > sizeof(*rec)) {
> -		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
> -		       rec->hdr.length);
> -		return;
> -	}
> -
> -	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
> -		pr_err(FW_WARN "CXL CPER invalid event\n");
> -		return;
> -	}
> -
> -	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> -
> -	if (!cxl_cper_work)
> -		return;
> -
> -	wd.event_type = event_type;
> -	memcpy(&wd.rec, rec, sizeof(wd.rec));
> -
> -	if (!kfifo_put(&cxl_cper_fifo, wd)) {
> -		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> -		return;
> -	}
> -
> -	schedule_work(cxl_cper_work);
> -}
> -
> -int cxl_cper_register_work(struct work_struct *work)
> -{
> -	if (cxl_cper_work)
> -		return -EINVAL;
> -
> -	guard(spinlock)(&cxl_cper_work_lock);
> -	cxl_cper_work = work;
> -	return 0;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
> -
> -int cxl_cper_unregister_work(struct work_struct *work)
> -{
> -	if (cxl_cper_work != work)
> -		return -EINVAL;
> -
> -	guard(spinlock)(&cxl_cper_work_lock);
> -	cxl_cper_work = NULL;
> -	return 0;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
> -
> -int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
> -{
> -	return kfifo_get(&cxl_cper_fifo, wd);
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
> -
>  static void ghes_log_hwerr(int sev, guid_t *sec_type)
>  {
>  	if (sev != CPER_SEV_RECOVERABLE)
> @@ -549,6 +417,42 @@ static void ghes_log_hwerr(int sev, guid_t *sec_type)
>  	hwerr_log_error_type(HWERR_RECOV_OTHERS);
>  }
>  
> +static bool ghes_cxl_event_len_valid(struct acpi_hest_generic_data *gdata,
> +				     struct cxl_cper_event_rec *rec)
> +{
> +	if (gdata->error_data_length < sizeof(*rec) ||
> +	    rec->hdr.length <= sizeof(rec->hdr) ||
> +	    rec->hdr.length > gdata->error_data_length ||
> +	    rec->hdr.length > sizeof(*rec)) {
> +		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
> +		       rec->hdr.length);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool ghes_cxl_prot_err_len_valid(struct acpi_hest_generic_data *gdata,
> +					struct cxl_cper_sec_prot_err *prot_err)
> +{
> +	if (gdata->error_data_length < sizeof(*prot_err) +
> +	    sizeof(struct cxl_ras_capability_regs)) {
> +		pr_err(FW_WARN "CXL CPER Invalid protocol error length (%u)\n",
> +		       gdata->error_data_length);
> +		return false;
> +	}
> +
> +	if (prot_err->dvsec_len >
> +	    gdata->error_data_length - sizeof(*prot_err) -
> +	    sizeof(struct cxl_ras_capability_regs)) {
> +		pr_err(FW_WARN "CXL CPER invalid DVSEC length (%u)\n",
> +		       prot_err->dvsec_len);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static void ghes_do_proc(struct ghes *ghes,
>  			 const struct acpi_hest_generic_status *estatus)
>  {
> @@ -585,18 +489,30 @@ static void ghes_do_proc(struct ghes *ghes,
>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
>  			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
>  
> +			if (!ghes_cxl_prot_err_len_valid(gdata, prot_err))
> +				continue;
> +
>  			cxl_cper_post_prot_err(prot_err, gdata->error_severity);
>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
>  			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>  
> +			if (!ghes_cxl_event_len_valid(gdata, rec))
> +				continue;
> +
>  			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
>  			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>  
> +			if (!ghes_cxl_event_len_valid(gdata, rec))
> +				continue;
> +
>  			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
>  			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>  
> +			if (!ghes_cxl_event_len_valid(gdata, rec))
> +				continue;
> +
>  			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
>  		} else {
>  			void *err = acpi_hest_get_payload(gdata);
> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
> index 7e4a66b788b8..b59e3ed3eab3 100644
> --- a/drivers/acpi/apei/ghes_cper.c
> +++ b/drivers/acpi/apei/ghes_cper.c
> @@ -12,9 +12,12 @@
>   *   Author: Huang Ying <ying.huang@intel.com>
>   */
>  
> +#include <linux/aer.h>
> +#include <linux/cleanup.h>
>  #include <linux/err.h>
>  #include <linux/genalloc.h>
>  #include <linux/io.h>
> +#include <linux/kfifo.h>
>  #include <linux/kernel.h>
>  #include <linux/math64.h>
>  #include <linux/mm.h>
> @@ -350,6 +353,138 @@ void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  	schedule_work(&entry->work);
>  }
>  
> +/* Room for 8 entries */
> +#define CXL_CPER_PROT_ERR_FIFO_DEPTH 8
> +static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
> +		    CXL_CPER_PROT_ERR_FIFO_DEPTH);
> +
> +/* Synchronize schedule_work() with cxl_cper_prot_err_work changes */
> +static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
> +struct work_struct *cxl_cper_prot_err_work;
> +
> +void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +			    int severity)
> +{
> +#ifdef CONFIG_ACPI_APEI_PCIEAER
> +	struct cxl_cper_prot_err_work_data wd;
> +
> +	if (cxl_cper_sec_prot_err_valid(prot_err))
> +		return;
> +
> +	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> +
> +	if (!cxl_cper_prot_err_work)
> +		return;
> +
> +	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
> +		return;
> +
> +	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
> +		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_cper_prot_err_work);
> +#endif
> +}
> +
> +int cxl_cper_register_prot_err_work(struct work_struct *work)
> +{
> +	if (cxl_cper_prot_err_work)
> +		return -EINVAL;
> +
> +	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> +	cxl_cper_prot_err_work = work;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
> +
> +int cxl_cper_unregister_prot_err_work(struct work_struct *work)
> +{
> +	if (cxl_cper_prot_err_work != work)
> +		return -EINVAL;
> +
> +	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> +	cxl_cper_prot_err_work = NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
> +
> +int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
> +{
> +	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
> +
> +/* Room for 8 entries for each of the 4 event log queues */
> +#define CXL_CPER_FIFO_DEPTH 32
> +static DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
> +
> +/* Synchronize schedule_work() with cxl_cper_work changes */
> +static DEFINE_SPINLOCK(cxl_cper_work_lock);
> +struct work_struct *cxl_cper_work;
> +
> +void cxl_cper_post_event(enum cxl_event_type event_type,
> +			 struct cxl_cper_event_rec *rec)
> +{
> +	struct cxl_cper_work_data wd;
> +
> +	if (rec->hdr.length <= sizeof(rec->hdr) ||
> +	    rec->hdr.length > sizeof(*rec)) {
> +		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
> +		       rec->hdr.length);
> +		return;
> +	}
> +
> +	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
> +		pr_err(FW_WARN "CXL CPER invalid event\n");
> +		return;
> +	}
> +
> +	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> +
> +	if (!cxl_cper_work)
> +		return;
> +
> +	wd.event_type = event_type;
> +	memcpy(&wd.rec, rec, sizeof(wd.rec));
> +
> +	if (!kfifo_put(&cxl_cper_fifo, wd)) {
> +		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_cper_work);
> +}
> +
> +int cxl_cper_register_work(struct work_struct *work)
> +{
> +	if (cxl_cper_work)
> +		return -EINVAL;
> +
> +	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> +	cxl_cper_work = work;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
> +
> +int cxl_cper_unregister_work(struct work_struct *work)
> +{
> +	if (cxl_cper_work != work)
> +		return -EINVAL;
> +
> +	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> +	cxl_cper_work = NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
> +
> +int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
> +{
> +	return kfifo_get(&cxl_cper_fifo, wd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
> +
>  /*
>   * GHES error status reporting throttle, to report more kinds of
>   * errors, instead of just most frequently occurred errors.
> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
> index d9f9253d8de9..a853a5996cdf 100644
> --- a/include/acpi/ghes_cper.h
> +++ b/include/acpi/ghes_cper.h
> @@ -20,6 +20,7 @@
>  
>  #include <acpi/ghes.h>
>  #include <asm/fixmap.h>
> +#include <cxl/event.h>
>  
>  #define GHES_PFX	"GHES: "
>  
> @@ -106,5 +107,15 @@ void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
>  			    struct acpi_hest_generic_status *estatus);
>  void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  				   int sev);
> +void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +			    int severity);
> +int cxl_cper_register_prot_err_work(struct work_struct *work);
> +int cxl_cper_unregister_prot_err_work(struct work_struct *work);
> +int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd);
> +void cxl_cper_post_event(enum cxl_event_type event_type,
> +			 struct cxl_cper_event_rec *rec);
> +int cxl_cper_register_work(struct work_struct *work);
> +int cxl_cper_unregister_work(struct work_struct *work);
> +int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
>  
>  #endif /* ACPI_APEI_GHES_CPER_H */
> 
> -- 
> 2.43.0
> 

