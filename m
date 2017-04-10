Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1gsD6VBXzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:54:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, Matt Brown <matthew.brown.dev@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-raid@vger.kernel.org
Subject: Re: [v2] raid6/altivec: Add vpermxor implementation for raid6 Q
 syndrome
In-Reply-To: <87r316hxmi.fsf@possimpible.ozlabs.ibm.com>
References: <20170406053816.5239-1-matthew.brown.dev@gmail.com>
 <87r316hxmi.fsf@possimpible.ozlabs.ibm.com>
Date: Mon, 10 Apr 2017 16:54:24 +1000
Message-ID: <874lxwhhwf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Daniel Axtens <dja@axtens.net> writes:

> Hi Matt,
>
> Thanks for answering my questions and doing those fixes.
>
>
>> Bugs fixed:
>> 	- A small bug in pq.h regarding a missing and mismatched
>> 	  ifdef statement
>> 	- Fixed test/Makefile to correctly build test on ppc
>>
>
> I think this commit should be labelled:
> Fixes: 4f8c55c5ad49 ("lib/raid6: build proper files on corresponding arch")
>
> mpe can probably add that when he merges - no need to do a new version :)

Please send a separate patch which does that fix.

>>  else
>> -        HAS_ALTIVEC := $(shell printf '\#include <altivec.h>\nvector int a;\n' |\
>> -                         gcc -c -x c - >&/dev/null && \
>> -                         rm ./-.o && echo yes)
>> -        ifeq ($(HAS_ALTIVEC),yes)
>> -                OBJS += altivec1.o altivec2.o altivec4.o altivec8.o
>> +	 HAS_ALTIVEC := $(shell printf '\#include <altivec.h>\nvector int a;\n' |\
>> +			 gcc -c -x c - >/dev/null && rm ./-.o && echo yes)
>> +	 ifeq ($(HAS_ALTIVEC),yes)
>> +		CFLAGS += -I../../../arch/powerpc/include
>> +		CFLAGS += -DCONFIG_ALTIVEC
>> +		OBJS += altivec1.o altivec2.o altivec4.o altivec8.o \
>> +			vpermxor1.o vpermxor2.o vpermxor4.o vpermxor8.o
>>          endif
>>  endif
> Looks like vim has replaced spaces with tabs here. Not sure how much we
> care...

We care at least because it makes the diff look bigger than it really
is, if I'm reading it right the first three lines haven't actually
changed.

>> @@ -97,6 +99,18 @@ altivec4.c: altivec.uc ../unroll.awk
>>  altivec8.c: altivec.uc ../unroll.awk
>>  	$(AWK) ../unroll.awk -vN=8 < altivec.uc > $@
>>
> ... especially seeing as tabs are already used in the file here!

It's a Makefile! Tabs have meaning :)

>> +# ifdef __KERNEL__
>> +	return (cpu_has_feature(CONFIG_ALTIVEC) &&
>> +		cpu_has_feature(CPU_FTR_ARCH_207S));
> I think CPU_FTR_ARCH_207S implies Altivec? Again, not a real problem,

It doesn't.

And also CONFIG_ALTIVEC is not a cpu feature!

You should be using CPU_FTR_ALTIVEC_COMP. That copes with the case where
the kernel is compiled without ALTIVEC support.

cheers
