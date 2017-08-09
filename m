Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRwG93dnwzDqvM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 12:29:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] powerpc/mm: Mark __init memory no-execute when
 STRICT_KERNEL_RWX=y
In-Reply-To: <2111e0d8-3b77-20a0-aab9-3572467eb0d4@c-s.fr>
References: <1500015083-23511-1-git-send-email-mpe@ellerman.id.au>
 <1500015083-23511-3-git-send-email-mpe@ellerman.id.au>
 <2111e0d8-3b77-20a0-aab9-3572467eb0d4@c-s.fr>
Date: Wed, 09 Aug 2017 12:29:52 +1000
Message-ID: <87d185o4m7.fsf@concordia.ellerman.id.au>
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

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 14/07/2017 =C3=A0 08:51, Michael Ellerman a =C3=A9crit :
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc=
/include/asm/book3s/64/pgtable.h
>> index c0737c86a362..3d562b210c65 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -1192,5 +1192,12 @@ static inline const int pud_pfn(pud_t pud)
>>   	BUILD_BUG();
>>   	return 0;
>>   }
>> +
>> +#ifdef CONFIG_STRICT_KERNEL_RWX
>> +void mark_initmem_nx(void);
>> +#else
>> +static inline void mark_initmem_nx(void) { }
>> +#endif
>> +
>
> Why do we want to limit that to CONFIG_STRICT_KERNEL_RWX ?
> Only the kernel text is marked X, even without CONFIG_STRICT_KERNEL_RWX=20
> (at least on PPC32), so I believe we should clear X on init text in any=20
> case, shouldn't we ?

You're right, but ..

On 64-bit when STRICT_KERNEL_RWX=3Dn we make no effort to ensure the
start/end of the init text is on a page boundary.

eg. on 64-bit hash we will typically use a 16M page to map the whole
kernel, text/data/init_text/etc.

So yes we *should* always mark it no-execute but in practice we can't
because it's not page aligned.

But if that's different on (some?) 32-bit then we could introduce a new
CONFIG symbol that is enabled in the right cases.

cheers
