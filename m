Return-Path: <linuxppc-dev+bounces-25763-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F67BC5B56A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 10:27:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKl713YY2z3bpP;
	Wed, 12 Aug 2026 20:27:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786530461;
	cv=fail; b=fE3kJIHbmdX3LYyQOeCyiTtMQRwXcnVzmUbaSCdNuG2EWsrPUlIXkm/bIBLYfiDUg4X+/BjkHzVzw/pRgYhqrcr4FpfIRuSOHmp7oDYG8c/C1AcCN0gHgOhe1L/Fb1eIic3YRDKFikPyUOuTfudH+prrDpSd9006blG61Z2bDZswUL7e+HzxEa6qEdcaYbNy8sip96t4UXJFaNRUGrMo0n6i/SMcgmOPE5idSwFh3riNBfw+cU4+EWn7Bv1F92UNdbWDgfb01bhZ09MI6XZBBuc4sQz+yrzd2kge06X9zD1e4T4uuNCREXJdKL8Gz9Okv+gR/KBntOkIrhFFXvPxfg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786530461; c=relaxed/relaxed;
	bh=W11Q/YkCGF/FMTJBoQ8X72ZIyIBw6/BgwbnJ6J5menE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S6k93k85BB+ppJSFE9tmwyCO4MONz5DMfGNdkii4kQpucbTo260LJhQBUerekpFVdPjGhbXKDlBxk49XImjs7VhR8DNOuzJZDvXJCDNPnGq3SiG4aoRh1/99EZvVsFgr+VClz+qS4UXSegxC8wkfqUEIvdozI0OHiK5zvn0q/vx4uju3EMOCHDcN3J2/TmeNzBT23fi5zPBrOFxGEkN3/ydgeOpV5gp3DfP7vSS3ZPuZrBX3m2ppspmvPxYx/uyM3ulSqAcMOtt/VFXiDQ9EPkm8TjJax++wOu9x9MAmuCDLpyQygtGJYL+4+D/PQdrp0FprCmpZXjkGuwIbtUDriw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WOcg0GLw; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WOcg0GLw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKl6x34nBz2yvB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 20:27:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786530457; x=1818066457;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y1tAJuowwqvDNA1aXQo9fpH5+dM2bOksd9Rispfe35w=;
  b=WOcg0GLwl6SU3mddQJ+sJrT15cbG+gGpv89q58ts4dINb0GFp4ctJ5x+
   Dcin+TXsX5DDUshSXR1TcFNwOzlbZL6PhDmrR54RPDAmpcPRKsuQjA7RL
   mRQMLHDpfeuJB2iK3LRrk794nq61HZQ66E75riHn0Er8ChNB9xgwOIUuW
   tYxqCB0I1utFC1zCalM3ZYw4Rweez4kFCibwZoSn1tJqpwjEu6ptnM3fs
   +VimqgiIBW46fQSNWK5VSywM9IoNPc8xCHvweGvzdvQsAN+8EcXM9QCbY
   wej9A1uSDyOhGv6M5FUYbVIxU9HwMyaSg4GJuNp+TChZNHGZp2S3WOnzq
   A==;
X-CSE-ConnectionGUID: v3rXe5qYR/2V9mCOl++Ubg==
X-CSE-MsgGUID: Ef8vUKsSTkiNZM5sBbFRBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="104613587"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="104613587"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 03:27:28 -0700
X-CSE-ConnectionGUID: 1/nke3WGSfmYT7Bk3CGsng==
X-CSE-MsgGUID: Wqb+dzfgTAGkZlFEAe9ADQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="267100808"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 03:27:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 03:27:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 03:27:29 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 03:27:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6+TTAKN83CZDFggz2x9s1do2FtPAEOQF7fn+5O6SoE0HOsyJxqlZ6vBjVEG8z3528L31ZVaeFy29g/0Ux5QqCmEioeAZG7MxwhwQFPkFUef6mZvA+qZmz4QzgLCyaY1/Hw+Q813UIUmajjcidYla1vqBJxT6jk+C+tOjKF8XZiY4Lba8oloka3s41w9KMwgo79q+kLOQcr6kohng01gUs9+vDF59yKgJzTHTJthJ0iAFs2QQr3ZrRuF0efW+fVZtNwZ6KZrZRrf6vvFSmTPZKCgI3/lJ4/htialQrwN/PN6bn9+PeuFGsTeEs9lwncvAYzIAKm86ls2hbxOHnsr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W11Q/YkCGF/FMTJBoQ8X72ZIyIBw6/BgwbnJ6J5menE=;
 b=PvRXOFqJNPd9xQ+r8KegIfrcV9q5D98tqMlmwd4CA+Tv8d4fwRNiM8HDRYKoh7m56sMxNcygBC24S1o0ZcffmnFn6qORCm9/rohKRozAkfONqauLFdm+Bn/qhIWgwVVonqOekxJ1jpWHryRRNnLfMSiK14eVFVCcJjxymQncaFnQwtIpkcgCoHHYFQxJLGw+JdU5MmQC/kkUUeW+mAgiZJ8Y0C3vCq/QGKmK9Kw1Lh1mAQ0imxDeN0Aj4apg5l4N8N/BlnQ3bR2pQ2xtxqrb4Pynu61CGFvun7/gEY4wFuXKscq/kAheFyc/xsfyRuMMEqNdGHHZJHtmbsfoJw79Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 10:27:10 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 10:27:10 +0000
