Date: Thu, 26 Aug 2004 08:42:33 -0400 (EDT)
From: "Mark S. Mathews" <mark@linux-wlan.com>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: m8xx hang in reboot
In-Reply-To: <1268A0DE-F710-11D8-89B4-003065F9B7DC@embeddededge.com>
Message-ID: <Pine.LNX.4.61.0408260835410.19804@chef.linux-wlan.com>
References: <Pine.LNX.4.61.0408251615540.9890@chef.linux-wlan.com>
 <1268A0DE-F710-11D8-89B4-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 25 Aug 2004, Dan Malek wrote:

>
> On Aug 25, 2004, at 4:22 PM, Mark S. Mathews wrote:
>
>> I've got an mpc850 based setup running 2.4.27 that, under certain
>> circumstances, hangs in the the m8xx_restart() function (instead of
>> rebooting) when I issue the usermode reboot cmd.
>
> Hmmmm......
>
>> I've traced all through the path and confirmed that yes, it is hanging in
>> this function.  ;-)
>
> Does it get as far at the printk that indicates the checkstop failed?

No it doesn't.  I know that printk would generate output (if we
reached it) because I've added other printks to the function to narrow
down the failure point.   To actually get the output has required that I
temporarily disable the cli() and I have to add delays after each printk
to allow the serial output to complete.  Just stupid debug stuff.


>> I'm still looking over the databook and what this code does.  Just figured
>> I'd ask around and see if anyone else has seen this behavior.
>
> It's supposed to enable a "checkstop" reset, such that on a bad
> bus cycle that times out the processor will be reset.  Then, it
> forces a bad bus cycle.  Since it works in most cases, I suspect
> the problem is outside of the processor.

That code has worked perfectly up til now (this is by no means a new
design).

> This type of reset will cause the processor reset, but it will
> not reset the rest of the hardware on the board.  It seems there is
> something external on the board that must be in a state that
> prevents the bus from operating properly.  The processor
> resets, but can't fetch code properly.

I think you're right.  Your observation and Stefan's post have me thinking
we may have a flash access problem.

> This reset function is generic to all 8xx processors, in that it
> will reset the processor.  Done properly, a system design will
> have some external control register that can be written to
> reset the entire board, just like a power up or pressing a
> reset switch.  Without such complete system reset, this
> is the best we can do, but it certainly is not the same as
> a full reset.

I'll check with the board builder and see if there may be a software
accessible reset chip on the board.

Thanks,
-M

--

Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
721-D North Drive          e-mail: mark@linux-wlan.com
Melbourne, FL 32934        Phone:  321.259.0737
USA                        Fax:    321.259.0286

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
