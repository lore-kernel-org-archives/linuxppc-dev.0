Subject: Re: Caching in the MPC107, linux 2.6
From: Adrian Cox <adrian@humboldt.co.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040312223250.GE14472@smtp.west.cox.net>
References: <1079088369.691.43.camel@newt>
	 <20040312223250.GE14472@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1079177557.691.188.camel@newt>
Mime-Version: 1.0
Date: Sat, 13 Mar 2004 11:32:38 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-03-12 at 22:32, Tom Rini wrote:
> On Fri, Mar 12, 2004 at 10:46:09AM +0000, Adrian Cox wrote:

> > Without this fix or something like it my boards cannot use pcnet32
> > ethernet.
>
> And this is a rev of the mpc107 which is supposed to work with the 745x
> line ?

Yes. It's happened from the first rev supported on the 745x through to
currently shipping silicon. It's not a chip bug, it's the documented
behaviour of the bridge. Here's a summary of what happens:

1) Ethernet driver allocates buffer descriptors, sends address to
pcnet32.
2) pcnet32 reads a BD, which is currently empty. The MPC107 caches the
BD in the PCI-to-Local-Memory-Read-Buffer (PCMRB).
2a) If the PowerPC supports the shared state, the BD is now marked
shared in the PowerPC cache.
3) Ethernet driver writes to BD.
3a) If memory is marked _PAGE_COHERENT, the PowerPC performs an
address-only transaction, and changes the cache line from shared to
exclusive. The MPC107 sees the address-only transaction, and invalidates
the PCMRB.
3b) If the memory is not _PAGE_COHERENT, and the cache line is shared,
the MPC107 maintains a stale copy in the PCMRB.
4) Ethernet driver notifies pcnet32. pcnet32 reads the BD.
4a) MPC107 fetches the BD again. Success.
4b) MPC107 gives stale copy to pcnet32. Failure.

The crucial difference between the 745x and previous chips is that the
shared state is now compulsory. On the 7400 the shared state had to be
explicitly enabled by firmware, and I have not encountered a single
processor board which does that.

The pcnet32 is particularly vulnerable because its access pattern allows
the PCMRB to remain valid for a long period. This problem is most
visible when performing BOOTP and running with NFS root, as all other
PCI masters in the system are likely to be idle.

My patch is not the only way of dealing with this, but it is a lot
simpler than writing DMA mapping logic for this case.

- Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
