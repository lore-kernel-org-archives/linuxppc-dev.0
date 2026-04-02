Return-Path: <linuxppc-dev+bounces-19243-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33200D6AB1B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 23:54:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmzGJ66zvz2yYJ;
	Fri, 03 Apr 2026 10:54:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775151167;
	cv=fail; b=HFvLV3SdljBzKemukKyAmffB++Vu87/MlOsViAfCZf2WzWCM1Yybxt5JlRI5FdBwl+0S1aiKlYxV3aaAnyzmInBexpsY23u0cbkNevp2COY5qnq3tvanwQmfJJfDrQF8HemOoma8ieVLIhXO2N5xRiTaq8EIdDQODh2FwvfEEkLumjA/LECT2ekbuX3j3n/yvb4PB1IC0CNFbpIrFCkm9dCQ9+Nl6+kHiz7loxp4DUWPXL1S/d/1DhDT4sRaujcqG2rcpMu+v2NjemEKXRiOf20/Ws3OE8oDHaStypj840BZSNqj1nwY9VVxdVW3NWGANItkxloZl6Kg7y7YpInC3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775151167; c=relaxed/relaxed;
	bh=wpEbQXaRIygQ5Gv8MQGuGl8df2WMg5ttb7P/U0z2o7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QsoxHCXMcqFrDrEySjc/CfeOD+61uMIXxCO7q9+HU06g5080XqsGo5xhZwlcr6TS26xwjDtXdwAyXK/ThlJ3FECKWGDIDrN8tq0KKkmWc3HuExqtcqlx21dbVaQNXOFrEVijYtRvoEWJtXlaK9t+srk0WZVO8t5Cxomz+PR2tLOtnZZ6nIMJYRJN0p8nzWx+RhQYq7c0ahVh3iRXJJnRMdorLaOnN18v5EeoVfljOo/CFi5rSc7SVbCa+SgMoKEKFMelaSkDKYT9S8qLBRLvy3pkSUK+06OV1m4sHrpWEQCXW/AaFC8A9x9uBdhlIIDLUkp7eYhFpVTNc7mqDYZcYA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i6D/tWey; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=thomas.falcon@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i6D/tWey;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=thomas.falcon@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmppM1jcPz2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 04:32:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775151164; x=1806687164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wpEbQXaRIygQ5Gv8MQGuGl8df2WMg5ttb7P/U0z2o7c=;
  b=i6D/tWeynVJ6YLkVYfz7Dhilju6E9s2taWuc3QlnDvJvzoYNM81ReZWW
   wAWeSTzzrRJzTvvWXxropt4+FpUklxTWEuKm5ZIloteJyh4s/llWq7j5m
   YrpCXR/59o/Ijqcy7JZGSUNVVprJ4iMRqgK/QbV4a7ekHUvAOSnbgpkCp
   Nbn7j9ZFEAWUNDV87NyQV0CufAeaJcV5zagK5V0oB38eiozjZ53SWDoHb
   eJrGYLxGuEukjYUtLzUTj5e/vhFjI5mACqv9umj1MMJa4Otb4F/Kt3BjD
   qfvLy9eowulCivUkGsnpiwA/s0kVIgid0rhAJsUF7A9o5T1X2ztW6XVRv
   g==;
