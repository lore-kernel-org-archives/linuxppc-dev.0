Date: Wed, 23 Dec 1998 14:35:01 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Matroxfb & Motorola PPC & ...
In-Reply-To: <166BF41386C@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.03.9812231425560.18310-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi Petr,

>   after tweaking around I've found that add _ISA_MEM_BASE to value
> contained in pcidev->base_address to get virtual address is RightWay(TM).
> It is in complete contradict to everything what is written everywhere :-(
> Dear ia32, come back to me...

You're talking about a base_address in PCI I/O space, not PCI memory space?
Yes, that's correct. On PReP, I/O space starts at 0x80000000. Quite normal ;-)

>   And... I compiled both VGA Console and Framebuffer Console into one
> driver... Believe or not, it works - almost:
> 
> include/asm-ppc/vga.h
>   scr_readw(ushort* x) { return ld_le16(x); }
> 
> include/linux/vt_buffer.h
> #define scr_readw(x)   ((ushort*)(addr))
> 
> So it causes that if you have compiled in both VGA and FBCon, fbcon
> does not work - you'll see small balls (character code 7) with
> random color background (determined from character code)...

Aha, so scr_readw() is redefined. I already heard about problems with kernels
that have both vgacon and fbcon on PPC. As I don't have a PReP box, I was
unaware of the problem.

> Maybe that some conditionals or warning should be added to Config.in,
> should not?

Not a good solution: it should be possible to have a unified kernel that works
on PReP, PowerMac and CHRP, and thus it must contain both vgacon and fbcon.

> P.S.: Without vgacon (with fbcon alone or together with early boot (BootX only)

BootX only console? Why do you need that? BootX is for booting Linux/PPC on
PowerMac while running MacOS. I'd say: disable it in your config.

> console), it looks like that main console is serial - it is not what
> I want :-( What is proper way to boot PPC with framebuffer?

Is your Millennium correctly initialized to VGA text mode by the PReP Firmware?
If not, it's quite normal that it doesn't work that well.

Things will also go wrong on PReP if you disable vgacon, since conswitchp is no
longer initialized. You should add

    #ifdef CONFIG_DUMMY_CONSOLE
        conswitchp = &dummy_con;
    #endif

to prep_setup_arch() in arch/ppc/kernel/prep_setup.c, as is done for CHRP in
chrp_setup.c. Later the frame buffer console will take over the screen.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
