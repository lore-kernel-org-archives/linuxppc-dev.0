Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85931B7B68
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 18:32:53 +1000 (EST)
Subject: Re: 2.6.31-git5 kernel boot hangs on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tejun Heo <tj@kernel.org>
In-Reply-To: <4ABC73C7.20403@kernel.org>
References: <4AB0D947.8010301@in.ibm.com> <4AB214C3.4040109@in.ibm.com>
	<1253185994.8375.352.camel@pasglop>	<4AB25B61.9020609@kernel.org>
	<4AB266AF.9080705@in.ibm.com> <4AB49C37.6020003@in.ibm.com>
	<4AB9DAEC.3060309@in.ibm.com> <4AB9DD8F.1040305@kernel.org>
	<4ABA2DE2.6000601@kernel.org> <4ABB269F.6020309@in.ibm.com>
	<4ABB6D33.6060706@kernel.org>  <4ABB72BD.9050905@in.ibm.com>
	<1253826309.7103.461.camel@pasglop> <4ABC376D.1020704@kernel.org>
	<4ABC6E25.7090904@in.ibm.com>  <4ABC73C7.20403@kernel.org>
Content-Type: text/plain
Date: Fri, 25 Sep 2009 18:31:45 +1000
Message-Id: <1253867505.7103.515.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-09-25 at 16:39 +0900, Tejun Heo wrote:
> Hello,
> 
> Sachin Sant wrote:
> > <4>PERCPU: chunk 1 relocating -1 -> 18 c0000000db70fb00
> > <c0000000db70fb00:c0000000db70fb00>
> > <4>PERCPU: relocated <c000000001120320:c000000001120320>
> > <4>PERCPU: chunk 1 relocating 18 -> 16 c0000000db70fb00
> > <c000000001120320:c000000001120320>
> > <4>PERCPU: relocated <c000000001120300:c000000001120300>
> > <4>PERCPU: chunk 1, alloc pages [0,1)
> > <4>PERCPU: chunk 1, map pages [0,1)
> > <4>PERCPU: map 0xd00007fffff00000, 1 pages 53544
> > <4>PERCPU: map 0xd00007fffff80000, 1 pages 53545
> > <4>PERCPU: chunk 1, will clear 4096b/unit d00007fffff00000 d00007fffff80000
> > <3>INFO: RCU detected CPU 0 stall (t=1000 jiffies)
> 
> This supports my hypothesis.  This is the first area being allocated
> from a dynamic chunk and cleared.  PFN 53544 and 53545 have been
> allocated and successfully mapped to 0xd00007fffff00000 and
> 0xd00007fffff80000 using map_kernel_range_noflush() but when those
> addresses are actually accessed, we end up with infinite faults.  The
> fault handler probably thinks that the fault has been handled
> correctly but, when the control is returned, the processor faults
> again.  Benjamin, I'm way out of my depth here, can you please help?

Definitely looks like a powerpc mm problem. I'll have a look on monday.

Cheers,
Ben.

> Oh, one more simple experiment.  Sachin, does the following patch make
> any difference?
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 69511e6..93d29eb 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2102,7 +2102,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  				     size_t align, gfp_t gfp_mask)
>  {
>  	const unsigned long vmalloc_start = ALIGN(VMALLOC_START, align);
> -	const unsigned long vmalloc_end = VMALLOC_END & ~(align - 1);
> +	//const unsigned long vmalloc_end = VMALLOC_END & ~(align - 1);
> +	const unsigned long vmalloc_end = vmalloc_start + (512 << 20);
>  	struct vmap_area **vas, *prev, *next;
>  	struct vm_struct **vms;
>  	int area, area2, last_area, term_area;
> 
> 
