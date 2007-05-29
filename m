Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from ex01.ads.ubidyne.de (mail.ubidyne.com [212.211.133.238])
	by ozlabs.org (Postfix) with ESMTP id 116DDDDFD4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 May 2007 20:08:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: BDI2000 configuration file for MPC8313E-RDB
Date: Tue, 29 May 2007 12:08:21 +0200
Message-ID: <29DC34A6B43468409F5A371CFE34E8491B57CB@ex01.ads.ubidyne.de>
From: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>
To: "Leonid" <Leonid@a-k-a.net>
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

Hi Leonid,

the PowerTAB pro JTAG Debugger cannot access NAND directly like the =
BDI2000.
I thought it could, but as you said there's no way to program NAND =
directly.

The configuration file I posted was the unmodified one that I got from =
the http://www.ultsol.com/ webpage. Therefore you find at section [FILE] =
PCB82xx120.ep. (I change the IP and the file to u-boot.bin)

I still got the problem that I don't know how to get access to NAND to
store the 4KB bootloader and to boot completely from NAND.=20

I tried via u-boot by booting from NOR.

=3D> nand info
Device 0: NAND 32MiB 3,3V 8-bit, sector size 16 KiB


=3D> nand erase=20

NAND erase: device 0 whole chip
Erasing at 0x1ffc000 -- 100% complete.
OK
=3D>


That seems each command works. (show info and erase NAND)

But when I'm trying to write for example u-boot.bin to NAND
I'll get this:
=3D> nand write.e 3000000 f8000000 29790

NAND write: device 0 offset 0xf8000000, size 0x29790


Data did not fit into device, due to bad blocks
 169872 bytes written: ERROR
=3D>

Furthermore, when I trying to display NAND memory
I'll get this:
=3D> md 0xf8000000
f8000000:Bus Fault @ 0x00000900, fixup 0x00000000
Machine check in kernel mode.
Caused by (from msr): regs 07f38cc0 Unknown values in msr
NIP: 00000900 XER: 20000000 LR: 07FD4430 REGS: 07f38cc0 TRAP: 0200 DAR: =
FFFFFFFF
MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00

GPR00: 07FD4430 07F38DB0 00000080 00000000 B09F0000 00000010 00000001 =
00000008=20
GPR08: 00000001 00000020 00000000 00000000 07F38B78 00000000 07FFC000 =
09FBB000=20
GPR16: 00000000 00000000 00000000 00000000 07F38DB8 00000040 07F38DB8 =
07F38DB8=20
GPR24: 00000000 00000100 00000010 00000004 F8000000 07F38F5C 07FFCDA8 =
07F38DB8=20
Call backtrace:=20
07FD4430 07FDD8D8 07FDCFD0 07FDD12C 07FCCDAC 07FBFAC8 07FBE66C=20
7EB143A6=20
machine check
Resetting the board.

Why? Is the NAND memory not correctly mapped to 0xf8000000? Where
can I change the mapping?

I'm aware of that these are very basic questions, but it doesn't becomes
clear by reading the board specific manuals.=20


Best regards

Frank.





-----Urspr=FCngliche Nachricht-----
Von: Leonid [mailto:Leonid@a-k-a.net]=20
Gesendet: Montag, 21. Mai 2007 17:28
An: Frank Prepelica
Cc: linuxppc-embedded@ozlabs.org
Betreff: RE: BDI2000 configuration file for MPC8313E-RDB

On Monday, May 21, 2007 12:25 AM Frank Prepelica wrote:
> Sorry, but the BDI does not support programming any NAND flash.
> You can write your own driver. Then load the data and the driver into=20
> SDRAM via the BDI and execute it.

> Well, I think I have to try this, if there's really no other way.=20
> I'm not quite sure, maybe you know the PowerTAB Pro JTAG Debugger,
> (it's recommended in the manuals) could this one get directly access
> to NAND memory?

No, I don't but I would like to learn more about NAND flash programmers.

> Uhm, it's possible that achieved that in an "indirect" way that I was
> not aware of. But as I said, the complete flash and ram was empty,
just
> loaded=20
> the corresponding BDI config file to BDI2000 JTAG and I got access to
> flash memory where I placed the bootloader image. Hmm, anyway ;)

> The BDI config: http://www.ultsol.com/config/Emb%20Planet/83xx.cfg

It's still not clear from your description what has been done - "I got
access to flash memory" sounds too vague. It's quite possible that SW
you are using does the trick; at least you have some file, loaded from
the host to RAM:

[HOST]
IP          10.0.0.198
FILE        PCB82xx120.ep

Where did you get this PCB82xx120.ep file from?

In any rate, FLASH section of this configuration file specifies NOR
flash so it's out of question that BDI2000 could program NAND by itself:

[FLASH]
CHIPTYPE    MIRRORX16   ;Flash type: Micron Q-Flash MT28F640J3

Moreover, since workspace is disabled, direct image programming shall be
really slooow - you had to notice that. Did you? Most likely not - SW
burned your flash.


Best regards

Leonid.
