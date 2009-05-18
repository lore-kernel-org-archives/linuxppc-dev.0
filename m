Return-Path: <stern+4a1a87d0@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 9EB5CDE0C3
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 02:30:53 +1000 (EST)
Date: Mon, 18 May 2009 12:30:41 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [RFC Patch 2/6] Introduce PPC64 specific Hardware
	Breakpointinterfaces
In-Reply-To: <20090518161055.GA27641@in.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0905181227180.3136-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 18 May 2009, K.Prasad wrote:

> > > > > +int __kprobes hw_breakpoint_handler(struct die_args *args)
> > > > > +{
> > > > > +	int rc = NOTIFY_STOP;
> > > > > +	struct hw_breakpoint *bp;
> > > > > +	struct pt_regs *regs = args->regs;
> > > > > +	unsigned long dar;
> > > > > +	int cpu, stepped, is_kernel;
> > > > > +
> > > > > +	/* Disable breakpoints during exception handling */
> > > > > +	set_dabr(0);
> > > > > +
> > > > > +	dar = regs->dar & (~HW_BREAKPOINT_ALIGN);
> > > > > +	is_kernel = (dar >= TASK_SIZE) ? 1 : 0;
> > > > 
> > > > is_kernel_addr() ?
> > > > 
> > > 
> > > Ok.
> > 
> > Shouldn't this test hbp_kernel_pos instead?
> > 
> 
> Testing hbp_kernel_pos should be sufficient for PPC64 with just one
> breakpoint register. However the above code is more extensible to other
> PowerPC implementations which have more than one breakpoint register.

Then maybe you don't want to test this at all.  Just compare the dar 
value with each of the breakpoint addresses.  That's more like what the 
x86 code does.

Alan Stern
