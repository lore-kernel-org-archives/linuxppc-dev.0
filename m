Return-Path: <geralds@linux.vnet.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.17.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C506B7B68
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 23:12:38 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.1/8.13.1) with ESMTP id n98CCRNk010064
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2009 12:12:27 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n98CCRw12695198
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2009 14:12:28 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n98CCQtX016360
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2009 14:12:27 +0200
Message-ID: <4ACDD71D.30809@linux.vnet.ibm.com>
Date: Thu, 08 Oct 2009 14:12:13 +0200
From: Gerald Schaefer <geralds@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2][v2] powerpc: Make the CMM memory hotplug aware
References: <20091002184458.GC4908@austin.ibm.com>
	<20091002185248.GD4908@austin.ibm.com>
In-Reply-To: <20091002185248.GD4908@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mm@kvack.org, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>
Reply-To: gerald.schaefer@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I am currently working on the s390 port for the cmm + hotplug
patch, and I'm a little confused about the memory allocation
policy, see below. Is it correct that the balloon cannot grow
into ZONE_MOVABLE, while the pages for the balloon page list
can?

Robert Jennings wrote:
> @@ -110,6 +125,9 @@ static long cmm_alloc_pages(long nr)
>  	cmm_dbg("Begin request for %ld pages\n", nr);
> 
>  	while (nr) {
> +		if (atomic_read(&hotplug_active))
> +			break;
> +
>  		addr = __get_free_page(GFP_NOIO | __GFP_NOWARN |
>  				       __GFP_NORETRY | __GFP_NOMEMALLOC);
>  		if (!addr)
> @@ -119,8 +137,10 @@ static long cmm_alloc_pages(long nr)
>  		if (!pa || pa->index >= CMM_NR_PAGES) {
>  			/* Need a new page for the page list. */
>  			spin_unlock(&cmm_lock);
> -			npa = (struct cmm_page_array *)__get_free_page(GFP_NOIO | __GFP_NOWARN |
> -								       __GFP_NORETRY | __GFP_NOMEMALLOC);
> +			npa = (struct cmm_page_array *)__get_free_page(
> +					GFP_NOIO | __GFP_NOWARN |
> +					__GFP_NORETRY | __GFP_NOMEMALLOC |
> +					__GFP_MOVABLE);
>  			if (!npa) {
>  				pr_info("%s: Can not allocate new page list\n", __func__);
>  				free_page(addr);

Why is the __GFP_MOVABLE added here, for the page list alloc, and not
above for the balloon page alloc?

--
Regards,
Gerald
