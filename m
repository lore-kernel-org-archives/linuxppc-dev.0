In-Reply-To: <19991122143732.B12973@hq.fsmlabs.com>
Date: Tue, 23 Nov 1999 11:35:04 +0100
To: Cort Dougan <cort@fsmlabs.com>, linuxppc-dev@lists.linuxppc.org,
        paulus@linuxcare.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: bootloader & head.S weirdness
Message-Id: <19991123113504.011766@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 22, 1999, Cort Dougan <cort@fsmlabs.com> wrote:

>CC: linuxppc-dev@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
>----------
>Not always.  Keep in mind we have several machine types that follow the
>same patch there.  We don't always enter with OF and OF doesn't always give
>1:1 mappings, either.

Yes, I agree. but I beleive the piece of bootloader appended to the head
of the kernel image or the early bootloader used (quik ?) should take
care of those very weird case and of mapping the kernel 1:1 before
entering it.

>} The kernel enters from OF, with the MMU in whatever state OF set it and
>} the guarantee that at least it's mapped 1:1 with some memory (1Mb) also
>} mapped just after it so that it can expand itself. This guarantees are
>} the responsibility of the bootloader.
>
>I don't care for it much but it gives us a foothold and OF doesn't seem to
>use bat1 ever...

There is no guarantee. I'll check what OF does on my machine, but I
really sounds risky to assume that. I did experience _lots_ of weird
crashes during boot and kernel relocation until I added the code to turn
the MMU off. Also, the range mapped with this BAT may overlap with
whatever OF has mapped previously.
The 1:1 mapping requirement I wrote about is just to make sure we get the
correct physical address when turning the MMU off. This could eventually
be replaced by a real boot params structure in one register (r3 ?) and
the kernel's entry physical address in another (r4 ?). Basically, if we
don't require 1:1 mapping, then we need to be given our own physical
address. I really don't like the idea of playing with this BAT with MMU
ON, and as I wrote you, I did experience various bad behaviour. Also, I
can't turn MMU off from the bootloader since the prom_init stuff needs
the MMU to be kept in it's original OF setup until we finish initialising.

>Not dependent on the bootloader, just dependent on the current running
>address and whether MSR_DR is set in the MSR or not.

You are right, but there is this CHRP address translation I didn't fully
catch.

>at 0x10000 on chrp when running quik.

Isn't there a risk here in the copy&flush code ? When copying the kernel
down, won't the copy&flush code override itself ? (We are lucky, it's in
the cache... but we have no guarantee neither that the cache is enabled
at this point).

>We only do that after we've called prom_entry() for the last time, though.

Hum... quik loads the kernel at 0, which _will_ override whatever vectors
where here way before we stop using OF. I think most OF implementations
use ROM based vectors at FFxxxxxx but this is still, I think, a dangerous
assumption. On the iBook, OF won't let you claim a range of memory
including the low mem vectors.

>That's a good way to do it but shutting it down isn't always that easy.  On
>some PReP's (the IBM 830 I think) we come into the kernel with MSR_IR on
>and MSR_DR off and we're running with some odd I mappings (not D mappings,
>though).

Ouch. I think this should be taken care by the small bootstrap appended
to the kernel (but that's only my opinion). In any way, if we could at
least differenciate those case clearly (let's say with some kind of
explicit machine number in a register on the kernel entry, not a
structure since at this point we don't want to access memory at all I
beleive).

Will those machine boot from OF ? I mean, is it OF who is setting up this
weird mapping ? In this case, wouldn't it be possible to fix this from
the bootloader using the OF "map" method ? If it's not OF, then I could
be fixed from the head bootloader.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
