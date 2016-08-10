Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8JJg4tBZzDqQb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 14:36:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denys Vlasenko <dvlasenk@redhat.com>, linuxppc-dev@lists.ozlabs.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Kees Cook <keescook@chromium.org>,
 Oleg Nesterov <oleg@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc: Do not make the entire heap executable
In-Reply-To: <20160809190822.28856-1-dvlasenk@redhat.com>
References: <20160809190822.28856-1-dvlasenk@redhat.com>
Date: Wed, 10 Aug 2016 14:36:51 +1000
Message-ID: <87lh05tf30.fsf@concordia.ellerman.id.au>
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

Denys Vlasenko <dvlasenk@redhat.com> writes:

> On 32-bit powerps the ELF PLT sections of binaries (built with --bss-plt,
> or with a toolchain which defaults to it) look like this:
...
>
>  arch/powerpc/include/asm/page.h    | 10 +---------
>  arch/powerpc/include/asm/page_32.h |  2 --
>  arch/powerpc/include/asm/page_64.h |  4 ----
>  fs/binfmt_elf.c                    | 34 ++++++++++++++++++++++++++--------
>  include/linux/mm.h                 |  1 +
>  mm/mmap.c                          | 20 +++++++++++++++-----
>  6 files changed, 43 insertions(+), 28 deletions(-)

What tree is this against?

I can't get it to apply to either Linus' tree or linux-next.

cheers

$ patch --dry-run -p1 < diff.diff
checking file arch/powerpc/include/asm/page.h
checking file arch/powerpc/include/asm/page_32.h
checking file arch/powerpc/include/asm/page_64.h
checking file fs/binfmt_elf.c
Hunk #3 FAILED at 613.
Hunk #4 FAILED at 633.
Hunk #5 succeeded at 681 (offset 2 lines).
Hunk #6 succeeded at 889 (offset 2 lines).
Hunk #7 succeeded at 984 (offset 2 lines).
Hunk #8 succeeded at 1003 (offset 2 lines).
2 out of 8 hunks FAILED
checking file include/linux/mm.h
checking file mm/mmap.c
Hunk #1 FAILED at 2653.
Hunk #2 succeeded at 2668 (offset 2 lines).
Hunk #3 succeeded at 2736 (offset 2 lines).
Hunk #4 succeeded at 2750 (offset 2 lines).
1 out of 4 hunks FAILED
