Return-Path: <linuxppc-dev+bounces-25761-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDF6C5AD5A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 09:31:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKjtV1ts7z3brB;
	Wed, 12 Aug 2026 19:31:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786527106;
	cv=fail; b=c9mBFu/QqZJE9Rqsh/moRd3djN/aDZw9Hn0PQfyylaNP4SoW0y9Of6KxSamzsUp9M/CpOF8IY/2UsyXTdhDTzrMm1fosEaNaayF0HLUyKbCqOM7z9wIDigakbDQ4wg+NIpKrKM9QrJX4a0M1DaOsi7y2eTMv7I4w8ZsQT//FaFqEAfNT2S9Yn4HDbL0B1FZ6K1me7PCAF5JJUzqN0sX/y3Bs1EI3aS/JWZZHKGEvF6n9qCpNgC+zXUg826vrHJZxI5VZkqf/MFiUgptrOdCdtmB7mktoiDDC5r7QdqgPBw4ef2Wrviuo5H6HdlAkvFWwz16ns1UNQ+TPfWcR6iSPgw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786527106; c=relaxed/relaxed;
	bh=Y2MZIdADox9QdPhIT6CJItrVSQDTUW8r1pOFfsDF9lQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C3bcehIIaAVFigORRiXCZvyfNKdapxxhtLpwoeX+svDDNx2OiBLwZukPpmjVCBmstryXkKF3Gqd5r0RK+K/xG5F4s30ydMiu0s2ptHQNwRVWiESyR1lNzuTGXXKNSWyHH+kPYU0Ed7gGoK842aE/oXG3iKN7n+y5znFx7I3ZRdZej2kdHEHOzfK7q0Hfl9XzRwhOi6libAfOBCzgAXK0TINxvKbMYAHjO2uyoyzXo7eepvOrbwJk+QJTtyOsoxkCd5TxKlaP0jUJ4NSJtBPwJLbFkyJ5G+hkXMbTURU2rA6zQEKrsMzH4kk/4bIhbM6cby9cCNdlmlV3ovutMeL9vQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cZh5kKGe; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cZh5kKGe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 66 seconds by postgrey-1.37 at boromir; Wed, 12 Aug 2026 19:31:42 AEST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKjtQ0vfQz3br7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 19:31:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786527103; x=1818063103;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hQ3MfS2pAGWqjKv2hwWUGGibUSAEoF4exVm7fB4DFDA=;
  b=cZh5kKGez/d46YNpripti+xYTovG2LYbhuwmxO4zQnqee/lTh3O/Djrf
   Wrurgb3XJhVfu64t4wL5cPYotdBwLxAQ8j7YAI4IIaLomTIAVxNB5FY2U
   RDxDfpTgpDFGSwPl6mk+/wwvSuNIiX8VVjNfa2QeEqWpaS3UmOLFirPcG
   8ckmQros4tNq5VWJl7G54UMKoBuJHZ5eX/3wAgFi4A7xmJ25h6tyMJgSe
   mNf/mrBzIprCOfKfafAeODpFu/suwsPxDZ8lHEaEZIDmRq+ybaRe1XRCl
   lAGEE2KUqbSqPEydJwX4S6J0GO2IxB/NS13fq1BzinHlNTmGDsM59xQ5M
   A==;
