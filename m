Date: Thu, 28 Jun 2001 06:43:20 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
Reply-To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: Paul White <pwhite@networkrobots.com>
Cc: jtm@smoothsmoothie.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
In-Reply-To: <200106281622.f5SGMW810376@stimpy.networkrobots.com>
Message-ID: <Pine.LNX.3.95.1010628062229.5112E-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hrm... well, that's not the answer that I wanted, but it does explain a
lot :-/

It sounds like you know a lot more about what's going on here, Paul, but
since it sounds like we're in the same boat, I'm more than willing to help
in whatever way I can (especially since I have nothing better to do until
I get the ethernet controller working, and that just isn't happening
without this fixed :)

And thanks for the heads up that setting PAGE_NO_CACHE doesn't work- I'd
just tried disabling caches entirely and was about to go in and start
mucking with lower level things- starting with a BAT entry :)

Back to the debugger...
--Gus

On Thu, 28 Jun 2001, Paul White wrote:

>
> Justin,
>
> >From my recent experience, this does not work.  We have a device on our
> PCI bus which is DMAing to SDRAM, and so far I can't get anything to
> work without cache coherency support in the system controller.
>
> If you find anything out, please let me know.  I may end up adding a new
> memory queue for non-cacheable memory, and just use another BAT entry
> for some pre-defined amount of memory for a non-cacheable pool.  A new
> flag to kmalloc() could then be used to get non-cacheable memory.  Does
> anyone know if anything like this already exists, or if theres a much
> easier way around this??  I should hopefully get cache coherency
> working, but we have been unable to so far.  If I end up doing the work,
> I"ll post the patches here.
>
> Btw..  I attempted to disable cache, as well as simply set the RAM bat's
> to PAGE_NO_CACHE, however this does not work because the PowerPC will
> throw alignment exceptions whenever a cache instruction is called on
> either a non-cached memory region, or if caching is disabled.  Just
> wanted to give you a heads up on this.
>
> Paul W.
>
>
> At 04:52 AM 6/28/2001 -0400, Justin (Gus) Hurwitz wrote:
> >
> >Did yo ever get a reply to this? That sounds like just what I want to do
> >(well, it sounds just like what our vxworks code does to do what I want to
> >do, which I guess is good enough).
> >
> >TIA,
> >--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
