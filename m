Return-Path: <linuxppc-dev+bounces-19412-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970FDFB5160
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 20:20:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqLKv1mbnz2ySS;
	Tue, 07 Apr 2026 06:20:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775506819;
	cv=fail; b=funDYcAwHX4zPnftOavPQOmIdvc/C4nOaiXfr3z2sg0fdqyJHv9a2p7um5rFb9Nl2fKSwR/UQ33SjyzZ8tsBF2s3ErDkwr0tqUc1ONUVa2SkJc5alldvpJocXHOq3SILdFW7OAU+K40t9mY5XJh9wfvHsqV9ARlixFfFMwfoCbLMl3HtjLFPNI5RXDfBrXqTOere+BXNzT6yG/vEspS0hsEvRMdrMcAUsav9rS6srSlVYHU7xItffw/ESeYijcRet4EM9peBYPBYRWagMdEwC3yTaRhzzx68/UHF0OqjNqKIGaylmbDbTGq5S6mamjycAKf4dUQDQKbOVCtxG9DpUw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775506819; c=relaxed/relaxed;
	bh=e25O4RYSK+WOHOn4Z0QUh6mTjmiiy5rx3TbgQeYDekI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cB/q2FkcmoQvXzIZTmL5DMj/RvylpVKgNrt8DVyC6Y48H6tLCHUaJgNpRQLon2J+cj4AhNm1AypimrlPdXbI0a5hcLOI04PfgievlasyivwPzuJWweyxR9Ts95L/8KjzitH7w2O5R8m2+qaWiWTcgyqCzvJDQW0c6nrNVvl40XdCEeLAXdNksDVcz7P9/q93X5jn4k1noBmfacAF8C3gF+Pwkf8PjIQyf7AimE5JVUnstISKhUNlvK0u2YSU/McFk86UAOjljH8p8cAIZYogsrhsEMgFn9EuZtVLpMOX4UGb5Rd8GLY4RPkQUXIcEjuCYNeHAmcI7xzXYRbHDBUOTA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gfDXQCmf; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gfDXQCmf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqLKr2JXPz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 06:20:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775506816; x=1807042816;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DaBKoX0A6ChXWngUKZAMTjagLvI9ygGsOEgQLt85QeQ=;
  b=gfDXQCmfxvZax2yH4t8Ubsbv0Ed3nWqVL37rMqkAKh8G370o+erlzgx0
   FNZm/EBIvru7GHZ5o8Z1l8NwD8KSUK9bO3vlTpb0Ait0Ps18W/NofALJG
   CNDrYi6TCi7MD+I2RqLRSUzq/l/A+3UEVbJF8GmD/kTnaJ1nYRx9Vo/JR
   akFFLf+ZjUz80xIpKuc+jmbN3r1w+ByPM+3aPZzrPkIK6o2ozzhC9cIso
   wiAdwpa4R1KkwNySLXM5v7Is1r4gu3qMgmbZcVlauj9rfEMiVyfLoLfxN
   roq3unN+zW29ZFSBO5/zaO9e7Mfk3RbhW5h4QvH/xaG4HaqPDo6JZdBL+
   Q==;
