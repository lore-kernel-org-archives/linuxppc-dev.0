Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Rob Baxter <robb@synergymicro.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040105005234.GA25978@synergy>
References: <20040101181145.GA27294@iliana> <20040102151830.GA31261@synergy>
	 <1073087816.10542.16.camel@gaston> <20040103002733.GA2112@synergy>
	 <1073092343.10538.21.camel@gaston>  <20040105005234.GA25978@synergy>
Content-Type: text/plain
Message-Id: <1073268821.761.26.camel@gaston>
Mime-Version: 1.0
Date: Mon, 05 Jan 2004 13:13:41 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The problem I saw with the dual PCI buses is that the second Discovery PCI
> bridge was assigned a bus number of 01 (i.e., first_busno), or 02 if a PtP
> bridge was located off of the first PCI bus of the Discovery, prior to the
> scan.  The Discovery does not respond to PCI configuration cycles when the
> bus number is not zero--the reason for bus fixup routine.

Sure, you need to issue a type-0 config cycle on a host bridge for devices
that are on the same segment... it's possible that in your case, a type
0 and and type 1 are the same format with bus 0 for the first, in which
case, just do that (no need to "fixup" the bus number, it's really not
related to bus numbers, but to the type of config cycles issued to the
PCI bus)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