X-CSE-ConnectionGUID: 7uTG3GTaRa6mdwOC9uTMLA==
X-CSE-MsgGUID: RrJtUORZTO2xYqZQOGesGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="90887518"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="90887518"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:30:28 -0700
X-CSE-ConnectionGUID: PVPZnm1FQZmumDgDMx4F+Q==
X-CSE-MsgGUID: XU/xcZ3bTKKdWyTFgpWHkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="264185580"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:30:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 02:30:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 02:30:27 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 02:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gb/bb2aaiIJ5FNZ5CE1HCDZhS1ADdkgDWzzIQlEayyvRBt87OlFFDGVvJvUBzX/y2boLSpWgzymjNFbJSnwRMvwyYLL00XGGC9MMQpGdMU3PTlC5nbQcQgWPh8YAJFNBtceHuRJtjlCfG34014Oc59JUaRW9ZrnuB6DJbRQGPOZuR+kAt0H9miL3uGfhg0QgRgbAApimVvkYugcfaEMj4x1vbWw937E+chp0sxEMqV2Av2WJ5cER245CY+5AE7o2/ixpiLaP1KN0D3ZEDR1oWKjC6auMSp1s7jUcl5j+gtDjLDYhBIqsAqX9AtDdIPbp/ONA2cEfItkSb8Xs5dToXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2MZIdADox9QdPhIT6CJItrVSQDTUW8r1pOFfsDF9lQ=;
 b=Q+4amfiISIxKXoVIdnsPmR4Y7dfBGQF/aQX24LOINM7JkOVhWly2haGJxOOEYPUsE76ddGOKRVjBsSXJFuO2Fuoaivo+K/DXcHKfdeLLmZ6pvhaJWaDwFpgVp5+TMFuewCdqPApFMn+Rm89mo4xpSEIPzaAzoztCaeozzYcE7ufUPcegi3eIEuW/BbPQulUV5DQv92r9ivOZIOZ6mungZO1aM9IzTThWhW1yIc0mlwWptWInXaA7sHuO/15iy6vZFUZNDQIL0yznBLQs0P5uCLvEH+M0VVE9BDdVn7SrPq6T8ASYmeKdGyU0JQM1QgjMeh7QW0NTPMtnpgKD7HPaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA4PR11MB9419.namprd11.prod.outlook.com (2603:10b6:208:564::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 09:30:24 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 09:30:23 +0000
Message-ID: <9d5f7724-3b23-48b6-9441-961614294562@intel.com>
Date: Wed, 12 Aug 2026 12:30:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/6] tools/perf: Move powerpc VPA-DTL auxtrace init
 into a separate file
