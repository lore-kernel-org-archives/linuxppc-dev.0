Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C52BDDF25
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 23:59:49 +1000 (EST)
In-Reply-To: <200710222012.20316.yur@emcraft.com>
References: <200710181108.19413.yur@emcraft.com>
	<18199.60025.563689.10810@cargo.ozlabs.ibm.com>
	<E0BC0C69-03B1-4F7A-9DEC-0EA9DAC92FB7@kernel.crashing.org>
	<200710222012.20316.yur@emcraft.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6c38f6dc60553ae158e4d3094b879e10@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
Date: Tue, 23 Oct 2007 15:59:31 +0200
To: Yuri Tikhonov <yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> The following patch adds support for 256KB PAGE_SIZE on ppc44x-
>>>> based boards.
>>>> The applications to be run on the kernel with 256KB PAGE_SIZE have
>>>> to be
>>>> built using the modified version of binutils, where the MAXPAGESIZE
>>>> definition is set to 0x40000 (as opposite to standard 0x10000).
>>>
>>> Have you measured the performance using a 64kB page size?  If so, how
>>> does it compare with the 256kB page size?
>>
>> I was wondering about this as well?  Isn't this technically in
>> violation of the ABI?
>
>  No it isn't the violation.
>
>  As stated in "System V ABI. PowerPC processor supplement"
> (on which the "Linux Standard Base Core Specification for PPC32"
> is based): " ... Virtual addresses and file offsets for the PowerPC 
> processor family
> segments are congruent modulo 64 Kbytes (0x10000) or larger powers of 
> 2...".
>
>  So, 256 Kbytes is just a larger case.

If I understand you correctly, the only problem with existing binaries
is that the ELF segments are aligned to 64kB, but not necessarily to
256kB.  Couldn't you handle this as a special case, for example by
mapping the "ends" of such an unaligned segment with normal 4kB pages?
That way, a new binutils isn't required to get a big part of the 
benefit,
and importantly, existing shared library binaries will work with your
apps.


Segher
