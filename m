From: Brian Waite <waite@skycomputers.com>
To: Dan Malek <dan@embeddededge.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Disable cache on 74xx
Date: Thu, 20 Feb 2003 10:47:02 -0500
Cc: Gary Thomas <gary@mlbassoc.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
References: <Pine.GSO.4.21.0302201507510.27212-100000@vervain.sonytel.be> <3E54F2EF.2080601@embeddededge.com>
In-Reply-To: <3E54F2EF.2080601@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302201047.02490.waite@skycomputers.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well to preface, some people around here think disabling cache is a good idea.
I report to one of those :). What I am trying to debug is why my custom board
hangs. Basically,  what I see is when a PCI interface starts reading/writing
SDRAM, my 745x processor locks up. I see no more decrementer interrupts being
serviced and using a BDI 2000 JTAG interface I see the processors stalled on
some memory access instruciton. The memory controller (gt64260) seems to be
doing something very wrong and it is thought to be a cache coherency issue.
So to prove this, I was asked to try running without any sort of cache.
Hopefully between Gary's information and yours, Dan I can convince people
that it is futile.

Thanks
Brian

On Thursday 20 February 2003 10:23 am, Dan Malek wrote:
> Geert Uytterhoeven wrote:
> > There may be a different behavior for `disabling the data cache globally'
> > and `using e.g. dcbf on uncached memory' (with the data cache enabled
> > globally).
>
> I decided to take a diversion and read some processor manuals.  :-)
>
> The behavior of the cache instructions on areas that are not cacheable
> for any reason depends upon the cache instruction used.  Some have
> no effect, some have unpredictable behavior, some cause alignment/access
> traps.  It all depends upon how they would translate/access the cache
> and the operation they would perform on a cache line.  We use all
> instructions in Linux that would trigger any of the behavior. :-)
>
> The bottom line appears to be you really don't want to execute cache
> instructions on areas that are not cached.  This includes global disable
> or any method of marking pages uncached.
>
> For Brian, I'm also curious why you think running Linux with disabled
> caches will assist in debugging memory controller problems?  If you are
> looking for such fine control of the bus cycles for debugging it seems a
> simple memory diagnostic used in conjuction with hardware debug tools is a
> better approach.
>
> Thanks.
>
>
> 	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
