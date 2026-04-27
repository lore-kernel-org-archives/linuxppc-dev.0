Return-Path: <linuxppc-dev+bounces-20150-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57087FF8862
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 08:06:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3x383mFxz2yZ6;
	Mon, 27 Apr 2026 18:06:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777277172;
	cv=fail; b=l939OAfO3+gXcuCFxZfQC8iyKzlCeO93qydvQkqmnjMz4XDx4owd/OJzuqmDkx2B89tYmK0BkgAOODlouJIYwkXVGxAaEURtbBH4Pen0M6IzrimsWCNlTJX3rn1RZ6XhH6ZL+qci675eVNeOLsr/Ht6a9BKxHoSrWQSQ4tP5GvQL4G35DQQ0vr20jIqKfpnuYkGdiHgISfAVfz0C6jrlG0paJ29sm5mxvlUxMprQHFYvhfULpN0unDuweP3VKrXqflbRsOFnp/08xUAHBl+Jw5vbLg4wOGMBGmodzXCM88laZ/jyarAO9JtM702ZAcg4qSdVlvhIf2rP+Owyc3w2pQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777277172; c=relaxed/relaxed;
	bh=k9lZG1fDrLaEU+xqWgV49c793ZF9m4YDmQfq747vjdw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PrLs8Ho9Hzonj5ENCrl+ZgRN/ZENG58bl4p19i9toxLsmS3AWGj5jePUu7sTgniuhsuCXcFt7uV4SokWqgKnmkPFHYFmpKvGOrrTYIhuMVUDA+GciirE1k1/fFMUkky2J0O807lq23Z8UmHgspD6o3AK281KgQ1Yr8aq+AGQpDMhsE8aMdBTOA1JxFQ5p8vGp+HMpgzIWGAvJaEZfrU9wRPK+RI/f5x7Lu2S69eaV+jxy8agG6JFdsvfSlfC8wyx51BQzV3qLFgEBq0N3Yc/M03PNuFujhuXYHhmZxqcVcLw/UlGMeSmw8fV2xMuU3SZjW3KgwyO/0xzT+IfQnB5+A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VfO37KX9; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VfO37KX9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3x3470hSz2yLG
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 18:06:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777277170; x=1808813170;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ChkMv22SkCmmtOPTScYbmZRIT1BWS/QCUL4igZqKIqk=;
  b=VfO37KX9lh+5LtPDUXKl+0lKHvf2gnX4eShyMgPXCwCD18IRk0TLAb60
   9BLPr/7K6jB82Ntld1yaSFVQ0thRLuM711o0DAGuAJkiE7yUTWF5koeop
   72XryS8Q2xUw/mSgrRhsIF/J+jncQ4bihSL6iD4/tj+q2CBX0ad2x0O/0
   bL6LCmApdZE4oFWc0mgtJ6jyEjnMq/w8cVkcljPSNiXxaf4Be7bEMHXzG
   tDynGfEKWveXn/G1YFtngMNWS1Qer3ozU47bzd+kLq5+xlviGGuNpja0J
   d5aiIZ91B7LZDTynizjCETYTTxaiBVaE0BKNtHcTqOpVrTmaU5135e5Qg
   Q==;
