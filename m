Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS3mv3ngnzDvWk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 22:07:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>, Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH] powerpc/boot: request no dynamic linker for boot wrapper
In-Reply-To: <20161128014226.7656-1-npiggin@gmail.com>
References: <20161128014226.7656-1-npiggin@gmail.com>
Date: Mon, 28 Nov 2016 22:07:39 +1100
Message-ID: <87shqbrhfo.fsf@concordia.ellerman.id.au>
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

> The boot wrapper performs its own relocations and does not require
> PT_INTERP segment.
>
> Without this option, binutils 2.28 and newer tries to create a program
> header segment due to PT_INTERP, and the link fails because there is no
> space for it.

2.28 is not released yet though is it?

So can we just declare versions with that behaviour broken?

> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 404b3aa..cd941a8 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -181,6 +181,13 @@ case "$elfformat" in
>      elf32-powerpc)	format=elf32ppc	;;
>  esac
>  
> +# Do not include PT_INTERP segment when linking pie. Non-pie linking
> +# just ignores this option.
> +LD_VERSION=$(${CROSS}ld --version | $srctree/scripts/ld-version.sh)
> +LD_NO_DL_MIN_VERSION=$(echo 2.26 | $srctree/scripts/ld-version.sh)
> +if [ "$LD_VERSION" -ge "$LD_NO_DL_MIN_VERSION" ] ; then
> +	nodl="--no-dynamic-linker"
> +fi

Some distros (RHEL at least?), ship the wrapper as a standalone script.
So I don't think we can call things in $srctree. Or at least I don't
know how that's supposed to work when it's shipped standalone.

We're also basically reinventing ld-option, which is a PITA.

cheers
