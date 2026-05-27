Return-Path: <linuxppc-dev+bounces-21598-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A208CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 16:06:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQZHL0GSfz3cWv;
	Thu, 28 May 2026 02:06:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779897981;
	cv=fail; b=eASYlkCjuiQFHNBnKVrY/4cd+DM76A4JiF2WAfbS0BQpTN0edz9IxR3bbU6h1h2tlJjFLPFdbDTFQ1b5pPrZlVMPAat4eU8yjSR4xzkeJiK6sSDMJ6yRjqW7aHaTKangl5UjmPuMK2+oeeJ70UPYwUZ8kKGKJsjq9NvRwCDETWdIjTGCq/3yZK+oRN0p0k2BgH7KXkcGM+K2KgG8B1aVpOMqMRtf5zRglOlzIF2DVqVWEpBb3HvNY489ogUsT8BQ90fM1XVwwWrVIDB4PHCiIyKFtT6LAKo4bArj2VMnsvShRS8MTv/2QiYP3/rIIuELI1nBHhzd8w5XY7+1PdoBKw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779897981; c=relaxed/relaxed;
	bh=eglvJTCGsxNalR7iMZQJVw9xBzHnFUcAlVnEVpfq2Ro=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nd9qXK8NdXV3Acm8Dw5TZGD71/co1BVhTscRW+ahdviadt9SHw2VEKURCtFABmsooV3vZ41P2q/GubqgiPi2XvKZ3gls2Zach2cyp3NRMEBG+OB3RWcWfgpCzZKxLLSiVzfcDv7/ccafhxLAcS0CpeIyy/zmMSKREoAq8eyddMThvjRTk7TzQstDiHb7hAN32hBqjBpZ75iyTxPMHIOQ/khf92KkYK9vnhApM+GRnn9wXm2olxkSKH00MsBiKkJEb6lwVOuA8rNZjjA4U2TuxmPBG+FTY8YFJiso12IRQF5KPgtb6Gqgc0U/iKoi9FYmQKgcmCVCrwUOOsgGq5YZPA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b57OzJ1m; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b57OzJ1m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQZHG46dwz30B4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 02:06:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779897980; x=1811433980;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GIYdOSkj96LAnfrTGGR+MWobQNlGKNxXgaAEjYgngzY=;
  b=b57OzJ1mrvxzlxY8Ga6qoWaKzSdD+tKiIxg9I605fa3XPJio+oor4F/Z
   nTRRuhpn1J82pZj7bXOYNMP7q+1xYvD1ExkHOuxZucE5KVKxu9gmcXeAu
   yVoRgWn5MslmLKYyugKME3/oCUBeHgNKorm3y2PWRnlqp/y8UHSE2wC4x
   nBaRQvmEjaUzPE0TkA9tmY7yJWOcIiQJtuWGOuVuE0AXS20sZQ8wVV1kE
   3zgL7T4yYZMmoYsaKZeTBIq1WTRkANWdHIhME4z6NAVAMaXUc3NWLdSjA
   lRufoTiySwl2PnRuKbGMg/SLfEf/0vdzd/8C80nAFezkjbhN8bx3lP5m8
   Q==;
