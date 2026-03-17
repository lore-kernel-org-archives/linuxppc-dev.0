Return-Path: <linuxppc-dev+bounces-18283-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C396AFB5EA0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 01:47:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZZbN1FYCz2ySB;
	Tue, 17 Mar 2026 12:47:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c007::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773712064;
	cv=pass; b=OfUh3PFvugpOoEEIMSiLXrdMB4lIlGnBzyP1ywDX9OBvx1OLc1uyh4xqX5vfcmBj+epktzntA2Bvy/oWeOUvu/AaspglmVGr2wZEzsnI/LNza7BkTZz+4akVks1ypIlk8k+Yt3tD3alH6PvGQW7hb1qzoXCn3k5QrEJsWZZtFyijqTgDIIT/58i9+ER2m+LvZ2JUjOc/2jdyFQxjAz6TMopGcsqNPPvZ9QLDY1QvMkwLtNtZjcZfEvDgoaNjuoBllS8YxBnBTP8pkqK5b6B5k0KbOIHNGxt9jRVu++xJSGkYm9M61oGpOxF0A/N+xSA/UvTkxEEpK+Q/NQd7z8dyZQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773712064; c=relaxed/relaxed;
	bh=WqLFMk9+ZUg+sj9Eb/OVfR1CoLnZhCFlaQW4EVz1vbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=deqYZiC5OPuZ9iuFOv+JrCGzoQUKbrRm1+8vCRFHlsCvKuWmmz0XMBnfRmiRvgx93mGQJNxE0jaxesJSwNcrq5OoQc59JTfymmcCbiG0Fvb3iLXALtOYD0IvpDOufUTsCBnmj4yrKL4D74u0lzSfGeHTtR9aaRMPCLs1uK3Xu9wMVk63mmEpzUbcX4hC3CqWD0bB+8cuir8hjE3z8wT+WCnHK/3vI49kP6E6nNq4Esobw/1iivBx6J2/pL6iL6qqcVZqsdCtbuL1i+8m31n721dIiygmXmCm+ByAGEMld65GDHCODkKRivwG+2hloTVgou2NSqF5coelrR8tBNO4fg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lyt9MKLK; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=apopple@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lyt9MKLK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=apopple@nvidia.com; receiver=lists.ozlabs.org)
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZZbL4qv9z2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 12:47:42 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLCSvFuaS89jAko8bZFideyMrBbXdftB7VSh/AEK9v4fsj6pHTuBfCmkqR5YjsfdCXMQJAliKaQm6/cYwID9fCIezcK0uuRlQf3cMFa7xXpseXRGtWdWOPPV4qGsXiYtNqGq/QOubFyEFIS8o0yYSl23a0wKnKz4VQ4K5/rvSzTc8phZTcX2QM3X27Gch7TeAgZv7X40ncydDISQDQWg3jHkP30BKX7qVwYlq228yhtkAYxAO89817fx/9UWMjapih1bfaTDSSetH57RE+lsqCGXexiUQKesgrdwog1+W1ZFOxMJTal2AOIhnHeDBWMekFmrUcDor5EZHJjzH5vDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqLFMk9+ZUg+sj9Eb/OVfR1CoLnZhCFlaQW4EVz1vbg=;
 b=hQHJm+FxKWctn8X4H/17PbSkqk+BRQL8V4qwDO9t+4CDnxCj0wzM3I1AFYwTbynVDHchg6OR96pIsgLOnjsHP8VIML1+5C9cWJiI9M7mlFQNgb4EiRENSBcvTl2Pq8tuIjeq3vxo43sp8swj669fcrUxtFBVa1z/jUuzr5x/C5OC82r1mYCcRGBcSAgzJ60DxXHQdi/bvpRQTkeXAzA3iDOxjxxbGNI4bNoBJARYVehorNMTPcHUJ8y+tAH6DFUI92jFKHY8qW9BeSY7NdAiDnr3puTtzCBxS/8XpjRMhGtOYQWqO8Br9/5hb4bydQmvkxLgyLRZGxZE20k1oHqX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqLFMk9+ZUg+sj9Eb/OVfR1CoLnZhCFlaQW4EVz1vbg=;
 b=lyt9MKLK0v+JfgXCBoFlw77k8YHAwC8gl+qvjJHQGXwUCVFeqoCeu9l1BfJ+5wVkZ4icqpH19wZIXuZPxipwrVKc1xrWLI033QNLXHI1d66krBVP/oeyAo5GHRVIrisQmA4yMVwr/CPH8A4kwDMb52PtUCOubkxEbJWloDUPp+/zns47nzlCtrbNCwtlDrE+dgG/Hjg/lhlh7GqiTv1yiCyRqW1hUDHz5d1HUfFXXsB7pz5SksXQPbJdIWWKp1oZbcXbhRqKWO8CU2HqmKvsX118EyxNXL5uPQrbCqfAxzvevGdUuuYXjeVyZ8votvHU9h2oYQE2BqIhdhKnOdWW7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 01:47:13 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 01:47:12 +0000
