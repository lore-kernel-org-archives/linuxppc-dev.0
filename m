Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 085B41A064A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 14:33:47 +1100 (AEDT)
Message-ID: <1421811226.4900.3.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: fix endian problems with LE migration
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>
Date: Wed, 21 Jan 2015 14:33:46 +1100
In-Reply-To: <1421807520-12030-1-git-send-email-cyrilbur@gmail.com>
References: <1421807520-12030-1-git-send-email-cyrilbur@gmail.com>
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

On Wed, 2015-01-21 at 13:32 +1100, Cyril Bur wrote:
> The need to handle ibm,suspend_me specially from within ppc_rtas has left an
> endian bug exposed as rtas_ibm_suspend_me actually performs HCALLs and should
> have its params in CPU endian.

That needs a much better explanation.

Key points:
 - ppc_rtas() is a syscall, which takes arguments in BE
 - ibm,suspend-me is not a real RTAS call and is handled specially in there
 - ibm,suspend-me is actually implemented by an hcall
 - there is currently a bug on LE, because rtas_ibm_suspend_me() takes the
   ppc_rtas() args and feeds them directly to the hcall

> Have ppc_rtas send the params correctly and also interpret the result
> correctly.

That's a second bug which you should also mention above.

> Removed the convoluted use of the rtas_args struct to pass params to
> rtas_ibm_suspend_me in favour of passing what it needs directly.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
> This patch has been tested with KVM both LE and BE and on PowerVM both LE and
> BE. Under QEMU/KVM the migration happens without touching the these code
> pathes.
> For PowerVM there is no obvious regression on BE and the LE code path now
> provides the correct parameters to the hypervisor

Fold that into the changelog, it's worth remembering.

cheers
