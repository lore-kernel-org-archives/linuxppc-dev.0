Return-Path: <Ralf.Truebenbach@men.de>
Received: from de2.hostedsecurity.org (de2.hostedsecurity.org [82.98.75.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9BF3DDED3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Sep 2008 19:47:03 +1000 (EST)
Received: FROM [195.127.220.117] ([195.127.220.117]) (envelope-from
	<Ralf.Truebenbach@men.de>) BY de2.hostedsecurity.org
	([82.98.75.133]) WITH ESMTP (EmailSecurity KH67IU80pQXWo) ID
	180785725 FOR <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Sep 2008 09:35:44 +0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: PCI Bus Mapping for MPC8548 with multiple PCI interfaces
Date: Mon, 29 Sep 2008 11:35:44 +0200
Message-ID: <D0B748CCD5DF144CA5C56A9D860A31340FE1C0@men-exch1.intra.men.de>
From: =?iso-8859-1?Q?Ralf_Tr=FCbenbach?= <Ralf.Truebenbach@men.de>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
=20
I'm currently developing a bootloader for a MPC8548 based board. This =
board has got three PCI interfaces (PCI1, PCI2 and PCIe). At the PCIe =
interface the MPC8548 appears as PCI-Bridge (at bus 0 device 0), at the =
PCI1/2 interfaces the MPC8548 appears as normal devices (bus 0 device =
0).

And now I'm a little bit unshure about how Linux expects the PCI bus =
mapping. I see two ways:


A)
--------
MPC8548:   PCI1         PCI2         PCIe
             |           |             |
             |           |             3
             |           |           bridge
             0           2             4
--------     |           |             |
extern:   -------      ------        ------
          |  |  |      |    |        |    |
         dev | dev     dev dev...   dev  dev ...
             0
           bridge
             1
             |
          ---------
          |   |   |
         dev dev dev...

Since I have to create Type 0 Config Read/Writes to access the first bus =
of an interface, my PciConfigRead/Write functions would have to convert =
the bus no. from 0->0 2->0 3->0 (for the example). And PCIe bridge's =
primary bus no. has to be set to 0.



or B)
--------
MPC8548:   PCI1         PCI2         PCIe
             |           |             |
             |           |             0
             |           |           bridge
             0           0             1
--------     |           |             |
extern:   -------      ------        ------
          |  |  |      |    |        |    |
         dev | dev     dev dev...   dev  dev ...
             0
           bridge
             1
             |
          ---------
          |   |   |
         dev dev dev...

Every bus is mapped independently. And PciConfigRead/Write functions =
convert the bus no. so that upper layers (and user) see a bus mapping =
similar to A).

Maybe someone knows how U-Boot or Linux would map the interfaces?

Thank you for your Help.

Ralf


Best Regards/Mit freundlichen Gruessen
=20

Ralf Tr=FCbenbach, Software Design
MEN Mikro Elektronik GmbH
Neuwieder Stra=DFe 5-7
90411 Nuremberg, Germany
Phone +49-911-99 33 5-0
Fax +49-911-99 33 5-910
E-Mail Ralf.Truebenbach@men.de <mailto:Ralf.Truebenbach@men.de>=20
www.men.de <http://www.men.de/>=20

----------------------------------------------------------------------

MEN Mikro Elektronik GmbH - Gesch=E4ftsf=FChrer Manfred Schmitz, Udo =
Fuchs - Handelsregister N=FCrnberg HRB 5540 - UST-ID-Nr./VAT DE 133 528 =
744 - Umsatzsteuer-Nr./Turnover Tax No 238/159/58551 - WEEE-Reg.-Nr. DE =
49081198 - Deutsche Bank AG Kto. Nr. 0390 211, BLZ 760 700 12 - =
HypoVereinsbank Kto. Nr. 1560 224 300, BLZ 760 200 70
