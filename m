Message-ID: <003101c2a4fe$b4cf05f0$1764a8c0@leonardo>
From: "Leonardo Pereira Santos" <lsantos@pd3.com.br>
To: "James Don" <JDon@spacebridge.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <DB0585C9F6F9D411BE8F00D0B7896A4CC05F11@SNCMAIL>
Subject: Re:  kernel 2.4 smc1 problems ... advice please ...
Date: Mon, 16 Dec 2002 10:28:57 -0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Well we managed to make a MPC850 FADS work. But we haven't got any
problems with the console, but with the ethernet. My guess is that you have
a kernel configuration problem, problably at the MPC8xx CPM Options. There,
the only two selected options are the very first one, CPM SCC Ethernet, and
the the second one, SCC2 used of the ethernet. All the other options aren't
selected. After that, if you find out that the kernel is not initializing
the ethernet too (it'll complain that it can't mount the root FS if you're
using NFS), then you'll vahe to copy some definitions for the EPLD's
registers for the FADS boards. The kernel's one are outdated, I think. But
PPCBoot, as you already noticed, are correct, so edit asm-ppc/fads.h our
platforms/fads.h and change the BCSRs definitions found that for the
PPCBoot's ones. That solved our problems.
Cheers.
----- Original Message -----
From: "James Don" <JDon@spacebridge.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Saturday, December 14, 2002 5:37 PM
Subject: kernel 2.4 smc1 problems ... advice please ...


>
> Hello,
>
> I am cuurently trying to boot up the linux kernel using ppcboot 1.16 and
the
> 2.4 kernel with only smc1 uart support as a start on an MPC860 FADS
derived
> board.
>
> So far I have:
> - ppcboot running great
> - tftpboot graps my kernel puts in RAM
> - bootm starts my kernel ... BUT no serial activity ...
>
> I am using the vision ICE currently to debug the kernel start up but it
has
> a problem stepping through the 'rfi' etc when memory protection is
running.
>
> So currently I can only really peek at the PC and see that I am indeed
> excuting kernel code.
>
> I believe my memory map is ok:
> MEM        VIRT        PHYS
> RAM        0xc0000000  0x00000000
> IMMR       0xff000000  0xff000000
>
> My pc seems to get beyond start_kernel ... but I don't see the kernel
banner
> printed or anything ... with an ocillioscope I don't see any serial
activity
> at all after I exit ppcboot ...
>
> I have check the following so far to the best of my abilities (until I get
a
> BDI 2000) ... and the MMU looks ok ... and my SMC port B settings are ok
as
> well.
>
> Does anyone have any tips that could help me out? For some reason I think
> either my MMU is not set to what I think it is ... or my SMC config has
> tanked ...
>
> Regards,
> Jim
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
