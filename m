Return-Path: <dave@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1CC89DDFCA
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2009 04:53:04 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0GHpWJL004038
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 12:51:32 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0GHqxH5168884
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 12:52:59 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0GHq8sX026438
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 12:52:08 -0500
Subject: Re: 2.6.28-rc9 panics with crashkernel=256M while booting
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Chandru <chandru@in.ibm.com>
In-Reply-To: <200901161746.36584.chandru@in.ibm.com>
References: <200812241325.49404.chandru@in.ibm.com>
	<200901091637.24658.chandru@in.ibm.com>
	<200901151335.27649.chandru@in.ibm.com>
	<200901161746.36584.chandru@in.ibm.com>
Content-Type: text/plain
Date: Fri, 16 Jan 2009 09:52:57 -0800
Message-Id: <1232128377.27278.69.camel@nimitz>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-01-16 at 17:46 +0530, Chandru wrote:
> On Thursday 15 January 2009 13:35:27 Chandru wrote:
> > Hello Dave, From the debug console output, if there is anything you can add
> > here, pls let me know.
> 
> As we can see from the console output here,  physbase isn't page aligned when 
> the panic occurs.  So we could as well send (start_pfn << PAGE_SHIFT) to 
> reserve_bootmem_node() instead of physbase. your thoughts ?.
> 
> Also end_pfn in mark_reserved_region_for_nid() is defined as 
> 
> unsigned long end_pfn = ((physbase + size) >> PAGE_SHIFT);
> 
> Does this refer to the pfn after the area that we are interested in ?.  We have 
> atleast two fixes here,  
> 1. Limit start and end to bdata->node_min_pfn  and bdata->node_low_pfn in 
> reserve_bootmem_node() and add comments out in there that the caller of the 
> funtion should be aware of how much are they reserving. 
> 2. send (start_pfn << PAGE_SHIFT) to reserve_bootmem_node() instead of 
> physbase. 

Just looking at it, that calculation is OK.  But, there was one in your
dmesg that looked a page too long, like page 0x1001 instead of 0x1000.
I'd find out how that happened.

-- Dave
