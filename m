Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 2 Feb 2010 14:48:32 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Joel Schopp <jschopp@austin.ibm.com>
Subject: Re: [PATCHv2 2/2] Update ibm,client-architecture call field based
	on device tree
Message-ID: <20100202034832.GD12389@ozlabs.org>
References: <1263501508.4869.133.camel@jschopp-laptop>
	<1263501674.4869.142.camel@jschopp-laptop>
	<1265064662.5391.19.camel@jschopp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1265064662.5391.19.camel@jschopp-laptop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 01, 2010 at 04:51:02PM -0600, Joel Schopp wrote:

>  static void __init prom_send_capabilities(void)
>  {
>  	ihandle elfloader, root;
>  	prom_arg_t ret;
> +	u32 *cores;
>  
>  	root = call_prom("open", 1, 1, ADDR("/"));
>  	if (root != 0) {
> +		/*
> +		 * If you add to the struct, please be sure the 100 index
> +		 * didn't change.  The BUILD_BUG_ON is a reminder.
> +		 */
> +		cores = (u32 *) &ibm_architecture_vec[100];
> +		if(*cores != NR_CPUS)
> +			prom_printf("client-architecture structure corrupted\n");
> +		*cores = (NR_CPUS / prom_smt_way());
> +		prom_printf("setting client-architecture cores to %x\n", *cores);

I don't know if I'm painting a bike shed of if this is a real concern, but if
*cores isn't NR_CPUS shouldn't we do nothing rather then clobbering it?

Yours Tony
