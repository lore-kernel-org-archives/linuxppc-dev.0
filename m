Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8474DDFBE
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 14:14:23 +1000 (EST)
Message-Id: <133B6911-6594-4366-9A0E-DF2604DFDA4C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B046E7B25@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: 1 GB lowmem
Date: Wed, 21 May 2008 23:13:59 -0500
References: <DCEAAC0833DD314AB0B58112AD99B93B046E79B3@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E7AA0@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E7AF5@ismail.innsys.innovsys.com>
	<1941C6C3-9883-4015-91A6-35F5966AA1ED@kernel.crashing.org>
	<DCEAAC0833DD314AB0B58112AD99B93B046E7B25@ismail.innsys.innovsys.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 21, 2008, at 4:24 PM, Rune Torgersen wrote:

> Kumar Gala wrote:
>> On May 21, 2008, at 3:55 PM, Rune Torgersen wrote:
>>> Argh... Found it. Had to set CONFIG_TASK_SIZE to 0x80000000. Now it
>>> works in both vaniulla an d RT kernel.
>>
>> We should really add some sanity check on CONFIG_TASK_SIZE vs
>> KERNEL_START.
>
> Something like this?
> Wording sould probablyy be a bit different/cleare.
>
> diff --git a/include/asm-powerpc/processor.h
> b/include/asm-powerpc/processor.h
> index fd98ca9..72e0e3f 100644
> --- a/include/asm-powerpc/processor.h
> +++ b/include/asm-powerpc/processor.h
> @@ -81,6 +81,10 @@ extern struct task_struct *last_task_used_altivec;
> extern struct task_struct *last_task_used_spe;
>
> #ifdef CONFIG_PPC32
> +
> +#if CONFIG_TASK_SIZE > CONFIG_KERNEL_START
> +#error User TASK_SIZE overlaps with KERNEL_START address
> +#endif
> #define TASK_SIZE      (CONFIG_TASK_SIZE)
>
> /* This decides where the kernel will search for a free chunk of vm
>

something like that would be good.  is there really anything PPC32  
specific about it?

- k
