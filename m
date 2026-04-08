Return-Path: <linuxppc-dev+bounces-19454-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ADBEDB7D0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 00:13:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr3Rl2chyz2yZN;
	Wed, 08 Apr 2026 10:12:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775607171;
	cv=fail; b=k3+qNzIIpx7H+tbeM/GfZrfemAmfAq3NaCKZIWLZRwbKg7399Br6wrBF4JgouEVZXaobRuudT2ksk/JbLlpj1sFPLuD4cieSBA0Wxg5rD9dFeR20O0KJgXMSjEGhSTRmHxLF438IXPEhDuQ/OB299OJE4Py7tBttZSObuS6u0bfbZaZU31TozvuGp9s0hDNveovphDLxQbWrEYWAy5ZPVbQ7PCSqN/M6MzDo2vGMW+BgDour23x8OVgViNte31aH+2DrkHR2lIShxFYCHv98Lw5eqBKJlAs8CaTpH3mC9bNYGloUUUyEoKTbuJDUFqgEm/5qXXDhikLUGDt2RpgaFw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775607171; c=relaxed/relaxed;
	bh=2BnsEb0EUtpokN/BKhrgP4HSzyuLR+43WQoj65XEU70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jv3zcO4H/Wi5DeVwiJwGencyZuH2hVXEu4apfSNYR7Hru2aP26M5ECZSeRktb88pfi1UFR36EOL9mWAqJIULdjSrJ12SZ58t6K+vbcAdx5ar18ATxPZ62QEfEbxxeBQf4AwO//Z3oG0xQPZstAn3umBjTwYtLMxY0rufx51B9caneE5EysJTTyHzWLURWQ2piaarDtVuEp2Xa3u6BmceQSAyaWRCKPDjB4H44dJu/J6J2P3a0NYBkCCdjLQuXM1xthhM+tld1T7F6DDJJ+HQmLA5QihbbE81ufC+yPpqm9RTKKb5JYimHk9eFa2YuJHhwcBXJ7J1vyT/htPc0xFL5g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CCWcRFyj; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CCWcRFyj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=peter.fang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr3Rj75Qvz2ynH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 10:12:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775607171; x=1807143171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=cxKFD5zF7CEalAKf7AlBTUEcFnA4PkVju+MGC/K1gao=;
  b=CCWcRFyje8++wLaDxjjNGgvMv8+gpopAd7XC/6SAM2SGQPgwCCsFFFjX
   yw7xy51L6bSGtaaSl7DR7udJsoin9G6ohiMX5fJM+LYPzNI7QDPk5AEh/
   6jQ4QFS5EkJjLflTc3AwHpKS/651XtRrXFm9ipQmnGBXj4vLHl00akYmH
   +M8WGp7oNhAl/hlG/jcLH60fmy/Q8wSgrwj0UTTei7BdjBaqtWrWrITU7
   cufDiDjHNNFpxkdRs74/icp0WXtQh7KIsy0FWQpQDoLR0cuGdOgj9mJNJ
   BtrYIsDfFVl/n6Tyh+bSj6YsTGYifAD3ncmZYoVFf5YdlsIzTVDv6jP87
   g==;
