Return-Path: <linuxppc-dev+bounces-20246-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB03FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 18:05:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4pJ45N9Fz2xld;
	Wed, 29 Apr 2026 04:05:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip="2a01:111:f403:c107::9"
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777399524;
	cv=fail; b=RISwLmEyArZVpJZVdmO+Bu9opT15bjQqDLLnEDW6YOz7QedYeXAjnMQX6x2X3a4GkwY63kALSQ+ph+h2kaBwP/C5wfTh2IarCJKsy0+7daWqVDU4DDRaIlz0z75hDKHIPuetwD+Qr+/bHu1jlQBQd6MnLuPXckHxBl2g+5ODah53EdOtFx1CmLVfTrLnadn4ILdH4WtR4PuuJmbdl0qlZzAQ4It8943tAQPKYR59XFeCY9QBSNBlLA/mkW/IBWLmN7Ax4NGVIzlxwuCTfGk6yEx1ctuo/rcV/CYyniXdDdKmojakR7vcymRwSkllPfZ23movaR77vcmc6+oNfjAONQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777399524; c=relaxed/relaxed;
	bh=stA1zz+3qOh+ct2j2+jQrqVLURNdHeafsVy9WK67QbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e+TfejNgAYew2MgFCucaYJWtHfCDGe/v88fUv4/rBuN+JHNdLb88BAO15bZd6yISaMcxGvI/u1Kj+r/N3URGYDLo7QSaVrgYIzcD9+eW6ELeAeHWO9wNVuwELs/mBJKv1D/7TzLDDgLOCTGkoYgBpqe1u9b9EpyM2F38Rryfy9wOQ6nNys9MGD11fJEoeSBDRknZGVc2kt/jkwzOW2j4Jq5g27L8GYK4la8sRUQoL+M1cE8lxzNyFnm2r0Kfb4qFd9CCWtXlXLfxC/QMZtl14zKJH8aaJjuejoGCwlH3RyUC+pY3zewJSax0dkZbsTO0HrBghjcsG3USnsdcKlS9Rw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=fail (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E84snSgf reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::9; helo=ph7pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E84snSgf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::9; helo=ph7pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170100009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4pJ251S1z2xSG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 04:05:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dy9PVcc0zmJpaYvB6rTq+tLYM8AZfafCvAC7yK7mqEReOnsIZYKT0GLDAZjVxlHc/7Hb651Ft/z1pMEF0ynhlDcwTGvZDu9QBuAm2hbt++8E/eYCJSd5tc7/lrqXoayfHu/r8ouVDn/rtwCpam+bi1s5+QzuXfZDEGyPwgNOUT0VEu3u9fSIpN3Mh8n3ZveNIEP6gZU5bNhwCln8yLqHtyosCP0rTWvhYAdpUUF1vkQuOAkp5omzMaPdBpMvabgV6P0KGRUC2nZs+0fm8FSD/Z99YoxoK3hyWMiXvmsJuzxxz+V4NY1ViD1htYz0KIN4+jMJHbDhcmJ9Vdv8HS5GlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6YPPnSzY//1FVVn+RyM7J5i+tae13KYJmQT59I2Hig=;
 b=Asc/ohQ+A4YvGGSVtRhl4rvVIb+1e5A3N78tYxjyw0RgsmmDnhVlbj7HPx5sqZC66N2jncwArsmGlnvptCR5833+rS7P7q92n5A7D9p08iO3C8W3Arx1Qr9Qy03VaSoDTLcymXrNOxl2sTIqOYHbwRgChInc9MJ9PsMd5XfUQQKSDXsXtLgt6T2YKICUcIPlkMoxWLH7PGOmPjfxLsjfkNaMB3Jn+gydYt85AQ6b/hSZEcB+FSO8qGYeIitX03NENA1RGwIte5lbCDM2zRyautu1tdMwY3SaGzrKTl2P3ynlQFEbuTMGC13l0JVctBjNb/YBnPfIIMJbFJv0V9YNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6YPPnSzY//1FVVn+RyM7J5i+tae13KYJmQT59I2Hig=;
 b=E84snSgflsoM7MIO5ceQ4lFc2NY5NFLYZHfGXhzwpjW5LEBw9Q7rxVNB4zHrwPS69OI1YYqQzwcDq5xRRfAx42YIXIjv6oaba5IB9t7EkVouamDXjc/fIZfEpcowtE8LoFiGpxEAChbKdtfDyLJYvNKjULqjt01ntorQ4PbFDGlOE0dyB+5rPgoFkb+YHxnjgD4J89ZBjpx2yyWJhYjy913qj3mZmg5c4ejkWE5gXmQmoDFVMqm+TwssERvmAios4parFHPQeW3ScTyWiBK+jMHV12/VrGOlElUoGYCxOq6swB11H9cgup/Il8wRdG2m+bCH7dh7kZS8+iL2ikfFng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 18:04:48 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 18:04:48 +0000
Date: Tue, 28 Apr 2026 14:04:42 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
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
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5/5] fpga: m10bmc-sec: switch show_canceled_csk() to
 using sysfs_emit()
