Message-Id: <2.2.32.20000501224050.00d776fc@electra.znyx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 01 May 2000 15:40:50 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: Jochen Roth <jochen@znyx.com>
Subject: Re: Board boots when in BDM, hangs otherwise
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Josh,

The EST BDM tool sets up the PPC core and some of the standard
peripherals, like the SDRAM controller, when you use the IN
command. The INN command does just reset the chip. Your boot
ROM needs to initialize all registers properly, then it should
work.

After IN, try the DR (display register) command, and DR PCI
for PCI config registers. Compare to the readouts after INN
(initialization without presets) and you see the differences.

Jochen

At 02:36 PM 5/1/00 -0500, Joshua Horvath wrote:
>
>I've got a custom 855T based board that I'm having trouble getting Linux to
>boot up on consistently.
>
>I've written a simple bootloader that allows me to TFTP an image to RAM and
>execute it.  If I download this program via the BDM port and run it, everything
>works fine.  The ethernet download works fine and the kernel boots without a
>hitch.
>
>I then progammed this code into flash and although everything appears to work
>correctly, Linux won't boot after downloading the image to RAM.  I've verified
>that the image is in fact uncorrupted after download so I would expect it to
>boot correctly.  The bootup goes like this:
>
>loaded at:     00210000 0021C578
>relocated to:  00100000 0010C578
>board data at: 001001C8 001001E4
>relocated to:  00200100 0020011C
>zimage at:     00217000 00282603
>initrd at:     00282603 00459440
>avail ram:     0045A000 01000000
>
>Linux/PPC load:
>Uncompressing Linux...done.
>Now booting the kernel
>Linux version 2.2.13 (srossi@boston.ccrl.mot.com) (gcc version 2.95.2 19991024
>(
>release)) #152 Wed Apr 26 15:22:16 CDT 2000
>Boot arguments: root=/dev/ram
>time_init: decrementer frequency = 187500000/60
>Calibrating delay loop... 49.46 BogoMIPS
>clear_bit(0, c01381c0)
>NIP: C0007030 XER: E000217F LR: C0007030 REGS: c00dcb50 TRAP: 0300
>MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
>TASK = c00dac90[0] 'swapper' mm->pgd c00d9000 Last syscall: 0
>last math 00000000
>GPR00: C0007030 C00DCC00 C00DAC90 0000001A 00000001 00000017 00000000 C00F6849
>GPR08: 00000017 C00F0000 FF002808 C00DCB40 95113133 000191B8 00004C00 00000000
>GPR16: 00000000 C04DCC00 C00F0000 C0120000 C0120000 00000000 00000000 C015B000
>GPR24: C0120760 00000000 C012075C C1000000 C00F0000 00000001 C1000000 00000001
>Call backtrace:
>C0007030 C00EBC5C C00EA6E4 C000221C
>Kernel panic: kernel access of bad area pc c0007030 lr c0007030 address
>C1000000
> tsk swapper/0
>In swapper task - not syncing
>Rebooting in 180 seconds..
>
>
>I'm using the EST VisionICE box to do the BDM download.  Now, the weird thing
>is, if I do an "IN" command (which does some basic initialization and puts the
>processor in debug mode) and then jump to flash and execute my code, everything
>works fine.  My bootloader code also does board initialization and as far as I
>can tell I'm setting up the registers the exact same way, so I can't figure out
>what is getting configured differently by the VisionICE box.  I've disabled the
>MMU and the caches.
>
>I've also noticed that the code executes faster after I do an "IN" and jump to
>flash (i.e. when I'm in BDM) versus when I just powerup or do a hard reset and
>have the code execute automatically.
>
>Does anyone know what the problem might be?  Since it runs correctly after
>being initialized by the VisionICE box I assume something is wrong with my
>hardware init routine but I can't figure out what that is.
>
>Thanks,
>-Josh
>
>
--
Jochen Roth, ZNYX Networks
jochen@znyx.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
