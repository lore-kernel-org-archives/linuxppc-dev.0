Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1A9EFB7D42
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 17:41:43 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4S7fdgF012192
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 17:41:39 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4S7fgEP1118452
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 17:41:42 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4S7ffn0028971
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 17:41:42 +1000
Date: Fri, 28 May 2010 13:11:35 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Patch 3/4] PPC64-HWBKPT: Handle concurrent alignment interrupts
Message-ID: <20100528074135.GA10511@in.ibm.com>
References: <20100525083055.342788418@linux.vnet.ibm.com>
	<20100525091435.GD29003@in.ibm.com> <20100527062044.GB4105@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100527062044.GB4105@drongo>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>, David Gibson <dwg@au1.ibm.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 27, 2010 at 04:20:44PM +1000, Paul Mackerras wrote:
> On Tue, May 25, 2010 at 02:44:35PM +0530, K.Prasad wrote:
> 
> > An alignment interrupt may intervene between a DSI/hw-breakpoint exception
> > and the single-step exception. Enable the alignment interrupt (through
> > modifications to emulate_single_step()) to notify the single-step exception
> > handler for proper restoration of hw-breakpoints.
> > 
> > Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/traps.c |    7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > Index: linux-2.6.ppc64_test/arch/powerpc/kernel/traps.c
> > ===================================================================
> > --- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/traps.c
> > +++ linux-2.6.ppc64_test/arch/powerpc/kernel/traps.c
> > @@ -602,7 +602,7 @@ void RunModeException(struct pt_regs *re
> >  
> >  void __kprobes single_step_exception(struct pt_regs *regs)
> >  {
> > -	regs->msr &= ~(MSR_SE | MSR_BE);  /* Turn off 'trace' bits */
> > +	clear_single_step(regs);
> >  
> >  	if (notify_die(DIE_SSTEP, "single_step", regs, 5,
> >  					5, SIGTRAP) == NOTIFY_STOP)
> > @@ -621,10 +621,7 @@ void __kprobes single_step_exception(str
> >   */
> >  static void emulate_single_step(struct pt_regs *regs)
> >  {
> > -	if (single_stepping(regs)) {
> > -		clear_single_step(regs);
> > -		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
> > -	}
> > +	single_step_exception(regs);
> >  }
> 
> We still need the if (single_stepping(regs)) in emulate_single_step.
> We don't want to send the process a SIGTRAP every time it gets an
> alignment interrupt. :)
> 
> Paul.

Agreed, and made changes to that effect in version XXII (as seen in
patch linuxppc-dev message-id: 20100528064017.GD8679@in.ibm.com).

Thanks,
K.Prasad
