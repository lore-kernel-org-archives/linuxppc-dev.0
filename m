Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2555EDE64A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 00:09:03 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m6HDMbYo015730
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 15:22:38 +0200
Message-ID: <021101c8e810$2e810fb0$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Calling the kernel from a mini-bootloader
Date: Thu, 17 Jul 2008 15:22:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,
I'm in the process of writing a mini-bootloaler for a custom board and would 
like some feedback on my boot methodology.

Basically the kernel code (elf file) is copied into memory by a JTAG 
debugger. A custom program (yet to be finished) then copies it onto an 
onboard flash memory using serial commands. This flash is not part of the 
flat memory addressing.

When I want to boot, I have a small bootloader put into an eprom that _is_ 
part of the flat memory addressing. This (finished but not tested yet) 
bootloader basically does two things:
- it copies the content of the first flash into RAM
- it launches it using a custom function call like "0x400000();"

Now, I'd like to know if this is a reasonable approach ? I couldn't think of 
a better way, but maybe there are issues I didn't think off.


One additional question, if the above is valid, is that I would like to pass 
a particular argument to the kernel to set its MAC address. I can read an 
external value (similar to jumpers) from the bootloader via GPIO. Is there a 
way to pass this value to the kernel so that a modified 
arch/ppc/boot/simple/embed_config.c can use it to set the MAC address ?

Maybe the main() of the kernel can receive argv/argc the usual way, and I 
just need to call "0x400000(argc, argv);" but I have no idea if that works. 
Thanks for suggestions.
-- 
Guillaume Dargaud
http://www.gdargaud.net/