X-CSE-ConnectionGUID: Qg5dy3tnSu2LgvS+H/5CIQ==
X-CSE-MsgGUID: X9G/Flp7RJS+U3wR821xoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="103407385"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="103407385"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 09:06:13 -0700
X-CSE-ConnectionGUID: B8zHrDEFRqeQf0ZKKG322A==
X-CSE-MsgGUID: hfcgSci7RgWPArJooLZmgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="247357996"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 09:06:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:06:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 09:06:10 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.31)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:06:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4Aeg9YKD4RG0TZjPpehyAkIuQjCmB9Jgj8YIfMJ4UbyYN1AUaMzLvQMyBAqWZUKLNJLZ5GWwRt29/8fZdrtAaSZ83aj4iMNL1YqhjzddFXhTV7usTsl53pzPhCXCBjS3FHp+A9rTiaZfH50RncbHoymTNJWngP0Y/Cy7x/9VZ5RQmjdtA+mvcedzivQodcWAIdySucrzjcX532eEDElBbH3Itlxigy4aBydWy8kCRLihvnTGDjfR1HLp5yfJ77a48tbf3bJRY3E6pGiY6nnRtesAG76Cdixdzz5OVaiNf+iqk6QaEdB3pwB28ICjxZj36LUviBklNMoZSOrjCOPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eglvJTCGsxNalR7iMZQJVw9xBzHnFUcAlVnEVpfq2Ro=;
 b=rFFH66zUhHAc0ht2dTrcPoBA25CytGq4jLd/hjardS0HDXVnjgOO0a5wO3oxpeTQRQKzCYI8On0UR8rEWZW0wdhUXZd8T573uFsWqMOhUa+p0347+eXscPZ+vh+8vR1TP65oFsTk1YlfhtLUMs8gQA0jHS6CVnBRYeCCqqjcZZRG3WB4q1/5itU8mF61tSnM2Ed4BUNoDXcAMkSXBs1DEehg4I4iPq3c9tEH3w+A1yb4ZfEcreKIu+LQw8t7LSVZjIPruLr9hQiPBdzIHBlw05OC1h9p1DtnQ3aHsL5LAtgcDisEWChVacZ8t6WP8fx3Wz2OVj/hUSTHYn2F1zWE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CY8PR11MB7083.namprd11.prod.outlook.com (2603:10b6:930:51::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.11; Wed, 27 May 2026 16:06:07 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 16:06:06 +0000
Message-ID: <912676bc-230e-410f-a5fe-153b0f304aee@intel.com>
Date: Thu, 28 May 2026 00:05:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
To: Shrikanth Hegde <sshegde@linux.ibm.com>
CC: <srikar@linux.ibm.com>, <venkat88@linux.ibm.com>, <maddy@linux.ibm.com>,
	<riteshh@linux.ibm.com>, <chleroy@kernel.org>, <tim.c.chen@linux.intel.com>,
	<peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-sched@vger.kernel.org>,
	<kprateek.nayak@amd.com>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <ahUogeqIq5km7JSr@linux.ibm.com>
 <058664ab-0982-4c13-9d4b-caa2f7616b0f@amd.com>
 <20260526140856.139657-1-yu.c.chen@intel.com>
 <d45877d5-86f1-4581-b3e0-59ceb722de3a@linux.ibm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <d45877d5-86f1-4581-b3e0-59ceb722de3a@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0035.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::7)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
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
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CY8PR11MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc7a18c-1161-47a6-55a0-08debc09dc26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099006|18002099003|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 0FX4+MkxWiI4ogBNV8zgmdy9gEMMYa+UGt8Mq23q9d0XgsrD2bUH5jilJXMWecAAb1oeBPN0Mk9ah9A5JQklevYl1/7MOkjW/NZ4JNvKm9YH0h47T76sNfcnJE1EbkMaoGQqK1+e74uWDkMEup37X1i+Ji0zNUNaSy45SjAuHV+hP4nJZNWLdvUZAJAy+NIj80h5MX8IJE/0gpP5fF2sFxjdRXc0V/oNztL0gOt/Q2DwZzCeixCJmmaMdE50YYKpdf1OKDDlqnbWk4LbMH3z7mxw6j1Q9axRYDNkngE5UwkUnpyESlgLmbX0Afd4PsN5bLMzVOzn0Wzlf4vzepTjbKcs2uugHYkWUvLjh77BF12xjoNUd5C63PBbCrCg1lwkqhde9Lg3bYC4fHra9mQA+EZZAuBN+o/8cF4Yn7Eo8xTJU3Fendw5ae7iQw2Adv+4L6eKRRmjV8HVb0CI/GWoM9Nazy76aEeiu82Uwqm1t8MUUiS/RtX1kQMX3y2ZC2F7THkAg+aI0W19ee+hRKynszR4ZjbDc+H72hNF68HtY7r2PPftX6H008dpu05CHOborCPH9CghOLEUu4tX2ADaUBBeXfRwI7GUpqb5DB21MMxbZVG9C0kIhvtB8eNkTAFyb/AeOPngQ11QSU/LkKI2Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099006)(18002099003)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXJQaVhEVXhuNC9XQ1loN1RFMXFZVExzTDdVeUVjNFFvZUx0WjNKQ3VNcFdL?=
 =?utf-8?B?WUk1YXhEZWhEa2VEWHh2N25IMFFhVTkyd2hBNUsxWTFQRzhPN1ZkSUtkL3Fm?=
 =?utf-8?B?MVkzeGNYVjc3OVB0Y2lmYVhtS2FWTHZGay92bXpPYlpvSVZvRGxqVWNsaXNv?=
 =?utf-8?B?Q0tkM0FlK2lwTTd2WXgzYkl6QkxhblVrNTFRTDhqQzQwazNrT1ZTOHJ6c2du?=
 =?utf-8?B?cm9wQUc1OGNQcEpISWZkTktEeU8wWGk2STdtZmxuOFUvbWNZUlBOdmwwQ2Rr?=
 =?utf-8?B?aDVCb0F1dDNINGtsaTB5RVlhYkZZSWtXR1ZGNzRZc09FQWVlTW9sYVhTV0NV?=
 =?utf-8?B?QjdUY0g4MU51emRaQ2poNmVYWVJBejQxYTdxQ1Zhb3FwVHVzM2hTL3QyaHpr?=
 =?utf-8?B?OWd5V0pJaHUrakE1NzE2L3JxRmd6eTVOZ2RsSWN6bzY5WjBxc2VXbkhRcTdK?=
 =?utf-8?B?QUZFQkdOSUIzV0szNHVjK0RlSGsybnY0dGFjelRpN0VXNHF4aHJDWWcxaXpO?=
 =?utf-8?B?REJNYm9lWFVLU0QzZTVYT2FyaGlWNStHUTFmbC8xZEw2djFDd2VXZDVjaGw0?=
 =?utf-8?B?UG5vakovY09KVWxaeUk1Zmt5QnRLNXY5Rk0xWVZtWmJRQlArRWI5amJQNHNu?=
 =?utf-8?B?enNQd1dma1ZhV2pSeUk3KzBTeW50ZWFwaXBkOG5vcm9zNlNyanJHR0EyY0dy?=
 =?utf-8?B?MzRDY0VWS2JpTjJ6Q0NWNzVJTUZrazVyVlQrdnV4SUJLdC83Qm13R1VSbitT?=
 =?utf-8?B?TVJUOC9aaFNRZHVuVi9wZFMrWkRLdzQ2K0VVTHZIbEFoRnZSeU5aRWhETFp2?=
 =?utf-8?B?R1U0NzRQL0txV2lnTmVWUzFMVDBXOW9NZFhLSHlZazZxd2dMcmZ2ZExBalNB?=
 =?utf-8?B?MDBhNFlIM2czcVQyb0h4ZGY1TlFCOVUzbis5MkNvRHBOMkJpWU4wenFhejVV?=
 =?utf-8?B?WWFac3JZQmNVU29sUmhFUkgyVjYzV0ZPeS9TYWk4dWk1bE4zQnZ4L0l0Tnc4?=
 =?utf-8?B?Rm9NczNEMmJHeWtWM1I1dWdwUjNpSzdkQnByYWQ4ZlpVYzBFanV5V1VYN0xC?=
 =?utf-8?B?b0xSai85QWJRSDRqSUtQanZsazNoOU1QdEtCNEF0LzE4ZkIvK1B2dm1zRVhp?=
 =?utf-8?B?R3FnMndGdGFMaFdmdlRkZlluQkY1Y25RNFRPcDZINWkycW9RSmJFWVZzUS85?=
 =?utf-8?B?cTFLYlZvbEV6L3dwWk1UV0tjQjZ4R0pEWmQ5U0FoMXlhU3hVVlJMTmVmajFO?=
 =?utf-8?B?NWdLMFh5azN1NzFpMGQxRmZtejg1RXRCS1VuV0hNY21Da3FueDhtamVqUmJ0?=
 =?utf-8?B?MFRKNlhtTGlvdmYxbm5MbWYwc2RhclZtakIrRkZNekxjYnVzSUFIckVOdUx3?=
 =?utf-8?B?dnlyRHJGYzdOTGRBTjNNSzN4OE9qTVRLMXdiR3p1SENENnBjekhZc0tZSjcx?=
 =?utf-8?B?YTBRYXVYbUFBV2ZwbEE4a1dhOG1GdU1sR3hOdkhtazRYd1NBeEFtbkJVUUFO?=
 =?utf-8?B?QUlzblRWWlF6VGpCNGl1akZqK3RuT251TUV5WnVJVVc5YlRZaExlUm9wVmRM?=
 =?utf-8?B?MC9hdFA1SEFnUTZ5bG1ORmFmdVR3MW55VS93cWp5UHRSOTM2Rkk5RmNQYks0?=
 =?utf-8?B?R1J5dWY3YnRjYmo1Y1VMZ0ZacXd2cGo5cFRrMmgvNHZ4VE0zbHdDQW1oVUtO?=
 =?utf-8?B?QnpDYUdBTXJPbUlOSkZScHFDUnMxQmlPVHhNQUx2c3hYaUlKWHFjTDdCYnQ3?=
 =?utf-8?B?ZUxCd1gzMyt4VXBUWC9raExuSVB3cjZnYVVEeU9YcGRHclRINTR5UnJnbWpX?=
 =?utf-8?B?VCs0QVFETTRCQ1N5WHZSdHdTL21NUDg2TVZLVzFVSW1yTnQrQ2s4c2hOUGlF?=
 =?utf-8?B?ZTlxTXIwN0crd1lhZDRMWGpHWVZmODlVYnZrQXVSWGIwcnVoTzFYbm95WHVL?=
 =?utf-8?B?S1F6RDBUOE1ORWU2ZG14cFY3eXVWKzduOWd2QmxFalNOZG9wWXhCVHB4d09L?=
 =?utf-8?B?cFlZdmxtVlViR0dMTmpSRWU3MlEwdC91cG9LRGpFN2ZqajJ3NTM2TVpXWnY3?=
 =?utf-8?B?RVBsMVlybDdRNWdFWkU3K0pBS2pPTmcvdS8xeVNKR1I5eHdWNmh0Ukc3OXI3?=
 =?utf-8?B?Vk5NVXYrSHNLYkRyenFtZDhqSS9NUTJYSlZFNmJtWk90YU9mdGFpbzNERmRk?=
 =?utf-8?B?dkw4T1BIWGQ4d2tuRTdtMjdjL2QzKzBSOHFLaXRFYkN1dlU5K21INjFyRVRq?=
 =?utf-8?B?c3IwOVBHVnU1U2J2SVpxOHlxaGJmZVBkRjh1UnZzUzhTMXBMSDZxZjlrZHB5?=
 =?utf-8?B?bmt1cGxRdGUrMVBZQkFwTFVKTCtrWmFTajZHSkVvb0NHSUdGMnc5dz09?=
