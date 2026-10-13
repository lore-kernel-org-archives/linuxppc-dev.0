Return-Path: <linuxppc-dev+bounces-29372-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA79ECC6B10
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:10:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3x7J15Qhz30Tf;
	Wed, 14 Oct 2026 01:10:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791900620;
	cv=fail; b=GwX5BVU9+HHu0cwv4N7aJrb8TBOj3E9ju4JPo6tZGjWRllpDg79PR7bRi46a/D90ZMDztEMqMHvq6i1yHdtQlLkavGJ8FF/2ZnNKQtjZ6nb3mwJEZwxyvdK0GLs3A+ixuYMprxef+27RByrPmOZG9wP7TqfjkwREmG93w9psXOmP7LMmvFA9+U6QVCezrwah0+FW1hFGggAT+Knk7dUuN5QVkSWIfCj06kQf2Ry9UbyYEks07n0t8JLR2C9y725sLXruhI1H6BM3nrNo7SEmET7e3b3vK9tLBCE2MEztmY2YQTJVt3uE49HLtX5P8KQDVNqbpyl42do8cDWGBvUvWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791900620; c=relaxed/relaxed;
	bh=RDZnApntZDZEkaR3/QuQ+NVmKivCF9edby+QxqsQ0UI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FtW/hwwSqwpNngCoxEX6V4N6fG5J7fUUt4AtcogxpcQvH1pDvS1PdHVfK634/Sgd+99gacmGWY/qF44nV2aPUlr/kpqK9Q/Ij0F+r9cGJC/+k6HUXc+US5Uv+eTjf2Pq1vJoCId1UAOV255vMdAK2gSdtltjjdL6kCvv/+MPuxzMI/DKFBWx31UlKwOUWJmnKhVq9dWfi97e6/GyFE8y5Yg0toepdqZbn54cdWx6ZC+62N6D2loJ0RsOpNMcpvqjHRAzTT/UIvkilywMRDVkhgSE7Q7KDOs5Q1rUxgEmPKDHJwB5WF5cPRGOqofPfVD0ktk2eW+J0JUR/Yo1kFAy1w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=egOkQX/7; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=rodrigo.vivi@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=egOkQX/7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=rodrigo.vivi@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 63 seconds by postgrey-1.37 at boromir; Wed, 14 Oct 2026 01:10:16 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3x7D75Rlz308H
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 01:10:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791900618; x=1823436618;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/PPptRWdZ5Ab82Cxr5GwM7a6IrdsLqXwviq1vJyDyXQ=;
  b=egOkQX/7lmUWIuYIL5HDz2MuWru61fJ1CNb631EKqQ5hAiRNcVcrGNjJ
   aO0zgXJ5xI5+7oIVWVRJmrfNMDMVNVqWUxukRSp83SbGI/ve9JDsTDhnt
   CspstJKvpgvqP/bh5y3yUdZGGDRfOyqK4z+ZvHfIrbxgHhK5qWbddA58u
   9WKdqhk5fa/MP2ZrbeVLYQdK1x54FxDM5QHAQWym71xdlcXkZfWCaHp0h
   XEPK+uxnB6hvIog0m366/2V4nQ3z5t6KhIp8+HMBH5SXoXP6Nx+700YBQ
   fX3VBMUO/cOwy40tGDIXNGgnUX+60YCSlNSC4TZ7eUt+Wd7yZwTMEcEld
   A==;
