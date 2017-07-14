Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-qk0-x22a.google.com (mail-qk0-x22a.google.com
 [IPv6:2607:f8b0:400d:c09::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7vBl1CJszDqkm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 10:46:23 +1000 (AEST)
Received: by mail-qk0-x22a.google.com with SMTP id v17so58559030qka.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 17:46:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170713073757.GC13471@gate.crashing.org>
References: <20170713032548.451-1-matthew.brown.dev@gmail.com>
 <20170713032548.451-4-matthew.brown.dev@gmail.com>
 <20170713073757.GC13471@gate.crashing.org>
From: Matt Brown <matthew.brown.dev@gmail.com>
Date: Fri, 14 Jul 2017 10:46:20 +1000
Message-ID: <CAPoR37bkFAguL1SGa1Zfq-+H1pwN_LE0PV4VHD_GLt9+Kw1gOg@mail.gmail.com>
Subject: Re: [PATCH 4/5] powerpc/lib/sstep: Add prty instruction emulation
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

On Thu, Jul 13, 2017 at 5:37 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Thu, Jul 13, 2017 at 01:25:47PM +1000, Matt Brown wrote:
>> +static nokprobe_inline void do_prtyw(struct pt_regs *regs, unsigned long v,
>> +                             int ra)
>> +{
>> +     unsigned long low, high, out;
>> +     unsigned int i;
>> +
>> +     high = 0;
>> +     low = 0;
>> +     out = 0;
>> +
>> +     for (i = 0; i < 8; i++) {
>> +             if (v & (1 << (i * 8)))
>
> 1UL
>
>> +                     (i < 4) ? (low++) : (high++);
>> +     }
>> +
>> +     if (low % 2)
>> +             out |= low;
>> +     if (high % 2)
>> +             out |= (high << 32);
>
> Only the low bit of each word of the output can be set.  Something
> like
>
>   out = ((high & 1) << 32) | (low & 1);
>
Ah, I wasn't aware. That way is much more concise too :)

Thanks,
Matt
>
> Segher
