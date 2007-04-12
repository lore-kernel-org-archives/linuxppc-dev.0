Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5B052DDF37
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 03:06:27 +1000 (EST)
In-Reply-To: <aeef7937e978aec33074251c48dca389@kernel.crashing.org>
References: <1176382146.6379.28.camel@zod.rchland.ibm.com>
	<aeef7937e978aec33074251c48dca389@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2830816F-F1C5-450C-BA68-287D8C312561@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix PowerPC 750CL CPU features
Date: Thu, 12 Apr 2007 12:06:02 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 12, 2007, at 11:41 AM, Segher Boessenkool wrote:

>> PowerPC 750CL has high BATs.  The patch below sets cpu_features to
>> match that.
>> Without it, the original firmware mappings in the high BATs aren't
>> cleared
>> which can cause "odd" address translations to occur.
>
>> -		.cpu_features		= CPU_FTRS_750,
>> +		.cpu_features		= CPU_FTRS_750GX,
>
> The difference between these two is
>
> #define CPU_FTRS_750GX  (CPU_FTR_DUAL_PLL_750FX |  
> CPU_FTR_HAS_HIGH_BATS)
> #define CPU_FTRS_750    (CPU_FTR_COMMON)
>
> 750GX excludes COMMON, which seems like a bug.  With
> your change, 750CL uses DUAL_PLL_750FX; does it actually
> have that feature?

I agree the 750GX should include COMMON, we probably don't notice  
since its never in a SMP system.

- k
