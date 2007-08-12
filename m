Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts13-srv.bellnexxia.net (tomts13.bellnexxia.net
	[209.226.175.34]) by ozlabs.org (Postfix) with ESMTP id 98208DDEDD
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Aug 2007 23:35:56 +1000 (EST)
Received: from krystal.dyndns.org ([76.65.103.147])
	by tomts13-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070812133554.JZHY13659.tomts13-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Aug 2007 09:35:54 -0400
Date: Sun, 12 Aug 2007 09:35:52 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.23-rc2-mm2 build error on MIPS and ARM
Message-ID: <20070812133552.GA21643@Krystal>
References: <20070811025802.GA15885@Krystal>
	<1186825800.32314.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1186825800.32314.2.camel@localhost>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Martin Schwidefsky (schwidefsky@de.ibm.com) wrote:
> On Fri, 2007-08-10 at 22:58 -0400, Mathieu Desnoyers wrote:
> > I got the following errors when building 2.6.23-rc2-mm2 on both mips and
> > arm. Both errors are very much alike.
> 
> That attached patch should fix it for arm and mips. I'll try a few more
> architectures until I'm fed up with compiling cross-compilers..
> 

It fixes the problem for me, thanks!

Tested-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

Mathieu


> -- 
> blue skies,
>   Martin.
> 
> "Reality continues to ruin my life." - Calvin.
> ---
> Subject: [PATCH] move mm_struct and vm_area_struct, compile fix.
> 
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Include <asm/page.h> in <linux/mm_types.h> to make mips and arm
> compile again after mm_struct and vm_area_struct have been moved.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
> 
>  include/linux/mm_types.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -urpN linux-2.6/include/linux/mm_types.h
> linux-2.6-patched/include/linux/mm_types.h
> --- linux-2.6/include/linux/mm_types.h	2007-08-11 11:30:10.000000000
> +0200
> +++ linux-2.6-patched/include/linux/mm_types.h	2007-08-11
> 11:32:42.000000000 +0200
> @@ -11,6 +11,7 @@
>  #include <linux/rwsem.h>
>  #include <linux/completion.h>
>  #include <asm/mmu.h>
> +#include <asm/page.h>
>  
>  struct address_space;
>  
> 
> 

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
