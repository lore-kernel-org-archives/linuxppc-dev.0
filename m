Return-Path: <nhickman@dtechlabs.com>
Received: from mail.dtechlabs.com (66.239.149.149.ptr.us.xo.net
	[66.239.149.149]) by ozlabs.org (Postfix) with SMTP id 7A7F1DDF42
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jun 2007 02:54:55 +1000 (EST)
Subject: RE: mpc8270 & Intel 82551ER on 2.6.17.14
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Fri, 29 Jun 2007 12:54:52 -0400
Message-ID: <8140AAF341CC904BA92C3D6A5A1909782A2FB9@ditech-1.ditechllc.com>
In-Reply-To: <200706291648.l5TGmSS17074@sierra.gdatech.com>
References: <200706291648.l5TGmSS17074@sierra.gdatech.com>
From: "Nicholas Hickman" <nhickman@dtechlabs.com>
To: "Muruga Ganapathy" <gmuruga@gdatech.com>,
	"Pradyumna Sampath" <pradyumna.sampath@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the reply.

I believe that the EEPROM is programmed correctly.  At lease the driver
seems to think so.  I am still leaning towards the interrupts not being
properly initialized on the PCI bus.  I am currently trying to track
this down. =20


Here's the output of what I have for one of the Ethernet controllers.

# cat /proc/interrupts
           CPU0      =20
 20:          0   CPM2 SIU  Level     eth0
 24:          0   CPM2 SIU  Level     PQ2 PCI cascade
 40:        154   CPM2 SIU  Level     cpm_uart
BAD:          0
# lspci -vvv
00:12.0 Ethernet controller: Intel Corporation 8255xER/82551IT Fast
Ethernet Controller (rev 10)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium =
>TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (2000ns min, 14000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at 00000000affff000 (32-bit, non-prefetchable)
[size=3D4K]
        Region 1: I/O ports at 1ffffc0 [size=3D64]
        Region 2: Memory at 00000000affc0000 (32-bit, non-prefetchable)
[size=3D128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

 ethtool -e eth0
Offset          Values
------          ------
0x0000          00 50 c2 70 7a 01 80 a1 ff ff 01 02 01 47 ff ff=20
0x0010          ff ff ff ff a0 d0 00 00 00 00 ff ff ff ff ff ff=20
0x0020          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
0x0030          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
0x0040          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
0x0050          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
0x0060          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
0x0070          ff ff ff ff ff ff ff ff ff ff ff ff ff ff 92 3d=20



Thanks again,
-Nick


-----Original Message-----
From: Muruga Ganapathy [mailto:gmuruga@gdatech.com]=20
Sent: Friday, June 29, 2007 12:48 PM
To: Pradyumna Sampath; Nicholas Hickman; linuxppc-embedded@ozlabs.org
Subject: Re: mpc8270 & Intel 82551ER on 2.6.17.14



1. You may want to check whether the device is configured properly by
   enabling the debug statements or using the lspci command. I mean the=20
   BAR registers.

2. Also check whether correct the interrupt is assigned to the=20
   device using cat /proc/interrupts command under linux.=20

3. As far as the EEPROM is concerned, you need to enable debug to check=20
   whether there is any check sum error. If there is a check sum error=20
   in EEPROM, the device may not come up too. As you are using it in=20
   powerpc platform, you need to take care of the endianess while=20
   writing to the EEPROM.

Hope this helps!

Thanks
G.Muruganandam



> Hi Nicholas,
>=20
> On 6/29/07, Nicholas Hickman <nhickman@dtechlabs.com> wrote:
> >
> >
> > I am having trouble getting two 82551ER Ethernet controllers
running in
> > Linux.  I am able to scan the PCI bus and see the devices and I was
even
> > able to program the EEPROM from U-boot.
> >
> > In the kernel I mapped the IRQ's through /arch/ppc/m82xx_pci.c. =20
I've been
> > using the e100 drive that comes with the 2.6.17.14 kernel and have
also
> > tried the driver directly from Intel.  Both give the same results. =20
The PCI
> > scan shows the correct output for how the device should be
configured.
> <snip..>
>=20
> I have the same, exact same problem. But there are some of the=20
> differences with the setup though. I have an MPC5200B and the other=20
> difference is that I have a 2.6.21-rt3. However its the same ethernet=20
> controller.
>=20
> I am trying out a few things here, some of them being complete=20
> guesses. But if I hit something, I will let this list know. Anyone=20
> else had similar issues ? Request you to please holler.
>=20
> regards
> prady
> --
> htp://prady.livejournal.com
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

*************************************************************
GDA Technologies, Inc.	=09
1010 Rincon Circle
San Jose CA, 95131
Phone	(408) 432-3090
Fax	(408) 432-3091

Accelerate Your Innovation=09
**************************************************************


=3D=3D=3D=3D=3D
This message contains information from GDA Technologies Inc and
affiliates, and is intended for the sole use of the individual and
entity to whom it is addressed. It may contain information, including
any attachments, that is privileged, confidential and exempt from
disclosure under applicable law. If you are not the intended addressee,
nor authorized to receive for the intended addressee, you are hereby
notified that you may not use, copy, disclose or distribute to anyone
the message or any information contained in the message. If you have
received this electronic transmission in error, please notify the sender
immediately by a "reply to sender only" message and destroy all
electronic and hard copies of the communication, including attachments.
=3D=3D=3D=3D
