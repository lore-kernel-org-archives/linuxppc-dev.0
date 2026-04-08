Return-Path: <linuxppc-dev+bounces-19452-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD30AEDB7D0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 00:12:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr3Rj2YhCz2yfS;
	Wed, 08 Apr 2026 10:12:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775607169;
	cv=fail; b=FOeLgWeVQ5SHbQEOam7IF94gxIufhcnoyivg20x5WwwE0KV959oBAOpdWbiRb31GvLojFVFGsD8Cml8ehng40AVZla25MvHjp406gPIiyrPkCP6HiRBIwqCGPIbFRlpYturI+MhBPwI0+wPWHIf6xOiOYgWGhneoou4Sehq2PKRAZRn2RfEDy4Xkh4KVzRlemtoWg90JPNF2U9CP69ESAunmT3TuPaoU9dSj4eQ6Gz/cY5Vt3Ch503oqJb2dVE2op1kKAjkDtQJia/N2/PBOlABFd9X1zvEZHoEr3aLVbh7JIrZTxqR+31uiUm7YPmDIH6L5nFvM6088LFgUYW0RyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775607169; c=relaxed/relaxed;
	bh=HmpcEhJRXNLSrVvtO+q3NPl8oAVZNB7FR37VZ5VJvZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l4c4+wGHyWILbo/vcjHXTt1BtwVg6KyM9cPjl7vFjeDqvkwlgciX2T8gZ2bhXAmH8IqKH7RNeLmYHLuB/1mvYVAGmtwgJ7Q5yVFJeriyZvWJV7QANaKP1ofR1B++hdT3GsiP2Y2BFNTMc3GlxtnXQCZLVH2FlWyTpWmk51w/ezLSFWO75/gvAS6xmo0ZEm8M8puDAVcm6H1cLHRUEQu8Bg+2Qje4ZaS9iP4vlqvI1AUXMeDMfMIjHyoXE7RSNBi0rphz+P/FL66O7I+1ykTHCdf/PUgSActNG97aekHHa0i4IBvc2uNsnXzz7wEt1ez/2qlGIuCAqI929OudiGgoGg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rbkp2eFg; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rbkp2eFg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr3Rd6VvRz2yZN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 10:12:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775607166; x=1807143166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fQgHdJOoZw9n3OlrcPN4pbtlirqw3b4Uh0gyZsPLnZg=;
  b=Rbkp2eFgI3XozrBfxgU/jMJxYCDOdUetgSX0i2FH7iPFMJ86IZld4lZG
   9us1RvSOLDK06PXK8RI6JQgcOg/i/joDdZl614qQc5LiaRIoWOdfzhlr5
   fhDwcMj5fIhGY6nOHT2mctYY6VDNij59VZ7W3cT6urDV/V+Nm9bW6Nflp
   PCVvMMWedBiiZmjHleJesB8aYOUr0Aw1/fU8fUBMMtAShgYvl4SKjQZsd
   zQ4ZIS/TQfxgyD97q7HYiSRmp/7HqLUkNjMbTaAs9E9Pj+8siiOth4+eC
   EKp7kXFpZSBGWGOtUl/jAh2MdwvR4bciYOUAWrDkHM8/6kikasKPvFUzk
   Q==;
