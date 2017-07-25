Return-Path: <bsingharora@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGzgw28qVzDqmW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 23:32:44 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id v76so1059274qka.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 06:32:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD003FBDF@AcuExch.aculab.com>
References: <20170725033320.17893-1-matthew.brown.dev@gmail.com>
 <20170725033320.17893-2-matthew.brown.dev@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DD003FBDF@AcuExch.aculab.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 25 Jul 2017 23:32:40 +1000
Message-ID: <CAKTCnz==rx7hP5YN2i8nSyeXvbF+A=J5YrZDbOHoTvNKVxCmqQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] powerpc/lib/sstep: Add popcnt instruction emulation
To: David Laight <David.Laight@aculab.com>
Cc: Matt Brown <matthew.brown.dev@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 25, 2017 at 8:24 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+david.laight=aculab.com@lists.ozlabs.org] On Behalf Of
>> Matt Brown
>> Sent: 25 July 2017 04:33
>> To: linuxppc-dev@lists.ozlabs.org
>> Subject: [PATCH v3 2/5] powerpc/lib/sstep: Add popcnt instruction emulation
>>
>> This adds emulations for the popcntb, popcntw, and popcntd instructions.
>> Tested for correctness against the popcnt{b,w,d} instructions on ppc64le.
>>
>> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
>> ---
>> v3:
>>       - optimised using the Giles-Miller method of side-ways addition
>> v2:
>>       - fixed opcodes
>>       - fixed typecasting
>>       - fixed bitshifting error for both 32 and 64bit arch
>> ---
>>  arch/powerpc/lib/sstep.c | 40 +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
>> index 87d277f..c1f9cdb 100644
>> --- a/arch/powerpc/lib/sstep.c
>> +++ b/arch/powerpc/lib/sstep.c
>> @@ -612,6 +612,32 @@ static nokprobe_inline void do_cmpb(struct pt_regs *regs, unsigned long v1,
>>       regs->gpr[rd] = out_val;
>>  }
>>
>> +/*
>> + * The size parameter is used to adjust the equivalent popcnt instruction.
>> + * popcntb = 8, popcntw = 32, popcntd = 64
>> + */
>> +static nokprobe_inline void do_popcnt(struct pt_regs *regs, unsigned long v1,
>> +                             int size, int ra)
>> +{
>> +     unsigned long long out = v1;
>> +
>> +     out = (0x5555555555555555 & out) + (0x5555555555555555 & (out >> 1));
>> +     out = (0x3333333333333333 & out) + (0x3333333333333333 & (out >> 2));
>> +     out = (0x0f0f0f0f0f0f0f0f & out) + (0x0f0f0f0f0f0f0f0f & (out >> 4));
>> +     if (size == 8) {        /* popcntb */
>> +             regs->gpr[ra] = out;
>
> I'm pretty sure you need to mask the result with 7.
>
Absolutely! Good catch!

Balbir Singh.
