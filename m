Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS5661FwdzDsxq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 23:07:42 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 3so13028290pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 04:07:42 -0800 (PST)
Date: Mon, 28 Nov 2016 23:07:24 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>, Alan
 Modra <amodra@gmail.com>, Nick Clifton <nickc@redhat.com>
Subject: Re: [PATCH] powerpc/boot: request no dynamic linker for boot wrapper
Message-ID: <20161128230724.375227b4@roar.ozlabs.ibm.com>
In-Reply-To: <87shqbrhfo.fsf@concordia.ellerman.id.au>
References: <20161128014226.7656-1-npiggin@gmail.com>
 <87shqbrhfo.fsf@concordia.ellerman.id.au>
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

On Mon, 28 Nov 2016 22:07:39 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > The boot wrapper performs its own relocations and does not require
> > PT_INTERP segment.
> >
> > Without this option, binutils 2.28 and newer tries to create a program
> > header segment due to PT_INTERP, and the link fails because there is no
> > space for it.  
> 
> 2.28 is not released yet though is it?
> 
> So can we just declare versions with that behaviour broken?

No it's not released yet, but I don't know if it's due entirely to binutils
bug. Let's see what Nick thinks.

> 
> > diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> > index 404b3aa..cd941a8 100755
> > --- a/arch/powerpc/boot/wrapper
> > +++ b/arch/powerpc/boot/wrapper
> > @@ -181,6 +181,13 @@ case "$elfformat" in
> >      elf32-powerpc)	format=elf32ppc	;;
> >  esac
> >  
> > +# Do not include PT_INTERP segment when linking pie. Non-pie linking
> > +# just ignores this option.
> > +LD_VERSION=$(${CROSS}ld --version | $srctree/scripts/ld-version.sh)
> > +LD_NO_DL_MIN_VERSION=$(echo 2.26 | $srctree/scripts/ld-version.sh)
> > +if [ "$LD_VERSION" -ge "$LD_NO_DL_MIN_VERSION" ] ; then
> > +	nodl="--no-dynamic-linker"
> > +fi  
> 
> Some distros (RHEL at least?), ship the wrapper as a standalone script.
> So I don't think we can call things in $srctree. Or at least I don't
> know how that's supposed to work when it's shipped standalone.
> We're also basically reinventing ld-option, which is a PITA.

Okay I didn't realize that. It's already using mkuboot.sh, but only
for uboot targets... I don't know, I don't have any good ideas at the
moment.

Maybe go back to using the linker script if possible? (I hadn't been
able to quite get it right yesterday, and this option seemed cleaner,
but it might be possible)

Thanks,
Nick
