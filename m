Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id CE1851A0BE2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 21:43:47 +1000 (AEST)
Message-ID: <5534E670.8070804@c-s.fr>
Date: Mon, 20 Apr 2015 13:43:44 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "scottwood@freescale.com" <scottwood@freescale.com>
Subject: Re: [PATCH 07/11] powerpc/8xx: macro for handling CPU15 errata
References: <20150420052637.185801A242C@localhost.localdomain>
 <063D6719AE5E284EB5DD2968C1650D6D1CB22366@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CB22366@AcuExch.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 20/04/2015 13:40, David Laight a écrit :
> From: Christophe Leroy
>> Sent: 20 April 2015 06:27
>> Having a macro will help keep clear code.
> ...
>>    * We have to use the MD_xxx registers for the tablewalk because the
>>    * equivalent MI_xxx registers only perform the attribute functions.
>>    */
>> +
>> +#ifdef CONFIG_8xx_CPU15
>> +#define DO_8xx_CPU15(tmp, addr)	\
>> +	addi	tmp, addr, PAGE_SIZE;	\
>> +	tlbie	tmp;			\
>> +	addi	tmp, addr, PAGE_SIZE;	\
>> +	tlbie	tmp
>> +#else
>> +#define DO_8xx_CPU15(tmp, addr)
>> +#endif
> I'm sure I've spotted the same obvious error in the above before.
>
> I'd also suggest calling it 'invalidate_adjacent_pages' - since that it
> what it does.
>
> I also guess that the execution time of 'tlbie' is non-trivial.
> So you might as well get rid of the temporary register and put an
> 'addi' to reset 'addr' at the end.
>
> 	David
>

Forget it, I did a big mistake this morning, involontarily resent an old 
patch.
Sorry for the noise.

Christophe
