Return-Path: <linuxppc-dev+bounces-26656-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B20C79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 08:27:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdgDJ5qkfz2xfj;
	Mon, 07 Sep 2026 18:27:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788769648;
	cv=pass; b=NjddohnOyTEk7DpBDUkanlCMFstMpjYah8DSQKbHCCgph1cmeCT6d+vTVYpHSvlgeOVcKMGCNibygZ8zn/q+1kgyDkm2Xuw02fEPIE0uMpE6KPOJfefCu4a0lu5SduaHP7eefBRZXdeamaHclD4Lua8NZwCBBs9VfMIC70zTrInMhdKRSzZHS0+V4FFGG5mtKvhaQzaXZgDtD9DFowlumHY+SN9A7en1cNdY7O7AQVmRXmXs30Y9PM9E3Mb2Rz7dApU6J/sbwkDZE2uKdYs11vJQa2AJh5wjKKW6CF4q6T6YufEJkxf2zwrQMAdEJc6mZN99g98xKrQ2jZOPG4ASUg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788769648; c=relaxed/relaxed;
	bh=2EaR0Z8O2+Ysaq5lqbG5pWfQ4iBLBBfcUvQjsY9knoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mINlRCC3lPUucO1KeryMvfhP3nRsQqQd1xGSNLv5uwziQix5DuBgwIz5W5WjKJ+tvahDa93E5xfI1sc1ysdSfzz/4V+5rPdy8exmw6VVa9fKRwwHfnbLkyDcNWenOyDCIqdMp1j2mlNmcuOhCCBfgwogLT+VPErWQ2xZReIn9PlUbKC/u0LI2T786tnIVaUmXdp7LsVQIURH1OTKhSbnFDmuQkSrM7KIEZBcECNhyoq6kdSXzfus7HGsO1X0FKJnzYHkCFKTmZIRNP+ChKeVuS79BHG5bcajv39z4f7guwrNyyyIf23+b7rk43+c6HtTB1XHOlEk/rhjVSfoI0GCoQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ImImQsO4; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ImImQsO4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdgDH2nggz2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 18:27:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1op+pjEzXo8txrs/OmxESb8R+CkzpmuIFDCH0nz5QGwM692m2au0EZSe7ff+XpMWh3xku/v0Uyc96AMiNODVSUJfLA+eVPcXXXvG8iAPtfgoTfg08wZuDd9Teu1fme8mbFEK8b8jLVqaPAplFjyPoF9dosloCdx6knMajzqL1jebLii1rAAFfPRGreJKr8XIWVk2cpyxOuBdGdQtX+EQFGKX6Ty8LCLqxdqtB5SPhrDDZ3Nw4dvDT8CGFBD4MTRNXPIXQhEuutJRVPnkHqbNWO3Avdg6Mi6y+EyLIi1GjgOreSEkJXRY5k2/GLhv2r0nsG57oNf45zQS9iRSOH8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EaR0Z8O2+Ysaq5lqbG5pWfQ4iBLBBfcUvQjsY9knoI=;
 b=R7mLYeeyLFmg7jHOJ2eEshUr2No3d8uraD3YslJqr+4JVy6A7cnBG0Ba3IVoDQAPk3xtsuDvPHyX2AdkhLjh/L3AjBAVh5Lz/j3Eg8/e+TAXFpGC77lRpB/AmzUZYuEYBxABx7XGbpBJXnYXaiiAcjDkYzCQ8H3nDjrjwfUwuvS8qDbgRXCmp1x1FoVkK0/co41jirOI+6bnOBZ/poCaE1aMGw/WF8a2SdFe6sLKtsxzLB5Qnpyl/Gsdkuga3/aVr0R45XrZIfGifQp9UjCH1iywI+DbfPmqWP+E9yIo3qL2o58DE8s0Qs8dPcP3ihofTvZbip2ghnR1iog46v4byQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EaR0Z8O2+Ysaq5lqbG5pWfQ4iBLBBfcUvQjsY9knoI=;
 b=ImImQsO4+x8dzBPy6l0y+/7JQ5jUljHhYJKs2DO/+js/hJuMjbaZKrfdqb2K39E+Iec+Dsl8rMKTAaCUZGQuZW940mwtU2kiVr8RQ0cCz24JUWr+gHdIjyqy+QI8Uj3kXVuaXjOoyhXsOmM0wT5Khp+3QmDdNca3EnIpjW57kFdWKUns8YCNc0760MUNJg2HGGCGLfbL3xXKA6FHtzG8kD+dxEcB4ccERyoRtdlh37VMeDoQwpCUVGNBnAs6LvF2N2nGdIdGSkkowrbUye+l06qGGuDNkOvh8sQkjKBsvyfPYzkYyEqC/IL8kob2AM9U/tobx0ts4+7sqecjYiSYbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by GV1PR04MB9085.eurprd04.prod.outlook.com
 (2603:10a6:150:20::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 08:27:01 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%3]) with mapi id 15.21.0382.012; Mon, 7 Sep 2026
 08:27:01 +0000
