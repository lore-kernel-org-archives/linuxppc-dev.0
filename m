Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <17671.12953.147098.637600@cargo.ozlabs.ibm.com>
References: <200609121952.04779.arnd.bergmann@de.ibm.com>
	<17671.12953.147098.637600@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <260BD3AF-68B1-42B8-8CB0-C275F0F53509@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: allow PHBs anywhere in the device tree
Date: Wed, 13 Sep 2006 02:23:10 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The rtas_pci code currently restricts pci host bridges to
>> locations directly under the device tree root. In order to
>> correctly model a north bridge that has multiple PCI buses,
>> that restriction needs to be relaxed.
>
> Ummm, how do you think we've managed on pSeries all this time?
>
> I could understand this if you said you needed to represent multiple
> north bridges, though that would be a rather peculiar system
> topology.

Yes, although it actually already exists.

> Having multiple PCI domains hanging off a single north
> bridge can be represented perfectly well with the host bridges being
> children of the root, because the root node represents the address
> space directly accessible to the processor(s), and it is the north
> bridge that implements that address space.

There are some cases where you *really* want to model the PCI bridges'
parents in the OF tree as well.

And even if it wouldn't be sane -- why would Linux refuse an OF device
tree that makes perfect sense an sich?  If some 970 OF would put the
HyperTransport node under the U4 node, should that really be a problem
for Linux?

> What specifically do you want this for?

Not on a public list ;-)


Segher
