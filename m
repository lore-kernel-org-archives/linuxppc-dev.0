Message-ID: <3891008C.A83C47B4@mvista.com>
Date: Thu, 27 Jan 2000 18:35:56 -0800
From: Jun Sun <jsun@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: the ppc_n_lost_interrupts thing...
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, all,

I am a newbie to PowerPC-linux.  Hopefully this question is
not too dumb.

When I looked into the interrupt related code in ppc-linux,
I got totally confused by the "ppc_n_lost_interrupts"
variable.

Here is the comment from pmac_pic.c file :

        /*
         * Unfortunately, setting the bit in the enable register
         * when the device interrupt is already on *doesn't* set
         * the bit in the flag register or request another
interrupt.
         */

>From this, I can infer that ppc_n_lost_interrupts is used to
"fake" a new interrupt at the end of an interrupt handling.
However,
what I don't understand is - how could this possibly detect an
interrupt that happens while the CPU is blocking external
interrupt?
In this case, ppc_n_lost_interrupts won't be incremented and when
the external interrupt is re-enabled, we won't be able to get
into interrupt mode.

That does not sound right to me.  Could someone shed a light on
this whole "ppc_n_lost_interrupt" thing?  Thanks in advance.


Jun

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