X-CSE-ConnectionGUID: 4Yir3uMmS1eb4qwIjAth5g==
X-CSE-MsgGUID: bB8xdBvcTKuNk1iSrt/nBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76462870"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="76462870"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 17:12:40 -0700
X-CSE-ConnectionGUID: dJL55AWpQ4i9UJxjN7/6PQ==
X-CSE-MsgGUID: s33TZcTlSQi1B10wSMmGOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="227298001"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 17:12:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 17:12:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 17:12:38 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.21) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 17:12:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceWwbk7KGWODP0FPmyJAIBUAaq5JaAnkZTccMnNMHXsrT2Slf87cvbLkJlLwkeofFS5YZFyqL6EVOYewId/G+PsSzBs/VcDlPlC1+TcAN9owvCbP1mxGl79sh+A39QE9CxO7S0BtT7hMoEoqbnCUVZ8hcsyDusvm1hjvKlOLZRyI2RGjMjaHjrLH4XokDDY20vVdeexnRhtR4BL3V6MgbVAEQoqdrEkC9coQ0vTXrKEa+Yr0I5EcksjXOKHzRC8bXpIYkhFhJYjf9OtE+T6R6yhoYrYJsrvLCuf4xOpIGxih20meEMWSYvsykOcorvfOjGXtL1YByV3VWQb7Uw4RxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BnsEb0EUtpokN/BKhrgP4HSzyuLR+43WQoj65XEU70=;
 b=f8VxRwWhk7KrlLgtbERXq+y8GacoqE6NUCFFbkWVFpSYM5gVozSezIC6sHJGoLAYfmzS1f2IT13BIiU35FxIFc8GvHc3xnqroR1UXeVZtbN+xKmnKgIlCl7w07neWyG6MK4z8Ycb0XOVjK0bKBo7S/jplIcgLEJpYY1+u9UYrnpJBLyQUgTo7LQ+J3iFMVjPqg2y1dZVQk/f1ctNzmRqtS7wqeZe35L61KVYOw5IO+l+G8Fc3Sgmw5KuqiIGRFZo0/XyKpojWJAGYLryrtb2unUu/cnsCIBXciV5rfbR/bo3/r7cBtc/EkqQCORjEHlf950dRUWkLMjWLqoM0U+0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 8 Apr
 2026 00:12:35 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 00:12:35 +0000
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
	<linux-kernel@vger.kernel.org>, Peter Fang <peter.fang@intel.com>