Message-ID: <9e765036-6578-4832-9dd2-ab00e62dfacc@intel.com>
Date: Wed, 12 Aug 2026 13:27:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/6] tools/perf: Add AUXTRACE recording support for
 powerpc HTM
To: Athira Rajeev <atrajeev@linux.ibm.com>, <acme@kernel.org>,
	<jolsa@kernel.org>, <maddy@linux.ibm.com>, <irogers@google.com>,
	<namhyung@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<hbathini@linux.vnet.ibm.com>, <tejas05@linux.ibm.com>,
	<tshah@linux.ibm.com>, <venkat88@linux.ibm.com>, <usha.r2@ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-3-atrajeev@linux.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260807144135.2607-3-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0053.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::23) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CY8PR11MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: ffedef8c-4819-4924-ff7d-08def85c442e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|6133799003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: TOhy0npthKseJmeCiONv36bvXVIs1NNaljjppSk/zUqnymxmnT13Yur2Q4MAh/4mtC3/qiyulXlt+MWvTyUxrVkKWupKs853L6UZPJZweRQQlJtKPWvobUDl2F5lXqGq4yJ6qwYsoREaGehLY2qk6ykwiyClb0sH9KRQDlSpLBKaJwG2fpA5LaSb4WwtwzuDogLr+F+NQ4XnVZSTkMuhnLSKs4S5QukAxiFfmbIWcGNtLGcFMEH5EUJ1RgDC3uhEQd0MVL76MWWxo3w165I5Ubzr5svbwnDmJsM4HiO9u1eb4eBQz0q99MovR0SsH29/FLN5gs9hyo2KJtvUEGdvbjgICxDQ9dM08Hj/urW1CMogXM9omPZPvJjv376pg3XaDS01CguBkSlmGpM3k25tf1mmeXQccS1mR9HM+7fGn7m4xXVUSOhs5HF0x72inAlnalmVSHyxJwV46JvWOUOH/5PLdkLT/5W159kXQAMetggItY4zwjp/mKJVnf9rn0qOAXKTLx6PKMDZDCUa0BeoGhhR+Uu0XFsAVzapWpntSu92pysryJwsAucJha6ZTCKB2KIRGTY0yygdXDXNyMVUL44kntdkyf/m1toOlZ5ojVIybXgn36O0bYxOuawKDlzHDyHA1zc1nuB5WztSnqjgVgjrOYOhxO5t5M3bOePQIVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGxmYVNyc0l2SmxwVGZhL0lMV2Z0U2ZVKzFyT2p6cHBBM3hKcVZqSUthQk4r?=
 =?utf-8?B?WUw2b0F1ZVhTeDBxNm5rZWlYSm41dXJxbmtyS2tIbWFIZDRVaUFpM0hxKzVC?=
 =?utf-8?B?ZDlUNWpGVEZBdnIyYmFYVnJTdVF4WDVJV1pnYUd3TWpBZkdyVlYyL0FjM0tW?=
 =?utf-8?B?TVh4ZFlpNUNDYU9HWjFjV1pIeDVMRTl4SWRxa05NV1NYaHY0Q1hxMmV2ajZ3?=
 =?utf-8?B?TkRiTy8zbXVRbEZHZnFuemo4MU9NWTgrRVFFbU11UGJrSkFPRzBRUllxb3Mz?=
 =?utf-8?B?elBVd1FSVlBhd0g4SXl1VFpIOHRZQXJubksvcmt3bnpDWDdhT2dRbFJlV0ly?=
 =?utf-8?B?ZHovYzZuOVg0aWhZdHFtWUMyZmNOZzFCSWxESlNZbC9xNjJLWHorVFgyZnNt?=
 =?utf-8?B?WU5TQXEzZkdXK0ZpT1FXd3VLUldOeTJUbTFqV3V2ZHh5T0hiazkwWkdFc2t2?=
 =?utf-8?B?WXdHK1hOV2NTSFRsNjVZMk1SaFo2ZnNWZG1KUjNPUWk1blVsRUFIeWJVMVdN?=
 =?utf-8?B?NVRKQ0RnQlkrb0MwMW5XZUFKV1J0RG1XdzU0eDRLU1BuMENQTzFtUlFmSzQr?=
 =?utf-8?B?bGY0L0l5NFZvK0FzL0RlekF5ci84TW9XaU4vMndPY2U3aHZMdU1NZW1KbThz?=
 =?utf-8?B?bTB0Q2NMbVdYZWNlWDVWcm04S0xwTS9KUEN4eGlyVU52b3k4RlkwR1FyblFI?=
 =?utf-8?B?Q040eHdKRXJ5NnRZWHE1VXZpU2RTajNLN0dEZktxVkE1TGZHQnozQWJoeHFk?=
 =?utf-8?B?Zm1WQ0k5OE9rVXhYMHg1Nk9zQm9ZejJXVURWMTU1MU5KemJad3c1OEwxTGdB?=
 =?utf-8?B?N00rV0V3RGhqbHcyTThsNFpIRzhQOGdVQ1F3VkZFWEdtRzVxYmlvR1VNM280?=
 =?utf-8?B?MkhlVmVOeEN2dkxXbkhjZ3l3aUNmVy8wa2ljakN3WWdFUTNEZkc4c1dEYTVJ?=
 =?utf-8?B?dDJqQjFZNUxYRGJISndnektURG91YWJyeTY0TXczT1pmN21aVzQzamtxQjZh?=
 =?utf-8?B?cXV0UGVtTnFKNUlIWGtKbWhWWTY5S0VWdmxsek92RWpVRGd5bmEvZnJhZERi?=
 =?utf-8?B?SzZhck9OOGJPN1Iwam9Nc2plWjVYWUdMS1dtMXJTSlRQVjY5YkxWRFNGOHBY?=
 =?utf-8?B?cFlvTmduVTgrWE1WSlZhK05OUXZ5RW96clFyYVk0dWN2Kzd4SkZiYWFJUk5v?=
 =?utf-8?B?bkQ1Q1RDQmU1OUt6dXhEczVWbmloRGFBS2dVN05RV0pIOXFjSkJsQjk1cTRX?=
 =?utf-8?B?bSs3clZwdnV3ZThDRjJxL0hLd3JrTTdNUnZpMysxcnZYTU5HU3JZNnRTWDFy?=
 =?utf-8?B?bUJSUE9SSUxYeEZzdG1HRVh4MXBiRXJ5OTk5cGptWUJJb2xkMzJHZ1RHQXA3?=
 =?utf-8?B?RFlLb29Ndi9jRlp4bTNtM2h3czlGYVpJV2E0QWJqaXV6R25PVVdETUVNQ2Vm?=
 =?utf-8?B?aENWL3ExdkFCZ296TmVoU2RoTDZsWURZSTJUbm83MGxtTmJ4NDFGMEZFOHN3?=
 =?utf-8?B?enZsVlQ2SVZTVXBBc3lSVWFnOFZJYWNMQ09SaTBrQ0RRV0hYdHJHL0tkb2Y1?=
 =?utf-8?B?Y0M3bzJUeXhCcThBbGFOMGtaWkNmZDRtVlk4b1BYR3pDZy9SZVFFUitFcXBW?=
 =?utf-8?B?V2ROYkZoYXpDMTVTOExxOGJIS0M5bWZnK0ErZ2VLK2pMMlhaVTVyYVhhSmVr?=
 =?utf-8?B?ZlplNlduVjZRQlRIekJYZWZGdjZoeERlT1UyUGgwbzFYY0pOblZJV3RjdGVK?=
 =?utf-8?B?NGFzc0s4Q1pyWTAxWHFyZGxUWDQreUNuQ1lQSGVoY1RucmtGM2pjaWV1YjJS?=
 =?utf-8?B?VmlIYXZOV2huRzlRWWRKUTd5ak5pNG8reG9COExIenRxMGFRQnVKd081KzFI?=
 =?utf-8?B?SlNXZzdCK2p6Y25jdzBZd2UvWFo5cmVpWDY1N2hvWVU0ZkFQNzYyN3pncVRo?=
 =?utf-8?B?Q1FMclZGNENmWHB4K09UdEVCdDgxS3ZxRDBuR2dmUFRuTmM3dExUUkZVYTY2?=
 =?utf-8?B?V0VzRk11elVNdUVHSjRvb280RXhubVRaR0xpV1dFYWdqWkFJUUFRWU5DSEFM?=
 =?utf-8?B?NVZvdm13dDg4Uk5DZUU0NEtnOG5mSVVVRlV1MTQ0K0NsYzlSMVJ5ODdXOURY?=
 =?utf-8?B?SWw1VUszSHdSc0luSTVJNVJ2VXpzS3VLY1ViM2ltZk1HZW1pQ1IwWmp1RXdh?=
 =?utf-8?B?S3h0dEt1cndIYnFWUWpNZTlWK0g1ZWZibkVPL0s5OWlwT1lwREFJYlpPM2Vy?=
 =?utf-8?B?STNOVWF3dmQwbmJrcktpTENNcVdsNnFPUnpiRGI0YTFrSHNiUzRvY0U0bWdX?=
 =?utf-8?B?VitSMGkyVm9jVzVjeWthUmNDNzc0UlU2OGpBdnY1bEpXRytxV0JKdDJrcHlN?=
 =?utf-8?Q?xlGH2IS6T2dohi8s=3D?=
