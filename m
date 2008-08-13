Return-Path: <jrigby@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C1802DE138
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 02:30:44 +1000 (EST)
Message-ID: <48A30C2D.1070106@freescale.com>
Date: Wed, 13 Aug 2008 10:30:37 -0600
From: John Rigby <jrigby@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5121 pci 1/3] powerpc: 83xx: pci: Remove need for
	get_immrbase from mpc83xx_add_bridge.
References: <1218130587-31176-1-git-send-email-jrigby@freescale.com>	
	<20080813050924.GD17587@secretlab.ca>
	<48A3068F.20409@freescale.com>
	<fa686aa40808130923q2ef7d4b7ha5a9225ce0afd061@mail.gmail.com>
In-Reply-To: <fa686aa40808130923q2ef7d4b7ha5a9225ce0afd061@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Wed, Aug 13, 2008 at 10:06 AM, John Rigby <jrigby@freescale.com> wrote:
>   
>>> On Thu, Aug 07, 2008 at 11:36:25AM -0600, John Rigby wrote:
>>> Can you use something like 'fsl,primary-pci-bridge' instead?  'primary'
>>> is a little too generic for my taste.  Also, the purpose of identifying
>>> one of the PCI bridges as primary should be documented (This is me
>>> pushing against encoding Linux internal implementation details into the
>>> device tree, I suspect that 'primary' doesn't belong in the device tree
>>> at all).
>>>
>>>       
>> Ok, I got the primary idea from sam440ep.dts, I'm willing to do something
>> different.
>>
>> I have thought about adding an is_primary argument to mpc83xx_add_bridge
>> like fsl_add_bridge has and make the callers figure out which is primary.
>>
>> The simple case is the platform that have only one bus:
>>   for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
>>       fsl_add_bridge(np, 1);
>>
>> Callers with multiple bridges do something like this:
>>   for_each_compatible_node(np, "pci", "fsl,mpc8641-pcie") {
>>       struct resource rsrc;
>>       of_address_to_resource(np, 0, &rsrc);
>>       if ((rsrc.start & 0xfffff) == 0x8000)
>>           fsl_add_bridge(np, 1);
>>       else
>>           fsl_add_bridge(np, 0);
>>   }
>>
>> So now we are using hardcoded offsets again.
>>     
>
> Go with the hardcoded offset.  Linux is broken, so the workaround
> should be in Linux code until Linux PCI code is fixed.
>
> g.
>
>   
Ok, I'll leave the offset checking in mpc83xx_add_bridge rather than 
having it duplicated in the eight different callers.
