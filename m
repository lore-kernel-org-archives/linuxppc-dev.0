Return-Path: <linuxppc-dev+bounces-21492-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2084CCD5BC9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 03:15:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPdDD4wKhz2xSb;
	Tue, 26 May 2026 13:15:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779765324;
	cv=fail; b=cKyDku0ENAitW28WrjzKyc6VS9HsAv7plYAVRSkZJUoEY2/VCUMPt1Y9lF4XAGlllb9H3a0a0Z0XQQMvQnWT0Er+Q8MNEMxaapfRhfcxs8sD2/T5tThaqe9K198hYVWd1S38ViOzox2mERcG9JVorLp1uic33w7qITGIUiapInd79Py0GktDQhu6lbqJ6lWE7jD6fxFgTPkVh+TJaGsjMnMBxlG4i2KmmRfX/F8irOn5hrCVqt+a50BqoCg+/1MKtOR5mfiBN58EdGd9W+f949nV6aZ0/P6o0uHnlhWawY/woXVcPp55vl2g6gD5RLZ61p79uODPj557RaffeQJ7iQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779765324; c=relaxed/relaxed;
	bh=yq3XBiXxQB4FDEQa+jhyJ5rJg3PjnMPgiExR0BzWOs8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I7XfcfveGz2AE5Zn5WHmYN+9A19aDp+ZT0x2gEHtqFyC7HGQuYC2hEduAVhyJM5kOmejTplAOy1CYn4WV9BRGfU/9PbUpGmsJOdENub61KnEKf9qqVWBQ4BtzroWzKxheAIFVmKbHKcVQg6h7lQRCI/kzqi2bCmN9LtBt0ZhisoMtqq1NzAT6IOm9f4JbBAS8VMIiVkO1HTuY7wctpsueVNoGGtD57bcOadd1LwJSYYE2E6KAZTxlE6+22Q2QFRPHsj4gQdv8FsPSdvOdrxHGqHiwudZXWdrXRqabu2Td38hmibveLlkwHHqZHEHwTVbOJlaw8GmpdSDesAtVtOAoQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RsG06/Eo; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RsG06/Eo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPdD85l04z2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 13:15:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779765321; x=1811301321;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ljTBwJosb8Y954+b4rypJRMLbevw9liHvrhzwKrhhRY=;
  b=RsG06/EoQdAv7yfQVL8PDMHHHIHeaCmHwUhp5YcHZx6oshNg6NdVfzi6
   sOzhdv0znK5auq+AtZGy3FQSfF6P9VlWZAiaU2IRi3w+3W2JYiFA96Ykb
   o8nIBGNfNtn6z5/Jkl5bR8fxt0gSDCmQDSguR+q44swhjvbG/TdkeBtPS
   oF/jWRYaHjZ/wx3SHAmgZf5rj5JYkDk4/i0Q1jCuEYtgVlOeLciMoUa8x
   /uRzAjGWUDhw9dZ88JoF6aylV5twolGCChhRBfK5nzDbNydq/haqKUTZv
   Wr3MtMtW2OHrExPLTUKSYVDaUuE7O1J7mrLKpx+plmaLY7ptbHns/3rBz
   w==;
