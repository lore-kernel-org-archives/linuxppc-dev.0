Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2510167DDE
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 07:44:23 +1000 (EST)
Subject: Re: [POWERPC] Cleanup pegasos i8259 not in device tree workaround.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@gmail.com>
In-Reply-To: <116196732980-git-send-email-grant.likely@gmail.com>
References: <116196732980-git-send-email-grant.likely@gmail.com>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 07:44:10 +1000
Message-Id: <1161985450.25682.75.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-10-27 at 10:42 -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Only make assumptions about i8259 presence if ppc_md.get_irq is not set.
> Previous workaround only checked chrp_mpic value.
> 
> Nicolas, please verify that this patch fixes your mpc52xx pic problems.
> Ben, I got tired of how often this question was being raised, so I just
> wrote this patch; I've compiled, but cannot test it.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/platforms/chrp/setup.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
> index 49b8dab..a5466ed 100644
> --- a/arch/powerpc/platforms/chrp/setup.c
> +++ b/arch/powerpc/platforms/chrp/setup.c
> @@ -451,7 +451,7 @@ static void __init chrp_find_8259(void)
>  	 * we have a pegasos that claims to be chrp but doesn't have
>  	 * a proper interrupt tree
>  	 */
> -	if (pic == NULL && chrp_mpic != NULL) {
> +	if (pic == NULL && ppc_md.get_irq != NULL) {
>  		printk(KERN_ERR "i8259: Not found in device-tree"
>  		       " assuming no legacy interrupts\n");
>  		return;
