Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzWSQ6VBYzDr61
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 19:29:10 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5U9StqE109414
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 05:29:08 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bdjtq3aq8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 05:29:08 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 30 Jun 2017 19:29:02 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5U9SwKh4784636
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 19:28:58 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5U9Snt2010529
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 19:28:49 +1000
Subject: Re: [PATCH] powerpc/hugetlbfs: Export HPAGE_SHIFT
To: "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170630065235.752-1-oohall@gmail.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 30 Jun 2017 14:58:51 +0530
MIME-Version: 1.0
In-Reply-To: <20170630065235.752-1-oohall@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <316b2400-6be8-2772-e307-0fa6447ccaa9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2017 12:22 PM, Oliver O'Halloran wrote:
> Export it so it can be referenced inside a module.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  arch/powerpc/mm/hugetlbpage.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index ceeab69cf7fc..96293560f294 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -34,6 +34,7 @@
>  #define PAGE_SHIFT_16G	34
> 
>  unsigned int HPAGE_SHIFT;
> +EXPORT_SYMBOL(HPAGE_SHIFT);

Why would you need this in a driver ? This represents the
default HugeTLB page size.