To: Athira Rajeev <atrajeev@linux.ibm.com>, <acme@kernel.org>,
	<jolsa@kernel.org>, <maddy@linux.ibm.com>, <irogers@google.com>,
	<namhyung@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<hbathini@linux.vnet.ibm.com>, <tejas05@linux.ibm.com>,
	<tshah@linux.ibm.com>, <venkat88@linux.ibm.com>, <usha.r2@ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-2-atrajeev@linux.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260807144135.2607-2-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0115.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::27) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA4PR11MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 27261967-3479-4557-6d81-08def85455a7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: gIAEhum5/72V3ij4aNUUDTDxindIJMEiCOqTFoExbG4bSUrbzXzXEgrHE2PZhc1JbecqNyueYT7GZHMjlvvuWs6dXE3+QWESl5XzDlfqmVW8HA/M6efGdqljtUvAb50rKuHXt7Z8Ly/u3huKntwhuaNtZ153XVGVblPdIL8CBRG2fnZ83UWYLuJNq6hgKO8UGmeDWHQSYXztKKL5ziyLsHW0zTHWrFOG7iD0lh9Juyv8e37EACsZcVcVvE7cu9rVn/92N6bh4RX6g5qOdnLxuTyyG2LZlXR7Y/GeWLZYOsSSM+3P4xWCVX/J/Yd+Vm+q+CPGFrtcdsvpt5jWFtl09TLv6r3rqm89ikzMWtcsn7MLVPis/4aXcnTUzQtcSPNzhgg5gxb+kCHc1e4tPxJxV7gAkhzQ7jEK1bjM46Tpap2cl6mbbdhzkh/YKaZ+qvR6YF4UWTuBJzGqvx33FhMtmZJJS7UoP9PDy0NzKL0tH+2EiL1iurhDud3dBkdlfITvVnmO+rYWZatXzAzJZwftoFaSY8ZCI+UMGsMCVZZ3nO/g79qMSUa8aBkWlLxR9h9f5a4RioJOw4y6SH5oHLFflB3+0WGXzvdjlglBp3GmkOT/2/ccLtalrPp9sRsOpZHuEdaM55wDSmCfkmzlf7fSOQ8kYL2wv3mh41n9WIC8HVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlBVQVBXSmNXUHR0MVNCL1h5K0tXeEsyWjNacThwTGdzQytXNE5uS0RTQzRV?=
 =?utf-8?B?Z0ZRTDdLck1qZDFzdWxRd0FYM3F5cW1RSVhCRDFyUUNSdGhqSUtuSEp5ZTJ1?=
 =?utf-8?B?M1k1OWJoRDY3b2NuUVJ3RmsvbUYvbXN3SHBoMVVIQS9Wbjd6K3UwVGpTeEVP?=
 =?utf-8?B?Zks3czdnSk1aQURvOU5FK1NOQU9tTVp3bmJNVEliNFFaZ0dUL05pMnVoa2lR?=
 =?utf-8?B?RlVFMS9IVkcydmdLWEVlRkpkNUl6aU4wcE5XK21aa1NJMWNJRFFvMWRxQ0x2?=
 =?utf-8?B?Q1A0aFZtK1J6K05MWitTdTA0TzVBK29nQWZheGNEbENFMTFQaWQ0M2Znc01D?=
 =?utf-8?B?Q0psaWduTjViS25iM2VyMm5Yc2pUZWVqbk5BeFYvNytKL0E3VWhsSFdGK3pI?=
 =?utf-8?B?THVZTTR5dXJ3a3VBcHJzaE5OYXRuZFlJTnc0ckFLR2ZpeE9SZk9mVmFyVStV?=
 =?utf-8?B?SXdhcTNGZUhYYzZsVkk0aVk3LytaZmthU0MrQ1Vlcmo0U3J3V2pvYkdUWEhJ?=
 =?utf-8?B?MXNJVXZkQ3BTNjR2WFA1NEpSQjFsQXNXd3N6NXBHK3dNNitZaWkzUUxpTzFU?=
 =?utf-8?B?eS9PcStqeWFRNmxVY3VUbHo3N1J3dEJ4SWw0ZytBVWdmSndFVlpCNE8rUlNM?=
 =?utf-8?B?N0k0TGlEUVlvdU4yM1VGVHB0RkkvSkx6cE1id3ZCb0VFdWo0S3FwK3hpSmZz?=
 =?utf-8?B?WVpFVlJSOUtxV3JvVmJHZXN1Z3UyRnBIaXJHYnNISDRzUlh1MWxGV0FmYW50?=
 =?utf-8?B?SmdyY2pRaGl0cnd3bTZtMm5VaTF4NzlJRjlMZ05GYzUvdmR1ZlpON01jY2ox?=
 =?utf-8?B?K3ZBRXZuOFcxdjd2NUxveWtTQll1a3FpQ0lYS3hFZERtcTdLNytQU3k1NkFY?=
 =?utf-8?B?dFpLa3RoSkM5MWN1bEQzWjBtOUU5a0MweGJIemxWNnN5N21wTXZBSEZscE43?=
 =?utf-8?B?QnNiQUFRMWFIUUs2cmNsZmQyZkt5eERpdFhpaW8rWVk5NmdneHdTb2ZxQXlX?=
 =?utf-8?B?WktRZE9FVVJWeDkwUFBuaDA0YXJjM2JGSVJ4YmU4a3o1OUlxTWFVWjEwQmhx?=
 =?utf-8?B?dDRoQVkvaEtBQ2RXSzBIOC9vcXFTcDB4YkRsWDR1RVBJRm5XT3pRc2xiV0ZO?=
 =?utf-8?B?RXJCR2o2NERTQ0puWVJ6OWdUV3VVaFRZTVJ4MDBSVUZkcmV5TDZPdWZ0U05r?=
 =?utf-8?B?Y3phaytNTHBqdXFKZGFSUkszdk5CRXNIampTVXI1SVlHQ3V6d1lDcE9BaENu?=
 =?utf-8?B?Nit6OGxsd1BwT3VqY0JMdHhCQ3ZiaTlLTHA2NmFia0tNWVk1TUxxU2IwOC85?=
 =?utf-8?B?cWMxbHJZckhiSEJHMTZuMFBJZEt0dG50M3BmMTNGVUVJa1UweDZhLytSRTZ2?=
 =?utf-8?B?Z1dHSzZwaGpZU1JkU0orVHlxN09mSlFJWUhlNThrdVEybmdhQnJkQ0grMUVT?=
 =?utf-8?B?RFJMczFVbWNkZFpiWHl5QlJmczEyNHRucnBEdE5HSHBqUzNFL01KMHM2NXVu?=
 =?utf-8?B?OFdYSVlpdU5GekpTNXhFQUVwQjFmZW1rQnVXaEo0Q2l2Rk9lbDRTWXJKUURG?=
 =?utf-8?B?cGUxMGRQWDE5RUxXdEROV3lsTFpZSGdLWGdwUHlUUWpqdWN6R05JUHV5MXFI?=
 =?utf-8?B?bFZhcE5BNmw5OVkrY2ZuZVA5Vkh0NVRDWUVteVMyOGxVc3RJSUhzT0pRaVVQ?=
 =?utf-8?B?VDY1TDlkQmNETmhaNThlNFJPV21Yc0VMKzRwdFhObERCZnNzRzhEaHJxQWt0?=
 =?utf-8?B?SVROV1F0RDN0a2hNZlVxNFYway9JeGhUR3RrQW1iaU1mR1hSTTJieHVHL09n?=
 =?utf-8?B?ZkNnV2pNckVUUnVMSHJnZGJMSHNnZTlCUlZKNGpCQ1hZRTRjQm9QRG0rd2pS?=
 =?utf-8?B?OUQyUFNYM1hvckc2RXU1d0taZFhVSU9TRHlxU3dxOWUyZnFNblgxSFNobHVL?=
 =?utf-8?B?QjVKUnNVOVptbVpYZkszYkZYcWo4NkFKWkU0YXFMMDlQZVNWWTNiWTBIeDNx?=
 =?utf-8?B?SDlVQWllL0JaV3M2WU5LYi9vaS9MbmdxbXFxRk9NblJhdFM1SXZYUlptaDNs?=
 =?utf-8?B?RW9GQTN5VkkxL3dmSGl6TzlGUGh4NEUrRUZiZkRYd29xVUlPdHd5MnZMK0px?=
 =?utf-8?B?MHFqeFZLaWx4Z0FSeW1hM25Zc2JrWTNweTZNK3JESlVPU3FWTjVKWHNDeU50?=
 =?utf-8?B?R2twUHJTSDlqMExsYUplVGsrbXp1VHFkY0FYb3ZYQVg4Q21QU0F4cUJzZUJU?=
 =?utf-8?B?WXpyODBTZzh3a0ZaNXJGREFyVTkzcDhDMVVqVEhUM2ZxM0hiUDEwbkV4VGI0?=
 =?utf-8?B?ekhkSEMrdDVLTkh6U3Z1aVVzZ053OWNWMWN5bmc1Z0VOcndhaERpL0hhSEVs?=
 =?utf-8?Q?BL3es7bfIBR/i8yY=3D?=