X-CSE-ConnectionGUID: oVekhHpbSPa5rqHMGFElPw==
X-CSE-MsgGUID: TB2/gEsESDCzysuDYogL3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80466773"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="80466773"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 17:12:39 -0700
X-CSE-ConnectionGUID: mvwz+I+4R6yLN6/QqPvAiw==
X-CSE-MsgGUID: KW5NVmRgTA6FpZ9MNEGmGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="233272608"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 17:12:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 17:12:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 17:12:38 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.21) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 17:12:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZH2psOw/WroKaHHVQo7FJNbWD3wZ5k/C8n94AiO9zIS6rmehDZnmT+rT7OpFlwuFiVwPMuq24ImaDKqk2+nH0lDRcNCtsRqlggX2OynIFX3Q+bUuwwv5/EKOPMb4Mj6MfoEab4Y/Rch2v7VRMiPEIO4pYkrp/jTz0iPLEsXoCaULTChJXlOk0imfRrOowitbqUltXGqY7FCNIWHxiqecii7lanQ8usGU/Ge74xk3p6BAOaEKpMOyjKvRet0N9InYfTTzjWqlOy91fYjlguRqoIdaPTRas3jnjCAaoR4lE1BqPxeoqejwhRhscK4H+dJZYogWv7RAe9uB7swZHkaneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmpcEhJRXNLSrVvtO+q3NPl8oAVZNB7FR37VZ5VJvZ4=;
 b=g35RC63dRItgI6qKpwRxgjC1C27HCaJ5ieOQiIXsV311GnDML5PDsGWXBnfxcfDdc/vPiOQLtRCnJ8jtnFSnZ3Gnyaj15S7KIaQX5d/2UEN+nHXXcYtkrT+vTY7eQpAPcjgh9Lpy83YFOL9rZV2dzZUh9IvJfThWkzjS/tlLA+DQ0VFe9D2yMhWIu00MG91gmOYCfFdzxZVqg6RTTHGva9DTmFIzdELU195oiq9PKZH0g5y4n3/gLFby6IFMfxd5ppmqVOeMhnOKCWl+j3siAk+F89v2Nvq+DNFKrev/4LidKM/foiHv82dW0lN04Klpfte2BycBFgxiYd8U9L0/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 8 Apr
 2026 00:12:34 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 00:12:34 +0000
From: Peter Fang <peter.fang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Nicholas
 Piggin" <npiggin@gmail.com>
CC: Yosry Ahmed <yosry@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <kvm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Peter Fang <peter.fang@intel.com>,
	"KarimAllah Ahmed" <karahmed@amazon.de>, Konrad Rzeszutek Wilk
	<konrad.wilk@oracle.com>
