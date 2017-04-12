Return-Path: <dja@axtens.net>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2z8l2JJFzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 19:27:18 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id g2so4080272pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 02:27:18 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-raid@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/raid6: Build proper files on corresponding arch
In-Reply-To: <87wpaqt8ia.fsf@concordia.ellerman.id.au>
References: <20170412013552.21650-1-matthew.brown.dev@gmail.com>
 <87wpaqt8ia.fsf@concordia.ellerman.id.au>
Date: Wed, 12 Apr 2017 19:27:12 +1000
Message-ID: <87inmakmbz.fsf@possimpible.ozlabs.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> Matt Brown <matthew.brown.dev@gmail.com> writes:
>
>> diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
>> index 9c333e9..62b26d1 100644
>> --- a/lib/raid6/test/Makefile
>> +++ b/lib/raid6/test/Makefile
>> @@ -44,10 +44,12 @@ else ifeq ($(HAS_NEON),yes)
>>          CFLAGS += -DCONFIG_KERNEL_MODE_NEON=1
>>  else
>>          HAS_ALTIVEC := $(shell printf '\#include <altivec.h>\nvector int a;\n' |\
>> -                         gcc -c -x c - >&/dev/null && \
>> -                         rm ./-.o && echo yes)
>> +			 gcc -c -x c - >/dev/null && rm ./-.o && echo yes)
>>          ifeq ($(HAS_ALTIVEC),yes)
>> -                OBJS += altivec1.o altivec2.o altivec4.o altivec8.o
>> +		CFLAGS += -I../../../arch/powerpc/include
>> +		CFLAGS += -DCONFIG_ALTIVEC
>> +		OBJS += altivec1.o altivec2.o altivec4.o altivec8.o \
>> +			vpermxor1.o vpermxor2.o vpermxor4.o vpermxor8.o
>
> The whitespace in here is a bit of a mess, but you should follow what's
> there and use spaces to indent your additions.

My apologies for steering you in the wrong direction here Matt!

Also, should the changes to altivec.uc in patch 2 be part of this patch?
>From memory they are also needed to run the tests?

Regards,
Daniel
>
> cheers
