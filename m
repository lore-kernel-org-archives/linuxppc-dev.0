Return-Path: <linuxppc-dev+bounces-20559-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70AECD3442
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 08:19:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gB4sg1WG6z2yrD;
	Thu, 07 May 2026 18:19:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778141959;
	cv=fail; b=ZLzRnFihGctVVHsvvrsFmfnE6rmsmmL+pbULIfyt9f6OM0QWHXxYiayQDosk4Kwr1WKJXjSyWrB/xBYo3VXJhY/rZnMmmXxZHwtJ9Cq9W99n/P1+aMiyRhw+D7ymF/ySPtwxMf/uKkNQ5+3ykTnFHLHQNM4cENxDBXitZS5E8uWZH+qrkORWtG9+ZkRFQX7id0zPT3EeHkKXvCZqFp6cC55AKQCYteZlfZdSeqTbJan0APfj0S/apO6XKnUVR/L+1oRVQeOggtsWXyYbOz4XHOSxZhnAwmNREF4OlJUTGP86GRfu1TV6tc3+Xc9PBiK8yEiyoOH2B3gOY1oGQOPhXw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778141959; c=relaxed/relaxed;
	bh=iGOBKxch0Tkkff86YHz6xPUYj0cY/2myl784eB8wNfc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XFQT6W/eUf5XyW+iZ5WcRj6KE9IgzrELbegohfg526BwZNNV4HJxEhZOW0e1nK0gy64H4jMVIucJH7KPbJ3YDVgpgjYx7tKBvub0YO20HNw6EDaE75tziCahwtmzguQ+8bFSY9mQtShSIzjaOwzCa9QHagvhbKjJcjQcV65h63e4GbjuO2XlPy1NKtPU5nNL6O3QUNFVQRnaqSd1spd3bFBAKqBDT6ZTPsCsxOTzF2Lw7ipypRJQjrJWXAxsTrdfUXQBcJc3SnARo49eH9yVsC5nvXKhmHRap3giaBv2FaCug53IjlAiob/hRYViU+wh2VJZ06ORHUn5+B6+knZItA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=diKE4F24; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=diKE4F24;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gB4sb6gHBz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 18:19:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778141957; x=1809677957;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AJo5S+h2nMzL/C/3vDvEJ+2zQ2tWdo0vUvH06UOk1Lo=;
  b=diKE4F24KcjeiwcjRQKd57UqkA1lm+iPofxuHa1LFVniRvuuMRKJWfNK
   Abl13Azn/mcdtr7nfTu7tSD/NIkVm7Z9z33cwmO1CWNwlg6eSrhKbMzzW
   Kc4B8YIAf0lUoO/AXl1eD7BhWsvHJ5qNdNloxnWiLF7jrIaGc3/mXlS5X
   x4YraLgdzyNS4T9MvvAODyMOVv+liHci1DLFjToacGRs6QS+tp9E34vTj
   rJCqnAO8Jz6fQSxN85YdIxAuVyrksGlwTlcxViB4qyqnMYoWWMm/btRcB
   1AvOT1hU/f5d79/e4VD6Zr2LBt49r0VvJ5CthTswFKtQWrOQMmGXTAibu
   w==;
