Message-ID: <3C177748.1A1342C2@labs.mot.com>
Date: Wed, 12 Dec 2001 09:27:04 -0600
From: Steve Rossi <srossi@labs.mot.com>
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: high priority interrupts disabled
References: <3C112297.6DE37608@labs.mot.com> <3C114C63.3050102@embeddededge.com> <3C14F91F.F382ABE3@labs.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,
Here's an update

> Dan Malek wrote:
>
> > ...I wonder if IRQ2 is being masked.  ...
>
> I verified that IRQ2 is not getting masked in the SIMASK register during the
> disk I/O which is when it can get held off ...

Well I lied - sort of - turns out that under normal circumstances IRQ2 doesn't
get masked but under some condition (which I have not yet determined) IRQ2 does
get masked during IRQ6.
Since IRQ6 - the hard disk interrupt - does data transfer in the ISR, then
interrupts again, the processor ends up exiting from the ISR, then jumping right
back in hundreds of times in a row. I'm a newbie to writing Linux drivers, but
this seems to me like poor practice - to do the work of data transfer to the disk
in the ISR itself, but I guess its only really a problem in PIO modes. I would be
interested in knowing why its done this way. Regardless, my IRQ2 doesn't get
unmasked again until the full number of sectors is written to the disk.

I tried to use the Linux Trace Toolkit - as Wolfgang suggested, but after
applying the patches to my 2.4.16 kernel and hacking in the pieces that didn't
patch cleanly, the kernel wouldn't boot, so I didn't spend much more time on it.
I think it would only give me marginally more information than what I'm able to
gleen by looking at the bus activity.

Are there any other experiences with ide-disk driver causing other interrupts to
be held off for long periods of time?

Can someone who is familiar with the interrupt entry/exit mechanisms comment on
if it is possible for a normal IRQ2 isr to run (note it runs with interrupts
enabled MSR EE bit =1), then as its exiting, but before it is re-enabled for IRQ6
to run? Since IRQ6 fires one right after the other hundreds of times, the
un-masking of IRQ2 wouldn't happen until IRQ6 stops firing?? Is this plausable or
is there sufficient protection to guarantee that IRQ2 will exit completely
(thereby getting un-masked) before IRQ6 can run? Is there a mechanism by which
all lower priority interrupts are disabled when a higher priority one is running?
If not, it seems to me this could happen.

Thanks,
Steve


--
-------------------------------------------------------
Steven K. Rossi                     srossi@labs.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
