Message-ID: <3CD7F783.8070704@pacbell.net>
Date: Tue, 07 May 2002 08:49:23 -0700
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ibm_ocp_enet.c - PHY implementation requirements?
References: <NCBBIINEHIPFGJPLBEIFEEJNDGAA.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen Curtis wrote:
> We have an 405GP design, very similar to the Walnut LSP. One of the major
> differences is that we have a BroadCom 9-port switch instead of a dedicated
> PHY for Ethernet. Supporting the switch is much easier than a dedicated PHY
> because you can always assume:  100Mb, Full-Duplex and you do not have to
> handle disconnect and mode change interrupts. The problem is that the OCP
> Ethernet implementation has become much more complex and it is not obvious
> what must be supported when adding a new interface and what could be a stub.
> (and its expected result)
>
> Another issue is that the switch supports both the MII and SPI interfaces.
> These are mutually exclusive, determined by first access to the device. Our
> design requires the use of the SPI interface. All currently supported PHY
> are MII, which is expected. Do you forsee any problems using SPI within
> ibm_ocp_phy.c?
>
> TIA

There are a few stubs for the zmii bridge

The MII functions can most likly be placed into it's own file and you
might want to think about creating  a spi.c file for its implimentation.
  This would allow us to have them be complied in depending on what mode
is configured. The questions is can we come up with a common api to mii
& spi?



armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