X-Exchange-RoutingPolicyChecked: Fs0cV47qrZ0lOif6Wwco9xaYttXb2WCuPvClUKiPTP2X9sR7+A+0OAD8avoXImi8KaRGLl75tvuXAlOXt1t+WrmtAMWnfxztB2fmlb0zdYRpC4fLxIf5Sqw31j/I3T+wv2evHGZ4Uo8w6vz5mdOTrhp1c8X6UqQHQkkfzEgVTazg4OC/x1UdWwZfmyazgjW6kznVpHwMOKE4ywRUKy2NzNH6xdYeS5JPQQuCy2+uMWbW0rExQHNyd9IUbNMtO3afMRUTZba8qK4CODleDVSMw0WQInjtJTr86ZFCz5lvS9YVHTxJxr/uLEAqtvZAZVWSI2c+xSbX7IopS/5gSGtbKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ffedef8c-4819-4924-ff7d-08def85c442e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 10:27:10.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7IYNscyqkDzuktZ1vRZ3SestW6q3bKP0T919G5DsoAQYHJyXMb0eva+x8iHELHBEnQachnVpGOjHUB2WshZJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7134
X-OriginatorOrg: intel.com

On 07/08/2026 17:41, Athira Rajeev wrote:
> Add powerpc perf tool support for the HTM PMU AUXTRACE recording path.
> 
> Introduce htm_recording_init() and the associated auxtrace callbacks so
> perf record can create PERF_RECORD_AUXTRACE records for HTM data.
> 
> htm_info_fill() stores the PMU type, number of HTM evsels, and a
> (cpu, attr.config) pair for each evsel into PERF_RECORD_AUXTRACE_INFO
> priv[].  The decode side reads these back to map each AUX buffer
> (identified by event->auxtrace.cpu) to the correct (node, chip, core)
> target when writing htm.bin.* output files.
> 
> Update auxtrace_record__init() to detect HTM events and dispatch to the
> HTM-specific recording initializer.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

