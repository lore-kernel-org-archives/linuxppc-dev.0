Return-Path: <hbausley@deltatau.com>
Received: from Barracuda.deltatau.com (barracuda.deltatau.com [76.79.246.10])
 by ozlabs.org (Postfix) with ESMTP id 38DF72C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 08:12:12 +1000 (EST)
Subject: Re: Critical Interrupt Input
From: Henry Bausley <hbausley@deltatau.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1377040129.25016.181.camel@pasglop>
References: <63d2635a$648939a4$b3aeac8$@deltatau.com>
 <1376945799.25016.77.camel@pasglop> <1377038913.25385.194.camel@lx-henry>
 <1377040129.25016.181.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Aug 2013 15:11:56 -0700
Message-ID: <1377641516.4691.11.camel@lx-henry>
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


Both methods you described seem to work. We are currently using the
method of clearing the partially written TLB. Seems to be working but
we're still testing.  Thanks.=20=20


=2E
=2E
=2E
	mfspr	r5,SPRN_CSRR0;
	lis	r12,finish_tlb_load_44x@h
	ori	r12,r12,finish_tlb_load_44x@l;
	addi	r11,r12,finish_tlb_load_44x_end-finish_tlb_load_44x;
	cmplw	cr0,r5,r12;
	cmplw	cr1,r5,r11;
	ble	cr0,3f;
	bge	cr1,3f;
	li	r12,0;
	mr	r5,r11
	tlbwe	r12,r13,PPC44x_TLB_XLAT;
	tlbwe	r12,r13,PPC44x_TLB_PAGEID;	/* Clear PAGEID */
        tlbwe   r12,r13,PPC44x_TLB_ATTRIB;	/* Clear ATTRIB */
	isync
=2E
=2E
=2E


On Wed, 2013-08-21 at 09:08 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2013-08-20 at 15:48 -0700, Henry Bausley wrote:
> > Ben,
> >=20
> >=20
> > After your hints I suspected the read of a real world i/o variable *piom
> > which came from ioremap_nocache in the 3 line critical interrupt handler
> >=20
> > void critintr_handler(void *dev)
> > {
> >   critintrcount++;          // increment a variable
> >   iodata =3D *piom;           // read an I/O location=20
> >   mtdcr(0x0c0, 0x00002000); // clear critical interrupt=20
> > }=20
> >=20
> > is what caused the problem. Commenting it out seems to make the system =
stable.=20=20
>=20
> Right, definitely would do that. BTW. You may want to use proper IO
> accessors while at it, to get the right memory barriers etc...
>=20
> > This led us to disable the critical interrupt when in the
> > DataTLBError44x and InstructionTLBError44x exceptions.  Now the critical
> > interrupt handler seems to make things more stable when reading real
> > world i/o for our application.
> >
> >=20
> >   /* Data TLB Error Interrupt */
> >   START_EXCEPTION(DataTLBError44x)
> >   mtspr	SPRN_SPRG_WSCRATCH0, r10  /* Save some working */
> > +  mfmsr r10                      /*  Disable the */
> > +  rlwinm r10,r10,0,15,13         /*  MSR's CE bit */
> > +  mtmsr r10=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
> >=20
> >=20
> > Do you see any potential problems with this approach?
> >=20
> > If so can you advise us on how to better take care of this.
>=20
>  - You potentially still have an exposure ... between the mtspr to
> scratch and the mfmsr, a CRIC can occur, causing a re-entrancy which
> would than clobber the scratch register. That can be handled by saving
> that scratc SPRG into the stack frame on entry/exit from the crit
> interrupt. Look at crit_transfer_to_handler, how it already handles
> MMUCR:
>=20
> 	mfspr	r0,SPRN_MMUCR
> 	stw	r0,MMUCR(r11)
>=20
> Probably add saving of the SPRG_WSCRATCH0 in there (need to add a frame
> slot for it) and do the restore in RESTORE_MMU_REGS
>=20
>  - You need to handle Instructions TLB miss as well
>=20
>  - You add overhead to the TLB miss handlers which are fairly
> performance critical pieces of code. You might be able to alleviate
> that by making the whole thing support re-entrancy properly but that's
> harder. To do that you would have to:
>=20
>     * Save *all* the SPRGs used by the TLB miss during crit entry/exit
>=20
>     * Detect in crit_transfer_to_handler (check the CSRR0 bounds) that=20
>       the crit code interrupted finish_tlb_load_44x before or at the
>       last tlbwe instruction. In that case, immediately clear the=20
>       partially written TLB entry (index in r13) and change the
>       return address to skip right past the last tlbwe.
>=20
> Cheers,
> Ben.
>=20
>=20
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > On Tue, 2013-08-20 at 06:56 +1000, Benjamin Herrenschmidt wrote:
> > > On Mon, 2013-08-19 at 12:00 -0700, Henry Bausley wrote:
> > > >=20
> > > > Support does appear to be present but there is a problem returning
> > > > back to user space I suspect.
> > >=20
> > > Probably a problem with TLB misses vs. crit interrupts.
> > >=20
> > > A critical interrupt can re-enter a TLB miss.
> > >=20
> > > I can see two potential issues there:
> > >=20
> > >  - A bug where we don't properly restore "something" (I thought we did
> > > save and restore MMUCR though, but that's worth dbl checking if it wo=
rks
> > > properly) accross the crit entry/exit
> > >=20
> > >  - Something in your crit code causing a TLB miss (the
> > > kernel .text/.data/.bss should be bolted but anything else can). We
> > > don't currently support re-entering the TLB miss that way.
> > >=20
> > > If we were to support the latter, we'd need to detect on entering a c=
rit
> > > that the PC is within the TLB miss handler, and setup a return context
> > > to the original instruction (replay the miss) rather than trying to
> > > resume it..
> > >=20
> > > Cheers,
> > > Ben.
> > >=20
> > > > What fails is it causes Linux user space programs to get Segmentati=
on
> > > > errors.
> > > > Issuing a simple ls causes a segmentation fault sometimes.  The she=
ll
> > > > gets terminated=20
> > > > and you cannot log back in.  INIT: Id "T0" respawning too fast:
> > > > disabled for 5 minutes pops up.
> > > >=20
> > > > However, the critical interrupt handler keeps running.  I know this=
 by