Subject: [PATCH v2 2/3] KVM: Move page mapping/unmapping APIs in kvm_host.h
Date: Tue, 7 Apr 2026 17:11:29 -0700
Message-ID: <20260408001137.3290444-3-peter.fang@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9f6834c6-99c9-46f8-fdb2-08de95038911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IUKs7L41ezuFBNnkpHG13g7/1QLF1e2xzaAfPXbok4sLA+Q1iD73tiYuAE+By+yeYZJUlrXMjICtTWpkZDfWSYTap/1PHflmuTZ0R7Ufg+pLulhKRJ/yeUVfOVgjFbVvcqVDfey2mUYk/3GPeLY/mg71dGCghc9+3ddeoraAuwqiZTotxPb1MrgLodnuUFAZhkpChO8LKhax022nwF34HcF6JozStfqQfe1zmG2rKsBS8abGVchP02KRsf9ZLr6jqruhfMOiQHAdTjTqjmC1JJZB/yqssn5/7HTNpYLJMd3UVNSGMYy5j19ZqukFXaPlRr8C0Ae3tr6BA1rB7d4qXh1NYBntm0tA5YjWcyqVNiAuuNeHef3/XsUhj5FBL2TOXT+54jPSuSiDrkSNfAwQNjo6btYXeju9Ke1bJb98VbRYkH6ge3QWL/MXlxz+CJu0uTuzXmwoLAa9FHeuKJTfeX0eIil5QYQ+F5eIxCDFtBEJtyhW02jDV9FD0kKRi6RW8EfpdeT8qTgiTuBWiwuIYi2c39jUQlHjVcYocpGWgxi5met9EyiOUNBm54XiXsuO0HED2m5mJXcJSidZ3h0vs8lUBTyL7btX27ToFDQSagVysQLAx+Olg9peCHnuwJLXDv6j//ag7fEpY1sm7A6qDMLXxbfwCc38x37KbSHND9b0XWywsbtsFLx/2pX+xM8+qhzlNZwDDjnlJkfiJZGVuWGF7QDsSf11wVWywdVhVp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XK11Ua7Wp6MOxe3Ys9G/RX2UxhjXuqmVcsO5rBbFN1bf/yYmWS3+sXWNkWT0?=
 =?us-ascii?Q?2Y3QDnW+R5OzN7ueu3V/D1oKXLTrxKCUf7Nmw0V5zUjXBWRMcIvNiGl6ugkK?=
 =?us-ascii?Q?EAp7PvaRJFo1S1bq9tZh1vGZSVFu/WTrK2+iSzlQcQnpvtBPo2QqlTsV2Goy?=
 =?us-ascii?Q?VVfLLIx4HoLCToqwf30yrGm2jmtu8ySjYrdYhmlZdYuoUcHLoq+62zUgSgRG?=
 =?us-ascii?Q?gfztv6cTfEc8fJM7wRTEhyIVQUEg/CDqvfhU28fVC6EntOoPbGRfyeCSu8rR?=
 =?us-ascii?Q?oZO4QSdY8JPJE6MRsQNhg2D4gDcFareKZ9Phtwto+Zm2oAZvHqetFYyuF1V7?=
 =?us-ascii?Q?SXIIh5De0DKY/cQzxEXg8Yoiqn2YjLJy+GPjeBm8Xvqo7SXrjG9xOQfcUfj2?=
 =?us-ascii?Q?+3mEn9BLdbNubEutnFgKXOkyT48/hIQFqLw6pKmDOhOtiMPwBXHEvimpTEFD?=
 =?us-ascii?Q?v3XaUepbhM4Qjt/o4KgKWhhHbMdTVxu7Cl/Je4z5AJ6rZ65Q0RDIOD6vtHY4?=
 =?us-ascii?Q?7a+OobnflIvU26aMXG8d5gV5A4VDj1y24qePb4J7i/APL+rL2SHR5OaacBe3?=
 =?us-ascii?Q?+ydvy5k4vp3x5foA9eD/jB+K9ByuZbmF4eSl47ggqtv2uPV0LCwF/gmezYRH?=
 =?us-ascii?Q?LXZG56slX5mhivDof4zNTjw7vaDqkm/4d4ywnqsCk/VQTLfSHiruy/fqqF5S?=
 =?us-ascii?Q?F0bAjGopogZWojsR1utGO+IJCQ9ICb3fdzeuuziAWC1XPz9HY6S2pbKOXImz?=
 =?us-ascii?Q?1FztMmNMozZdCZ2sHfOHWIOCItY5M79OS/yq9p9ZrsjHs5DBSBG5U4UZhMES?=
 =?us-ascii?Q?2V8iQCLDpAsZ//rIkQD6IrogMeHkkYEh08IBDdUx+g5XV37fcLMJVhUpR0LB?=
 =?us-ascii?Q?RZ2gm3u6NRi+FvzK8l3OF9Jomf1jWqrPBPP+eJStaB3+dIFb0s8Tj87Ppk0g?=
 =?us-ascii?Q?e8isH5fumyrHvtwWdiccaOvRIBOf+s9RkS0YuKdRYhI+wlyvtPdYALvb+lIG?=
 =?us-ascii?Q?w/Yey0MQMgLKMZcQu9oumdw3TY0DNbAdllzabyxSpv9bDKcNJ66Wngkgpbqe?=
 =?us-ascii?Q?HPsLKr/CU8dhx3mcuxhrOJri5kDtovo2CvIhtuKn9mqrx/pKFArlQScoUI1C?=
 =?us-ascii?Q?rjYwpu58NJA5eQkw5WK/AJi+TDteO+1sbgTX38maUMSgJ+4wV/YWddCRhu8L?=
 =?us-ascii?Q?0xWhgldXBn/FhGkmu1oYFpKPYtPDRafFOz9NKSM4oJFyrFOa5qwqx1JI47PV?=
 =?us-ascii?Q?19pgfB8M9Fi6ZaWn7f+nJ2OU87/rr/6JDswTpTmgt6+YkZefvuUZ4oCrZPCn?=
 =?us-ascii?Q?d/sYSIra1jgv8Ag8aas1abyOBndK4s6gGvrcboykalnveHlnSb5XGLgXvpqv?=
 =?us-ascii?Q?zfeBy2Z5eRyUeLWByeYE3XVF8JbnGhbTDTv8CmrTFQCqWCcEGAetajWgBTYi?=
 =?us-ascii?Q?pc681Og+sbh2+Bk6BCDsCX2y96E9mpHMBv8c5EWpWLyLn0W7um3KzwXSRBl/?=
 =?us-ascii?Q?OPoMqIrRI0ok/LFz80dRfEm/Lm3oElUNDfccSbQw1VkMkcfL9XGbFQ4Gk2pE?=
 =?us-ascii?Q?FFtIfeRroKtidvGP23IBv82iJfuj2+i8PcpRQ3C/O0C60UBwWhUTyAkwWAas?=
 =?us-ascii?Q?LtBgOx7TgvfzW6/u9k8GTRT/26YcqaABTz0nN3SHZBePtbQE0jTIem8kyKTS?=
 =?us-ascii?Q?wp4JK3QKI1BgZxfdTx6po/ey6FP1s+x4oBPWd3Yrpj+gHE/O4OIT2u5Eirib?=
 =?us-ascii?Q?OtzR59qUjA=3D=3D?=
