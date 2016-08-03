Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4B2V5RbmzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 21:40:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Fengguang Wu <fengguang.wu@intel.com>,
 Guenter Roeck <linux@roeck-us.net>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linker tables on powerpc - build issues
In-Reply-To: <CAB=NE6Xu2t7JYUfvZcPSpX_Yt2yN9ooWgzctZFMr3LZGG1hVzw@mail.gmail.com>
References: <CAB=NE6Xu2t7JYUfvZcPSpX_Yt2yN9ooWgzctZFMr3LZGG1hVzw@mail.gmail.com>
Date: Wed, 03 Aug 2016 21:40:17 +1000
Message-ID: <87popqullq.fsf@concordia.ellerman.id.au>
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

"Luis R. Rodriguez" <mcgrof@do-not-panic.com> writes:

> I've run into a few compilation issues with linker tables support [0]
> [1] on only a few architectures:
>
> blackfin - compiler issue it seems, I have a work around now in place
> arm  - some alignment issue - still need to iron this out
> powerpc - issue with including <asm/sections.h> on <asm/jump_labels.h>
>
> The issue with powerpc can be replicated easily with the patch below,
> and compilation fails even on a 'make defconfig' configuration, the
> issues are recurring include header ordering issues. I've given this
> some tries to fix but am still a bit bewildered how to best do this
> without affecting non-powerpc compilations.  The patch below
> replicates the changes in question, it does not include the linker
> table work at all, it just includes <asm/sections.h> instead of
> <asm/tables.h> to reduce and provide an example of the issues
> observed. The list of errors are also pretty endless... so was hoping
> some power folks might be able to take a glance if possible. If you
> have any ideas, please let me know.

What is the end goal?

You want to be able to include asm/sections.h in asm/jump_labels.h? So
that you can get some macros to wrap the pushsection etc, am I right?

The biggest problem I see is dereference_function_descriptor(), which
uses probe_kernel(), which pulls in uaccess.h.

But it doesn't really make sense for dereference_function_descriptor()
to be in sections.h AFAICS.

I'll see if I can unstitch it tomorrow.

cheers
