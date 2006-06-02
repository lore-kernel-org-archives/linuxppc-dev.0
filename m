Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 82B63679E1
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Jun 2006 02:45:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC85xx PCI transfer disconnect
Date: Fri, 2 Jun 2006 09:45:04 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE4871053883A1@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "Liu Dave-r63238" <DaveLiu@freescale.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> The 85xx cacheline is 32 bytes.

Yes, so it is. =20

> Did you enable Memory Read Multiple command of your PCI master?

Thanks for the clue.  I'm trying to figure out how to do this.  The PCI
master is a Tundra TSI148 VME-PCI bridge.  The documentation says it
supports the PCI read multiple cycle, but so far I haven't found a
register to specifically configure it.  I'll check the C/BE lines to see
if a PCI read multiple cycle is being issued.

I have confirmed that 64 bytes are being transferred before the MPC85xx
disconnects the transfer.  If the PCI master initiates a 32 byte or 64
byte read, the MPC85xx does not disconnect the transfer.

Tim

> -----Original Message-----
> From: Liu Dave-r63238 [mailto:DaveLiu@freescale.com]
> Sent: Thursday, June 01, 2006 8:52 PM
> To: Martin, Tim; linuxppc-embedded@ozlabs.org
> Subject: RE: MPC85xx PCI transfer disconnect
>=20
>=20
> > I know this is probably a question for Freescale directly,
> > but I thought I would post here to see if anyone else has
> > seen similar issues with the MPC85xx PCI under Linux.
> >
> > I'm using a Freescale MPC85xx (8541) processor and seeing an
> > extreme slowness to the PCI bus.
> >
> > I'm attemping to do 2048 byte PCI burst reads from an
> > external PCI master.  So an external chip is the PCI master
> > ("initiator") and the MPC85xx is the PCI slave ("target")
> >
> > When initiating the PCI burst read, there is a 270 ns delay
> > from the MPC85xx claiming the transaction (DEVSEL# going low)
> > to being ready (TRDY# going low).  Then 64 bytes (a single
> > cacheline) are transferred, and TRDY# goes inactive.  Next,
> > STOP# goes low, terminating the transfer.  I believe this is
> > considered a PCI DISCONNECT type 1 since IRDY# is active the
> > entire time.
> >
>=20
> The 85xx cacheline is 32 bytes.
> Did you enable Memory Read Multiple command of your PCI master?
>=20
> > What I would expect is that the entire 2048 bytes are
> > transferred in one PCI bus mastership, but instead there are
> > several re-arbitrations and long delays in between several 64
> > byte transfers.
> >
> > Additional info:
> > The PCI bus is 64bit running at 66 MHz.
> > I'm running a modified Linux 2.6.9 kernel (elinos-111).
> > The PCI CCSR piwar1 =3D 0xa0f4401d.
> >
> > Freescale has an FAQ 21021 that describes having a PCI
> > DISCONNECT 2, which sounds similar to my problem, but I've
> > already confirmed I'm doing what the FAQ suggests (enable
> > prefetching in the piwar register)
> > (http://www.freescale.com/webapp/sps/utils/SingleFaq.jsp?FAQ-2
> 1021.xml)
>=20
> Any thoughts/suggestions would be appreciated,
> Tim
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-
> embedded
