Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz1lH24nvzDrFQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 12:09:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Laight <David.Laight@ACULAB.COM>,
 'Josh Poimboeuf' <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>
Cc: "linux-ia64\@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "kernel-hardening\@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux-MM <linux-mm@kvack.org>, sparclinux <sparclinux@vger.kernel.org>,
 Jan Kara <jack@suse.cz>, Christoph Lameter <cl@linux.com>,
 Andrea Arcangeli <aarcange@redhat.com>, "x86\@kernel.org" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Dmitry Vyukov <dvyukov@google.com>,
 David Rientjes <rientjes@google.com>, PaX Team <pageexec@freemail.hu>,
 Borislav Petkov <bp@suse.de>, Mathias Krause <minipli@googlemail.com>,
 linux-arch <linux-arch@vger.kernel.org>, Rik van Riel <riel@redhat.com>,
 Brad Spengler <spender@grsecurity.net>, Andy Lutomirski <luto@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-arm-kernel\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Laura Abbott <labbott@fedoraproject.org>, Tony Luck <tony.luck@intel.com>,
 Ard Biesh
 euvel <ard.biesheuvel@linaro.org>, LKML <linux-kernel@vger.kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Pekka Enberg <penberg@kernel.org>,
 Daniel Micay <danielmicay@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Subject: RE: [PATCH v3 02/11] mm: Hardened usercopy
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F502102@AcuExch.aculab.com>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
 <1468619065-3222-3-git-send-email-keescook@chromium.org>
 <5790711f.2350420a.b4287.2cc0SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAGXu5jLCu1Vv0uugKZrsjSEsoABgXJSOJ8GkKmrHbvj9jkC2YA@mail.gmail.com>
 <20160722174551.jddle6mf7zlq6xmb@treble>
 <063D6719AE5E284EB5DD2968C1650D6D5F502102@AcuExch.aculab.com>
Date: Tue, 26 Jul 2016 12:09:14 +1000
Message-ID: <87mvl5jgl1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Laight <David.Laight@ACULAB.COM> writes:

> From: Josh Poimboeuf
>> Sent: 22 July 2016 18:46
>> >
>> > e.g. then if the pointer was in the thread_info, the second test would
>> > fail, triggering the protection.
>> 
>> FWIW, this won't work right on x86 after Andy's
>> CONFIG_THREAD_INFO_IN_TASK patches get merged.
>
> What ends up in the 'thread_info' area?

It depends on the arch.

> If it contains the fp save area then programs like gdb may end up requesting
> copy_in/out directly from that area.

On the arches I've seen thread_info doesn't usually contain register save areas,
but if it did then it would be up to the arch helper to allow that copy to go
through.

However given thread_info generally contains lots of low level flags that would
be a good target for an attacker, the best way to cope with ptrace wanting to
copy to/from it would be to use a temporary, and prohibit copying directly
to/from thread_info - IMHO.

cheers