X-CSE-ConnectionGUID: 7yofA63nS3u9oxVa94KHgQ==
X-CSE-MsgGUID: TWLW0Fx6RPWsqcDaCN3UEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="64008531"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="64008531"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 13:20:09 -0700
X-CSE-ConnectionGUID: gttl/qqATXOCEWHcc0nbbw==
X-CSE-MsgGUID: q7xHUgWITNecNuDAC7WBeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="251095280"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 13:20:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 13:20:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 6 Apr 2026 13:20:08 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 13:20:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHz26GyoR2bXpm5YlrgDbCS2McDm/JArzwgG7u1EM/zVdHtrabaYss6qtwXAExDi26Utu9PeNWm7Yqf/RElQUV3IeeoVh7YJgYTlZIaE43nd1RwO0/FtvbW807/9As8KEAFJe1In4tmxnGBVFO7d7wlUtaPMHMfSnd7/c+FGyrcTlxrOKvuoh+zJCXuxIyLInROI8GlU6iyVKt0XBJ3CphjKXpcCTZeo+U1mB4Voku+Hdc6cktlfZYXHnBVB1ordp6TV2AtAKjmqlePJvQgTTmnXX53+2ziuSBUZTroSvomF8Mz9AgpnXSNqmOEsRzAq1ivvZhfWL3w5a9e7rk8tFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e25O4RYSK+WOHOn4Z0QUh6mTjmiiy5rx3TbgQeYDekI=;
 b=OzrWZmkV7njePuVLHbLsGUoz3Ipr7uR7IfzX5/FvZ0QTPrBAYvPOhhTgUFr3i+8nfSo2IoDK8My/2iCFDKJowV2NBGY4i30Ub6YFOhNjY5S9IyaLcceTWg+ijyXsdgTIcx1rjJQqqPa2m//5wXFXevheGv0C83Xgg8m7ryf4lVh3MYycQWYJ7Oxgh7lYB24k7PEGINMBHn2jn4QkvbtxzlPjcIF++Wo9HxIpOvKd0VhImmLUVucnYqCf0rIq6/NIz7FujaFfakNcV+WN7P4wRw9ms75PDAc1w7qWtS48H3Nnes7zh9fjG1WzdGQQkQmartGnKtfOIPzG7gXwc3xEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by PH0PR11MB4936.namprd11.prod.outlook.com (2603:10b6:510:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 20:20:04 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 20:20:04 +0000
Date: Mon, 6 Apr 2026 13:19:58 -0700
From: Peter Fang <peter.fang@intel.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
CC: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Sean
 Christopherson" <seanjc@google.com>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
	<kvm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, KarimAllah Ahmed <karahmed@amazon.de>,
	"Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Subject: Re: [PATCH] KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
Message-ID: <adQVblwkGi1oDYya@pedri>
References: <20260325092001.613025-1-peter.fang@intel.com>
 <acsvbxIdtlQzUw4q@google.com>
 <7bqnm5he.ritesh.list@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7bqnm5he.ritesh.list@gmail.com>
