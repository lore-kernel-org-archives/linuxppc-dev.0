Message-ID: <3D7E25F4.4CC00BF8@mvista.com>
Date: Tue, 10 Sep 2002 13:03:48 -0400
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Caching in the MPC107
References: <1031581408.30396.81.camel@newt>
		<20020910145843.GB797@opus.bloom.county> <1031672735.2686.58.camel@newt>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Adrian Cox wrote:

> I think the problem was only visible because the pcnet32 device polls a
> descriptor small enough to get cached in the MPC107, and no other PCI
> master is active to read this cache. I don't currently have access to a
> Sandpoint X3 to test this out on.
>
> The problem seems to be a logical consequence of the documented and
> correct behaviour of the MPC107 and the 7450 family: a PCI read causes
> the MPC107 to cache the line, and the 7450 to mark the line shared. As
> _PAGE_COHERENT is not set, the 7450 does not produce an address only
> transaction when it writes to the line and changes it back from shared
> to modified. The physical evidence was using the scope to see a PCI read
> go into the MPC107, and the MPC107 respond without any cycles on the 60x
> bus.

Adrian,

I think I understand what you're saying.  The biggest question that comes to
my mind, though, is whether this is a problem on many of the other
hostbridges?  Most of the newer bridges will buffer a cacheline or two.  Is
this a wider issue than just the 107?

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
