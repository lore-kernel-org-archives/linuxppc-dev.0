Message-ID: <81A66F72DCACD511B0600002A551BFCB4E9D5E@kuumex05.barco.com>
From: "Callebaut, Benoit" <benoit.callebaut@barco.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RT RE: kernel boot on mpc8245, internal UART
Date: Fri, 7 Mar 2003 08:52:23 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


THe interrupt numbers are configured in the IVPRs( Interrupt Vector
Proiority Registers).
Those registers configure a particular interrupt ( sense,
level,enable,vector,priority)
The purpose of the vector is to map a physical register to a logical
interrupt "channel". Keep those settings, there are good.

> I noticed. And few people use the internal ones :(

This doesn'tmatter normally since these UART are fully 16C550 compliant, you
can use and I think the code use the standard driver for the 16C550 UART.
The only thing that changes is the address of the UART given in the table.

The whole description is in the documentation of Motorola Chapter 12
(MPC8245SUM.pdf)

You will heve to do some research yourself because the standard driver
assume an external UART, so there is also the PCI bus stuff to access it.
But normally
this should not be a problem with the patch and some experience in driver
writing.

Try the Montavista patch. It is based on a 2.4.17 kernel and should work
since the Hardhat distribution is merely a standard distribution with a
custom toolchain.

Best regards.
----------------------------------------------------------------------------
------
Benoit Callebaut
Software Development Engineer
Barco | Control Rooms
Noordlaan 5, 8520 Kuurne, Belgium

Tel 	+32(0)56 36 84 28
Fax 	+32(0)56 36 86 05

mailto:benoit.callebaut@barco.com
http://www.barcocontrolrooms.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
