Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2D9849M4zDqQt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 00:09:48 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id f4so14301623qte.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 05:09:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170116125356.GF3159@twins.programming.kicks-ass.net>
References: <20170116083600.47175073@kryten>
 <20170116090540.GE3159@twins.programming.kicks-ass.net>
 <20170116224229.17d1f6fc@kryten>
 <20170116125356.GF3159@twins.programming.kicks-ass.net>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date: Mon, 16 Jan 2017 16:09:45 +0300
Message-ID: <CAPAsAGwTxU7SjK2o7ohdZxeFF5j_7UF-TUyXmOzndE8Z177kzw@mail.gmail.com>
Subject: Re: llist code relies on undefined behaviour, upsets llvm/clang
To: Peter Zijlstra <peterz@infradead.org>
Cc: Anton Blanchard <anton@samba.org>, behanw@converseincode.com,
 kernel test robot <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2017-01-16 15:53 GMT+03:00 Peter Zijlstra <peterz@infradead.org>:
> On Mon, Jan 16, 2017 at 10:42:29PM +1100, Anton Blanchard wrote:
>> Hi Peter,
>>
>> > Last I checked I couldn't build a x86_64 kernel with llvm. So no, not
>> > something I've ever ran into.
>> >
>> > Also, I would argue that this is broken in llvm, the kernel very much
>> > relies on things like this all over the place. Sure, we're way outside
>> > of what the C language spec says, but who bloody cares ;-)
>>
>> True, but is there anything preventing gcc from implementing this
>> optimisation in the future? If we are relying on undefined behaviour we
>> should have a -fno-strict-* option to cover it.
>>
>> > If llvm wants to compile the kernel, it needs to learn the C dialect
>> > the kernel uses.
>>
>> LLVM has done that before (eg adding -fno-strict-overflow). I don't
>> think that option covers this case however.
>
> Our comment there states:
>
> # disable invalid "can't wrap" optimizations for signed / pointers
> KBUILD_CFLAGS   += $(call cc-option,-fno-strict-overflow)
>
> So this option should apply to pointer arithmetic, therefore I would
> expect -fno-strict-overflow to actually apply here, or am I missing
> something?

That case is null pointer check optimization.  '->member' has non-zero
offset in struct, so LLVM assumes that pos->member != NULL
and optimize away this check.
LLVM/clang currently doesn't have -fno-delete-null-pointer-checks
