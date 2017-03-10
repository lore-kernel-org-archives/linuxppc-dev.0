Return-Path: <dja@axtens.net>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfT253FVhzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 11:40:29 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 25so8398822pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Mar 2017 16:40:29 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: "Tobin C. Harding" <me@tobin.cc>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH] powerpc: fix sparse warning, include kernel header
In-Reply-To: <1488788731-2537-1-git-send-email-me@tobin.cc>
References: <1488788731-2537-1-git-send-email-me@tobin.cc>
Date: Fri, 10 Mar 2017 11:40:23 +1100
Message-ID: <87k27y3qx4.fsf@possimpible.ozlabs.ibm.com>
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

Hi Tobin,

I have built the kernel with the ppc6xx_defconfig with and without your
patch.

Using my smart-sparse-diff tool[1], I have confirmed the warning
disappears:

-/scratch/dja/linux/arch/powerpc/kernel/swsusp.c:17:6: warning: symbol 'save_processor_state' was not declared. Should it be static?
-/scratch/dja/linux/arch/powerpc/kernel/swsusp.c:31:6: warning: symbol 'restore_processor_state' was not declared. Should it be static?

As such, this patch is:

Reviewed-by: Daniel Axtens <dja@axtens.net>

Thanks for fixing this!

Regards,
Daniel

[1] https://github.com/daxtens/smart-sparse-diff

"Tobin C. Harding" <me@tobin.cc> writes:

> Spares emits two symbol not declared warnings. The two functions in
> question are declared already in a kernel header.
>
> Add include directive to include kernel header.
>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>
> github issue: #37 Fix sparse errors
>
>  arch/powerpc/kernel/swsusp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/kernel/swsusp.c b/arch/powerpc/kernel/swsusp.c
> index 6ae9bd5..0050b2d 100644
> --- a/arch/powerpc/kernel/swsusp.c
> +++ b/arch/powerpc/kernel/swsusp.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <linux/sched.h>
> +#include <linux/suspend.h>
>  #include <asm/current.h>
>  #include <asm/mmu_context.h>
>  #include <asm/switch_to.h>
> -- 
> 2.7.4
