Message-ID: <3E53E4F2.3020805@mvista.com>
Date: Wed, 19 Feb 2003 12:11:30 -0800
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: Prakash kanthi <pkanthi@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: rs_timer
References: <20030219181822.14372.qmail@web41205.mail.yahoo.com>
In-Reply-To: <20030219181822.14372.qmail@web41205.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Prakash kanthi wrote:
> Hi Folks,
>
> I observed that, even after linux boots and INIT
> process starts, rs_timer stays active and causes the
> rs_interrupt_single to be called.

Depending on your board and the kernel version you're using, this might
be the result of using IRQ 0 for ttyS0 interrupts (as occurs for ppc_405
boards).  The stock kernel from kernel.org does not recognize IRQ 0 as a
valid value, and sets up rs_timer polling instead.  Recent
linuxppc_2_4_devel kernels (and perhaps other ppc kernel trees) are
modified to remove this restriction; see modifications to
drivers/char/serial.c that remove checks for "irq != 0" and such.
MontaVista Linux makes this an optional feature, enabled by defining
SERIAL_IRQ0_VALID.


--
Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