Date: Mon, 7 Sep 2026 11:26:58 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] bus: fsl-mc: fix repeated word 'for' in comment
Message-ID: <gi45nz42aqxeijwpmkz6qkreu5ek5oeejwiwqjxzppmxcjvm6p@6ap6dr75p5wq>
References: <20260904124540.7652-1-hemanth.selam@gmail.com>
 <20260904124540.7652-3-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904124540.7652-3-hemanth.selam@gmail.com>
X-ClientProxiedBy: FR0P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::19) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|GV1PR04MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfa94cd-285e-4f7d-bcbd-08df0cb9ca60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|376014|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	ycsJU25FB4FezQ/UcPVT37hioM5Cara5+s9sQ0/Sot9qFIoFVNJFuxu8YhCwpn2/gyn6IAH9hOQl9cb030z3Nq7023vssXKpcx/kzo6YylpNyhGqpb1HugvwZS07NZPM8Iao13KfkrhLA9NSnazUMKLJcjxm0rEWnypxOFXe04ExwgE3Flb7gJbTrsCBZdgD0KEyE8qH8QhmFcu+Sj4X5qKl3TNaE/QbJ5xLP0t9RiDcDNIYNp2a9Xm4hA2Du3yF5QE4EFsHiV+8T4NI3gp62Pq0c8jG1MIjppeIY5QpSrVyc4NlsADB2VOz65/zZoo51wvJLWLB1JGwi62poZAhOdjJcIKL6mXOARtGSTEAYj+ZqZlAUgSHbI0r8s6tbsbpnSMs22wIqN4FBRmT6j6eqrUB4bncahFTsworSK1VNR9sA71t76hwvUGZSIX1ReAZmHI6P2EJX0OtfV1zMlUMgPaJ0xcdw3UxHN27SsfEW5cEGb5swMPGR+m5RLgAPrLG7pOi1MYP8y5ypDXGnhv0At2YSSWCVf/MCuIJ0nagNSF8lwP8Xz9D1WmLmAwULC/zL4Hr+ah/C89skKJyAPSzqXt+hE9LWy/4xFxm2N9hp6wYvVFc/Ql6plm+aEslvLtfdNx0jXP2/ToinCtPxRyGgz55FJ/pe7vKF9aJzvAOhLI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RXwOL0ZGZpou4l2eyelkEd+pmhr849TtGxnYxXI0kXudfE1w6hauSYJpCsCQ?=
 =?us-ascii?Q?2/U7ItoUzolXYIfm2VKJmSdkVi+f8c6UmL0JEnTFATwYRfCk3XHV0s0tnskR?=
 =?us-ascii?Q?7rgW7+PWpU9ctGzikFd6qVRmMQui3J3JCGOdWWl+w7y/fXF3jfrpHmkBvI0l?=
 =?us-ascii?Q?Bt9SyVkre+9khG/7upF88zo8qbApRvc3ypzh4ad0glpBAV3xhkIHn60/yT49?=
 =?us-ascii?Q?k0vhaG5VDYhYs8S8PKaGCU9MogazKq4CHqIRMQ/fO0nNSX1L/kpar1LEssgt?=
 =?us-ascii?Q?1mMfVAkI3TceDqsgoFEcZi2QBzNc3V7wkFgDZpUZzxZklBvI9c7LBcey7rkq?=
 =?us-ascii?Q?l3LQ3rMUe3suelmcsoZ3lBnZ4lA4Cjlfpgc3EHLVc3YhnGft0SBhetVOdsVe?=
 =?us-ascii?Q?GEOjCr9cOzxtRcsF6r/4oES3ArGmMc6pDnjYF7yrZt3cASy/f3WRGe2wPcNy?=
 =?us-ascii?Q?qkml20KRJoc28xi3gr1H2aUEMIlQ8FGwonxHG91NRlRK459gbuak8d72wEe3?=
 =?us-ascii?Q?DPHripp07CZVACxla2EwZI9ygdMbRj6+OWxopmrasVH8o1SnrE4dR4vbJ7qF?=
 =?us-ascii?Q?Y2p+PptpHhTlRz4imOi9I+bZRTmMQfsw/ZjQGWY6XTapaJT3orRSm3Jx9rnh?=
 =?us-ascii?Q?V/9kuR/n6xIqcdg0+mOiD36txnCPyKexU0NxowYZvvUzTzGiPt39SxZyrChM?=
 =?us-ascii?Q?Aw7lml32mmeTReseMGG/3hgzNgffnBD9kTLLpxFd14Nrgxh+LzohZ7KSn9s0?=
 =?us-ascii?Q?QM/W1/z6px3TVhD2O9X4xb3m/l9GBhW79X5SmWz1vkfhEKnC1bIres9c7Kcv?=
 =?us-ascii?Q?SPdTqdlJ8J0LyNpTydyq2NCFBNluMkamUw/nJRnWLV/m2H9s57r9t/8FcTxX?=
 =?us-ascii?Q?UN/MneydiUwk5AcLJtyp9cImnmXl3+ZKkfOV7+d9OwniiozZACVX1/OpAzIm?=
 =?us-ascii?Q?oU8u2bO7SjC/wzi7NiiR6LxxpRMxV+WUUj16PNu611mKV/i96Cyc7B086JDu?=
 =?us-ascii?Q?4NA/oLVg7Zaf/JU/WabmQqZm3IAg0/9V4Gr6D1nvLOxrbPSjDI3n8SCX3omY?=
 =?us-ascii?Q?ue8Y3/JNoMxBGCluMMga6O46AmAjFP1oamJo9NHbIKjDodhlOM7nSS8WD2va?=
 =?us-ascii?Q?B7JGWYUx9PcHc0h96PO3RDOLHv5w7XWueS2l+U17fR0H7rY3OngyDI3Dzjtz?=
 =?us-ascii?Q?T79hQrKjtBiVjAkw9JN8fRATHYeY8gjl6+9usY0LRM7EzmkGdu9rxAQVP3BB?=
 =?us-ascii?Q?PnT5XDhb/eaN7RNUPJJfYoRVl9q3/T8FBBN48RjX+jgKKq79CG2LwnncUf6M?=
 =?us-ascii?Q?srjL4pSrsntOr9bjuB1TlvS1TLDe1WQ0YU96fhiLbmob8zBdyHvrZ+vf6DAF?=
 =?us-ascii?Q?wuEN2MZxrqiOferFU5ZsEZ0d18+HERge4EZP18BHH0T/DLsHqbluCoNwT3IX?=
 =?us-ascii?Q?djGju/z7UhbnG+0pzcN9aTyPGh4Bo81azDPqiTSN3ndkjfMVXbvKQhR0ghwV?=
 =?us-ascii?Q?UVip9iWcv3En4/xEXIw08Ra4f/atz5TFB7TBSt+mskmFzPNrQX3KsMBvJnlk?=
 =?us-ascii?Q?lMkKxVdYQ2z06siKqdspcRsNwDt/wz1gpRd3SN5myO6tK3UXk2kb9H57QEHF?=
 =?us-ascii?Q?v1cCEKrkQYW8nf9klIxJuJULaOdFxvFjKVj57F5hA+yORtcK4SeqIA9It6Nj?=
 =?us-ascii?Q?wXVsyGd8SJ4+gCS6OwFmbDwxzUEmbjBuv+nBsDQxAAiPIf8ASzpsfJq8h03K?=
 =?us-ascii?Q?ukrYyJqUlw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfa94cd-285e-4f7d-bcbd-08df0cb9ca60
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:27:01.5558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuIWqQeFgfD62LFx3E3KdxtPeiX4PQ+CPpHAA71P59H0zheoBLwRBijr35Raz9cGkg0F32obLYjPHqRd6k+egg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9085

On Fri, Sep 04, 2026 at 06:15:36PM +0530, Hemanth Selam wrote:
> Drop the second 'for', reported by checkpatch.pl as a possible repeated
> word.  Only touches a comment, no code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>


