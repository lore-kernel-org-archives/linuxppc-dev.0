Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27ADD1A0D14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 14:38:49 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6E1F61400DE
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2015 14:38:48 +1100 (AEDT)
Message-ID: <1424749119.12891.20.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Export __spin_yield
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>
Date: Tue, 24 Feb 2015 14:38:39 +1100
In-Reply-To: <54EBC165.3020708@linux.vnet.ibm.com>
References: <1424477465-9199-2-git-send-email-warrier@linux.vnet.ibm.com>
 <54EBC165.3020708@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-02-23 at 18:10 -0600, Suresh E. Warrier wrote:
> Export __spin_yield so that the arch_spin_unlock() function
> can be invoked from a module.

Make it EXPORT_SYMBOL_GPL. Also explain why a module might need it

> Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
> ---
>  arch/powerpc/lib/locks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
> index bb7cfec..d100de8 100644
> --- a/arch/powerpc/lib/locks.c
> +++ b/arch/powerpc/lib/locks.c
> @@ -41,6 +41,7 @@ void __spin_yield(arch_spinlock_t *lock)
>  	plpar_hcall_norets(H_CONFER,
>  		get_hard_smp_processor_id(holder_cpu), yield_count);
>  }
> +EXPORT_SYMBOL(__spin_yield);
> 
>  /*
>   * Waiting for a read lock or a write lock on a rwlock...