> > > > adding the reading=20
> > > > of a physical I/O location in the handler and can see it is being r=
ead
> > > > on the scope.
> > > >=20
> > > >=20
> > > > The only code in the handler is below.
> > > >=20
> > > > void critintr_handler(void *dev)
> > > > {
> > > >   critintrcount++;          // increment a variable
> > > >   iodata =3D *piom;           // read an I/O location=20
> > > >   mtdcr(0x0c0, 0x00002000); // clear critical interrupt
> > > > }
> > > >=20
> > > >=20
> > > > Below is a log of the type of crashes that occur:
> > > >=20
> > > > root@10.34.9.213:/opt/ppmac/ktest# ls
> > > > Segmentation fault
> > > > root@10.34.9.213:/opt/ppmac/ktest# ls
> > > > Segmentation fault
> > > > root@10.34.9.213:/opt/ppmac/ktest# ls
> > > > Makefile        ktest.c    ktest.ko     ktest.mod.o  modules.order
> > > > Module.symvers  ktest.cbp  ktest.mod.c  ktest.o
> > > > root@10.34.9.213:/opt/ppmac/ktest# ls
> > > >=20
> > > > Debian GNU/Linux 7 powerpmac ttyS0
> > > >=20
> > > > powerpmac login: root
> > > >=20
> > > > Debian GNU/Linux 7 powerpmac ttyS0
> > > >=20
> > > > powerpmac login: root
> > > >=20
> > > > Debian GNU/Linux 7 powerpmac ttyS0
> > > >=20
> > > > powerpmac login: root
> > > >=20
> > > > Debian GNU/Linux 7 powerpmac ttyS0
> > > >=20
> > > > powerpmac login: root
> > > > Password:=20
> > > > Last login: Thu Nov 30 20:42:16 UTC 1933 on ttyS0
> > > > Linux powerpmac 3.2.21-aspen_2.01.09 #10 Mon Aug 19 08:49:12 PDT 20=
13
> > > > ppc
> > > >=20
> > > > The programs included with the Debian GNU/Linux system are free
> > > > software;
> > > > the exact distribution terms for each program are described in the
> > > > individual files in /usr/share/doc/*/copyright.
> > > >=20
> > > > Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
> > > > permitted by applicable law.
> > > > INIT: Id "T0" respawning too fast: disabled for 5 minutes
> > > >=20
> > > >=20
> > > > ___________________________________________________________________=
___
> > > > From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
> > > > Sent: Saturday, August 17, 2013 3:05 PM
> > > > To: "Kumar Gala" <galak@kernel.crashing.org>
> > > > Cc: linuxppc-dev@lists.ozlabs.org, hbausley@deltatau.com
> > > > Subject: Re: Critical Interrupt Input
> > > >=20
> > > > On Fri, 2013-08-16 at 06:04 -0500, Kumar Gala wrote:
> > > > > The 44x low level code needs to handle exception stacks properly =
for
> > > > > this to work. Since its possible to have a critical exception occ=
ur
> > > > > while in a normal exception level, you have to have proper saving=
 of
> > > > > additional register state and a stack frame for the critical
> > > > > exception, etc. I'm not sure if that was ever done for 44x.
> > > >=20
> > > > Don't 44x and FSL BookE share the same macros ? I would think 44x d=
oes
> > > > indeed implement the same crit support as e500...
> > > >=20
> > > > What does the crash look like ?
> > > >=20
> > > > Ben.
> > > >=20
> > > >=20
> > > > _______________________________________________
> > > > Linuxppc-dev mailing list
> > > > Linuxppc-dev@lists.ozlabs.org
> > > > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > > >=20
> > > >=20
> > > >   =C2=AD=C2=AD=20=20
> > >=20
> > >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > Outbound scan for Spam or Virus by Barracuda at Delta Tau
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
