Message-Id: <s6abd0ea.070@COREL.CA>
Date: Mon, 25 Jan 1999 02:03:05 -0500
From: "Gavriel State" <gavriels@COREL.CA>
To: linuxppc-dev@lists.linuxppc.org
Subject: PCMCIA Interrupt woes - Megahertz XJEM3336
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been struggling this past weekend to try to get my PB2400 to talk 
to my PCMCIA ethernet card.  I'm running kernel 2.2.0-pre7 and I'm 
using the PCMCIA 3.0.5 sources that come with the Pre-R5 distribution.

Originally, once I got the PCMCIA package compiled and installed, the card
would be recognized, but would give a bogus MAC address and wouldn't 
transmit properly.  After a couple of byte-swapping fixes I was able to get
it transmitting properly, but I've been completely unable to get it to recieve
anything (and this includes the responses to ARP packets - my PC netmon
shows the ARP packets being sent and responded to, but my 2400 never
sees the packets).

After putting a few printks in the code, it looks as though the driver's 
interrupt handler is never being called.  I've verified that the card's 
interrupt mask register isn't making out the receive interrupts, so 
nothing seems wrong at that level.  

I've also tried turning on debug info in the i82365 module, but again I 
never see any interrupts except for the 1000 ms polling status timer. 
I tried turning on pci_csc to see if we would get interrupts for card 
status if the polling were off, and didn't see any interrupts at all!
Note that /proc/interrupts claims that the card has been assigned
interrupt 23...

Does anyone have any clues?  This is my first time getting into driver
level issues, and I'm stumped at this point.  If the driver isn't getting
any interrupts it's hard to debug the driver.  Is there any way to querey
the interrupt controller directly to get statistics, etc?  What could be going
wrong here?

Any assistance would be greatly appreciated.

-Gav

--
Gavriel State
Project Leader - Linux Applications Software
Corel Corp
gavriels@corel.com


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
