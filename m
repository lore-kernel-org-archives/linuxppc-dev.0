Return-Path: <linuxppc-dev+bounces-19999-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8321DF99340
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 07:50:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1StQ08CFz2xls;
	Thu, 23 Apr 2026 17:50:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776930605;
	cv=fail; b=muYbVmzogtTw16q0NcDaA5nnnHB4UO2+D7R4a7XWi/lEZ4TjUkk8AE9Lu1FuSSFe/B0dMdOnYkp5/XBuOcwPWhnaINMxjjG4OKZGWLzyvB6x6LhMDsNaW/MJ2sPQE70VPrUqG4FFKPd5YmzylHF0P+y++b9UAlG3/Th6fx2dSutGt9lN7qU1zbOlamZm6UHRXiphrOZcLFMwwiUiRdcrrB1BE99VwGEfJQ9KEYd8tsw4tcDgkMdadG07jnAzjoq2lvPAM15iW3tWKB6sCNSGKsAwRZRKNWWc3H1cj8pCNXaTMeXKV+e8btOVTyhp78I26aGYOdLTdPCUKFiA+kAwEA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776930605; c=relaxed/relaxed;
	bh=PK0VrOwBqLDWedfhkRWU/yTrwDpdo9dgA+ovcbCsk1Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z57GPeSEp2UGYel/QQP+HJQoVBHN7sPrIiK3R8zoQ6aU3DKLVVdfTZfIWs3esPXx7JIZt9MW9IFpxkf+TpoHrY0LlY5rwSkBciBWTiq+LAz6aiekDRacLndvlzuQsp72mfSfSya/E/WlHDaM/SgJmi2urO2Bop7H/sCNQkAJeNAuXdLAwOv0xOTF4rzhRvXBLzFLqj8xjaQSGOcGemOHGwcff3tpWN4ZZCjqcXlu8gMg+Ij5T/kbXzB+fp3WcoEQiocKjqHJxKxnB1qabXSTT1venyWTGeVaB9zUYBC0SRqoZTB/2WF1dl/U+tFI0tSMexgNIxHtaOMq8RhyzjEPkA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OXTSgcCw; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OXTSgcCw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1StM1QRfz2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 17:50:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776930603; x=1808466603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OS4BO2ZHKdJhXANW3oO5O7bfYGJ9FN5Ut3KUWyjmc1I=;
  b=OXTSgcCwRSfqfmF3+5iUnL+O2/5w/0BPPGzEe805Kn0EWZIAHviXCyxS
   lLFdqH8hV9xsNh3FgqpGrxYs0t98kDEKEeJDMEkAGRhEEKlgurE4Q1z8d
   o2rooIPldElrchi6V0cRtniEVFRX2z9jquLVgjmzUlfumf7nQY+qbHKnI
   9EIhK2t+ZfHWmNfZxnnuzYszxeDYR8hXnEW8J9Cl3WmBXMUgduOjATVAm
   QA/4LPx4Z146fWKsWNhmo3bkwiQrWaxNs5VwL5TQdpVVWjLRGWsbCTPbA
   HnDRS65+KGqvLw5Y04h8FTuzDMAziZQCwNIJXzuumwhhz81pTar9fbXI7
   w==;
