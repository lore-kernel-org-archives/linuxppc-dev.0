From: "Steve Boorman" <steveb@baydel.com>
To: linuxppc-embedded@lists.linuxppc.org
Date: Fri, 16 Jul 2004 11:49:47 +0100
Subject: PPC440 Kernel Stack overflow
Reply-To: Steve Boorman <steveb@baydel.com>
Message-ID: <40F7C0DB.3069.2BDF12@localhost>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

We recently traced a system hang-up to a bug in one of our drivers.
The bug effectively caused repeated calls to itself, which caused the
Kernel stack to overflow. The surprising thing is that the machine
would just hang, no o/p on the console and all interrupts including
the timer were dead. We never got the message "Kernel stack overflow
in process" which is what I expected.

We are running a ported version of 2.4.26 on our hardware (PPC440GP
based), suspecting that something may be adrift with the port I tried
this with the stock 2.4.26 IBM ebony kernel running on the Ebony eval
board. This was done using a test driver, written as a loadable
module. The driver simulated a kernel stack overflow by repeated
calls to a module within the same module. The result was identical,
ie no messages on the console and the system completely freezes.

Am I expecting too much here, or is something wrong in the kernel
stack overflow detection?

The problem is that this type of hang is very hard to debug. We have
implemented the PPC440 watch-dog in our Kernel port, and whilst that
happily traps code spinning in a loop, it does not trap this kernel
stack problem, presumably because even critical exception interrupts
are not being processed. The watch-dog is definitely expiring.

We do not have (at the moment) a BDI2000 and wondered if it would be
any good at tracking this type of crash down anyway?

Any thoughts on this would be appreciated.

Regards,

Steve Boorman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
