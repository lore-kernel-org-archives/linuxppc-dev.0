Message-Id: <200011072326.eA7NQI622146@denx.local.net>
To: "Karaaslan, Utku" <UKaraasl@drs.ca>
cc: LinuxPPC Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PpcBoot running but not the linux kernel? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 07 Nov 2000 16:26:21 EST."
             <585D9BAABBE7D211A2B00000F8050AAF759A09@thebrain.drs.ca>
Date: Wed, 08 Nov 2000 00:26:18 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


*** Please:
*** Send PPCBoot related messages to the PPCBoot mailing lists.

In message <585D9BAABBE7D211A2B00000F8050AAF759A09@thebrain.drs.ca>
Utku Karaaslan wrote:
>
> I have ported the ppcboot to our custom board and everything runs correctly
> except

Congratulations.

> the linux kernel :). Basically, it fails to start (no output, just hangs)
> and upon checking
> with the BDM debugger (Lauterbach) I found out that it was failing right
> after the mmu
> initialization (in head.S). The IMMR location given in the kernel matches

Please see the "Linux for PowerPC Embedded Systems HOWTO", especially
http://members.nbci.com/_XMCM/greyhams/linux/PowerPC-Embedded-HOWTO-18.html#ss18.1

Most probably you need to set DER to a value that allows Linux to use
the MMU without causing debug events; 0x2002000f  is  a  pretty  good
value to use.


Also, please note that AFAIK the Lauterbach debugger does not support
the MMU. It will not be helpful to debug Linux kernel or driver code.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"A complex system that works is invariably found to have evolved from
a simple system that worked."             - John Gall, _Systemantics_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
