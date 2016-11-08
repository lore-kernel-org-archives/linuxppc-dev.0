Return-Path: <dsafonov@virtuozzo.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::71f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCq0Y75mGzDt2k
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 23:50:21 +1100 (AEDT)
Subject: Re: [PATCHv3 0/8] powerpc/mm: refactor vDSO mapping code
To: Michael Ellerman <mpe@ellerman.id.au>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <20161027170948.8279-1-dsafonov@virtuozzo.com>
 <CAJwJo6b16mt0N_xJeeQ0EikyPhoo-UvAx-FaXO9hGzwW=o+s5Q@mail.gmail.com>
 <87pom6lu6a.fsf@concordia.ellerman.id.au>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-mm@kvack.org>, open list
 <linux-kernel@vger.kernel.org>
From: Dmitry Safonov <dsafonov@virtuozzo.com>
Message-ID: <97bc21c0-d7b7-d771-3f2b-1d7a862a2eee@virtuozzo.com>
Date: Tue, 8 Nov 2016 15:47:22 +0300
MIME-Version: 1.0
In-Reply-To: <87pom6lu6a.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/08/2016 02:57 AM, Michael Ellerman wrote:
> Dmitry Safonov <0x7f454c46@gmail.com> writes:
>
>> 2016-10-27 20:09 GMT+03:00 Dmitry Safonov <dsafonov@virtuozzo.com>:
>>
>> ping?
>
> There's another series doing some similar changes:
>
> http://www.spinics.net/lists/linux-mm/msg115860.html

Well, that version makes arch_mremap hook more general with renaming
vdso pointer. While this series erases that hook totaly.
So, we've agreed that it would be better without this hook, but with
generic version of vdso_mremap special_mapping helper:
https://marc.info/?i=d1aa8bec-a53e-cd30-e66a-39bebb6a400a@codeaurora.org

> And I don't like all the macro games in 3/8, eg:
>
> +#ifndef BITS
> +#define BITS 32
> +#endif
> +
> +#undef Elf_Ehdr
> +#undef Elf_Sym
> +#undef Elf_Shdr
> +
> +#define _CONCAT3(a, b, c)	a ## b ## c
> +#define CONCAT3(a, b, c)	_CONCAT3(a, b, c)
> +#define Elf_Ehdr	CONCAT3(Elf,  BITS, _Ehdr)
> +#define Elf_Sym		CONCAT3(Elf,  BITS, _Sym)
> +#define Elf_Shdr	CONCAT3(Elf,  BITS, _Shdr)
> +#define VDSO_LBASE	CONCAT3(VDSO, BITS, _LBASE)
> +#define vdso_kbase	CONCAT3(vdso, BITS, _kbase)
> +#define vdso_pages	CONCAT3(vdso, BITS, _pages)
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt)	"vDSO" __stringify(BITS) ": " fmt
> +
> +#define lib_elfinfo CONCAT3(lib, BITS, _elfinfo)
> +
> +#define find_section CONCAT3(find_section, BITS,)
> +static void * __init find_section(Elf_Ehdr *ehdr, const char *secname,
> +		unsigned long *size)
>
>
> I'd rather we kept the duplication of code than the obfuscation those
> macros add.
>
> If we can come up with a way to share more of the code without having to
> do all those tricks then I'd be interested.

Well, ok, I thought it's quite common even outside of tracing:
e.g, fs/compat_binfmt_elf.c does quite the same trick.
But as you find it obscured - than ok, I will resend without that
common-vdso part.

>
> cheers
>


-- 
              Dmitry
