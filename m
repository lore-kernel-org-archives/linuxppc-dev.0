Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound9-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C85F1DDFAA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jan 2008 03:46:17 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MMU failure, Virtex4-FX60
Date: Wed, 9 Jan 2008 08:46:09 -0800
In-Reply-To: <1199829276.4598.7.camel@PisteOff>
References: <1199727744.17452.8.camel@PisteOff><fa686aa40801071021g611ee7d6jbeafb4616cf29464@mail.gmail.com>
	<1199829276.4598.7.camel@PisteOff>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Robert Woodworth" <rwoodworth@securics.com>,
	"Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080109164610.EABD91010053@mail17-blu.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Passed along....

"Most likely bootloop is not enabled. The processor takes an invalid
instruction and registers a following machine check exception. The
machine check exception is taken when it is enabled in the MSR causing
Linux to crash."

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Robert
Woodworth
> Sent: Tuesday, January 08, 2008 1:55 PM
> To: Grant Likely
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: MMU failure, Virtex4-FX60
>=20
> After further investigation...
> There is a pending interrupt from the PLB waiting at bootup and it
gets
> hit by Linux when the MSR gets set and enables critical interrupts
(same
> time that it jumps into 0xC000XXXX).  The kernel code detects the
> interrupt as a PLB data bus error and goes into crash sequence die().
>=20
> I think I have a problem with my reset hardware, such that the PLB is
> not getting reset correctly with the PPC.  With all interrupts
disabled
> and running a standalone C program, the PLB and memory work fine.
> Any Virtex experts out there have any hints?
>=20
>=20
>=20
> RJW.
>=20
>=20
>=20
>=20
> On Mon, 2008-01-07 at 11:21 -0700, Grant Likely wrote:
> > On 1/7/08, Robert Woodworth <rwoodworth@securics.com> wrote:
> > > Hello!
> > >
> > > I'm building a new Virtex4-FX60 device.  I have built it with the
new
> > > MPMC3 and a 256MB SO-DIMM.  It works successfully with a
"mem-test" type
> > > embedded program.
> > >
> > > I cannot get it to boot a Linux kernel.  I have traced it down to
the
> > > MMU not getting mapped correctly.
> > >
> > > I can load the kernel via jtag, get the pre-boot messages on the
serial
> > > but then when it tries to jump to 0xc0002218 (start_here:
head_4xxx.S)
> > > it fails with a "Machine check exception; invalid instruction
address".
> > >
> > > Using the debugger and examining the memory once the mmu is
suppose to
> > > be configured, I see that it is not mapping 0xc0000000  to the
proper
> > > location.  I'm sure I've set something up wrong in my FPGA and I
need to
> > > re-synthesize.  But what?
> >
> > Hmmm, I haven't seen that failure mode before.  MMU handling on an
of
> > my virtex platforms has never been a problem.  Take a look at the
TLB
> > registers to see how they are configured to see if the mappings are
> > really getting written.
> >
> > What kernel version are you using?
> >
> > Cheers,
> > g.
> >
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
