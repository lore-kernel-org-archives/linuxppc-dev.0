Return-Path: <linuxppc-dev+bounces-18475-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03769109316E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 04:58:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcVgt3Ckhz2xm3;
	Fri, 20 Mar 2026 15:58:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773982698;
	cv=pass; b=VerrrSyJeK5xQVAg3nCHt6bxMM+hC51Ksh7330tPPShhcYgzOWjTaFNeJl9/Ws/bO8apno6e2EWvlafBAk3g7z55V0rCr7SRCn3HhNDNRHGJMz9us8IeNiUdJYgZJZ+fAgi/MnJuM+DcjrvUtsjU4pKbvhNcEra2hNmfF8Omv6xvcziMvuHRHFLR+NnR3JltZBwYg1RK4uqtkZ01rikk6WpvFJp0WT37qPeQUOBHnU8HnhKJETXN1Oulyp+ISQPicuLf+4THhvn5aR2uj4r9NcMa9alXwuGd8386uxC36H/wFJwxfQ/t7bePq3dvwdyJLinKpIFfYStrkGXYR3DLfg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773982698; c=relaxed/relaxed;
	bh=8QWklbdcQQdcH/vkgnx5l0UMM9k73g91X5VyIUZ45pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QfRvibHP+XH2BELLT5krEt9jtl4CHpZJWEf9BNj9xXsKjM5HUx0QZQJAuqgg3xAVZ6BLI+DJjbFL42YXkQFdes2WTUabj+Z0vtfKLAC1tRoOQa2hp1IAalXYoB1Pm+zlvmlgIopzMclvFcdhwAOkXat+Nfg+nyXZ26AEF61EGVYbCOU6vUEkK+QCH2Zgbgu0ZvwtAKZbF7lxxOPUcOxuNr73f2L5T0UHt0evxrUL1XeNO5TJhMYGr1s94ZM22bWI6m94Pkw5OvxJbIcgz5RVZMOBlc8dJgpr7lugiajE+C62mi5LEh5oyBNtE2u0A1s9nRvjrt2kgamRP4pSADdrXg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q8XRdALR; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=apopple@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q8XRdALR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=apopple@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcVgs1NRlz2xN2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 15:58:16 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drqqoq37n/BcWYA35VP+V/OliP3+HtaqUoZTwWBq0X+aSr89E3BVtQwJQQO3iOQWgBPHO8r5DDrjvFTIoc9gcDNWlao9k4U8Btr6czjIehOu1/DmtExey4WzDFHKLSzLEakhMTM0ovAhvjTSI4tCU52utGl1Uy8uHGVJ/uNBaLIh7zwD2+nUSgzW4tKPV1MEOQESmKTovNp06CUbC3VbeVD/tANL5UT4xtjxP9T1MII3ERKsotVxeCb1iJE92R3sFYBtzaICEfW3MwpaEGfBJ6q0k0yRlnTMcGWslAJ/JBNQZ8iX46VJcEav+BWSBR9j5HTPAb9E2CuRtpRldXuGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QWklbdcQQdcH/vkgnx5l0UMM9k73g91X5VyIUZ45pw=;
 b=Ucycfvfj59aBdRTbg8WeBvQPtkyWk54kk8ylRbufalcEC8fM8NjK85ByXwitJ1NzcwJEejSBgRB9TUwVYjt3FEv/cnraqvK+NTc/rgTqJY2hy9rdU1BWDux5oWRfswT8iKzoE290H67eC1k5lE5gU0AndGdPEkPRaLf74FY/Tgma+xJHvLmSEFt8lBV0XvRUk96k3+nNTi/GmXu9mbIZWli6+PXua3n4fDePsc01mGfOlCxHhu8cu7XUATZoP/hSBB26jtPE2OqBnpunypmk06b9A2uLnojM9kvUn1HoCLWviFyfnSflhc0+2qXTYQGY3r67zl2t8N5j8y/6n1Imcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QWklbdcQQdcH/vkgnx5l0UMM9k73g91X5VyIUZ45pw=;
 b=q8XRdALRcV3RICQA/4b5f4D/Ngw7rL1ci4J8hmTrJ2oIYp08s2k9KCuWGUXnKIkP6KsWfJpco+lMWnuL165kWgn2Ft1vCmtftdgtWYkaQMmMGxQz8lSoxivMzNukLJe2lHUs0xCgS/0tDn47cpjiu2BAtRwuTVtdzhO+rUg8UnvCAhwxN6FjVTlBioB99jKrL1ywOt1RSQp4IM7ApmQMbmyEc+c3aFrzVLukkl6Q86eAWlVMJ61EeuBTt15Y7ksJYJ0VVUfmmKc7Fr1G2Pxc+BpISwWV43k1wjuZTCpTkdUTzjUosEgM2usc2B2RoWGSSSaaEdwgw56yYLqszn9B4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MN0PR12MB6221.namprd12.prod.outlook.com (2603:10b6:208:3c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 04:57:46 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 04:57:45 +0000
Date: Fri, 20 Mar 2026 15:57:40 +1100
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
Subject: Re: [PATCH v6 05/13] mm/page_vma_mapped: Add flag to
 page_vma_mapped_walk::flags to track device private pages
Message-ID: <abzSSHQUnDs_AFoz@nvdebian.thelocal>
References: <20260202113642.59295-1-jniethe@nvidia.com>
 <20260202113642.59295-6-jniethe@nvidia.com>
 <81e7bd1c-54d5-4f88-969a-685177447c51@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81e7bd1c-54d5-4f88-969a-685177447c51@kernel.org>
X-ClientProxiedBy: SY5PR01CA0124.ausprd01.prod.outlook.com
 (2603:10c6:10:246::13) To DS0PR12MB7726.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MN0PR12MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a816721-51e6-40f5-07f4-08de863d39e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|7053199007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	91RDluNrY79+kKG5qf7yKJZKKFPFDfmAawdD36qgc+Aggd1lKgAnDb0teiHLJbyd/1yBsKEUNJHkxuTDcEdpNRUK5CU13v16Vr6rdKAk7xgn3inoVN0C98REtMEhIpdG/HUY4Mnd2zlwzihzLzHGIrKIG7w4U7baRMI+Ml3X7bIQ37dvscR9hYMF2DeKIJzeGoDWIZ6EtF8P1bFy7D3KyuAI3B3QRUaKI/x7C6ef+wjotg0wud9HURRijLod+nG8xhsG7K17hXo0qsBmWUzjsS3ob7tAOfFNbHSTS3jTBltKQ1VyckFHpMyV3IfzSvcbYGR2XmSvLBlFz/wDr0KEI+VS9FU/1IghWfLyhh48joEBnaoUrsyK/asZ88g/FpDaCXB18YyDNMDmhwIqjekolCnQBSYV0aCS22gThnIAlFNAXQjyEPC+gos5B3Egn2XA5YCyeVDXuw2gB1m5VbU6s7PEcIhsb7EfMshzKFf5ppFoj2XU26GB49DTILAMFhiLez+jgagF9bzTA7L/BOZ/vIwCLdT8beozppucsVsuZqumqTCP8URloupKPUKfbADUmZTLYamLRfYKsHPJOohyzMoXkRyl+ofME0ZLs+fLpwlJaedpUljia1thEHsyTty7zGAlIqrE4LACZxUMTmctPRyELLkzL5QxydG/sW5i/bY68N1qi6Zzx20jEOUsWsSZ6ERbxJjMHlzzlg1Lm5VSpzrW6mIRENFBc74wceCh/9w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(7053199007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DSp7Q2nNCsTZQOBXApbLmr8b+CdnGV4kV1A4/xCB6dADfOAceuOrdiuQluIo?=
 =?us-ascii?Q?Fl23Er2Wt4rEKkOrpm3AyB33H/trc+kUg4r3FGgHgqV8PvHbuvamuPvEUdb9?=
 =?us-ascii?Q?atZtN6uplduzvtUOSLnvAmymxyIOWPTJEgKZDGvNOXs6H6qfZMSwWy9Q1i3B?=
 =?us-ascii?Q?EDXTPuay1/gz/7vx4VXyijnFclWh8zG1Bs4ZPuubw66nZw7Bj0QwnTiz//07?=
 =?us-ascii?Q?R7zyN1CDgaiMmexVanQnNwM/1uxdjJwIQayqpmNsd559rEnEWFQUiApNfrC+?=
 =?us-ascii?Q?W/CpDWJ8tDp+mu8Xx6Bevw2mnyMR9SeCK5KR/HzW4fnqi+qze8UAGa6mufmv?=
 =?us-ascii?Q?q94/CL17WfT2RyqpUj7lPZVCplQ5+qBDe0FaT5PuiYSNzf3h0Z95mjirhH2a?=
 =?us-ascii?Q?HQ6KpRfTp7d/YQLSvymk4QhA2ejnTAm15vJ51X8TCmPBeWTj9KQKzt8/pl6P?=
 =?us-ascii?Q?FKyFR3/JUVR2CWKo2z8hwch/nVW9cctzen5IPZcrzw75L2/O/GzVMyEfgFdL?=
 =?us-ascii?Q?4vKqV+/HGS2Q0BVtJD7a0AhPtVUEVzeQGTY/sSOUgACaaTws53LAK9UpofI/?=
 =?us-ascii?Q?bgvCT/WHip8YjCSn325/4efE3C5Q8mdN21H78ntKEvhKPHM/WkBymU0JZGIC?=
 =?us-ascii?Q?03gFvGLMsEkxTGtFpaiK8xoMv+/wHDAZIdWe8uzN0Zxg1QamBdhzAT9+xDl5?=
 =?us-ascii?Q?FLslTiLIxSdnMhbPafa3Y1FSuTr62lYx+/oJuXYajj/DmV+yWQW+XrYA2z5H?=
 =?us-ascii?Q?RbQHmpERTlS+w3MWIelzIeJPoZdRcuI7hiC0XFMjc/Xa2yAhlki5hH/HU4Q9?=
 =?us-ascii?Q?Uae0XZVeRYJGD8Fa6DYo0op/w0xRw37Jsc3BQuoLWC+4CxM4y9gXtgIqoMme?=
 =?us-ascii?Q?tUk6Dl86eA3IarruMXgjJvJkR0kGn+xqGrrI8llGPOrUIeEbDfXxAhLoewhM?=
 =?us-ascii?Q?Ro0GcELULR7F0lmufjNDzAMLkA8Rk5a7X/2e0RISZp3TaWV13M6cDyx7VGph?=
 =?us-ascii?Q?hcl45HNF3la6y8NAwFeor1s2SFQXysCka54EUdZCexw+QZyeZWYfNUMy+LRP?=
 =?us-ascii?Q?5scwViVltQ+ermXAtUOLsf+JJiTh1e+iJK8V6/UrDXOcWqEqTEZsF/4E9HaL?=
 =?us-ascii?Q?GafijPVTTKwCht+3lvcb95RNi3XbvgF+PWinY+BTsBaPZAm8Vl12qXKCi1SD?=
 =?us-ascii?Q?FEuAvHvhYb2CZS0UepFgNK+hb40hwCfVP2OOCgkO4gqqKyOok1gwtwtAuFJ8?=
 =?us-ascii?Q?NLjp6OhE11ocWZ9/HBPRPQBkx0BqLG1Ugs4jqTRGS913x/EouMcrYmEjun85?=
 =?us-ascii?Q?Cl0Fkd5hnfDqN9Q7zmas8yGKqRfNBS7o5/YsamgE7ds8JwB6JRRxdrIRJJjs?=
 =?us-ascii?Q?+oOZ6LulDYsr0azTQqcRIQt2/dG8jp2SqSDiL/lnRYCHswvyNKhF5Xpxbcho?=
 =?us-ascii?Q?Uq0HFCPgp4XPyBsdMP2Q/mF9cfuRtgxXOGoADh44eoJpOZxkLM/gi1XTorKd?=
 =?us-ascii?Q?wPgGtk//5ueDnDEkQnUMFYjKfXxgsEScnjaEgmSYizVKiQEaI5DTdaiURDlb?=
 =?us-ascii?Q?g1EmuGzcnuPvOnb5cNLhIAzCQvpV8c2a1oJeDWffjRzFKLxCspxg9t3ZXsPh?=
 =?us-ascii?Q?yJSkBLPNw2VWWm9rkT241xwfa/t+h9Vawza7zKlNIMMWMHGFA88twGqGduDA?=
 =?us-ascii?Q?ppeODTq6+tVJJHbA9jY+vAzz6xx2DQJmytVDrxxEf+RMd+H77W35sGIuVhP3?=
 =?us-ascii?Q?xnrkVTRxJw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a816721-51e6-40f5-07f4-08de863d39e9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 04:57:45.7458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAxIr6he7iu0qdGZEdaUirRs008uFr5YZAED2KTPReuw8fxZi1bXstpPBJCvFjSPx+zxdg1FKffQitXVUValPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6221

On 2026-03-07 at 02:44 +1100, "David Hildenbrand (Arm)" <david@kernel.org> wrote...
> On 2/2/26 12:36, Jordan Niethe wrote:
> > A future change will remove device private pages from the physical
> > address space. This will mean that device private pages no longer have
> > normal PFN and must be handled separately.
> > 
> > Prepare for this by adding a PVMW_DEVICE_PRIVATE flag to
> > page_vma_mapped_walk::flags. This indicates that
> > page_vma_mapped_walk::pfn contains a device private offset rather than a
> > normal pfn.
> > 
> > Once the device private pages are removed from the physical address
> > space this flag will be used to ensure a device private offset is
> > returned.
> > 
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Signed-off-by: Jordan Niethe <jniethe@nvidia.com>
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > ---
> > v1:
> >   - Update for HMM huge page support
> > v2:
> >   - Move adding device_private param to check_pmd() until final patch
> > v3:
> >   - Track device private offset in pvmw::flags instead of pvmw::pfn
> > v4:
> >   - No change
> > ---
> >  include/linux/rmap.h | 24 ++++++++++++++++++++++--
> >  mm/page_vma_mapped.c |  4 ++--
> >  mm/rmap.c            |  4 ++--
> >  mm/vmscan.c          |  2 +-
> >  4 files changed, 27 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index daa92a58585d..1b03297f13dc 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -921,6 +921,8 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
> >  #define PVMW_SYNC		(1 << 0)
> >  /* Look for migration entries rather than present PTEs */
> >  #define PVMW_MIGRATION		(1 << 1)
> > +/* pvmw::pfn is a device private offset */
> > +#define PVMW_DEVICE_PRIVATE	(1 << 2)
> >  
> >  /* Result flags */
> >  
> > @@ -939,14 +941,32 @@ struct page_vma_mapped_walk {
> >  	unsigned int flags;
> >  };
> >  
> > +static inline unsigned long page_vma_walk_flags(const struct folio *folio,
> > +						unsigned long flags)
> > +{
> > +	if (folio_is_device_private(folio))
> > +		return flags | PVMW_DEVICE_PRIVATE;
> > +	return flags;
> > +}
> > +
> > +static inline unsigned long folio_page_vma_walk_pfn(const struct folio *folio)
> > +{
> > +	return folio_pfn(folio);
> > +}
> > +
> > +static inline struct folio *page_vma_walk_pfn_to_folio(struct page_vma_mapped_walk *pvmw)
> > +{
> > +	return pfn_folio(pvmw->pfn);
> > +}
> > +
> >  #define DEFINE_FOLIO_VMA_WALK(name, _folio, _vma, _address, _flags)	\
> >  	struct page_vma_mapped_walk name = {				\
> > -		.pfn = folio_pfn(_folio),				\
> > +		.pfn = folio_page_vma_walk_pfn(_folio),			\
> >  		.nr_pages = folio_nr_pages(_folio),			\
> >  		.pgoff = folio_pgoff(_folio),				\
> >  		.vma = _vma,						\
> >  		.address = _address,					\
> > -		.flags = _flags,					\
> > +		.flags = page_vma_walk_flags(_folio, _flags),		\
> >  	}
> 
> That's all rather horrible ...
> 
> 
> I was asking myself recently, why something that is called
> "page_vma_mapped_walk" consume a pfn. It's just a horrible interface.

I don't disagree, and in fact it used to consume a page until 2aff7a4755be ("mm:
Convert page_vma_mapped_walk to work on PFNs"). If this was a page it would
basically resolve all the hackiness of this patch because we would no longer
have to pass PFN context around. So I wonder if there would be any opposition to
changing this back to taking a page?

> 
> 
> * DEFINE_FOLIO_VMA_WALK() users obviously receive a folio.
> * mm/migrate_device.c just abuses page_vma_mapped_walk() to make
>   set_pmd_migration_entry() work. But we have a folio.
> * page_mapped_in_vma() has a page/folio.
> 
> mapping_wrprotect_range_one() and pfn_mkclean_range() are the real
> issues. They all end up calling page_vma_mkclean_one(), which does not
> operate on pages/folios.
> 
> Ideally, the odd pfn case would use it's own simplified infrastructure.
> 
> 
> So, could we simply add a folio+page pointer in case we have one, and
> use that one if set, leaving leaving the pfn unset?
> 
> Then, the pfn would only be set for the
> mapping_wrprotect_range_one/pfn_mkclean_range case. I don't think
> device-private folios would ever have to mess with that.
> 
> 
> Then, you just always have a folio+page and don't even have to worry
> about the pfn?

That sounds reasonable to me. We were hesitant to add a page back to the
interface given it had been removed previously but lets try implementing this to
see what it looks like.

 - Alistair

> -- 
> Cheers,
> 
> David

