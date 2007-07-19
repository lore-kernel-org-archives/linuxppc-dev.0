Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD086DDF21
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 03:17:03 +1000 (EST)
In-Reply-To: <1184863497.16820.8.camel@ld0161-tx32>
References: <11847726193856-git-send-email-segher@kernel.crashing.org>
	<5d56173bee3f9ea0050aa508e7f27cc932af7229.1184104284.git.segher@kernel.crashing.org>
	<18078.43412.493174.590540@cargo.ozlabs.ibm.com>
	<1184863497.16820.8.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5B45DD7F-1916-4E92-B0F6-6D1C11EF391B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Treat ISI faults as read faults on classic 32-bit PowerPC
Date: Thu, 19 Jul 2007 19:16:51 +0200
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Hmmm.  The dangling else clauses are pretty gross, and in fact we  
>> have
>> the same problem on POWER3 and RS64 processors (to be fair, we had
>> the problem before and didn't notice, but we should still fix it).
>>
>> How about this instead?  Could people test it please?  (Note that
>> CPU_FTR_NOEXECUTE is 0 in 32-bit kernels.)
>>
>> Paul.
>>
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index 0ece513..99c3093 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>
> Acked-by: Jon Loeliger <jdl@freescale.com>
>
> Tested on 8641HPCN.

Which glibc versions?  glibc-2.4 and newer are fine without the
patch already, glibc-2.3 seems to get away by accident; but 2.2
(and before) are the problematic ones.

No other userland program has been identified as needing this
fix, btw -- thankfully, or the testing matrix would be _huge_.


Segher
