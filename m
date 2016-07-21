Return-Path: <keescook@google.com>
Received: from mail-wm0-x22a.google.com (mail-wm0-x22a.google.com
 [IPv6:2a00:1450:400c:c09::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwMrR1704zDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 04:34:31 +1000 (AEST)
Received: by mail-wm0-x22a.google.com with SMTP id o80so36063612wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 11:34:31 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <5790711f.2350420a.b4287.2cc0SMTPIN_ADDED_BROKEN@mx.google.com>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
 <1468619065-3222-3-git-send-email-keescook@chromium.org>
 <5790711f.2350420a.b4287.2cc0SMTPIN_ADDED_BROKEN@mx.google.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 21 Jul 2016 11:34:25 -0700
Message-ID: <CAGXu5jLCu1Vv0uugKZrsjSEsoABgXJSOJ8GkKmrHbvj9jkC2YA@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] mm: Hardened usercopy
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Balbir Singh <bsingharora@gmail.com>,
 Daniel Micay <danielmicay@gmail.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Rik van Riel <riel@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>,
 PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
 Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, "David S. Miller" <davem@davemloft.net>,
 "x86@kernel.org" <x86@kernel.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
 Borislav Petkov <bp@suse.de>, Mathias Krause <minipli@googlemail.com>,
 Jan Kara <jack@suse.cz>,
 Vitaly Wool <vitalywool@gmail.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Dmitry Vyukov <dvyukov@google.com>, Laura Abbott <labbott@fedoraproject.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-ia64@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 20, 2016 at 11:52 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> diff --git a/mm/usercopy.c b/mm/usercopy.c
>> new file mode 100644
>> index 000000000000..e4bf4e7ccdf6
>> --- /dev/null
>> +++ b/mm/usercopy.c
>> @@ -0,0 +1,234 @@
> ...
>> +
>> +/*
>> + * Checks if a given pointer and length is contained by the current
>> + * stack frame (if possible).
>> + *
>> + *   0: not at all on the stack
>> + *   1: fully within a valid stack frame
>> + *   2: fully on the stack (when can't do frame-checking)
>> + *   -1: error condition (invalid stack position or bad stack frame)
>> + */
>> +static noinline int check_stack_object(const void *obj, unsigned long len)
>> +{
>> +     const void * const stack = task_stack_page(current);
>> +     const void * const stackend = stack + THREAD_SIZE;
>
> That allows access to the entire stack, including the struct thread_info,
> is that what we want - it seems dangerous? Or did I miss a check
> somewhere else?

That seems like a nice improvement to make, yeah.

> We have end_of_stack() which computes the end of the stack taking
> thread_info into account (end being the opposite of your end above).

Amusingly, the object_is_on_stack() check in sched.h doesn't take
thread_info into account either. :P Regardless, I think using
end_of_stack() may not be best. To tighten the check, I think we could
add this after checking that the object is on the stack:

#ifdef CONFIG_STACK_GROWSUP
        stackend -= sizeof(struct thread_info);
#else
        stack += sizeof(struct thread_info);
#endif

e.g. then if the pointer was in the thread_info, the second test would
fail, triggering the protection.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