X-CSE-ConnectionGUID: 9ZhoNG7GSNSXH8lNVllcEQ==
X-CSE-MsgGUID: 8iEurTJFQt+Gta8xuhgYLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79022783"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="79022783"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 01:19:10 -0700
X-CSE-ConnectionGUID: Exe9u4PJQSy18/kanNdkrw==
X-CSE-MsgGUID: z+3Y/HokRxuQF5I0N5pCkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="231854054"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 01:19:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 01:19:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 01:19:08 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 01:19:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9BNmeezoYEVeclyvLruxjF7fMD7uihiNuBi2lce6doaRa687kD7zgQvme7Kbf99003Ga7cmGARIqplfJJEHU1A5GA1KtpiGeeVNqGgyc7zkyle7uOnS9nWURb0YAyk4QBwKjqEMhMRQOZf4DZgIc/NtZk1Hc4+qyxrpOzuPwMntCwGliuaNi5DWIAKrFE80JBh+h3eJ+1shlIrZ/53TOxPxntOFViVbG8FEIwW3mSQhJj6sNdqSLzgkg3SgW8cijiRKdb4zD1c/MG0iD2bDQ1C9eV5+ZySiGGOp6axhNdXHwprxgFn7NQ0QPVZwP5OgJ5L3pDU0ADAdFfIu3oZbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGOBKxch0Tkkff86YHz6xPUYj0cY/2myl784eB8wNfc=;
 b=h/eEGemcoDTp+lHRNUGX3EjeTleUmKXn4YqJHisBeMLxjjc200o96h2kF2Ebdz6an42k2Aiodl398NYSiBly0KHzOVmBHI0Hed4c0r9TNQqHyvqaSOjzR+AYkf6ItXvpa4ZJtAwGsmsFfYwBYb609/K7diA5xvlalDivhfo4gNyYvnF/NrnKrXerGcCrfpNNR0y1oHEdc5N2VUFVddKwEQbNp5ByQThBlBnDJtInodQ0FoT68bf803IEO4nTha9aM2O+jcyxidsagnpzqmkl+dS6G47BPmkxEGdKbnl6PBJUs2kLjrL1+U/iY40mKH5VmAkQH1IdCNNiKx+blOLlWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SN7PR11MB6899.namprd11.prod.outlook.com (2603:10b6:806:2a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 08:19:00 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 08:19:00 +0000
Date: Thu, 7 May 2026 01:18:55 -0700
From: Peter Fang <peter.fang@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Nicholas
 Piggin" <npiggin@gmail.com>, Fred Griffoul <fgriffo@amazon.com>, Yosry Ahmed
	<yosry@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman
	<mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] KVM: Fix and clean up kvm_vcpu_map[_readonly]()
 usages
Message-ID: <20260507081855.GA362060@pedri>
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <c2fad21764d2561469151f5dd5d35833ae8f76e6.camel@infradead.org>
 <20260427080554.GD1733452@pedri>
 <afjeahNaSG0zsMgx@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afjeahNaSG0zsMgx@google.com>
