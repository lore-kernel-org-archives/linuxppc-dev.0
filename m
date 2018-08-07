Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lP023PYzzDqgF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 04:57:22 +1000 (AEST)
Date: Tue, 07 Aug 2018 20:57:18 +0200
Message-ID: <20180807205718.Horde.hQCYOtyzfY7xFtxCwRj2Iw1@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Breno Leitao <leitao@debian.org>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/tm: Print 64-bits MSR
References: <5b85006b6695bd94f4818357be607036e9df8696.camel@neuling.org>
 <1533648900-7933-1-git-send-email-leitao@debian.org>
 <95db63eb-6fb7-eed3-1ce8-8b2c053dff47@c-s.fr>
 <c5be0bf4-de2c-6fe4-3192-f48aade9506b@debian.org>
In-Reply-To: <c5be0bf4-de2c-6fe4-3192-f48aade9506b@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Breno Leitao <leitao@debian.org> a =C3=A9crit=C2=A0:

> Hi,
>
> On 08/07/2018 02:15 PM, Christophe LEROY wrote:
>> Le 07/08/2018 =C3=A0 15:35, Breno Leitao a =C3=A9crit=C2=A0:
>>> On a kernel TM Bad thing program exception, the Machine State Register
>>> (MSR) is not being properly displayed. The exception code dumps a 32-bi=
ts
>>> value but MSR is a 64 bits register for all platforms that have HTM
>>> enabled.
>>>
>>> This patch dumps the MSR value as a 64-bits value instead of 32 bits. I=
n
>>> order to do so, the 'reason' variable could not be used, since it trimm=
ed
>>> MSR to 32-bits (int).
>>
>> reason is not always regs->msr, see get_reason(), allthough in your=20=
=20
>>=20case it is.
>>
>> I think it would be better to change 'reason' to 'unsigned long' instead=
 of
>> replacing it by regs->msr for the printk.
>
> That was my initial approach, but this code seems to run on 32 bits syste=
m,
> and I do not want to change the whole 'reason' bit width without having a=
 32
> bits to test, at least.

But 'unsigned long' is still 32 bits on ppc32, so it makes no=20=20
difference=20with 'unsigned int'
And I will test it for you if needed

Christophe

>
> Also, it is a bit weird doing something as:
>
> 	printk("....(msr 0x%lx)....", reason);
>
> I personally think that the follow code is much more readable:
>
> 	printk(".... (msr 0x%lx)...", regs->msr);
