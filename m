Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A402C2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 08:14:33 +1000 (EST)
Message-ID: <1377641665.3819.138.camel@pasglop>
Subject: Re: Critical Interrupt Input
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Henry Bausley <hbausley@deltatau.com>
Date: Wed, 28 Aug 2013 08:14:25 +1000
In-Reply-To: <1377641516.4691.11.camel@lx-henry>
References: <63d2635a$648939a4$b3aeac8$@deltatau.com>
 <1376945799.25016.77.camel@pasglop> <1377038913.25385.194.camel@lx-henry>
 <1377040129.25016.181.camel@pasglop> <1377641516.4691.11.camel@lx-henry>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-08-27 at 15:11 -0700, Henry Bausley wrote:
> Both methods you described seem to work. We are currently using the
> method of clearing the partially written TLB. Seems to be working but
> we're still testing.  Thanks.  

Feel free to send me us patch for review :-)

Cheers,
Ben.

> .
> .
> .
> 	mfspr	r5,SPRN_CSRR0;
> 	lis	r12,finish_tlb_load_44x@h
> 	ori	r12,r12,finish_tlb_load_44x@l;
> 	addi	r11,r12,finish_tlb_load_44x_end-finish_tlb_load_44x;
> 	cmplw	cr0,r5,r12;
> 	cmplw	cr1,r5,r11;
> 	ble	cr0,3f;
> 	bge	cr1,3f;
> 	li	r12,0;
> 	mr	r5,r11
> 	tlbwe	r12,r13,PPC44x_TLB_XLAT;
> 	tlbwe	r12,r13,PPC44x_TLB_PAGEID;	/* Clear PAGEID */
>         tlbwe   r12,r13,PPC44x_TLB_ATTRIB;	/* Clear ATTRIB */
> 	isync
> .
> .
> .
> 
> 
> On Wed, 2013-08-21 at 09:08 +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2013-08-20 at 15:48 -0700, Henry Bausley wrote:
> > > Ben,
> > > 
> > > 
> > > After your hints I suspected the read of a real world i/o variable *piom
> > > which came from ioremap_nocache in the 3 line critical interrupt handler
> > > 
> > > void critintr_handler(void *dev)
> > > {
> > >   critintrcount++;          // increment a variable
> > >   iodata = *piom;           // read an I/O location 
> > >   mtdcr(0x0c0, 0x00002000); // clear critical interrupt 
> > > } 
> > > 
> > > is what caused the problem. Commenting it out seems to make the system stable.  
> > 
> > Right, definitely would do that. BTW. You may want to use proper IO
> > accessors while at it, to get the right memory barriers etc...
> > 
> > > This led us to disable the critical interrupt when in the
> > > DataTLBError44x and InstructionTLBError44x exceptions.  Now the critical
> > > interrupt handler seems to make things more stable when reading real
> > > world i/o for our application.
> > >
> > > 
> > >   /* Data TLB Error Interrupt */
> > >   START_EXCEPTION(DataTLBError44x)
> > >   mtspr	SPRN_SPRG_WSCRATCH0, r10  /* Save some working */
> > > +  mfmsr r10                      /*  Disable the */
> > > +  rlwinm r10,r10,0,15,13         /*  MSR's CE bit */
> > > +  mtmsr r10                     
> > > 
> > > 
> > > Do you see any potential problems with this approach?
> > > 
> > > If so can you advise us on how to better take care of this.
> > 
> >  - You potentially still have an exposure ... between the mtspr to
> > scratch and the mfmsr, a CRIC can occur, causing a re-entrancy which
> > would than clobber the scratch register. That can be handled by saving
> > that scratc SPRG into the stack frame on entry/exit from the crit
> > interrupt. Look at crit_transfer_to_handler, how it already handles
> > MMUCR:
> > 
> > 	mfspr	r0,SPRN_MMUCR
> > 	stw	r0,MMUCR(r11)
> > 
> > Probably add saving of the SPRG_WSCRATCH0 in there (need to add a frame
> > slot for it) and do the restore in RESTORE_MMU_REGS
> > 
> >  - You need to handle Instructions TLB miss as well
> > 
> >  - You add overhead to the TLB miss handlers which are fairly
> > performance critical pieces of code. You might be able to alleviate
> > that by making the whole thing support re-entrancy properly but that's
> > harder. To do that you would have to:
> > 
> >     * Save *all* the SPRGs used by the TLB miss during crit entry/exit
> > 
> >     * Detect in crit_transfer_to_handler (check the CSRR0 bounds) that 
> >       the crit code interrupted finish_tlb_load_44x before or at the
> >       last tlbwe instruction. In that case, immediately clear the 
> >       partially written TLB entry (index in r13) and change the
> >       return address to skip right past the last tlbwe.
> > 
> > Cheers,
> > Ben.
> > 
> > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > On Tue, 2013-08-20 at 06:56 +1000, Benjamin Herrenschmidt wrote:
> > > > On Mon, 2013-08-19 at 12:00 -0700, Henry Bausley wrote:
> > > > > 
> > > > > Support does appear to be present but there is a problem returning
> > > > > back to user space I suspect.
> > > > 
> > > > Probably a problem with TLB misses vs. crit interrupts.
> > > > 
> > > > A critical interrupt can re-enter a TLB miss.
> > > > 
> > > > I can see two potential issues there:
> > > > 
> > > >  - A bug where we don't properly restore "something" (I thought we did
> > > > save and restore MMUCR though, but that's worth dbl checking if it works
> > > > properly) accross the crit entry/exit
> > > > 
> > > >  - Something in your crit code causing a TLB miss (the
> > > > kernel .text/.data/.bss should be bolted but anything else can). We
> > > > don't currently support re-entering the TLB miss that way.
> > > > 
> > > > If we were to support the latter, we'd need to detect on entering a crit
> > > > that the PC is within the TLB miss handler, and setup a return context
> > > > to the original instruction (replay the miss) rather than trying to
> > > > resume it..
> > > > 
> > > > Cheers,
> > > > Ben.
> > > > 
> > > > > What fails is it causes Linux user space programs to get Segmentation
> > > > > errors.
> > > > > Issuing a simple ls causes a segmentation fault sometimes.  The shell
> > > > > gets terminated 
> > > > > and you cannot log back in.  INIT: Id "T0" respawning too fast:
> > > > > disabled for 5 minutes pops up.
> > > > > 
> > > > > However, the critical interrupt handler keeps running.  I know this by
> > > > > adding the reading 
> > > > > of a physical I/O location in the handler and can see it is being read
> > > > > on the scope.
> > > > > 
> > > > > 
> > > > > The only code in the handler is below.
> > > > > 
> > > > > void critintr_handler(void *dev)
> > > > > {
> > > > >   critintrcount++;          // increment a variable
> > > > >   iodata = *piom;           // read an I/O location 
> > > > >   mtdcr(0x0c0, 0x00002000); // clear critical interrupt
> > > > > }
> > > > > 
> > > > > 
> > > > > Below is a log of the type of crashes that occur:
> > > > > 
> > > > > root@10.34.9.213:/opt/ppmac/ktest# ls
> > > > > Segmentation fault
> > > > > root@10.34.9.213:/opt/ppmac/ktest# ls
> > > > > Segmentation fault
> > > > > root@10.34.9.213:/opt/ppmac/ktest# ls
> > > > > Makefile        ktest.c    ktest.ko     ktest.mod.o  modules.order
> > > > > Module.symvers  ktest.cbp  ktest.mod.c  ktest.o
> > > > > root@10.34.9.213:/opt/ppmac/ktest# ls
> > > > > 
> > > > > Debian GNU/Linux 7 powerpmac ttyS0
> > > > > 
> > > > > powerpmac login: root
> > > > > 
> > > > > Debian GNU/Linux 7 powerpmac ttyS0
> > > > > 
> > > > > powerpmac login: root
> > > > > 
> > > > > Debian GNU/Linux 7 powerpmac ttyS0
> > > > > 
> > > > > powerpmac login: root
> > > > > 
> > > > > Debian GNU/Linux 7 powerpmac ttyS0
> > > > > 
> > > > > powerpmac login: root
> > > > > Password: 
> > > > > Last login: Thu Nov 30 20:42:16 UTC 1933 on ttyS0
> > > > > Linux powerpmac 3.2.21-aspen_2.01.09 #10 Mon Aug 19 08:49:12 PDT 2013
> > > > > ppc
> > > > > 
> > > > > The programs included with the Debian GNU/Linux system are free
> > > > > software;
> > > > > the exact distribution terms for each program are described in the
> > > > > individual files in /usr/share/doc/*/copyright.
> > > > > 
> > > > > Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
> > > > > permitted by applicable law.
> > > > > INIT: Id "T0" respawning too fast: disabled for 5 minutes
> > > > > 
> > > > > 
> > > > > ______________________________________________________________________
> > > > > From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
> > > > > Sent: Saturday, August 17, 2013 3:05 PM
> > > > > To: "Kumar Gala" <galak@kernel.crashing.org>
> > > > > Cc: linuxppc-dev@lists.ozlabs.org, hbausley@deltatau.com
> > > > > Subject: Re: Critical Interrupt Input
> > > > > 
> > > > > On Fri, 2013-08-16 at 06:04 -0500, Kumar Gala wrote:
> > > > > > The 44x low level code needs to handle exception stacks properly for
> > > > > > this to work. Since its possible to have a critical exception occur
> > > > > > while in a normal exception level, you have to have proper saving of
> > > > > > additional register state and a stack frame for the critical
> > > > > > exception, etc. I'm not sure if that was ever done for 44x.
> > > > > 
> > > > > Don't 44x and FSL BookE share the same macros ? I would think 44x does
> > > > > indeed implement the same crit support as e500...
> > > > > 
> > > > > What does the crash look like ?
> > > > > 
> > > > > Ben.
> > > > > 
> > > > > 
> > > > > _______________________________________________
> > > > > Linuxppc-dev mailing list
> > > > > Linuxppc-dev@lists.ozlabs.org
> > > > > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > > > > 
> > > > > 
> > > > >   ­­  
> > > > 
> > > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > Outbound scan for Spam or Virus by Barracuda at Delta Tau
> > 
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
