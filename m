Message-ID: <3CB3325B.4090209@embeddededge.com>
Date: Tue, 09 Apr 2002 14:26:35 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 - Spurious interrupt when calling __sti()
References: <F1BED55F35F4D3118C0F00E0295CFF4DFF9F8E@mail.mediatrix.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jean-Denis Boyer wrote:

> On kernel 2.4.10, at boot up, the following message was written to the
> console:
>
>   Unhandled interrupt 0, disabled

How often did you see these?  This message will indicate there was a
hardware interrupt posted to the processor but when we read the vector
register nothing was pending.  Usually race conditions between devices
removing the interrupt signal and interrupts being enabled.

> This message did not appear on kernel 2.4.18 (I don't know why),
> but in /proc/interrupts, the number at the right of BAD was increasing
> slowly.

I'm not sure the processor specific irq function is properly returning a
status to the do_IRQ function.  In this case, the spurious counter will
be incremented without any message.  I do what the comment indicates,
return a -1 if no more pending, but I think there is a hole in the code
that can erroneously update the counter.  It's no big deal, since it
functionally works fine.


> Putting traces in the interrupt handler, it appeared that the interrupt
> happened in '__sti()' (arch/ppc/kernel/misc.S), just after calling 'mtmsr'
> to turn on the 'EE' bit.

Just think about this for a minute.............If there was an interrupt
pending, why are you surprised it occurs as soon as you enable interrupts
in the MSR?

> I added a 'sync', between 'ori r3,r3,MSR_EE' and 'mtmsr r3',
> and it has fixed the problem.

A 'sync' or an 'isync'?  The mtmsr is supposed to be an instruction
synchronizer, so if you required an 'isync' for proper operation then it
would be a silicon mask concern.  If you really added a 'sync' instruction,
this implies to me there is some driver that isn't properly synchronizing
its state with a device.  An operation to acknowledge the interrupt from
the driver is stuck in the pipeline, you enable the interrupts again,
the processor is handed an interrupt, the device is acknowledged (from
the pipeline), and in the interrupt handler we don't find anything.

I would be looking for a driver bug someplace.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
