Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7zwn1h2GzDqg2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 14:19:37 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id m54so8673723qtb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 21:19:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170713072821.GB13471@gate.crashing.org>
References: <20170713032548.451-1-matthew.brown.dev@gmail.com>
 <20170713032548.451-3-matthew.brown.dev@gmail.com>
 <20170713072821.GB13471@gate.crashing.org>
From: Matt Brown <matthew.brown.dev@gmail.com>
Date: Fri, 14 Jul 2017 14:19:34 +1000
Message-ID: <CAPoR37Ymuy95zzshsgwQwsCyMJwdc3MOzneL4=dq_xABY7o_dA@mail.gmail.com>
Subject: Re: [PATCH 3/5] powerpc/lib/sstep: Add bpermd instruction emulation
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 13, 2017 at 5:28 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Thu, Jul 13, 2017 at 01:25:46PM +1000, Matt Brown wrote:
>> +static nokprobe_inline void do_bpermd(struct pt_regs *regs, unsigned long v1,
>> +                             unsigned long v2, int ra)
>> +{
>> +     unsigned int idx, i;
>> +     unsigned char perm;
>> +
>> +     perm = 0x0;
>> +     for (i = 0; i < 8; i++) {
>> +             idx = (v1 >> (i * 8)) & 0xff;
>> +             if (idx < 64)
>> +                     perm |= (v2 & (1 << idx)) >> (idx - i);
>
> That doesn't work I think, the bit numbers ("idx") are big-endian?

Why would it be big-endian? Wouldn't it be in the same endian form as the arch?
>
>> +     }
>> +     regs->gpr[ra] = 0 | perm;
>
> And that is just silly :-)
>

Yep that is silly.

Thanks,
Matt

>> +}
>
>
> Segher
