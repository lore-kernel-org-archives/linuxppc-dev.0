Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95302B7CFC
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 21:57:23 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id o1NArrpJ004130
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 21:53:53 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1NApsJN1593448
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 21:51:54 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1NAvLEA012743
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 21:57:22 +1100
Date: Tue, 23 Feb 2010 16:27:15 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100223105715.GA17358@in.ibm.com>
References: <20100215055605.GB3670@in.ibm.com>
	<20100215055914.GA6017@in.ibm.com> <20100221010130.GA5187@nowhere>
	<20100222131746.GA3228@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100222131746.GA3228@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	Will Deacon <will.deacon@arm.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 22, 2010 at 06:47:46PM +0530, K.Prasad wrote:
> On Sun, Feb 21, 2010 at 02:01:37AM +0100, Frederic Weisbecker wrote:
> > On Mon, Feb 15, 2010 at 11:29:14AM +0530, K.Prasad wrote:
[snipped]
> > Also, do you think addr/len/type is enough to abstract out
> > any ppc breakpoints?
> > 
> > This looks enough to me to express range breakpoints and
> > simple breakpoints. But what about value comparison?
> > (And still, there may be other trickier implementations
> > I don't know in ppc).
> > 
> 
> The above implementation is for PPC64 architecture that supports only
> 'simple' breakpoints of fixed length (no range breakpoints, no value
> comparison). More on that below.
>

Looks like I forgot the 'more on that below' part :-)....here are some
thoughts...

Architectures like PPC Book-E have support for a variety of
sophisticated debug features and our generic framework, in its present
form, cannot easily port itself to these processors. In order to extend
the framework for PPC Book-E, I intend the following to begin with:

- Implement support for data breakpoints through DAC registers with all
  the 'bells and whistles'...support for instruction breakpoints through
  IAC can come in later (without precluding its use through ptrace).

- Embed the flags/variables to store DVC, masked address mode, etc. in
  'struct arch_hw_breakpoint', which will be populated by the user of
  register_breakpoint interface.

Apart from the above extensions to the framework, changes in the generic
code would be required as described in an earlier LKML mail (ref:
message-id: 20091127190705.GB18408@in.ibm.com)....relevant contents
pasted below:

"I think the register_<> interfaces can become wrappers around functions
that do the following:

- arch_validate(): Validate request by invoking an arch-dependant
  routine. Proceed if returned valid.
- arch-specific debugreg availability: Do something like
  if (arch_hw_breakpoint_availabile())
        bp = perf_event_create_kernel_counter();

  perf_event_create_kernel_counter()--->arch_install_hw_breakpoint();

This way, all book-keeping related work (no. of pinned/flexible/per-cpu)
will be moved to arch-specific files (will be helpful for PPC Book-E
implementation having two types of debug registers). Every new
architecture that intends to port to the new hw-breakpoint
implementation must define their arch_validate(),
arch_hw_breakpoint_available() and an arch_install_hw_breakpoint(),
while the hw-breakpoint code will be flexible enough to extend itself to
each of these archs."

Let me know what you think of the above.

Thanks,
K.Prasad
