Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070912035351.GF20218@localhost.localdomain>
References: <Pine.LNX.4.64.0709111436290.14121@blarg.am.freescale.net>
	<20070912031132.GC20218@localhost.localdomain>
	<AC5C6EF4-EE8E-487F-BF45-3653A5C2617D@kernel.crashing.org>
	<20070912035351.GF20218@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <44b4b3a133980aeb6c596aad71612e6c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Date: Wed, 12 Sep 2007 16:00:38 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> +		uli1575@0 {
>>>> +			reg = <0 0 0 0 0>;
>>>
>>> This looks kind of bogus...
>>
>> Its a PCIe to PCI bridge that is transparent.
>
> Right.... if it has no control registers, I think it should just lack
> 'reg', not define a zero-length register block.

"reg" for PCI config registers has length 0 always, it's defined that
way in the PCI binding.

But if this thing is transparent, it doesn't have PCI config regs.

>>>> +			#size-cells = <2>;
>>>> +			#address-cells = <3>;
>>>> +			ranges = <02000000 0 80000000
>>>> +				  02000000 0 80000000
>>>> +				  0 20000000
>>>> +				  01000000 0 00000000
>>>> +				  01000000 0 00000000
>>>> +				  0 00100000>;
>
> And if truly transparent, it should perhaps have just ranges;
> indicating that child addresses are identity mapped to parent
> addresses.

If truly transparent, the node should just not be there at all!

>>>> +			pci_bridge@0 {
>>>
>>> Ok.. why is pci_bridge nested within uli1575 - with the matching reg
>>> and ranges, it looks like they ought to be one device.  Also if this
>>> is a PCI<->PCI bridge, I believe it shold have device_type = "pci".
>>
>> We've been using this as it stands for a while.  If there are some
>> changes here that make sense I'm willing to make them.
>
> Right, at present I don't see why you couldn't just ditch the
> pci_bridge node, and drop its contents straight into the uli1575 node.

Yeah.  The preferred name for PCI-to-PCI bridge nodes is simply "pci", 
btw.


Segher