A couple of very minor comments.

Nevertheless:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in V5:
> - htm_recording_options(): clamp aux_watermark with min_t(size_t, wm,
>   UINT_MAX) before assigning to pos->core.attr.aux_watermark (u32).
>   On a system with large auxtrace_mmap_pages the unclamped product can
>   exceed UINT_MAX and silently truncate on 32-bit platforms.
> - htm_info_fill(): iterate all CPUs in each evsel's CPU map and write
>   one (cpu, config) entry per CPU instead of only the first CPU.  An
>   evsel opened with -C 0,1,2 now contributes three priv[] entries, one
>   per CPU, each carrying the same attr.config.  The decode side
>   (powerpc_htm_process_auxtrace_event) uses event->auxtrace.cpu to look
>   up the matching entry, so every CPU's AUX buffer is correctly mapped
>   to its (node, chip, core, type) target and written to the right output
>   file.  An evsel with no CPU map records cpu=-1 as before.
> 
> Changes in V4:
> - Add explicit mutual-exclusion check in auxtrace_record__init(): if
>   both vpa_dtl_evsel and htm_evsel are set after scanning the evlist,
>   print an error, set *err = -EINVAL, and return NULL.  V3 silently
>   fell through to prefer VPA-DTL when both PMU types were present,
>   leaving HTM AUX buffers collected without a
>   PERF_RECORD_AUXTRACE_INFO record and the trace undecodable.
> - Drop the superfluous pos->name && null-guard from the HTM detection
>   condition in auxtrace_record__init(): the condition becomes
>   !strcmp(evsel__pmu_name(pos), "htm") without the leading check.
>   evsel__pmu_name() handles a NULL name internally so the guard is
>   redundant.
> - Apply the same simplification in htm_recording_options() and
>   htm_nr_events() in htm.c: remove the !pos->name || prefix from
>   the evsel__pmu_name() comparisons, consistent with the dispatcher
>   change above.
> - Set pos->core.attr.sample_period = 1 for each HTM evsel inside
>   htm_recording_options().  V3 set freq=0 and aux_watermark but did
>   not set sample_period, leaving the kernel to use whatever default
>   value was in the attr, which could cause the HTM event to fire at
>   an unintended rate.
> 
> Changes in V3:
> - Switch HTM event detection in auxtrace_record__init() from
> strstarts(pos->name, "htm") to !strcmp(evsel__pmu_name(pos), "htm"),
> matching the kernel-assigned PMU name and preventing false
> matches on user-named events.
> - Switch htm_recording_options(), htm_nr_events(), and the
> loop in htm_info_fill() from strstarts(pos->name, "htm")
> to evsel__pmu_name(), consistent with the above and with
> patches 4 and 6.
> - Add #include <linux/zalloc.h> to htm.c for zalloc().
> - Set auxtrace_info->type = PERF_AUXTRACE_POWERPC_HTM directly
> in htm_info_fill(), removing the placeholder comment. (V2
> deferred this to patch 5; it is cleaner to set it in the same
> patch that defines the enum.)
> - Set aux_watermark to half the AUX ring-buffer size
> (auxtrace_mmap_pages * page_size / 2) so there is always
> headroom for hardware to write while userspace drains. V2 set
> it to the full buffer size, risking data loss under back-pressure.
> - Add PERF_AUXTRACE_POWERPC_HTM to the enum auxtrace_type in
> util/auxtrace.h and add #include "powerpc-htm.h" plus a stub
> case PERF_AUXTRACE_POWERPC_HTM: (falls through to
> PERF_AUXTRACE_UNKNOWN) in util/auxtrace.c in this patch, so
> the enum is defined before it is used in htm_info_fill().
> (V2 did this in patch 5.)
> 
> Changes in V2:
> - htm_info_fill() now stores a (cpu, attr.config) pair for every HTM
>   evsel into PERF_RECORD_AUXTRACE_INFO priv[].  V1 stored only the PMU
>   type and a single config value; there was no per-CPU mapping.
> - The priv[] layout is formalised in util/powerpc-htm.h with enum
>   constants POWERPC_HTM_PMU_TYPE, POWERPC_HTM_NUM_EVENTS, and
>   POWERPC_HTM_EVENT_DATA and the helper macros HTM_AUXTRACE_PRIV_FIXED
>   and HTM_AUXTRACE_PRIV_SIZE(n).  V1 used bare numeric offsets.
> - PERF_SAMPLE_RAW is enabled in the recording options so that memory
>   configuration records emitted by the kernel driver are captured
>   alongside the AUX stream.  V1 added this in a later patch.
> - PERF_AUXTRACE_POWERPC_HTM type constant is set in htm_info_fill()
>   (wired up in patch 5 once the enum is defined).
> - Patch is now 2/6 instead of 2/9.
> 
>  tools/perf/arch/powerpc/util/Build      |   1 +
>  tools/perf/arch/powerpc/util/auxtrace.c |  22 +++
>  tools/perf/arch/powerpc/util/htm.c      | 185 ++++++++++++++++++++++++
>  tools/perf/util/auxtrace.c              |   2 +
>  tools/perf/util/auxtrace.h              |   1 +
>  tools/perf/util/powerpc-htm.h           |  43 ++++++
>  6 files changed, 254 insertions(+)
>  create mode 100644 tools/perf/arch/powerpc/util/htm.c
>  create mode 100644 tools/perf/util/powerpc-htm.h
> 
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
> index 7819c8f5af2d..297152591046 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -8,3 +8,4 @@ perf-util-$(CONFIG_LIBDW) += skip-callchain-idx.o
>  
>  perf-util-y += auxtrace.o
>  perf-util-y += vpa-dtl.o
> +perf-util-y += htm.o
> diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
> index e04a0bd61755..9936d1910256 100644
> --- a/tools/perf/arch/powerpc/util/auxtrace.c
> +++ b/tools/perf/arch/powerpc/util/auxtrace.c
> @@ -12,13 +12,16 @@
>  #include "../../util/debug.h"
>  #include "../../util/auxtrace.h"
>  #include "../../util/powerpc-vpadtl.h"
> +#include "../../util/powerpc-htm.h"
>  #include "../../util/record.h"
> +#include <string.h>