X-Exchange-RoutingPolicyChecked: Gu+dzGcNOi7P3SkwHJItr0528WFB9nXcCyY4xKPO6NfaA0hzOD3hiLTL8IjwzzVbR1l1hdEox3fXnCWgzAgY3rcH2ztnVRe8UZWVvuHxS3WHbM/Dj/JAHARWW0MbQecDCHc/Q9DjdaGR0aNqS5xTTimKZwhleKHMylaP1V5TFsdDUGRWhQNq1TndsCTJ0D/fz2lVBUgcb94+MiMtQdR/1Bb0WDayP56aoD+sf/ar36hrNWZ/XJFPDi4wRlaiz9t3knDYDhnma69ghoVSPkySZXUW02S4EGRMdqtVpKsM724utNYRTEE9CqAwothAK1y9xrm+qQb0FlK+Z1TgxEB6yA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 27261967-3479-4557-6d81-08def85455a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 09:30:23.9009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iniexvK2RTFvJ8AoCTunRcyY9Bp1rwN9xgAZvJ2nl/GUuYyb5I+QD+4T79pDR79yM8tbnX1EJqn5B0iotuSXYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9419
X-OriginatorOrg: intel.com

On 07/08/2026 17:41, Athira Rajeev wrote:
> The powerpc auxtrace dispatch lives entirely in
> arch/powerpc/util/auxtrace.c.  As new PMUs such as HTM are added, this
> file would grow to contain the recording logic for all of them.
> 
> Factor out the VPA-DTL recording initializer into its own file,
> arch/powerpc/util/vpa-dtl.c, and reduce auxtrace.c to a thin dispatch
> layer.  auxtrace_record__init() now detects the PMU by name and calls
> the appropriate per-PMU init function:
> 
>   - vpa_dtl_recording_init() for VPA-DTL events (unchanged behaviour)
>   - Further PMU entries will follow in subsequent patches
> 
> This makes room in auxtrace_record__init() for the HTM recording path
> added in the next patch without growing a single monolithic file.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