X-Exchange-RoutingPolicyChecked: gT8ApqQ9qd0HTsWf/+e9rT/P0yNNfxP09WKQ3q2EAEMMi6pxJMuM7vKXt9DSvDc2lU5Bxde2bzXRqVOecA8VgpcWy9aLeQc4AALTUFbn0uOh3iQe5eaYOIXjWuycWrELpZgi97pCxJxVge7MDylei2Wh9wgyr8DgVzvrBt7a6uQC+3LytJ80KKpT3AGmIWqza4RF5+2cGKFyEcrH1IogBMAY1w1lsIKvkNX7SJv0IThpuE5i6nn9XgzXSDbv79oBQef8b6pyskbFAMkyA+dM4WU43CaGmPctv8+WSa52c7+Mvwt4uAAZxbCZvktQJ9+vIZ+4w+JB9omPJBTpe7svhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc7a18c-1161-47a6-55a0-08debc09dc26
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:06:06.9327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMTDoGBpQmcMh6sXgEAWYd7AZe5hbesE8sVCKi65Hsx834cxJVsc/q0P9Li66jnlhhF5oJNEKbWpg0IeGVw8Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7083
X-OriginatorOrg: intel.com

Hi Shrikanth,

On 5/27/2026 3:01 PM, Shrikanth Hegde wrote:
> Hi Chen, Prateek.
> 
> I got back to work today, sorry for delay.
> I am trying to go through the mails.
> Apologies in case i have missed any bits.
> 

