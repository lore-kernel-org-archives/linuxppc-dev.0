Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCjp73XnSzDrCy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:56:47 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6K5s9T9100752
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 01:56:45 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2btdkwt0w6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 01:56:44 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 15:56:41 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6K5ublg15073432
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:56:37 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6K5uaqE026316
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:56:37 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net,
 mingo@redhat.com, mhocko@kernel.org
Subject: Re: [RFC v6 05/62] powerpc: capture the PTE format changes in the
 dump pte report
In-Reply-To: <1500177424-13695-6-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-6-git-send-email-linuxram@us.ibm.com>
Date: Thu, 20 Jul 2017 11:26:28 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877ez3r6r7.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> The H_PAGE_F_SECOND,H_PAGE_F_GIX are not in the 64K main-PTE.
> capture these changes in the dump pte report.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/mm/dump_linuxpagetables.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
> index 44fe483..5627edd 100644
> --- a/arch/powerpc/mm/dump_linuxpagetables.c
> +++ b/arch/powerpc/mm/dump_linuxpagetables.c
> @@ -213,7 +213,7 @@ struct flag_info {
>  		.val	= H_PAGE_4K_PFN,
>  		.set	= "4K_pfn",
>  	}, {
> -#endif
> +#else /* CONFIG_PPC_64K_PAGES */
>  		.mask	= H_PAGE_F_GIX,
>  		.val	= H_PAGE_F_GIX,
>  		.set	= "f_gix",
> @@ -224,6 +224,7 @@ struct flag_info {
>  		.val	= H_PAGE_F_SECOND,
>  		.set	= "f_second",
>  	}, {
> +#endif /* CONFIG_PPC_64K_PAGES */
>  #endif
>  		.mask	= _PAGE_SPECIAL,
>  		.val	= _PAGE_SPECIAL,
> -- 
> 1.7.1
