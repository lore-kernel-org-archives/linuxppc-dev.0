Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Rob Baxter <robb@synergymicro.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040103002733.GA2112@synergy>
References: <20040101181145.GA27294@iliana> <20040102151830.GA31261@synergy>
	 <1073087816.10542.16.camel@gaston>  <20040103002733.GA2112@synergy>
Content-Type: text/plain
Message-Id: <1073092343.10538.21.camel@gaston>
Mime-Version: 1.0
Date: Sat, 03 Jan 2004 12:12:23 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> This was necessary because the PCI driver (scan/enumeration code) was using
> these same config calls that was being fixed up.  (A chicken and egg issue?)

This should still not be necessary... Before scanning a bus, the PCI code
will properly set first_busno, thus the config access methods will work.

The only problem I spotted in 2.4 (and afaik, that is fixed in 2.6) is
that when P2P bridges are moved around, we could end up with a temporary
wrong state where 2 of these on a given bus segment would try to decode
the same bus numbers, thus screwing up probe. This is why I added a
skew value of 0x10 between each host on some machines.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
