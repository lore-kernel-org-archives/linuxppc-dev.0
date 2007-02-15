Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 8F6A0DDEE5
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 07:55:17 +1100 (EST)
Message-ID: <45D4C8AF.80607@freescale.com>
Date: Thu, 15 Feb 2007 14:55:11 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add of_get_mac_address() and update fsl_soc.c
	to use it
References: <1171408247467-git-send-email-timur@freescale.com>
	<1171411219.20192.118.camel@localhost.localdomain>
	<01b23edfa0a058ae8a119594abb51e01@kernel.crashing.org>
In-Reply-To: <01b23edfa0a058ae8a119594abb51e01@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>> +    return get_property(np, "address", NULL);
>>
>> Since there is so much room for confusion with "address", please at
>> least do some basic sanity checking, like check that it's size is 6
>> bytes and maybe that the multicast bit isn't set.
> 
> Preferably, don't use "address" at all -- there shouldn't

Unfortunately, I really don't have that luxury.  I *must* support 'address'.

> be any trees in the wild that use it.  If there actually
> are some, the should use a quirk to change it to "local-
> mac-address" instead.

The whole point behind checking for 'address' is to support older device trees 
that have only that property.  We have a problem where some installations use 
'address', and if we don't support it here in the kernel, then the kernel won't 
boot.

> This holds in general: workarounds for gross errors in
> device trees should be applied much more selectively
> than is done now, it just doesn't scale this way.

There are trees in the kernel today that have 'address' in them.  Before I can 
fix the trees, though, I need to update U-Boot and the kernel to support 
local-mac-address *without* breaking support for older trees.  That's why this 
patch is written the way it is.

I have patches for U-Boot already out there, although currently none of the 
U-Boot maintainers have indicated a willingness to apply them.

This whole local-mac-address mess needs to be fixed in an iterative process. 
One day, we can remove the check for 'address' from of_get_mac_address(), but 
not yet.

I've implemented all the other suggestion so far.  I *really* need this patch to 
go in as is.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