X-Exchange-RoutingPolicyChecked: whgIHmSNaIOWeA6VKMoIznTTT7KWSts3OgrfpFBIitecnzAzSINa9Ip3lJJ7Z+4sVoPRcD07fV5vEL84eHbMOBkXZgSgaXyXEZj90ig24+UXn11kUEDxy/Y6JNBi7fWGTxw+iYJezioV90HNxkYG7+uRMlTvLExoIRMYH6qyNZw9mQamohFOlIVaies5/2NasQeohXqjvf1qxUIhWQmbU9PJ+18eV4xkYCJgoPeBFHwzrKx6ViTly6eGHAnxI/c5GX4NchiojkwSxaN3uDLRt6JVQaDZYxo+lFhwZo3aRwPJVxTkU/Xv6ZpRKfVWT5Ig70CbhCSqqt6sMOIIBSAF1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6834c6-99c9-46f8-fdb2-08de95038911
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 00:12:35.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yB27rhSeG3sLgq6skZ0z0quzQCjqwcmb1zgsn1Hld97dF5tZLtlEMv40zDDMK0zEQoU35MmcgSj1vz75czv1Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

Move kvm_vcpu_map*() and kvm_vcpu_unmap() so that a subsequent refactor
can use gpa_to_gfn() without a forward declaration.

No functional change intended.

Signed-off-by: Peter Fang <peter.fang@intel.com>
---
 include/linux/kvm_host.h | 46 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4e3bea92a06b..484378cfdcc0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1382,29 +1382,6 @@ void mark_page_dirty_in_slot(struct kvm *kvm, const struct kvm_memory_slot *mems
 void mark_page_dirty(struct kvm *kvm, gfn_t gfn);
 void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn);
 
-int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
-		   bool writable);
-void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map);
-
-static inline int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn,
-			       struct kvm_host_map *map)
-{
-	return __kvm_vcpu_map(vcpu, gfn, map, true);
-}
-
-static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gfn_t gfn,
-					struct kvm_host_map *map)
-{
-	return __kvm_vcpu_map(vcpu, gfn, map, false);
-}
-
-static inline void kvm_vcpu_map_mark_dirty(struct kvm_vcpu *vcpu,
-					   struct kvm_host_map *map)
-{
-	if (kvm_vcpu_mapped(map))
-		kvm_vcpu_mark_page_dirty(vcpu, map->gfn);
-}
-
 unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *writable);
 int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data, int offset,
@@ -1916,6 +1893,29 @@ static inline hpa_t pfn_to_hpa(kvm_pfn_t pfn)
 	return (hpa_t)pfn << PAGE_SHIFT;
 }
 
+int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
+		   bool writable);
+void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map);
+
+static inline int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn,
+			       struct kvm_host_map *map)
+{
+	return __kvm_vcpu_map(vcpu, gfn, map, true);
+}
+
+static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gfn_t gfn,
+					struct kvm_host_map *map)
+{
+	return __kvm_vcpu_map(vcpu, gfn, map, false);
+}
+
+static inline void kvm_vcpu_map_mark_dirty(struct kvm_vcpu *vcpu,
+					   struct kvm_host_map *map)
+{
+	if (kvm_vcpu_mapped(map))
+		kvm_vcpu_mark_page_dirty(vcpu, map->gfn);
+}
+
 static inline bool kvm_is_gpa_in_memslot(struct kvm *kvm, gpa_t gpa)
 {
 	unsigned long hva = gfn_to_hva(kvm, gpa_to_gfn(gpa));
-- 
2.53.0