Subject: [PATCH v2 1/3] KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
Date: Tue, 7 Apr 2026 17:11:28 -0700
Message-ID: <20260408001137.3290444-2-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408001137.3290444-1-peter.fang@intel.com>
References: <20260408001137.3290444-1-peter.fang@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:40::24) To SJ0PR11MB5645.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|BL3PR11MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc18e15-f2c6-4a6c-5413-08de9503888e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: C+woclGz3/KKypkYSMYvyfmbEtjHnb7mAOslMLTAqwOxyJZHHUlj55e5XRccUe2EgnxtsFnR8NMcPABw8/3Fe4NC102fLhpCudwjDOVVsbUCLqP1C18ci4Ra12a4CnYiJIh5gsZaTJOR/PVeJNwlI/gP1IbO943lQgJJQ3mFV6ldVxmxVvsyPL0KxU/zzd1FSePlyO4WW1SdL0reHigdKQMKJxo8ihWBpnf6qPPHvL0659f/sEgS2KBotWMf0cgmoq7HIjVe7vNC3IYBZ1Jxhha6o3VS4jd+SZLjQMWb5c6gAIJUPspI9S+P7mrNYY0WF3AKJQl3++RDHMOBE3Kvru0UwApGrJ/fEVF/4LxmXGnsZgAyaLZp3xIRZsCmIma+eTB1vM3EyWbmp8330fhgITzOQtcg+MUPW84YgDB5f82+zrLBnNIR32azGZXs0KPSyofbPJSVM7CkY1VOUVrtmFYaXyKG7iUor5ArbxXiFckB/zFJoWvqShRAFLYkv+YZlMZFqVHDHPz7k/YLCHb0nhOUDm+sCJMpf14uzIVseyNicQ38ep47hozLN7xncrzZK9sFI4y/2Xp58r+v5MKsbWSSfkPTBiGx21upIMrUPyCoTxTCSppPQ55g1hjZ8iBkpCrRrzwx3+CCVqQOaiYgsptguNYxMH4XxSaqbnXQswQ/J5AL4JBOjXNVPvxiF7hkKvVUszEJ5UqCrY7YinTJEPzoVsvFAdGkzrUcfGxCAWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hvKaWTmKXdrrGjjevpAF/bnulifbxRME2Pv/sfMRBxvbmsZ1CmMAqs7jzLAF?=
 =?us-ascii?Q?UZI8XYJQpyDpMlbRQdjQDxxiOk38No3YnoUJ7btp4IWrBQIzc3WdmuuhrzLV?=
 =?us-ascii?Q?zPyLpRw4q0TFblRH8mWufFHOWBX4ZLRTbs4zoe7IzFfC44nDD4v7xc0rw0Aw?=
 =?us-ascii?Q?+MxQHQvjsoogZ3QsCBaA8LejwChBdwY5ElgOMCtNMP3ttp1jQk12J6p72V39?=
 =?us-ascii?Q?ta7Tm8YPoV78Lc9tzbeu3WVgTHrAc8U2GWi4w92FFCxtwHACaNlYFMrCVd+l?=
 =?us-ascii?Q?SAJ6SgeeUURBqi7g/FOBjsgmy5T9mkOr4S5aIquIwT/Obe2w7yKYb8y5tMhx?=
 =?us-ascii?Q?HLSpnK5V2hihN+CJAd0q0okEgEdwDEi4leJoJHp00YOb6+/9t1B/CD3mxbtQ?=
 =?us-ascii?Q?yPx+SGerDKnmHa/RUuQK8HkRUQPZESzOv19p0CYenFgyRkl0EyCnPixRy7uC?=
 =?us-ascii?Q?YUh/O+qKFDqFW2Xvyzn3hWiyP1noGOhPMSNYCkQrH5C0koXmQ42xylAyso96?=
 =?us-ascii?Q?HynD5Jd8qMlCKeHGxqlJmCCfCqtPeei4O2FdUTt7cWymlsm/mXaMJOTLE0pf?=
 =?us-ascii?Q?rVqmNJyV3ZRonKqu15KUDYubzxH651czk1HjSrvwog9LpMawkOdlLSsCmH5N?=
 =?us-ascii?Q?FWmpAOGuUF2jYh3OVwbu5Wq/uCw2+Cp7oSV9hkJW0yVVT6hhNpYijnVECcVD?=
 =?us-ascii?Q?go5HyOtigiWed6CC8AEx/weIB7XViTSTj7IM2PyBiboKXalF8k5wM221xtGX?=
 =?us-ascii?Q?tFv3ROEJsHqYcH9ArS8gaEwMFxIFkZLlMFdraqx62wODxgmJ0zUjiMLPLMoq?=
 =?us-ascii?Q?3Ab86SvKNuAe3QKiiiHTZvewE4n9+pF9dyfLDIQBEGQh4PWt/xf/8cizk1lZ?=
 =?us-ascii?Q?IU4dDPGouGflxIPh/TXfB1/usi/3nVXpNwwUW3HUT3GMPg/TzJXkI4TbwOTZ?=
 =?us-ascii?Q?6mFXJ1e+MJPnwQBzalBxv1kj8BLf/wRAqrPE4CnkySIv57kj4QCHJ0Po67pw?=
 =?us-ascii?Q?atDGQNOzKJQsB+dhfbFRVdH4NxE53B9kYELSEsq1MPqaE03hn94ahX7houb+?=
 =?us-ascii?Q?Rj3E/FPecbHKCQfA/NndVZjS7oSAiwF/KqCx6Sis4gad9luWUZuVghO8FKqQ?=
 =?us-ascii?Q?nrZpLrh8QD9OlwXgvylnYwZ/YS5Bif2e3lcspyJgK9hX2yN7O3MaxrWTU/ka?=
 =?us-ascii?Q?l3hPa9ic/VvUHE9SXD7AixT+kzdIkVZOTgKrHSv35j9G5el+NQNhuSudhpHK?=
 =?us-ascii?Q?b5I+D23QVZW/XOTh9SvgLm+nVhz0CK4N8AXfXisldwlsVW7f/wm53o1jvR1E?=
 =?us-ascii?Q?DsuMtAaKWieUmC9DaaqEK8enVT7gg460P/RS4e/ZBNxorNIcrjfbjzqR56d0?=
 =?us-ascii?Q?jUJZUbvEI0p66jJnE8U30bwZGfViE4zKD14SIK3t14atsHh0j39GmNw+9RSV?=
 =?us-ascii?Q?sl0Kya5AB7IcPT4hHEXr2YKNhPaizlIjmqdt+vQ/8iY0qtAgsNwv6YsbsR++?=
 =?us-ascii?Q?Ck59H/VKOePq9IcPxnYB8kqKxdKOw9dBfcPoHlZkSCtzEcc5R7VDHY7ZTd+N?=
 =?us-ascii?Q?Zo4L9La15JY0552QDbl6+UVjQVyd9mr9MTJTy+s3AZaf/tWnIbsfkuc3PxMb?=
 =?us-ascii?Q?u25p32JiqIEo/vfCOPFtdXreePQG7v+Vn/01YIvb8+KNmXT7dFNdtUpdeJ1n?=
 =?us-ascii?Q?+ROQrLmBcB7pgx2ffUX8L+o3/fOc8oj5ZazSTp4XhRtAyhRWKA5AoX0HA49n?=
 =?us-ascii?Q?ueJ4EXJwFw=3D=3D?=
