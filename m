Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 876591A00CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 09:50:10 +1000 (AEST)
Message-ID: <1430956210.9675.1.camel@neuling.org>
Subject: Re: [PATCH 2/6] powerpc: Add cpu name to dump stack arch description
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 07 May 2015 09:50:10 +1000
In-Reply-To: <1430824337-15339-2-git-send-email-mpe@ellerman.id.au>
References: <1430824337-15339-1-git-send-email-mpe@ellerman.id.au>
 <1430824337-15339-2-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: tj@kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-05-05 at 21:12 +1000, Michael Ellerman wrote:
> As soon as we know the name of the cpu we're on, add it to the dump
> stack arch description, which is printed in case of an oops.
>=20
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/cputable.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputabl=
e.c
> index 60262fdf35ba..cf5e0c9b80cb 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -15,6 +15,7 @@
>  #include <linux/threads.h>
>  #include <linux/init.h>
>  #include <linux/export.h>
> +#include <linux/printk.h>
> =20
>  #include <asm/oprofile_impl.h>
>  #include <asm/cputable.h>
> @@ -2174,6 +2175,8 @@ static struct cpu_spec * __init setup_cpu_spec(unsi=
gned long offset,
>  	}
>  #endif /* CONFIG_PPC64 || CONFIG_BOOKE */
> =20
> +	dump_stack_add_arch_desc(t->cpu_name);
> +

Can we make this the PVR instead if the name?  It gives us more fidelity
on what the hardware revision is.

Mikey

>  	return t;
>  }
> =20