X-CSE-ConnectionGUID: Gjbv48q6Th6wmBWGPi37EQ==
X-CSE-MsgGUID: IHCkjGMiSS68kpkgiODLWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="729762"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="729762"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 07:08:56 -0700
X-CSE-ConnectionGUID: 72KsqCRNTFajriGjBYWVYQ==
X-CSE-MsgGUID: B1YwFK8tREKdb2yGze3srQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1177340"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 07:08:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 07:08:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 07:08:53 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 07:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sybFoqkK8o50CMZVf5hBnwe12Rcjw8OQdCL0Zpc7xvVYtHm+mxtWmasrV/h7i19cfqG1IT5jnkee23yFe1zMF9V+GTdWeJ+ccG012lnwPvLovqR+1f3+yTbuVfX3rUPc9EAUVFD3Xo/J3LbeArRLvXh4IG0nwSZHP71xTa+9KqlQYze244WXXf1d22muXNpWMTyQGoG8+S3jN6M2n+UgsuEy9uqCPAdzu0QNvY8ZaEODeWt32PzIrByJW5toyx50a8kPdP2j+wlhwmRi3edf9bgjd+5GpZG6wucAuMEouKaSp3f3pyMq8hUIhtKbeuhbUl8ee/sqjPEB57QZETrtXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rTV6bdBHnVNR7hG3nX3yUN+lUDWMEWvhFtqJNb0k4E=;
 b=hSiwO6WKCPuJ40UZGicx1hyFrlPLtNO1pAo17N8mcYethbSL1iavUlrONQT2r75fXlVVPnGZJJGTSHGOvjWwARPBMrTkAyyl5b/lZFW41yn4oLocuJ24myiScjlrPV6vi/1k5KvDRfmfpMibLHyeeQ5G1rd/g49sHg/tdMCu+dWt0SUQx8bfBjeEMmGcCsPz9tH5+GC6xg8Us3Vlx0uTP0W5vJasfCy0lTEX9U7iN144l5LejYIHsxMKleLA1CzqDaj2W7eLkG6YHdDzJbShjTwuwW5XcrTZRjMoZtsLlJhQUSVHZzljXGWyzWWpR6JPHNc2TU1Drhf0Z2s15HMn7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5)
 by CH3PR11MB901483.namprd11.prod.outlook.com (2603:10b6:610:348::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Tue, 13 Oct
 2026 14:08:50 +0000
Received: from CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8]) by CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8%7]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 14:08:50 +0000
Date: Tue, 13 Oct 2026 10:08:06 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Maciej Grochowski <Maciej.Grochowski@sony.com>, Nikolas Joshua Britton
	<nbritton@exabit.io>, Geramy Loveless <gloveless@jqluv.com>, Eric Auger
	<eauger@redhat.com>, Alexey Fomenko <alexey.fomenko@intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Richard Henderson
	<richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, "Magnus
 Lindholm" <linmag7@gmail.com>, Russell King <linux@armlinux.org.uk>, "Geert
 Uytterhoeven" <geert@linux-m68k.org>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy
 (CS GROUP)" <chleroy@kernel.org>, Yoshinori Sato
	<ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max
 Filippov <jcmvbkbc@gmail.com>, David Airlie <airlied@redhat.com>, Jani Nikula
	<jani.nikula@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
	Simona Vetter <simona@ffwll.ch>, <linux-alpha@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-mips@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-sh@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<intel-gfx@lists.freedesktop.org>, Bradley Morgan <brads@mainlining.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 3/8] PCI: Honor alignment overrides
