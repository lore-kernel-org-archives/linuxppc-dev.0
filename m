Date: Sun, 4 Jan 2004 17:52:34 -0700
From: Rob Baxter <robb@synergymicro.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rob Baxter <robb@synergymicro.com>,
	Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040105005234.GA25978@synergy>
References: <20040101181145.GA27294@iliana> <20040102151830.GA31261@synergy> <1073087816.10542.16.camel@gaston> <20040103002733.GA2112@synergy> <1073092343.10538.21.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1073092343.10538.21.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 03, 2004 at 12:12:23PM +1100, Benjamin Herrenschmidt wrote:
>
> > This was necessary because the PCI driver (scan/enumeration code) was using
> > these same config calls that was being fixed up.  (A chicken and egg issue?)
>
> This should still not be necessary... Before scanning a bus, the PCI code
> will properly set first_busno, thus the config access methods will work.
>
> The only problem I spotted in 2.4 (and afaik, that is fixed in 2.6) is
> that when P2P bridges are moved around, we could end up with a temporary
> wrong state where 2 of these on a given bus segment would try to decode
> the same bus numbers, thus screwing up probe. This is why I added a
> skew value of 0x10 between each host on some machines.
>
> Ben.

The problem I saw with the dual PCI buses is that the second Discovery PCI
bridge was assigned a bus number of 01 (i.e., first_busno), or 02 if a PtP
bridge was located off of the first PCI bus of the Discovery, prior to the
scan.  The Discovery does not respond to PCI configuration cycles when the
bus number is not zero--the reason for bus fixup routine.

--
-Rob

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