X-Exchange-RoutingPolicyChecked: sUsP2g+TfsZxopZ4aiVeAodwMWRwsWx54/E/HZQLRIsldOjDIfxTzE+g2ZIQ6Z1Qv6zMRHKr5ehSFUASCuc/kT3+cjwsdQ0s06kZiMNgrE61En68ZIiF+lb6z+C6JdBt8OMJdc2rKKpo1Z2n2nCPBeoWOGVjtLb8UZNUDAVivxHIpVx+Otl9V/5c9C5tBoL7q2ZUGQVTMgACiRRC5eMs2jJodij0ti1+7ADwsb6USXSaecShsi2sy1gV3j3t+I2hb6Inm9myC/Dr0gv8KDL5D5JyXUVua9U1xpPkgA7Oa4IeXZ9AaydX0x3+EHl1aM4uzdR/fo9lS72lVfrmV1cf+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc18e15-f2c6-4a6c-5413-08de9503888e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 00:12:34.5442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fL5SJjwLmmAS1DnsHlFn08TLmOBVuOpkzUJV1+ES5zZwQopWm5o5pH2zpvEerRvRUvX7Y36pgAkSmA/xqrAYOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

kvm_vcpu_map() and kvm_vcpu_map_readonly() should take a gfn instead of
a gpa. This appears to be a result of the original kvm_vcpu_map() being
declared with the wrong function prototype in kvm_host.h, even though
it was correct in the actual implementation in kvm_main.c.

No actual harm has been done yet as all of the call sites are correctly
passing in a gfn. Plus, both gfn_t and gpa_t are typedef'd to u64 so
this change shouldn't have any functional impact.

Compile-tested on x86 and ppc, which are the current users of these
interfaces.

Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Peter Fang <peter.fang@intel.com>
---
 include/linux/kvm_host.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6b76e7a6f4c2..4e3bea92a06b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1382,20 +1382,20 @@ void mark_page_dirty_in_slot(struct kvm *kvm, const struct kvm_memory_slot *mems
 void mark_page_dirty(struct kvm *kvm, gfn_t gfn);
 void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn);
 
-int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, struct kvm_host_map *map,
+int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
 		   bool writable);
 void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map);
 
-static inline int kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa,
+static inline int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn,
 			       struct kvm_host_map *map)
 {
-	return __kvm_vcpu_map(vcpu, gpa, map, true);
+	return __kvm_vcpu_map(vcpu, gfn, map, true);
 }
 
-static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gpa_t gpa,
+static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gfn_t gfn,
 					struct kvm_host_map *map)
 {
-	return __kvm_vcpu_map(vcpu, gpa, map, false);
+	return __kvm_vcpu_map(vcpu, gfn, map, false);
 }
 
 static inline void kvm_vcpu_map_mark_dirty(struct kvm_vcpu *vcpu,
-- 
2.53.0


