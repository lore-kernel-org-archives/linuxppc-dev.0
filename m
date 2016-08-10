Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8XHR09xLzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 23:36:34 +1000 (AEST)
Date: Wed, 10 Aug 2016 15:36:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Kees Cook <keescook@chromium.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] powerpc: Do not make the entire heap executable
Message-ID: <20160810133621.GA30167@redhat.com>
References: <20160810130030.5268-1-dvlasenk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160810130030.5268-1-dvlasenk@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10, Denys Vlasenko wrote:
>
> Currently, to support 32-bit binaries with PLT in BSS kernel maps *entire
> brk area* with executable rights for all binaries, even --secure-plt ones.
>
> Stop doing that.

Can't really review this patch, but at least the change in mm/mmap.c looks
technically correct to me... One nit below, feel free to ignore.

> @@ -2668,7 +2668,7 @@ static int do_brk(unsigned long addr, unsigned long request)
>  	if (!len)
>  		return 0;
>
> -	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
> +	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;

OK. But note that we have

	mlock_future_check(mm->def_flags);

a few lines below and after this change this _looks_ wrong because
VM_LOCKED can come from the new "flags" argument passed to do_brk().
Nobody does this right now, still this looks wrong/confusing.

I'd suggest to add another change

	-	mlock_future_check(mm->def_flags);
	+	mlock_future_check(flags);

or add a sanity check at the start to deny VM_LOCKED and perhaps
something else...

The same for vm_brk_flags() which after your change does

	do_brk_flags(flags);
	populate = (mm->def_flags & VM_LOCKED);

again, this is just a nit, I do not think it will be ever called
with VM_LOCKED in "flags".

Oleg.
