Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 954D4DDF8D
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 10:04:40 +1000 (EST)
Message-Id: <8A11E9B3-4B7D-48CF-ABAB-625050D8FFFE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1218147224.24157.308.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for setting
	up BAT translated IO regions.
Date: Thu, 7 Aug 2008 19:04:04 -0500
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060223.30717.35175.stgit@trillian.secretlab.ca>
	<CD66FAA8-BC99-4630-9FFF-E2C651E5DE9A@kernel.crashing.org>
	<fa686aa40808061454t14737278h3fd15fb0ccdbf251@mail.gmail.com>
	<75A0A752-FF2C-41B6-A6D3-E510E8FD4E91@kernel.crashing.org>
	<1218061709.24157.249.camel@pasglop>
	<63451E1F-30C1-4146-9D1A-BD4973E8F17A@kernel.crashing.org>
	<1218147224.24157.308.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 7, 2008, at 5:13 PM, Benjamin Herrenschmidt wrote:

> On Wed, 2008-08-06 at 20:49 -0500, Kumar Gala wrote:
>> On Aug 6, 2008, at 5:28 PM, Benjamin Herrenschmidt wrote:
>>
>>>
>>>> there is a bunch of error checking and difference in semantics that
>>>> you need to fix.  I think introduce a new API for this is silly,
>>>> especially since we expect there to only be one actual invocation  
>>>> of
>>>> the API for serial console access.
>>>
>>> Not necessarily....
>>>
>>> There's another aspect to BAT mappings here. First, they should be
>>> permanent (ie, not unmappable). That way, we have ioremap just use
>>> an existing BAT mapping when asked for a device that is covered
>>> by a BAT. This allows to have platform code do something like setup
>>> a BAT over a bunch of SOC registers or over a device, to  
>>> automagically
>>> get drivers doing ioremap to that area benefit from it.
>>
>> why should they be permanent.. We could implement reference counting
>> around the regions and free BATs if the count = 0.
>
> Do we care ?

probably not for BATs but for other things we might.

>> I'm more concerned about this being implemented around the existing
>> ioremap core in __ioremap().  We can easily use a flag bit to say use
>> "large mappings" or the fact that mem_init_done == 0.
>
> mem_init_done isn't a good indication. We can do page tables when it's
> 0, we would have to use a separate mem_preinit_done or something :-)
>
> I initially also though about a flag to ioremap_prot to be honest. But
> it does obfuscate the normal ioremap code path and if there's a flag,
> that means that callers know the difference and thus may as well call
> a separate function, don't you think ?

I'm ok with exposing a separate function as far as the API goes.. I'm  
not ok with duplicating the logic of __ioremap().

- k
