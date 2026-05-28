Return-Path: <linuxppc-dev+bounces-21626-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A965CD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 09:13:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gR13y70KPz2xM6;
	Thu, 28 May 2026 19:13:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779959582;
	cv=fail; b=NPsUoQwg7iRKxSI4aRbES5oFsBs6XNO9dzONWc9ZjRBzxPsGmqUuEulyZ8kqAICdR9XutfTHneayQhMfsH42s5+blcw3aIx2tNZ/zUlx+/QS7GE/tp4AAaooK5UW6OIDI8+Iarl8mlSKVxrvu+pMJeYhgf9KWrzhsOFBkDuvOTDDcd849dWnFaSPJNCj8A7iKG3tbmaUhMItouG3123+r3C6G2Q3jqiaLu7IfTo5DniVJmjnf6++pQ3vF57HGt11qRuu2jXrexUTmMVfWYToq8eAGLjX5GCzP5TfDT/4M6pkRg72dpsPKM94ghf3bL6Lpa7xzKz6llV6qckREQtf5A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779959582; c=relaxed/relaxed;
	bh=rHup9dFG36J/57JgnmgGTh49ximPEGEGIq0kjdWDbvI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MT0B55PuxFsAKg3df16M8BR/dAsDq6oaI9JSLfXDNrbLk5zUZzM1X3AAfdiVHOadgtEcpfIFsIRYeKIpKYPqb7m9Oc2oSCaEJrUu5SeRaKhKLeQ7ciooFprniww1onWmxQ9qA9+Y9ErHIwU5V85QFAOll3FJyDOIdXhY4CYZINKoBKt0Pa2oe7u92iXcMdCOelT+6wErkTbO6JZUsjqEYIDi2VQf2/4JIxxI7K7JTBt6utUjHC7XiySRfvmU4OGIS0SxcIv7vT8ag6C9v2Y56dPWKJbzGHP/6o7jsQpLQXxm11lKirHxI8LgkZcLRw9lRZW90TzzJCQljGb3kmH5zA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=alHiFLBZ; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=alHiFLBZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gR13v2lbhz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 19:12:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779959579; x=1811495579;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p3yj6Qbuwyldg5irHn+mxjOr1HyW9k0srcJ2G8E+AqY=;
  b=alHiFLBZX4y+YdP1XDzJIaO9ZMztjJuARFyLHWYHXnqyZI5SImE7WuKF
   YHmiEf3rZORQ6DK/PGDK1ASLoZxcATd3tAR4ycU9JH3FtPxbsA5dMDgrF
   Q3VZKwj9X3mqTulckFaXYYilbmFe/siSjFXdrPxiq1iLfVJ7V2pKL0o1O
   mDqREkayXtekUWYb3dhyMI/7cw6/CN6feWpOcRTGaMT6euZ7goJCG6XqJ
   gljwu+XsYFKqTCDaQNSZviSgDwHCp3bBzmIyAWYkptT2kow2trprvRGcQ
   iR5SSyP+U9qPSAneXgI9vLiyQ4pQjxYbc9BHFAirk//42eFuseMPOn71n
   Q==;
X-CSE-ConnectionGUID: gb4FuPvgSviDHVxkdyQRcg==
X-CSE-MsgGUID: IddtB7coQwC5w3QNqX6vDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80700377"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80700377"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 02:12:53 -0700
X-CSE-ConnectionGUID: kHcULiYtS6S2a4oZEjLqFA==
X-CSE-MsgGUID: vW6b+zshTayunvCAa0No5A==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 02:12:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 02:12:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 02:12:52 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 02:12:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dddTKJ/5Nptc/V3RU11nE+rTu26R8JPMd/9IZOB15U/4LpVMXYhhEzM4gTM3r1+z9juujLfCslUrpAjmx56t1aRk93g3j8/ZZErbZz43sHfduztn/EZwpY2RdGMvPE9CjVXyqx7vqwi4LM2Hz4m8Rp2zNOwSZd28OYZ4H8RMrNnYKISVI2zqu6cc+hx6juQl8RX8Pbur31sJjJoUU5jGBjNNQ8w3EskRqUkb86KpOhjifE8IXPWBvH/+CYvN1eWgZdbyPrHaiXy1HIjrvUzpjsaHzqpFTqf4/FVkpHAYGqf74toi5LS5IT10CtJq+o4fr0VTqZOgWwu7oJ1/A6QKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHup9dFG36J/57JgnmgGTh49ximPEGEGIq0kjdWDbvI=;
 b=Yk3qZ1+CtrGOQOO74pjEGkjBcveHUAE/2QIOreGLxCwTAWq6ETLyCBxinVIGrYruWnbJlfLP2gFLxz/7z5FV4Yc9MH3+42ni0rDaktq2iKwaop77wwQiKNajXtlw4nE8PUKiFUhhJgqpiInj8Ys/PE6+JeKhaS+PAFghy8uAdAsRQ5UpL2TvQCvWMgpwUG5Nkul28Mv2eM6JgtGSgU/THNm++OCy/UrZRei/UfOkuDWiLlPEFmr3Gw13zh1D5Ppx9hWhs8UgqdUNsrU7La+FTCILevC//WIB5urO3TQ0Iv7P9B7fIRO8tW2jU+GoqLcsPQwL5eL2+Y+1+5wuZvmZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA7PR11MB9594.namprd11.prod.outlook.com (2603:10b6:806:4cf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 09:12:49 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 09:12:49 +0000
