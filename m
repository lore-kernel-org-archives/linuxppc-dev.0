Date: Thu, 7 Nov 2002 10:09:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: serial reset?
Message-ID: <20021106230903.GD1746@zax.zax>
References: <1036602788.17846.146.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1036602788.17846.146.camel@granite.austin.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Nov 06, 2002 at 11:13:08AM -0600, Hollis Blanchard wrote:
>
> Hi, I'm working on sleep on the 405LP. In one mode the chip is powered
> down and all state must be saved/restored by software.
>
> My current problem is with the UART (and I'm using serial console only,
> so it's problem). When I wake up, I can type commands to my shell and
> see them echoed correctly. However the result of those commands is
> garbled, like so:
>   ls
>     1  tm[lc ;u;v  43m
> Sometimes I get the message "ttyS: 1 input overrun(s)". Return
> characters come through as spaces.

This is a wild guess, but could it be that FIFO mode hasn't been
turned on during the restore.  That way individual characters being
echoed (slowly) might work, but faster transfers get garbled, because
the 405 can't keep up with the interrupts.

The other thing to check would be the various bits in the CPC which
affect the serial port.

> I've tried to save/restore the UART registers just like all the others.
> Unfortunately FCR is write-only, and my attempts have just resulted in
> no serial activity at all.
>
> I've also tried the unregister_serial/register_serial calls to the
> serial driver (intended for PCMCIA). I can't see how those ever worked
> register_serial to complain the device is already open. When I hack the
> driver though, I get the same result though: dead serial.
>
> This is a 2.4.17 kernel. Can you think of anything situation that would
> allow correct character echo but not output? I don't mind going through
> a full serial initialization if necessary, but it doesn't look like the
> driver was mutated *ahem* written with this in mind...
>
> -Hollis
>
>

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
