Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 86AC667BA8
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2005 15:26:12 +1000 (EST)
In-Reply-To: <1120107968.31924.42.camel@gaston>
References: <1120107968.31924.42.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <563CF66E-32DC-4872-B316-219F5F6136E3@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 30 Jun 2005 00:26:15 -0500
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: set_phys_avail() futures question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> I'd like to get your opinion on what the future of
>>>> arch/ppc/mm/init.c/set_phys_avail() looks like.
>>>> Currently, its job is to traverse the mem_pieces data
>>>> and remove a whole series of #ifdef'ed regions of
>>>> memory based on configuration options.  These regions
>>>> are the initrd, the RTAS data, and the AGP special page.
>>>>
>>>> Do you see these regions as being explicitly listed in
>>>> the proposed  "reserved memory blocks" area of the Flat
>>>> Dev Tree header structure?
>>>>
>>>>
>>>
>>> Yes. initrd for sure, RTAS too, AGP special page well ... I have to
>>> check if we still use that one at all... but it's not allocated in
>>> prom_init so it may need it's own little bit here still.
>>>
>>
>> What this implies to me is that what a flattened OF tree we will no
>> longer need to call set_phys_avail().
>>
>
> It will have to do some equivalent to transfer the reserve map to
> mem_pieces tho ...

Agreed, but I think we expect that to happen in platform_init now.   
When we walk the flatten tree we will build up the phys_avail  
mem_pieces data structure.

- kumar
