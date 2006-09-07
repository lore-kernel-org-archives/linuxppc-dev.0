Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0133367B75
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 10:52:11 +1000 (EST)
Subject: Re: [PATCH] kdump : Support kernels having 64k page size.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Haren Myneni <haren@us.ibm.com>
In-Reply-To: <44FE6700.8080504@us.ibm.com>
References: <44FE15B0.3030909@in.ibm.com>
	<1157511577.3661.7.camel@localhost.localdomain>
	<44FE6700.8080504@us.ibm.com>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 10:51:44 +1000
Message-Id: <1157590304.22705.267.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "Sachin P. Sant" <sachinp@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> At present we are doing the backup of 32K. Thus created one ELF PT_LOAD 
> segment for this region.
> But, in the case of 64K page size, second segments starts at 32K and the 
> first one is not page aligned.  __ioremap() (crash_dump.c) getting 
> failed if pfn = 0 which is the case for the second PT_LOAD segment.  We 
> did not hit this issue for 4K page size because the the first page (32K 
> backup) is copied to second kernel memory and thus referencing with the 
> second kernel pfn.
> 
> Here the fix is,  backup regions size is max(PAGE_SIZE,  32K)  so that 
> at least one page will be part of backup ELF segment.  Drawback here is, 
> we will end up 32K more for backup for 64K page size.

You should always do 64k regardless of the page size. I think we have
some ABI requirements here for ELF sections to be 64k aligned anyway
no ?

> It can also be fixed in copy_oldmem_page() (crash_dump.c), but first 
> PT_LOAD segment is not page aligned:
> 
> if (pfn > 0)
>     vaddr = __ioremap(pfn << PAGE_SHIFT, PAGE_SIZE, 0);
> else
>     vaddr = __va(pfn << PAGE_SHIFT);
