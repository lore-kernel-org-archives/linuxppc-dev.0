Date: Fri, 31 Aug 2001 18:03:36 +0200
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Xavier Grave <grave@ipno.in2p3.fr>,
	embarque ppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mvme5100 one more time...
Message-ID: <20010831180336.A13543@ipnpcu5.in2p3.fr>
References: <20010830170043.A8047@ipnpcu5.in2p3.fr> <20010830091936.N18618@cpe-24-221-152-185.az.sprintbbd.net> <20010831111629.A29808@ipnpcu5.in2p3.fr> <20010831075046.E27811@cpe-24-221-152-185.az.sprintbbd.net> <20010831173634.C8764@ipnpcu5.in2p3.fr> <20010831084927.F27811@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: =?ISO-8859-1?Q?=3C20010831084927=2EF27811=40cpe-24-221-152-185=2Eaz=2Esp?=
 =?ISO-8859-1?Q?rintbbd=2Enet=3E=3B_from_trini=40kernel=2Ecrashing=2Eorg_?=
 =?ISO-8859-1?Q?on_ven=2C_ao=FB_31=2C_2001_at_17:49:27_+0200?=
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Le ven, 31 aoû 2001 17:49:27, Tom Rini a écrit :
>
> On Fri, Aug 31, 2001 at 05:36:34PM +0200, Xavier Grave wrote:
> >
> > > That's fine..  Can you change arch/ppc/boot/simple/head.S to
> something
> > > like:
> > > #if 0
> > > /*
> > >  * Determine CPU type
> > > ...
> > > 	bge	_setup_L2CR
> > > #endif
> > > 	b	_setup_6xx
> > Thanks for your advice.
> >
> > I do on my x86 cpu :
> > make CROSS_COMPILE=powerpc-unknown-linux-gnu- ARCH=ppc znetboot
> > on my 5100 :
> > PPC6-Bug>nbo 0 0 ,,, zImage.pplus
> > Network Booting from: I82559, Controller 0, Device 0
> > Device Name: /pci@fe000000/pci8086,1209@e,0:0,0
> > Loading: zImage.pplus
> >
> > Client IP Address      = 192.168.120.38
> > Server IP Address      = 192.168.120.35
> > Gateway IP Address     = 0.0.0.0
> > Subnet IP Address Mask = 255.255.255.0
> > Boot File Name         = zImage.pplus
> > Argument File Name     =
> >
> > Network Boot File load in progress... To abort hit <BREAK>
> >
> > Bytes Received =&700757, Bytes Loaded =&700757
> > Bytes/Second   =&700757, Elapsed Time =1 Second(s)
> >
> > Exception: Program (Illegal Instruction)
> > SRR0 =001F0000 SRR1 =00083040 Vector-Offset =00700
> > IP     =001F0000 MSR    =00003040 CR     =00000000 FPSCR  =00000000
> > R0     =00000000 R1     =03F00000 R2     =00000000 R3     =00000000
> > R4     =00000000 R5     =49504C01 R6     =00007000 R7     =001F0000
> > R8     =03F0CF54 R9     =03F0CD54 R10    =03F0CD60 R11    =03F0CE54
> > R12    =03F0CE54 R13    =00000000 R14    =00000000 R15    =00000000
> > R16    =00000000 R17    =00000000 R18    =00000000 R19    =00000000
> > R20    =00000000 R21    =00000000 R22    =00000000 R23    =00000000
> > R24    =00000000 R25    =00000000 R26    =00000000 R27    =00000000
> > R28    =00000000 R29    =00000000 R30    =00000000 R31    =00000000
> > SPR0   =00000000 SPR1   =00000000 SPR8   =00000000 SPR9   =00000000
> > 001F0000 00040000  WORD        $00040000
> >
> > I have done the modification you advised me and also an other one (to
> > compile :-(
>
> Okay.  Try this.  Undo what I told you last time, and make the end of
> the file look like:
> #if 0
>
> 	.comm	.stack,4096*2,4
> #endif
>
> This may or may not compile.  I have a feeling there'll be some egg on
> my face shortly...

it doesn't compile : I have the following message :
head.o: In function `start_ldr':
head.o(.text+0x176): undefined reference to `stack'
head.o(.text+0x17a): undefined reference to `stack'
make[2]: *** [zvmlinux] Erreur 1

Why the eggs ? because it doesn't compile ? :-)

--
33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
