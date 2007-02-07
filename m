Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 010ADDDE37
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 08:52:40 +1100 (EST)
In-Reply-To: <45CA47AB.1000302@freescale.com>
References: <45CA41F7.6020700@freescale.com>
	<1170883956.2620.305.camel@localhost.localdomain>
	<45CA47AB.1000302@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0EF1DDFB-E590-422C-8FA6-0FD643E68F49@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: mac-address vs. local-mac-address
Date: Wed, 7 Feb 2007 15:51:45 -0600
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 7, 2007, at 3:42 PM, Timur Tabi wrote:

> Benjamin Herrenschmidt wrote:
>> On Wed, 2007-02-07 at 15:17 -0600, Timur Tabi wrote:
>>> Hi everyone,
>>>
>>> What is the current consensus on using mac-address vs. local-mac- 
>>> address in the
>>> device tree?  The 1275 spec says this:
>>>
>>> "local-mac-address" Standard property name to specify preassigned  
>>> network address.
>>> "mac-address" Standard property name to specify network address  
>>> last used.
>>>
>>> I think we need to agree on some interpretation of these  
>>> statements, and all the
>>> code should be updated to implement that interpretation.
>>
>> It's fairly clear:
>>
>> local-mac-address is what is statically set by the firwmare (comes  
>> from
>> EEPROM, whatever).
>>
>> mac-address is really only meaningful if your firmware is
>> "dynamic" (real OF, uboot maybe) and was, for some reason,  
>> instructed by
>> the user to use a different mac address for that boot (if that  
>> feature
>> exist).
>>
>> It's basically the mac-address that was actually used on that  
>> interface
>> to netboot the kernel I'd say.
>>
>>> Linux doesn't support that.  In some cases, the actual device  
>>> tree is located on
>>> a TFTP server, and it's only copied temporarily into RAM by U- 
>>> Boot.  There's no
>>> way that a Linux driver can update that.
>>
>> I don't understand what you mean here :-) The linux driver can  
>> perfectly
>> well update the in-memory copy of the device-tree, which would  
>> make it
>> useful in the case of a kexec to a newer kernel.
>
> That makes sense.  I don't know anything about kexec, so I didn't  
> think there
> was any point in updating the in-memory copy.  But in this case,  
> the driver
> should update it.
>
>>> On a full-blown OF machine, the firmware does provide APIs for  
>>> updating the
>>> device tree, and so we could support mac-address on these  
>>> machines.  But U-Boot
>>> disappears once the kernel loads, so there is no firmware to call  
>>> to update the
>>> device tree.
>>
>> I don't understand what the firmware device-tree has to do with  
>> that...
>
> Without a firmware device tree, there's no way to update the device  
> tree and
> have that new tree retained over a reboot.
>
>> If uboot is instructed to use a different mac-address than the
>> "built-in" one, it can perfectly well create that property before
>> getting to the kernel.
>
> And it does, depending on which version of U-Boot.  There is debate  
> (inside
> Freescale, at least) whether U-Boot should update mac-address or
> local-mac-address.  It sounds to me like it should update local-mac- 
> address, and
> the DTS file shouldn't even include an entry for mac-address.

The problem with u-boot is that the correct way would be to use local- 
mac-address for what's compiled into u-boot and mac-address if  
someone does a 'setenv' to modify the mac address.  The question is  
anyone really going to care that much.

- k
