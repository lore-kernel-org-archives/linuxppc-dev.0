Message-ID: <01C065EA.89787760@NB2>
From: torsten.rissel@t-online.de (Torsten Rissel)
To: "'Matt Porter'" <mporter@mvista.com>
Cc: "Linuxppc-Embedded (E-Mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: AW: MVME 5100
Date: Thu, 14 Dec 2000 16:25:55 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks, but I have already set up a BAT to cover the area from 0xf0000000 - 0xffffffff
because everything is there on the MVME5100 - the serial ports (via the Hawk external
registers) [fef88000+], the MPIC [f3f80000+] and the PHC PCI registers [fe000000+].

The CONFIG_ADDRESS and CONFIG_DATA registers are on fe000cf8 and fe00cfc,
and still writing to the CONFIG_ADDRESS and then reading the CONFIG_DATA sometime
works and sometimes not !!!??

Torsten

-----Ursprungliche Nachricht-----
Von:	Matt Porter [SMTP:mporter@mvista.com]
Gesendet am:	Mittwoch, 13. Dezember 2000 21:41
An:	Torsten Rissel
Cc:	Linuxppc-Embedded (E-Mail)
Betreff:	Re: MVME 5100


On Wed, Dec 13, 2000 at 10:39:59PM +0100, Torsten Rissel wrote:
>
> Hi Everybody !
>
> I am trying to run Linux on an MVME5100 board. I am using PReP-style booting and
> got the boot process and some of the kernel initialization running. But I am missing any
> knowledge of other PowerPC boards or machines, so that it is relativly hard to find out
> what exactly to change. So I have a question: The MVME5100 is missing all ISA stuff.
> Is the IRQ mapping (first 16 for the 8259 and the other 16 for the MPIC) still valid ?

Might as well just use 16-31 and stick with the MPIC convention.  If
somebody else is using the 5100 with the IPMC761 then they will have
ISA and will thank you many times for not changing things.

> Also I run in a problem: the indirect mechanism for generating PCI config cycles is set
> up correctly, but the board seems to hang when reading from the CONFIG_DATA address !!!???

Make sure you have those Hawk registers covered with a BAT or PTEs.
Notice the areas covered by BATs in the MACH_prep BAT setup case in
arch/ppc/mm/init.c.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