X-ClientProxiedBy: BY5PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::25) To SJ0PR11MB5645.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|PH0PR11MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ad211b-54ce-4269-c320-08de9419e1fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: t6B+AY61KVn8pavlZmeaNNjuIVCR0THR+qFFfrTKUtlmiZ2YxRYSPf+Gfk4qA6uNMxfdg4vk1+ZJ6j+A8Avoz3U/6z42TzrqKwuprM6Omj3rqtCwdKiUIktATrOexpDmBGHQg8BG993zJOr269CBtfaifZU8CoOjzNLtr9xuxNDqLZGI4lRplw3PA8BvChKhMly4bn9DiOtTJHsIRVJV/dGKoq3FWHhleyzC7tPLYcfUKYT4pnM+EHus5RhyC9+tkoVe6mJxOD5N+aazpMiEZcUlCfBdZnBfqdQ+tSQ+0+xHGl3roqE+KbjBP/Gkj/K+70Z2TxtXap0j6oPZJwSEaCIF97isjt+wsSNczyUkdgJc0LH3q54SACBLWjBiB1fRFJSQRua4zSDUlO4BWkRJpB9f/mDYzCFfwN4X3oJ3CQQG0wj6avx+FCGzLM7iKNSFVmZ3vlx3DIph8Wg8HCRg4GtFccqZJ18VjC+PW6W3SeEbItGO8JU1XSaH58VFaBoDQI601Y2KvHxNJsSMtHMRDUg0ce6hoTkJQTvvwrQ6U0RKrQhQNZ7YTO4+WMBmMNO0lpzKzIbWiFVxujn9w+lgglUGeETVjil1CrvNMb5FceSt48f6P89HBUnxWeNqsoSVfgBNEDv+snUhw2LCRM9mQnrxs7qw8+4Gw1MAC/wpIa8HkFhQpQMpAjacd+Tg3kvB8nyPXC6egh1Ogv5uJ7+1pRRrVpn81kBxaZM6+w8KxsY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R2HjANjlPpfBDaZvlJxaStMcRHYBJgRgSKiIOOtsdiLQZdBUmoqNPJbWQzOf?=
 =?us-ascii?Q?BtjkIE8yB7fNeyZJ3v2UoohfaE55auh9FbnQV1aPhc/6xEfaRmxrbU/uljMC?=
 =?us-ascii?Q?qXIGPjh7qgImHqG8RFFGnTzXFDcOHznU+u29x7uET+PTh8KGT/lnlHVnuRNB?=
 =?us-ascii?Q?tPlGAwURbdLRCki43qzbEh3X2UXHVmcRbEOVXNhWC3QSxfnrmo9SkDhWfxjH?=
 =?us-ascii?Q?yP3bRuBigCY8rT9Vavxbg3K+ylgj+kInktSlMZ96U3O3O75baV7l7s6NB5Ns?=
 =?us-ascii?Q?V8/S8+iAy1cvtkoNxb7pVzC41LgV0fZb2QN9R6cGoit3Z2kTI4DqZrxtPuYh?=
 =?us-ascii?Q?eUq+aGaLQRMIZyLdNmPMopLpHOvGRB2R68jUUrn/S9dNCzZHj1rMck2X2sxj?=
 =?us-ascii?Q?4tEUIiSMqGbsxmE+h/evvWHYCbvctbL7yc7HZNz/ZTkDVGnTRJXGFFzAPZxf?=
 =?us-ascii?Q?W842A1dY5+WVyam46UKnObtOWztdFDDi9SfUO9QZjeYbzOqebXxuOSILLaHj?=
 =?us-ascii?Q?6yhQXbE9rgi14UBP13tBDHcRjfSwFasCfp5f0XKGvzss+Px3KIH5A5kL8N79?=
 =?us-ascii?Q?7nu4MIPokNCItIypC7GkiLQVPJkBXKN2Wp8TCtMbqh+wAPVSRJdjFwfA8R26?=
 =?us-ascii?Q?g4n6U135mdIgz3FIEbq5BoHXeT4y79IW0JXHDcSjurMlaJahbZBc9T+FIKZk?=
 =?us-ascii?Q?jFLV3Qrt7l7o0FHTcbwgUfEaIhww3xvP5d4z2GKIyPNHnVHPx/FpAhWwODkg?=
 =?us-ascii?Q?2JAkwr/l/K4ZRwgbBQRQmuH+Fj1PReDX7rkhHn/i4v+ar5ghxVHopNhLHyDm?=
 =?us-ascii?Q?Tg0H4mcQMe37z4apl9y/w6tvbW5vKHKu1rsujxw4wWj0d4R2nNSZhnZT67FX?=
 =?us-ascii?Q?BhV51INmeOLdJytuZC3j9vlJ1OEfJldBMfe4Ldw/dfrjpQqlPfrNBBBOoczj?=
 =?us-ascii?Q?ClVs+wuvSqtg9v64UR0Cvapaq7moASwBRYa+ArZVt8niPMOSQZXXx/yfUbKR?=
 =?us-ascii?Q?kxAT/N1Sb7ESeVBoxltgHso81172Vm5qJQlFmMdqEB3rVmQ9KgTgs+PSYMur?=
 =?us-ascii?Q?kJ2HwDY2+GC53j9TZiUFk1P8v786ECjs6fGoiElkvAeBGBA7//alrPaQGAmF?=
 =?us-ascii?Q?mxnbRn4b3AtvVXuRWvFOt1ZqnMScDOuJ9xPPxQaoSueaFIU14Sv7mQuskmJu?=
 =?us-ascii?Q?TijVT//vCKAK2v6l7J/WKnDTvhDLl71YtQ/eDE/IqJ5vNvCCQVe3m4yX7LSm?=
 =?us-ascii?Q?KbbI44BWLVZog0aT1VwST8Qtb6IJ/eL5kDFyZO+Xfd2rpN/fach2x6MUQHfi?=
 =?us-ascii?Q?HK2DXk77NOtj7blwnPWqTN0A0a16Yw60a/YA3D+o2gGk1ZI7YptPWju5uqjy?=
 =?us-ascii?Q?57dRdYKmiL+V0LPZtkL6yOwpICjsAXk27K7BKKnq5rk+g8T/TdvRi3L+/9EC?=
 =?us-ascii?Q?IVhADK83dgDFHWM8pehd+lXmFvDVDZAMveb19ZTmoOyaGW8P6GbE/42/wMeb?=
 =?us-ascii?Q?d4Ppovnl+8R6vOvagChKdizwrODs2bmTAeqSo71wKMAjIFpqpYelg7JLJ6a/?=
 =?us-ascii?Q?uEen+ZwHX9pGMOS4CISBiQUSJYn68HVdxcOTvUfB2RCzRFHC8N/afhXhP0VP?=
 =?us-ascii?Q?UO2OjxV2UeQVSOc0aD3g9GggxW6GjRm0FVnZnTqOztcvuPHOF0+W3ehaPI44?=
 =?us-ascii?Q?j45adKTir4ZWSw5hypBBtDON2whMzjIgxBVdVmIfGwtoprWBJ/IZNlvQEevg?=
 =?us-ascii?Q?R5RazO3H7Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: uEdYh+JJQhMTUc4gTNMim5vf/PsqtAnGGJRAS067vaidcrvhQtRGXD4YE9MhC1Z9wv4b5WdagM69vHd/c5isQ2t6pO5IOxdWruMuAOPYYaXD82wv9LOdqDKhDbEpYoeiKpRIzTeR/UO109skARgemI0bSVK0hm9w03hPmpnKglisVRyVpRosLREPthEqKDXssXhQEeG9rWAU3g3no0rVdtYTIbx+f4Q498l7ofQFZmpKC4c/gp+9KdknkO5Cc3YF6WP/Tq8D6D+2kPbPNRWc6TYEWUhDddrkP5xSh9b7AhW9bWaxsKvDMVsRpgeXZNm6gZKEuUnRUe9oSzs2sVPBiw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ad211b-54ce-4269-c320-08de9419e1fd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 20:20:03.5330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzIs7NExgu0jKujnMPmoRq/I6CRJGv2lhFR0+Qib+nzK/2AdK5D1iRnvwfDvShYdTsMyZWLZGblyP2P2Q8nA6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4936
