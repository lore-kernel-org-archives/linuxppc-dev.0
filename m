From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 17 Nov 2003 18:05:14 +0100
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: New 745x errata
Message-ID: <20031117170514.GA32760@iram.es>
References: <1068721518.23764.84.camel@newt> <20031114162414.GD13003@ip68-0-152-218.tc.ph.cox.net> <1069081074.10537.16.camel@newt> <20031117151246.GA31680@iram.es> <1069083421.10537.63.camel@newt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1069083421.10537.63.camel@newt>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 17, 2003 at 03:37:00PM +0000, Adrian Cox wrote:
> On Mon, 2003-11-17 at 15:12, Gabriel Paubert wrote:
> > On Mon, Nov 17, 2003 at 02:57:53PM +0000, Adrian Cox wrote:
> > > Any opinion on the dcbt issue?  It looks like it could provide a way for
> > > a malicious userspace application to crash the machine, though it needs
> > > a combination of:
> > > 1) good timing
> > > 2) a peripheral that would be confused by an extra read cycle
>
> > Well, only privileged applications should have access to
> > peripherals, no?
> [...]
> > But maybe I miss something.
>
> That's the bug - a dcbt to a protected region can cause a spurious read
> cycle to that address. To trigger it:
>
> 1) the target address is in a BAT or TLB, marked as supervisor access
> only.
> 2) a cache miss to a cache alias of the target address reaches the
> load-store unit
> 2) you issue a dcbt to the target address within 1 clock cycle of step
> 2.
>
> Actually, I now believe the bug may be harmless, as the peripheral has
> an extra defence - its BAT or TLB entry will be non-cacheable, so no bus
> cycle will occur. The text of the errata doesn't spell this out as
> clearly as I'd like, but I think all it can do is cause a spurious bus
> cycle to ram.

Now that I downloaded the errata, it is rather clear that if the area
is cache-inhibited, there won't be any spurious access.

You might have a spurious access to a write-through area, even if
guarded it seems, but if something is marked write through, spurious
reads should have no side effects to start with.

In short, I believe that the erratum is harmless, until somebody
clearly shows that I'm wrong of course :-)

	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