Message-ID: <db443a1e-e6fc-491c-a38a-1cafc8e674cd@intel.com>
Date: Thu, 28 May 2026 17:12:41 +0800
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
 <912676bc-230e-410f-a5fe-153b0f304aee@intel.com>
 <42a19577-fe56-44b4-b0ed-37cde6d03ff5@linux.ibm.com>
 <508a604b-2d30-47f4-a63c-36778a1d47c7@linux.ibm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <508a604b-2d30-47f4-a63c-36778a1d47c7@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0017.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::11) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
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
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA7PR11MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: c11070cb-f5d5-4171-b84b-08debc994a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: jVm+yHQd0xMb9oHlx0cfKVQeZKp9g5/8enMtn0jjjzH0CA/Hm6uAsCj+C0Erk8GJroJhGmBEHC2MCSZ/aQRMIVpNMalwHkixUzN+Gs4a/nOw5UWpOj5tSQgVqpd2RAl/XnpFCMpJuek0yAALinCOr7v7gvOA+YcXlLtSpRDjJG2ayf0wu6i/kOIecpn5wMaeueczRdQNMcvK0mhggBlxwtdY8lq1CATIEEDDqqqgrbHsIlj0VNUHZ33bb0/s7mPUVvE35+YIqvr0f8+5N9y5WPq3Rz3k5i1Ode3a6vre7l1jiah1TroBCAkR3CoEKCF3V+3aiqqEo+GA2j7hyba5JOolWNYic4umrm6eQmxiIERYaezM+WXZgFfOBRYNIoWNdwgOHJ4ZpNexImyp0hanuvOf3i3sAtoCHRp5uFaDR3vJ3rqDIAd41UJspHrnQ7KB0Rb4pv+PK1FscpZ/iUGR/zZw7uD3kgZnNd/lwiL5/95MFW6xeqC2WgliuPqJ+NIzowhucaWs/ZNG8yxfcvOgJuSXZbjxVyZeMBUl9lkfA/GlcPlYS32PIDutaOXo//9UkCfC3UjzUvGIrJ9UjKWy+TuS7dMXYNo0+LlqydDpgF+hXC5FdQgaQ+KlkYgrFc+CE0x5s3xAp360i18u8e9740U2mmRlwFFdYDgjzqlMntUa/ZyFtBaUkjPFoNAxQlQh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFZ1SjM1amJsbFd6Y0g1MTZhdHV2UnFQekoycnRnTU5vSms0cUYrSUowbUN1?=
 =?utf-8?B?ZGRPTFpjQS96K01Yb1pXQ0hEUWQ1VE5RSDdwYmU1WVFGdU41NytPWlFZTFRq?=
 =?utf-8?B?MHNYZXR1MGRvREhoQWlPMGN2WmM1WG04VStKOEZ5Q0E1SU1tVmlwcHBlSVFm?=
 =?utf-8?B?TUZtYzUzc2N4RjVkZy9HaWswU0M0dHBnR3VYdE1qSG1oWS92bkZTdERtRTdX?=
 =?utf-8?B?bXZSRTRqVFRGRDJMRTdvQjZ0VDFtYnlsUmpnZVpFRDI4RmxpU2hTeVFpdXFP?=
 =?utf-8?B?WEFGVjRPbVB0bDExQVcxZ1BkTHVFZmQ0OFVxT29GdVpMZmg5cDh6a2hrNVBt?=
 =?utf-8?B?bjExa2ZvK0dvODZ3QkNGZHJRUmd2eFY5MzJWSnZiTWU2T1lMNVlacjZYc0c2?=
 =?utf-8?B?cTdmTGJiTmxCZVkzWm5GcXRRRTVMbVlEaXdHOUJJZXUrRmM3L1RSWUNYZ2xo?=
 =?utf-8?B?eXM4WTdkRGYvam5nMjZtN0ZMK2NEU3VzL1F5WnIyaE9ibFlsNHc5alFubWFB?=
 =?utf-8?B?dEYxcXgwVmF4RmNwK3liejlkZm44aGcvK2xQMkpFTGFLUHpxWmJLaDhPcnJo?=
 =?utf-8?B?V1FyYnNGNzd4WUxyWTY4UUQ3TWttOWlBVjUwa1Y4NkZyZnZRMHdTUytzamRs?=
 =?utf-8?B?V2t4Tk1GRWpDZFY3eE0zOFY2NjlaTkpTS0cxcGVDN3lhUmZ4ZmI2K2loTHU2?=
 =?utf-8?B?VUNIU3p1UnNNYjZhNEZSVzNMWkZ4alh4aldkM2tOc0NBTFRtU0dzNGxSOEtz?=
 =?utf-8?B?SmFxTUVLcHVQandkS1JDZFBIRE9lY1dXaW9LeWlUblZyQTdiejVFSldmd0Q0?=
 =?utf-8?B?SEdtZTdDSE84SkdFdTY3eWVVUlNBMzZsRnNwYlBYcGZ4YjFpNTgxelRxMSs5?=
 =?utf-8?B?c2gxdldTZThjTERPNHFkTDZta3pPbHpJaGV5cCtQVU5vSkRxRFVCaW5pRHlP?=
 =?utf-8?B?Q1VLZDd1djN3b0laSGtQc3NvTGtHQ2RweXZhdy9FbjdzQVVvT2FuVWxwdTRH?=
 =?utf-8?B?NldWOW5Dek5Cd3RETmlnZEhPclh4TThKOE00aURoSXU5U2ovbmg4dklvRStG?=
 =?utf-8?B?UTYzbVBRZlFUNnFRQjJxZ0FhTFlycTlZVlVBYjNpY2Y5Y2lzVTNNa1ovc1d4?=
 =?utf-8?B?U3F5QnZoaGdYem9YTytQc3JnWC9Cc3F5V1JFVEgwaDRyNUxxK0VuRlJwcXNs?=
 =?utf-8?B?aFArVUp1bk9SYUtXRllDRStiL3pXMCtubThqVm1nNk45RFZuamdpK0xHWnhY?=
 =?utf-8?B?RW1Qd0pac2Jnb0cyRTBha2Zmc0p5eUdKbjA0aDVjbitOcUJGbEJtV28yZjB4?=
 =?utf-8?B?a0EvSnk0b1VDcVFhVFlIR09TdUlZYXFFOFlLWEt4U3ZrdDZ2Q2QvdVV5K0pa?=
 =?utf-8?B?VlI2ODl2QnBXZmpUQ0dYOW5RTko0T1VVbUN5OWx2Z3hlYVF6aHRGTk55VWhp?=
 =?utf-8?B?bFVsNHRhbmhrMFZJYm92cWhSNkFuVmdNREhrZVpJak1ORHo1UG1pQTdYS0tj?=
 =?utf-8?B?SFFkUkRPVUdIbnMxYVNDRmpqSjZzemp4My9OdXVrQ0VnSkhiV0ZmaTY2R1lO?=
 =?utf-8?B?RXBpWWsvdkRCM24yK0kyNlhBaGUvZkczQ2hpVEJGUm1qc0xrRU1adCtjNDhB?=
 =?utf-8?B?Y2RIazgvZFdCNG0xQTlLQk1RL2x0bHo3c1A0K3Z0d1huUUorZUxCOEVTY044?=
 =?utf-8?B?SlNIUXJieTVjS0c3c3BPWDJGejEzazF1ejJmWnhLOXB1c0JsNU5TV0YxeDZB?=
 =?utf-8?B?RVFpWFNJOUc5anFOUXhDSmwzRkJsT0lEZ1ZONmNXZFBNZTJzUGY4cUo1UjA3?=
 =?utf-8?B?L1IwM2pNenBnaERZd0lUMkVKTW5Wbm1ySGc5a2p5SThnU1ArTHdReXE5V3Bu?=
 =?utf-8?B?UVpCMUswMDVNak1qM2VxVVNqVytMSHFWQzNDNzdycnVXT2VoeHBEeDFxeVNu?=
 =?utf-8?B?c0ZZaWFTTC9oMEw3SWNVL20zd2kyd3ZhaEs1ZjBRakxobjlmbm1zOUtzUGtm?=
 =?utf-8?B?MG4wMWw3Q0tCN0dmdUlyRnk5cjFBSnB0Wkg5cm5XMnRXQzRxNmQxdjVLNG1u?=
 =?utf-8?B?aWpucWVEcVZIOHBDckpzMUQxSVllREtMOWEzSEs5OUlJa0lEMk83ZHBzaDlT?=
 =?utf-8?B?TTVrMUhqWE0vYkg2Z0hsMjFiVElTeHRiTmdVU3VYNm9OMWUzWGFKZXV2UEtX?=
 =?utf-8?B?SlVBTTRVd2Y0d1hrNm1vVWdLRGp1TjFrQ01uQkwrcm1ldjhVMU9JT3dsZjd5?=
 =?utf-8?B?Y1dXZFNRc3RvWHowMkE3bVFHMTJBeVJuNzdWVVEzSWU5M1J5TVh5VVZaaTNv?=
 =?utf-8?B?RzllMzFDWUNCaTZqdC94SEcvQjZUcDlCY3BtZW0vV3JWaVRzcmw0QT09?=
