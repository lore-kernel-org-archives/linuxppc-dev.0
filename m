Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GJTY68dfzDrJv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 00:07:45 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: Checkpatch bad Warning (Re: [PATCH] powerpc/kgdb: add
 kgdb_arch_set/remove_breakpoint())
To: Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>,
 Andy Whitcroft <apw@canonical.com>, paul.burton@mips.com,
 ralf@linux-mips.org, jhogan@kernel.org
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
References: <872199441fd43b05fc1c7d049098ef7c0e83f4c5.1537262646.git.christophe.leroy@c-s.fr>
 <2f5f572a-a28c-9d17-844b-9e1961febf64@c-s.fr>
 <595c96f5adcccd7eab9dc95eb48618981af66d3c.camel@perches.com>
 <87worgia60.fsf@concordia.ellerman.id.au>
 <f9ad7501-4d07-ddc2-6236-a7eb61283378@c-s.fr>
Message-ID: <32b61fef-8da3-9203-1115-78e69afc56d4@c-s.fr>
Date: Thu, 20 Sep 2018 14:07:41 +0000
MIME-Version: 1.0
In-Reply-To: <f9ad7501-4d07-ddc2-6236-a7eb61283378@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding MIPS arch in the loop

On 09/20/2018 01:19 PM, Christophe LEROY wrote:
> 
> 
> Le 20/09/2018 à 15:13, Michael Ellerman a écrit :
>> Joe Perches <joe@perches.com> writes:
>>
>>> On Tue, 2018-09-18 at 09:33 +0000, Christophe Leroy wrote:
>>>> On the below patch, checkpatch reports
>>>>
>>>> WARNING: struct kgdb_arch should normally be const
>>>> #127: FILE: arch/powerpc/kernel/kgdb.c:480:
>>>> +struct kgdb_arch arch_kgdb_ops;
>>>>
>>>> But when I add 'const', I get compilation failure
>>>
>>> So don't add const.
>>>
>>> checkpatch is stupid.  You are not.
>>>
>>> _Always_ take checkpatch bleats with very
>>> large grains of salt.
>>>
>>> Perhaps send a patch to remove kgbd_arch
>>> from scripts/const_structs.checkpatch as
>>> it seems not ever to be const.
>>
>> I think it could/should be const though, it just requires updating all
>> arches.
>>
> 
> Yes I was thinking about doing it, but first thing is to change the way 
> MIPS initialises it:
> 
> 
> struct kgdb_arch arch_kgdb_ops;
> 
> int kgdb_arch_init(void)
> {
>      union mips_instruction insn = {
>          .r_format = {
>              .opcode = spec_op,
>              .func    = break_op,
>          }
>      };
>      memcpy(arch_kgdb_ops.gdb_bpt_instr, insn.byte, BREAK_INSTR_SIZE);
> 
> 
> Can this be done staticaly ?
> 
> Christophe
