Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0231BDE198
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:15:16 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id n4L7F7gA029986
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 12:45:07 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4L7F7qi1900752
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 12:45:07 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id n4L7F6JN015815
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:15:07 +1000
Date: Thu, 21 May 2009 12:45:05 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC Patch 2/6] Introduce PPC64 specific Hardware
	Breakpointinterfaces
Message-ID: <20090521071505.GB9344@in.ibm.com>
References: <20090518161055.GA27641@in.ibm.com>
	<Pine.LNX.4.44L0.0905181227180.3136-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.0905181227180.3136-100000@iolanthe.rowland.org>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 18, 2009 at 12:30:41PM -0400, Alan Stern wrote:
> On Mon, 18 May 2009, K.Prasad wrote:
> 
> > > > > > +int __kprobes hw_breakpoint_handler(struct die_args *args)
> > > > > > +{
> > > > > > +	int rc = NOTIFY_STOP;
> > > > > > +	struct hw_breakpoint *bp;
> > > > > > +	struct pt_regs *regs = args->regs;
> > > > > > +	unsigned long dar;
> > > > > > +	int cpu, stepped, is_kernel;
> > > > > > +
> > > > > > +	/* Disable breakpoints during exception handling */
> > > > > > +	set_dabr(0);
> > > > > > +
> > > > > > +	dar = regs->dar & (~HW_BREAKPOINT_ALIGN);
> > > > > > +	is_kernel = (dar >= TASK_SIZE) ? 1 : 0;
> > > > > 
> > > > > is_kernel_addr() ?
> > > > > 
> > > > 
> > > > Ok.
> > > 
> > > Shouldn't this test hbp_kernel_pos instead?
> > > 
> > 
> > Testing hbp_kernel_pos should be sufficient for PPC64 with just one
> > breakpoint register. However the above code is more extensible to other
> > PowerPC implementations which have more than one breakpoint register.
> 
> Then maybe you don't want to test this at all.  Just compare the dar 
> value with each of the breakpoint addresses.  That's more like what the 
> x86 code does.
> 
> Alan Stern
>

Comparing the DAR register value with each breakpoint address is
required to determine if the exception is the cause of a breakpoint hit
and I've added the code to hw_breakpoint_handler(). With this check in
place, I find that using hbp_kernel_pos to determine kernel/user space
origin is much easier (as you suggested) and the code is modified
accordingly.

Please find the changes in the new patchset being sent.

Thanks,
K.Prasad