X-CSE-ConnectionGUID: 4+c/++sHTre1NCg6FCT2bw==
X-CSE-MsgGUID: ATkpslk4Tz68Lyt6xuYjZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80629453"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80629453"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 20:15:10 -0700
X-CSE-ConnectionGUID: zQFGCBldTTaLmKhob+lkaQ==
X-CSE-MsgGUID: WsSg5iLmQ2eLBXSCDD2czA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="245811619"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 20:15:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 20:15:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 25 May 2026 20:15:10 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 20:15:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGIo4qS7mnLJhNQQ5DL9dachOTgrn0yPzZwAC+deM19C+Qr1Fz4lCH+J454lSMIZ96qTtJK0JnQxpfAEOxzK0AJsCEVa4S1XNdlwl1oI3FhJtHHQfs2F+LSNsBA2n9WxSPblALTsDstb7Ge/P+jqqcIt6tR0Ij0pvbjNlpANLYosvKT7UbXcyQasyNWzwZZGhniK3gY/7X+/qg9MlrxwprrPiGogCWq7BTJJmDf1e/zoIcu2ZdLSTn9pao3q8YbZfwfjYsEEW5Yn5m/M4bGy0T6fFqKH9vS/FHOa/J15F0AkJ3STVfY7dIPHOR48btmPgWjZj5wmjK+q+YXVBpBIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yq3XBiXxQB4FDEQa+jhyJ5rJg3PjnMPgiExR0BzWOs8=;
 b=HtjUxcS42dM4jxIxDh1yqfzOf2EQaMLtJ8nVwMI3uEbpIdepPD1MRfEH+OxNzypMhWy37E5pweokGNYXc0VO7bAXp1anuBVPjGmNQZJXfRRVnS/n/zmiwcbfNmHiGS/esC5AWbSOylUjW9zFIwcRt3lQOvwtdYQXXNX1jwB+KfalBh0Qku1gvT3qfZ9bGgA3dzc5oEt7fQPhESoYliDgFtU/OK/P8WWJYQKxcH/127oj+JNJmAm8jubMJ+vuYLis2Qx198Uu2dLsPu26ZZANLMh7oBfraYCO+boPJ0Au/ye7s8/Gm9HXdlJghjZs3L5lOf7tahX2AEKrzzNtRu8t1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.20; Tue, 26 May 2026 03:15:02 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 03:15:02 +0000
Message-ID: <8d14c844-b4a8-4af6-acab-2cfdd42225be@intel.com>
Date: Tue, 26 May 2026 11:14:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
 dereference in build_sched_domains on POWER9
