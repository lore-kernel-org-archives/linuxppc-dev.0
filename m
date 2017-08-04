Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNqFf2LZDzDqgK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 11:33:42 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id m84so358075qki.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Aug 2017 18:33:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87fudasp7u.fsf@concordia.ellerman.id.au>
References: <20170428055809.2675-1-matthew.brown.dev@gmail.com>
 <87bmnysz34.fsf@linkitivity.dja.id.au>
 <87fudasp7u.fsf@concordia.ellerman.id.au>
From: Matt Brown <matthew.brown.dev@gmail.com>
Date: Fri, 4 Aug 2017 11:33:39 +1000
Message-ID: <CAPoR37bTFG4_keEp10903H+9AD97T=Z2kyjR4q4sjB0cE0+J6w@mail.gmail.com>
Subject: Re: [v5 1/2] lib/raid6: Build proper files on corresponding arch
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 2, 2017 at 12:00 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Daniel Axtens <dja@axtens.net> writes:
>
>> Hi Matt,
>>
>>> --- a/lib/raid6/test/Makefile
>>> +++ b/lib/raid6/test/Makefile
>>> @@ -44,10 +44,12 @@ else ifeq ($(HAS_NEON),yes)
>>>          CFLAGS += -DCONFIG_KERNEL_MODE_NEON=1
>>>  else
>>>          HAS_ALTIVEC := $(shell printf '\#include <altivec.h>\nvector int a;\n' |\
>>> -                         gcc -c -x c - >&/dev/null && \
>>> -                         rm ./-.o && echo yes)
>>> +                         gcc -c -x c - >/dev/null && rm ./-.o && echo yes)
>>
>> From memory the change here (s/>&/>/) was necessary to get the build to
>> succeed - did we ever figure out why that was? I'm not enough of a shell
>> guru to grok the difference.
>
> Using >& redirects stdout and stderr, whereas > only redirects stdout.
>
> So possibly it doesn't fix anything, but rather lets you see any error
> emitted by the compiler rather than swallowing it?
>

Just had to double-check what the problem was.
The bug was that none of the ppc specific files were being built.
I'm not entirely sure how, but this fixes it so the altivec and
vpermxor files are built.

I'll fix up the commit message and move the vpermxor make defs into
the other patch.

Thanks,
Matt

> cheers