X-Exchange-RoutingPolicyChecked: CfoI8oTKod8op/5l6NvIhewX+g50azqztK98YzeEUnycObJSH1aV8eRknkyqAubLrBz4PAOO0gk2td08fUFHadttoo1RynW2h6TtrF+9E/nlXAl8cbaqg0Ani2iW9y98uCVEAQOwC5VbISNslpKxdYkSHEZ+gH7hRer3JRQuwWTHMEaSm/HLbtI5upgFaTfFptqTwspoAW7Wq0XEcqQBJMcoiKmX6mIjCosf6Q0MAfmDKJ38yVy7eS5oVICB60DrVdlNcPIKj/ZMTORJg/I24Aje620yv6+yIF5/88DrbkL9c+InAe9E5ixWuxRl5ne4dGUQQwzf772qx7aXDF5WDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c11070cb-f5d5-4171-b84b-08debc994a03
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 09:12:49.2080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVp6BgapU76xbzTaz1GOPLzj5xU4Ck+XmzM3rOxHvgpXxaV/ZlFTsEHIsRBNL5MLRBXKYMXLdHS+0PHU1lx50A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9594
X-OriginatorOrg: intel.com

On 5/28/2026 12:58 PM, Shrikanth Hegde wrote:
> 
> 
> On 5/27/26 11:37 PM, Shrikanth Hegde wrote:

