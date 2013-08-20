Return-Path: <hbausley@deltatau.com>
Received: from Barracuda.deltatau.com (barracuda.deltatau.com [76.79.246.10])
 by ozlabs.org (Postfix) with ESMTP id 6A5342C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 08:45:36 +1000 (EST)
Subject: Re: Critical Interrupt Input
From: Henry Bausley <hbausley@deltatau.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1376945799.25016.77.camel@pasglop>
References: <63d2635a$648939a4$b3aeac8$@deltatau.com>
 <1376945799.25016.77.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Aug 2013 15:48:33 -0700
Message-ID: <1377038913.25385.194.camel@lx-henry>
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

Ben,


After your hints I suspected the read of a real world i/o variable *piom
which came from ioremap_nocache in the 3 line critical interrupt handler

void critintr_handler(void *dev)
{
  critintrcount++;          // increment a variable
  iodata =3D *piom;           // read an I/O location=20
  mtdcr(0x0c0, 0x00002000); // clear critical interrupt=20
}=20

is what caused the problem. Commenting it out seems to make the system stab=
le.=20=20

This led us to disable the critical interrupt when in the
DataTLBError44x and InstructionTLBError44x exceptions.  Now the critical
interrupt handler seems to make things more stable when reading real
world i/o for our application.


  /* Data TLB Error Interrupt */
  START_EXCEPTION(DataTLBError44x)
  mtspr	SPRN_SPRG_WSCRATCH0, r10  /* Save some working */
+  mfmsr r10                      /*  Disable the */
+  rlwinm r10,r10,0,15,13         /*  MSR's CE bit */
+  mtmsr r10=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20


Do you see any potential problems with this approach?

If so can you advise us on how to better take care of this.















On Tue, 2013-08-20 at 06:56 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2013-08-19 at 12:00 -0700, Henry Bausley wrote:
> >=20
> > Support does appear to be present but there is a problem returning
> > back to user space I suspect.
>=20
> Probably a problem with TLB misses vs. crit interrupts.
>=20
> A critical interrupt can re-enter a TLB miss.
>=20
> I can see two potential issues there:
>=20
>  - A bug where we don't properly restore "something" (I thought we did
> save and restore MMUCR though, but that's worth dbl checking if it works
> properly) accross the crit entry/exit
>=20
>  - Something in your crit code causing a TLB miss (the
> kernel .text/.data/.bss should be bolted but anything else can). We
> don't currently support re-entering the TLB miss that way.
>=20
> If we were to support the latter, we'd need to detect on entering a crit
> that the PC is within the TLB miss handler, and setup a return context
> to the original instruction (replay the miss) rather than trying to
> resume it..
>=20
> Cheers,
> Ben.
>=20
> > What fails is it causes Linux user space programs to get Segmentation
> > errors.
> > Issuing a simple ls causes a segmentation fault sometimes.  The shell
> > gets terminated=20
> > and you cannot log back in.  INIT: Id "T0" respawning too fast:
> > disabled for 5 minutes pops up.
> >=20
> > However, the critical interrupt handler keeps running.  I know this by
> > adding the reading=20
> > of a physical I/O location in the handler and can see it is being read
> > on the scope.
> >=20
> >=20
> > The only code in the handler is below.
> >=20
> > void critintr_handler(void *dev)
> > {
> >   critintrcount++;          // increment a variable
> >   iodata =3D *piom;           // read an I/O location=20
> >   mtdcr(0x0c0, 0x00002000); // clear critical interrupt
> > }
> >=20
> >=20
> > Below is a log of the type of crashes that occur:
> >=20
> > root@10.34.9.213:/opt/ppmac/ktest# ls
> > Segmentation fault
> > root@10.34.9.213:/opt/ppmac/ktest# ls
> > Segmentation fault
> > root@10.34.9.213:/opt/ppmac/ktest# ls
> > Makefile        ktest.c    ktest.ko     ktest.mod.o  modules.order
> > Module.symvers  ktest.cbp  ktest.mod.c  ktest.o
> > root@10.34.9.213:/opt/ppmac/ktest# ls
> >=20
> > Debian GNU/Linux 7 powerpmac ttyS0
> >=20
> > powerpmac login: root
> >=20
> > Debian GNU/Linux 7 powerpmac ttyS0
> >=20
> > powerpmac login: root
> >=20
> > Debian GNU/Linux 7 powerpmac ttyS0
> >=20
> > powerpmac login: root
> >=20
> > Debian GNU/Linux 7 powerpmac ttyS0
> >=20
> > powerpmac login: root
> > Password:=20
> > Last login: Thu Nov 30 20:42:16 UTC 1933 on ttyS0
> > Linux powerpmac 3.2.21-aspen_2.01.09 #10 Mon Aug 19 08:49:12 PDT 2013
> > ppc
> >=20
> > The programs included with the Debian GNU/Linux system are free
> > software;
> > the exact distribution terms for each program are described in the
> > individual files in /usr/share/doc/*/copyright.
> >=20
> > Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
> > permitted by applicable law.
> > INIT: Id "T0" respawning too fast: disabled for 5 minutes
> >=20
> >=20
> > ______________________________________________________________________
> > From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
> > Sent: Saturday, August 17, 2013 3:05 PM
> > To: "Kumar Gala" <galak@kernel.crashing.org>
> > Cc: linuxppc-dev@lists.ozlabs.org, hbausley@deltatau.com
> > Subject: Re: Critical Interrupt Input
> >=20
> > On Fri, 2013-08-16 at 06:04 -0500, Kumar Gala wrote:
> > > The 44x low level code needs to handle exception stacks properly for
> > > this to work. Since its possible to have a critical exception occur
> > > while in a normal exception level, you have to have proper saving of
> > > additional register state and a stack frame for the critical
> > > exception, etc. I'm not sure if that was ever done for 44x.
> >=20
> > Don't 44x and FSL BookE share the same macros ? I would think 44x does
> > indeed implement the same crit support as e500...
> >=20
> > What does the crash look like ?
> >=20
> > Ben.
> >=20
> >=20
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> >=20
> >=20
> >   =C2=AD=C2=AD=20=20
>=20
>=20




=0D
Outbound scan for Spam or Virus by Barracuda at Delta Tau=0D