To: K Prateek Nayak <kprateek.nayak@amd.com>, Venkat Rao Bagalkote
	<venkat88@linux.ibm.com>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Ritesh Harjani <riteshh@linux.ibm.com>, "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, <linux-sched@vger.kernel.org>,
	<tim.c.chen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <bca40921-d351-4439-ae6a-9e5294f23e2e@intel.com>
 <75179ee2-ec20-4757-8631-79b1f304c366@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <75179ee2-ec20-4757-8631-79b1f304c366@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0058.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::9)
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
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DM4PR11MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8daba5-7dfe-4644-903a-08debad4f9c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|56012099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: MD/2bTatSCqDvX1VHlVRRy1dM3XRyWKhyYR3wyDPsvssZbU82ukbRZM8NeyoDKaESYqlyVCKFdwFoa8qMN2Fbcpnq1pkp3QWSIUHN6g6mLpQuKlNUbmzYfjr1tcJYlfEvAhSpR9l9hoBpZ+8CTrK0AN/2h9T6V8c+we8BCXsdVMGMzOXN7yI6RzZq1bmTsKvNPx3iAYfbiCNBmGFQQe0vOJGg6pLQ4F6XOwvEYPyb5JTIP9m4UV4CDgFZl5kM29y+rmMluUJJe49af0c+YrwheBj+q6o8qe+U+CJKO+hCm2tlxw90cM3ycB5cK0TVq5b9rQ80xT5FzNwzTdg2/nlXzqM5743V1pag0QrxhJmt4CQsxPfccCaax+opVJuyMNTn2Sg/IDF7h303W+j0BDnWqwzm6iS2ES/hoVNap8ioy5E9zlFf7dvkrj2jyjPL8tL/f/NqomQSfsIXNvK/6I51J5CJ4vLYgMzKd7ECFdeVPkz1b3SKWibfodInVuIvFGZoDi1y9PzKR83FiW2gaiLwxPaZylEfRpScD0TzJyQiAZJEbJRqzBGPQkrzxjBoieHgZf4gxsgyB91nq2UItG+KogJ8KNmddtXvuqAWx/R0undaTOwnYbU8usu0RsIV2hjFlvSMFq1SnAbWnnIpudrXPuMpwIFsEnCfRdHB0knQDtvo7M1TM4XrzuKnG/7N1gM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXR6QjB5b0NUZE1jNU43T3REZTcrRExxcEcvSXFmcko3TlB5YTZXTTBUc0dX?=
 =?utf-8?B?TWxBVHRqQ2RCVzkydDJiNTZTTHRseDczRHpkYXFFY29MSTN0KzVMMzRyanFr?=
 =?utf-8?B?VXd1dHY0VlJLaU1mMnE2NjhDZ05EVDZTRjVSUHd5dVFGcGdDM3pGeHE2TTRX?=
 =?utf-8?B?WHd5TUJDczJORHlFTlhkbjg2ZyszV0o2RE83cVpzME5uWFdPNlBzT3R6Mmo0?=
 =?utf-8?B?S2RtQzgrYUh6Y2w5SFMvS2tSRGp5YW9NT3haVEhqeUhrYUp4N05OQ1lObTRK?=
 =?utf-8?B?SndrZXM3ck5aTDE3aUxzRFN1MTRuSnVxQkVhUFY3S0ZNTk1aR3VvUnY3WDJZ?=
 =?utf-8?B?RWc0cUtMMkdYcDhjaFFYVlkyZlpSV1NVN0dRSjBKUkZpVC9EVnFjQjlTZWFR?=
 =?utf-8?B?Yk5BUjc2cWtQZWFrUEhsVEdhSmlBN0NoVmE3NEhsbG81S0l4T3lINkZRVDZa?=
 =?utf-8?B?L0VFVkowUDNsbTlkSlZDaEg0aStMd3N1UlgycmdtT1NGZk0xNjN4RjZ6QXRP?=
 =?utf-8?B?TGVtVGQzVHlpcGFNUXlxb1RYSngyT2N2TEh6REF3MG5tUGducVN3WW1CQTFq?=
 =?utf-8?B?ZlZlaGV1azNrNGtMNDNhSitETU4ySGpUdldVS1Qvd3B4RDJqK1ltTnNWSnpW?=
 =?utf-8?B?YkwycGVWN1pNK1hTRmtCMythWEpZeEZqUm9vck5tSXZBMGdGNXJTOVZSb3NG?=
 =?utf-8?B?d0h5YVF0NVFQeFFJcW5KZUxaL1hYNDB0dWwzcmdNYmttZWw2SWhFNlRuSTBW?=
 =?utf-8?B?aEU4amp1L1FwQ1gxdHllWW9melhoS2o1MDN2clVDM2NtQTI2V0hacFl1TXgv?=
 =?utf-8?B?bGlTa08xc21JUkdBWEZKZmcvZHVXTG01bnVNMjRsdkpydm9uZVM3RUtMNWhu?=
 =?utf-8?B?TGRmQVJGaEVaT0xIUWRkV1FnZ1ZkcjUzRi9jR1VTUU14VDhOcUF6V04xL1JB?=
 =?utf-8?B?ZzlEZVZ3OUpyYjgzQ0tkdDlDOUJZamlmVWFXVkJKT2xhR0lVU3J5WUs2c0dv?=
 =?utf-8?B?azlSTFphTVZ5WlAwNlJZU3I4Q01MMS8wRWtDUDFYTE4yRFgwWWp1TUphcmV5?=
 =?utf-8?B?WitEdUdzbVNLaDN3VE4xNkpGQzYxNjhoaHRhRzV4cEdSeVdwVnh0SEd2dURM?=
 =?utf-8?B?cEU1NTRUcFF4a3kwUnRjTkpnTHlHbzhvQlZKYVAxY3dPeGdxdGxEOVBqQ0xT?=
 =?utf-8?B?M1JSMHphNmdTaDIzcmMwRnFpRDdBOWxOQmFKaXV6WnVWSjllVFpNMTJOZlN4?=
 =?utf-8?B?SlNpdUN4dG1XWTV4b2hQLzk1V3BNVkZCWkJjZ3lFZWVmL25FMlc0Q1hpTCt6?=
 =?utf-8?B?TVNydkVWTytVZXNseU92K0Vib2xYanBacU5EMWg4RWJ3dkRCQ0xGaSs4K1Vn?=
 =?utf-8?B?ZnNiVkl3dFp4ZUxyN3lyZkFsYlhQdDc4N2hlN1UvUDVORlNuYXhTcTByZldu?=
 =?utf-8?B?V3JUYXdMbFA2OHdCdmlGdHFZYTBTSGZ6bS9sVDAwcVpiUGtzTkJGTFU1WUd1?=
 =?utf-8?B?dUpNaE1neU1scVU3am5rMjhFVWo1TGlZOGxDQ0dzV29GNTR6akV4SVV1Wkg2?=
 =?utf-8?B?cFdYRFhodG1OejJEdnY4NzBUbFN0QnFyQUY5MlVSWHRoQjBPcUdHbzJ6U0hR?=
 =?utf-8?B?WGdQYnlVOEEvYi9WbmgrNVZvNGsyLzlwZEZGUkRweFNuRTBJT3JYT0dkUDhQ?=
 =?utf-8?B?VlJxbHJNcXhtQ3dEZTlUU1RFTGQvVnBpRU9HNERCdkZ3NEtRZWN1dEUzZWIz?=
 =?utf-8?B?aUd2QmZESityNjl1aWpOMlJaSzNMUy9jWDRoUjJwalZYOFRJYlVxaGlSUWZD?=
 =?utf-8?B?bThGQi83WExzM2g5dzNKRDRIVi9sdVUybStjNXVzYW84bFdFanA5NXNRS1pZ?=
 =?utf-8?B?WjdFNkhFV2ZpM0VwblgyUzNLRnhJWkZ0ZHBnWTF5UnR4RndNdTNYWVpZMUx4?=
 =?utf-8?B?L0tReXZXRHhCT1RZTjh6QVZ0QThkZ3NuYk4vU1cybUJyNWZqd01kV3pRTnVk?=
 =?utf-8?B?blo2VXJtaExxT2ZqZWZESWRNRG80bGozSE9XdWdMMkRPM2hva0lJd0JOSVV6?=
 =?utf-8?B?bTlRZVJYQ1VoUlBPVVptLzN0S1R0VlZIZHZFQ0hWS1BNTVJrbkJOV045MUdL?=
 =?utf-8?B?dEkvOHZ3TWpDcHJXYW5BYWFrVXFkTkszVCtPcGEyeFRoelV3eTRZSW9vQWRX?=
 =?utf-8?B?dzRHdkgyc3JaS1o5djBMdVlnWGl5YmF6anlpU2hoeks5bW1keWZvbmk3cFN6?=
 =?utf-8?B?alhQM1FQMnp1WmZCSXd4UVMwMmw2c2JFNVFSdW96Snh6bTNXMThMMkRYQWE5?=
 =?utf-8?B?bXBzWFNXZkNXT01UN0RnN213ZU41UDA0RmwyeldTamp4Ukd3V214QT09?=
