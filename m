Message-ID: <3BD4681C.C3FE8A8C@mvista.com>
Date: Mon, 22 Oct 2001 14:40:28 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: John F Davis <johndavi@us.ibm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405GP cat /proc/interrupts
References: <OF8E67EA1A.B526D51D-ON85256AED.0064781F@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John F Davis wrote:

> ....  With that said, why does cat /proc/interrupts say that I am
> using Edge Sensitive interrupts when I have
> modified the TR register to be Level sensitive?

Because the information printed by /proc/interrupts doesn't come directly
from the hardware registers, but rather (and irrelevant in this case) part
of the irq descriptor structure.  You could set a bit in the irq descriptor
to make the print out pretty, but it won't have any effect on the system.
The proper solution is to set the the information in the irq descriptor,
and have the controller initialization read this and program the hardware
registers properly.  You just skipped to the last step.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
