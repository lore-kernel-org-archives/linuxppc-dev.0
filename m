Return-Path: <linuxppc-dev+bounces-18466-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D821091912
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 20:19:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcH8y2vS5z2ynn;
	Fri, 20 Mar 2026 07:19:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip="2a01:111:f403:c105::7"
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773951554;
	cv=fail; b=B2VowUXGnE8ZTqx3PEKIsAtWZdY8KTohF1S2tNLSdA6rCAbbyGA3TS81CNIL4yLxbTwDP5bj65DfoQ8rx53W3HEtobZRXsjmD/ii95AlJADdUoV2OpdST8tH0baid3ZF6a9TIzCmu3vmagZrOW79Qh1EfxPq1bFG4I6NeOn8Cq9VDqc1r/vwXaL2uqkjmb7AUNbnnmXM6JrMvwyH7/7VqaiK7IZGHJL7zx1KRRt/RQ7P8Uw0QcnpNz8TX/CI1dp27glspYD14Z9hLxMtTNKiHC5Qfd0357qzw0UvB7jOFTj75zpAjUWYL+qH+bGe8vYVjuNzMsjqNjB52wYh/otSNA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773951554; c=relaxed/relaxed;
	bh=RpPhl71vfNUCdaYAzlZ1a+wBsEryyjw7mdDbj/G/rB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qh1Su3lZ6Gma+hg/TfCCApR0vWMDsatI7h8551g2h73pC9rrjD9S/iZD19SKkA3UQ2drA+ZncEGs1rSh+yTnTVYPkhRXeZZuvDmff2dWatUDoWCvH7IfY1bSXxiW9kP/09BTaDBcxgOk0xqC6c9Z2eKyWQxiuFrvMXzDgUpn597pq09GxwdlO0GiIJKHp/DMFvE2Nf3cKNPXPN4XsqpiOIDQU973fQRuzvgGYwWOANolqK4DNoUlQGoNPm3GP4wgLo0Mwn/eTAQNX1dcOfqxZyjuMAqf6PvlIA+iKK0DWQLLxz7A87Q6Vl1Q4OEQJzM1OH1KawFitQM16w22ZPmvoA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=fail (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nX5aheu+ reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::7; helo=ch4pr04cu002.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nX5aheu+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::7; helo=ch4pr04cu002.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcH8x0rHCz2yng
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 07:19:12 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/2UeCX3IPXq4/HNdXT40x6p7S0K80ps7ZixHgeRJjLdfYCgqoaU3/s5mt3/ECY3oWIwrlFJFj2Nud4tgITd1wLgzKlALhpVoIshyJIwMXEyyYr8P2XhGaDiuqljJ8Tjkt21VkI/BYKmomT+wiNAi2WvpAefqvqIvqQVljEp5iiEF3VhnMsIgGwid19OkHyRKhqaNU8prpFVFXyJeLx9bXaY6pg8LfVGO62FLJYkT7tZSeqknElwbD0dGwQ4HOCHTTMMDeNHmMEvbw9jpdbjCeiXoSmo2nQBLXD4l4im0uMFG3n6Eh5Lc1x4raV0sxDMzOJyeMLNTmZofAhtdr2DyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYIqy4oX12FQnh7j38QB3ANTstWWixTCrYuos4D+GYo=;
 b=CUrb+6xiz2AX3LyerZE/JurgE4DKMoKpDj+5+roO8vYNQnHSnWd/W3wVonRKxtRwPmTycpj6F5nRtpzLX6+b9LlrqW+9pO7i1rirCwFmd1IelazvqSnlmMreC0mWFddnSuCtCLi7/POtWetoFXFW+ODqjO5ZMuBmhp3tBbJaIykBLOL+/USwheL+quTecdhkxFape2ACDeRdTAsHApb8IkZMVKXzH9SVBeXn8g9v2H3vxv6McX/2BjXN0lIwI2B4r5lT0+Gxsv+pBGv17itjQiNJdpDBjrDIAZ0zRhNP9Z8VsaYJKsPpimhL/LkwgxJF7GfWT4Dv9mDWyh3xjzpg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYIqy4oX12FQnh7j38QB3ANTstWWixTCrYuos4D+GYo=;
 b=nX5aheu+3vhO6J4GXqda0hsRLxcC88sNGrLiIwX+lut0I/cSStpRzX7796lxHa/dRsU9nQz0XlWwt6B6AWrP4raPZJbqU/jZ3Dn64DaPAuxBMTSw4SyR3uRM7AT1ky/yB0MCEZDhtYDmhkE1sJL4MYWmvriDYpQ/8raolp7TvdGPGfBt8NfHzXjqsKUMHcmwAP0zyroAupemKlcGGu0Feym706DBCnqqJ+Z1IrKGR444cCElLURZBkCFT3hEoq4u18qW/wG5CkGp8r+aLlcIDYc2Z6nsKWiwzNTND8QlDVQRoVS+hXk0JBAt0o5bVnmBFl1GvZdcHC+y4hIMxMWd3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Thu, 19 Mar
 2026 20:18:42 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 20:18:42 +0000
Date: Thu, 19 Mar 2026 16:18:40 -0400
From: Yury Norov <ynorov@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@linaro.org>, Moritz Fischer <mdf@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Russ Weight <russ.weight@linux.dev>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Suki K Poulose <suzuki.poulose@arm.com>, Tom Rix <trix@redhat.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Xu Yilun <yilun.xu@intel.com>, Yury Norov <yury.norov@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH RESEND 0/5] bitmap: cleanup bitmaps printing
Message-ID: <abxaIMi55N4X9JWz@yury>
References: <20260303200842.124996-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303200842.124996-1-ynorov@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0898.namprd03.prod.outlook.com
 (2603:10b6:408:13c::33) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d60a58-c56d-4ec1-9128-08de85f4b743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7416014|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	9ifa+bS4ZAzVcx4Fn3fgUuloDXL/KkhYJSCC6KZ0SMR+KbXazkGiG38G82ua5lJ8GCq2/hCJnVA3Ys/7N5h+RX0TrVW7iPOZ4k/i5681gE2cZzlgJW3E5eZpUSMEe+m6dRvcNAFeGMhZxRSoGY5CeyHp8EPLOUTZAHo2kwuepheClRkfrHVa9WIOWr4JOkaag58yJABWtULPBign+4oYdJyQhTENy54CbmmbjPpbLheSXNsvWfw6eBHFD/6HSkAb//U3BuG4VWQBl9ctKgeCotlpOiKzoBkKKAOp8GHytCWHjfj8LWaN7peB8PrF2LBkkMgiMB0uvrvRD/NDqmtx0dFmwSUHaiehb/aXEU3l6ROhD2kpKNGYgsfSihDl0PD3wG+hWIWrnJFxSEraYnRiPlvT6GunGNDoXvRYbNucDw2cH0xaw44MmbUH4nkBX/9bFCT5X44Se5XeJZW84hSiKR0xjzGae/CTQMUJgeJe+csGXz93IcTgz5lVuhXUKmNETJTVAMIuVpiedeH3r1ZtMbWLLFO5Ptnz2FfzG9567oH2BdAmEXyqnz+4Tr97zMoJAUJZI3nJ4IbcOtEHZk7o8mBUqncH2WPejqQoC/fUTJClh+RfvgEHkwkf1+p58p9//+NxifQsGORC20WgYuK7mPHKmsVd/Q5973Wg0LociVt7fDoiwVrzpGkMI+Yo5QeiYOsovtnoKWurnSU76L5kfHqlKUE4cRXPfX//1uFlKDDFUMdkAxQfS+rj14x6Qhh4CDlDSmfZ/WXz5t6Zeht1IEBOou1ZcBBGLJVPvQ+wtsI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7416014)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?NnrKG/08hXdJeOA+4271JcCi2R4ynKNDZ0UixbTr3noodKh2ODpflZgn0J?=
 =?iso-8859-1?Q?bNZ0+P4aDTt1TGn/P1ZDlOQL9+uOZKaqlR4FJ/AsucvkzvsNOUWloP+RGl?=
 =?iso-8859-1?Q?7Ej3lUiGKlopUCzNizHengLerFVc60XxTbXVfEpH7Df5SzR5QOuwirGEMf?=
 =?iso-8859-1?Q?CD4UgXhUv8OBIovDw3Ga4lEOioTcTSdQn1mAKIimvsELSDKMDAsZ3IkQx+?=
 =?iso-8859-1?Q?ndtxuPJHAtDiDthYmUIW3MCI+cMwnv1Gdm+SOCjw3U2/3bNtkewWSaL0mj?=
 =?iso-8859-1?Q?9qZudmQZvv2gQV5Y5/thmyt203OtY4MIhFJvaSsUt9hQz6JEwrlZsSu1Yb?=
 =?iso-8859-1?Q?VwPcGkSAdfiAHrxbsu1aJprX1pqub6JIVovHaSY6KA5AMQWmnAY8KKtefE?=
 =?iso-8859-1?Q?VYfDVTIJ4xxPsxa7BuWRChXmVXbUbWiVJ6ABlA8JbQvWuNQHB7MNrsK7Nf?=
 =?iso-8859-1?Q?rPTlZVLPMM4jwq2Y7ekKozS2aai46BzmZunsmoxDQ7vFp9fRc9dlgtgqfP?=
 =?iso-8859-1?Q?Y1bY3/fv7GrHG3imr77F+uKsZxX+UpkVbsXjzR5bjLwBtCosZWHJZEbaxf?=
 =?iso-8859-1?Q?ajfCnttzzuEIs8Z9Q+ulfmC08oPtjNpWvM4Y1PUEXB8jvqq8pvpQ5sblNx?=
 =?iso-8859-1?Q?NWHUg0r7h3oQvbTmP2Ti1GAaHSam9LmnP4fItCLxVy0uw+6nNo6eS1hvgt?=
 =?iso-8859-1?Q?h0nOpW+V1blYxifKPMIY1ynLmWSYZ/Uw7v9eforPLVYrSFyh9DfVFa71h4?=
 =?iso-8859-1?Q?T7/lTtbQE0MCNoT1ZyoEz0BtX3FY8jY7Hm/gZSnJv7YopjOkBkBs6DPu94?=
 =?iso-8859-1?Q?WMMp7PVe4eBk2JagExbhRAGfGAXateD1MifjkzjA0FaAkXFKwA4NIYE+vN?=
 =?iso-8859-1?Q?B/xQ+P74d20rK3Mw+u5ZNrL5rEpVALGW3fB7IKvHfMNaTj4GxAtKxYB4i0?=
 =?iso-8859-1?Q?oN7jGk0UN/am1BX31dgBvu9AJP4hTPnCVrfVHZE43zND7MPuf6G9B/2lBs?=
 =?iso-8859-1?Q?NrgEizdacjWnRUlfyXy4XjLLmitZO3PPvPgCnw94SiZ/B2B7dbuoMzJ0nO?=
 =?iso-8859-1?Q?ksGc0JKWvrCXgVyslU1SlG6ynUpnhTa/oOyHVempRevosd9wkzlQMsLm+1?=
 =?iso-8859-1?Q?MuviN6/uGP0j8R01Rzs3AtEdVVJ+YNe+r3Rb9Y0pDQ64dkdqOckZ97VhHj?=
 =?iso-8859-1?Q?eandGLDMuHBj6zAPKSOmf00mal2hjbXqXtIpFLC3qyNdEeNAyzcsnpp4/F?=
 =?iso-8859-1?Q?8cb+4ox90D1z3WWZDv/nzAVQiKuQycrwnPVh/LOpKU7B6R2dAw7ri4zgrK?=
 =?iso-8859-1?Q?V26wSMhnhUuSzlm4Urmy+A/L7qRomPj8Ke8+/DUkHVy2Q9Pc9010lgkT2J?=
 =?iso-8859-1?Q?kFcHxlQTLfUP4MqDurNIZPv3dr6K1RxCKSjSLb/I3JAJpjdRmzNZxeIJdT?=
 =?iso-8859-1?Q?qzbcqzyvQkVwNTORsi7/Dc6uq/2Wjvbi+vslhBYLoX7C5pSjqOgoxm8TwA?=
 =?iso-8859-1?Q?TBjf9R66iVR8m+mWem4yOy3jYXNDJsLyk3NBISItQRp59jkiZ91eZSzKIl?=
 =?iso-8859-1?Q?sWXuQjk//yOUIkA6g3281t9KRQDim74MoarxLM085i/HkExvPB+qdP8KPd?=
 =?iso-8859-1?Q?0RDjiq8uI8DvGDZr3Sjf66Sq8raOkINHEZ/mgIwDX3qX7rJ3/1CZ9E/IwT?=
 =?iso-8859-1?Q?kMWaTMIewxyLVvipr+We3qBS+kxyVAmlqYTLBb1rB9tSdo3//vkM+LGU6W?=
 =?iso-8859-1?Q?xTUjeDraXFi36ALVZfA5UKa+vN0kzN3nAHYa0acKAR5TpSUpcNS3KctQaY?=
 =?iso-8859-1?Q?9obJf2cdS8P8ulhieXmP2IWdqADaS9prPbBbGSHH7Wau7ljm4z4q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d60a58-c56d-4ec1-9128-08de85f4b743
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 20:18:42.7746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svT2XjmvScQEDr8DOM1F4UXulEhReJu08t33OfK/NaRFq1VQ0QHf0ooxDsQTJoPohpR4YcEk3yYu+ea5iUTOww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654

