Message-ID: <01C068F5.2F343240@NB1>
From: torsten.rissel@t-online.de (Torsten Rissel)
To: "'Matt Porter'" <mporter@mvista.com>
Cc: "Linuxppc-Embedded (E-Mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: AW: MVME 5100
Date: Mon, 18 Dec 2000 13:19:41 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


-----Ursprungliche Nachricht-----
Von:	Matt Porter [SMTP:mporter@mvista.com]
Gesendet am:	Freitag, 15. Dezember 2000 23:38
An:	Torsten Rissel
Cc:	Linuxppc-Embedded (E-Mail)
Betreff:	Re: MVME 5100


On Thu, Dec 14, 2000 at 04:25:55PM +0100, Torsten Rissel wrote:
> Thanks, but I have already set up a BAT to cover the area from 0xf0000000 - 0xffffffff
> because everything is there on the MVME5100 - the serial ports (via the Hawk external
> registers) [fef88000+], the MPIC [f3f80000+] and the PHC PCI registers [fe000000+].

Right, I have one as well as a similar Hawk-based board that has Linux
on it.

> The CONFIG_ADDRESS and CONFIG_DATA registers are on fe000cf8 and fe00cfc,
> and still writing to the CONFIG_ADDRESS and then reading the CONFIG_DATA sometime
> works and sometimes not !!!??

I can consistently read from and write to config space on my 5100 board
via PPCBUG.  The only thing I can think of is that you have somehow
locked up the Hawk bridge.  I've managaged this on other host bridges
only by getting a PIB locked up and squatting on the bus.

[Torsten Rissel]  I never saw any problem with PPCBUG neither, still, during kernel startup
it sometimes works and sometimes not. Now it works a little bit better, because I found out
that the BAT configuration constructed in mapin_ram() didn't work properly.

What kernel version are you using as a basis for your port?  Are you
basing the port off the existing prep_*.c support?

[Torsten Rissel]  I've downloaded linuxppc-2-2-snap-tar.gz from fsmlabs (It's my first try with
linux on PowerPCs, so I just took more or less the first I read about).
And, yes, I set CONFIG_6xx, CONFIG_PPC, CONFIG_PREP and one I invented (CONFIG_MVME51xx).
I use PREP-style network boot from PPCBUG. In the moment I try to get the eepro100 driver
working, because I want to use a root-fs on NFS.

[Torsten Rissel]  Regards, Torsten

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
