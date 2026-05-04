Return-Path: <linuxppc-dev+bounces-20397-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9A8CD3423
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 05:15:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g88wh2L0Lz2yZ3;
	Mon, 04 May 2026 15:15:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777871716;
	cv=fail; b=K8wEQA546kYX2kNT+B+n8uUlPTQZBEunU1S2zBnmgxOPF/KqWfhR6UFCu7eudYO7d8avkfoCz79G14gheAQ20gw3XFCKAX/x8qOE1OueJLc/9MgN88mjbgdnSr7y5M+pvQ2R1Rzjt7Pv5SW79ZOAnMzV1bpVD5PNtCU81SEJWIvcS617+L7/mNcgGoCDNrKxZtk+KZbm6SqU01VKE5MOfG5v31Vqk/LAZEBqZsXBa/nna7Se/2tKy0MS/gwZnB8ZYW8PIJlgsMjU7FLzOHE13SRF7cQycoe9G0nyPxyUOZhhG7OOQjb47aIczBPAj3Lf0/5zOBF1SptKlKQhejdOCQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777871716; c=relaxed/relaxed;
	bh=nraTbdexcqi7G4WH/h2BIIalP1I4FsW+udMl6f/86bY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YhHgkqQI9JBltdDOPm1y5vPG8yqBgtLQ7SyfPdzXBHH6zuosJUIAs0t4yhAgeBZ8o+Gok0E/azcRKgpHKW+mE1AqbFFJWx/RZCZQ7GsMYuFKI3ltMsqsgrOzu2YnWTFNCs/Yi1dj8X+E1Qi9/jCWANPOjtSYs7yiNKDiLl85QGg3ZApgeab4mqAm9Fj9IbcTIMBKDghtPgt1AZV+cpr0Ve7beRIxy+6OYyo/KtrWE55J7QM9nESFyxtg5R0UoCc+XRO0BxHPo6YljiNYEkUXKJiG3EKaEA2pTlgI7w5lRKW9EojHN0kmPvwjNyI41tYucIFW4bd5JluDjx2LA69vMw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T9ugF8yA; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T9ugF8yA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g88wc3WWBz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 15:15:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777871713; x=1809407713;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cJYe9SRPhxJsvqVmfSYon+HasJV4TcZT01E1Nzxe724=;
  b=T9ugF8yAZ7Waug6dFO+jzkUcVTf4cze3Pt/95qQrnnUjY/lpeIk3Z2Y/
   OzSCCgA0Pp6fgcEn9OyQffG/YvfWeuPBUJamILzzzafzSxgNTyh3OPxFi
   tI36YsT29zE9qo8TDEZnbhk8sOngHud+6narz2zcQ+IQXUASreQLePLkt
   4hugVMgdZKGyqWA27Q5had0M6i5oCodTIXlQu+wQLZOfb3UymgIT8ZIbN
   Iv686ViXmf/e8DJ6sjUgrg93sRDMKuGYQp3cHDHK/JghwBTBlg8r5hyX8
   L4QjBt7B+MuRyQBBSRL4j1ytVEpCGEPOdFJgn7i8ZNtinYvgixncfqrXR
   g==;
X-CSE-ConnectionGUID: Me34Oi87SE6kI4wY46SLPw==
X-CSE-MsgGUID: tHoyiiRSQoysefZMyCs1oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78659214"
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; 
   d="scan'208";a="78659214"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 22:15:05 -0700
