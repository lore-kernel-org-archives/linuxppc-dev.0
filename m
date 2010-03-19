Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1B36B7C67
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Mar 2010 16:50:54 +1100 (EST)
Subject: Re: [PATCH] PPC: Skip over OF_DT_NOP when unflattening the device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
In-Reply-To: <20100309193021.GD30462@obsidianresearch.com>
References: <20100309193021.GD30462@obsidianresearch.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 19 Mar 2010 16:50:38 +1100
Message-ID: <1268977838.8599.53.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-03-09 at 12:30 -0700, Jason Gunthorpe wrote:
> NOPs within the property section are skipped, but NOPs between
> OF_DT_END_NODE and OF_DT_BEGIN_NODE were not. My firmware NOPs out
> entire nodes depending on various environment parameters.
> 
> of_scan_flat_dt already handles NOP more generally..

Good catch, though that code has now moved over to drivers/of
and is a bit different. Grant is going to fix it up though.

Cheers,
Ben.

> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  arch/powerpc/kernel/prom.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 4ec3008..92137b2 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -408,8 +408,11 @@ static unsigned long __init unflatten_dt_node(unsigned long mem,
>  		if (!np->type)
>  			np->type = "<NULL>";
>  	}
> -	while (tag == OF_DT_BEGIN_NODE) {
> -		mem = unflatten_dt_node(mem, p, np, allnextpp, fpsize);
> +	while (tag == OF_DT_BEGIN_NODE || tag == OF_DT_NOP) {
> +		if (tag == OF_DT_NOP)
> +			*p += 4;
> +		else
> +			mem = unflatten_dt_node(mem, p, np, allnextpp, fpsize);
>  		tag = *((u32 *)(*p));
>  	}
>  	if (tag != OF_DT_END_NODE) {
