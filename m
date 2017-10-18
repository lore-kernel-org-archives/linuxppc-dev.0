Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHBzs0bXyzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 00:02:33 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>,
 Stewart Smith  <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/xmon: check before calling xive functions
In-Reply-To: <1508264418-13448-1-git-send-email-leitao@debian.org>
References: <1508264418-13448-1-git-send-email-leitao@debian.org>
Date: Thu, 19 Oct 2017 00:02:31 +1100
Message-ID: <87vajchamw.fsf@concordia.ellerman.id.au>
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

Breno Leitao <leitao@debian.org> writes:

> Currently xmon could call XIVE functions from OPAL even if the XIVE is
> disabled or does not exist in the system, as in POWER8 machines.  This
> causes the following exception:
>
>  1:mon> dx
>  cpu 0x1: Vector: 700 (Program Check) at [c000000423c93450]
>      pc: c00000000009cfa4: opal_xive_dump+0x50/0x68
>      lr: c0000000000997b8: opal_return+0x0/0x50
>
> This patch simply checks if XIVE is enabled before calling XIVE
> functions.

Thanks. I'll merge this.

But we should also fix it in skiboot.

cheers

> Suggested-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/xmon/xmon.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 4679aeb84767..b34976c4a6ba 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -2508,6 +2508,12 @@ static void dump_xives(void)
>  	unsigned long num;
>  	int c;
>  
> +	if (!xive_enabled()) {
> +		printf("Xive disabled on this system\n");
> +
> +		return;
> +	}
> +
>  	c = inchar();
>  	if (c == 'a') {
>  		dump_all_xives();
> -- 
> 2.14.2
