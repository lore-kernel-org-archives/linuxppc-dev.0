Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm9Tr2L7RzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 20:20:00 +1000 (AEST)
Date: Fri, 08 Jul 2016 20:19:58 +1000
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>, "kernel-hardening\@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>
Cc: Jan Kara <jack@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Linux-MM <linux-mm@kvack.org>,
 sparclinux <sparclinux@vger.kernel.org>, linux-ia64@vger.kernel.org,
 Christoph Lameter <cl@linux.com>, Andrea Arcangeli <aarcange@redhat.com>,
 linux-arch <linux-arch@vger.kernel.org>, "x86\@kernel.org" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, PaX Team <pageexec@freemail.hu>,
 Borislav Petkov <bp@suse.de>, lin <ux-arm-kernel@lists.infradead.org>,
 Mathias Krause <minipli@googlemail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Rik van Riel <riel@redhat.com>, David Rientjes <rientjes@google.com>,
 Tony Luck <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Dmitry Vyukov <dvyukov@google.com>,
 Laura Abbott <labbott@fedoraproject.org>,
 Brad Spengler <spender@grsecurity.net>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>,
 Casey Schauf
 ler <casey@schaufler-ca.com>, Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Subject: Re: [kernel-hardening] Re: [PATCH 9/9] mm: SLUB hardened usercopy
 support
In-Reply-To: <CAGXu5jJbmLD-zPzJodM0=imuj-=w_s8RGP=vwtGuhmXJjQjuSw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Message-Id: <577f7e55.4668420a.84f17.5cb9SMTPIN_ADDED_MISSING@mx.google.com>

Kees Cook <keescook@chromium.org> writes:
> On Thu, Jul 7, 2016 at 12:35 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> I gave this a quick spin on powerpc, it blew up immediately :)
>
> Wheee :) This series is rather easy to test: blows up REALLY quickly
> if it's wrong. ;)

Better than subtle race conditions which is the usual :)

>> diff --git a/mm/slub.c b/mm/slub.c
>> index 0c8ace04f075..66191ea4545a 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3630,6 +3630,9 @@ const char *__check_heap_object(const void *ptr, unsigned long n,
>>         /* Find object. */
>>         s = page->slab_cache;
>>
>> +       /* Subtract red zone if enabled */
>> +       ptr = restore_red_left(s, ptr);
>> +
>
> Ah, interesting. Just to make sure: you've built with
> CONFIG_SLUB_DEBUG and either CONFIG_SLUB_DEBUG_ON or booted with
> either slub_debug or slub_debug=z ?

Yeah built with CONFIG_SLUB_DEBUG_ON, and booted with and without slub_debug
options.

> Thanks for the slub fix!
>
> I wonder if this code should be using size_from_object() instead of s->size?

Hmm, not sure. Who's SLUB maintainer? :)

I was modelling it on the logic in check_valid_pointer(), which also does the
restore_red_left(), and then checks for % s->size:

static inline int check_valid_pointer(struct kmem_cache *s,
				struct page *page, void *object)
{
	void *base;

	if (!object)
		return 1;

	base = page_address(page);
	object = restore_red_left(s, object);
	if (object < base || object >= base + page->objects * s->size ||
		(object - base) % s->size) {
		return 0;
	}

	return 1;
}

cheers