X-CSE-ConnectionGUID: nbZYJvQaTWmnftjmqhFeHw==
X-CSE-MsgGUID: 7ZnJHlJ6RaK8ZAWqWZfW0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="100812555"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="100812555"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:06:02 -0700
X-CSE-ConnectionGUID: poSHdGWtRPWmaoAEmAKxjw==
X-CSE-MsgGUID: 2U2XBiI5QlGmj4xok+kKPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="230939113"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:06:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 01:06:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 01:06:00 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.38)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 01:05:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+bZtkmJVjcgh9eiTvl7VgVdRzg+Wk/66/3+Y0yhvjEoBLt24fA+7EPgg3NX2D2baktQCzvernJ+OnQxcgoDiEMbuBnGKpSQN/IUHPg/5yFsNWsb3plNtIU+PKe9ed/+Mf5teTXu8JnXdHfWF+A/AnBsHhpR1ko4onf1jaVDCEeNxaRswOBnH2sT6JeRGpvyT3s64bT7G0Ekyr4yC2RxoKTKOKKAk3RtuZisL0NrFuEn1AIuYmTQRkh0iqwFYjHkgtyR1ZUomPbmUiCopiUBOP6wrGwcLrjKdKUZLovnm+969gMauz33kRWBpL6isZND+Yw4sI/egRZwJWBMBapVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9lZG1fDrLaEU+xqWgV49c793ZF9m4YDmQfq747vjdw=;
 b=j+FwSMa01vPuOe8/VM+UR1xFbGYLuParPiT2X7+7h+xO66bhn10sx1APFBv74odQRianhhutU8lXhESTqz3ciLBQJX8IR1ZMKwH8NxO5gDpa3yTsgP58cDEfmQCHFP9sXJj0wGb4Z0DadY3Jjpp2FvD+1oRv6pe4M+7PVn0HzjllpljwynVPZgigTE3sSwtSKfo6m/CL7qiQLT6fbui5PT1WbYC7Xb0+rVSBFX8vcmh0dI0/n2izWsalaP8ksRjge3oXxwxtX84dPq1LCe1xDAXqIT9RLI0Gon1eLHjKFadKzvhpdn13I1AhbJMnA+s8r0KUKjyCG/xP7m/7adgKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by MW4PR11MB6786.namprd11.prod.outlook.com (2603:10b6:303:20b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 08:05:57 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 08:05:57 +0000
Date: Mon, 27 Apr 2026 01:05:54 -0700
From: Peter Fang <peter.fang@intel.com>
To: David Woodhouse <dwmw2@infradead.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Griffoul, Fred" <fgriffo@amazon.com>, "Yosry
 Ahmed" <yosry@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <kvm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] KVM: Fix and clean up kvm_vcpu_map[_readonly]()
 usages
Message-ID: <20260427080554.GD1733452@pedri>
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <c2fad21764d2561469151f5dd5d35833ae8f76e6.camel@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2fad21764d2561469151f5dd5d35833ae8f76e6.camel@infradead.org>
X-ClientProxiedBy: SJ0PR03CA0375.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::20) To SJ0PR11MB5645.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|MW4PR11MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc1c24d-41a1-4b77-d525-08dea433cfbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: H7BRzKkZ9ZjYq1epOu0uFLXnAic3IFSgSPhtw7wI3YbyR5RpqqKJmUZprZCAvkJ6Y0FTCasyN6zeEmvcHPenwlzK2aOwDp4pY78LiMYbS/cuN4g3a3wgOTCvSRibvK/Yf/UkgVw6kbV9Zkj+h77HNDBokZnP0sL+o5b/Y3oAWv4ek4LyVVzQc1inLOzCar0ChRuZJDba2AWz3u4wv6HCO3+Nj/NlI3qFZkBuuT99L93kc565uXq9dr+Pij2EN+hGf+8jqlYvMJl0lYkf9dGfoMRmzjIkf6Cn+/phxYzN4PwoS0+9dTjvK+mRuQHD5CXPCirAdGY2Efn25PIBzFWE13gJpOa76WX0VoISZ/+0SO6iKuOxW7pbYZG8KoZlDChhOKWjY46XodrL645iGjJvoaVB78DD7hxr7UJXIIGliKwyUgTanCyZFgrnz/VJs9nKHwxLjAGvyDTjK1bMFB1qLlpGBFQKYMKKfQesUjKlAmemc9KrZaLdCIwBkmJHTpgN5/ZsLcCEb5Cwoo+ZqM02UnhWuHtpcONd85jNetWxocScJb2PbvL2FaY5OlpmsgvWwmepxIrFXu25DLbtRpy38HZs1RPYju4Q5iecVSwJUBkaQ5c4qSKUxboye5YIdlkqDH8ZM3LhH3+gEqklTNVlvq912XQ1iBTz5f705MXJXTUxTOgRIYtwvNE1h2XkiWJTQAuLJlNbM4TLietii7TyWW0lfXzBIfRQ2ZV4sOgy+0TW4nTy74QoWDYoowv1o9SF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vyt4dXhFUHorOU5CQjRUTUhwWGdSaE4zdVBHT1JRVXk0dEk5V1BYOWRuc1Fh?=
 =?utf-8?B?Y2hGRUcrWFl0VEtTdXlQd0xhc2szZE05cDhjeHJnN1psNzRwWTk5M0MzMW1v?=
 =?utf-8?B?RUdJNjlVa2RBam45WDBISnNNaWQrc2laZkROMXFzNHY3ajRwRTQzdWZFZXRV?=
 =?utf-8?B?cVdBZWtiNGZtWmsvOGloOGFCRjRCa2pJbFRkakh2WVNOZElBRVArR3R0S1hV?=
 =?utf-8?B?eVhrRWJzemV5Nmg2Sk83L3d1SC9TMnRHRlBma2VOYiswVXQwNnR6d3NaVnlp?=
 =?utf-8?B?d0dCWjgwMUtUSSt2T1hTNWpSeEJPQnBNREZrTGowZ0VyVE5LclJmK0tEanRI?=
 =?utf-8?B?amgzY1VKRU5QNUJLa2xGcEFGT0JCcXJWekt0NHpGTXJKM2ZZa1dFL2FtMnR1?=
 =?utf-8?B?WFNDWVQwTWRNZktWdVpOdkpvcFBJeFVVMEpQWEMrL2hXWmMxYjdCbHN4UXhX?=
 =?utf-8?B?elI5Zk5JZEtKRTlHUEdkVnptMXJpUnArbUhBNHNiTFpoWkd4TnlIQ2wxTURv?=
 =?utf-8?B?eXBySFdCWGRjNHYzNTYxRG1kTFhZQWhnTnc3dzlZV0R4ZGlzVXR1eDZlVGNp?=
 =?utf-8?B?eFUvbEE3Mlc3YVJrQ21peTZ1bkFaSWllWE1OZUN4bitWNy9TR2hUWS96Q0dV?=
 =?utf-8?B?MU5qblU5Y2JHczJpT3cyRjRTQURLdDRSMXh2bTRvSHVkeUFNV3JvRGlid1JZ?=
 =?utf-8?B?SWFwaWRCT05qTlFTOS80RW1UTnRIVnNTbkp5RDNCaGU1TUFVVVptRkoxbk9K?=
 =?utf-8?B?MkpRNDQ1eFdRamxKU2tUUjVCTDNmVDdHV0tiMnprUFlTZWF6MUFmS3puZXhO?=
 =?utf-8?B?UXRzak54bWNXd0M3TmxJKzdRWWV1VStYUHdlOFYwQjhMODlXMVNvTHhzSWlH?=
 =?utf-8?B?NTgrSUpSb201S09xSzdZZVNodlNTYllka0ozWjErS285RXhtRlYySS9ReUd1?=
 =?utf-8?B?VVhidU9nSEtZUStCNDFDRWFkeFNtLzBRTEJxckhIUUNrRXMzYmVvdlp6THpN?=
 =?utf-8?B?K3hiQ21lYXpTUUlWYjZ1MStEY1A2TWp0OFpWUDR4d3VhUEloTkNldlZtaTlU?=
 =?utf-8?B?OXNLemZ3Q3lyTGt2bjhCWGhZUEVXUTI2Z2hCU241Vis3c0dBWXE5NWRvQ2ZH?=
 =?utf-8?B?MEwvTTJnWkpINFgrWXZNSk1VRVJDSTBJMUNaSWR4TmcxbDU5MWV3SUxuZmpD?=
 =?utf-8?B?SGhHeDdYOEN2aWU2WUlOR29IYzNDRXdCREttSjI5cGRUV2txUWJWSyt5QTNC?=
 =?utf-8?B?TEs4Q3BNZkpybzBrcEZtUnN6R2hvMkZHajRHMjhvU3dEM25XcElSWTVYU0VO?=
 =?utf-8?B?RnAxREkwbk9hdUo2TnZ0eHBRNFBkZXl0NVlqc09UdkM3dWVkTy9SQk11dUNl?=
 =?utf-8?B?SDJja216cVQxaXR2dmRhY1NVRVJRWjg4UzBtU3UrTlBPTlBVUm9HWUhzRjE4?=
 =?utf-8?B?MEcwRGkzRitDdGtCNHcrdTU4clNmZzdyM3hzN2JPSWU4NHhzWnN5RlhkdG9W?=
 =?utf-8?B?cDYwWTd2czJGTEF1a3VjVlVsczdXSnpKZGUzQnpodzAva0QyVjc0aXlDNklL?=
 =?utf-8?B?M0dWL1BIU3hVa04wTFJMTm4yOWdac1hqV2lGWVc0NVFRQi83TUxBOGdDNWg2?=
 =?utf-8?B?MzVGcEttdnhTcEppRVlZeG9YMm41cnZmbFgzU3FZR2l3bk9Gd1RRbmZqdXBC?=
 =?utf-8?B?NHdjL1UrcXAvUjBwbnVKNHZ0REtLdVY1a0g1UDNRb3NJajBQblVNSXpESkFk?=
 =?utf-8?B?cEFxNkt2UWhhV092cXRYTEFPcnNyT0UvOG9DWXVUNW1Fck9BWUJHUUNobG5N?=
 =?utf-8?B?ck1XM1RPOHdkSkJqWTRmKzgyMmxqMHVhUWdUUDhMbGVPeUZxMlQ5Q3lxOFBi?=
 =?utf-8?B?WGZsdW5Ka3pzek5TZUR5WHRQL2Jkd2Nya1BzTnBqVWFnS2VCb3FpSHYzQTM4?=
 =?utf-8?B?ZDRkcUlnbTM2WXFSckVnQjMyUXc4R1ZoM3Yya3AveTk1K3BnN1M3dHMxbDkz?=
 =?utf-8?B?VUxERXlXU04yNTFXT2o3RE5OS2NtSWhDVWljTEx4Y0pLbVpHQ2lISFlaUDVs?=
 =?utf-8?B?YWtBN28rQUxqRGF2KzVXcWV5cmtwSG90c1NBZzNUWnM4V0lyOVQwRkU2S09t?=
 =?utf-8?B?UmNNK3NLYkhGZndvV0NUYU4rQjFyREplYUdzcHUreUJ2NTdpUG9QWlFJSzZM?=
 =?utf-8?B?Sk1YY1krMVZuQlFKVlRKN2ZlRnhlaVRuaUwzT2lHV1NZZmFhc2ZOYTl3TTYw?=
 =?utf-8?B?b2pMTzRndXN0dHRVcHBxSzNLdHV6UzlzbmVIenRQeFFEcTgyOWpqM1FVRStM?=
 =?utf-8?B?VGowQUkzTXV2SXA1YUlOMlE2eEhOR096Z2VocXBQOVFDRnpyb1Ywdz09?=