X-OriginatorOrg: intel.com

On Sat, Apr 04, 2026 at 03:07:01PM +0530, Ritesh Harjani wrote:
> Yosry Ahmed <yosry@kernel.org> writes:
> 
> > On Wed, Mar 25, 2026 at 02:15:11AM -0700, Peter Fang wrote:
> >> kvm_vcpu_map() and kvm_vcpu_map_readonly() should take a gfn instead of
> >> a gpa. This appears to be a result of the original kvm_vcpu_map() being
> >> declared with the wrong function prototype in kvm_host.h, even though
> >> it was correct in the actual implementation in kvm_main.c.
> >> 
> >> No actual harm has been done yet as all of the call sites are correctly
> >> passing in a gfn. Plus, both gfn_t and gpa_t are typedef'd to u64 so
> >> this change shouldn't have any functional impact.
> >> 
> >> Compile-tested on x86 and ppc, which are the current users of these
> >> interfaces.
> 
> Mostly a mechanical change. I had looked at ppc call site and looks ok
> to me.

Thanks for reviewing the ppc part! v2 with the suggested changes will be
posted soon.

> 
> >> 
> >> Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
> >> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> >> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> >> Signed-off-by: Peter Fang <peter.fang@intel.com>
> >
> > Most callers are converting a GPA to a GFN, I wonder if we should make
> > the function take in a GPA instead? But then we'll need to the GPA not
> > being aligned to a page boundary (either do gpa_to_gfn() in
> > __kvm_vcpu_map() or fail if it's not aligned).
> >
> > Not sure if that's a net improvement, mostly thinking out loud here.
> 
> The suggestion from Yosry and Sean sounds good too. Instead of every
> caller of kvm_vcpu_map() doing gpa_to_gfn(), we may as well make
> kvm_vcpu_map() accept gpa_t instead and do the gpa_to_gfn() inside
> kvm_vcpu_map() in the call to __kvm_vcpu_map(vcpu, gpa_to_gfn(gpa),...),
> or within __kvm_vcpu_map() which is fine too, however, the former is a
> better approach, IMO.
> 
> -ritesh

