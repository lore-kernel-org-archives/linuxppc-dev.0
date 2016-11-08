Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCcm648FzzDt2g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 16:08:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hugh Dickins <hughd@google.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: 4.9-rc G5 build broken with a 2.23 binutils
In-Reply-To: <alpine.LSU.2.11.1611061953120.11253@eggly.anvils>
References: <alpine.LSU.2.11.1611061953120.11253@eggly.anvils>
Date: Tue, 08 Nov 2016 16:08:51 +1100
Message-ID: <87bmxqlfrw.fsf@concordia.ellerman.id.au>
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

Hugh Dickins <hughd@google.com> writes:

> Hi Nick,
>
> I've not been able to build 4.9-rc kernels for the PowerMac G5, getting
>
> arch/powerpc/kernel/exceptions-64s.S:
> Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:770: Error: operand out of range
> (0xffffffffffff8100 is not between 0x0000000000000000 and 0x000000000000ffff)
> and 20 more similar before
> arch/powerpc/kernel/exceptions-64s.S:1024: Error: operand out of range
> (0xffffffffffff9180 is not between 0x0000000000000000 and 0x000000000000ffff)
> make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
>
> That's with the binutils-2.23.2-8.1.4.ppc64 from openSUSE 13.1.
>
> But yesterday your comment on @l in
> a24553dd02dc ("powerpc/pseries: Remove unnecessary syscall trampoline")
> helped me to the patch below (removing @l from LOAD_HANDLER, but leaving
> @l in __LOAD_HANDLER), which gets the build working again (and produces
> a good kernel).  For me.  But to judge by your comment, this would break
> the build for someone else?  I don't mind keeping this as a local patch
> if I'm the only one affected, so haven't signed off on it; but thought
> I'd better inform you.

Thanks for the report Hugh.

We added the @l recently to keep binutils 2.22 happy, in commit a24553dd02dc:

https://git.kernel.org/torvalds/c/a24553dd02dc


We needed it because we were using LOAD_HANDLER() for systemcall_common,
which is in a separate .S. But since then we've split that out into a
separate macro, meaning we no longer need the @l in LOAD_HANDLER().

Why binutils 2.23 can't cope with the @l I'm not sure, and I don't
really care. Dropping the @l is more correct, ie. 

So I'll merge this as a fix, do you want to send me a SOB?

cheers
