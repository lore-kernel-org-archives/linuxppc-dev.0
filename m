Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNpkR0pTfzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 11:10:07 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id d10so325181qtb.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Aug 2017 18:10:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170801125735.GJ13471@gate.crashing.org>
References: <20170707070249.15773-1-matthew.brown.dev@gmail.com>
 <87lgn555vs.fsf@concordia.ellerman.id.au>
 <20170801125735.GJ13471@gate.crashing.org>
From: Matt Brown <matthew.brown.dev@gmail.com>
Date: Fri, 4 Aug 2017 11:10:04 +1000
Message-ID: <CAPoR37b+J19h06cgOeLYuU6WO_-rsu49a8S3MCQ1dQEVwbXHGg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/powernv: Use darn instr for random_seed on p9
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
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

On Tue, Aug 1, 2017 at 10:57 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Mon, Jul 31, 2017 at 07:10:15PM +1000, Michael Ellerman wrote:
>> And ___PPC_RA() is not quite right. The L field is only 2 bits wide, not
>> the 5 that ___PPC_RA() allows.
>>
>> We don't have a __PPC_L() macro, because L fields vary in size and
>> location. So I think you're best of open coding it, eg:
>>
>> +#define PPC_DARN(t, l)               stringify_in_c(.long PPC_INST_DARN |  \
>> +                                             __PPC_RT(t)        |  \
>> +                                             (((l) & 0x3) << 16))
>
> It would be better if you could do a compile-time error if the L value
> is out of range.  Hrm, nothing else does such checking either?
>

Yeah currently the only checks are whether the register value is
valid, using the __PPC_R{A,B,S,T} macros.
However, we can't use these macros for inline asm because we're
passing a variable into it
so the pre-processor attempts to look for register %0 which breaks it.
(Have to use triple underscore versions)

We could add more checking to validate the L value, but I don't know
how much of an issue it currently is.
A question for mpe I guess.

Thanks,
Matt


>
> Segher
