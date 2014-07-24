Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 25C711A09AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jul 2014 01:13:21 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 24 Jul 2014 09:13:19 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 39EA73E4003D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 09:13:16 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6OFBfOj6947158
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 17:11:41 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s6OFHPKw011769
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 09:17:25 -0600
Message-ID: <53D1228A.3060204@linux.vnet.ibm.com>
Date: Thu, 24 Jul 2014 10:13:14 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Li Zhong <zhong@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/4] powerpc: start loop at section start of start in
 vmemmap_populated()
References: <1402475019-19699-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1402475019-19699-4-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1402475019-19699-4-git-send-email-zhong@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/2014 03:23 AM, Li Zhong wrote:
> vmemmap_populated() checks whether the [start, start + page_size) has valid
> pfn numbers, to know whether a vmemmap mapping has been created that includes
> this range.
> 
> Some range before end might not be checked by this loop:
>   sec11start......start11..sec11end/sec12start..end....start12..sec12end
> as the above, for start11(section 11), it checks [sec11start, sec11end), and
> loop ends as the next start(start12) is bigger than end. However,
> [sec11end/sec12start, end) is not checked here.
> 
> So before the loop, adjust the start to be the start of the section, so we don't miss ranges like the above.
> 
> After we adjust start to be the start of the section, it also means it's
> aligned with vmemmap as of the sizeof struct page, so we could use
> page_to_pfn directly in the loop.
> 
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/mm/init_64.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index 4963790..253b4b9 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -175,9 +175,10 @@ static unsigned long __meminit vmemmap_section_start(unsigned long page)
>  static int __meminit vmemmap_populated(unsigned long start, int page_size)
>  {
>  	unsigned long end = start + page_size;
> +	start = (unsigned long)(pfn_to_page(vmemmap_section_start(start)));
>  
>  	for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page)))
> -		if (pfn_valid(vmemmap_section_start(start)))
> +		if (pfn_valid(page_to_pfn((struct page *)start)))
>  			return 1;
>  
>  	return 0;
> 
