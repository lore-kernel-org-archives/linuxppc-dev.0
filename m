Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28esmtp02.in.ibm.com (e28smtp02.in.ibm.com [59.145.155.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 90CB3DDECE
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 18:53:14 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp02.in.ibm.com (8.13.1/8.13.1) with ESMTP id m257qtFP017177
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 13:22:55 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m257qtE51085440
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 13:22:55 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id m257qtmw026760
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 07:52:55 GMT
Message-ID: <47CE5155.5000009@linux.vnet.ibm.com>
Date: Wed, 05 Mar 2008 13:22:53 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Adam Litke <agl@us.ibm.com>
Subject: Re: [BUG] 2.6.25-rc3-mm1 kernel bug while running libhugetlbfs
References: <20080304011928.e8c82c0c.akpm@linux-foundation.org>
	<47CDA0F1.9030908@linux.vnet.ibm.com>
	<20080304115158.505f33eb.akpm@linux-foundation.org>
	<1204668089.14779.92.camel@localhost.localdomain>
In-Reply-To: <1204668089.14779.92.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	balbir@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adam Litke wrote:
> On Tue, 2008-03-04 at 11:51 -0800, Andrew Morton wrote:
>> hugetlb-correct-page-count-for-surplus-huge-pages.patch adds:
>>
>>         if (page) {
>>                 /*
>>                  * This page is now managed by the hugetlb allocator and has
>>                  * no users -- drop the buddy allocator's reference.
>>                  */
>>                 int page_count = put_page_testzero(page);
>>                 BUG_ON(page_count != 0);
>>
>>
> 
> Ugh I got bitten by put_page_testzero().  When it returns 1, the page
> count is zero (not the page count).
> 
> My initial version had a BUG_ON() with side-effects.  When a reviewer
> pointed it out, I thought I could fix the patch up on its way out the
> door.  I have self-administered my punishment.  This patch will fix it:
Hi Adam,

Thanks the patch fixes the kernel bug while running the libhugetlbfs test.

Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

> 
> Signed-off-by: Adam Litke <agl@us.ibm.com>
> 
> --- mm/hugetlb.c.orig	2008-03-04 13:36:30.000000000 -0800
> +++ mm/hugetlb.c	2008-03-04 13:39:30.000000000 -0800
> @@ -291,8 +291,8 @@ static struct page *alloc_buddy_huge_pag
>  		 * This page is now managed by the hugetlb allocator and has
>  		 * no users -- drop the buddy allocator's reference.
>  		 */
> -		int page_count = put_page_testzero(page);
> -		BUG_ON(page_count != 0);
> +		put_page_testzero(page);
> +		VM_BUG_ON(page_count(page));
>  		nid = page_to_nid(page);
>  		set_compound_page_dtor(page, free_huge_page);
>  		/*
> 


-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
