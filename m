Date: Tue, 22 Oct 2002 09:33:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: question about open_pic and serial port
Message-ID: <20021022163332.GD669@opus.bloom.county>
References: <0B0A39652BB0D411BCCF00508B9512EC08AEB555@tx14exm05.ftw.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0B0A39652BB0D411BCCF00508B9512EC08AEB555@tx14exm05.ftw.mot.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Oct 22, 2002 at 10:23:20AM -0500, Yu Bo-BOYU1 wrote:

>
> Does the current version Mvista preview 2.1 fully support serial mode of 107
> EPIC ?
> If so, what is interrupt number for serial mode interrupt 0 of mpc107 ? I
> reviewed
> the old messages on this list and the open_pic.c and there are some threads
> talking
> about the first 16 interrupts are reserved for 8259 only. Does that mean
> serial mode interrupt
> 0 match interrupt 16 on open_pic interrupt table ?

The way that things are handled internally are still to offset by 16,
when describing the interrupts.  This is no longer true in the community
tree, but on both trees, all interrupts work, and yes, in the mvista
source, interrupt 16 in the table is OpenPIC interrupt 0.

> Plus, I changed the base address of boot/common/ns16550.c to drive the TI
> 752 uart.
> It appears working before kernel starts. Then it hang. It seems that the
> same file (ns16550.c)
> is not used after kernel starts. Which serial device driver is used after
> kernel starts ?

drivers/char/serial.c is used once the kernel starts.  Is this for some
custom hardware?  If you changed boot/common/ns16550.c directly, I
suspect you did something wrong, as it works with numerous base
addresses.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
