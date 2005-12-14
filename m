Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5BEB1688A1
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 01:41:26 +1100 (EST)
In-Reply-To: <1134569118.3875.9.camel@localhost>
References: <1134569118.3875.9.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <66D10776-B8F2-48E4-9B96-CA37323B5799@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 14 Dec 2005 08:41:25 -0600
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: illegal instructions / irqs disabled warning
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 14, 2005, at 8:05 AM, Johannes Berg wrote:

> So I run across this warning:
> [ 2724.595549] Debug: sleeping function called from invalid context  
> at arch/ppc/kernel/traps.c:528
> [ 2724.595563] in_atomic():0, irqs_disabled():1
> [ 2724.595568] Call trace:
> [ 2724.595573]  [c001fe54] __might_sleep+0xd4/0xf0
> [ 2724.595592]  [c0005ad8] program_check_exception+0xb8/0x520
> [ 2724.595606]  [c0004f04] ret_from_except_full+0x0/0x4c
>
> when I wrote a program calling illegal instructions. I then checked  
> out
> why this happened and the cause is the might_sleep() here:
>
> #define __get_user_check(x, ptr,  
> size)                                  \
> ({                                                                     
>   \
>         long __gu_err = - 
> EFAULT;                                        \
>         unsigned long  __gu_val =  
> 0;                                    \
>         const __typeof__(*(ptr)) __user *__gu_addr =  
> (ptr);             \
>         might_sleep 
> ();                                                  \
> ...
>
> I then figured I could use __copy_from_user_inatomic to access the
> instruction word to fix this (as far as I can tell only the warning is
> annoying, because the instruction already failed at that point so it
> must be in memory, right?)

Its highly likely, but not guaranteed on all systems.  In truth this  
is most likely a bug.

> But here's the actual question:
> static inline unsigned long __copy_from_user(void *to,
>                 const void __user *from, unsigned long size)
> {
>         might_sleep();
>         return __copy_from_user_inatomic(to, from, size);
> }
>
> Does that mean __copy_from_user_inatomic isn't actually valid to  
> call in
> atomic context? Or is this only so that kernel developers that use
> powerpc see the bugs their code would have on other platforms? The  
> magic
> in get_user_asm thoroughly confuses me.

What do you mean atomic context?  Not exactly sure what your asking  
about.

- kumar
