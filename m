Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 0CE911A08ED
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 00:27:41 +1100 (AEDT)
Message-ID: <54ABE2CA.8030608@c-s.fr>
Date: Tue, 06 Jan 2015 14:27:38 +0100
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>,
 'Joakim Tjernlund' <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 05/11] powerpc/8xx: Optimise access to swapper_pg_dir
References: <20141216150338.D4F0A1A5E0A@localhost.localdomain>
 <1420482826.25047.26.camel@transmode.se>
 <063D6719AE5E284EB5DD2968C1650D6D1CAC1765@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CAC1765@AcuExch.aculab.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: "scottwood@freescale.com" <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 06/01/2015 13:08, David Laight a écrit :
>> On Tue, 2014-12-16 at 16:03 +0100, Christophe Leroy wrote:
>>> All accessed to PGD entries are done via 0(r11).
>>> By using lower part of swapper_pg_dir as load index to r11, we can remove the
>>> ori instruction.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Nice :)
>> Acked-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
>>
>>> ---
>>>   arch/powerpc/kernel/head_8xx.S | 22 ++++++++++------------
>>>   1 file changed, 10 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
>>> index ae05f28..aa45225 100644
>>> --- a/arch/powerpc/kernel/head_8xx.S
>>> +++ b/arch/powerpc/kernel/head_8xx.S
>>> @@ -322,13 +322,12 @@ InstructionTLBMiss:
>>>          mfspr   r11, SPRN_M_TW/* Get level 1 table base address */
>>>   #ifdef CONFIG_MODULES
>>>          beq     3f
>>> -       lis     r11, (swapper_pg_dir-PAGE_OFFSET)@h
>>> -       ori     r11, r11, (swapper_pg_dir-PAGE_OFFSET)@l
>>> +       lis     r11, (swapper_pg_dir-PAGE_OFFSET)@ha
>>>   3:
>>>   #endif
>>>          /* Insert level 1 index */
>>>          rlwimi  r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
>>> -       lwz     r11, 0(r11)/* Get the level 1 entry */
>>> +       lwz     r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)/* Get the level 1 entry */
>>>
> On the face of it that fragment doesn't look right when CONFIG_MODULES is undefined.
>
> 	David
>
I'm not sure I understand what you mean.

The other part of the patch adds the following:
+    li    r5, (swapper_pg_dir-PAGE_OFFSET)@l
+    sub    r4, r4, r5

r4 is the value put into SPRN_M_TW, so I don't see what may be wrong.

Christophe
