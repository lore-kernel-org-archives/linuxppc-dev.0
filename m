Return-Path: <prasannatsmkumar@gmail.com>
Received: from mail-yb0-x241.google.com (mail-yb0-x241.google.com
 [IPv6:2607:f8b0:4002:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXb3Y6kpHzDvwD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 06:51:05 +1100 (AEDT)
Received: by mail-yb0-x241.google.com with SMTP id h184so7740401ybb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2016 11:51:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161205082357.GB3450@naverao1-tp.localdomain>
References: <20161204165521.10045-1-prasannatsmkumar@gmail.com>
 <20161205082357.GB3450@naverao1-tp.localdomain>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Tue, 6 Dec 2016 01:21:03 +0530
Message-ID: <CANc+2y7OOPGz+Gjgp4A8DcAAJEL1qtStkKfrnhQecVZDCcTSmg@mail.gmail.com>
Subject: Re: [PATCH] PPC: sstep.c: Add modsw, moduw instruction emulation
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, Ananth N <ananth@in.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Naveen,

Thanks for the review.

>> ---
>>  arch/powerpc/lib/sstep.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
>> index 9c78a9c..5acef72 100644
>> --- a/arch/powerpc/lib/sstep.c
>> +++ b/arch/powerpc/lib/sstep.c
>> @@ -1148,6 +1148,15 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>>                               (int) regs->gpr[rb];
>>                       goto arith_done;
>>
>> +             case 779:       /* modsw */
>> +                     regs->gpr[rd] = (int) regs->gpr[ra] %
>> +                             (int) regs->gpr[rb];
>> +                     goto arith_done;
>
> Since these instructions don't update CR, you can directly goto
> instr_done.

Sure. Will use that.

>> +
>> +             case 267:       /* moduw */
>
> Please move this case further up so that the extended opcodes are in
> numerical order.

Placed it after divide instruction as it appeared logical. Also placed
267 below 779 as it is the order in which the instructions are
documented in the ISA book. This may help in finding related
instructions together. If this style is not preferred I can arrange it
in numerical order.

Regards,
PrasannaKumar
