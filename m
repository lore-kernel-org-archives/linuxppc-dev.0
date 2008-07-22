Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29F25DE0F7
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 20:49:59 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m6MAnsMD004079
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 12:49:54 +0200
Message-ID: <048601c8ebe8$acbfcc50$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: "ppcdev" <linuxppc-dev@ozlabs.org>
References: <93c791ba2d4ce372589da84acd14a15c@bga.com><20080718034727.GF18748@yookeroo.seuss><02ec01c8e8b2$52717890$ad289e86@LPSC0173W>
	<007a845ba2b60b02a256b58632490b27@bga.com>
Subject: Re: Calling the kernel from a mini-bootloader
Date: Tue, 22 Jul 2008 12:49:49 +0200
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

Thank you Milton for the detailed explanation. It'll take me quite a while 
to digest it.


As a follow up to my previous messages, I now have a working kernel and a 
working bootloader... but not when they are both together.

Case in point:
- load zImage.elf to DRAM 0x400000 with JTAG debugger. Run it. It runs fine.

- Load Bootloader.elf to BRAM 0xFFFF0000 with JTAG debugger. Run it. It runs 
fine (but it doesn't do much yet).

- Now load both of the previous ones, and have the bootloader perform a jump 
to kernel:
     typedef void tFunc(void);
     ((tFunc *)0x400000)();

The kernel seems to start:

loaded at:     00400000 004EA19C
board data at: 004E8120 004E819C
relocated to:  0040405C 004040D8
zimage at:     00404E48 004E7A7E
avail ram:     004EB000 08000000

Linux/PPC load: console=ttyUL0,115200 rw root=/dev/nfs ip=bootp
Uncompressing Linux...done.
Now booting the kernel

But then it hangs for exactly 3 minutes, nothing on the serial port, before 
the bootloader restarts.
Why should the behavior be different whether it's started from the debugger 
or from my bootloader ?
-- 
Guillaume Dargaud
http://www.gdargaud.net/