X-CSE-ConnectionGUID: YeyPlJp0TKOtySLDjhGvbg==
X-CSE-MsgGUID: /1iCKFhJRwSeSckbl3GE5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="76927958"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="76927958"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:49:56 -0700
X-CSE-ConnectionGUID: z0KSVfhISmCDOJv+BjwhfA==
X-CSE-MsgGUID: c7fIRLoER0akwjsQNQz28g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="231707240"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:49:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 00:49:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 00:49:55 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 00:49:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HC7paawsMJrRNS3ffWzuqfjoNTIUTsN0m2R2WDXKt3g24X4vtMZKOkllYwN50QdyATjIecl2Zf0lVEnOAk8OOp+aRTzI7xZ0RorRPo7Zc+Tlfa9mf76xarZKwMcvdqdJpX4n40yllLr2omTIIcd432iLrtmKB3m+WJvxgO2bfV6pxHOqOhMkJgRsl50RdA37RfnWyh8CijR5v2BtEmSOxHFlUQ15zEX+2WguKyMHToj9ZTpOo4L7jdNK0oLPndnUm2wjjJPEB6VkTQ/3tueiQ2F9qOpKvB2xGuyyjbamm2c6E4yyGXNdNUM5TGJIRGiUFB3mSBiQ/O2qhxKoTlaFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PK0VrOwBqLDWedfhkRWU/yTrwDpdo9dgA+ovcbCsk1Y=;
 b=KwgK0IL7rmjTKe9gYJwGRMzCqA6hObTegToJV8nTZSx+aYM9ioRnazKsWIK6II50XQFXjXOpFcINFfgtuVFaueHGl059yebneFtvL5rTLV+AMB5DBbUaq1jhS8LS2LVfFk1eR6b951P2nxpBJXO3V5K9u30sBYl1r0qd6VIpq9gXqGSAG+Fv0yYlISXSQeTJNkohnb+B8PPHeo8mrNXZisQppVuMG1ZaXidgSjs2+8m6reJfX7QTdohOHiCuiSparFiBsRDgYzeyPqW7ZwRE6/l0E0CUxpwEcNr1E6lI0HURNzI6l4FMd3aLu0UzvQ4r8wbqXaLWMnk9hKAXWZLtEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SA1PR11MB8328.namprd11.prod.outlook.com (2603:10b6:806:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 07:49:52 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 07:49:51 +0000
Date: Thu, 23 Apr 2026 00:49:47 -0700
From: Peter Fang <peter.fang@intel.com>
To: Yosry Ahmed <yosry@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Nicholas
 Piggin" <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <kvm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
Message-ID: <20260423074947.GA1733452@pedri>
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com>
 <aegDJssx-ZvbfggI@google.com>
 <aegF59gToidudIUC@google.com>
 <aegIPGYPH-nxGsua@google.com>
 <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
 <aegV3ELp20DlC5Ge@google.com>
 <aekrJrSRoclZoBo9@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aekrJrSRoclZoBo9@google.com>
X-ClientProxiedBy: BYAPR07CA0108.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::49) To SJ0PR11MB5645.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SA1PR11MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: 4839d42d-aa1e-48d9-a82d-08dea10ce692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: D73jMJGUbNRmEwG2lQMlc33FhXUlVIUFat3QGVI3owEicQytsuh/UBOebXkXJZ0ZF5pPVxUcinT4YqLPrb7rhvoNVwjRA8+K4EMClnoMv0WqRcpgOFunDkWYInZGkS3tWKn0QhQP38iYCOKsYNint6AUeQnW1uTrE5g4vQADBtiXqRuBRmhC7rWv+SroRzorO6O57cDmARr/Tv2WEn0EWnfy3GPeA1v0DmZ1w1NTtXl8qK8GNLrgaaThTXVanDXno0t+GeV+P1/eVOKbFSZUGEUTwXlejbIJAR7GOxnXWiKOAOp8WtgB3Jkh/0gudZDXPV8+mJeCo/d2q0qlfVxoht9/sq3KVGSWzj6sROgdvhtRXnmqOXUwF2XBlGXMJCHap4xoNh3b5tgCQzRbGVeqdo9hflHwuqB4qP7OR7tmUppgRqWQbSpKr6pOmQ+pdB8p4T6yvm8C5rE0fhpsvenp6WGZAe1CZWY1C/rCDlMymsXrzpFZTgirIV8esq3FyDwMa9UNeg8o6PlBCHZ7xSVeMXOu01ekBaGD+YkiE0QOFNpQhxgTboinrTn7EagOPIjRQcuXc7XbE9BvfB3N+TNN8fGPPjhHCZVUvsLPxqOc8enTatOE1ix2fk49YcVszEhj4xMxEhEAjiYfVzaSP1DeJHXc+scyarqzpT3E8FVb32URwcb46s3TAFlz2B6jL1dOF4zsGsClaQl6aMfWO4IFgwrJmNwZWyDs11Jz7QQo8p4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0bNqB2lP+4GLm5u/GPsL/J2dTbXs/pJiQVyhwCYPFBAQ7mQCzYlniyEOxonU?=
 =?us-ascii?Q?136p9L19rSRaTtxXZSsJ6M8ITe48000tOWyTU7AasJirt+YxVtvBxmpEzRoM?=
 =?us-ascii?Q?UCtyvNdWRkdq7vOMnkzi2uSsHLnWx9JOmT/hnzDUMzpTUkoTBNQoBWjzAxCU?=
 =?us-ascii?Q?IJ61cmjfcsH0REMRPBBlNf8h4spFrr/25QBQcT8j5XVEsRqVgUlAeV29w0s9?=
 =?us-ascii?Q?72etDQRSSadVJwYMBP2NHwWrRi1eYDqqQEbOSSAwoWpKOfxiZ2rvaSipglp5?=
 =?us-ascii?Q?E5vwgDH3eAgq7QvY3yUJ8LC0C0vUo0LVV2rwKORXChxsxabNIzI4HVRFlUPG?=
 =?us-ascii?Q?0+SK7RSy+Ve+JrPnrpFMJorMev+weUHGPjhaiXbYZLCsfOkJJiO3ZuiDlWiu?=
 =?us-ascii?Q?flYlx7uulLE8TM7ysd6QSpyRWpdkRKvD102lwg8sMbZMQbnIufyRC7oKbYlQ?=
 =?us-ascii?Q?9V0naHefI+MsZFudbuJ2SgLJp6mCdi5TmcFUJTiURp2+GNa1sc8I5aham7ro?=
 =?us-ascii?Q?GjTEFkFpllviCMqLKPhMfHEjV/QsNhitTY3oXg0UHIpIBXl+nIrxb3Lqc6X6?=
 =?us-ascii?Q?WOcM1UfEcHVi8ljI3YdWvbmoKhgSziZq5k03OJ+6FYFRLFgaNWjSQGOAUNpu?=
 =?us-ascii?Q?OQn0MziccjUwF0dPWEwdg9S7szOXRYtBjvTYU5WNYBxIKN/IfWtV5+sOYyo8?=
 =?us-ascii?Q?Bth3/P8AF+511qoReTzLgfI0DUBC7sOMjVKd5WnTNgbEHDTQvZTu/dE1NuMt?=
 =?us-ascii?Q?BPQpnAMwAC9Pte85HTPwS8nbD3vhvWlvezinvGmJfXX3MJ+JZaNW3OFHHSj2?=
 =?us-ascii?Q?/zRt1wux2H2wgcAdeJarJJbtXSwE1UzjSp3GfvTJeYTLXaOHhNXGjDTCghjW?=
 =?us-ascii?Q?z9NarwOBxCG94fOCWD3z8mK5ZS/9WxxNUxnYJTSnE3uwWrPwtNMiDyB7J+co?=
 =?us-ascii?Q?W0hL9s3fICWgu1sOvSW6qPGohyKYXLruhL/J8xGIgAR6Nno38Mh+gvjTFd/J?=
 =?us-ascii?Q?K/UmFlNzWQHpa0ypYDrGU0fHOXeAyRoT0O2eUo2PY80BLrX3GXKn/NWHop5o?=
 =?us-ascii?Q?5ZAj6wVMiPV6kxzgcJCF7NhB4+KiDjM7BkUnc5O2KO4EdGoSY4jCjDFVlXAO?=
 =?us-ascii?Q?NKZcOi/EoFpb2wDEqP7c1i+H0FkalMmGkknVzoa8xIsqjlCjbGYJIUVs3D43?=
 =?us-ascii?Q?LLlcv7RfdWoMyeCJoQJo8Y/nBXx/UY9SeIKGHO7woy19rz2Zg1X5o8wwbdaB?=
 =?us-ascii?Q?+9756laatY2c2XSekEVcj3bMQZYJInPnX1mo0R7XYa2eVEVS2G3hBAkoLkNI?=
 =?us-ascii?Q?xMfkmitLPoRbIkQo7a62BH2JsVjgVTehUasljpKIAQZ38rKOSQgivihJAvFh?=
 =?us-ascii?Q?NmOgY8Cj/rjanDiFTsJ1GF7OwwDbe1feQI0VAKshKeXYschjwQ1AKdt11Zmp?=
 =?us-ascii?Q?04X3SzbsBxqZt9QuCBwiOeBEsNYLdCT2oKlTPAui440QSl+j/PnRreSvdTHD?=
 =?us-ascii?Q?bBECg5Ue2ay/OLbcVJcDuBkP6MFcOCcLgQA+7mX3iWzX7mv0sGQBIW4TsPK6?=
 =?us-ascii?Q?AyB1fiVVdwhpkAfBe4LrUbOphl4Hz4r4LP0fkMmdMWJg8cXNv4HWSqs1QiJK?=
 =?us-ascii?Q?GXRYbQ23Dud7iTeOOUvzR/VQT9h4ur/CNGlNwYjt1zhbfurf3GgsT4mhGQem?=
 =?us-ascii?Q?1yvp0q/9t4O0TTMh3RNAUuQKpHHUSTfupX9VeU6runcLuoEral04EKqWEcN9?=
 =?us-ascii?Q?fIi723CT+Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: MU6Z+nyDcq6/WZDcQB4ufRQquQRNV7f4VHjzxl83m4Ox4kdyAJYReAOmNERjUsHPuRPX5cONOSV5pbzqHC4aok3Dm1GPle0ch9826mrVltmXFlMPzVBbuU3yybu4CexLCV4+Rk+krtd6jnfIIpAMEBAeTwIBP6vx/25q0IYVT2PktfvDl3QmQSTGomZDRmhxJVjQtcvP2TZrV7siQg68yKIfFaER7Rf/b15tCOIEV+9N6NV88h53GmPU0OM2caa7LGJ4RCIW5ZOUsSfIEf1T+K8amxv1Hnr4csnsIrNdERCTDKYKLYzfRrlJEIgV4s1Y4bANOVyj31/xcV5y4jZOKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4839d42d-aa1e-48d9-a82d-08dea10ce692
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 07:49:51.4782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtKvAZSLw9eBvVj748RPV+VuJal4aTo3bxFzoEilgg/5dWTPRwDDnR2rMyZAXSN5mRXDLecimHphURQRdGP43Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8328
X-OriginatorOrg: intel.com

