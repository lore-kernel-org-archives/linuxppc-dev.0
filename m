Mime-Version: 1.0
Message-Id: <p04320400b59877f5cc70@[192.168.240.10]>
In-Reply-To: <20000715082955.6590@192.168.1.10>
References: <Pine.GSO.4.10.10007150057110.4812-100000@unix1.wm.edu>
 <20000715082955.6590@192.168.1.10>
Date: Mon, 17 Jul 2000 11:22:18 +0200
To: Benjamin Herrenschmidt <bh40@calva.net>,
        Paul Mackerras <paulus@linuxcare.com>
From: Alain RICHARD <alain.richard@equation.fr>
Subject: MacSerial and Serial driver cohabitation
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  >On my Rev. D iMac, disabling CONFIG_SERIAL means I am unable to use my
>>internal modem.  I expect it would be the same story on an iMac DV.  So it
>>turns out serial support is important for something on an iMac.  :)
>
>I think your a mixing legacy serial support that must _not_ be enabled on
>PowerMacs (CONFIG_SERIAL) and the Macintosh serial support (I don't have
>the config option name with me now). Only the latest is needed for your iMac.
>
>Ben.
>
>

There is a long waiting problem in making the two serial drivers
(legacy serial driver named serial.o and macintosh serial driver
named macserial.o). The problem is that the two drivers thinks there
are the legacy one and numbers each serial port found from ttyS0 to
ttySn. So if you try to load them simultaneously, you'll get a kernel
fault.

There are several workarounds, either :

- compiles only macserial and disable legacy serial.
- compiles the two drivers as modules and load only one (by adding
"alias char-major-4 macserial" and "alias char-major-5 macserial" in
your /etc/conf.modules file).

This is just a hack, but the problem is worst : macserial is a serial
driver for Z8530 chipsets and serial is a serial driver for 16x50
UARTs. There are several cases where you may need the two drivers :

a) in a powerbook when using a pcmcia modem : most, if not all, modem
cards are based on a 16x50 UART and do need the serial.o driver.
b) most PCI serial cards are using 16x50 UARTs

Powerbooks kernels compiled by Paul Mackerras have a quick fix in the
serial driver in order to make it skip the first 2 ttyS entries when
compiled on PMAC architecture. This fix works but was never included
in the main kernel because it is just a simple hack.

Looking at the current kernel code, I have found that there is now a
new serial driver called serial167.c (for another serial chipset)
that is avoiding the problem by allocating its ttySn after all
curently allocated ttySn and not starting from ttyS0).

So I think a very simple fix would be to add a similar patch to
macserial AND serial so that all serial drivers may be loaded at the
same time without problem . This fix may have to be also added to all
the other serial devices in the various Linux ports (mac_SCC for
Linux 68k, sunserial for Linux Sparc for example).

I have seen a lot of complain about that simple silly problem, and I
think this will be a good thing to fix. What do you think about it ?
Is there anybody working on this stuff (macserial and sunserial is
maintained by paulus) or should i submit separate patch to linus and
the various maintainers ?

Regards,




--
-------------------------------------------------------
Alain RICHARD <mailto:alain.richard@equation.fr>
EQUATION SA <http://www.equation.fr/>
Tel : +33 477 79 48 00	 Fax : +33 477 79 48 01
Applications client/serveur, ingénierie réseau et Linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
