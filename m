Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: ibm_ocp_enet.c - PHY implementation requirements?
Date: Tue, 7 May 2002 07:15:19 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFEEJNDGAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We have an 405GP design, very similar to the Walnut LSP. One of the major
differences is that we have a BroadCom 9-port switch instead of a dedicated
PHY for Ethernet. Supporting the switch is much easier than a dedicated PHY
because you can always assume:  100Mb, Full-Duplex and you do not have to
handle disconnect and mode change interrupts. The problem is that the OCP
Ethernet implementation has become much more complex and it is not obvious
what must be supported when adding a new interface and what could be a stub.
(and its expected result)

Another issue is that the switch supports both the MII and SPI interfaces.
These are mutually exclusive, determined by first access to the device. Our
design requires the use of the SPI interface. All currently supported PHY
are MII, which is expected. Do you forsee any problems using SPI within
ibm_ocp_phy.c?

TIA


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
