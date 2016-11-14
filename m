Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHVbL66PmzDvmc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:44:46 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH] powerpc: fpr save/restore function cleanups
In-Reply-To: <20161101161828.6075f836@roar.ozlabs.ibm.com>
References: <20161101042219.25587-1-npiggin@gmail.com>
 <20161101154112.1516b5cb@roar.ozlabs.ibm.com>
 <20161101161828.6075f836@roar.ozlabs.ibm.com>
Date: Mon, 14 Nov 2016 23:44:45 +1100
Message-ID: <878tsmi62q.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Tue, 1 Nov 2016 15:41:12 +1100
> Nicholas Piggin <npiggin@gmail.com> wrote:
>
>> On Tue,  1 Nov 2016 15:22:19 +1100
>> Nicholas Piggin <npiggin@gmail.com> wrote:
>> 
>> > The powerpc64 linker generates fpr save/restore functions on-demand,
>> > placing them in the .sfpr section. So remove the explicitly coded ones
>> > from the 64 build.
>> > 
>> > Have 32-bit put save/restore functions into .sfpr section rather than
>> > .text, to match 64-bit.
>> > 
>> > And explicitly have the linker script place the section rather than
>> > leaving it as orphan.
>> > 
>> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > ---
>> > 
>> > I tested this with 64-bit optimize-for-size build with modules,
>> > and that works okay.  
>> 
>> No I didn't, it's broken. I'll send an update shortly.
>
> Working (hopefully) patch this time. I also removed the 32-bit changes
> which aren't really necessary:
>
> The powerpc64 linker generates fpr save/restore functions on-demand,
> placing them in the .sfpr section. Module linking (because it's a
> "non-final" link) requires --save-restore-funcs for this.
>
> Remove the explicitly coded save/restore functions from the 64 build.
>
> And explicitly have the linker script place the section rather than
> leaving it as orphan.

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/Makefile             |   4 +
>  arch/powerpc/boot/Makefile        |   3 +-
>  arch/powerpc/boot/crtsavres.S     |   8 +-
>  arch/powerpc/kernel/vmlinux.lds.S |   6 +
>  arch/powerpc/lib/Makefile         |   5 +-
>  arch/powerpc/lib/crtsavres.S      | 238 +-------------------------------------
>  6 files changed, 22 insertions(+), 242 deletions(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index fe76cfe..8ea7c9e 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -179,7 +179,11 @@ else
>  CHECKFLAGS	+= -D__LITTLE_ENDIAN__
>  endif
>  
> +ifeq ($(CONFIG_PPC32),y)
>  KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
> +else
> +KBUILD_LDFLAGS_MODULE += --save-restore-funcs

As discussed offline, this option is reasonably new, added in 2014 and
appearing in binutils 2.25.

So it's too new to require, we can use it if it's there, but we still
need a fallback for when it's not.

cheers
