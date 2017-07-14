Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-qk0-x22c.google.com (mail-qk0-x22c.google.com
 [IPv6:2607:f8b0:400d:c09::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7vGj1QZ8zDqkm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 10:49:49 +1000 (AEST)
Received: by mail-qk0-x22c.google.com with SMTP id v17so58598952qka.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 17:49:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170713074732.GD13471@gate.crashing.org>
References: <20170713032548.451-1-matthew.brown.dev@gmail.com>
 <20170713032548.451-5-matthew.brown.dev@gmail.com>
 <20170713074732.GD13471@gate.crashing.org>
From: Matt Brown <matthew.brown.dev@gmail.com>
Date: Fri, 14 Jul 2017 10:49:46 +1000
Message-ID: <CAPoR37bHoNwN7MEO0JTLh_23vwPo5scbjbjHQ6Q_nF-xBg5Baw@mail.gmail.com>
Subject: Re: [PATCH 5/5] powerpc/lib/sstep: Add isel instruction emulation
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

On Thu, Jul 13, 2017 at 5:47 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Thu, Jul 13, 2017 at 01:25:48PM +1000, Matt Brown wrote:
>> +             case 585:       /* isel */
>
> The secondary opcode for isel is only 5 bits, not 10 like most other
> insns have.

Yet another conversion mistake, I'll get there one day!

>
>> +                     mb = (instr >> 6) & 0x1f; /* bc */
>> +                     val = (regs->ccr >> (mb + 32)) & 1;
>
> regs->ccr >> (31 - mb)  ?
>
>> +
>> +                     if (val)
>> +                             regs->gpr[rd] = regs->gpr[ra];
>
> You need to treat ra=0 separately (as 0, not reg 0).
>
Ah I missed that. The wording in the ISA doesn't make that completely obvious.

Thanks,
Matt

>> +                     else
>> +                             regs->gpr[rd] = regs->gpr[rb];
>> +                     goto logical_done;
>
>
> Segher
