Date: Tue, 10 Jun 2003 02:57:03 -0400
From: Callebaut Benoit <callebaut@mailandnews.com>
To: linuxppc-embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Has anyone made the 8240 do burst reads from PCI memory?
Message-ID: <3EE63A5B@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I Ron

>So I was just wondering if anyone has actually gotten an 8240 to access PCI
>memory with multiple beat, memory read cmds.?

The response is yes, We do PCI memory burst write but we had to implements DMA
transfer on the PPC to do this. At low level, this implementation is very
easy, you must just enable the PCI bus snooping bit to avoid "strange" memory
content problem due to the cache.

Per default the PPC will try to send a full DWORD (CBEN[0..3] = 0X0) with one
PCI clock by DWORD.
Such a transfer is 5 time faster than without burst.

Note that you must use physical addresses with the DMA controller. This mean
that you must do the reverse than do ioremap to retreive it. And beware with
virt_to_phys or phys_to_bus, I am not sure that it work with PCI addresses.
I wrote this code, so if you want it, please ask.

Good Luck,
Benoit Callebaut

------------------------------------------------------------------------------
----
Benoit Callebaut
Software Development Engineer
Barco | Control Rooms
Noordlaan 5, 8520 Kuurne, Belgium

Tel 	+32(0)56 36 84 28
Fax 	+32(0)56 36 86 05

mailto:benoit.callebaut@barco.com
http://www.barcocontrolrooms.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
