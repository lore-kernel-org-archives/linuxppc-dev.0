Return-Path: <miroslaw.dach@psi.ch>
Received: from MAILSEND02.psi.ch (mailsend02.psi.ch [129.129.191.54])
	by ozlabs.org (Postfix) with ESMTP id 4A571DDE29
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 17:50:25 +1000 (EST)
Date: Thu, 30 Aug 2007 09:50:24 +0200 (CEST)
From: Miroslaw Dach <miroslaw.dach@psi.ch>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <fa686aa40708290817k897f8c2y5fdf12e5a48cc0ac@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0708300923140.12294-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

	I have modified the linux kernel to have it smaller than I have 
tried once again with bootm and uImage. The result is as shown below:

1. First I have downloaded u-boot via jtag:

XMD% dow u-boot.elf
        section, .text: 0x01300000-0x0131513c
        section, .resetvec: 0x0131513c-0x01315140
        section, .rodata: 0x01315140-0x01317d10
        section, .reloc: 0x01317e00-0x0131877c
        section, .data: 0x0131877c-0x01318c40
        section, .data.rel: 0x01318c40-0x01318c6c
        section, .data.rel.local: 0x01318c6c-0x013190a4
        section, .u_boot_cmd: 0x013190a4-0x01319314
        section, .bss: 0x01319400-0x0131df04
Downloaded Program u-boot13Debug.elf
Setting PC with program start addr = 0x01300100
PC reset to 0x01300100, Clearing MSR Register
XMD% run

2. The u-boot has started properly
3. Than I have loaded via tftp the uImage

=> tftp 0xf00000 uImage
TFTP from server 129.117.144.113; our IP address is 129.117.144.157
Filename 'uImage'.
Load address: 0xf00000
Loading: #################################################################
#################################################################
##############################################################
done
Bytes transferred = 981900 (efb8c hex)
=> bootm 0xf00000
## Booting image at 00f00000 ...
Image Name:  Linux-2.6.21-rc6
Image Type:  PowerPC Linux Kernel Image (gzip compressed)
Data Size:  981836 Bytes = 958.8 kB
Load Address: 00400000
Entry Point:  00400000
   Uncompressing Kernel Image ... OK
Bad trap at PC: c0002218, SR: 21030, vector=1100
NIP: C0002218 XER: 00000000 LR: 00400018 REGS: 01fc0578 TRAP: 1100 DAR:  01FF71AC
MSR: 00021030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11

GPR00: C0002218 01FC0668 B022C01B C00003C0 C0000000 00000000 007FFF00 007FFF7C
GPR08: C1FD9AC0 01FC0C0C 0000AE58 01FFEEC4 01FBFCA0 FFFFFFFF 02000E00 00000001
GPR16: 007FFF7C 00400000 00800000 FFFFFFFF 007FFF00 01FFA104 00000000 01FC0760
GPR24: 00000002 007FFE80 00000001 007FFF7C 007FFF00 00000000 00000000 007FFE80 
Call backtrace:
Exception in kernel pc c0002218 signal 0

4. I have stopped the system and I have reloaded u-boot to see what is in 
the RAM memory:

My __log_buf (of uImage)  is under the address :

c02070c4 b __log_buf

So I have dumped the data from this memory location:

=> md 0x2070c4 100
002070c4: 20257320 69732043 6f727235 70746564 %s is Corr5pted
002070d4: 20615400 25720000 7265646d 72654154 aT.%r..redmreAT
002070e4: 00000000 6b65322a 656c0004 67617465 ....ke2*el..gate
002070f4: 64000000 72614000 6d727400 6a652232 d...ra@.mrt.je"2
00207104: 61000000 62697264 00000000 2f655463 a...bird..../eTc
00207114: 2f497060 6b652465 322f7256 5f7052c5 /Ip`ke$e2/rV_pR.
00207124: 746f7100 676c2a62 616c0000 6e6f7748 toq.gl*bal..nowH
00207134: 65726500 73693465 00000200 27657462 ere.si4e....'etb
00207144: 2f697070 6f752065 322eaa50 5f73436f /ippou e2..P_sCo
00207154: 70655100 2f657022 2f697062 6f757441 peQ./ep"/ipboutA
00207164: 32277274 5b722121 6c6d7380 2f657413 2'rt[r!!lms./et.
00207174: 2f697872 6f357060 322f3264 5f647364 /ixro5p`2/2d_dsd
00207184: 69656c64 00000000 30782520 32780000 ield....0x% 2x..
00207194: 64656640 756c2400 2f653422 2f697070 def@ul$./e4"/ipp
002071a4: 6f757445 322f7274 5f746162 6c654300 outE2/rt_tableC.
002071b4: 10099124 100ae0d4 100aa0e8 100b1838 ...$...........8
002071c4: 100aa3e4 00000000 00000000 00000000 ................
002071d4: 100a6070 100ae0f8 100aa0ec 100ae100 ..`p............

I do not understand what is going on with my kernel image.

When I try to start zImage.elf with bootelf command the system hangs during 
uncompressing.
When I try to start uImage with bootm command the image is uncompressed 
but it does not start properly.

Any idea

Best Regards

Mirek






On Wed, 29 Aug 2007, Grant Likely wrote:

> On 8/29/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
> > Hi Grant,
> >
> >         My zImage.elf has 1.1 MB and uImage 968 KB.
> > Could you tell me please how to hook up GDB to debug u-boot?
> 
> Ah-HA!  You're using the wrong type of kernel image.  When booting
> from u-boot, you should be using a 'uImage', not a 'zImage.elf'.
> (generated with 'make uImage' in the kernel tree).  An you should use
> the 'bootm' command to boot the kernel.
> 
> With bootm, u-boot can pass parameters to the kernel and it is u-boot
> that does the uncompression (instead of the zImage wrapper).
> 
> Cheers,
> g.
> 
> 

-- 
=============================================================================
          Miroslaw Dach (Miroslaw.Dach@psi.ch) - SLS/Controls Group 
                PSI - Paul Scherrer Institut CH-5232 Villigen
=============================================================================