X-CSE-ConnectionGUID: YhNGT0g/SrmpHvXX8actDQ==
X-CSE-MsgGUID: +ciTwBYzQjaS8a0uuDCPRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; 
   d="scan'208";a="228915246"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 22:15:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 3 May 2026 22:15:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 3 May 2026 22:15:03 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 3 May 2026 22:15:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ob93DoafvVJk0KvpwzvB+1gLfSeVBiiUHRG82wCRW1s1nKxnzBybWloVciZBn3I6FrcBiHWumRjQzBoIBMU4V95IKIX17kMB2hukCERDowphj4LAA4sVdrElI2QozUwX+e0IVg3lkT/rV7BDIRQK+8BKqzTPTMxIWg3pFHEwbpAE5KBZ9GDUC1Vn6C2frXWx3raaWxy9GF5UgxBLPVUB07n3LdZj/hm1CZVUaLLoI/tE99xncDVt++L6XX1KkSurvE6ZwLGpq7TiIq1P9mXxhrHeizgzqpNrJckcmhYdw0dUJ5tdtpYRy8K+OS74Eqwh9lu3mfm1rx/JyrOfvE+ZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nraTbdexcqi7G4WH/h2BIIalP1I4FsW+udMl6f/86bY=;
 b=XuTQ7ZWI+RV4Q4cJmNvwyWolk5bLwxKod0okJLP2DziIx51dmX3LbZhZK7xWotL8+oWlHETRyk8GT3l7hwnDe+pD4euCWWanzv9+nJvL2Eo8Z2wiZnEizebmxChUhJZXuEt6/Z/uOlORgQEdofT6cNStDuKerOhv7oG+eIvkzgrvR4flAPD/Ail5Twf/tcJNh6enh7bPuJPDFJa4ciyQh0al74rlqXgAEnOOMOAJNznMrS3nZ2xOCotAQqFpAaSg0euSHHR02Q1xXy7cdhtKQpClrGQRvnM02EIp3yha47nPcJZSMZbk7uPgPt7N00vEAeFX+M4D8YuVmbe5QtQ2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB9660.namprd11.prod.outlook.com (2603:10b6:806:4df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 05:15:01 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 05:15:01 +0000
Message-ID: <712411ec-80af-4ac1-a27d-10866340bfe9@intel.com>
Date: Mon, 4 May 2026 08:14:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] powerpc tools perf: Initialize error code in
 auxtrace_record_init function
To: Athira Rajeev <atrajeev@linux.ibm.com>, <acme@kernel.org>,
	<jolsa@kernel.org>, <mpetlan@redhat.com>, <tmricht@linux.ibm.com>,
	<maddy@linux.ibm.com>, <irogers@google.com>, <namhyung@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<hbathini@linux.vnet.ibm.com>, <Tejas.Manhas1@ibm.com>,
	<Tanushree.Shah@ibm.com>, <shivani@linux.ibm.com>
