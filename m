Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMbxy2KmCzDsQ5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 12:00:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, Matt Brown <matthew.brown.dev@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v5 1/2] lib/raid6: Build proper files on corresponding arch
In-Reply-To: <87bmnysz34.fsf@linkitivity.dja.id.au>
References: <20170428055809.2675-1-matthew.brown.dev@gmail.com>
 <87bmnysz34.fsf@linkitivity.dja.id.au>
Date: Wed, 02 Aug 2017 12:00:53 +1000
Message-ID: <87fudasp7u.fsf@concordia.ellerman.id.au>
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
>> --- a/lib/raid6/test/Makefile
>> +++ b/lib/raid6/test/Makefile
>> @@ -44,10 +44,12 @@ else ifeq ($(HAS_NEON),yes)
>>          CFLAGS += -DCONFIG_KERNEL_MODE_NEON=1
>>  else
>>          HAS_ALTIVEC := $(shell printf '\#include <altivec.h>\nvector int a;\n' |\
>> -                         gcc -c -x c - >&/dev/null && \
>> -                         rm ./-.o && echo yes)
>> +                         gcc -c -x c - >/dev/null && rm ./-.o && echo yes)
>
> From memory the change here (s/>&/>/) was necessary to get the build to
> succeed - did we ever figure out why that was? I'm not enough of a shell
> guru to grok the difference.

Using >& redirects stdout and stderr, whereas > only redirects stdout.

So possibly it doesn't fix anything, but rather lets you see any error
emitted by the compiler rather than swallowing it?

cheers
