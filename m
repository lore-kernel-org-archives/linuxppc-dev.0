Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE87C1A00C7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 15:28:16 +1100 (EST)
In-Reply-To: <20141009234215.GC30604@linux.vnet.ibm.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2] powerpc/numa: add ability to disable and debug topology
 updates
Message-Id: <20141010042816.A75841400EA@ozlabs.org>
Date: Fri, 10 Oct 2014 15:28:16 +1100 (EST)
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-09-10 at 23:42:15 UTC, Nishanth Aravamudan wrote:
> We have hit a few customer issues with the topology update code (VPHN
> and PRRN). It would be nice to be able to debug the notifications coming
> from the hypervisor in both cases to the LPAR, as well as to disable
> responding to the notifications at boot-time, to narrow down the source
> of the problems. Add a basic level of such functionality, similar to the
> numa= command-line parameter. We already have a toggle in
> /proc/powerpc/topology_updates that allows run-time enabling/disabling,
> so the updates can be started at run-time if desired. But the bugs we've
> run into have occured during boot or very shortly after coming to login,
> and have resulted in a broken NUMA topology.

Thanks Nish, a couple of minor nits.

> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index e28c21ba862d..ad240a41d3e4 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -45,6 +45,7 @@ static char *cmdline __initdata;
>  
>  static int numa_debug;
>  #define dbg(args...) if (numa_debug) { printk(KERN_INFO args); }
> +#define pr_fmt(fmt) "numa: " fmt

This needs to come before printk.h to take effect, typically it goes before all
headers.

> @@ -1160,6 +1161,22 @@ static int __init early_numa(char *p)
>  }
>  early_param("numa", early_numa);
>  
> +static int topology_updates_enabled = 1;

bool ?

> +static int __init early_topology_updates(char *p)
> +{
> +	if (!p)
> +		return 0;
> +
> +	if (strstr(p, "off")) {

You're better off using strcmp. Using strstr() is nice if you need to support
multiple values, but it's sloppy otherwise. This will match "offset",
"smirnoff" etc.

> @@ -1807,7 +1836,9 @@ static const struct file_operations topology_ops = {
>  
>  static int topology_update_init(void)
>  {
> -	start_topology_update();
> +	/* Do not poll for changes if disabled at boot */
> +	if (topology_updates_enabled)
> +		start_topology_update();

Newline please!

>  	if (!proc_create("powerpc/topology_updates", 0644, NULL, &topology_ops))
>  		return -ENOMEM;

cheers