References: <20260502143237.23456-1-atrajeev@linux.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260502143237.23456-1-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0289.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::20) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB9660:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b01014-94da-4b86-4af3-08dea99c17aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: r2+1NtawlIS6b3f7EpIPWYxBLsD5DQHByKpMUq2p/OnXfkycteOKmpT24Hdmbc3li5AQQir092TfRQ2H1iZn0c8SkuKufm1YI5wUjbItJPZEDzkoNnVGF3SmdqtDqWNp/bfTbmVAasGxlBYR3aAVpu6Hl4HxgvUUEC130Xb2QJRN/e/AsilmAA092DCsmVzqDRzbXyoiZgJ+bLEJ1pl1OFV2h/FRNXbeITTxT0D7uen8HiMib6AhYalHj4TXsOBXRq+HXl8CxL19ivQ78wRXjlio86tHa7kabzN3+ONqkXMMGt66od+JIQdu5LrDMoFUM0sgaBO/cqlY0Zqu4+9NG0TdpKSvoVy3VxLnG8RoHx8I4d31va9ODjTJoQEAy2tsDYeufmTNVE+/aIVtFfSp1AViuN0EC9JaE8KBqaz3HDS/XXndUgoVR5A2zGvk74e/IdpfxUfJfD4MnChgX0GrYR4Yej5tPSuVsQS6ONPAt4lZxOFXBgpQ88/W5pg2JpSjwk/JEoarpbDzFUkLKLD3PByPujbU1eowQEob2nbhL2tW+ku7hSrF+LzZqU/Ps6x9/IbApKYs9pc/jte4n8h/4+/XqJyCgjnOEOf3m1P4bTf1+emuIv+qBYwtbcrr/MNGvKyNRUajTxAhtgujLPROI5DQAxduM91HOWGVBx1wUKs26CjG0+C0dtEbRvNaOosa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTNoR3l3eW15WlRlM3R3Y2pndGtQUitldnBMNEp4cTBnZ1BteGVVc01LVHlu?=
 =?utf-8?B?czRTVFJNQitiTDJnb2lzcEltT1JNZHJPalcydUVwNlgyWVJDRG4wS2I0ZWEx?=
 =?utf-8?B?ZFM0OXpOSXlxbk5keGJQRWVHb3BrNVR2MEgxYTZoR2VKWXgxY2dlbjhKRm5L?=
 =?utf-8?B?Q2U5aXJXWXBRWVRTWkN1V1p6OHBNd21USTN1TlFJY3BtcG1EeE1NZnFHZW1I?=
 =?utf-8?B?clU3TGtXMjErek1Wb2xyY1NPSWFWVW1mVGU4Q2VGNDBsOURtYW1TQVRvKzNW?=
 =?utf-8?B?UkF2U0ZlOG5YU0tpWFZaL1NvdlpEZW8yMGZWVmk2RDlzdWc3dktLZnJLR3Uv?=
 =?utf-8?B?RklxR2lTTko2Nm5OMlltQ0JzYSswYk1tZW9WNXV4SXlQY0tlcW0vb0F0QnAx?=
 =?utf-8?B?MzdueVBxVzZBRm84RzB2ZWJhRVpBL01OWUxIVTZlNDZPN2hnWHpBSkdlMFpU?=
 =?utf-8?B?Vk1tdm5uWXIyVGFHdHpKTjVoQW5PaENsYWlZZUZ6QVNXdG12VTVVZEVTTnBQ?=
 =?utf-8?B?TDJjalZtVUowenpWWWtkNy9BS21xcjJ6cGUraFRaTXU4bHVacC9KbkxrM3o3?=
 =?utf-8?B?QmQ2NUFQRm40K1UxVFZORUp2d0dpSng2S1hpMTEzSFBwbHVlL1BRSkVSQWNU?=
 =?utf-8?B?d0lhSm1jRHlhNlk0WmljbFJVNVpYSmRCeDNrTmRPUHQyeElpM0k0NTM4Zk1s?=
 =?utf-8?B?RjhwSjVpc0JrMENmYTJvaWZ5djBXTENVeXpYNERwbEZKSlYrU3BZQ01qanZQ?=
 =?utf-8?B?U29ST3haMVFTeVpEaUZYdkxlOUU5RFNLeEdMdTdrZGZRTXlwdFdlVkx5YnJN?=
 =?utf-8?B?bk5Sb0trT2tpaHV1TVNibVB6Vy9TdDYzUzFBT0VoVmJJZ3YzVFNNL1R6OHJG?=
 =?utf-8?B?elU1elB0Sy9lVFZ5VG1yZ0RoVGlJT1RHOHdtMDFlN005VnNDcTFQVW05MHND?=
 =?utf-8?B?RXNGZ1JvVS9jNmp2SGRBQnVmeWxBUXR0SVZuWEtPU0FPS3NydG5rbjROZlV2?=
 =?utf-8?B?RXVJbC9VT0taT013WjhmNmpRMmRrYmREdjJGdHZzVlFPNTRHMWdjandkQVlT?=
 =?utf-8?B?U1IrRlBzNHoyOHYwSzFhQVdJenZ3QlBWT2x5Q0ZYd25YL05veC96VFlTTXMr?=
 =?utf-8?B?QmFsaWF6VHhjUlRTYmtKRGUrRzhyZFJEdXozaEY5bllaOE1WYnVkeUFvQjNq?=
 =?utf-8?B?c0pRaUpSQnZZUXFkUkJXdThlb1ZQVHdKdFVDbnNZaFl4ZjRvR0VDS3ByMXFD?=
 =?utf-8?B?dGR2RkFJQlJRRE04YzlOWjNGMTdyTS9zZUJrakxyZzFuc3Q5ZUZGYjRhT1Zs?=
 =?utf-8?B?cktENys0R1BTZEhrQ2oreHJOc2NEbGxNZGdJbGkwWWVqc05UNWVDd3pEMFc5?=
 =?utf-8?B?SzVMckpVNHRmdS9aNXhzM1NJaUdnR3kzdkJOajhpNktnbkVCbFV6QTQxMHBn?=
 =?utf-8?B?VXVtMDZRZmxINlc4S0xwZkVaL1U2OFZlNlliU2hVbFFYRnhPNlYwaXNOY3lv?=
 =?utf-8?B?ZUxmanI3eDNJV0oyQ1JrS3lOY00zWWFWZ1pBbXJJR2FwN01ZNTlkVGIwYVhh?=
 =?utf-8?B?U3N1c2xaTnBIMEMraDY5QWRCQkl0YnQ0aWdoMXZrUVZKNWd1YTY5R3U0cHQ0?=
 =?utf-8?B?SG9sRm5DWWJrOWtnRU5xbnRONmlNOE9NRlVTbW1PWkExUS9WOE9DZWl2Zjd0?=
 =?utf-8?B?UkpEMVVtb3lIM3VpNWE2SjJQRURYdTlLaHppV3UwYkxNNEhWR1Vlb01LbnE1?=
 =?utf-8?B?R3pJSW9wcDRnV2Z5b0xYcDhTUjhTQVZGNCtlVGZWMnBBb1hBZWZsem5PV05P?=
 =?utf-8?B?UXYvNmFsNVJVajNWb0pFNmdkWXo3MCtZblFMSzdrNm5SekswWHdjYmZ6dFU5?=
 =?utf-8?B?aGhDM1pJY1hBVmhPa29RQTVNSjRncDBod0RMWUVKdWlGWlNEaGlHRFYvcGd4?=
 =?utf-8?B?Tk1MMWRpaEh1Rm1VM0c4bGNEbzFnUTNPQ0FGNFJaOWRsRWtraEhOenh1c0FR?=
 =?utf-8?B?bXVhSEg3UzVndW5VQ3QxajRORXhQNGliS2c2VVRmVjlIZEhTUk5EbzZ0Vzla?=
 =?utf-8?B?YzVUbHRCTXl6RXpjdFlqcnlYWUhORkcvT1ZBaWxpcXNBeENpSkpIL1hLNmNx?=
 =?utf-8?B?UHc3M21ERWxaWUhrTHBSS0pucFNyd0RDcVRJSWtzeStVc2ZLcDY2MnUydmRI?=
 =?utf-8?B?VmZ1RjFzZXlWYnp1Y3lDSDBGNFlXckVBbk1sMHpwalcydDFUaEJwTi83MFZJ?=
 =?utf-8?B?UGtDaGg2TVJjQXFFbkQ5a0pLbTRBN2tIK2dIZmVUZzQ5Q3dJVS9pY014MzV6?=
 =?utf-8?B?bkQ2clQ3cnBJR01UTTZvWFNjcENseHV0a1RyT21YQnpOb0NMUWV4MThCbmRB?=
 =?utf-8?Q?6GOs5j0F1nLUQXAk=3D?=
