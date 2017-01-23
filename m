Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6QTK29gZzDqRN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 20:08:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] powerpc/kernel: Remove nested if statements in
 rtas_initialize()
In-Reply-To: <1485127546-18859-2-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1485127546-18859-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1485127546-18859-2-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Mon, 23 Jan 2017 20:08:20 +1100
Message-ID: <8760l6b0u3.fsf@concordia.ellerman.id.au>
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

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> This removes the unnecessary nested if statements in function
> rtas_initialize(), to simplify the code. No functional changes
> introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/rtas.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 112cc3b..9ba0f67 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -1145,31 +1145,30 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
>  void __init rtas_initialize(void)
>  {
>  	unsigned long rtas_region = RTAS_INSTANTIATE_MAX;
> +	const __be32 *basep, *entryp, *sizep;
>  
>  	/* Get RTAS dev node and fill up our "rtas" structure with infos
>  	 * about it.
>  	 */
>  	rtas.dev = of_find_node_by_name(NULL, "rtas");
> -	if (rtas.dev) {
> -		const __be32 *basep, *entryp, *sizep;
> -
> -		basep = of_get_property(rtas.dev, "linux,rtas-base", NULL);
> -		sizep = of_get_property(rtas.dev, "rtas-size", NULL);
> -		if (basep != NULL && sizep != NULL) {
			...
> -		} else

Previously we set rtas.dev to NULL if either basep or sizep was NULL.

> -			rtas.dev = NULL;
> -	}
>  	if (!rtas.dev)
>  		return;
>  
> +	basep = of_get_property(rtas.dev, "linux,rtas-base", NULL);
> +	sizep = of_get_property(rtas.dev, "rtas-size", NULL);
> +	if (basep == NULL && sizep == NULL) {

But now you set it to NULL only if BOTH basep and sizep are NULL.

Was that intentional? If so you need to mention it in the change log.

> +		rtas.dev = NULL;
> +		return;
> +	}

The proper negation of:

	if (basep != NULL && sizep != NULL) {
is:
	if (basep == NULL || sizep == NULL) {


cheers
