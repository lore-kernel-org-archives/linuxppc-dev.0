Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyFr42mnVzDqMF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 13:11:13 +1100 (AEDT)
Date: Mon, 9 Jan 2017 18:11:07 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: Christophe LEROY <christophe.leroy@c-s.fr>
cc: Benjamin Herrenschmidt <benh@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
In-Reply-To: <alpine.DEB.2.20.99.1701040957380.31470@trent.utfs.org>
Message-ID: <alpine.DEB.2.20.999.1701091739320.5450@trent.utfs.org>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
 <alpine.DEB.2.20.99.1701040957380.31470@trent.utfs.org>
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

On Wed, 4 Jan 2017, Christian Kujau wrote:
> So, would the following be sufficient? It compiles, but I haven't had a 
> chance to boot yet.
> 

So, with -fno-stack-protector my GCC 4.9.2 compiles with 
CC_STACKPROTECTOR_STRONG=y but panics during boot:


Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: c069278c
CPU: 0 PIP: 591 Comm: systemd Tainted: G       W      4.10.0-rc3-dirty
Call Trace:
[ee965bb0] [c0693f5c] panic+0x120/0x274 (unreliable)
[ee965c10] [c002c568] print_tainted+0x0/0xcc
[ee965c20] [c069278c] schedule_timeout+0x25c/0x280
[ee965c80] [c068cc30] io_schedule_timeout+0x90/0xf4
[ee965ca0] [c00ac870] wait_on_page_bit_killable+0x1Oc/0x170
[ee965cf0] [c00ad240] __lock_page_or_retry+0xd4/0x12c
[ee965d10] [c00ad708] filemap_fault+0x470/0x5b0
[ee965d60] [c00d07c8] __do_fault+0x2c/0x90
[ee965e40] [c00d4104] handle_mm__fault+0x7c0/0x9cc
[ee965e00] [c0015a6c] do_page_fault+0x2ec,0x5b4
[ee965e40] [c0011660] handle_page_fault+0xc/0x80
--- interrupt: 301 at do_page_fault+0x394/0x5b4
    LR = do_page_fault+0x378,0x5b4
[ee965f00] [c0015c04] do_page_fault+0x484/0x5b4 (unreliable)
[ee965f40] [c0011660] handle_page_fault+0xc/0x80
--- interrupt: 401 at 0x2074d000
    LR = 0x207cff0


Maybe ppc32 is not supposed to be built with CC_STACKPROTECTOR ?

Thanks,
Christian.

> 
> diff --git a/arch/powerpc/platforms/powermac/Makefile b/arch/powerpc/platforms/powermac/Makefile
> index 1eb7b45..c7dcab9 100644
> --- a/arch/powerpc/platforms/powermac/Makefile
> +++ b/arch/powerpc/platforms/powermac/Makefile
> @@ -1,4 +1,4 @@
> -CFLAGS_bootx_init.o  		+= -fPIC
> +CFLAGS_bootx_init.o  		+= -fPIC -fno-stack-protector
>  
>  ifdef CONFIG_FUNCTION_TRACER
>  # Do not trace early boot code
> 
> 
> Thanks,
> Christian.
> -- 
> BOFH excuse #156:
> 
> Zombie processes haunting the computer
> 

-- 
BOFH excuse #450:

Terrorists crashed an airplane into the server room, have to remove /bin/laden. (rm -rf /bin/laden)