A couple of cosmetic / very minor comments.

Nevertheless:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in V5:
> - Add forward declarations for struct evsel and struct auxtrace_record
>   in powerpc-vpadtl.h before the vpa_dtl_recording_init() prototype.
>   Without them, a translation unit that includes the header before the
>   full definitions are visible may produce implicit-declaration warnings
>   on strict compilers.
> 
> Changes in V4:
> - No changes from V3.
> 
> Changes in V3:
> Add #include <linux/zalloc.h> to vpa-dtl.c; without it the compiler
> treats zalloc() as implicitly returning int, truncating the upper
> 32 bits of the returned pointer on 64-bit PowerPC.
> 
> Changes in V2:
> - Renamed the destination file from arch/powerpc/util/vpa-dtl.c (same
>   name, unchanged) but the subject and commit message are reworded to
>   clearly state that the goal is to make auxtrace_record__init() a thin
>   per-PMU dispatcher, not merely to "allow multiple PMUs to use auxtrace".
> - Handle failure from memory allocation
> - Included stdlib and limits.h
> - No functional change to the VPA-DTL path itself.
> - Patch is now 1/6 instead of 1/9.
> 
>  tools/perf/arch/powerpc/util/Build      |  1 +
>  tools/perf/arch/powerpc/util/auxtrace.c | 84 +++-------------------
>  tools/perf/arch/powerpc/util/vpa-dtl.c  | 96 +++++++++++++++++++++++++
>  tools/perf/util/powerpc-vpadtl.h        |  3 +
>  4 files changed, 108 insertions(+), 76 deletions(-)
>  create mode 100644 tools/perf/arch/powerpc/util/vpa-dtl.c
> 
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
> index ae928050e07a..7819c8f5af2d 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -7,3 +7,4 @@ perf-util-y += evsel.o
>  perf-util-$(CONFIG_LIBDW) += skip-callchain-idx.o
>  
>  perf-util-y += auxtrace.o
> +perf-util-y += vpa-dtl.o
> diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
> index 4600a1661b4f..e04a0bd61755 100644
> --- a/tools/perf/arch/powerpc/util/auxtrace.c
> +++ b/tools/perf/arch/powerpc/util/auxtrace.c
> @@ -13,63 +13,12 @@
>  #include "../../util/auxtrace.h"
>  #include "../../util/powerpc-vpadtl.h"
>  #include "../../util/record.h"
> -#include <internal/lib.h> // page_size
> -
> -#define KiB(x) ((x) * 1024)
> -
> -static int
> -powerpc_vpadtl_recording_options(struct auxtrace_record *ar __maybe_unused,
> -			struct evlist *evlist __maybe_unused,
> -			struct record_opts *opts)
> -{
> -	opts->full_auxtrace = true;
> -
> -	/*
> -	 * Set auxtrace_mmap_pages to minimum
> -	 * two pages
> -	 */
> -	if (!opts->auxtrace_mmap_pages) {
> -		opts->auxtrace_mmap_pages = KiB(128) / page_size;
> -		if (opts->mmap_pages == UINT_MAX)
> -			opts->mmap_pages = KiB(256) / page_size;
> -	}
> -
> -	return 0;
> -}
> -
> -static size_t powerpc_vpadtl_info_priv_size(struct auxtrace_record *itr __maybe_unused,
> -					struct evlist *evlist __maybe_unused)
> -{
> -	return VPADTL_AUXTRACE_PRIV_SIZE;
> -}
> -
> -static int
> -powerpc_vpadtl_info_fill(struct auxtrace_record *itr __maybe_unused,
> -		struct perf_session *session __maybe_unused,
> -		struct perf_record_auxtrace_info *auxtrace_info,
> -		size_t priv_size __maybe_unused)
> -{
> -	auxtrace_info->type = PERF_AUXTRACE_VPA_DTL;
> -
> -	return 0;
> -}
> -
> -static void powerpc_vpadtl_free(struct auxtrace_record *itr)
> -{
> -	free(itr);
> -}
> -
> -static u64 powerpc_vpadtl_reference(struct auxtrace_record *itr __maybe_unused)
> -{
> -	return 0;
> -}
>  
>  struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
>  						int *err)
>  {
> -	struct auxtrace_record *aux;
>  	struct evsel *pos;
> -	int found = 0;
> +	struct evsel *vpa_dtl_evsel = NULL;

Ordering local definitions by descending line length is nicer e.g.

	struct evsel *vpa_dtl_evsel = NULL;
  	struct evsel *pos;

>  
>  	/*
>  	 * Set err value to zero here. Any fail later
> @@ -78,33 +27,16 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
>  	*err = 0;
>  
>  	evlist__for_each_entry(evlist, pos) {
> -		if (strstarts(pos->name, "vpa_dtl")) {
> -			found = 1;
> +		if (pos->name && strstarts(pos->name, "vpa_dtl")) {
>  			pos->needs_auxtrace_mmap = true;
> -			break;
> +			/* Remember the first matching VPA DTL event */
> +			if (!vpa_dtl_evsel)
> +				vpa_dtl_evsel = pos;
>  		}
>  	}
>  
> -	if (!found)
> -		return NULL;
> -
> -	/*
> -	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
> -	 * must come first.
> -	 */
> -	evlist__to_front(pos->evlist, pos);
> -
> -	aux = zalloc(sizeof(*aux));
> -	if (aux == NULL) {
> -		pr_debug("aux record is NULL\n");
> -		*err = -ENOMEM;
> -		return NULL;
> -	}
> +	if (vpa_dtl_evsel)
> +		return vpa_dtl_recording_init(vpa_dtl_evsel, err);
>  
> -	aux->recording_options = powerpc_vpadtl_recording_options;
> -	aux->info_priv_size = powerpc_vpadtl_info_priv_size;
> -	aux->info_fill = powerpc_vpadtl_info_fill;
> -	aux->free = powerpc_vpadtl_free;
> -	aux->reference = powerpc_vpadtl_reference;
> -	return aux;
> +	return NULL;
>  }
> diff --git a/tools/perf/arch/powerpc/util/vpa-dtl.c b/tools/perf/arch/powerpc/util/vpa-dtl.c
> new file mode 100644
> index 000000000000..2609b88f61d8
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/vpa-dtl.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * VPA DTL AUX tracing support
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/string.h>
> +#include <linux/zalloc.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <limits.h>
> +#include "../../util/cpumap.h"

