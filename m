In-Reply-To: <20040115115023.GA12001@iram.es>
References: <20040114161107.GM2658@adapter.n0skillz.org> <20040114181350.B40506@forte.austin.ibm.com> <70D6BF86-473D-11D8-A8C3-000A95A4DC02@kernel.crashing.org> <20040115115023.GA12001@iram.es>
Mime-Version: 1.0 (Apple Message framework v609)
Message-Id: <C404D01A-475A-11D8-A8C3-000A95A4DC02@kernel.crashing.org>
Cc: linas@austin.ibm.com, valvoline <valvoline@vrlteam.org>,
	linuxppc-dev@lists.linuxppc.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Broadcom BCM94306
Date: Thu, 15 Jan 2004 14:00:16 +0100
To: Gabriel Paubert <paubert@iram.es>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Also note that the 970 does not support wrong^H^H^H^H^Hlittle-endian
>> mode
>> at all.
>
> BTW, where did you find this? IBM's sites have no real documentation on
> the 970, or I was too dumb to find them.

I work for IBM.  I did not realize this information wasn't
publicly available -- if it isn't, and it's not just you.

> It's more complex than this, because it is pseudo little endian,
> munging
> low address bits.

It's not, afaics.

>  The memory seen as an array of bytes is not invariant
> through this transformation for most processors. For example the
> character
> chain "abcdefgh" copied from a kernel buffer through a read call will
> look as "hgfedcba" from a little endian application.

Representation depends on access size.

>  Bridges have a
> "LE" bit to also mung addresses during DMA and PIO transfers.

Well yeah, PCI swizzling is awful and complicates the hell out
of everything.

> But this makes it almost impossible to support a mixture of little and
> bug endian applications. Indeed the ROM BIOS x86 emulator I wrote a
> few years ago runs in big-endian mode and uses {l,st}[hw]brx
> instructions
> to emulate x86 crapitecture.

That's how to normally access PCI as well, yeah.

> P.S.: there is nothing wrong with calling little-endian wrong or
> perverted or fucked-up ;-)

I don't know if I trust you here -- you wrote "bug endian" just a few
lines up ;-)


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
