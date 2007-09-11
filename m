Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 737D6DDE2D
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 03:04:22 +1000 (EST)
Message-ID: <46E6CA63.1040703@freescale.com>
Date: Tue, 11 Sep 2007 12:03:31 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: SOC registers/immr determination from device tree (was Re: [PATCH
	1/3] fsl_soc.c cleanup)
References: <20070828201618.GA24210@ld0162-tx32.am.freescale.net>
	<1E0D95DC-03E8-4BF0-9E22-69AECFA73FCF@kernel.crashing.org>
	<20070911135717.GD1932@ld0162-tx32.am.freescale.net>
	<3583FF3E-35E3-4B0A-A170-D69135E902F2@kernel.crashing.org>
	<46E6B98C.1070207@freescale.com>
	<B247D7AF-6AB9-4009-BFB8-0A365D3F0DF2@kernel.crashing.org>
	<46E6C145.2050006@freescale.com>
	<D3BBD38C-B050-4694-8B38-EF9C75DD2D8F@kernel.crashing.org>
In-Reply-To: <D3BBD38C-B050-4694-8B38-EF9C75DD2D8F@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Sep 11, 2007, at 11:24 AM, Scott Wood wrote:
>> I propose we do it by defining the first (and ideally only, but 
>> that's another argument) entry in ranges as the immr, and getting 
>> rid of /soc/reg.
> 
> I disagree.

I'm shocked. :-)

> I don't think we want to start overloading the meaning of something 
> like 'ranges' in that way.

As opposed to overloading the meaning of 'reg'?

It's no different than how PCI ranges are treated -- we interpret, in a 
bus-specific way, that certain ranges mean certain things.  In the case 
of fsl immr/cssr buses, the first range would mean the immr/cssr space.

>>>> And why is 82xx-pq2 special?  Wouldn't you need this on 83xx, 
>>>> 85xx, and 86xx as well?
>>> The range will cover the whole immr space on 83xx/85xx/86xx.
>> 
>> And why can't it do that on 82xx?
> 
> we can cover the whole range, thats fine.  We just need a different
> mechanism to determine immr base.

I'm unconvinced.

>>> 82xx-pq2 is special in that its soc regs are in the middle of the
>>>  immr address map.
>> 
>> The /soc node is misnamed; it should really be /immr.  Why do we 
>> need these particular registers to be in /soc/reg rather than a 
>> subnode?
> 
> They could be in a sub node if there is a clear subnode for them to 
> be in.

Does anything actually use /soc/reg as anything other than an input to
get_immrbase()?  If not, we can defer defining such nodes until there's
actually a need.

It'd probably be more efficient to discuss this in person; can you stop
by my cube sometime when you're around and not in a meeting?

-Scott