X-CSE-ConnectionGUID: U9kS/TwoSzWGpWTv+NiH4g==
X-CSE-MsgGUID: d11lSDSkR4iNdhBfa9bcDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="63766085"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="63766085"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 10:32:36 -0700
X-CSE-ConnectionGUID: oJybxy3pSzu3k6MoHNZCcg==
X-CSE-MsgGUID: IixFgPE4QeGxC0GsQwfz/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="231438577"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 10:32:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 10:32:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 10:32:35 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 10:32:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4LVUiazoGPmjw35HJscwHWno1fknjqFiY4TRLrvFEkFa6SaASlXVL5h6ysqmiAoYAbC8CKSOww743DzLTUrw/K2qijl8/iOw989TVg5gYhWhKLsS/SQtcJojDrMS3zC3YRci5OtTvt8+vyJAu9n3fTcXZKf8JgqSTgUOSKYpZVYK0pIDIQ2et+4qkjITAAJ5tZhCm/x/L4q5Tyiny8qTDAjuJ9XyY3BcTENoTGbFz4FaaEfX8wXyL6VnPvulSeZhExqMwq4+xAnohdBn8JFUPFZBNTzph2tme0oHvwwPWxLl8au7QOjFT7pqlrE6Q1s1vcTCOojoeZm5BTPL1eCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpEbQXaRIygQ5Gv8MQGuGl8df2WMg5ttb7P/U0z2o7c=;
 b=WRkdQABStBsJV6s1pHbSnon3CjkzXPO1jwC4YO9xVFWt82VqkUKE1A0q0gQaMZF37L1fVafY1ELkcHctomMFNx+6nObliao7ZRG9PGnBFz2dJL1y+TULe91n+K5IhP/pqOsiiQSzR3DOmRWfpJEp8zazN84WKgpJ2ozcWqnyM/6HsbeOWEl3Qat/wFt4mcnwJzo2OBePHzrLqdIZnRWPjP6/ueqUVrqn87O3ouSfuz+3zCVp7omeMMDtqn5rN/LSkYAf0YC3DNVcNQjY/qp0F/3SX353CkWuNvbC9s7a08yhwINCaoBd7EhJZ52qmQc/T6FVxflyGUPUSNuPwFjOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SA3PR11MB7612.namprd11.prod.outlook.com (2603:10b6:806:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 2 Apr
 2026 17:32:28 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9769.014; Thu, 2 Apr 2026
 17:32:28 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "atrajeev@linux.ibm.com" <atrajeev@linux.ibm.com>,
	"venkat88@linux.ibm.com" <venkat88@linux.ibm.com>, "Rogers, Ian"
	<irogers@google.com>
CC: "Kleen, Andi" <andi.kleen@intel.com>, "Shivani.Nittor@ibm.com"
	<Shivani.Nittor@ibm.com>, "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
	"hbathini@linux.vnet.ibm.com" <hbathini@linux.vnet.ibm.com>,
	"mpetlan@redhat.com" <mpetlan@redhat.com>, "Tanushree.Shah@ibm.com"
	<Tanushree.Shah@ibm.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"maddy@linux.ibm.com" <maddy@linux.ibm.com>, "Chen, Zide"
	<zide.chen@intel.com>, "vmolnaro@redhat.com" <vmolnaro@redhat.com>,
	"Tejas.Manhas1@ibm.com" <Tejas.Manhas1@ibm.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"acme@kernel.org" <acme@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"Mi, Dapeng1" <dapeng1.mi@intel.com>, "namhyung@kernel.org"
	<namhyung@kernel.org>
Subject: Re: [PATCH] tools/perf/test: Check for perf stat return code in perf
 all PMU test
Thread-Topic: [PATCH] tools/perf/test: Check for perf stat return code in perf
 all PMU test
Thread-Index: AQHctGqvwcLWcCGhQ0up1SoMnZ3VAbW7+duAgA7M8oCAAV20gA==
Date: Thu, 2 Apr 2026 17:32:27 +0000
Message-ID: <ec33d914a3eb3f8cc1a0ad16bf877ff7284072c9.camel@intel.com>
References: <20260315105751.86835-1-atrajeev@linux.ibm.com>
	 <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com>
	 <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>
In-Reply-To: <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SA3PR11MB7612:EE_
x-ms-office365-filtering-correlation-id: 0cc54274-c27c-4520-9848-08de90ddcfce
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: cG1w590T/5zsZdo8LqUbVcXjiJmeiMBEMQH9JSbi59qp1QW1qUnbZlfkQfkcCsVkzI0CfDad63BeX9nnSKE4SXvjiORF4JIHJdGN7A2VeVn6pp9jvUfL+5HwvD7johWWYnSFywE/Xzuo9RKZG36chqP31o6MJKW2YXLR9vXjOrLMGKQPZLXCozZCivtV3xKmw0gaFGY6C76/VRAnuYJ8yi/SNhSRU95Blpq1dku+pE5WV5qqrD9ZFkc/+ajK2nZEBKOz5vfpvnUg+G+mLclTtEAS8TZmMxBVfPWMtsF8bGqJmvy7GJDqm6XCnSa0EUae+dGRZ2M8fdi4HUrdMyQ38QoL/SAOY9lnh7g9xxrzvCje9WqG0PEGQK586EjBTaZNnhtgIOkNGZMop0DYpaR5tceFMJDrU892fqAzpFv/MrRGl5HtvLXx0lg7g9lHPR036r3tfaGY/2ZiDK5x5odc0i8lwMWas9/+Jtyh43HWSY6mNbKAfcOFddQYZYJi1OHH4p4urINaoHXRbit55Yf/OKeXNfhleVnm0e52L9z+eCq35mSHbbd6J+8lMPp9risluXDdQvL+dr1lMDMD9xrX7pDTWKwntKjBQeNS5TR3kRilswxIBp3DfIYuHL5gEHn21FFOhzihKjEL4n0N/QL2uia0cqpv7BpKzPnuURbVi4VWVH7q2pEuKLTq0OcjZ0geg56Pp1kEsqiTlpykT5/G6hF4M9AOHKH1vsXQZxeLjdFWtyAYEwIOtcaECd+FoRcEcvPDuhaKtFOm//Luwd0qThy2bWF2EPFcb9m+qCFOCVA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUFSNnpWWExkeGwrM0tvSE1HV2NQWTN5LzdUMFlEMmF2ODkvWUtTLzNrc1Q3?=
 =?utf-8?B?ZHVwVzNxT0dZTXFZVnl1OVVINUVQQW1oaWdLRjJHRzUwbW9oSG13UWpHRWtt?=
 =?utf-8?B?ZHR6dS90aVA4UEZRVE4xQzdlU2FxcEwrOFg5aFpmN2NoWkViYzA4c001a2x1?=
 =?utf-8?B?NmU0Z1NVbmtxeERRTUE3VmV1Z2RjNXdxb1RVdGV5ZFpuQ0VOKzVLakN2ZGRP?=
 =?utf-8?B?UWl5eVR4WEVkdHVYVDJSNDR6NDVQTGhOMzJNL3FhQm5VVml4TnJ4WU1Mc3g4?=
 =?utf-8?B?T3BUelU5bXdNdXRLN21TK3J1djdoQm1OYldaVlY3WHBENmR3WCsyenMrUzJh?=
 =?utf-8?B?Z2w1UDJzRkk3SEZKTlpmUUxJVVJDMUY1VW9ZSTNGNlFzUEdrRjBNYVZZRUJr?=
 =?utf-8?B?Zy92Tjl0NXFhajA3V2FPbHJhUmFMM1J5TDYxUzZYSnBlVWJrVkxmTW9SRlBo?=
 =?utf-8?B?RnhsRE9SOFNRQXdnV3dzRkFQeDR1d0xXYkY1YlJma0o3Q2tBOTlIbmxIRWtS?=
 =?utf-8?B?eVNESHkyb3BIekNWUzVHVE04ZlYvSWh5RnJKL2lxOG11cS8rUy9KWXErY1JP?=
 =?utf-8?B?eTluNVlSSXhlNnlUQmxVT3hEMXJ5V2Q1QjJYdXlMVWxXUy9UZGQ4c1p5Mytw?=
 =?utf-8?B?cEtXNzJKM3hBU1BtN1RaK3cxZ1ZOUGZMRmZ2Z2x0bW0wZXpIejRqVTNHdWdL?=
 =?utf-8?B?dXlnRkNUUkJXYUc5UUNGZXRxZ1MrS2x1VGtjTzhjOTlFay9VQlcyRFliSU43?=
 =?utf-8?B?UmtVZzdoRFA5VC9acWRRVUtQVkFwSktFaU5iTlcvWmQ5T0VDUGQ5RkpLSXVC?=
 =?utf-8?B?YVU2a3pBb2poaVZNTmUrVG5PQWU3b25xakhkTUx5b0piK1NVcWNzS05VdEg2?=
 =?utf-8?B?aFJKYXB5YXJUSERCVllaY0ZwVFN3aGthbk90VytIcTFvdWk3RGFlalpJb2l4?=
 =?utf-8?B?UG1NU0FTRXlNYkx0cnQ2OXFFRmppK05PdkRvUENtdlVscTNlRHh6RS9OQU1F?=
 =?utf-8?B?WDNPTmhFM0pNVWJwOHhLV2x3Y0F5R29WOWE3bktlZ2RicWRkdytWWFI0N2hY?=
 =?utf-8?B?aFZoNUc3WWNzdVNLRDlzang2YTF6WEZsUGViOEdSd2x1enB6RXBnaXQyV21C?=
 =?utf-8?B?elNSMWNFRWN3YW1UdmlDRlV1ZFZ6U0tXUG10NlNSeXo4Z1Y5Q2xRcEVibkZT?=
 =?utf-8?B?QTdRN2ZXSVhDSC9icllqNDd2UUs5TDUxWW9qa2NwREFJay92SmJQajFudzVw?=
 =?utf-8?B?TWpxYUVCbnoxVHVJeGNWQ2ZSZXZJQk80QXhRS1lsaFEwMitOR1RFeXJHYVEr?=
 =?utf-8?B?aDhVc2ZmWmM2NitZZnZhR29xVTkzUitGWjRwOVV0b0lnWnJkKzZ3Tlp5K21H?=
 =?utf-8?B?WVhaYjFvaFhpZzFSRVBxakE3OFZid0c2dnFkR0M4ckpaZFk4d3d6OFhXNHE5?=
 =?utf-8?B?TFA0aVUwRlN0ZUFWMGtjWlJNVHhnUUpWVDlLeWRqcGRjNE5LVFdzUkJjM011?=
 =?utf-8?B?VG9mMWs0WGRNakJHSStGdUZmaVRvdHRBYk40MWNYdlZyRkhCSHBreDhwTGo4?=
 =?utf-8?B?UmhFN0xFNHpGL2JpbS8zalJ0OXhOb3UvWks0a25yZzZxZml1b2pFQTNjSjJz?=
 =?utf-8?B?RjF4d3BpNnB4Zm96UHJydHRzR0FjZFZxcWR6MEtNV3BEWTRpMC83ZVFMU25r?=
 =?utf-8?B?Wm1TaGVjakIzMnVkRlJCYXNXek1wUERqRnRxcGtnL203cXhKa0tmMlplZXlM?=
 =?utf-8?B?U3kydnd6S1RxMkxncXVuRU5Ub21WWWowSFhST2Z3K3BYS2VHYy9rb256TFlE?=
 =?utf-8?B?eVZpZzUwbDlwQ2xpZVpBOUkyWVBwa3lybHZudW92TC94QWVQcDlJZSsyeThR?=
 =?utf-8?B?RU5pNmJ6dlJZQWF4a0Y2c1dxNmNmSE13bms2SXpRVEUxVHJZUThkb1FuVzBp?=
 =?utf-8?B?Zm9JSzR3MGtJRU5MSEZBNFRrMXhBTnQ2WUR5cFQyMTYyTlY0QjkyMUhRMWZT?=
 =?utf-8?B?UklGemlqaVk5ZU11TFNGd2l3V25abVhjSnlUK216dVBlY2VsRWhSRHBhNm4w?=
 =?utf-8?B?YjJERXVvSzcxWWNnSlhZT0svajhGOUZKYzlnVGJHUjBZNU5RaWcxVXhRajVz?=
 =?utf-8?B?clFaVGlXQmhHWlVnV0NBR1pDeFNWMXc5SzhnSW9acGVYMitNTzRWNW1vYVBm?=
 =?utf-8?B?SHN2bmRrYlBFN2pJNHgybDRUVDFLUjM1UTFWNTF3VWZCTFRvOHZ1akpvNVlQ?=
 =?utf-8?B?QlV6VHdXazIwdGtaUlNBaUcxTUFuR0IvbGxvWklSYi9sSDBWa0x1eTR1cTRy?=
 =?utf-8?B?NStBOTErNmo0Q0RTenRzcXhkTW9qamY5d1RHVURlNElkNFdqdVVaSFNORy9h?=
 =?utf-8?Q?4yxmK1RQ+GsnEQXjbs1nbsRlDEq1xnTJlD/COJSkllm0q?=
x-ms-exchange-antispam-messagedata-1: nADLSPnqlla8htsb8olpDLJf0us4cxZwGUc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8EFAC23E292CB4A96B8A24262F20111@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
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
X-Exchange-RoutingPolicyChecked: cXwpcvnLumyCEmaO/ZGWpNzHbGmjF5fFZuZIV5ScEhoGz53LouzeoWrR5DO9hbA5ZSCbNi0abQ7ujDrIA6TBZpJniiAjMq7ZeehmAD+2Df2Y8dBX9xhZW6eNWqdnE1kwiAw3UJkq6v0EvvRcJKL6y/rnHg3T5it9ypyRiXlf0AQz58mFD4a00hSPTrcnmsRWfYRNBbSs/mkZuV2WO69uekOVc84D/Z4PSzb9cJvMD4kSiDF3rO85iRLKSLAIh3iMnJimJRog1k037fbPa9nC7elMQXpqm4SA5GF0nElhoPoL4Rwq2VWHiRHr04cjOqHuUEh9nW0ZG1PQrGs0GTZ1FQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc54274-c27c-4520-9848-08de90ddcfce
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 17:32:28.1153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ogAbVHTaVMMlALfV9zJ70yCMQBNwedrymm96fEP7iTd/v4xbsoIkKrmsMg6ul4Q5gNcJGZaEuuvJ/bNTWltmfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7612
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTAxIGF0IDEzOjQwIC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBP
biBNb24sIE1hciAyMywgMjAyNiBhdCAzOjQw4oCvQU0gVmVua2F0IDx2ZW5rYXQ4OEBsaW51eC5p
Ym0uY29tPg0KPiB3cm90ZToNCj4gPiANCj4gPiANCj4gPiANCj4gPiA+IE9uIDE1IE1hciAyMDI2
LCBhdCA0OjI34oCvUE0sIEF0aGlyYSBSYWplZXYNCj4gPiA+IDxhdHJhamVldkBsaW51eC5pYm0u
Y29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gQ3VycmVudGx5IGluICJwZXJmIGFsbCBQTVUgdGVz
dCIsIGZvciAicGVyZiBzdGF0IC1lIDxldmVudD4NCj4gPiA+IHRydWUiLA0KPiA+ID4gYmVsb3cg
Y2hlY2tzIGFyZSBkb25lOg0KPiA+ID4gLSBpZiByZXR1cm4gY29kZSBpcyB6ZXJvLCBsb29rIGZv
ciAibm90IHN1cHBvcnRlZCIgdG8gZGVjaWRlIHBhc3MNCj4gPiA+IMKgc2NlbmFyaW8NCj4gPiA+
IC0gY2hlY2sgZm9yICJub3Qgc3VwcG9ydGVkIiB0byBpZ25vcmUgdGhlIGV2ZW50DQo+ID4gPiAt
IGxvb2tzIGZvciAiTm8gcGVybWlzc2lvbiB0byBlbmFibGUiIHRvIHNraXAgdGhlIGV2ZW50Lg0K
PiA+ID4gLSBJZiBvdXRwdXQgaGFzICJCYWQgZXZlbnQgbmFtZSIsIGZhaWwgdGhlIHRlc3QuDQo+
ID4gPiAtIFVzZSAiQWNjZXNzIHRvIHBlcmZvcm1hbmNlIG1vbml0b3JpbmcgYW5kIG9ic2VydmFi
aWxpdHkNCj4gPiA+IG9wZXJhdGlvbnMgaXMNCj4gPiA+IMKgbGltaXRlZC4iIHRvIGlnbm9yZSBm
YWlsIGR1ZSB0byBhY2Nlc3MgbGltaXRhdGlvbnMNCj4gPiA+IA0KPiA+ID4gSWYgd2UgZmFpbGVk
IHRvIHNlZSBldmVudCBhbmQgaXQgaXMgc3VwcG9ydGVkLCByZXRyaWVzIHdpdGgNCj4gPiA+IGxv
bmdlcg0KPiA+ID4gd29ya2xvYWQgInBlcmYgYmVuY2ggaW50ZXJuYWxzIHN5bnRoZXNpemUiLg0K
PiA+ID4gLSBIZXJlIGlmIG91dHB1dCBoYXMgPGV2ZW50PiwgdGhlIHRlc3QgaXMgYSBwYXNzLg0K
PiA+ID4gDQo+ID4gPiBTbmlwcGV0IG9mIGNvZGUgY2hlY2s6DQo+ID4gPiDCoGBgYA0KPiA+ID4g
wqBvdXRwdXQ9JChwZXJmIHN0YXQgLWUgIiRwIiBwZXJmIGJlbmNoIGludGVybmFscyBzeW50aGVz
aXplIDI+JjEpDQo+ID4gPiDCoGlmIGVjaG8gIiRvdXRwdXQiIHwgZ3JlcCAtcSAiJHAiDQo+ID4g
PiDCoGBgYA0KPiA+ID4gLSBpZiBvdXRwdXQgZG9lc24ndCBoYXZlIGV2ZW50IHByaW50ZWQgaW4g
bG9ncywgY29uc2lkZXJzIGl0DQo+ID4gPiBmYWlsLg0KPiA+ID4gDQo+ID4gPiBCdXQgdGhpcyBy
ZXN1bHRzIGluIGZhbHNlIHBhc3MgZm9yIGV2ZW50cyBpbiBzb21lIGNhc2VzLg0KPiA+ID4gRXhh
bXBsZSwgaWYgcGVyZiBzdGF0IGZhaWxzIGFzIGJlbG93Og0KPiA+ID4gDQo+ID4gPiAjIC4vcGVy
ZiBzdGF0IC1lIHBtdS9ldmVudC/CoCB0cnVlDQo+ID4gPiBldmVudCBzeW50YXggZXJyb3I6ICdw
bXUvZXZlbnQvJw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
XF9fXyBCYWQgZXZlbnQgb3IgUE1VDQo+ID4gPiANCj4gPiA+IFVuYWJsZSB0byBmaW5kIFBNVSBv
ciBldmVudCBvbiBhIFBNVSBvZiAncG11Jw0KPiA+ID4gUnVuICdwZXJmIGxpc3QnIGZvciBhIGxp
c3Qgb2YgdmFsaWQgZXZlbnRzDQo+ID4gPiANCj4gPiA+IMKgVXNhZ2U6IHBlcmYgc3RhdCBbPG9w
dGlvbnM+XSBbPGNvbW1hbmQ+XQ0KPiA+ID4gDQo+ID4gPiDCoMKgIC1lLCAtLWV2ZW50IDxldmVu
dD7CoMKgIGV2ZW50IHNlbGVjdG9yLiB1c2UgJ3BlcmYgbGlzdCcgdG8gbGlzdA0KPiA+ID4gYXZh
aWxhYmxlIGV2ZW50cw0KPiA+ID4gIyBlY2hvICQ/DQo+ID4gPiAxMjkNCj4gPiA+IA0KPiA+ID4g
U2luY2UgdGhpcyBoYXMgbm9uLXplcm8gcmV0dXJuIGNvZGUgYW5kIGRvZXNuJ3QgaGF2ZSB0aGUN
Cj4gPiA+IGZhaWwgc3RyaW5ncyBiZWluZyBjaGVja2VkIGluIHRoZSB0ZXN0LCBpdCB3aWxsIGVu
dGVyIGNoZWNrIHVzaW5nDQo+ID4gPiBsb25nZXIgd29ya2xvYWQuIGFuZCBzaW5jZSB0aGUgb3V0
cHV0IGZhaWwgbG9nIGhhcyBldmVudCwgaXQNCj4gPiA+IGRlY2xhcmVzIHRlc3QgYXMgInN1cHBv
cnRlZCIuDQo+ID4gPiANCj4gPiA+IFNpbmNlIGFsbCB0aGUgZmFpbCBzdHJpbmdzIGNhbid0IGJl
IGFkZGVkIGluIHRoZSBjaGVjaywgdXBkYXRlDQo+ID4gPiB0aGUgdGVzdGNhc2UgdG8gY2hlY2sg
cmV0dXJuIGNvZGUgYmVmb3JlIHByb2NlZWRpbmcgdG8gbG9uZ2VyDQo+ID4gPiB3b3JrbG9hZCBy
dW4uDQo+ID4gPiANCj4gPiA+IEFub3RoZXIgbWlzc2luZyBzY2VuYXJpbyBpcyB3aGVuIHN5c3Rl
bSB3aWRlIG1vbml0b3JpbmcgaXMNCj4gPiA+IHN1cHBvcnRlZA0KPiA+ID4gZXhhbXBsZToNCj4g
PiA+ICMgLi9wZXJmIHN0YXQgLWUgcG11L2V2ZW50LyB0cnVlDQo+ID4gPiBFcnJvcjoNCj4gPiA+
IE5vIHN1cHBvcnRlZCBldmVudHMgZm91bmQuDQo+ID4gPiDCoFVuc3VwcG9ydGVkIGV2ZW50IChw
bXUvZXZlbnQvSCkgaW4gcGVyLXRocmVhZCBtb2RlLCBlbmFibGUNCj4gPiA+IHN5c3RlbSB3aWRl
IHdpdGggJy1hJy4NCj4gPiA+IA0KPiA+ID4gVXBkYXRlIHRlc3RjYXNlIHRvIGNoZWNrIHdpdGgg
InBlcmYgc3RhdCAtYSAtZSAkcCIgYXMgd2VsbA0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBBdGhpcmEgUmFqZWV2IDxhdHJhamVldkBsaW51eC5pYm0uY29tPg0KPiA+ID4gLS0tDQo+ID4g
DQo+ID4gVGVzdGVkIHRoaXMgcGF0Y2guDQo+ID4gDQo+ID4gDQo+ID4gV2l0aCB0aGlzIHBhdGNo
Og0KPiA+IA0KPiA+IFRlc3RpbmcgaHZfMjR4Ny9DUE1fQURKVU5DVF9JTlNULyAtLSBwZXJmIHN0
YXQgZmFpbGVkIHdpdGggbm9uLXplcm8NCj4gPiByZXR1cm4gY29kZQ0KPiA+IFRlc3RpbmcgaHZf
MjR4Ny9DUE1fQURKVU5DVF9QQ1lDLyAtLSBwZXJmIHN0YXQgZmFpbGVkIHdpdGggbm9uLXplcm8N
Cj4gPiByZXR1cm4gY29kZQ0KPiA+IA0KPiA+IA0KPiA+IA0KPiA+IFRlc3RlZC1ieTogVmVua2F0
IFJhbyBCYWdhbGtvdGUgPHZlbmthdDg4QGxpbnV4LmlibS5jb20+DQo+IA0KPiBUZXN0aW5nIG9u
IGFuIEludGVsIEFsZGVybGFrZSB0aGUgdGVzdCBpcyBub3cgZmFpbGluZzoNCj4gYGBgDQo+IC4u
Lg0KPiBUZXN0aW5nIG9mZmNvcmVfcmVxdWVzdHNfb3V0c3RhbmRpbmcubDNfbWlzc19kZW1hbmRf
ZGF0YV9yZCAtLQ0KPiBzdXBwb3J0ZWQNCj4gVGVzdGluZyBvY3IuZnVsbF9zdHJlYW1pbmdfd3Iu
YW55X3Jlc3BvbnNlIC0tIHBlcmYgc3RhdCBmYWlsZWQgd2l0aA0KPiBub24temVybyByZXR1cm4g
Y29kZQ0KPiBUZXN0aW5nIG9jci5wYXJ0aWFsX3N0cmVhbWluZ193ci5hbnlfcmVzcG9uc2UgLS0g
cGVyZiBzdGF0IGZhaWxlZA0KPiB3aXRoDQo+IG5vbi16ZXJvIHJldHVybiBjb2RlDQo+IFRlc3Rp
bmcgb2NyLnN0cmVhbWluZ193ci5hbnlfcmVzcG9uc2UgLS0gc3VwcG9ydGVkDQo+IC4uLg0KPiBg
YGANCj4gDQo+IFJ1bm5pbmcgYHBlcmYgc3RhdGAgbWFudWFsbHkgcmV2ZWFscyBhbiBpc3N1ZSB3
aXRoIHRoZSBldmVudDoNCj4gYGBgDQo+ICQgc3VkbyBwZXJmIHN0YXQgLXZ2IC1lIG9jci5mdWxs
X3N0cmVhbWluZ193ci5hbnlfcmVzcG9uc2UgLWEgc2xlZXANCj4gMQ0KPiBVc2luZyBDUFVJRCBH
ZW51aW5lSW50ZWwtNi1CNy0xDQo+IEF0dGVtcHQgdG8gYWRkOiBjcHVfYXRvbS9vY3IuZnVsbF9z
dHJlYW1pbmdfd3IuYW55X3Jlc3BvbnNlLw0KPiAuLmFmdGVyIHJlc29sdmluZyBldmVudDoNCj4g
Y3B1X2F0b20vZXZlbnQ9MHhiNyxwZXJpb2Q9MHgxODZhMyx1bWFzaz0weDEsb2ZmY29yZV9yc3A9
MHg4MDAwMDAwMTAwDQo+IDAwLw0KPiBvY3IuZnVsbF9zdHJlYW1pbmdfd3IuYW55X3Jlc3BvbnNl
IC0+DQo+IGNwdV9hdG9tL29jci5mdWxsX3N0cmVhbWluZ193ci5hbnlfcmVzcG9uc2UvDQo+IENv
bnRyb2wgZGVzY3JpcHRvciBpcyBub3QgaW5pdGlhbGl6ZWQNCj4gLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IHBlcmZfZXZlbnRf
YXR0cjoNCj4gwqB0eXBlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgMTAgKGNwdV9hdG9tKQ0KPiDCoHNpemXCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxNDQNCj4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IHBlcmZf
ZXZlbnRfYXR0cjoNCj4gwqB0eXBlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMCAoUEVSRl9UWVBFX0hBUkRXQVJFKQ0KPiDCoGNvbmZpZ8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhhMDAw
MDAwMDANCj4gKGNwdV9hdG9tL1BFUkZfQ09VTlRfSFdfQ1BVX0NZQ0xFUy8pDQo+IMKgZGlzYWJs
ZWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMQ0KPiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gc3lzX3BlcmZfZXZlbnRfb3BlbjogcGlkIDDCoCBjcHUgLTHCoCBncm91cF9mZCAtMcKg
IGZsYWdzIDB4OCA9IDMNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IHBlcmZfZXZlbnRfYXR0cjoNCj4gwqB0eXBlwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMCAoUEVS
Rl9UWVBFX0hBUkRXQVJFKQ0KPiDCoGNvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHg0MDAwMDAwMDANCj4gKGNwdV9jb3JlL1BFUkZfQ09V
TlRfSFdfQ1BVX0NZQ0xFUy8pDQo+IMKgZGlzYWJsZWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMQ0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gc3lzX3BlcmZfZXZlbnRfb3Blbjog
cGlkIDDCoCBjcHUgLTHCoCBncm91cF9mZCAtMcKgIGZsYWdzIDB4OCA9IDMNCj4gwqBjb25maWfC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MWI3
DQo+IChvY3IuZGVtYW5kX2RhdGFfcmQubDNfaGl0LnNub29wX2hpdF9ub19md2QpDQo+IMKgc2Ft
cGxlX3R5cGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSURFTlRJ
RklFUg0KPiDCoHJlYWRfZm9ybWF0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgDQo+IFRPVEFMX1RJTUVfRU5BQkxFRHxUT1RBTF9USU1FX1JVTk5JTkcNCj4gwqBkaXNh
YmxlZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxDQo+
IMKgaW5oZXJpdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDENCj4gwqB7IGJwX2FkZHIsIGNvbmZpZzEgfcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAw
eDgwMDAwMDAxMDAwMA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gc3lzX3BlcmZfZXZlbnRfb3BlbjogcGlkIC0xwqAgY3B1
IDE2wqAgZ3JvdXBfZmQgLTHCoCBmbGFncyAweDgNCj4gc3lzX3BlcmZfZXZlbnRfb3BlbiBmYWls
ZWQsIGVycm9yIC0yMg0KPiBzd2l0Y2hpbmcgb2ZmIGRlZmVycmVkIGNhbGxjaGFpbiBzdXBwb3J0
DQo+IFdhcm5pbmc6DQo+IG9jci5mdWxsX3N0cmVhbWluZ193ci5hbnlfcmVzcG9uc2UgZXZlbnQg
aXMgbm90IHN1cHBvcnRlZCBieSB0aGUNCj4ga2VybmVsLg0KPiBUaGUgc3lzX3BlcmZfZXZlbnRf
b3BlbigpIHN5c2NhbGwgZmFpbGVkIGZvciBldmVudA0KPiAob2NyLmZ1bGxfc3RyZWFtaW5nX3dy
LmFueV9yZXNwb25zZSk6IEludmFsaWQgYXJndW1lbnQNCj4gImRtZXNnIHwgZ3JlcCAtaSBwZXJm
IiBtYXkgcHJvdmlkZSBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiANCj4gRXJyb3I6DQo+IE5v
IHN1cHBvcnRlZCBldmVudHMgZm91bmQuDQo+IFRoZSBzeXNfcGVyZl9ldmVudF9vcGVuKCkgc3lz
Y2FsbCBmYWlsZWQgZm9yIGV2ZW50DQo+IChvY3IuZnVsbF9zdHJlYW1pbmdfd3IuYW55X3Jlc3Bv
bnNlKTogSW52YWxpZCBhcmd1bWVudA0KPiAiZG1lc2cgfCBncmVwIC1pIHBlcmYiIG1heSBwcm92
aWRlIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+IGBgYA0KPiANCj4gVGhpcyBsb29rcyBsaWtl
IGEgbGF0ZW50IEludGVsIGNwdV9hdG9tIFBNVSBidWcuIFRob21hcywgd2R5dD8NCg0KK0RhcGVu
ZywgWmlkZSwgQW5kaQ0KDQpUaGFua3MsDQpUb20NCg0KPiANCj4gVGhhbmtzLA0KPiBJYW4NCj4g
DQo+ID4gUmVnYXJkcywNCj4gPiBWZW5rYXQuDQo+ID4gDQo+ID4gDQo+ID4gDQo+ID4gPiB0b29s
cy9wZXJmL3Rlc3RzL3NoZWxsL3N0YXRfYWxsX3BtdS5zaCB8IDIwICsrKysrKysrKysrKysrKysr
KysrDQo+ID4gPiAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+ID4g
PiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9zdGF0X2FsbF9wbXUuc2gNCj4g
PiA+IGIvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9zdGF0X2FsbF9wbXUuc2gNCj4gPiA+IGluZGV4
IDljNDY2YzBlZmE4NS4uNmM0ZDU5Y2JmYTVmIDEwMDc1NQ0KPiA+ID4gLS0tIGEvdG9vbHMvcGVy
Zi90ZXN0cy9zaGVsbC9zdGF0X2FsbF9wbXUuc2gNCj4gPiA+ICsrKyBiL3Rvb2xzL3BlcmYvdGVz
dHMvc2hlbGwvc3RhdF9hbGxfcG11LnNoDQo+ID4gPiBAQCAtNTMsNiArNTMsMjYgQEAgZG8NCj4g
PiA+IMKgwqDCoCBjb250aW51ZQ0KPiA+ID4gwqAgZmkNCj4gPiA+IA0KPiA+ID4gK8KgICMgY2hl
Y2sgd2l0aCBzeXN0ZW0gd2lkZSBpZiBpdCBpcyBzdXBwb3J0ZWQuDQo+ID4gPiArwqAgb3V0cHV0
PSQocGVyZiBzdGF0IC1hIC1lICIkcCIgdHJ1ZSAyPiYxKQ0KPiA+ID4gK8KgIHN0YXRfcmVzdWx0
PSQ/DQo+ID4gPiArwqAgaWYgZWNobyAiJG91dHB1dCIgfCBncmVwIC1xICJub3Qgc3VwcG9ydGVk
Ig0KPiA+ID4gK8KgIHRoZW4NCj4gPiA+ICvCoMKgwqAgIyBFdmVudCBub3Qgc3VwcG9ydGVkLCBz
byBpZ25vcmUuDQo+ID4gPiArwqDCoMKgIGVjaG8gIm5vdCBzdXBwb3J0ZWQiDQo+ID4gPiArwqDC
oMKgIGNvbnRpbnVlDQo+ID4gPiArwqAgZmkNCj4gPiA+ICsNCj4gPiA+ICvCoCAjIGNoZWNrZWQg
dGhyb3VnaCBwb3NzaWJsZSBhY2Nlc3MgbGltaXRhdGlvbnMgYW5kIHBlcm1pc3Npb25zLg0KPiA+
ID4gK8KgICMgQXQgdGhpcyBzdGVwLCBub24temVybyByZXR1cm4gY29kZSBmcm9tICJwZXJmIHN0
YXQiIG5lZWRzIHRvDQo+ID4gPiArwqAgIyByZXBvcnRlZCBhcyBmYWlsIGZvciB0aGUgdXNlciB0
byBpbnZlc3RpZ2F0ZQ0KPiA+ID4gK8KgIGlmIFsgJHN0YXRfcmVzdWx0IC1uZSAwIF0NCj4gPiA+
ICvCoCB0aGVuDQo+ID4gPiArwqDCoMKgIGVjaG8gInBlcmYgc3RhdCBmYWlsZWQgd2l0aCBub24t
emVybyByZXR1cm4gY29kZSINCj4gPiA+ICvCoMKgwqAgZXJyPTENCj4gPiA+ICvCoMKgwqAgY29u
dGludWUNCj4gPiA+ICvCoCBmaQ0KPiA+ID4gKw0KPiA+ID4gwqAgIyBXZSBmYWlsZWQgdG8gc2Vl
IHRoZSBldmVudCBhbmQgaXQgaXMgc3VwcG9ydGVkLiBQb3NzaWJseSB0aGUNCj4gPiA+IHdvcmts
b2FkIHdhcw0KPiA+ID4gwqAgIyB0b28gc21hbGwgc28gcmV0cnkgd2l0aCBzb21ldGhpbmcgbG9u
Z2VyLg0KPiA+ID4gwqAgb3V0cHV0PSQocGVyZiBzdGF0IC1lICIkcCIgcGVyZiBiZW5jaCBpbnRl
cm5hbHMgc3ludGhlc2l6ZQ0KPiA+ID4gMj4mMSkNCj4gPiA+IC0tDQo+ID4gPiAyLjQ3LjMNCj4g
PiA+IA0KPiA+IA0KDQo=

