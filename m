Date: Fri, 10 Jan 2003 18:05:08 +0100
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: PrPMC800 - Restarting PPC7-Bug without a reset
From: Anders Blomdell <anders.blomdell@control.lth.se>
To: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Message-Id: <AC2DA90D-24BD-11D7-98E2-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

We have a number of PrPMC800 systems that are to be run in NON-MONARCH mode.
  Unfortunately they hang indefinitely if I tries to do a [card] reset (full
system reset works). This means that it is impossible to use the Harrier
chip to get the board to do a proper reset.

Therefore I need some way to restart PPC7-Bug without doing a hardware
reset (in the belief that PPC7-Bug will setup the card in a useful state).
The naive attempt to do a "g fff00100" [jumping to the reset exception
handler in flash] from the PPC7-Bug prompt, of course failed miserably, and
so did my attempts to simulate a system reset by the following code:

	lis r0,0xfff0        ; Flash reset vector lives at 0xfff00100
     ori r0,r0,0x0100
     li  r9,0x40          ; Use exception prefix = 0xfffn_nnnn
     mtmsr r9             ; Make msr contain exception prefix bit
     mtsrr0 r0            ; Make rfi return to 0xfff00100
     mtsrr1 r9            ; Make msr after rfi contain exception prefix bit
     sync
     rfi                  ; Simulate a reset

Anybody that has some good idea of what could be done?

Regards

Anders Blomdell


------------------------------------------------------------------------------
  Anders Blomdell
  Department of Automatic Control        Email: anders.blomdell@control.lth.
se
  Lund Institute of Technology           Phone: +46 46 222 4625
  Box 118, S-221 00 Lund, Sweden         Fax:   +46 46 138118


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
