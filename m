Return-Path: <cyrilbur@gmail.com>
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com
 [IPv6:2607:f8b0:400e:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EB331A0E00
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 16:37:43 +1100 (AEDT)
Received: by mail-pd0-f182.google.com with SMTP id z10so14905866pdj.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 21:37:42 -0800 (PST)
Message-ID: <1421905054.2865.8.camel@cyril>
Subject: Re: [PATCH] powerpc/pseries: fix endian problems with LE migration
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 22 Jan 2015 16:37:34 +1100
In-Reply-To: <1421811226.4900.3.camel@ellerman.id.au>
References: <1421807520-12030-1-git-send-email-cyrilbur@gmail.com>
 <1421811226.4900.3.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-21 at 14:33 +1100, Michael Ellerman wrote:
> On Wed, 2015-01-21 at 13:32 +1100, Cyril Bur wrote:
> > The need to handle ibm,suspend_me specially from within ppc_rtas has left an
> > endian bug exposed as rtas_ibm_suspend_me actually performs HCALLs and should
> > have its params in CPU endian.
> 
> That needs a much better explanation.
> 
Agreed

> Key points:
>  - ppc_rtas() is a syscall, which takes arguments in BE
>  - ibm,suspend-me is not a real RTAS call and is handled specially in there
>  - ibm,suspend-me is actually implemented by an hcall
>  - there is currently a bug on LE, because rtas_ibm_suspend_me() takes the
>    ppc_rtas() args and feeds them directly to the hcall
> 
I've tried to write that out neatly and orderly. Here's how that went:


RTAS events require arguments be passed in big endian while hypercalls
have their arguments passed in registers and the values should therefore
be in CPU endian.

The ibm,suspend_me 'RTAS' call makes a sequence of hypercalls to setup
one true RTAS call. This means that ibm,suspend_me is handled specially
in the ppc_rtas syscall.

The ppc_rtas syscall has its arguments in big endian and can therefore
pass these arguments directly to the rtas call. ibm,suspend_me is
handled specially from within ppc_rtas (by calling rtas_ibm_suspend_me)
which has left an endian bug on little endian systems due to the
requirement of hypercalls. The return value from rtas_ibm_suspend me
gets returned in cpu endian, and is left unconverted, also a bug on
little endian systems.

rtas_ibm_suspend_me does not actually make use of the rtas_args that it
is passed. This patch removes the convoluted use of the rtas_args struct
to pass params to rtas_ibm_suspend_me in favour of passing what it needs
as actual arguments. This patch also ensures the two callers of
rtas_ibm_suspend_me pass function parameters in cpu endian and in the
case of ppc_rtas, converts the return value.

migrate_store (the other caller of rtas_ibm_suspend_me) is from a sysfs
file which deals with everything in cpu endian so this function only
underwent cleanup.

> > Have ppc_rtas send the params correctly and also interpret the result
> > correctly.
> 
> That's a second bug which you should also mention above.
> 
> > Removed the convoluted use of the rtas_args struct to pass params to
> > rtas_ibm_suspend_me in favour of passing what it needs directly.
> > 
> > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > ---
> > This patch has been tested with KVM both LE and BE and on PowerVM both LE and
> > BE. Under QEMU/KVM the migration happens without touching the these code
> > pathes.
> > For PowerVM there is no obvious regression on BE and the LE code path now
> > provides the correct parameters to the hypervisor
> 
> Fold that into the changelog, it's worth remembering.
> 
> cheers
> 
> 