Date: Tue, 17 Mar 2026 12:47:07 +1100
From: Alistair Popple <apopple@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Jordan Niethe <jniethe@nvidia.com>, linux-mm@kvack.org, 
	balbirs@nvidia.com, matthew.brost@intel.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, ziy@nvidia.com, 
	lorenzo.stoakes@oracle.com, lyude@redhat.com, dakr@kernel.org, airlied@gmail.com, 
	simona@ffwll.ch, rcampbell@nvidia.com, mpenttil@redhat.com, jgg@nvidia.com, 
	willy@infradead.org, linuxppc-dev@lists.ozlabs.org, intel-xe@lists.freedesktop.org, 
	jgg@ziepe.ca, Felix.Kuehling@amd.com, jhubbard@nvidia.com, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, ying.huang@linux.alibaba.com
Subject: Re: [PATCH v6 00/13] Remove device private pages from physical
 address space
Message-ID: <abiloqDpIs046DJJ@nvdebian.thelocal>
References: <20260202113642.59295-1-jniethe@nvidia.com>
 <4b5b222a-18e8-4d48-9acb-39e5bfe4e5f7@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b5b222a-18e8-4d48-9acb-39e5bfe4e5f7@kernel.org>
X-ClientProxiedBy: SYCPR01CA0006.ausprd01.prod.outlook.com
 (2603:10c6:10:31::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: dedbbaed-1e2f-4898-3a3f-08de83c71bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	CjDNrj2eQPB52NLcmbunxPooRt6DyWXjpm2XJzuDguL8u+eHhUY9ZvqhBE5UpTqBA+Ev/XyvmZKsYe9eUVmVjDXW0e3wM2fc4j5JIcp4Axli1PvusQyfBwjlURHXIdjSJeIYe85BZ/aQ/baIKGVvYuw7mGhidMpVVATqrYB0qyuFjWIhpVxeimVSj6M8PbTKs9YKDc2vpSieZcc8j+CUueec/8LvsO4hwE4AVP5slc6stz38BZ2lm0/TRmWD7ePExFVVAODScich/zMQoOlWsJ/3hJ7axc6apaZG1pNuw14Qq/nDPme674hho1hil40p1YYneDW7TCvNN8FcE7wLTZbUmidvTbnCieOtqLx4sE6hjQfwgFi1Z+Or4CTeCPaahBAmJ43EUCbahb8/HmFijceU7c4Hij/BOXIH3h0C7TUrwwLY5wi0jcAc6H7nra9XM3v5B21ATK5d1ycfciz8arNy/Ux23ZXgm9yLsPlQL+nSL8thJJWPfwXFFbcFqQBPYklmwYRWrcgdU4Idsm+p1oaxsah7dViNAfeQgD5+YmTH3QwVf7Mn7JhZYh9EZYyGujkzeLhuEgHF/DppL8Sk/gt+vc9t/PYzIhQpBkMX+3xMgrJuGU+7OqmGwJP6vYjE2z/1afeptIxshFItOizrlZIeV+1SAiaJO4CvEoFqcLfWXIR2mIiArwbmS3mZLgVu0jH3vqQHoE9+Uem011CbG/39RnM86IF5JLt99h49kKc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z2EEBSRYrvMoLVMk0fLBhZukIfBlXVFBBhT5KqOzb1kXtyDkQKDK09bMp0Hg?=
 =?us-ascii?Q?7Fo5IDU1l8wNjzptJ5Aq3wSy3+Fhwxyz8TURTCWf+HpRd4bOP1nt1YFmAA6m?=
 =?us-ascii?Q?dewdk9tKFQ+njJBWxJYew0RY+f5eKowXGZhxDaVaJTqrtXbfgbQedKhfPBGa?=
 =?us-ascii?Q?p98U1hOrLc5Q5/hQnCptWtNFeRJaqHdzh4fyNNoQGDXhCWdEtjmQRPDLGs7Z?=
 =?us-ascii?Q?QArKT9rYtCJrIKkOBdlg9LXoQtyUFQrW9DwRr/J9+zTTKIq+KfUGv5IXk2Tf?=
 =?us-ascii?Q?NaOlc+MDZI3IKLzAOd7BU8sUiN6iZxTxPbjnk7LaDjt4qxFfbFhnxcaeWW9c?=
 =?us-ascii?Q?7erMNxJiWO3cXJ9/SE8KLLlJL2Rv/7YkLR+9zU4G6SOmkT4+U+CpUxaEMuJW?=
 =?us-ascii?Q?Fpft7OhjvEsZiKpm3um15MQlfLcf9Jk3siWITMSkecvtq++hMkCoEQ9l0Pzt?=
 =?us-ascii?Q?pZF0PmaGhPBwBvN8/DOErqIXsmdou2dwzlUrPq7C/4wiLRg8zDfVgG7aNGHJ?=
 =?us-ascii?Q?HaTRHRasCh53Oz9K8UQ82apQXrrnkHWy/Wm11auCtBMIieHGhX0jf0AOiWgQ?=
 =?us-ascii?Q?i5hzgFWJheIIuXqah8CokpUEMPvD+/MrkwTKMJektGLt8vTjbAHrPHe5ElWh?=
 =?us-ascii?Q?y4uR2Xv7xOqs9nIMb4kMOjlNccUL2IYYZs7MwMZFrYGDS6giDfw8z1mFjl5r?=
 =?us-ascii?Q?9o6OgchmYTCxZMMsLpE8K2uETbmCGg2GcLGpXAHrfCZaGlKH4hWlsYhIurf6?=
 =?us-ascii?Q?UVCTcN/0vQxiJq7QuehiJ67aNpQh59aFazi6PBS7LJ+gDoJIGH87FHqyO2l/?=
 =?us-ascii?Q?JD0yv7Ph/5PDGoMky/2F8WRWy7lh4tMz5iRdzP4b9JyDCZepMZREEaDmBlPp?=
 =?us-ascii?Q?4I3585oNrNuIOgLKy60AErm0jaudGRiDStOszPON2nWXw+ChaNk0MvPfYrEz?=
 =?us-ascii?Q?BG169Wbkk9zENl1vzqw3ebIeNC+kflC+/98KxUZ9OdsTznTK6FEsBZhnCfNC?=
 =?us-ascii?Q?cERv4qluRTE17dPMI8FjYbvZM37M8zdDSbFXcO42aEJ3t4/pA8oIT/A11YF5?=
 =?us-ascii?Q?DuFnjVVFzrKcgIz+iXmLKTLqkVxUrioX4FOa2IJcq7RomhjDODqVF3HmPcLE?=
 =?us-ascii?Q?JTezTkyd5StBEPLBxW9AsU+teFwNI2HJaBA5qLvOqZ5YrK7Tnm1A9vD0bvgo?=
 =?us-ascii?Q?A7hNaSR+BjBHKUPIgZpEhAtM3huIs+VyPa034t37rpe0Ucj0DilS+AnNmtcE?=
 =?us-ascii?Q?yNcSGdpKTKWmY6ceZq99J/hywxrxpSdotKc6x6fn4NlG1Vz2gi/Cy67dXAVJ?=
 =?us-ascii?Q?Qu2iShz4wR/0ShHy53/iihfKfSnDrZ/OdkBCfdGxy8sqYFqq5cjiX4orQtzE?=
 =?us-ascii?Q?ejgpFlHvC3hOup2+bf28fWFtof6m1vFuJbPQcrDHJFaSjiyAyWc49PFcTrnJ?=
 =?us-ascii?Q?mF08J99ERZ/iajRlPwAr3CAileU553r5E7Jm23/rBRx3R5jCy/SeA4UEmS7o?=
 =?us-ascii?Q?yyc6G1LD/r9L3LKfn0hkYlcwY9am/THkSacl3u9zeJaVfwQy71qVtebgl4Jf?=
 =?us-ascii?Q?p5nZ175NeORg1NjDW56jJZB6/U29eQfSWtivTSMnZxoMKDYDZ5en67p/+WDd?=
 =?us-ascii?Q?FFE4lbmQtbWdEsK1dSWc18TaBc0R6pc/Quvh5vk4kovDJQVAbExYv2LGn95W?=
 =?us-ascii?Q?7/bpK6dlsBluipYikNBQOYY90qtuTSWbzTR97a1HePk0qeWsC8sH1GjCCZwg?=
 =?us-ascii?Q?0Q3t+VaKoQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedbbaed-1e2f-4898-3a3f-08de83c71bed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 01:47:12.8096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBSjYxjZlePcVzj5bdncuIz3kU08oO3AxlKIRVIwuGGjaJQQRBfIVTNrXFhbOxHEkYXrIY7CgmkpHBLwigxZ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211

On 2026-03-07 at 03:16 +1100, "David Hildenbrand (Arm)" <david@kernel.org> wrote...
> On 2/2/26 12:36, Jordan Niethe wrote:
> > Introduction
> > ------------
> > 
> > The existing design of device private memory imposes limitations which
> > render it non functional for certain systems and configurations where
> > the physical address space is limited. 
> > 
> > Limited available address space
> > -------------------------------
> > 
> > Device private memory is implemented by first reserving a region of the
> > physical address space. This is a problem. The physical address space is
> > not a resource that is directly under the kernel's control. Availability
> > of suitable physical address space is constrained by the underlying
> > hardware and firmware and may not always be available. 
> > 
> > Device private memory assumes that it will be able to reserve a device
> > memory sized chunk of physical address space. However, there is nothing
> > guaranteeing that this will succeed, and there a number of factors that
> > increase the likelihood of failure. We need to consider what else may
> > exist in the physical address space. It is observed that certain VM
> > configurations place very large PCI windows immediately after RAM. Large
> > enough that there is no physical address space available at all for
> > device private memory. This is more likely to occur on 43 bit physical
> > width systems which have less physical address space.
> > 
> > The fundamental issue is the physical address space is not a resource
> > the kernel can rely on being to allocate from at will.  
> > 
> > New implementation
> > ------------------
> > 
> > This series changes device private memory so that it does not require
> > allocation of physical address space and these problems are avoided.
> > Instead of using the physical address space, we introduce a "device
> > private address space" and allocate from there.
> > 
> > A consequence of placing the device private pages outside of the
> > physical address space is that they no longer have a PFN. However, it is
> > still necessary to be able to look up a corresponding device private
> > page from a device private PTE entry, which means that we still require
> > some way to index into this device private address space. Instead of a
> > PFN, device private pages use an offset into this device private address
> > space to look up device private struct pages.
> > 
> > The problem that then needs to be addressed is how to avoid confusing
> > these device private offsets with PFNs. It is the limited usage
> > of the device private pages themselves which make this possible. A
> > device private page is only used for userspace mappings, we do not need
> > to be concerned with them being used within the mm more broadly. This
> > means that the only way that the core kernel looks up these pages is via
> > the page table, where their PTE already indicates if they refer to a
> > device private page via their swap type, e.g.  SWP_DEVICE_WRITE. We can
> > use this information to determine if the PTE contains a PFN which should
> > be looked up in the page map, or a device private offset which should be
> > looked up elsewhere.
> > 
> > This applies when we are creating PTE entries for device private pages -
> > because they have their own type there are already must be handled
> > separately, so it is a small step to convert them to a device private
> > PFN now too.
> > 
> > The first part of the series updates callers where device private
> > offsets might now be encountered to track this extra state.
> > 
> > The last patch contains the bulk of the work where we change how we
> > convert between device private pages to device private offsets and then
> > use a new interface for allocating device private pages without the need
> > for reserving physical address space.
> > 
> > By removing the device private pages from the physical address space,
> > this series also opens up the possibility to moving away from tracking
> > device private memory using struct pages in the future. This is
> > desirable as on systems with large amounts of memory these device
> > private struct pages use a signifiant amount of memory and take a
> > significant amount of time to initialize.
> 
> I now went through all of the patches (skimming a bit over some parts
> that need splitting or rework).

Thanks David for taking the time to do a thorough review. I will let Jordan
respond to most of the comments but wanted to add some of my own as I helped
with the initial idea.

> In general, a noble goal and a reasonable approach.
> 
> But I get the sense that we are just hacking in yet another zone-device
> thing. This series certainly makes core-mm more complicated. I provided
> some inputs on how to make some things less hacky, and will provide
> further input as you move forward.

I disagree - this isn't hacking in another/new zone-device thing it is cleaning
up/reworking a pre-existing zone-device thing (DEVICE_PRIVATE pages). My initial
hope was it wouldn't actually involve too much churn on the core-mm side.

It seems that didn't work quite as well as hoped as there are a few places in
core-mm where we use raw pfns without actually accessing them rather than using
the page/folio. Notably page_vma_mapped in patch 5.

But overall this is about replacing pfn_to_page()/page_to_pfn() with
device-private specific variants, as callers *must* already know when they
are dealing with a device-private pfn and treat it specially today (whether
explicitly or implicitly). Callers/callees already can't just treat a
device-private pfn normally as accessing the pfn will cause machine checks and
the associated page is a zone-device page so doesn't behave like a normal struct
page.

> We really have to minimize the impact, otherwise we'll just keep
> breaking stuff all the time when we forget a single test for
> device-private pages in one magical path.

As noted above this is already the case - all paths whether explicitly or
implicitly (or just fogotten ... hard to tell) need to consider device-private
pages and possibly treat them differently. Even today some magical path that
somehow gets a device-private pfn/page and tries to use it as a normal page/pfn
will probably break as they don't actually correspond to physical addresses that
actually exist and the struct pages are special.

So any core-mm churn is really just making this more explicit, but this series
doesn't add any new requirements.

My bigger aim here is to use this as a stepping stone to removing device-private
pages as they just contain a bunch of redundant information from a device driver
perspective that introduces a lot of metadata management overhead.

> I am not 100% sure how much the additional tests for device-private
> pages all over the place will cost us. At least it can get compiled out,
> but most distros will just always have it compiled in.

I didn't notice too many extra checks outside of the migration entry path. But
if perf is a concern there I think we could move those checks to device-private
specific paths. From memory Jordan did this more as a convenience. Will go look
a bit deeper for any other checks we might have added.

 - Alistair

> -- 
> Cheers,
> 
> David

