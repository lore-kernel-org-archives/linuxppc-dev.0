Date: Fri, 11 Feb 2000 18:49:41 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Latest OpenPic changes
In-Reply-To: <20000211183123.028211@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10002111837290.1866-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 11 Feb 2000, Benjamin Herrenschmidt wrote:

> I read back the interrupt until it's actually changed in the controller
> for the simple reason that if I don't do that, I sometimes get bogus
> interrupts. It looks like the calling path from driver code calling

I agree for the disable case, although I'm testing a different solution
with only an isync right now, no sync, not even an eieio. But for the
enable case it should not be necessary (Geert's snippet was
enable_irq).

Admittedly we have different machines since I have never put a single sync
on the OpenPIC accesses in my tree and I have a 3 months uptime on 2.2.12
with one spurious interrupt systematically just after initialization on
Raven chipset (but not on the followup chip called Hawk with exactly the
same code) which I never bothered to track down (it's perhaps even a HW
bug, obviously I don't care).

> disable_irq() and the actual disabling of the irq is short enough to
> cause the interrupt to fall when unexpected in some cases, or to arrive
> after beeing masked (more frequent with IDE). I've seen this behaviour

If it's truly the case we should consider a different solution. Masking
interrupts in a device or controller for a very short lapse is dominated
by the HW access overhead, and this is bad. sync instructions are also
extremely bad.

> with the old pmac pic (which was known to be slow). I used to have tons
> of bogus interrupts on the ibook & G4 (OpenPIC based), and I got rid of
> most of them by adding this code and by implementing an ack_and_mask
> function that actually masks the interrupt (which is, I think, not done
> on CHRP). I still get some when PMU/ADB doing synchronous requests however.
>
>
>
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
