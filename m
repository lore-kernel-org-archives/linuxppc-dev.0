Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 4CE7967EE5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Aug 2005 05:48:53 +1000 (EST)
In-Reply-To: <42FCCEA4.2030409@ru.mvista.com>
References: <42FCCEA4.2030409@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <725685C1-2B6B-4B19-A1E9-D68AB21AFEAF@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 12 Aug 2005 14:48:49 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] identify_ppc_sys_by_name_and_id function implementation
	final
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Aug 12, 2005, at 11:30 AM, Vitaly Bordug wrote:

> Kumar Gala wrote:
>
>> Can you do a sizeof instead?
>>
>> #define num_ele sizeof(ppc_sys_specs[])/sizeof(struct ppc_sys_spec)
>>
>> Something like matchted[num_ele] ??
>>
>>
>
> That's what the first I tried actually :)
> gcc is not happy with it:
>
> arch/ppc/syslib/ppc_sys.c: In function `find_chip_by_name_and_id':
> arch/ppc/syslib/ppc_sys.c:54: error: parse error before ']' token
>
> and if I remove [] from the ppc_sys_specs, it outputs:
>
> arch/ppc/syslib/ppc_sys.c: In function `find_chip_by_name_and_id':
> arch/ppc/syslib/ppc_sys.c:54: error: invalid application of  
> `sizeof' to
> incomplete type `({anonymous})'
>
> So I cannot use sizeof this case, I think...

Realized the same thing.  I'm thinking that your original method is  
the best solution to just do this on the stack.  In general the  
number or processors (array size) is going to be less than 100.  So  
at most this array is going to end up being 100 bytes on the stack.   
I dont think that's a big deal at the point we are calling this.

- kumar
