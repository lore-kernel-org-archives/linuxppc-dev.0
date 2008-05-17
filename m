Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8482BDDE25
	for <linuxppc-dev@ozlabs.org>; Sun, 18 May 2008 01:00:36 +1000 (EST)
Message-Id: <EEBAB3F3-A472-41D1-872F-BEF7616CADC3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080517125517.46cd43a7.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v3 3/3] [POWERPC] 40x/Book-E: Save/restore volatile
	exception registers
Date: Sat, 17 May 2008 10:00:14 -0500
References: <Pine.LNX.4.64.0805161404410.6286@blarg.am.freescale.net>
	<Pine.LNX.4.64.0805161406100.6286@blarg.am.freescale.net>
	<Pine.LNX.4.64.0805161407440.6286@blarg.am.freescale.net>
	<20080517125517.46cd43a7.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 16, 2008, at 9:55 PM, Stephen Rothwell wrote:

> Hi Kumar,
>
> On Fri, 16 May 2008 14:08:00 -0500 (CDT) Kumar Gala <galak@kernel.crashing.org 
> > wrote:
>>
>> +++ b/arch/powerpc/kernel/asm-offsets.c
>> @@ -52,6 +52,15 @@
>> #include <asm/iseries/alpaca.h>
>> #endif
>>
>> +#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
>> +#include "head_booke.h"
>> +#endif
>> +
>> +#define DEFINE(sym, val) \
>> +	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
>> +
>> +#define BLANK() asm volatile("\n->" : : )
>> +
>
> Why are these defines here? We already pick them up from kbuild.h ...

thanks, this is a mismerge from some old tree, will clean up.

- k
