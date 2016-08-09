Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7xgl4HPszDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 00:37:07 +1000 (AEST)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s7xgl0bXBz9t1F
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 00:37:07 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id h186so988520pfg.2
 for <linuxppc-dev@ozlabs.org>; Tue, 09 Aug 2016 07:37:06 -0700 (PDT)
Date: Wed, 10 Aug 2016 00:36:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 <imunsie@au.ibm.com>
Subject: Re: [PATCH] powerpc/Makefile: Use cflags-y/aflags-y for setting
 endian options
Message-ID: <20160810003658.527c34e0@roar.ozlabs.ibm.com>
In-Reply-To: <1470746626-1989-1-git-send-email-mpe@ellerman.id.au>
References: <1470746626-1989-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  9 Aug 2016 22:43:46 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> When we introduced the little endian support, we added the endian flags
> to CC directly using override. I don't know the history of why we did
> that, I suspect no one does.
> 
> Although this mostly works, it has one bug, which is that CROSS32CC
> doesn't get -mbig-endian. That means when the compiler is little endian
> by default and the user is building big endian, vdso32 is incorrectly
> compiled as little endian and the kernel fails to build.
> 
> Instead we can add the endian flags to cflags-y/aflags-y, and then
> append those to KBUILD_CFLAGS/KBUILD_AFLAGS.
> 
> This has the advantage of being 1) less ugly, 2) the documented way of
> adding flags in the arch Makefile and 3) it fixes building vdso32 with a
> LE toolchain.

This seems okay to me.

> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/Makefile | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index ca254546cd05..1934707bf321 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -66,29 +66,28 @@ endif
>  UTS_MACHINE := $(OLDARCH)
>  
>  ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
> -override CC	+= -mlittle-endian
> -ifneq ($(cc-name),clang)
> -override CC	+= -mno-strict-align
> -endif
> -override AS	+= -mlittle-endian
>  override LD	+= -EL
> -override CROSS32CC += -mlittle-endian
>  override CROSS32AS += -mlittle-endian

Can't we get rid of CROSS32AS? If not, then should it get the
-mbig-endian override?

Thanks,
Nick