Message-ID: <as47Rs1SN3zKRObs@intel.com>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
 <20261013130948.6231-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261013130948.6231-4-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: PN4P287CA0107.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::10) To CH3PR11MB7180.namprd11.prod.outlook.com
 (2603:10b6:610:148::5)
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
X-MS-TrafficTypeDiagnostic: CH3PR11MB7180:EE_|CH3PR11MB901483:EE_
X-MS-Office365-Filtering-Correlation-Id: 317735f5-bea6-4089-c44e-08df293380e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|18002099003|10067099003|22082099003|3023799007|4143699003|261009223027099003|260925022911599003|11063799006|260925021911599003|260925021311599003|56012099006;
X-Microsoft-Antispam-Message-Info: GvXCWXjW0VR/qcHH1lMbLxlIOm2Iv44np71/iI7hmjo2MYNOjs+1K6lG3STdVqmTDTOEui+JW/Mc1Ykuv81WKxwWlIO3GugGxkLhu/ZlCb7VGCX2vvvLrSPSNbBZ4RwxfEbHj/bZmfaNJM5bsswgRweiBRm6BO4Gy4JNnNlTWhOOAiGYyt4vT25DIF/WmC5wg/O+vAWRxMngVEG8VZycPFvWCA9mbp8i+EqvzhmVEfnTJ5Fc8Q2B+HDyjYpKChLJjBeOCIDikaRjWHfqihpNvAhy4NDDOX87KXH2uACN9mv6bTVxc/P/7gpTj/jOGpcttyOehyaVr3MeJjzKjMYafEt7jEV2EK/xbOKkk7fnq4CEloYtglJdP4Aho7K+KAy7gijY7efg7EfUkQwXhrMQG9HhvF13lj6hP1P15X8a/9S6vVZJptEK8rmhs4DK32gRMM5jmQnkwFLE/USK0bk83dNd+nu1E2n7J6GqxVHtU2DzpJa/+S093rYk8KjyB7yZRbwGYioaDvkqxAPa102eIr+xUxerNOci3ihTDLdHKQJ8uT1VDnjZHNUOHqQLQ/iAPj5N469IoAzDcH5GgvjWersn5fLZQ9tTiRk7LaHx6Ex0S6WTrybtrO77dkS8Lr40
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(3023799007)(4143699003)(261009223027099003)(260925022911599003)(11063799006)(260925021911599003)(260925021311599003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?axPnn678ilZYjxjFERui0HuZe3fXuWXi5iEV74EQ4PCzTHkJLL0sBqHgus?=
 =?iso-8859-1?Q?0bxHorXlbzptJGhR+QHr5TIwqMGd6m9e9U7oEWSI1cpG2Ev+ATmF11VxXe?=
 =?iso-8859-1?Q?tOTKyJCKLJh7jV9v5dQ3fY9FsD0QU6EFtGhD6lp7+FUeWQGy8WSzDsEu7a?=
 =?iso-8859-1?Q?stOcIj5sn1FltrSA548MW09BClr0b7g0UzmUJaX3NHwO0a5evpNeBdB4Gw?=
 =?iso-8859-1?Q?U11qaStRcUEoQtPy4ul9XQNuma268YtEWGyEFLPqUTG7OTIghuCWgHaHAk?=
 =?iso-8859-1?Q?gIYMlbgQk3o7hNmqgb1e848mBHzEmi2+N6OaXwdlpnejIcKvrPwlJl9deN?=
 =?iso-8859-1?Q?hgnJkMoBXrdkuANPGvtsbvflSDYDocwPL05mRbeeI+H/1pJmulzfEVIJ+J?=
 =?iso-8859-1?Q?3sBPDJSZZ4BKzXSFUs+3NftmnFINpJ/a7HmM4uRFwinY50gIlqOuhE1jYs?=
 =?iso-8859-1?Q?uQym+DQqC42KQ6VPkbx/iL41g5QUawmdRWAzaCb11P6zp+R8b2UQV79dVl?=
 =?iso-8859-1?Q?SMuSw2y50eydansMJlTFDTT7v2TilSaqWxXp6O4LcM1bYk/QsZsDoGm0pn?=
 =?iso-8859-1?Q?gkqwi0DIaCteIcFbZjPoPFlDRUSJtOmtITqctBsD1keKi/0m0YgP2E1JE6?=
 =?iso-8859-1?Q?hqlrjeeF80ORbB5w2SvBNEF+U8lwoZI/fy8UUGf4TFw6LiydI8Ay0x8e9O?=
 =?iso-8859-1?Q?9HBp17RXpVaJ+bdMZVTM4mNVMwx192hWTCfp8HelnbVg3Uc8j+DKwX0LMw?=
 =?iso-8859-1?Q?UfCqEROSw7nN78X/KQ/Rg5FW5Js/U3wpnESHT0ExnIbJBQe/vQCrBSHQ+6?=
 =?iso-8859-1?Q?LSjswb8fZ9viiwGlCY1JPI4hVlfqpmMn/Be8K6bgDXDNLyFmqr7rm191w6?=
 =?iso-8859-1?Q?iqsVQMZLuUQT3/x4PGSBa0OQOGf77roIq2pBUkwhvD2ECL23kOgt3cPzP8?=
 =?iso-8859-1?Q?3PPuTvjxklUof5bsv/mgISfXCRho+1cB7t/TlWgqTAS9iZqWYaF9i+aU3u?=
 =?iso-8859-1?Q?5Rz9EbxxyrvwMhPhcRtWfgqhgTF6cmSl4WBQGD+hBjhoeI90UHjtvr5Ll4?=
 =?iso-8859-1?Q?cgPNP2q+/CBG+YUzU5EUy27BmKdtZi5T9Pzkib/zBhrOG8s9kbT++yjsoB?=
 =?iso-8859-1?Q?KNTEpEVAejNrIl0wYbkZpCcyApsNiUSZQ2fdWs4iou57YlOVCSBnqjbP9y?=
 =?iso-8859-1?Q?jNQD5HbKfNlEGKAJ5y5yQf+j7TRRE6sMyTIbfzrcLCG6/3vMsy8ToVz7L1?=
 =?iso-8859-1?Q?2HEvezJc6crt6nubVanCihBuQ16LDyaudItxBvjQfxFMdFwpFaweqGiYea?=
 =?iso-8859-1?Q?+AKEuuvlc7zFi0wkm8eVSg/9OoSMWLnxfMnl4yguMop8PCy1KU8dVnCgm5?=
 =?iso-8859-1?Q?7BenbTktxcsS3kxBttcqUAC58+bUHVlbFNXm6UYjIi6C3P7tO54pi5SdOq?=
 =?iso-8859-1?Q?/vMWulax2Gh7osBRKJIQyR7uJ8idlK8Psf1a+YkYaX4YYlsiwRbzWOZ+Gb?=
 =?iso-8859-1?Q?Z0yToWeMPlRFqC1RSb/r6xGdVG/75SGmihBvBMCKknl9Lqkotw11ZrYkYj?=
 =?iso-8859-1?Q?U0NDKyIWquvqgdzc54zW3SKouI2Gz/RJx5cAAY0K124IUSBD9pTLOIjoJL?=
 =?iso-8859-1?Q?bcoJ8U5c8Gl2+05cK1iA6u0eBGZFpZR5hKx86FbHbHAOO587JOvNUiJ7Tn?=
 =?iso-8859-1?Q?29TAlIwL0BVaKiDxQ/cVN1+twT42FOKohpwDd6SpQRvZh6vR9Rb8u845NE?=
 =?iso-8859-1?Q?VISEAdS2q8AonGHLNYw7Qiqvn1DHN8EfO0OvhEkdN/+aKJTzGUCF2w/1RS?=
 =?iso-8859-1?Q?m6u0KzKC83z8cWIjBQqJhD3BcMkxPQg=3D?=
X-Exchange-RoutingPolicyChecked: LaQqN0TLac931NvHaij7r+92wV0d2n4O7FE2zQ4SzX/LdeaDPlnLW8SG6FaNIx3VONbAPS2fdqzpGjK8ht9V/k8hsXyqcxeyKHzFWJzJ3uPa1NMZ7L1ye1a+/el2HoEVbkOMaSwEkL5Ob44bISKiN6mrHGruovi4djzEX2Yas1fMG2DcL790HmY+Qek8Zoyf1pjHJ4lWPW7dnFoXTVbYSBohbH4MA3UiBgZkNjPUlswO1xBwQgqQSHwT/ngZLd1OTaAdv6EaPBSdTe0W4QpD8scLpmIziIhnRlKf/+5EURCK8z3MRICqNtidLZ57+/Rht7J6KC98rrx+zXnMmjwSfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 317735f5-bea6-4089-c44e-08df293380e9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:08:50.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fbu5XCkkuvEtrlOC7D2IE+PGJAilqFA5NQJqSkeG0TRGt57A1GhfXMmd85e+GDX7OGhHWc3+eO8WKkjd8xay6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB901483
X-OriginatorOrg: intel.com

On Tue, Oct 13, 2026 at 04:09:37PM +0300, Ilpo Järvinen wrote:
> pci=resource_alignment argument can override the default alignment for
> the resource. The remainder code introduced in the commit 9036bd0efcb6
> ("PCI: Align head space better") can move remainder space (non-aligning
> part of the size) before the aligning left edge which results in
> violating the requested alignment.
> 
> Introduce struct pci_resreq_data to hold device and user-given alignment
> to be able to honor it in pci_align_resource(). When user-given alignment
> is found, any remainder movement is skipped.
> 
> Fixes: 9036bd0efcb6 ("PCI: Align head space better")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/linux-pci/20260923133202.07DF61F000FF@smtp.kernel.org/
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> IMO, PPC rigging the user alignment override to enforce arch specific
> min alignment is mixing things wrongly. It would be more appropriate
> to do arch alignment overrides by overriding pci_resource_alignment().
> 
> Jani Nikula <jani.nikula@intel.com> did ack this with a condition that
> there is a proper review done by somebody else so I've not yet included
> his tag.
> 
> ---
>  arch/alpha/kernel/pci.c          |  3 ++-
>  arch/arm/kernel/bios32.c         |  5 +++--
>  arch/m68k/kernel/pcibios.c       |  4 ++--
>  arch/mips/pci/pci-generic.c      |  5 +++--
>  arch/mips/pci/pci-legacy.c       |  5 +++--
>  arch/parisc/kernel/pci.c         |  5 +++--
>  arch/powerpc/kernel/pci-common.c |  5 +++--
>  arch/sh/drivers/pci/pci.c        |  5 +++--
>  arch/x86/pci/i386.c              |  5 +++--
>  arch/xtensa/kernel/pci.c         |  5 +++--
>  drivers/char/agp/intel-gtt.c     |  5 ++++-
>  drivers/gpu/drm/i915/i915_gmch.c |  5 +++--

Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

>  drivers/pci/pci.c                |  5 +++--
>  drivers/pci/setup-res.c          | 19 +++++++++++++------
>  include/linux/pci.h              | 32 ++++++++++++++++++++++++++++++--
>  15 files changed, 81 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
> index 11df411b1d18..c5d725a9781f 100644
> --- a/arch/alpha/kernel/pci.c
> +++ b/arch/alpha/kernel/pci.c
> @@ -128,7 +128,8 @@ pcibios_align_resource(void *data, const struct resource *res,
>  		       const struct resource *empty_res,
>  		       resource_size_t size, resource_size_t align)
>  {
> -	struct pci_dev *dev = data;
> +	struct pci_resreq_data *rr = data;
> +	struct pci_dev *dev = rr->dev;
>  	struct pci_controller *hose = dev->sysdata;
>  	unsigned long alignto;
>  	resource_size_t start = res->start;
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index ac0e890510da..3e61826f07fb 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -564,7 +564,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				       resource_size_t size,
>  				       resource_size_t align)
>  {
> -	struct pci_dev *dev = data;
> +	struct pci_resreq_data *rr = data;
> +	struct pci_dev *dev = rr->dev;
>  	resource_size_t start = res->start;
>  	struct pci_host_bridge *host_bridge;
>  
> @@ -578,7 +579,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				start, size, align);
>  
>  	if (res->flags & IORESOURCE_MEM)
> -		return pci_align_resource(dev, res, empty_res, size, align);
> +		return pci_align_resource(rr, res, empty_res, size, align);
>  
>  	return start;
>  }
> diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
> index 7a9e60df79c5..3024408412bc 100644
> --- a/arch/m68k/kernel/pcibios.c
> +++ b/arch/m68k/kernel/pcibios.c
> @@ -31,14 +31,14 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				       resource_size_t size,
>  				       resource_size_t align)
>  {
> -	struct pci_dev *dev = data;
> +	struct pci_resreq_data *rr = data;
>  	resource_size_t start = res->start;
>  
>  	if ((res->flags & IORESOURCE_IO) && (start & 0x300))
>  		start = (start + 0x3ff) & ~0x3ff;
>  
>  	if (res->flags & IORESOURCE_MEM)
> -		return pci_align_resource(dev, res, empty_res, size, align);
> +		return pci_align_resource(rr, res, empty_res, size, align);
>  
>  	return start;
>  }
> diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
> index c2e23d0c1d77..7f3ecb91b85b 100644
> --- a/arch/mips/pci/pci-generic.c
> +++ b/arch/mips/pci/pci-generic.c
> @@ -25,7 +25,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				       const struct resource *empty_res,
>  				       resource_size_t size, resource_size_t align)
>  {
> -	struct pci_dev *dev = data;
> +	struct pci_resreq_data *rr = data;
> +	struct pci_dev *dev = rr->dev;
>  	resource_size_t start = res->start;
>  	struct pci_host_bridge *host_bridge;
>  
> @@ -39,7 +40,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				start, size, align);
>  
>  	if (res->flags & IORESOURCE_MEM)
> -		return pci_align_resource(dev, res, empty_res, size, align);
> +		return pci_align_resource(rr, res, empty_res, size, align);
>  
>  	return start;
>  }
> diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
> index dae6dafdd6e0..82d4b01db64e 100644
> --- a/arch/mips/pci/pci-legacy.c
> +++ b/arch/mips/pci/pci-legacy.c
> @@ -55,7 +55,8 @@ pcibios_align_resource(void *data, const struct resource *res,
>  		       const struct resource *empty_res,
>  		       resource_size_t size, resource_size_t align)
>  {
> -	struct pci_dev *dev = data;
> +	struct pci_resreq_data *rr = data;
> +	struct pci_dev *dev = rr->dev;
>  	struct pci_controller *hose = dev->sysdata;
>  	resource_size_t start = res->start;
>  
> @@ -70,7 +71,7 @@ pcibios_align_resource(void *data, const struct resource *res,
>  		if (start & 0x300)
>  			start = (start + 0x3ff) & ~0x3ff;
>  	} else if (res->flags & IORESOURCE_MEM) {
> -		start = pci_align_resource(dev, res, empty_res, size, align);
> +		start = pci_align_resource(rr, res, empty_res, size, align);
>  
>  		/* Make sure we start at our min on all hoses */
>  		if (start < PCIBIOS_MIN_MEM + hose->mem_resource->start)
> diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
> index 96950fe9c2b7..36a3a439f609 100644
> --- a/arch/parisc/kernel/pci.c
> +++ b/arch/parisc/kernel/pci.c
> @@ -193,7 +193,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				       resource_size_t size,
>  				       resource_size_t alignment)
>  {
> -	struct pci_dev *dev = data;
> +	struct pci_resreq_data *rr = data;
> +	struct pci_dev *dev = rr->dev;
>  	resource_size_t align, start = res->start;
>  
>  	pci_dbg(dev, "%pR: pcibios_align_resource(%lx, 0x%llx, 0x%llx)\n",
> @@ -205,7 +206,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  	if (align > alignment)
>  		start = ALIGN(start, align);
>  	else
> -		start = pci_align_resource(dev, res, empty_res, size, alignment);
> +		start = pci_align_resource(rr, res, empty_res, size, alignment);
>  
>  	return start;
>  }
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 4fc52c21fe5d..23594759cfe2 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1131,7 +1131,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				       resource_size_t size,
>  				       resource_size_t align)
>  {
> -	struct pci_dev *dev = data;
> +	struct pci_resreq_data *rr = data;
> +	struct pci_dev *dev = rr->dev;
>  	resource_size_t start = res->start;
>  
>  	if (res->flags & IORESOURCE_IO) {
> @@ -1140,7 +1141,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  		if (start & 0x300)
>  			start = (start + 0x3ff) & ~0x3ff;
>  	} else if (res->flags & IORESOURCE_MEM) {
> -		start = pci_align_resource(dev, res, empty_res, size, align);
> +		start = pci_align_resource(rr, res, empty_res, size, align);
>  	}
>  
>  	return start;
> diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
> index 878a27a1acfb..279f2770ff4b 100644
> --- a/arch/sh/drivers/pci/pci.c
> +++ b/arch/sh/drivers/pci/pci.c
> @@ -172,7 +172,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				       resource_size_t size,
>  				       resource_size_t align)
>  {
> -	struct pci_dev *dev = data;
> +	struct pci_resreq_data *rr = data;
> +	struct pci_dev *dev = rr->dev;
>  	struct pci_channel *hose = dev->sysdata;
>  	resource_size_t start = res->start;
>  
> @@ -186,7 +187,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  		if (start & 0x300)
>  			start = (start + 0x3ff) & ~0x3ff;
>  	} else if (res->flags & IORESOURCE_MEM) {
> -		start = pci_align_resource(dev, res, empty_res, size, align);
> +		start = pci_align_resource(rr, res, empty_res, size, align);
>  	}
>  
>  	return start;
> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
> index e2de26b82940..4178ae4380c2 100644
> --- a/arch/x86/pci/i386.c
> +++ b/arch/x86/pci/i386.c
> @@ -156,7 +156,8 @@ pcibios_align_resource(void *data, const struct resource *res,
>  		       const struct resource *empty_res,
>  		       resource_size_t size, resource_size_t align)
>  {
> -	struct pci_dev *dev = data;
> +	struct pci_resreq_data *rr = data;
> +	struct pci_dev *dev = rr->dev;
>  	resource_size_t start = res->start;
>  
>  	if (res->flags & IORESOURCE_IO) {
> @@ -165,7 +166,7 @@ pcibios_align_resource(void *data, const struct resource *res,
>  		if (start & 0x300)
>  			start = (start + 0x3ff) & ~0x3ff;
>  	} else if (res->flags & IORESOURCE_MEM) {
> -		start = pci_align_resource(dev, res, empty_res, size, align);
> +		start = pci_align_resource(rr, res, empty_res, size, align);
>  
>  		/* The low 1MB range is reserved for ISA cards */
>  		if (start < BIOS_END)
> diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
> index 305031551136..4e8ad4a3c9fe 100644
> --- a/arch/xtensa/kernel/pci.c
> +++ b/arch/xtensa/kernel/pci.c
> @@ -42,7 +42,8 @@ pcibios_align_resource(void *data, const struct resource *res,
>  		       const struct resource *empty_res,
>  		       resource_size_t size, resource_size_t align)
>  {
> -	struct pci_dev *dev = data;
> +	struct pci_resreq_data *rr = data;
> +	struct pci_dev *dev = rr->dev;
>  	resource_size_t start = res->start;
>  
>  	if (res->flags & IORESOURCE_IO) {
> @@ -55,7 +56,7 @@ pcibios_align_resource(void *data, const struct resource *res,
>  		if (start & 0x300)
>  			start = (start + 0x3ff) & ~0x3ff;
>  	} else if (res->flags & IORESOURCE_MEM) {
> -		start = pci_align_resource(dev, res, empty_res, size, align);
> +		start = pci_align_resource(rr, res, empty_res, size, align);
>  	}
>  
>  	return start;
> diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
> index bcc26785175d..2214347906a6 100644
> --- a/drivers/char/agp/intel-gtt.c
> +++ b/drivers/char/agp/intel-gtt.c
> @@ -1038,10 +1038,13 @@ static struct agp_memory *intel_fake_agp_alloc_by_type(size_t pg_count,
>  
>  static int intel_alloc_chipset_flush_resource(void)
>  {
> +	struct pci_resreq_data rr;
>  	int ret;
> +
> +	pci_init_pci_resreq_data(&rr, intel_private.bridge_dev);
>  	ret = pci_bus_alloc_resource(intel_private.bridge_dev->bus, &intel_private.ifp_resource, PAGE_SIZE,
>  				     PAGE_SIZE, PCIBIOS_MIN_MEM, 0,
> -				     pcibios_align_resource, intel_private.bridge_dev);
> +				     pcibios_align_resource, &rr);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/i915/i915_gmch.c b/drivers/gpu/drm/i915/i915_gmch.c
> index b0ef6ef577a3..d35097bebc0f 100644
> --- a/drivers/gpu/drm/i915/i915_gmch.c
> +++ b/drivers/gpu/drm/i915/i915_gmch.c
> @@ -38,6 +38,7 @@ static int mchbar_reg(struct drm_i915_private *i915)
>  static int
>  intel_alloc_mchbar_resource(struct drm_i915_private *i915)
>  {
> +	struct pci_resreq_data rr;
>  	u32 temp_lo, temp_hi = 0;
>  	u64 mchbar_addr;
>  	int ret;
> @@ -55,12 +56,12 @@ intel_alloc_mchbar_resource(struct drm_i915_private *i915)
>  	/* Get some space for it */
>  	i915->gmch.mch_res.name = "i915 MCHBAR";
>  	i915->gmch.mch_res.flags = IORESOURCE_MEM;
> +	pci_init_pci_resreq_data(&rr, i915->gmch.pdev);
>  	ret = pci_bus_alloc_resource(i915->gmch.pdev->bus,
>  				     &i915->gmch.mch_res,
>  				     MCHBAR_SIZE, MCHBAR_SIZE,
>  				     PCIBIOS_MIN_MEM,
> -				     0, pcibios_align_resource,
> -				     i915->gmch.pdev);
> +				     0, pcibios_align_resource, &rr);
>  	if (ret) {
>  		drm_dbg(&i915->drm, "failed bus alloc: %d\n", ret);
>  		i915->gmch.mch_res.start = 0;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..1b7a4469c6ca 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6444,8 +6444,8 @@ static DEFINE_SPINLOCK(resource_alignment_lock);
>   * RETURNS: Resource alignment if it is specified.
>   *          Zero if it is not specified.
>   */
> -static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
> -							bool *resize)
> +resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
> +						 bool *resize)
>  {
>  	int align_order, count;
>  	resource_size_t align = pcibios_default_alignment();
> @@ -6497,6 +6497,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>  	spin_unlock(&resource_alignment_lock);
>  	return align;
>  }
> +EXPORT_SYMBOL_GPL(pci_specified_resource_alignment);
>  
>  static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
>  					   resource_size_t align, bool resize)
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 376f09630a4a..441a62807719 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -265,17 +265,21 @@ resource_size_t pci_resource_alignment(const struct pci_dev *dev,
>   * before res->start if there's enough free space there. This enables
>   * tighter packing for resources.
>   */
> -resource_size_t pci_align_resource(struct pci_dev *dev,
> +resource_size_t pci_align_resource(struct pci_resreq_data *rr,
>  				   const struct resource *res,
>  				   const struct resource *empty_res,
>  				   resource_size_t size,
>  				   resource_size_t align)
>  {
> +	struct pci_dev *dev = rr->dev;
>  	resource_size_t remainder, start_addr;
>  
>  	if (!(res->flags & IORESOURCE_MEM))
>  		return res->start;
>  
> +	if (rr->user_align)
> +		return res->start;
> +
>  	if (IS_ALIGNED(size, align))
>  		return res->start;
>  
> @@ -306,18 +310,21 @@ resource_size_t __weak pcibios_align_resource(void *data,
>  					      resource_size_t size,
>  					      resource_size_t align)
>  {
> -	struct pci_dev *dev = data;
> +	struct pci_resreq_data *rr = data;
>  
> -	return pci_align_resource(dev, res, empty_res, size, align);
> +	return pci_align_resource(rr, res, empty_res, size, align);
>  }
>  
>  static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>  		int resno, resource_size_t size, resource_size_t align)
>  {
>  	struct resource *res = pci_resource_n(dev, resno);
> +	struct pci_resreq_data rr;
>  	resource_size_t min;
>  	int ret;
>  
> +	pci_init_pci_resreq_data(&rr, dev);
> +
>  	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
>  
>  	/*
> @@ -329,7 +336,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>  	 */
>  	ret = pci_bus_alloc_resource(bus, res, size, align, min,
>  				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
> -				     pcibios_align_resource, dev);
> +				     pcibios_align_resource, &rr);
>  	if (ret == 0)
>  		return 0;
>  
> @@ -341,7 +348,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>  	     (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
>  		ret = pci_bus_alloc_resource(bus, res, size, align, min,
>  					     IORESOURCE_PREFETCH,
> -					     pcibios_align_resource, dev);
> +					     pcibios_align_resource, &rr);
>  		if (ret == 0)
>  			return 0;
>  	}
> @@ -354,7 +361,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>  	 */
>  	if (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))
>  		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
> -					     pcibios_align_resource, dev);
> +					     pcibios_align_resource, &rr);
>  
>  	return ret;
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1e..ea7d75871269 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1217,12 +1217,40 @@ int __must_check pcibios_enable_device(struct pci_dev *, int mask);
>  /* Architecture-specific versions may override this (weak) */
>  char *pcibios_setup(char *str);
>  
> -/* Used only when drivers/pci/setup.c is used */
> +/* Resource assignment request handling */
> +/**
> + * struct pci_resreq_data - Data passed to pcibios_align_resource()
> + * @dev: PCI device
> + * @user_align: User provided alignment override (pci=resource_alignment param)
> + */
> +struct pci_resreq_data {
> +	struct pci_dev *dev;
> +	resource_size_t user_align;
> +};
> +
> +resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
> +						 bool *resize);
> +/*
> + * TODO: Improve PCI resource assignment interface so that callers outside PCI
> + * core do not need to know about this detail.
> + */
> +static inline void pci_init_pci_resreq_data(struct pci_resreq_data *rr,
> +					    struct pci_dev *dev)
> +{
> +	bool user_aligned;
> +
> +	memset(rr, 0, sizeof(*rr));
> +	rr->dev = dev;
> +	rr->user_align = pci_specified_resource_alignment(dev, &user_aligned);
> +	if (!user_aligned)
> +		rr->user_align = 0;
> +}
> +
>  resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				       const struct resource *empty_res,
>  				       resource_size_t size,
>  				       resource_size_t align);
> -resource_size_t pci_align_resource(struct pci_dev *dev,
> +resource_size_t pci_align_resource(struct pci_resreq_data *rr,
>  				   const struct resource *res,
>  				   const struct resource *empty_res,
>  				   resource_size_t size,
> -- 
> 2.47.3
> 

