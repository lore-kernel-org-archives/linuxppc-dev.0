Subject: Re: Caching in the MPC107
From: Adrian Cox <adrian@humboldt.co.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020910145843.GB797@opus.bloom.county>
References: <1031581408.30396.81.camel@newt>
	<20020910145843.GB797@opus.bloom.county>
Content-Type: text/plain
Date: 10 Sep 2002 16:45:31 +0100
Message-Id: <1031672735.2686.58.camel@newt>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2002-09-10 at 15:58, Tom Rini wrote:
> On Mon, Sep 09, 2002 at 03:23:24PM +0100, Adrian Cox wrote:
>
> > I've just been debugging an interesting problem with a new board that
> > uses a MPC107 bridge with a 7445 processor. The symptoms were that the
> > ethernet device never saw updated transmit descriptors unless another
> > bus master was active in the system.
> [snip]
[snip]
> Are there any more details you can give?  I've got a Sandpoint X3 and
> Valis (with a 7455 CPU), and aside from the MPC107 Errata #18 problem
> (http://e-www.motorola.com/brdata/PDFDB/docs/MPC107CE.pdf) which is now
> fixed, I haven't seen any problems here.  Do you have access to this
> board and a 7455?

I think the problem was only visible because the pcnet32 device polls a
descriptor small enough to get cached in the MPC107, and no other PCI
master is active to read this cache. I don't currently have access to a
Sandpoint X3 to test this out on.

The problem seems to be a logical consequence of the documented and
correct behaviour of the MPC107 and the 7450 family: a PCI read causes
the MPC107 to cache the line, and the 7450 to mark the line shared. As
_PAGE_COHERENT is not set, the 7450 does not produce an address only
transaction when it writes to the line and changes it back from shared
to modified. The physical evidence was using the scope to see a PCI read
go into the MPC107, and the MPC107 respond without any cycles on the 60x
bus.

>From the chip documentation, I can't see another way around this. Some
device drivers on MPC107/7450 systems will run into trouble without it.

- Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
