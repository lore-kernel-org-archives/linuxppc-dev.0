Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77FF606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 05:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vm7JxNoj;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=kFUIIdo8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSbYC1DpWz2xnn;
	Mon, 16 Nov 2026 16:10:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=192.198.163.11 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794805855;
	cv=pass; b=ghT/gMG+D51Wl1Vz4wpRs4AJtZZ1X28ziFuGBSpD5Bdnha5h3aWhSKt4ysLK+qhRf7GKkBRstVQIB5wfhpFs6rhY+Bwf71JbUebO00zVzDjzimnVBLFi2aX5aMO0sbh0sESwbJISwxsgD8LEQOhcA0fYJvYY241tIp4GdrvBgyKuf3N67RuU5MDtQmoTg6B/XG3g4Wwa5TsdxcbKJQ7YRuUKXDlF+ujHMKYLMfgvqYXx75l88LJlYaJINSuLaiwpnfCqiAJrtrfpAetZ7387QRmJNjOvIg9YQpcqk+pQ2p68PZrCOmRmR9HbWlPjubZL2JlcBEGIQrboN+SQNHt0Xg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794805855; c=relaxed/relaxed;
	bh=y+mqpmodbErtngp3a028GhKd0DsW4aB72L8qCGrV6DU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IpQiDMWA9klM6lurNVU+rMugP62doWW4D39fqR5QwCZ01JM/PskdzOpGiGPhAHc+l2+9kE/6iLq+B58wcWCaLjUh6ZfSIxbR5jboyj06mJGLs91h6RQ+VQRMg3xB5cnxl/pAENTdb16WkhtdRdU7ZFGxXRCRmyd0p1uUy5TI9+gS8OhCfOO+aKisQMhmJx8SwuRldNkzUD+8hKtlYoOMsWMH+wvatYDhevoeP5tqbv275v3/hNVVBpvav+rwEvGilwtMbND2QCppeQn0QgmCHFQupHjaH7dXlPN0KZdP103jxv3nWDoTn/Q1lGExWntOutsg+rC/j4jTkeaxNyoELg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vm7JxNoj; dkim=pass (1024-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=kFUIIdo8; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=philip.li@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vm7JxNoj;
	dkim=pass (1024-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=kFUIIdo8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=philip.li@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Mon, 16 Nov 2026 16:10:52 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSbY83l6sz2xjv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 16:10:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794805852; x=1826341852;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cx1DuGGV79IN2iloo1eNI3lViRT6Er9gGTOCbWukTVI=;
  b=Vm7JxNojzPbYAukuSCCwJk/0LnRloMsQQPPCYXskCxhKviqaWxL3E7/V
   4wiIeVX6vKUmy2XUT/ckuzpFiCw4zljEhqEbLpIYL31cr0ohYnWxjzlWP
   wzuz+C1cv17WQlklRYCWPyKFaaTOfABi0TgVjQ9ld2BHUC1L0Gedn7ctD
   WA9VKJpPUl0uX5bDCvcI151a8ka8UMB3u6sp4yw+64tUUrJLy9V4qyRrs
   JtyOJl6nOxEs1Gx8mFnDxowI3EJ9YufRwu8Bn0/S4FTJwkv2372XsGZJ9
   rnhOheggVUGJmvCWRlC2W3OFOLtU2h2Yl60pdZtKitSdJW+sVndrTroEo
   A==;
X-CSE-ConnectionGUID: DKn7yaEPQ7u1KZIaPCOy1g==
X-CSE-MsgGUID: W0ECLAcTS/+rKhZtKtEFzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3449841"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3449841"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 21:09:43 -0800
X-CSE-ConnectionGUID: TptoQiPLTuO7WDPB/OKtMg==
X-CSE-MsgGUID: 4L/PPeeQSNGApYP4bom5Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9781300"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 21:09:43 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 15 Nov 2026 21:09:42 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 15 Nov 2026 21:09:42 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 15 Nov 2026 21:09:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuPQAfdBCxlYi49eIFdnBOqDj6LjcHAYFITvDd20gPgziPTFJFnBj55dqK4Svogu1MG7OH45EeFidUZndHNiN+ro4tj+66riajtxxCqlCbshsSDxO3E3/a/mNqBHv/3sfIfVcfRcb/QuB7SP9lzIB8Y1gKVybh7Xgi1j4PPV7a+RAAkkhIKcRUgm2xLSbbWf1coaFgVKxjXtqkGsaTrn26Z3HpTFjAmf0ivNekGzigS8E+RVYCxbYAya9cV4TRjoRnW2bYOAsWOvO8f4GojmwrCnU2DdIj+fsJbfREE86sEo7DgRYrmXTh6vX9L+A2OTMO3aZbUEoMI4DFiO+S8tog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+mqpmodbErtngp3a028GhKd0DsW4aB72L8qCGrV6DU=;
 b=BnWwywiHHMwmFPn8AxBizdzGZkZ9V03hdqpZT5CALFP5FnO5+c52OC91SBMSPJY6ZeQWEVOtTDf7zjVgyIBeEZrFXMARbqhEiQSq083SU+Tj5bl8qG2ZCxA961D9JwsIyhNg52YijFXBzmkx1JFrhSdsMT2SwmOHmfzZzBc2WPjz2M6Y7lE6lLPGIpkoCeM7VTGMQqxVI93X+yPaSTPww1ukJUGjU6nnEjym0PYTpqFdn+IHJqeDuEkQDTZk5INTUC+bTe2/XKK/jqN7K2VqEAPT0BEE15M66CCJi63akvrAQhhBEw8bmgVmKmH6Gb8Uy4TdwSG6Gyrjdp5vXLGf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+mqpmodbErtngp3a028GhKd0DsW4aB72L8qCGrV6DU=;
 b=kFUIIdo8Y+fji7k9jDDECDujmf3S0a334czH++quw2J9c+uNJx7wXihE9M1z5H+ofysPtnbZUbE6eCDOzSOK1FlXQ0WkQSAkB8RU1zMeFF9qUgojkzHLRUE/SVu/4sXHKMmJd9gntIPqA1gV03cbHatiktpIRsd8LWfogwdnTAA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS6PR11MB362586.namprd11.prod.outlook.com (2603:10b6:8:4c4::14)
 by IA3PR11MB9400.namprd11.prod.outlook.com (2603:10b6:208:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 05:09:39 +0000
Received: from DS6PR11MB362586.namprd11.prod.outlook.com
 ([fe80::71a6:38f9:43ed:8f8a]) by DS6PR11MB362586.namprd11.prod.outlook.com
 ([fe80::71a6:38f9:43ed:8f8a%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 05:09:39 +0000
Date: Mon, 16 Nov 2026 13:09:30 +0800
From: Philip Li <philip.li@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [arnd-playground:highmem-7.4 5/6]
 arch/powerpc/mm/init_32.c:49:2: error: #error "You must adjust
 CONFIG_LOWMEM_SIZE or CONFIG_KERNEL_START"
Message-ID: <avqQCvFeWPgNnnWo@rli9-mobl>
References: <202611121726.xboRqpix-lkp@intel.com>
 <ffac8517-468b-4dd6-b354-5e63ed2b40cc@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffac8517-468b-4dd6-b354-5e63ed2b40cc@app.fastmail.com>
X-ClientProxiedBy: SI3PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::15) To DS6PR11MB362586.namprd11.prod.outlook.com
 (2603:10b6:8:4c4::14)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS6PR11MB362586:EE_|IA3PR11MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: d97bc621-5019-40bd-285b-08df439fd0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261021121427099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: bylloNtBdg2TN+PKaUpuxk/lFK5UKC33AgLVWOR+yA5j6EYPKm/xJG2FaK5JXLMcp4H+1Ny0FnO2TO8PfCmvU/HAx+ZeViGmM7G0hlYAYIZT36haTIsuvyZOd7P74F8EXuY/LeYoG7LfIC0icWYghozSQUC8Qw3fQeZmd6Zzld/rQbZgOGKSh416g6PeKhipKhVcsUQB0i1H/5TcIvOSjyNo7gIFRj1n6LA6OauTe+HlJsPI5wDXv/eoeahFg5WG4H75yXgjrSFMckdT1Z2q9xXCZuHkkwStbhNHYE2tkzryUglLQR9LP4Kz1903o6dpQRTTlQuTP7Kamnzyb3Ih/6gQ47hEMOpTgALyd90EkTpOXhb86mf/8I8tLjqLIHDFO85TTmsMz4Bk2k4/q9o5hp4xz6F1iYQMdiX/IdxK/0WvvsNNpWGkcTfzum1tskAdSgglrZQGTbY6XIdBooilY/Axuq+53jP+2LWh1wJYqUCkpsdgtfKx6XG/BhGiRcD03H1CXzWXf2YZuFjJf1+rSeY9TkJIjpC7In01oRuYyj7qtmuK/SIXXcNg7m3kWiE24dmXZmJ0TrmuFQEEt2TexjyAMvxgIcWpIX4UbNJkOPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS6PR11MB362586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wHS2PJ+HWfUtI0xIL08S1OZLoYTGqcvh6NhQO67HODYyIteD/I/lIylpoyu+?=
 =?us-ascii?Q?ZC7S5u9Ne3lcxMdyPkjb1wBfhvTMG58jnmEutSbO6CU+9Xbj+GFRMFLbpAK/?=
 =?us-ascii?Q?nD863VpTSVAdqDK4tu47EYSGSzjlNK39oBhjf6/EqmVuxoN3YscwiHsQ+lw2?=
 =?us-ascii?Q?HKz4nsbQLFYkQrbq05Pl+9E9PlOI4jQCJtFzkuq8r2gMmgNMNuInj+zrSRgH?=
 =?us-ascii?Q?6Fpb4tOfvq4G6IIUQAV8QI4atHmb3YPk1Clrc4p8zqnYeouCtmb9PbaIXN5q?=
 =?us-ascii?Q?O28ykoVD9/gKDRecSKxRKi7AroCcGIVaWgRsgMbInWwjj1Kp0Tb0maWcPw1y?=
 =?us-ascii?Q?en0rztys8v+jLLSrd1M3h/z5z0+F6HRfMir84+C9Mg9xMwzhO2mz33N1Djk4?=
 =?us-ascii?Q?ycRSNI4R8Ma7MVCtQm9ZDgsNc95wJXzc7fZcrtv7juAdUZ9/q7ZAPdnglrKW?=
 =?us-ascii?Q?3aoLAFmEe95gMxWcfIpSF0CnlUaQecd57b8bDAgE3yvK0Zlb4Ssgs2RNwAP4?=
 =?us-ascii?Q?3imyVx5VIOKcK9re3m0z8Oq+/YjGhAPDiZ1//Mzc7ES5pYzRpEFB0FdTPgVp?=
 =?us-ascii?Q?wArnDtqcK4meqqRzmvigTOVoShSFTv1qq8j15MYprCLGQ1mI2Bi0w/xY02ny?=
 =?us-ascii?Q?QCNXydYVuGrT/0OaL6KfrIQ4KnPcNF1JzwHK3GJsdmk6Ls4GZ0Pi5Ym2M0Rk?=
 =?us-ascii?Q?t7DOqxjNcS+VmKIg6UeWwsLGv3KOxacB6VhTKbC8m9ygwN1b4vPLGyVanHl8?=
 =?us-ascii?Q?xT0p9E6f/figyDYv1ZXfDJwFc2ecHfY7KGscrVW9c8YW0JNxByiTT5n4pF9x?=
 =?us-ascii?Q?V20rQEvnY9PoKhNzRMXQZkJkCwfX4TQg2EsXUQ4h1xgE7LPeUllXysaXzZBB?=
 =?us-ascii?Q?Sev/9c8peOnQ89pDEk02NadRdiYHe7K8HbWLLR5yYiLKKEXSBlHz55fSeqQp?=
 =?us-ascii?Q?s3eeaIa7UrCK3rVJs6kwt/uqWEuzP6+fm33q668uvLcwLsW0/IcoMnxS7jJm?=
 =?us-ascii?Q?xMNSNyZukKbWSseRNRhuaThTugiVvsIN91958lSA5hz1fDGyWRY76PM00NWj?=
 =?us-ascii?Q?eYmvoZTispfEovdgyn8pO9v62Yd5znaO9pebXu8/cfhSd84uwZUnzSx+QeV3?=
 =?us-ascii?Q?e5UnWDnpfL+bpBYhbglU4MQsa0/JbdJ3ZW7t/3Vdk5rUoSX/6YhAQXzIVIRG?=
 =?us-ascii?Q?5qRQ3ewa2C+kx58ECPppZc3bLO9KAVIJs8sgk7D8dCkX15rTVqId6qKn7kIf?=
 =?us-ascii?Q?+CVwEGYgWej/ET/t6xV/HbEmPesBZ9lslFMtSCZGIiyXNZ4SSyoAAXp3UkKm?=
 =?us-ascii?Q?TSCwFG4WoL7W2Yo6f2ceAaIxN70gY+ruTEgdAiA9Bdv+yIm8kdKd60qtKShP?=
 =?us-ascii?Q?wE6ym/F1JewY21Qcmnh7c7aQ0mvAwE7179avL95oR/PUrF5Qpuo8OKCAGFXw?=
 =?us-ascii?Q?rSBB4GrXRo5Cyy7ySqakslXwqGNRIx+/RW7wHoS2l/xyH54P2etVbfTJunRs?=
 =?us-ascii?Q?JHEggcyj/ODr6UsbPezylsB1pyfn1EpOIQALkDaMeKITbDnT8VhD/TjjqkoF?=
 =?us-ascii?Q?Rub/sjHU+UWVjed0mDxvkVakvw6MTQUXXNKeTWfPCxcFoJJJ2DaTVtO4O6g/?=
 =?us-ascii?Q?YuzKyk77qscTu/UTvDIr8axSIJqFXC2k6qmXKtSxVk6kY9qza8kr2zAnEgSA?=
 =?us-ascii?Q?7EqBJvXgiPsQ5znP3s8lLW8uY5v/5BmW703di3C1JRLHAXERbTiN8TDNQVH7?=
 =?us-ascii?Q?Gs3FwSPajw=3D=3D?=
X-Exchange-RoutingPolicyChecked: YWzLhxqIWxbDW7a6houtiZkmlk7P3+J4NOnAhsoSCFtN8jwwNRK65gdZnm5hKrrecxvtCe6znxEC1B4TigQ5e9rDf/9kLAFhWZTZ/WX7iPwzEuIfBpwzbPC/8DVr3gL/FavNF2cqY/O12NDOucI7cUoKvWVX1bYQWY3CQfCqzJrIkc2EF7CYW+SdenNp8B9sHwZ6bx+sjEGpUqcP8I4pb3nirmJqz26nXHR1GPcbPktz4evnb5ABUZjqYq9sUfGcLA/5E/azy0mrVZL7i+tC5x6pQ4LKf6nc3BfQsXxbt7rDYmExsslinOXWxguVYmZyhWWufTVRf+a+n0xafoWJXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d97bc621-5019-40bd-285b-08df439fd0c2
X-MS-Exchange-CrossTenant-AuthSource: DS6PR11MB362586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 05:09:39.3799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFfx1yZ0jZ7T+e43QjG6p+6f8tbEKfoWfhJRUzjc5G/OoJcK1BKNtqHR+k5dfgyB6+TT7wXFtQe58LnOw2OqQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9400
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 05:30:25PM +0100, Arnd Bergmann wrote:
> On Thu, Nov 12, 2026, at 17:13, kernel test robot wrote:
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new 
> > version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: 
> > https://lore.kernel.org/oe-kbuild-all/202611121726.xboRqpix-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >>> arch/powerpc/mm/init_32.c:49:2: error: #error "You must adjust CONFIG_LOWMEM_SIZE or CONFIG_KERNEL_START"
> >     #error "You must adjust CONFIG_LOWMEM_SIZE or CONFIG_KERNEL_START"
> >      ^~~~~
> 
> The randconfig file contains
> 
> # CONFIG_LOWMEM_SIZE_BOOL is not set
> CONFIG_LOWMEM_SIZE=0x80000000
> CONFIG_PAGE_OFFSET_BOOL=y
> CONFIG_PAGE_OFFSET=0xc0000000
> CONFIG_KERNEL_START_BOOL=y
> CONFIG_KERNEL_START=0xc0000000
> 
> which is an invalid configuration
> 
> My patch changed the defaults for both PAGE_OFFSET and LOWMEM_SIZE
> in a way that should still work:
> 
>  config LOWMEM_SIZE
>         hex "Maximum low memory size (in bytes)" if LOWMEM_SIZE_BOOL
> -       default "0x30000000"
> +       default "0x80000000" if HIGHMEM
> +       default "0x40000000"
>  
>  config PAGE_OFFSET
>         hex "Virtual address of memory base" if PAGE_OFFSET_BOOL
> -       default "0xc0000000"
> +       default "0x70000000" if HIGHMEM
> +       default "0xb0000000"
> 
> What I'm guessing happened is that the .config file was generated
> with the old defaults by running 'make randconfig' on an unpatched
> tree, but then running 'make olddefconfig' changes the default
> for LOWMEM_SIZE without changing the others.

Sorry about this false report, you are right, the randconfig is not generated
correctly as you mentioned. I will follow up to fix the bot to avoid the wrong
reports.

> 
>      Arnd
> 

