Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 7816567B15
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Jun 2006 13:52:25 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k5258R64000576
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Jun 2006 23:08:27 -0600 (MDT)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k523qLd4019410
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Jun 2006 22:52:22 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673026FD934@zch01exm40.ap.freescale.net>
From: Liu Dave-r63238 <DaveLiu@freescale.com>
To: "'Martin, Tim'" <tim.martin@viasat.com>, linuxppc-embedded@ozlabs.org
Subject: RE: MPC85xx PCI transfer disconnect
Date: Fri, 2 Jun 2006 11:52:14 +0800 
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> I know this is probably a question for Freescale directly, 
> but I thought I would post here to see if anyone else has 
> seen similar issues with the MPC85xx PCI under Linux.
> 
> I'm using a Freescale MPC85xx (8541) processor and seeing an 
> extreme slowness to the PCI bus.
> 
> I'm attemping to do 2048 byte PCI burst reads from an 
> external PCI master.  So an external chip is the PCI master 
> ("initiator") and the MPC85xx is the PCI slave ("target")
> 
> When initiating the PCI burst read, there is a 270 ns delay 
> from the MPC85xx claiming the transaction (DEVSEL# going low) 
> to being ready (TRDY# going low).  Then 64 bytes (a single 
> cacheline) are transferred, and TRDY# goes inactive.  Next, 
> STOP# goes low, terminating the transfer.  I believe this is 
> considered a PCI DISCONNECT type 1 since IRDY# is active the 
> entire time.
> 

The 85xx cacheline is 32 bytes. 
Did you enable Memory Read Multiple command of your PCI master?

> What I would expect is that the entire 2048 bytes are 
> transferred in one PCI bus mastership, but instead there are 
> several re-arbitrations and long delays in between several 64 
> byte transfers.
> 
> Additional info:
> The PCI bus is 64bit running at 66 MHz.
> I'm running a modified Linux 2.6.9 kernel (elinos-111).
> The PCI CCSR piwar1 = 0xa0f4401d.
> 
> Freescale has an FAQ 21021 that describes having a PCI 
> DISCONNECT 2, which sounds similar to my problem, but I've 
> already confirmed I'm doing what the FAQ suggests (enable 
> prefetching in the piwar register)
> (http://www.freescale.com/webapp/sps/utils/SingleFaq.jsp?FAQ-2
1021.xml)

Any thoughts/suggestions would be appreciated,
Tim
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org https://ozlabs.org/mailman/listinfo/linuxppc-embedded
