Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C16B2DDF59
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 12:52:54 +1100 (EST)
Message-Id: <FEB25EA2-7E41-4CB1-AC88-6C6CBE2A60BD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1206665138.8173.3.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Clean up some linker and symbol usage
Date: Thu, 27 Mar 2008 20:52:43 -0500
References: <Pine.LNX.4.64.0803271452540.12382@blarg.am.freescale.net>
	<18412.10838.984230.869068@cargo.ozlabs.ibm.com>
	<1206665138.8173.3.camel@concordia.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 27, 2008, at 7:45 PM, Michael Ellerman wrote:
>
> On Fri, 2008-03-28 at 10:14 +1100, Paul Mackerras wrote:
>> Kumar Gala writes:
>>
>>> @@ -1124,7 +1124,7 @@ void __init early_init_devtree(void *params)
>>> 	parse_early_param();
>>>
>>> 	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
>>> -	lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
>>> +	lmb_reserve(__pa(_stext), _end - _stext);
>>
>> In the kdump case where the kernel starts at the 32MB point
>> (physical), wouldn't we want to reserve the first 32MB of RAM so that
>> it can't get allocated and used for random things?  Doesn't that  
>> first
>> 32MB contain the old kernel that we want to write out?
>
> For kdump there is nMB of memory reserved at 32MB for the 2nd kernel,
> and that's all it gets, all of the other memory is the old kernel text
> or the old kernel's data.

My understanding is those reservations are handled by the device tree  
that is passed to the 2nd kernel.

- k