X-Exchange-RoutingPolicyChecked: CIVYxbzkY/vpJ5z9KGetbmDmPzi28zecvvc3N0zZJyLvd0S32q+wlvzTiiqTA0CBAXMaHuae/qTnv5veX7jGTzWCBoi0hhdVDvl3Z5H5RltGaMxuRygvDd23ym+3VedKM68xIQ1jFBzme5ElLhPq3IDKW2E5IxLBlvnyJ4vB/jhHi57QJEkqlvIVF0T8tT8AstBXlvXpixhDTg643YR+AL+5egoWCtFVdNuYJvVAVWxMi+fwQxrEimoSPdcA7PK62tqctnzmMaIY6KxILNJlSCLqcnE25dMEv633T4Z0NdClr7s2TsUlu/JnMLqjMpMRaqZU13qJv9idUkkRRBjCxw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc1c24d-41a1-4b77-d525-08dea433cfbd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:05:57.0301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzBdz3xgseIzFezllfmTlzNVT0CeQa9YmM7aLfSbIhbhHDigdZxfYFRs/JCygF/7eEQR+fbK+GyM7IPIwvv4YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6786
X-OriginatorOrg: intel.com

On Fri, Apr 24, 2026 at 11:27:03AM +0100, David Woodhouse wrote:
> 
> Fred is already removing all the usage of kvm_vcpu_map() in nested VMX¹
> and nested SVM probably wants the same treatment. And the PowerPC one
> looks like it could just as easily operate on the userspace address? 
> 
> Could we just kill kvm_vcpu_map() completely?

Thanks David!

I think I'd need at least input from the maintainers on this but just by
code inspection, the kvm_vcpu_map() usage in sev.c seems a bit tricky.
Unmapping doesn't happen until right before switching to the guest, so
this might fall into the "keep the mapping around for a longer time"
category [1].

[1] https://lore.kernel.org/kvm/20211115165030.7422-8-dwmw2@infradead.org/

> 
> 
> 
> ¹ https://lore.kernel.org/kvm/20260102142429.896101-1-griffoul@gmail.com/



