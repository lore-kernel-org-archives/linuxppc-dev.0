Return-Path: <dev@codyps.com>
Received: from mail-lb0-x232.google.com (mail-lb0-x232.google.com
 [IPv6:2a00:1450:4010:c04::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 587851A024F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 09:27:03 +1000 (EST)
Received: by mail-lb0-f178.google.com with SMTP id w7so6214980lbi.37
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 16:26:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1401318025.19335.15.camel@joe-AO725>
References: <1401236684-10579-1-git-send-email-dev@codyps.com>
 <1401236684-10579-12-git-send-email-dev@codyps.com>
 <063D6719AE5E284EB5DD2968C1650D6D1724EEAF@AcuExch.aculab.com>
 <CAPoQQ-17OHotfbczJvEoq=vAzu_+6-sV3M1ZAhDaQ45wB3NB4A@mail.gmail.com>
 <CAPoQQ-11vW3Q0=LcS-myNZ6hXeYBeu==_prwHJXHvLfkUSmZHQ@mail.gmail.com>
 <1401318025.19335.15.camel@joe-AO725>
Date: Wed, 28 May 2014 18:26:57 -0500
Message-ID: <CAPoQQ-2Mjx7kHC8FSDBnLT2Y+m9W9cB_Q5ohWoYsKmxyhBp_DQ@mail.gmail.com>
Subject: Re: [PATCH 11/16] byteorder: provide a linux/byteorder.h with {be,
 le}_to_cpu() and cpu_to_{be, le}() macros
From: Cody P Schafer <dev@codyps.com>
To: Joe Perches <joe@perches.com>
Content-Type: text/plain; charset=UTF-8
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 David Laight <David.Laight@aculab.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 28, 2014 at 6:00 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2014-05-28 at 17:11 -0500, Cody P Schafer wrote:
>> On Wed, May 28, 2014 at 5:05 PM, Cody P Schafer <dev@codyps.com> wrote:
>> > On Wed, May 28, 2014 at 3:45 AM, David Laight <David.Laight@aculab.com> wrote:
>> >> From: Cody P Schafer
>> >>> Rather manually specifying the size of the integer to be converted, key
>> >>> off of the type size. Reduces duplicate size info and the occurance of
>> >>> certain types of bugs (using the wrong sized conversion).
>> >> ...
>> >>> +#define be_to_cpu(v) \
>> >>> +     __builtin_choose_expr(sizeof(v) == sizeof(uint8_t) , v, \
>> >>> +     __builtin_choose_expr(sizeof(v) == sizeof(uint16_t), be16_to_cpu(v), \
>> >>> +     __builtin_choose_expr(sizeof(v) == sizeof(uint32_t), be32_to_cpu(v), \
>> >>> +     __builtin_choose_expr(sizeof(v) == sizeof(uint64_t), be64_to_cpu(v), \
>> >>> +             (void)0))))
>> >> ...
>> >>
>> >> I'm not at all sure that using the 'size' of the constant will reduce
>> >> the number of bugs - it just introduces a whole new category of bugs.
>> >
>> > Certainly, if you mis-size the argument (and thus have missized one of
>> > the variables containing the be value, probably a bug anyhow), there
>> > will be problems.
>> >
>> > I put this interface together because of an actual bug I wrote into
>> > the initial code of the hv_24x7 driver (resized a struct member
>> > without adjusting the be*_to_cpu() sizing).
>> > Having this "auto sizing" macro means I can avoid encoding the size of
>> > a struct field in multiple places.
>>
>> To clarify, the point I'm making here is that this simply cuts out 1
>> more place we can screw up endianness conversion sizing.
>
> It does screw up other types when you do things like:
>
>         u8 foo = some_function();
>
>         cpu_to_be(foo + 1);
>
> the return value is sizeof(int) not u8

Yep, that is a very good argument against the cpu_to_{be,le}()
variants. It might make sense to remove them and just have the
{be,le}_to_cpu() ones.
