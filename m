Return-Path: <haren@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0851679A6
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 16:13:32 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k866DTdF015165
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2006 02:13:29 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k866DTBF172752
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2006 00:13:29 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k866DSpF032586
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2006 00:13:29 -0600
Message-ID: <44FE6700.8080504@us.ibm.com>
Date: Tue, 05 Sep 2006 23:13:20 -0700
From: Haren Myneni <haren@us.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH] kdump : Support kernels having 64k page size.
References: <44FE15B0.3030909@in.ibm.com>
	<1157511577.3661.7.camel@localhost.localdomain>
In-Reply-To: <1157511577.3661.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, "Sachin P. Sant" <sachinp@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:

>On Wed, 2006-09-06 at 05:56 +0530, Sachin P. Sant wrote:
>  
>
>>The following  kernel patch [ along with a patch to kexec tools posted 
>>seperately ]
>>is required to generate proper core files using kdump on ppc64.
>>    
>>
>
>Hi Sachin,
>
>Can you provide some more explanation? It's not clear to me why this is
>necessary.
>
>thanks
>
>  
>
At present we are doing the backup of 32K. Thus created one ELF PT_LOAD 
segment for this region.
But, in the case of 64K page size, second segments starts at 32K and the 
first one is not page aligned.  __ioremap() (crash_dump.c) getting 
failed if pfn = 0 which is the case for the second PT_LOAD segment.  We 
did not hit this issue for 4K page size because the the first page (32K 
backup) is copied to second kernel memory and thus referencing with the 
second kernel pfn.

Here the fix is,  backup regions size is max(PAGE_SIZE,  32K)  so that 
at least one page will be part of backup ELF segment.  Drawback here is, 
we will end up 32K more for backup for 64K page size.

It can also be fixed in copy_oldmem_page() (crash_dump.c), but first 
PT_LOAD segment is not page aligned:

if (pfn > 0)
    vaddr = __ioremap(pfn << PAGE_SHIFT, PAGE_SIZE, 0);
else
    vaddr = __va(pfn << PAGE_SHIFT);


Thanks
Haren





>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
