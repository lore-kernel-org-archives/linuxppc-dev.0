Date: Wed, 8 Jan 2003 17:57:38 +0100
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: PrPMC800 running as NON-MONARCH
From: Anders Blomdell <anders.blomdell@control.lth.se>
To: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Message-Id: <4B262319-232A-11D7-98E2-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have finally managed to get our PrPMC800's running as NON-MONARCH and
using its built in Ethernet controller. Now I only have to clean up what I
have done, and remove all hardwired hacks, in order to do this, I would
like comments on the points listed below.

1. I need to find out which of the found Ethernet 82559 chips that belongs
to this card. My suggestion is to compare the Ethernet adress returned from
a "82559 PORT Dump" command with the value stored in the PrPMC800 NVRAM.

2. All Ethernet chips that are not located on the board should be left
alone, how do I do this?

3. prpmc_map_irq needs to be modified to only route interrupts from the
built in ethernet.

4. Should I add a configuration option to use the built in ethernet? There
is a potential IRQ conflict, since the 82559 will generate PCI INTB
requests, and this might lead to conflicts whith the PCI MONARCH. In our
case that is not a problem, since we got a slightly modified ADC-PMC2 from
AlphaData (http://www.alpha-data.com/), which ensures that the INTB never
reaches the PCI bus.

5. I think that it would be a good idea to add some heuristcs to find out
what kind of carrier the PrPMC800 is located on, output from the PPC-Bug
"ver;e" command on different carriers are most welcome.

Regards

Anders Blomdell


------------------------------------------------------------------------------
  Anders Blomdell
  Department of Automatic Control        Email: anders.blomdell@control.lth.
se
  Lund Institute of Technology           Phone: +46 46 222 4625
  Box 118, S-221 00 Lund, Sweden         Fax:   +46 46 138118


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