Message-ID: <afD2ujUS70i5imxx@yury>
References: <20260303200842.124996-1-ynorov@nvidia.com>
 <20260303200842.124996-6-ynorov@nvidia.com>
 <acJWNRb1t96yu/H6@yilunxu-OptiPlex-7050>
 <acLaDFuCzt0d33Q_@yury>
 <acON/EU/GFvxRO1e@yilunxu-OptiPlex-7050>
 <afAh1hq_mkRN3q2t@yury>
 <afAqkfe8iOU1cUyQ@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afAqkfe8iOU1cUyQ@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
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
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: f165711d-6d53-40a7-4280-08dea550a2ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	T84yhglTKx18RheGcca2YqehnA4RTW8H6qLTlJyhYKc2zn4bGZXay/x9+k9kYBLL1QFgqWKunaO9lP1iJTk4sdwCpkWFGhT2XleKp9p00KUNv4mFxu9iyu2hz6JXSx9mcCME3ssiR/olU5xzrSpVDqkCzcIckZGul+M5rIwYxe3cqcbw0T/d8LPvxj/KlEz58VmzS1JqM4lW5QheFTD2oBYJS4TmOj246HxpIZa8T+fKvtwxEi1upKmBd/CWMXiVrzVKrD7u3tikU9ZzWPM0EZO1Tnl7twfKyiroqzgJWTtxMxA5Z00lW68WpskR+jNGcHy/gzzSe2vcmldFfBpPJAs30HlcIZ/RfguQYHoQ+X2HOqZ2zZVqZExXwgcksy26t2G2gy9i+kB/8X7TKbyiBEDP97zFyR3MfZ5EKA72tczt274fxcgW+eJS6h5vJZU4B+JQ8rO5UrHmn3iaNkLv5pe8EcUla+5KWXdkvl11YmH5dVgDpS7Im5ogt3952GzFsFiNVjMQQ3aFyDxjOlYX5iG8utwk+Ix8jAr60T18uCMADazBj1VbbkI42O/KDaq/RLQhTUcdnG+l5rtjOUst2OmX8QGKj/zk6alfwsBFhYEqAiE+wS7jtFVyKUha2mBeSchDoYHfYcL4jZfdQ2W5Ixj1nm2h3qIS2srCxsddR4JPMkc8b3Fyygl3ZWZl3FHtmWyGT0I+0TYfvIZOInBvmyKgre4QER3IP8rpJZFhtnE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?dgyHCkfLWy+tLHvzledMQ0rn08RsXP3vHeN/mK5+8M4d6GEIfCwiZ9utWo?=
 =?iso-8859-1?Q?suscRTHtLo/Zh/t1s3PD4wS7gFxDp9dLn2GDuVXDkJ15wdLVp++pSARLrj?=
 =?iso-8859-1?Q?CbIu2slBcykrw4IWp8FAadBxctEyFoCkwUv+mrMCSdRCWuduNN4mPcun/w?=
 =?iso-8859-1?Q?gjk9sU6AZShuMdieCHfx2UsX8d5LqGOr8Wdfye8ffysiVFVVXRkewRj38j?=
 =?iso-8859-1?Q?VL0kZRAAsEUGIrIyXhm+ej0I2CImiWRI6ae+Cr5KXHbnLiqtuzFiqqv+k9?=
 =?iso-8859-1?Q?mYm3PSWIGL8iIoCNtYENNF/K0fOFohLQy4o1nQ7/zrEplluhdKLCZj6Kxn?=
 =?iso-8859-1?Q?ro5OwNOh4hCiNCStyvem5i4l9/VIcvWrYrheb6zdodanUAv28uy+23BUDq?=
 =?iso-8859-1?Q?CwYQLVvJcLA6Csn/z+P2AI4G8P+PiLAbZiN7QIN1u8qYphOfsLDB7AVMQP?=
 =?iso-8859-1?Q?QO0FFzyoI3D8N39LolsMLC39fo0SUDppjbgfXDypw3sA2ooxsw/AMQCwv5?=
 =?iso-8859-1?Q?KdRSZADso5/fjROxyzcAgJtrcLkgYhdZ6H64FbKnhaeWe0CTY2PE6NJx7v?=
 =?iso-8859-1?Q?H4EAxbmUD6g39HhjOlDXttkGlxSgX5EhOkvHtLKEltFdzt2P9Y38YR1dG8?=
 =?iso-8859-1?Q?QaaDLdxoZLgpnUAgxSDgCbVZQzxNNvdXvlATSmfdSnry/Kxsn7G7vQkU7P?=
 =?iso-8859-1?Q?9+O2cglxGHaRHV0/or7CNu2t5T5J+muYN3xVYyDUxOUkBn4YY7ySwRyZKh?=
 =?iso-8859-1?Q?14N9lI84bPDAK14t9EDHmZbgn3zVcBO9S5fENRL0cuHyrG+FnnaIdDgaV/?=
 =?iso-8859-1?Q?eog8PGX+NQIs2tNrZYuDlEJe872TuqSCaGkd0KbgHZUyK49gitmhqWgCnL?=
 =?iso-8859-1?Q?sLrsAAMS9ZxiPVrDJcNrLbFBreFQiyNSM9AMGdhU06U/g/Y+NqGMSxlHmC?=
 =?iso-8859-1?Q?VCoQQZehVjwDUL1RRg4N0qjEw6HOhttZQD438bohD1hDxQMzskUY7xRfnn?=
 =?iso-8859-1?Q?LC5lOre0u2mJwmYaWBpH48ldLDWgEpRLIyLQvhtRfTI+izSGcThKocKK7N?=
 =?iso-8859-1?Q?5tpFbvDucGbWPJb4CvlJfK6123G9D9K8Gp3AQFTUQm0O5ipNNdq2krhMFZ?=
 =?iso-8859-1?Q?emAXhYBO4i3YNulwtLdkNyPreZnaPk3mNJx/YzjG1EXNPoK02zQ3SocVkh?=
 =?iso-8859-1?Q?tjJpGmNgBd9ZpipX23KQd7li8M3/dEeFdWxclccJruxqqOVa2pej1e1adH?=
 =?iso-8859-1?Q?000KEttfqTyStpDXO1XyMXsnf/SysKG7170CmUfTJ1ssDP6sdIMh41dDk2?=
 =?iso-8859-1?Q?Y7IQuUKtvWnVts5wJ11LrGYKFNCC07LZvjcqG+4pW7S52M7FTknhHeXTRz?=
 =?iso-8859-1?Q?Y04+hlTZXVO29mdYCJFS+Igdy6aZK0+1StdOIYlCv8ZWnhkIbNImcCtx0L?=
 =?iso-8859-1?Q?XEYvr5Ue9Xe3qgRG7QRBN+0wz1AHqKpm+m50MV/WBdc1xGAVF/2JaLlxJG?=
 =?iso-8859-1?Q?JFumVhNBkDfeF9yxyeabe5dh5LWnVRbYh2Tc4LUZUqZMosfHAOkw1q6zeh?=
 =?iso-8859-1?Q?EObu646DgZ1QDnZ285NuXTFhsxKM9YpOJZQAxOkXj6QBE6VKzPQnPpbcZD?=
 =?iso-8859-1?Q?fQiaJnsQ4Kdo5u3UdWRv7qAd3I7M10PEoTiSZYcaMcEOSqckaelfBNXK6b?=
 =?iso-8859-1?Q?6FSGLXTW4wBj7IRmPBpTMnneQPMfrr1di4BdBlIy8VkKoi86LglLmrqkkW?=
 =?iso-8859-1?Q?EtJcROUY9xgocH7JlS7EGS0YidobZx7o9Vvzqy+r9WUVtGaulyQLoEkkC9?=
 =?iso-8859-1?Q?dTrjsN10YG4lRHiSVW1I1Ez63USNI5e96Q4egmAxo9NuS9nN7H0M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f165711d-6d53-40a7-4280-08dea550a2ca
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 18:04:48.2162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKk0hB2p1W3ZB15gif5oJ+jpGSVsXrxRdGPredfZqIX4N5iscXf7AOQQAklmuAO/1QV481h2a4sz6VvrP6F02A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802

