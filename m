Date: Tue, 20 Nov 2001 23:17:29 -0500 (EST)
From: Bill Fink <billfink@mindspring.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <benh@kernel.crashing.org>, <anton@samba.org>,
	<billfink@mindspring.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: GigE Performance Comparison of GMAC and SUNGEM Drivers
In-Reply-To: <20011120.161937.118616800.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0111202254490.17140-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 20 Nov 2001, David S. Miller wrote:

>    From: benh@kernel.crashing.org
>    Date: Wed, 21 Nov 2001 01:05:18 +0100
>
>    Ah, ok, I stand corrected. Is this a bug in the chip or a flaw of
>    the GEM chip design ? I mean, is there a chance that later revs
>    of the chip or eventually the one used by Apple can support it ?
>
> There is no chance whatsoever of this ever working on any
> GEM revision.
>
> Even if it could work, GEM has a 9K transmit and 20K receive fifo in
> the largest configuration.  Even the Acenic has 512k or 1MB of total
> on-chip ram for packet buffering.
>
> As a result GEM sends pause frames when there is even the slightest
> amount of DMA traffic is has to compete with.  On a 33Mhz/32-bit PCI
> bus, it is sending pause frames all the time even if it is the only
> agent making use of the bus.

Ah, maybe the limited on-chip buffering with the GEM chips explains
the performance cap of about 720 Mbps that I am experiencing with my
testing.  Since Ben indicated that the GEM is on a 66 MHz PCI bus,
the PCI bus itself has a bandwidth in excess of 2 Gbps (32-bit) or
4 Gbps (64-bit).  I don't know whether the GEM/PCI is 32-bit or 64-bit.

BTW, is there any way of checking on the system about what the bandwidth
and width of the various PCI buses are?  I can see from /proc/pci that
there are 3 PCI buses on the 867 MHz G4, and that the GEM is on the third
PCI bus with the FireWire, but I don't see anything obvious that indicates
what the bus bandwidth or width is.  Also, I'm now wondering if I'll have
any contention problems if and when I get any FireWire disks.

						-Thanks

						-Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
