Return-Path: <mohan@in.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2789867B6D
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 15:59:33 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAH4xVhf029532
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 23:59:31 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAH4wGXv538694
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 21:58:16 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAH4wFkn013179
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 21:58:15 -0700
Date: Fri, 17 Nov 2006 10:27:39 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [RFC] Fix for interrupt distribution
Message-ID: <20061117045739.GA22383@in.ibm.com>
References: <20061030180446.GA24307@in.ibm.com>
	<20061030181751.GI17168@localdomain>
	<20061031110515.GB7884@in.ibm.com>
	<20061106224603.GG6848@localdomain>
	<20061116125637.GB13004@in.ibm.com>
	<20061116153616.GA670@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061116153616.GA670@krispykreme>
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	fastboot@lists.osdl.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 17, 2006 at 02:36:16AM +1100, Anton Blanchard wrote:
> 
> Hi,
> 
> Thanks for fixing this problem. One thing I noticed in the patch:
> 
> > +	np = cpuid_to_of_node(boot_cpuid);
> > +	BUG_ON(!np);
> > +	ireg = get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
> > +	hcpuid = get_hard_smp_processor_id(boot_cpuid);
> > +
> > +	if (ireg[0] == hcpuid)
> > +		default_distrib_server = ireg[1];
> > +	else
> > +		default_distrib_server = ireg[3];
> 
> While this will work on current firmware it would be more robust to loop
> through interrupt-gserver#s until you find your cpuid. For example we
> set up multiple interrupt-gserver#s entries in the lab so we can have
> chip, node local and global targets:
> 
> ibm,ppc-interrupt-server#s
> 	00000002 00000003
> 
> ibm,ppc-interrupt-gserver#s
> 	00000002 000000ff 00000003 000000ff 00000002 000000f7
> 	00000003 000000f7 00000002 000000d7
> 	00000003 000000d7
> 
> We always put the global target at the end (0xd7 in this case) because
> the current code in Linux just grabs the last entry in the array to get
> the global server. So the question is, do we look for the first or the
> last entry that matches your cpuid to find the global server?
>

Hi Anton,

Thanks for your input.

But I am also having the same question, which entry will be appropriate
to find the global server? First or the last cpu id entry? The existing
code always uses the last entry regardless of the cpu id to determine
the global server. 
 
> It might be worth getting something added to the architecture (PAPR) to
> clear it up. To match what current Linux does, we would want servers to
> go from including the least to the most cpus, so the global one is at
> the end.
> 
> Anton
