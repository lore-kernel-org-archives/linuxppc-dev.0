Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFF9F92@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Dan Malek'" <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: 8260 - Spurious interrupt when calling __sti()
Date: Wed, 10 Apr 2002 12:31:05 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

> >   Unhandled interrupt 0, disabled
>
> How often did you see these?  This message will indicate there was a
> hardware interrupt posted to the processor but when we read the vector
> register nothing was pending.  Usually race conditions between devices
> removing the interrupt signal and interrupts being enabled.

On 2.4.10 (and 2.4.16 as someone wrote on this list), this message
appears only once. But then it is flagged as 'DISABLED', and masked
(but this one is non-maskable), and the message is no longer displayed.
In /proc/interrupts, the number beside BAD is 1 and stay.

But the spurious interrupt continue to pop. If I remove the 'DISABLED'
flag, the message is written many times (I see them by executing 'dmesg').
In /proc/interrupts, the number beside BAD grows accordingly.

On 2.4.18, the message never appears, but
in /proc/interrupts, the number beside BAD grows in the same manner.

REASON:
I looked at the patches, and this is because between 2.4.17 and 2.4.18,
in the function m8260_get_irq (arch/ppc/kernel/ppc8260_pic.c),
an 'if(irq == 0) return -1;' has been added.
And so, 'do_IRQ' increments the spurious counter without calling
'ppc_irq_dispatch_handler', the function that was generating the warning.

IMHO, I prefer the way it is handled in 2.4.18.


> > Putting traces in the interrupt handler, it appeared that
> the interrupt
> > happened in '__sti()' (arch/ppc/kernel/misc.S), just after
> calling 'mtmsr'
> > to turn on the 'EE' bit.
>
> Just think about this for a minute.............If there was
> an interrupt
> pending, why are you surprised it occurs as soon as you
> enable interrupts
> in the MSR?

I wouldn't be surprised, if there were REALLY a pending interrupt.
I put the trace only when the vector index is 0 (error, or no interrupt).
The NIP was always the same, exactly after the instruction 'mtmsr'.
And the link register pointed inside the 'ppc_irq_dispatch_handler'.


> A 'sync' or an 'isync'?  The mtmsr is supposed to be an instruction
> synchronizer, so if you required an 'isync' for proper
> operation then it
> would be a silicon mask concern.  If you really added a
> 'sync' instruction,
> this implies to me there is some driver that isn't properly
> synchronizing
> its state with a device.  An operation to acknowledge the
> interrupt from
> the driver is stuck in the pipeline, you enable the interrupts again,
> the processor is handed an interrupt, the device is acknowledged (from
> the pipeline), and in the interrupt handler we don't find anything.
>
> I would be looking for a driver bug someplace.

I've put a 'sync'. An 'isync' does not change anything.
I agree with you, according to the 603e documentation,
the 'mtmsr' is an 'execution synchronizing' instruction.

What is even more strange, I can put the 'sync' everywhere in the '__sti'
function, that is before the 'mfmsr', before the 'ori', or before the
'mtmsr',
and the problem of spurious interrupt simply disappear. Remove it, it
reappears.

I could reproduce it using 2 interrupt sources: uart and fenet.
As I said, '__sti' is called by 'ppc_irq_dispatch_handler',
so I think we would see the problem whatever is the irq source.

If it is a pipeline concern, the instructions that are responsible of
the irq acknowledge would be neer the 'mtmsr', am I wrong?
I could not demonstrate that.

Hard to explain...

--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
