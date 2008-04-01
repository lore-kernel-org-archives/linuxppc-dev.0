Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 98941DE011
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 09:08:51 +1100 (EST)
Message-Id: <451ABD36-3763-4AF0-B24B-AF043393A72C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18417.44855.137234.450478@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Move phys_addr_t definition into asm/types.h
Date: Tue, 1 Apr 2008 17:08:44 -0500
References: <Pine.LNX.4.64.0803281338360.15109@blarg.am.freescale.net>
	<18417.44855.137234.450478@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 31, 2008, at 10:42 PM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>> Moved phys_addr_t out of mmu-*.h and into asm/types.h so we can use  
>> it in
>> places that before would have caused recursive includes.
>>
>> For example to use phys_addr_t in <asm/page.h> we would have included
>> <asm/mmu.h> which would have possibly included <asm/mmu-hash64.h>  
>> which
>> includes <asm/page.h>.  Wheeee recursive include.
>
> In general this looks fine.  I wonder if you should use u64 rather
> than unsigned long long.  Since CONFIG_PHYS_64BIT=n on 64-bit machines
> (which is itself somewhat counterintuitive) we will actually use
> unsigned long on 64-bit machines, so it matters less than I originally
> thought, but it would be worth explaining that in a comment and/or the
> commit message.

We could change it to be:

/* Physical address used by some IO functions */
#if defined(CONFIG_PPC64) || defined(CONFIG_PHYS_64BIT)
typedef u64 phys_addr_t;
#else
typedef u32 phys_addr_t;
#endif

This seems a bit more self documenting which is always nice (and I can  
add a comment in the commit message about CONFIG_PHYS_64BIT only  
making sense on ppc32).

- k
