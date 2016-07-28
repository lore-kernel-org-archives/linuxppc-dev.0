Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0Tyc538SzDrPM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 21:24:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: Re: [PATCH v3 12/21] powerpc/mm: Convert early cpu/mmu feature check
 to use the new helpers
In-Reply-To: <1469655430.5978.159.camel@kernel.crashing.org>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-12-git-send-email-mpe@ellerman.id.au>
 <1469655430.5978.159.camel@kernel.crashing.org>
Date: Thu, 28 Jul 2016 21:24:07 +1000
Message-ID: <87twfa6m5k.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Thu, 2016-07-28 at 00:18 +1000, Michael Ellerman wrote:
>>=20
>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h
>> b/arch/powerpc/include/asm/book3s/64/mmu.h
>> index 70c995870297..6deda6ecc4f7 100644
>> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
>> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
>> @@ -116,7 +116,7 @@ extern void hash__early_init_mmu_secondary(void);
>> =C2=A0extern void radix__early_init_mmu_secondary(void);
>> =C2=A0static inline void early_init_mmu_secondary(void)
>> =C2=A0{
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (radix_enabled())
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (__radix_enabled())
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return radix__early_init_mmu_secondary();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return hash__early_init_=
mmu_secondary();
>> =C2=A0}
>
> This one can go, no ?

Yep.

cheers
