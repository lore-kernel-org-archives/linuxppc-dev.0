Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 497402C04C7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 08:03:48 +1000 (EST)
Message-ID: <1378850610.4121.29.camel@pasglop>
Subject: Re: [PATCH] powerpc: Export cpu_to_chip_id() to fix build error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 11 Sep 2013 08:03:30 +1000
In-Reply-To: <1378777076-4699-1-git-send-email-linux@roeck-us.net>
References: <1378777076-4699-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-09 at 18:37 -0700, Guenter Roeck wrote:
> powerpc allmodconfig build fails with:
> 
> ERROR: ".cpu_to_chip_id" [drivers/block/mtip32xx/mtip32xx.ko] undefined!
> 
> The problem was introduced with commit 15863ff3b (powerpc: Make chip-id
> information available to userspace).

Thanks, I'll send that to Linus asap.

Ben.

> Export the missing symbol.
> 
> Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> Cc: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/powerpc/kernel/smp.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 442d8e2..8e59abc 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -611,6 +611,7 @@ int cpu_to_chip_id(int cpu)
>  	of_node_put(np);
>  	return of_get_ibm_chip_id(np);
>  }
> +EXPORT_SYMBOL(cpu_to_chip_id);
>  
>  /* Helper routines for cpu to core mapping */
>  int cpu_core_index_of_thread(int cpu)
