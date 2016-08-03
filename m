Return-Path: <keescook@google.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4MnD6Z8hzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 04:59:28 +1000 (AEST)
Received: from mail-wm0-x231.google.com (mail-wm0-x231.google.com
 [IPv6:2a00:1450:400c:c09::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s4MnD0HJSz9sxR
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 04:59:28 +1000 (AEST)
Received: by mail-wm0-x231.google.com with SMTP id q128so66569296wma.1
 for <linuxppc-dev@ozlabs.org>; Wed, 03 Aug 2016 11:59:27 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1470200371-31565-1-git-send-email-mpe@ellerman.id.au>
References: <1470200371-31565-1-git-send-email-mpe@ellerman.id.au>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 3 Aug 2016 11:59:24 -0700
Message-ID: <CAGXu5jJj8AJp0N23KLFQe9vX1qW0-4jkVqEwkKhGj9Q48T4Wtg@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: Mark lkdtm_rodata_do_nothing() notrace
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
 Anton Blanchard <anton@samba.org>,
 Alan Modra <amodra@gmail.com>, Nick Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 2, 2016 at 9:59 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> lkdtm_rodata_do_nothing() is an empty function which is generated in
> order to test the non-executability of rodata.
>
> Currently if function tracing is enabled then an mcount callsite will be
> generated for lkdtm_rodata_do_nothing(), and it will appear in the list
> of available functions for function tracing (available_filter_functions).
>
> Given it's purpose purely as a test function, it seems preferable for
> lkdtm_rodata_do_nothing() to be marked notrace, so it doesn't appear as
> traceable.
>
> This also avoids triggering a linker bug on powerpc:
>
>   https://sourceware.org/bugzilla/show_bug.cgi?id=20428
>
> When the linker sees code that needs to generate a call stub, eg. a
> branch to mcount(), it assumes the section is executable and
> dereferences a NULL pointer leading to a linker segfault. Marking
> lkdtm_rodata_do_nothing() notrace avoids triggering the bug because the
> function contains no other function calls.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Awesome! Thanks for tracking this down. I've applied it to my tree, it
should get picked up by Greg on my next pull request.

-Kees

> ---
>  drivers/misc/lkdtm_rodata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/lkdtm_rodata.c b/drivers/misc/lkdtm_rodata.c
> index 166b1db3969f..3564477b8c2d 100644
> --- a/drivers/misc/lkdtm_rodata.c
> +++ b/drivers/misc/lkdtm_rodata.c
> @@ -4,7 +4,7 @@
>   */
>  #include "lkdtm.h"
>
> -void lkdtm_rodata_do_nothing(void)
> +void notrace lkdtm_rodata_do_nothing(void)
>  {
>         /* Does nothing. We just want an architecture agnostic "return". */
>  }
> --
> 2.7.4
>



-- 
Kees Cook
Brillo & Chrome OS Security
