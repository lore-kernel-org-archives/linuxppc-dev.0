Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29E1FDE3DF
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 02:01:38 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m6MG1Xfk012675
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 18:01:33 +0200
Message-ID: <04ea01c8ec14$36663c70$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: "ppcdev" <linuxppc-dev@ozlabs.org>
References: <93c791ba2d4ce372589da84acd14a15c@bga.com><20080718034727.GF18748@yookeroo.seuss><02ec01c8e8b2$52717890$ad289e86@LPSC0173W><007a845ba2b60b02a256b58632490b27@bga.com>
	<048601c8ebe8$acbfcc50$ad289e86@LPSC0173W>
Subject: Re: Calling the kernel from a mini-bootloader
Date: Tue, 22 Jul 2008 18:01:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Answering to myself to try and provide more background info:

> As a follow up to my previous messages, I now have a working kernel and a 
> working bootloader... but not when they are both together.
>
> Case in point:
> - load zImage.elf to DRAM 0x400000 with JTAG debugger. Run it. It runs 
> fine.
>
> - Load Bootloader.elf to BRAM 0xFFFF0000 with JTAG debugger. Run it. It 
> runs fine (but it doesn't do much yet).
>
> - Now load both of the previous ones, and have the bootloader perform a 
> jump to kernel:
void main() {
     typedef void tFunc(void);
     ((tFunc *)0x400000)();
}

Now if the bootloader _only_ contains the above code, the kernel runs 
perfectly.
Unfortunately I need to do some things in the bootloader: I use 3 GPIOs to 
control a frontal set of LEDs, to get a card number and to load/unload a 
serial flash memory. Those operations work. But here is the strange thing 
that leads me to believe there are interrupt interferences.

If I just read from a GPIO before launching the kernel, it boots fine, with 
a few NFS errors when mounting the rootnfs:
[    4.360060] Freeing unused kernel memory: 76k init
[   11.432269] nfs: server 192.168.1.185 not responding, still trying
[   11.441186] nfs: server 192.168.1.185 OK
init started: BusyBox v1.10.1 (2008-04-24 12:26:38 CEST)
genepy login:

Now if I also write to a 2nd GPIO, I get a lot more NFS errors.

And if I also access the flash through the 3rd GPIO, the kernel hangs:

> loaded at:     00400000 004EA19C
> board data at: 004E8120 004E819C
> relocated to:  0040405C 004040D8
> zimage at:     00404E48 004E7A7E
> avail ram:     004EB000 08000000
>
> Linux/PPC load: console=ttyUL0,115200 rw root=/dev/nfs ip=bootp
> Uncompressing Linux...done.
> Now booting the kernel
>
> But then it hangs for exactly 3 minutes, nothing on the serial port, 
> before the bootloader restarts.
> Why should the behavior be different whether it's started from the 
> debugger or from my bootloader ?

Now I've defined my hardware project using interrupts on the GPIOs, which I 
don't need and frankly they don't make sense for an output GPIO. I would 
like to try to compile a kernel without GPIO interrupts, unfortunately the 
compilation fails:
$ make ARCH=ppc CROSS_COMPILE=powerpc-linux-uclibc-
[...]
  CC      arch/ppc/syslib/virtex_devices.o
arch/ppc/syslib/virtex_devices.c:535: error: 'XPAR_INTC_0_GPIO_0_VEC_ID' 
undeclared here (not in a function)

Question breakdown:
- do I need interrupts for GPIOs ?
- how can I compile the ppc 2.6.25 kernel without them ?
- Why do I have problems running the kernel if the bootloader makes use of 
the GPIOs ?
- does the bootloader need to perform some kind of special cleanup before 
calling the kernel ?

Thanks a lot for shedding a light on those mysteries.
-- 
Guillaume Dargaud
http://www.gdargaud.net/ 