There is "#include <errno.h>" further up.  Maybe nicer to put them
together as standard library includes

>  
>  struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
>  						int *err)
>  {
>  	struct evsel *pos;
>  	struct evsel *vpa_dtl_evsel = NULL;
> +	struct evsel *htm_evsel = NULL;
>  
>  	/*
>  	 * Set err value to zero here. Any fail later
> @@ -32,11 +35,30 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
>  			/* Remember the first matching VPA DTL event */
>  			if (!vpa_dtl_evsel)
>  				vpa_dtl_evsel = pos;
> +		} else if (!strcmp(evsel__pmu_name(pos), "htm")) {
> +			pos->needs_auxtrace_mmap = true;
> +			/* Remember the first matching HTM event */
> +			if (!htm_evsel)
> +				htm_evsel = pos;
>  		}
>  	}
>  
> +	/*
> +	 * Only one auxtrace PMU can be initialised per session.  Reject
> +	 * concurrent VPA DTL and HTM events: HTM AUX buffers would be
> +	 * collected without a PERF_RECORD_AUXTRACE_INFO record, making
> +	 * the trace undecodable.
> +	 */
> +	if (vpa_dtl_evsel && htm_evsel) {
> +		pr_err("Cannot record VPA DTL and HTM auxtrace events simultaneously\n");
> +		*err = -EINVAL;
> +		return NULL;
> +	}
> +
>  	if (vpa_dtl_evsel)
>  		return vpa_dtl_recording_init(vpa_dtl_evsel, err);
> +	else if (htm_evsel)
> +		return htm_recording_init(htm_evsel, err);
>  
>  	return NULL;
>  }
> diff --git a/tools/perf/arch/powerpc/util/htm.c b/tools/perf/arch/powerpc/util/htm.c
> new file mode 100644
> index 000000000000..d2fdef488032
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/htm.c
> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HTM AUX tracing support
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/string.h>
> +#include <linux/zalloc.h>
> +#include <stdlib.h>
> +#include <limits.h>
> +#include "../../util/evsel.h"
> +#include "../../util/evlist.h"
> +#include "../../util/session.h"
> +#include "../../util/debug.h"
> +#include "../../util/auxtrace.h"
> +#include "../../util/powerpc-htm.h"
> +#include "../../util/record.h"
> +#include <internal/lib.h> /* page_size */
> +#include <errno.h>
> +
> +#define KiB(x) ((x) * 1024)
> +
> +struct htm_recording {
> +	struct auxtrace_record	itr;
> +	struct evsel		*evsel;
> +};
> +
> +static int
> +htm_recording_options(struct auxtrace_record *itr __maybe_unused,
> +		      struct evlist *evlist,
> +		      struct record_opts *opts)
> +{
> +	struct evsel *pos;
> +
> +	opts->full_auxtrace = true;
> +
> +	if (!opts->auxtrace_mmap_pages) {
> +		opts->auxtrace_mmap_pages = KiB(128) / page_size;
> +		if (opts->mmap_pages == UINT_MAX)
> +			opts->mmap_pages = KiB(256) / page_size;
> +	}
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		size_t wm;
> +
> +		if (strcmp(evsel__pmu_name(pos), "htm"))
> +			continue;
> +		wm = opts->auxtrace_mmap_pages * (size_t)page_size / 2;
> +		pos->core.attr.aux_watermark = min_t(size_t, wm, UINT_MAX);
> +		pos->core.attr.sample_type |= PERF_SAMPLE_RAW;
> +		pos->core.attr.freq = 0;
> +		pos->core.attr.sample_period = 1;
> +		pos->needs_auxtrace_mmap = true;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Count htm evsels in the evlist */
> +static int htm_nr_events(struct evlist *evlist)
> +{
> +	struct evsel *pos;
> +	int n = 0;
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		if (!strcmp(evsel__pmu_name(pos), "htm"))
> +			n++;
> +	}
> +	return n;
> +}
> +
> +static size_t htm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
> +				 struct evlist *evlist)
> +{
> +	return HTM_AUXTRACE_PRIV_SIZE(htm_nr_events(evlist));
> +}
> +
> +/*
> + * Fill the PERF_RECORD_AUXTRACE_INFO private data with:
> + *   priv[POWERPC_HTM_PMU_TYPE]   = pmu->type of the first htm evsel
> + *   priv[POWERPC_HTM_NUM_EVENTS] = total number of HTM CPU entries
> + *   priv[POWERPC_HTM_EVENT_DATA + n*2]     = CPU number for nth entry
> + *   priv[POWERPC_HTM_EVENT_DATA + n*2 + 1] = attr.config for nth entry
> + *
> + * One entry is written per CPU in each evsel's cpu map.  An evsel opened
> + * with -C 0,1,2 contributes three entries (one per CPU), each carrying
> + * the same attr.config.  The decode side uses event->auxtrace.cpu to look
> + * up the matching config and derive (node, chip, core) for the output
> + * file name.
> + */
> +static int
> +htm_info_fill(struct auxtrace_record *itr,
> +	      struct perf_session *session,
> +	      struct perf_record_auxtrace_info *auxtrace_info,
> +	      size_t priv_size)
> +{
> +	struct htm_recording *htm_r = container_of(itr, struct htm_recording, itr);
> +	struct evlist *evlist = session->evlist;
> +	struct evsel *pos;
> +	int n = 0;
> +	int expected_n = htm_nr_events(evlist);
> +
> +	if (priv_size != HTM_AUXTRACE_PRIV_SIZE(expected_n))
> +		return -EINVAL;
> +
> +	auxtrace_info->type = PERF_AUXTRACE_POWERPC_HTM;
> +	auxtrace_info->priv[POWERPC_HTM_PMU_TYPE] = htm_r->evsel->core.attr.type;
> +	auxtrace_info->priv[POWERPC_HTM_NUM_EVENTS] = expected_n;
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		struct perf_cpu_map *cpus;
> +		int i, nr;
> +
> +		if (strcmp(evsel__pmu_name(pos), "htm"))
> +			continue;
> +
> +		/*
> +		 * Emit one (cpu, config) entry for every CPU in this evsel's
> +		 * map.  perf record -C 0,1,2 creates one evsel with a
> +		 * three-entry cpu map; each CPU gets its own AUX buffer and
> +		 * must be individually mapped so the decoder can match
> +		 * event->auxtrace.cpu to the correct (node, chip, core).
> +		 */
> +		cpus = evsel__cpus(pos);
> +		nr = cpus ? perf_cpu_map__nr(cpus) : 0;
> +
> +		if (nr > 0) {
> +			for (i = 0; i < nr; i++) {
> +				int cpu = perf_cpu_map__cpu(cpus, i).cpu;
> +
> +				auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2]     = cpu;
> +				auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2 + 1] =
> +								pos->core.attr.config;
> +				n++;
> +			}
> +		} else {
> +			/* cpu-agnostic evsel: record cpu = -1 */
> +			auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2]     = (u64)-1;
> +			auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2 + 1] =
> +							pos->core.attr.config;
> +			n++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static u64 htm_reference(struct auxtrace_record *itr __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +static void htm_free(struct auxtrace_record *itr)
> +{
> +	struct htm_recording *htm_r = container_of(itr, struct htm_recording, itr);
> +
> +	free(htm_r);
> +}
> +
> +struct auxtrace_record *htm_recording_init(struct evsel *pos, int *err)
> +{
> +	struct htm_recording *htm_r;
> +
> +	/*
> +	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
> +	 * must come first.
> +	 */
> +	evlist__to_front(pos->evlist, pos);
> +
> +	htm_r = zalloc(sizeof(*htm_r));
> +	if (!htm_r) {
> +		pr_debug("htm_recording allocation failed (-ENOMEM)\n");
> +		*err = -ENOMEM;
> +		return NULL;
> +	}
> +
> +	htm_r->evsel = pos;
> +	htm_r->itr.recording_options = htm_recording_options;
> +	htm_r->itr.info_priv_size    = htm_info_priv_size;
> +	htm_r->itr.info_fill         = htm_info_fill;
> +	htm_r->itr.free              = htm_free;
> +	htm_r->itr.reference         = htm_reference;
> +	return &htm_r->itr;
> +}
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index aa749e1c3036..bf08f41d623f 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -56,6 +56,7 @@
>  #include "s390-cpumsf.h"
>  #include "util/mmap.h"
>  #include "powerpc-vpadtl.h"
> +#include "powerpc-htm.h"
>  
>  #include <linux/ctype.h>
>  #include "symbol/kallsyms.h"
> @@ -1432,6 +1433,7 @@ int perf_event__process_auxtrace_info(const struct perf_tool *tool __maybe_unuse
>  	case PERF_AUXTRACE_VPA_DTL:
>  		err = powerpc_vpadtl_process_auxtrace_info(event, session);
>  		break;
> +	case PERF_AUXTRACE_POWERPC_HTM:
>  	case PERF_AUXTRACE_UNKNOWN:
>  	default:
>  		return -EINVAL;
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 6947f3f284c0..68b17802a419 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -46,6 +46,7 @@ enum auxtrace_type {
>  	PERF_AUXTRACE_S390_CPUMSF,
>  	PERF_AUXTRACE_HISI_PTT,
>  	PERF_AUXTRACE_VPA_DTL,
> +	PERF_AUXTRACE_POWERPC_HTM,
>  };
>  
>  enum itrace_period_type {
> diff --git a/tools/perf/util/powerpc-htm.h b/tools/perf/util/powerpc-htm.h
> new file mode 100644
> index 000000000000..18e39417d556
> --- /dev/null
> +++ b/tools/perf/util/powerpc-htm.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __POWERPC_HTM_H
> +#define __POWERPC_HTM_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * Layout of the private data in PERF_RECORD_AUXTRACE_INFO for HTM.
> + *
> + * priv[POWERPC_HTM_PMU_TYPE]   = htm PMU type ID (pmu->type from kernel)
> + * priv[POWERPC_HTM_NUM_EVENTS] = number of htm evsels recorded (N)
> + *
> + * Followed by N pairs (2 u64 each):
> + *   priv[POWERPC_HTM_EVENT_DATA + n*2 + 0] = CPU number for nth htm evsel
> + *   priv[POWERPC_HTM_EVENT_DATA + n*2 + 1] = attr.config for nth htm evsel
> + *
> + * Total priv entries: POWERPC_HTM_EVENT_DATA + N * 2
> + */
> +enum {
> +	POWERPC_HTM_PMU_TYPE  = 0,
> +	POWERPC_HTM_NUM_EVENTS,
> +	POWERPC_HTM_EVENT_DATA,	/* variable-length: 2 u64 per event */
> +};
> +
> +/* Fixed header size (everything before the per-event data) */
> +#define HTM_AUXTRACE_PRIV_FIXED  (POWERPC_HTM_EVENT_DATA * sizeof(u64))
> +
> +/* Total priv size for N htm evsels */
> +#define HTM_AUXTRACE_PRIV_SIZE(n) \
> +	(HTM_AUXTRACE_PRIV_FIXED + (n) * 2 * sizeof(u64))
> +
> +struct evsel;
> +struct evlist;
> +union perf_event;
> +struct perf_session;
> +struct auxtrace_record;
> +
> +struct auxtrace_record *htm_recording_init(struct evsel *pos, int *err);
> +
> +int powerpc_htm_process_auxtrace_info(union perf_event *event,
> +				      struct perf_session *session);

Ideally, should only add a declaration for powerpc_htm_process_auxtrace_info()
when it actually exists

> +
> +#endif /* __POWERPC_HTM_H */