X-ClientProxiedBy: BYAPR07CA0091.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::32) To SJ0PR11MB5645.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SN7PR11MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf33aea-8e61-4f81-ad03-08deac114a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2iVMN/Kkcg4OsaLGPzR67ppUFP+TKvHTVjSPe05C4WJ7l14Y+Kj17QXhvP1rTh0DgL6rGY0S1b+FKH5f1tcRx18f5L16KMM02GmswbpSXUYivql6p04tLBCxavcNGhk/790YQqcq0EKph6TjHbjXhROoPqGVSLOlhoh5YoO7xz/tS1p9XXVC/QbnVCVyU9FQgYVs+qr7g6LvIXh90Q/WqlkUMpIGGdblQYCQUStpJzk87KmgIie7I8lBbpcjmCTocu2aKgnxDMWZEAQ1Onzyr7OfvR0hz7flRH5JQ6ZwHQyHejDoYAidzQ4TUiVIEL1cYDddjxHGDaFOZ/wWFFDhsIlTBrxplCxzLExWYXPenKOQvY/mvkFVTskCrOsuUCQlrMtUD1BsbM6aYideRndA20THXyAOw6XsGRZoy9Cj3F9MQZ1IgzqCGPZ6crQAQvI2uILrXLxf4/ThwXmtEulNAWD7z+MjszHVTfKau9dQEoQLafvGdkBq4o0SUN0wS8Sp1SQ1JHFrnSyJ6/dgwuYBfC0mb5Dqhh0hOeBJKtf7PXrnFEI2aZjsVPnLXSFClzr7NgTSd0Ylq9f/q7imqLvWF15peh1+Y2x6S7ErldO0iiEjaXyc47wbtn1Duii11o88E4FO7HfLh+3jQr/O/49DunbX62nEWSK2aMhsaj/rdXtmxNdJ3BGX+l5ClV7r1MJq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AP9zToFeVH6dARFwaYN4j9p6Fy8KQsg3f5Zsmrc28vzC3S8nrhtayxPStqoE?=
 =?us-ascii?Q?kofv++4sMkZEyeXENhYQ50KBIsWmF8IBcfladXphcToFM+dFR+Xg/bN3mkzJ?=
 =?us-ascii?Q?3KNsF5EJN0kw6Co/KMtQlAcrMDZnBlIp73GePoVDlkcFJdnk8fTZ9LHe1kig?=
 =?us-ascii?Q?v8loYesv3V4LTh7ZwUyAA3JKZhHbkMWGM+IGU9YWDFwqdRcWMMOO7d53UNGI?=
 =?us-ascii?Q?RV9hzSwiV53mnE+YI1U75ceZC0Y/w85fUEoIKxoBYJDQcd+Hv3FGS7qtIiGF?=
 =?us-ascii?Q?3fxtlEip3WF0goYV8Bp7gtKxYYVqx4yIoyLONUtOa7+wIYdnZk0+z4ssYEoY?=
 =?us-ascii?Q?Z5Q4B29KqQg3IqBG2MBza+trWLsF76pUa2hjztvnDnA2Gtl2y8I7ZBF6qQby?=
 =?us-ascii?Q?um6J0ZNqsOijTfvKk04975DZrO54E5b1rXJryNUoPdwfsjIuRt4hLgtC61P2?=
 =?us-ascii?Q?s0yI+Yj5aJVnF1T/MHBrMZGKdmNG1CeI7zpnIfpgAEflk9ZJTPcUiUiN2GVw?=
 =?us-ascii?Q?Bd5Qt4FM/Jan1MObR9/b9sbYImEFbUlKW0x7+agZ3HkzqsWOaicJa0s6xpFd?=
 =?us-ascii?Q?KP/SkmtX1jqRGcxTTo2hln4U2aHlfiUcZY2g5fCRm5uxzq/dqA9SrIqQy3om?=
 =?us-ascii?Q?66Mah5q3W36+AQr+3cZn0+6AnvnrfWqCV+na7u74G76oL087FuO0jCj9nv+x?=
 =?us-ascii?Q?ggfrD4j/l9kkpa+HeCwXvqzWxD91OtIMhCqGNZhHh9YULQHws633HTEqilW5?=
 =?us-ascii?Q?lDdCDtVbiB938zwfyZGjs9c8YTE6NefNA7K7zjmi/ytXDEBPR5dR+XdoIVpL?=
 =?us-ascii?Q?Iu7oPG9aUAveMfTnVj59woreQPG4SZOyBWrzlvpZKaB1OLiCyDDgY429mNny?=
 =?us-ascii?Q?o2obX56z7M/Ktlpc1Crj019wRmbwdelCEQWYiO87pSKyojxQQOrmjbaVLcK4?=
 =?us-ascii?Q?qH8a9YSCX6LPSFRp6zlcKeUR08d5wOViaQfdxbjL8ulpVFzFb5iFwSEYgb40?=
 =?us-ascii?Q?bNoaaCFwRrI3kMhpGbSE4aWvnj6uXAlbxnkl/JS7V3DOJREJYThT4yhR08Hg?=
 =?us-ascii?Q?APgf3Q9SVKSyRjyYrLmSH2rPbrQrys9HHm6PfY+L1lM63PpPHObb+7oLOXaf?=
 =?us-ascii?Q?FUXIIgc7IEqPOuUBqFhhMFk8e7BRzR6FoMYFM2kRc01Lx4RkeetuB//8F/hS?=
 =?us-ascii?Q?0tyEVp6sfXAeRrss+0cjbvIaTbte3tL1eV16wHckUX7tQUhJePzqoh59ui1F?=
 =?us-ascii?Q?LIaxEroxA4D2UCdvJUpyKueuv1XQGYS/QBb78nYS2tOST+p6+GuKaG7TfoLc?=
 =?us-ascii?Q?cK6VjFPVhao96Jh4ZPaJ5kLSh8DEPV62m9t22M7kmxy1J3AJq56P07z1mPx0?=
 =?us-ascii?Q?WE7aNtMggW4cCrJ9Jvk2e08R5zQZIbh6s+TDFzbzf+mQGDdnAoijRanQgJru?=
 =?us-ascii?Q?rzRv7m0lDXmdOIQ5JCftdhVbBL0x/43muQbEHN/ZJ5AuoeLAgHKVoMk65cBp?=
 =?us-ascii?Q?Q+Mmld7Ck0R/8deTFoqkj/aNspy3JxYKsBGjTAje1Q9xES6REC8iPy+tw+cI?=
 =?us-ascii?Q?FZc1OF68z6SEfWRlQZJbhghTZ2GeNQVtrFROkiwGyDjqA7Jy+PFY/EClaB7R?=
 =?us-ascii?Q?A9lJmsgAclVcBDD4++XaI+7euUic24cYVpxxO9bQpzLNOfufH5cUry+sgkZL?=
 =?us-ascii?Q?QjkvKj+GmfS06USxU9W6/C6n3JPTZbXVheuN6aecwkUOcDrRcBYjM+A+/kIg?=
 =?us-ascii?Q?GkE880WndQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: EnR8ogN5Y9wl54CTdfm29xhVTBKOvZGSeVWL4K1Kh98WQh0GxKB+m26tdFLh7x6uIjSSaUJ4Eh5PLMrp/j/HwHLn4pbChzkchRAzj4YQC4mKzs2eZxLWfbSixxxzqhPK+YCD9s5zpLNQB9oHgLQ+YfWXlt8ER+kbmnXt2Wus03cvcxwdjF7JQZTLd6FPHXPljs0EDTXzIcXhcasaFqhFBTGr3NJ7JxMqX6VyrVLbggBoQJjJnX/Vaa4lTU+7YDJDpnTOeTW+hVEo2pXhD+jqdguzUiehVKlGytNB7sGYO0ufRlTTqxKlvWjyNVl2/m/ZKbBJJ7WXMUAjDSx4RgH7Sw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf33aea-8e61-4f81-ad03-08deac114a86
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 08:19:00.0803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkCCmADL5TeZE2WX28mZ2rI8daOwNYReBgZ4ebG3dpGxrrodEOlMgdj40fZLmUbbVD8kCOiF3Z93OdOou10xbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6899
X-OriginatorOrg: intel.com

On Mon, May 04, 2026 at 10:59:06AM -0700, Sean Christopherson wrote:
> On Mon, Apr 27, 2026, Peter Fang wrote:
> 
> > Thanks David!
> > 
> > I think I'd need at least input from the maintainers on this but just by
> > code inspection, the kvm_vcpu_map() usage in sev.c seems a bit tricky.
> > Unmapping doesn't happen until right before switching to the guest, so
> > this might fall into the "keep the mapping around for a longer time"
> > category [1].
> 
> It definitely falls into that category.  But that code is also rather gross, i.e.
> could use some cleanup no matter what, so I don't think it's a good argument for
> keeping kvm_vcpu_map() around.
> 
> To avoid a bunch of pointless work and churn, let's hold off on hardening and/or
> renaming kvm_vcpu_map() for now.  I'll take this v2 as-is; even though taking a
> gpa instead of a gfn will conflict with the nVMX series, it's dead simple and a
> worthwhile cleanup even if some of the conversions get discarded shortly after.

Makes sense to me. Thanks for the review Sean!