X-Exchange-RoutingPolicyChecked: TOrHQdfYznp3gK09D9ZTBnbLm1SKOb3ac846bS91cpEL9Y1N1FYJ6Ix8AI+Bn6/yOVVr5ZskffN8D+4Et1XsqNDjrTBK/GGyVNqIVN9KtDJ7SOTUrme+xZ64MA9tgz/cd08CBKCUT4ovFxpYjKJvcKGIYyqepL/T//ilqlJSwGg7ktxiD8v3u41DXsedUsegJCkCmKm5A3aeBktkXfXZwKTJGcL5bE1YstxX5esfW5b166BmnOV9B91GcaRk4Yhy/AZwVrInto2qalV+zfg0jyggHk/jfGk5cMHCdIGch2J8UXASFvy0OwpY3PtvCc6a/u3PSXW6DTL1GFCsUzr9vQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8daba5-7dfe-4644-903a-08debad4f9c9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 03:15:02.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NpRa1GTPvDEBQY9O/qZJZRqKeT8eNwNEl2v4aZtSRqnBs4iIjWjGAqzBlcrtZYFt15Vn5s8Mu80mxPCQfyncw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-OriginatorOrg: intel.com

On 5/26/2026 12:16 AM, K Prateek Nayak wrote:
> Hello Chenyu, Venkat,
> 
> On 5/25/2026 9:05 PM, Chen, Yu C wrote:
>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> index 3467f86fd78f..cf6c2e4190ab 100644
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -1042,11 +1042,6 @@ static const struct cpumask *tl_smallcore_smt_mask(struct sched_domain_topology_
>>   }
>>   #endif
>>
>> -struct cpumask *cpu_coregroup_mask(int cpu)
>> -{
>> -       return per_cpu(cpu_coregroup_map, cpu);
>> -}
>> -
>>   static bool has_coregroup_support(void)
>>   {
>>          /* Coregroup identification not available on shared systems */
>> @@ -1056,6 +1051,14 @@ static bool has_coregroup_support(void)
>>          return coregroup_enabled;
>>   }
>>
>> +struct cpumask *cpu_coregroup_mask(int cpu)
>> +{
>> +       if (!has_coregroup_support())
>> +               return cpu_l2_cache_mask(cpu);
>> +> +       return per_cpu(cpu_coregroup_map, cpu);
> 
> Interestingly, on powerpc, the MC domain doesn't have SD_SHARE_LLC flag
> set but I believe there is still some benefit of keeping the tasks on
> the same hemisphere?
> 
You are right. I guess power9 reported here does not have hemisphere and
power10 has, according to commit fb2ff9fa72e2:
"From Power10 processors onwards, each chip has 2 hemispheres"
but yes on both power9 and power10, MC domain doesn't have SD_SHARE_LLC
thus aggregating threads to 1 L2 domain might bring benefit. A side note is
that, cache aware scheduling is disabled on power for now because
power does not use the generic cacheinfo framework, thus its cache size
is returned as 0 so get_effective_llc_bytes() returns 0(for now, unless
we get the help from IBM friends to support it)
commit 7030513a0877 ("7030513a0877")

> If we are actually aiming for LLC, I think cpu_l2_cache_mask() is the
> right cpumask for all cases since tl_cache_mask() also returns that
> and the l2_cache_mask is set in all cases covered by update_mask_by_l2()
> in the same file.
> 
> If consolidation on hemisphere is beneficial, then the above diff
> looks correct.
> 
> Note: For has_coregroup_support(), with the above fix, the scheduler
> side llc_id will now be based on MC domain's span which seems wrong
> since it doesn't have SD_SHARE_LLC flag and might lead to other
> behavioral changes now.
> 

You are right, it seems to be a bug when has_coregroup_support() is enabled.
Maybe we can always return l2 id for power?

How about this(revert previous diff):
diff --git a/arch/powerpc/include/asm/topology.h 
b/arch/powerpc/include/asm/topology.h
index 66ed5fe1b718..3b3b4156f418 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -130,13 +130,15 @@ static inline int cpu_to_coregroup_id(int cpu)

  #ifdef CONFIG_SMP
  #include <asm/cputable.h>
+#include <asm/smp.h>

  struct cpumask *cpu_coregroup_mask(int cpu);
  const struct cpumask *cpu_die_mask(int cpu);
  int cpu_die_id(int cpu);

+#define arch_llc_mask(cpu)     cpu_l2_cache_mask(cpu)
+
  #ifdef CONFIG_PPC64
-#include <asm/smp.h>

  #define topology_physical_package_id(cpu)      (cpu_to_chip_id(cpu))
  #define topology_sibling_cpumask(cpu) 
(per_cpu(cpu_sibling_map, cpu))
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index df2ceb54c970..6772eb0ce493 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2063,12 +2063,18 @@ const struct cpumask *tl_mc_mask(struct 
sched_domain_topology_level *tl, int cpu
         return cpu_coregroup_mask(cpu);
  }

-#define llc_mask(cpu) cpu_coregroup_mask(cpu)
+#ifndef arch_llc_mask
+#define arch_llc_mask(cpu) cpu_coregroup_mask(cpu)
+#endif

  #else
-#define llc_mask(cpu) cpumask_of(cpu)
+#ifndef arch_llc_mask
+#define arch_llc_mask(cpu) cpumask_of(cpu)
+#endif
  #endif

+#define llc_mask(cpu) arch_llc_mask(cpu)
+
  const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level 
*tl, int cpu)
  {
         return cpu_node_mask(cpu);


thanks,
Chenyu

>> +}
>> +
>>   static int __init init_big_cores(void)
>>   {
>>          int cpu;
> 

