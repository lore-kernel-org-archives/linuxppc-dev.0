Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-qk0-x22c.google.com (mail-qk0-x22c.google.com
 [IPv6:2607:f8b0:400d:c09::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMb6t0Ym3zDrMw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 11:23:34 +1000 (AEST)
Received: by mail-qk0-x22c.google.com with SMTP id z18so19089317qka.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 18:23:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170801124433.GI13471@gate.crashing.org>
References: <20170731005826.32044-1-matthew.brown.dev@gmail.com>
 <20170801124433.GI13471@gate.crashing.org>
From: Matt Brown <matthew.brown.dev@gmail.com>
Date: Wed, 2 Aug 2017 11:23:31 +1000
Message-ID: <CAPoR37YD7UykvHy8WNdn62MaWX6D6=TubHgQm_7R2SMpcRVxbg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] powerpc/lib/sstep: Add cmpb instruction emulation
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
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

On Tue, Aug 1, 2017 at 10:44 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> Hi!
>
> On Mon, Jul 31, 2017 at 10:58:22AM +1000, Matt Brown wrote:
>> @@ -1049,6 +1065,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>>                       do_cmp_unsigned(regs, val, val2, rd >> 2);
>>                       goto instr_done;
>>
>> +             case 508: /* cmpb */
>> +                     do_cmpb(regs, regs->gpr[rd], regs->gpr[rb], ra);
>> +                     goto instr_done;
>
> Should this then be under an ifdef for 64-bit?

I don't think so, the cmpb instruction should be 32 and 64-bit.
It isn't listed under the '64-bit Fixed-point Logical Instructions'
section in the ISA either.

Thanks,
Matt
>
>
> Segher