On Wed, Apr 22, 2026 at 08:19:45PM +0000, Yosry Ahmed wrote:
> > 
> > Anyways, back to the hardening.  We can do it with minimal additional churn.  After
> > patch 3 (passing a @gpa to __kvm_vcpu_map(), not a @gfn), do the below over a few
> > patches (completely untested).  This way the common case of mapping and accessing
> > an entire page Just Works, and flows like the PI descriptor handling don't have to
> > many provide the length (which also can be error prone).
> 
> Yeah probably this (maybe not in the same order):
> - Convert map->pfn to map->hpa.
> - Pass size to __kvm_vcpu_map() and do bounds checking.
> - Rename kvm_vcpu_map() and __kvm_vpcu_map() to kvm_vcpu_map_page() and
>   __kvm_vcpu_map_page().
> - Introduce kvm_vcpu_map_ptr() wrapper and simplify the nested PID call
>   site.
> 
> Generally looks good with a small nit/question below. Peter, would you
> be interested in extending the series to do this? If not, I can send a
> follow up on top of your series when it's hashed out.

Yep, I can extend the series into v3. Adding kvm_vcpu_map_ptr() and
renaming the original APIs make sense to me, and I want to check all the
call sites again to see if anything else can be improved. Thanks for the
discussion. The out-of-bounds issue was not something I had considered.

> 
> [..]

