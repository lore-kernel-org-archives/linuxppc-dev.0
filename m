Date: Fri, 18 Dec 1998 20:14:16 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Gabriel Paubert <paubert@iram.es>
cc: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>,
        Corey Minyard <minyard@acm.org>, linuxppc-dev@lists.linuxppc.org
Subject: preploader, works on MTX, not on BlackHawk
In-Reply-To: <Pine.HPP.3.96.981218111509.12103B-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.04.9812181941460.13860-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Please please please someone do this? Then I can remove the ugly hack I
> > have in matroxfb to remap the PCI registers to something sane.
> 
> Did you try my preploader. It attempts to remap all the PCI resources to
> something sane and even includes a black list for devices who lie about
> their requirement (S3). For the latest version I've got success reports on
> quite a lot of Motorola boards: 
> 
> 	MVME230x, 2300SC, 2400, 260x, 2700, 3600, MTX and MPC750

First of all, can I get the patches for OpenPIC support? I'd like to try
to merge them with Corey Minyard's changes and add SMP support for MTX.

Along those lines, since there are at least four people doing development
on Motorola embedded (PowerPlus?) boards, I have considered setting up a
CVS archive for development kernel work. I was thinking of giving most
everyone working on this write access. The theory is that this will make
it more convenient, since one doesnt' have to worry so much about breaking
the Vger cvs and can submit more experimental code. This would also
hopefully reduce duplicated work, such as the restructing which Corey did
(which I had also started, but never got as far). Comments/Flames anyone?

I just tried the zimage-2.1.130 on vcorr1.iram.es, and got one moderate
success, and one failure. My MTX booted quite happily, however, there was
no vgacon support (I'm guessing), so I had no console. I've also included
the log from a boot with the video card removed.

My BlackHawk system came up, but the video card initialization failed and
filled the screen with a bunch of flashing characters. I could see
'linuxppc load' through the mess, but it seemed like the kernel never
booted. Is there any way to force loader to use serial? This would help
debugging.

Also, My matrox card's second PCI address got realocated to somethign
sane, but the first address (the control registers) stayed at 0. Will this
need a blacklist of some sort?

I also had an unexplained crash with the video card in. Gabriel, you might
want to look at your system.map. This occured about 2 or 3 minutes after
booting. ( I was logged in via the serial port at the time)


----- 
[root@kalmia pci]# page fault in interrupt handler, addr=8
NIP: C00A2194 XER: 20000000 LR: C009E4D4 REGS: c741dce0 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c741c000[264] 'rc5des' mm->pgd c760b000 Last syscall: 13
last math c741c000
GPR00: 00000000 C741DDD0 C741C000 00000000 00000000 C0104408 FFFFFF80 C0143040
GPR08: 00000001 C01432C4 00000000 00000000 61256FE5 2550CC02 D086C039 8790EC78
GPR16: 69F0205A 6E25B41B 0559B698 C8E1C490 00001032 0741DE80 00000000 00000000
GPR24: 00000000 00000000 C0100000 C0120000 C0110000 00000000 00000000 00000002
NIP: C00A2194 XER: 20000000 LR: C009E4D4 REGS: c741dce0 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c741c000[264] 'rc5des' mm->pgd c760b000 Last syscall: 13
last math c741c000
GPR00: 00000000 C741DDD0 C741C000 00000000 00000000 C0104408 FFFFFF80 C0143040
GPR08: 00000001 C01432C4 00000000 00000000 61256FE5 2550CC02 D086C039 8790EC78
GPR16: 69F0205A 6E25B41B 0559B698 C8E1C490 00001032 0741DE80 00000000 00000000
GPR24: 00000000 00000000 C0100000 C0120000 C0110000 00000000 00000000 00000002
Call backtrace:
C009ABE4 C009E4D4 C009E62C C009DDDC C009F360 C0005694 C0003A7C
00000000 0181A434 0180CCF0 0180ED5C 01800134
Kernel panic: kernel access of bad area pc c00a2194 lr c009e4d4 address 8
tsk rc5des/24
In interrupt handler - not syncing  

--------------------------------------------------------------------------
| Troy Benjegerdes    |    troybenj@iastate.edu    |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
