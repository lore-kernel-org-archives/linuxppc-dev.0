Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20070912035351.GF20218@localhost.localdomain>
References: <Pine.LNX.4.64.0709111436290.14121@blarg.am.freescale.net>
	<20070912031132.GC20218@localhost.localdomain>
	<AC5C6EF4-EE8E-487F-BF45-3653A5C2617D@kernel.crashing.org>
	<20070912035351.GF20218@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AE7CB083-8474-4EB6-B10E-C0D76BEBE620@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Date: Wed, 12 Sep 2007 10:13:35 -0500
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

>>>> +			reg = <e0000 1000>;
>>>> +			fsl,has-rstcr;
>>>> +		};
>>>> +
>>>> +		mpic: pic@40000 {
>>>> +			clock-frequency = <0>;
>>>> +			interrupt-controller;
>>>> +			#address-cells = <0>;
>>>> +			#interrupt-cells = <2>;
>>>> +			reg = <40000 40000>;
>>>> +			compatible = "chrp,open-pic";
>>>> +			device_type = "open-pic";
>>>> +			big-endian;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	pcie@ffe08000 {
>>>> +		compatible = "fsl,mpc8548-pcie";
>>>
>>> And again, "fsl,mpc8572-pcie", "fsl,mpc8548-pcie".
>>
>> But why?  there is no difference between the PCIe controller in
>> mpc8548 and mpc8572?
>
> As far as you've yet discovered...

Its the same actual block from design.  I'll think some on this.  If  
I had some macro support in the dtc I wouldn't feel so bad about  
doing this.  Its the edit/modify/fix cycle that's a pain.

>>>> +		uli1575@0 {
>>>> +			reg = <0 0 0 0 0>;
>>>
>>> This looks kind of bogus...
>>
>> Its a PCIe to PCI bridge that is transparent.
>
> Right.... if it has no control registers, I think it should just lack
> 'reg', not define a zero-length register block.
>
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
>
>>>> +
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

upon further review and discussion you are right about dropping the  
pci_bridge@0 node from the ULI.  However we do need to add a pcie@0  
node to cover the virtual P2P bridge in the PHB. So we have something  
like:

pcie@ff808000 {
   pcie@0 {
     uli@0 {
     }
   }
}

- k
