Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znTbk0pHzzF1TD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 09:31:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Yves-Alexis Perez <corsac@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 4.9 34/77] powerpc: fix build errors in stable tree
In-Reply-To: <1519306335.2388.18.camel@debian.org>
References: <20180221124432.172390020@linuxfoundation.org>
 <20180221124433.618725458@linuxfoundation.org>
 <87k1v5rg66.fsf@concordia.ellerman.id.au>
 <1519292030.2388.14.camel@debian.org>
 <874lm9qi4t.fsf@concordia.ellerman.id.au>
 <1519306335.2388.18.camel@debian.org>
Date: Fri, 23 Feb 2018 09:31:29 +1100
Message-ID: <87vaeopsfy.fsf@concordia.ellerman.id.au>
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

Yves-Alexis Perez <corsac@debian.org> writes:
> On Fri, 2018-02-23 at 00:16 +1100, Michael Ellerman wrote:
>> With the patches I just sent, for pseries and powernv, the mitigation
>> should be in place. On machines with updated firmware we'll use the
>> hardware-assisted L1 flush, otherwise we fallback to doing it in
>> software.
>
> So as of 4.9.82 meltdown is *not* addressed on those arches, but it should be
> ok in 4.9.83 or 4.9.84 depending on when the patches are merged?

As of 4.9.82 *most* of the patches to do the mitigation have been
merged.

One of them was missed, due to it not applying (because it was actually
a back port to 4.4 that was sent) that is:

  222f20f14062 ("powerpc/64s: Simple RFI macro conversions")


That patch adds calls to do the L1D cache flush when returning to
user/guest, so it is important that it's missing, the mitigation is not
fully effective without that patch.

However, 4.9.82 *does* have a backport of:

  b8e90cb7bc04 ("powerpc/64: Convert the syscall exit path to use RFI_TO_USER/KERNEL")

So the syscall path is protected, which means any attack which uses
syscalls is likely to fail.

Because the data the attack is trying to read has to be in the L1D, you
can't write an attack that remains in userspace 100% of the time, you
have to enter the kernel and have the kernel load the target data into
the L1D for you. With the syscall flush in place you can't use a syscall
for that, you have to trigger some other kernel entry/exit, eg. a page
fault.

TLDR is with the syscall flush in place it's much harder to write an
attack.

Greg has already released 4.9.83, so hopefully 4.9.84 will be fully
protected.

Note also that 4.9.82/83 have a bug in the SLB miss handler that can
lead to hangs in userspace, fixed by the first patch I sent.

cheers
