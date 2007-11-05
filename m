Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 660F9DDDF8
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 16:36:19 +1100 (EST)
Subject: Re: [PATCH 3/6]] POWERPC: fix memset size error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Zefan <lizf@cn.fujitsu.com>
In-Reply-To: <472E7E44.6000807@cn.fujitsu.com>
References: <472E7E44.6000807@cn.fujitsu.com>
Content-Type: text/plain
Date: Mon, 05 Nov 2007 16:35:57 +1100
Message-Id: <1194240957.6511.44.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, LKML <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-11-05 at 10:21 +0800, Li Zefan wrote:
> The size passing to memset is wrong.
> 
> Signed-off-by Li Zefan <lizf@cn.fujitsu.com>

Good catch, looks like a remain of when path was an array on the stack.

Thanks !

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> 
> ---
>  arch/powerpc/kernel/prom_init.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 1db10f7..1add6ef 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1244,7 +1244,7 @@ static void __init prom_initialize_tce_table(void)
>  			local_alloc_bottom = base;
>  
>  		/* It seems OF doesn't null-terminate the path :-( */
> -		memset(path, 0, sizeof(path));
> +		memset(path, 0, PROM_SCRATCH_SIZE);
>  		/* Call OF to setup the TCE hardware */
>  		if (call_prom("package-to-path", 3, 1, node,
>  			      path, PROM_SCRATCH_SIZE-1) == PROM_ERROR) {
