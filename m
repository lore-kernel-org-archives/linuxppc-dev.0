Date: Thu, 21 Jan 1999 09:38:27 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: DEC21143 on PPC
In-Reply-To: <Pine.LNX.3.96.990120210809.12797B-100000@liberty.chnd1.az.home.com>
Message-ID: <Pine.LNX.3.96.990121093326.14236C-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 20 Jan 1999, Matt Porter wrote:

> > > Is anybody running a 21143 on Linux/PPC using either de4x5.c or tulip.c?
> > > I'm having problems getting either to work on the newer Motorola VME
> > > boards.
> > > 
> > > eth0: DC21143 at 0x11000 (PCI bus 0, device 14), h/w address
> > > 08:00:3e:26:a3:0f,
> > >       and requires IRQ10 (provided by PCI BIOS).
> > > de4x5.c:V0.543 1998/12/30 davies@maniac.ultranet.com
> > > NIP: C000F104 XER: 00000000 LR: C000F0E8 REGS: c01d3cc0 TRAP: 0300
> >        ^^^^^^^^
> > > MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> > > TASK = c01d2000[1] 'swapper' mm->pgd c013a000 Last syscall: 120 
> > > last math 00000000
> > > GPR00: 00001032 C01D3DB0 C01D2000 00000001 00008000 C01CD0D4 00000000
> > > 00018583 
> > > GPR08: 00000001 00007800 80000000 000001E0 0000001F 01F818C0 00000000
> > > 00000000 
> > > GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > > 00000000 
> > > GPR24: 00000000 00000000 C0160000 C0160000 00000000 00009032 C01CD76C
> > > C01D3DB0 
> > > Call backtrace: 
> > > 00000000 C00DF338 C00D8DE4 C00D7764 C00D749C C0075278 C00762E0 
> >            ^^^^^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^^^^^
> > > C015D480 C015DDE0 C015CC8C C015EB7C C01548B0 C0004140 C0008010 
> >            ^^^^^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^^^^^
> > > Kernel panic: kernel access of bad area pc c000f104 lr c000f0e8 address
> > > 7804 tsk swapper/1
> 
> c00d749c: de4x5_open
> c00d7764: de4x5_init
> c00d8de4: autoconf_media
> c00df338: disable_ast
> c000f104: del_timer
> 
> Appears to lose it in the kernel timer services.  I'll update my source
> tree to the latest vger and give it another try.  My arch independent
> stuff hasn't been updated since Nov 30.

Got the latest and the same problem using del_timer is present.  Note: I
had to disable kbd_init() to get the latest stuff to boot, since the
board I have has no kbd port...previously it just failed cleanly.

--
Matt Porter
mmporter@home.com
Unix is a Linux-like operating system.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
