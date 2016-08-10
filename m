Return-Path: <dvlasenk@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8VFx06MRzDr3Y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 22:05:08 +1000 (AEST)
Subject: Re: [PATCH v3] powerpc: Do not make the entire heap executable
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20160809190822.28856-1-dvlasenk@redhat.com>
 <87lh05tf30.fsf@concordia.ellerman.id.au>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Kees Cook <keescook@chromium.org>,
 Oleg Nesterov <oleg@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <579d983b-6a6b-1a36-3ba6-ed8c6a756c5f@redhat.com>
Date: Wed, 10 Aug 2016 14:05:04 +0200
MIME-Version: 1.0
In-Reply-To: <87lh05tf30.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/10/2016 06:36 AM, Michael Ellerman wrote:
> Denys Vlasenko <dvlasenk@redhat.com> writes:
>
>> On 32-bit powerps the ELF PLT sections of binaries (built with --bss-plt,
>> or with a toolchain which defaults to it) look like this:
> ...
>>
>>  arch/powerpc/include/asm/page.h    | 10 +---------
>>  arch/powerpc/include/asm/page_32.h |  2 --
>>  arch/powerpc/include/asm/page_64.h |  4 ----
>>  fs/binfmt_elf.c                    | 34 ++++++++++++++++++++++++++--------
>>  include/linux/mm.h                 |  1 +
>>  mm/mmap.c                          | 20 +++++++++++++++-----
>>  6 files changed, 43 insertions(+), 28 deletions(-)
>
> What tree is this against?

Linus' tree from before August 2.
The "mm: refuse wrapped vm_brk requests" commit collided with my changes
I'll send patch v4 rebased to today's linus tree as soon as I finish testing it.