X-Exchange-RoutingPolicyChecked: s4XsKjsqlFMk1+2dyAWYBSY0rhEn4cgtbRwl4+mTQNkPz0zcInWIhOzMaDEKGrkmaZZ6pxpbseWMwbsuLXYttafwsaTcvK/rKmNTqlE9PmSojGwl7NyQ7+xeKMYFsilK7WDGwZuYo5GSiY+n4sq5lgf5IIkUwDhgQ/7r876hh2irsdizjk6Ccv5NLA11TGIaZ6EmKkzPBXVwjiKB/5XNs5vJbBqbJtJFHlBorBzFiEBYLqqlyzLKY1HODCzcgCHN+05k2Q0NUCxlWakMwKF2uVbM+VRZxEUZQijbkmcYnlvFAX2oLHHrZXFVghgNPl4oQYbKUGPkm6SL+kdyTcLO+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b01014-94da-4b86-4af3-08dea99c17aa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 05:15:01.1979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTed62l/1LhrB9yJwmef/Eoy8OMHytEylXIB7Lzbp97rrNkYGEIHt9fDu21nn9cL022oMI0UC5EmdPa0r9obsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9660
X-OriginatorOrg: intel.com

On 02/05/2026 17:32, Athira Rajeev wrote:
> perf trace record fails some cases in powerpc
> 
>  # ./perf test "perf trace record and replay"
>  128: perf trace record and replay                                    : FAILED!
> 
>  # ./perf trace record sleep 1
>  # echo $?
>    32
> 
> This is happening because of non-zero err value from
> auxtrace_record__init() function.
> 
>  static int record__auxtrace_init(struct record *rec)
>  {
>         int err;
> 
>         if ((rec->opts.auxtrace_snapshot_opts || rec->opts.auxtrace_sample_opts)
>             && record__threads_enabled(rec)) {
>                 pr_err("AUX area tracing options are not available in parallel streaming mode.\n");
>                 return -EINVAL;
>         }
> 
>         if (!rec->itr) {
>                 rec->itr = auxtrace_record__init(rec->evlist, &err);
>                 if (err)
>                         return err;
>         }
> 
> Here "int err" is not initialised. The code expects "err" to be set
> from auxtrace_record__init() function.
> 
> Update auxtrace_record__init() in arch/powerpc/util/auxtrace.c to clear
> err value in the beginning.
> 
> - Clear err value in beginning of function. Any fail later will
> set appropriate return code to err.
> - Even if we haven't found any event for auxtrace, perf record
> should continue for other events. NULL return
> will indicate that there is no auxtrace record initialized.
> - Not having "err" set here will affect monitoring of other events
> also because perf record will fail seeing random value in err.
> 
> Set err to -EINVAL before invoking auxtrace_record__init() in
> builtin-record.c
> 
> With the fix,
> 
>  # ./perf trace record sleep 1
>  [ perf record: Woken up 2 times to write data ]
>  [ perf record: Captured and wrote 0.033 MB perf.data (228 samples) ]
> 
> Fixes: 1dbfaf94cf66 ("perf powerpc: Add basic CONFIG_AUXTRACE support for VPA pmu on powerpc")
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changelog:
> v1 -> v2
> Addressed review comment from Adrian:
> - Set err to -EINVAL before invoking auxtrace_record__init() in
>   builtin-record.c
> - Added kernel-doc to auxtrace_record__init() in tools/perf/util/auxtrace.c
> Addressed review comment from Namhyung:
> - Added fixes tag
> 
>  tools/perf/arch/powerpc/util/auxtrace.c | 6 ++++++
>  tools/perf/builtin-record.c             | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
> index e39deff6c857..4600a1661b4f 100644
> --- a/tools/perf/arch/powerpc/util/auxtrace.c
> +++ b/tools/perf/arch/powerpc/util/auxtrace.c
> @@ -71,6 +71,12 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
>  	struct evsel *pos;
>  	int found = 0;
>  
> +	/*
> +	 * Set err value to zero here. Any fail later
> +	 * will set appropriate return code to err.
> +	 */
> +	*err = 0;
> +
>  	evlist__for_each_entry(evlist, pos) {
>  		if (strstarts(pos->name, "vpa_dtl")) {
>  			found = 1;
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4a5eba498c02..708825747af5 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -865,6 +865,7 @@ static int record__auxtrace_init(struct record *rec)
>  	}
>  
>  	if (!rec->itr) {
> +		err = -EINVAL;
>  		rec->itr = auxtrace_record__init(rec->evlist, &err);
>  		if (err)
>  			return err;


