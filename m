Message-ID: <1DF71FB881F4D311A6B700C04FA06A1AC43694@orca.desanasystems.com>
From: "Marti, Felix" <fmarti@desanasystems.com>
To: "'Raymond Lo'" <lo@routefree.com>,
	John Cagle <jcagle@kernel.org>, linuxppc-embedded@lists.linuxppc.org
Subject: RE: 405GP network receive problem
Date: Wed, 4 Jul 2001 13:31:54 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hmmm, I'm sorry if this is too obvious and you already checked it, but I
remember that our montavista kernel 2.4.0-test2 did not set the MAC address
correctly... which caused some packets to be dropped.

felix

-----Original Message-----
From: Raymond Lo [mailto:lo@routefree.com]
Sent: Wednesday, July 04, 2001 11:53 AM
To: John Cagle; linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405GP network receive problem



----- Original Message -----
From: "John Cagle" <jcagle@kernel.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, June 29, 2001 10:46 AM
Subject: 405GP network receive problem


>
> I am debugging a custom board design based on the 405GP and have a problem
> receiving lots of TCP/IP traffic (like FTP).  We're using a 2.4 kernel
based
> on Monta Vista's CDK 1.2.  UDP traffic (like TFTP) works very well, but it
> doesn't ever have back-to-back receives, typically.  The problem occurs
> at both 10mbit and 100Mbit.
>
> I have narrowed the problem down (using ttcp) to the following:
>
> During back-to-back receives (within microseconds) of two large (1500
bytes)
> TCP packets, the second packet is usually dropped by the 405GP.  When I
> check ifconfig statistics, it shows the 1 lost packet, but also shows 2
> framing errors.
>
> Has anyone else seen this type of problem with the 405GP or does anyone
> know what the problem might be?
>
> Thanks,
> John
> ------------------------------
> John Cagle <jcagle@kernel.org>
>
>

This can happen if the 405gp MAC is in full-duplex mode, but the other side
is in half-duplex.  The second packet could be corrupted by 405gp sending
TCP acknowledgments without listening for traffic first.

The function in the ppc405_enet driver determines half/full duplex is
ppc405_phy_duplex.  If reading PHY_BMCR does not give the correct duplex
setting, you can try the following.

 -Raymond


static int
ppc405_phy_duplex(void)
{
        int duplex = HALF;          /* Assume HALF */
        unsigned short anlpar = 0x0;

        if (ppc405_phy_read(PHY_ANLPAR,&anlpar)) {
                printk(KERN_ERR "phy duplex read failed \n\r");
                ppc405_phy_dump(KERN_ERR);
        }

        if ((anlpar & (PHY_ANLPAR_10FD | PHY_ANLPAR_TXFD)) != 0)
                duplex = FULL;

        return (duplex);
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