Thanks for taking a look at this!

> On 5/26/26 7:38 PM, Chen Yu wrote:
>> Hi Prateek,
>>
>> On Tue, 26 May 2026 11:23:59 +0530, K Prateek Nayak 
>> <kprateek.nayak@amd.com> wrote:
>>> Hello Srikar,
>>>
>>> On 5/26/2026 10:28 AM, Srikar Dronamraju wrote:
>>>> L2 Cache reported here is for SMT8 Core aka CACHE domain.
>>>
>>> Apart for the scheduler, nothing in tree currently cares about
>>> cpu_coregroup_mask() except for drivers/base/arch_topology.c but
>>> Power doesn't select GENERIC_ARCH_TOPOLOGY.
>>>
>>> Why can't Power have an internal mask for MC domain (tl_mc_mask) and
>>> the scheduler can use cpu_coregroup_mask() for the actual LLc? (The L2
>>> mask in this case.)
> 
> This seems wrong. there is no notion that coregroup_mask
> (MC domain) has to point at LLC domain.
> 
> For example, on Shared LPAR, there is no MC domain and LLC is at SMT 
> core level.
> In that case coregroup_mask has point at SMT mask is wrong.
>

On Shared LPAR, highest_flag_domain(SD_SHARE_LLC) selected the
SMT domain(L2 shared)prior to commit b5ea300a17e3.
Prateek suggested changing cpu_coregroup_mask() to use
cpu_l2_cache_mask(), which makes the LLC mask cover the same range.
sd_llc, size and grouping remain unchanged. Only sd_llc_id becomes
contiguous, which aligns with the intent of this commit.

But yes, the naming is confusing. cpu_coregroup_mask suggests a
"group of cores", but after the change, it only covers threads
within a single SMT core.

> If we need a mask to point to the LLC mask which arch has to return, 
> then we would
> need a new api say cpu_llc_mask ? that can point accordingly.
> 

Do you mean something like this?
https://lore.kernel.org/lkml/8d14c844-b4a8-4af6-acab-2cfdd42225be@intel.com/

> I don't like mixing MC domain and LLC into one bit.
> 

[ ... ]

>>   struct cpumask *cpu_coregroup_mask(int cpu)
>>   {
>> -    return per_cpu(cpu_coregroup_map, cpu);
>> +    return cpu_l2_cache_mask(cpu);
>> +}
> 
> This looks wrong to me too. In different hardware topologies
> there maybe distinction between coregroup and l2 mask.
> 
> Let me go through the code and see if there is better way.
> 

Sure, please go ahead - I'm on board with the direction
you settle on.

thanks,
Chenyu