[ ... ]

>> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/ 
>> include/ asm/topology.h
>> index 66ed5fe1b718..bd1db3b1dbb0 100644
>> --- a/arch/powerpc/include/asm/topology.h
>> +++ b/arch/powerpc/include/asm/topology.h
>> @@ -131,6 +131,9 @@ static inline int cpu_to_coregroup_id(int cpu)
>>   #ifdef CONFIG_SMP
>>   #include <asm/cputable.h>
>>
>> +const struct cpumask *arch_llc_mask(int cpu);
>> +#define arch_llc_mask  arch_llc_mask
>> +
>>   struct cpumask *cpu_coregroup_mask(int cpu);
>>   const struct cpumask *cpu_die_mask(int cpu);
>>   int cpu_die_id(int cpu);
>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> index 3467f86fd78f..26c15c786c55 100644
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -1101,6 +1101,13 @@ const struct cpumask *cpu_die_mask(int cpu)
>>   }
>>   EXPORT_SYMBOL_GPL(cpu_die_mask);
>>
>> +const struct cpumask *arch_llc_mask(int cpu)
>> +{
>> +       if (has_coregroup_support())
>> +               return cpu_coregroup_mask(cpu);
>> +       return cpu_smallcore_mask(cpu);
> 
> 
> This function body needs change, since LLC is not at MC.
> and I didn't account for power9.
> 
> Rest of the structure is what i would prefer the direction to go.
> This will help future architectures too to account for their specific
> needs.
> 
> What do you think?
> 

Yes this direction look good to me. Regarding the arch_llc_mask(),
how about the following per Srikar's description

const struct cpumask *arch_llc_mask(int cpu)
{
	/* Power9, CACHE domain is the LLC*/	if (shared_caches)
		return cpu_l2_cache_mask(cpu);

	/* P7, P8, P10, P11, SMT domain is the LLC*/	return cpu_smt_mask(cpu);
}

thanks,
Chenyu