Ping?

On Tue, Mar 03, 2026 at 03:08:36PM -0500, Yury Norov wrote:
> Bitmap API has a bitmap_print_to_pagebuf() function that is intended to
> print bitmap into a human readable format, making sure that the output
> string will not get big enough to cross the current page limit.
> 
> Some drivers use this function immediately before passing the result to
> scnprintf() with no modification. This is useless because scnprintf(),
> and helpers based on it like seq_pritf() and sysfs_emit(), take care of
> not overflowing the buffer by itself, and perfectly print bitmaps with
> "%*pb[l]".
> 
> This is a resend of non-networking part of [1]. Patches #3,5 switch from
> plain scnprintf() to sysfs_emit(), as pointed out by Thomas Weißschuh.
> 
> [1] https://lore.kernel.org/all/20260219181407.290201-1-ynorov@nvidia.com/
> 
> The networking part, for reference:
> 
> https://lore.kernel.org/all/20260303185507.111841-1-ynorov@nvidia.com/
> 
> Each patch can be applied individually per corresponding subsystem.
> 
> Yury Norov (5):
>   powerpc/xive: simplify xive_spapr_debug_show()
>   thermal: intel: switch cpumask_get() to using
>     cpumask_print_to_pagebuf()
>   coresight: don't use bitmap_print_to_pagebuf()
>   lib/prime_numbers: drop temporary buffer in dump_primes()
>   fpga: m10bmc-sec: switch show_canceled_csk() to using sysfs_emit()
> 
>  arch/powerpc/sysdev/xive/spapr.c              | 12 ++-----
>  drivers/fpga/intel-m10-bmc-sec-update.c       |  3 +-
>  .../hwtracing/coresight/coresight-cti-sysfs.c | 32 ++++++++-----------
>  drivers/thermal/intel/intel_powerclamp.c      |  3 +-
>  lib/math/tests/prime_numbers_kunit.c          |  6 ++--
>  5 files changed, 21 insertions(+), 35 deletions(-)
> 
> -- 
> 2.43.0

