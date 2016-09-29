Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slKHH2wvFzDskN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 02:08:11 +1000 (AEST)
Date: Thu, 29 Sep 2016 18:07:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Al Viro <viro@zeniv.linux.org.uk>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Denys Vlasenko <dvlasenk@redhat.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Florian Weimer <fweimer@redhat.com>, Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] powerpc: Do not make the entire heap executable
Message-ID: <20160929160702.GA30031@redhat.com>
References: <20160822185105.29600-1-dvlasenk@redhat.com>
 <87d1jo7qbw.fsf@concordia.ellerman.id.au>
 <CAGXu5jKzvF_vTdNQfcugcG6PqEeDjVxymYXFtsksLx6jN-Z4zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXu5jKzvF_vTdNQfcugcG6PqEeDjVxymYXFtsksLx6jN-Z4zg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/28, Kees Cook wrote:
>
> This is where the flags are actually built from what's coming in
> through the newly created exported function vm_brk_flags() below. The
> only flag we're acting on is VM_EXEC (passed in from set_brk() above).
> I think do_brk_flags() should mask the valid flags, or we'll regret it
> in the future. I'd like to see something like:
>
>     /* Until we need other flags, refuse anything except VM_EXEC. */
>     if ((flags & (~VM_EXEC)) != 0)
>         return -EINVAL;
>     flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;

I tried to suggest this too. In particular it would be simply wrong
to accept VM_LOCKED in flags.

Oleg.
