Date: Wed, 7 Nov 2001 10:38:27 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: <hollis@austin.ibm.com>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	<davidm@amberdata.demon.co.uk>, <Sven.Dickert@planb.de>
Subject: Re: RFC: i8259.c cleanup
In-Reply-To: <20011106171559.D9471@austin.ibm.com>
Message-ID: <Pine.LNX.4.33.0111071013050.19315-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 6 Nov 2001 hollis@austin.ibm.com wrote:

> i8259.c hasn't worked right for a long time on IBM PReP's, which crippled
> those that use IDE ("hda: lost interrupt" forever). I sent a note about this a
> while back
> (http://lists.linuxppc.org/linuxppc-workstation/200109/msg00030.html) but
> never got any answers...
>
> Anyways, by reading from 0xbffffff0 we can get the active irq without having
> to play with the 8259 directly (which we were doing wrong; see above URL).
> This is true on the IBM PReP's because the 8259's are implemented in the Fire
> Coral SIO bridge (which is on the PCI bus), so it can respond to the PHB's
> interrupt request. (Unless I'm mistaken it's the PHB, in this case MPC105,
> which decodes 0xbffffff0 and asks the system interrupt controller to supply
> the active irq number.)

The address is not always 0xbffffff0, it is bridge dependent. However this
address is normally found in OF device tree, in residual data and as a
last resort could be made host bridge dependent. It has to be ioremapped
anyway...

For example on OpenPIC with cascaded 8259 like Motorola MVME/MTX, the
address is 0xfeff0030 (doesn't even need a PTE if you put a large
enough BAT with CHRP mappings since it's just above PCI I/O space).

>
> The following patch (to linuxppc_2_4_devel) does exactly that - it reads from
> 0xbffffff0 instead of the 8259 directly. This seems to have completely fixed
> the lost irq problems that we (IBM PReP users) have been having for a long
> time. This patch has only been tested on a 6050 so far, but that should cover
> all the Carolina's.

The question is why the polling code did not work, subtle timing problems
or is the code plain wrong ? I suspect that some 8259 accesses were not
serialized well enough.

>
> I'm not positive this trick will work on every board that has an 8259. The
> PReP spec calls for it, and anything with an MPC105/106 should support it. I'm
> really hoping that covers everyone...

No, it won't work for everybody.

>
> Also, with this trick our i8259.c could be made almost identical to
> i386/mips/alpha, which already know the irq vector entering mask_and_ack().
> A lot of our boards call i8259_irq() directly though, which would have to be
> changed. I only suggest it because the i386 folks apparently know 8259's
> better than we do... :) Oh, and alpha uses the rotating priority feature which
> sounds cool. :)
>
> The patch also cleans up some whitespace (parts of i8259.c were apparently
> copied and pasted from one xterm to another), adds a few comments, and adds
> resource_request's for both 8259's.

Good, but you should add resource request for the edge/level control
register while you are at it (0x4d0/4d1). And you should not require
32 bytes for the 8259. On my boards, the super I/O control port is
0x2e-ox2f.

BTW, if you have an MTX or MVME board just try to do inl(0x20): instant
lockup, no machine check, nothing. It might lock up other boards too.
Bad hardware design, I find it scary for some of my applications.

> I have one other question, regarding spin_lock vs spin_lock_irqsave. We use
> both in different places in i8259.c ("_irqsave" is commented out in some
> places). i386 and mips use irqsave in their i8259.c's, alpha does not. Which
> is appropriate here?

You should not need irqsave variants, once the interrupt is acked and
masked you can reenable interrupts explicitly with __sti if the interrupt
flags allow this (doing like i386 is probably the best). But you have to
check the interaction with the OpenPIC when cascaded. I actually wonder
whether it would be better to split it in two cases:

- 8259 is the only interrupt controller in the system

- 8259 is cascaded interrupt controller on an openpic

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