On Tue, Apr 28, 2026 at 11:33:37AM +0800, Xu Yilun wrote:
> On Mon, Apr 27, 2026 at 10:56:22PM -0400, Yury Norov wrote:
> > On Wed, Mar 25, 2026 at 03:25:48PM +0800, Xu Yilun wrote:
> > > On Tue, Mar 24, 2026 at 02:38:04PM -0400, Yury Norov wrote:
> > > > On Tue, Mar 24, 2026 at 05:15:33PM +0800, Xu Yilun wrote:
> > > > > On Tue, Mar 03, 2026 at 03:08:41PM -0500, Yury Norov wrote:
> > > > > > Switch show_canceled_csk() to use the proper sysfs_emit("%*pbl").
> > > > > > 
> > > > > > Reviewed-by: Russ Weight <russ.weight@linux.dev>
> > > > > > Suggested-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > > > > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > > > > > ---
> > > > > >  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > > > index 10f678b9ed36..ae364c6636eb 100644
> > > > > > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > > > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > > > @@ -10,6 +10,7 @@
> > > > > >  #include <linux/firmware.h>
> > > > > >  #include <linux/mfd/intel-m10-bmc.h>
> > > > > >  #include <linux/mod_devicetable.h>
> > > > > > +#include <linux/mm.h>
> > > > > 
> > > > > Why add this header file?
> > > > 
> > > > When I was preparing the series, I had build issues without this. But
> > > > now I checked it against -rc5, and it's clean. Would you like me to
> > > > resend?
> > > 
> > > No need. Given that I'll pick this patch alone to fpga for-next with the
> > > fix.
> > > 
> > > Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> > 
> > Hi Xu,
> > 
> > This patch is still not applied. This is the last non-lib user of
> 
> I see it is already in v7.1-rc1, what's your expectation?

Oops, sorry. It's me not moving on the tip of the tree.
Sorry for the noise.