Is cpumap.h needed?

> +#include "../../util/evsel.h"
> +#include "../../util/evlist.h"
> +#include "../../util/session.h"
> +#include "../../util/util.h"
> +#include "../../util/debug.h"
> +#include "../../util/auxtrace.h"
> +#include "../../util/powerpc-vpadtl.h"
> +#include "../../util/record.h"
> +#include <internal/lib.h> // page_size
> +
> +#define KiB(x) ((x) * 1024)
> +
> +static int
> +powerpc_vpadtl_recording_options(struct auxtrace_record *ar __maybe_unused,
> +			struct evlist *evlist __maybe_unused,
> +			struct record_opts *opts)
> +{
> +	opts->full_auxtrace = true;
> +
> +	/*
> +	 * Set auxtrace_mmap_pages to minimum
> +	 * two pages
> +	 */
> +	if (!opts->auxtrace_mmap_pages) {
> +		opts->auxtrace_mmap_pages = KiB(128) / page_size;
> +		if (opts->mmap_pages == UINT_MAX)
> +			opts->mmap_pages = KiB(256) / page_size;
> +	}
> +
> +	return 0;
> +}
> +
> +static size_t powerpc_vpadtl_info_priv_size(struct auxtrace_record *itr __maybe_unused,
> +					struct evlist *evlist __maybe_unused)
> +{
> +	return VPADTL_AUXTRACE_PRIV_SIZE;
> +}
> +
> +static int
> +powerpc_vpadtl_info_fill(struct auxtrace_record *itr __maybe_unused,
> +		struct perf_session *session __maybe_unused,
> +		struct perf_record_auxtrace_info *auxtrace_info,
> +		size_t priv_size __maybe_unused)
> +{
> +	auxtrace_info->type = PERF_AUXTRACE_VPA_DTL;
> +
> +	return 0;
> +}
> +
> +static void powerpc_vpadtl_free(struct auxtrace_record *itr)
> +{
> +	free(itr);
> +}
> +
> +static u64 powerpc_vpadtl_reference(struct auxtrace_record *itr __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +struct auxtrace_record *vpa_dtl_recording_init(struct evsel *pos, int *err)
> +{
> +	struct auxtrace_record *aux;
> +
> +	/*
> +	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
> +	 * must come first.
> +	 */
> +	evlist__to_front(pos->evlist, pos);
> +
> +	aux = zalloc(sizeof(*aux));
> +	if (aux == NULL) {
> +		pr_debug("aux record allocation failed (-ENOMEM)\n");
> +		*err = -ENOMEM;
> +		return NULL;
> +	}
> +
> +	aux->recording_options = powerpc_vpadtl_recording_options;
> +	aux->info_priv_size = powerpc_vpadtl_info_priv_size;
> +	aux->info_fill = powerpc_vpadtl_info_fill;
> +	aux->free = powerpc_vpadtl_free;
> +	aux->reference = powerpc_vpadtl_reference;
> +	return aux;
> +}
> diff --git a/tools/perf/util/powerpc-vpadtl.h b/tools/perf/util/powerpc-vpadtl.h
> index ca809660b9bb..68a780c63204 100644
> --- a/tools/perf/util/powerpc-vpadtl.h
> +++ b/tools/perf/util/powerpc-vpadtl.h
> @@ -20,4 +20,7 @@ struct perf_pmu;
>  int powerpc_vpadtl_process_auxtrace_info(union perf_event *event,
>  				  struct perf_session *session);
>  
> +struct evsel;
> +struct auxtrace_record;
> +struct auxtrace_record *vpa_dtl_recording_init(struct evsel *pos, int *err);
>  #endif


