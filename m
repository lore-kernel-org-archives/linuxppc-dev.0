From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 15 Jan 2004 12:50:23 +0100
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linas@austin.ibm.com, valvoline <valvoline@vrlteam.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Broadcom BCM94306
Message-ID: <20040115115023.GA12001@iram.es>
References: <20040114161107.GM2658@adapter.n0skillz.org> <20040114181350.B40506@forte.austin.ibm.com> <70D6BF86-473D-11D8-A8C3-000A95A4DC02@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <70D6BF86-473D-11D8-A8C3-000A95A4DC02@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 15, 2004 at 10:30:21AM +0100, Segher Boessenkool wrote:
>
> On 15-jan-04, at 1:13, linas@austin.ibm.com wrote:
> >totally irrelevent and off-topic, but ... the ppc can (or used
> >to be able to) switch endianess dynamically.  To be more correct,
> >it can run some user-space code that was little endian, by having
> >the kernel set the appropriate bit in the MSR before it ran the
> >app.  I have no idea is the linux kernel saves/restores this bit(s),
> >or if this is still supported on the newest processors.
>
> It can also run supervisor-level code in little endian mode.
>
> The 2.0 PEM still doesn't show this support as optional [look at the
> ILE and LE bits in the MSR], but it does say that "the code sequence
> used to switch from big to little-endian mode may differ among
> processors".
>
> Also note that the 970 does not support wrong^H^H^H^H^Hlittle-endian
> mode
> at all.

BTW, where did you find this? IBM's sites have no real documentation on
the 970, or I was too dumb to find them.

>
> As these bits are in the MSR, and you are supposed to leave alone the
> bits
> that you don't explicitly touch, I suppose the Linux kernel
> saves/restores
> the bits just fine.  But I didn't check whether it actually does, so
> YMMV.


It's more complex than this, because it is pseudo little endian, munging
low address bits. The memory seen as an array of bytes is not invariant
through this transformation for most processors. For example the character
chain "abcdefgh" copied from a kernel buffer through a read call will
look as "hgfedcba" from a little endian application. Bridges have a
"LE" bit to also mung addresses during DMA and PIO transfers.

But this makes it almost impossible to support a mixture of little and
bug endian applications. Indeed the ROM BIOS x86 emulator I wrote a
few years ago runs in big-endian mode and uses {l,st}[hw]brx instructions
to emulate x86 crapitecture.

	Gabriel

P.S.: there is nothing wrong with calling little-endian wrong or
perverted or fucked-up ;-)

file (or written from the kernel
>
>
> Segher
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
