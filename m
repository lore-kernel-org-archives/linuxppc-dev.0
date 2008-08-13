Return-Path: <jrigby@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C517BDDDDB
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 02:06:48 +1000 (EST)
Message-ID: <48A3068F.20409@freescale.com>
Date: Wed, 13 Aug 2008 10:06:39 -0600
From: John Rigby <jrigby@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>, kim.phillips@freescale.com,
	Kumar Gala <kumar.gala@freescale.com>, Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 5121 pci 1/3] powerpc: 83xx: pci: Remove need
	for	get_immrbase from mpc83xx_add_bridge.
References: <1218130587-31176-1-git-send-email-jrigby@freescale.com>
	<20080813050924.GD17587@secretlab.ca>
In-Reply-To: <20080813050924.GD17587@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Thu, Aug 07, 2008 at 11:36:25AM -0600, John Rigby wrote:
>   
>> Modify mpc83xx_add_bridge to get config space register base address from the device
>> tree instead of immr + hardcoded offset.
>>
>> 83xx pci nodes have these changes:
>>     register properties now contain two address length tuples:
>> 	First is the pci bridge register base, this has always been there.
>> 	Second is the config base, this is new.
>>     The primary pci bus should have the "primary" property.
>>
>> These are documented in Documentation/powerpc/dts-bindings/fsl/83xx-512x-pci.txt
>>     
>
> Looks mostly good to me.  I only have one comment on the device tree
> binding...
>
>   
>> diff --git a/Documentation/powerpc/dts-bindings/fsl/83xx-512x-pci.txt b/Documentation/powerpc/dts-bindings/fsl/83xx-512x-pci.txt
>> new file mode 100644
>> index 0000000..51214a0
>> --- /dev/null
>> +++ b/Documentation/powerpc/dts-bindings/fsl/83xx-512x-pci.txt
>> @@ -0,0 +1,43 @@
>> +* Freescale 83xx and 512x PCI bridges
>> +
>> +Freescale 83xx and 512x SOCs include the same pci bridge core.
>> +
>> +83xx/512x specific notes:
>> +- reg: should contain two address length tuples
>> +    The first is for the internal pci bridge registers
>> +    The second is for the pci config space access registers
>> +- primary: 
>> +    This property should be present for the primary pci bridge
>>     
>
> Can you use something like 'fsl,primary-pci-bridge' instead?  'primary'
> is a little too generic for my taste.  Also, the purpose of identifying
> one of the PCI bridges as primary should be documented (This is me
> pushing against encoding Linux internal implementation details into the
> device tree, I suspect that 'primary' doesn't belong in the device tree
> at all).
>   
Ok, I got the primary idea from sam440ep.dts, I'm willing to do 
something different.

I have thought about adding an is_primary argument to mpc83xx_add_bridge 
like fsl_add_bridge has and make the callers figure out which is primary.

The simple case is the platform that have only one bus:
    for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
        fsl_add_bridge(np, 1);

Callers with multiple bridges do something like this:
    for_each_compatible_node(np, "pci", "fsl,mpc8641-pcie") {
        struct resource rsrc;
        of_address_to_resource(np, 0, &rsrc);
        if ((rsrc.start & 0xfffff) == 0x8000)
            fsl_add_bridge(np, 1);
        else
            fsl_add_bridge(np, 0);
    }

So now we are using hardcoded offsets again.

As I type this I'm coming to like the primary flag more and more.  I'm 
willing to change it to 'fsl,primary-pci-bridge' though I don't really 
agree with your argument against the generic name.  It is in the context 
of an 'fsl,pci-whatever' node so it does not have to be specific.  And 
maybe generic is good, a universal generic solution would be to require 
all primary pci nodes to have the property then 
pci_process_bridge_OF_ranges could get it out of the device node instead 
of having it passed in.

I would like to hear what the 83xx folks think about this.

John

>   
