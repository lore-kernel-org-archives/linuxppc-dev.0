Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0C03DEB9B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 02:11:26 +1000 (EST)
Message-ID: <4804D39C.9000309@freescale.com>
Date: Tue, 15 Apr 2008 11:11:08 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] 86xx: mark functions static, other minor cleanups
References: <1207933186-20555-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1207933186-20555-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Gortmaker wrote:

> -void
> +static void
>  mpc86xx_hpcn_show_cpuinfo(struct seq_file *m)
>  {
>  	struct device_node *root;
> @@ -190,13 +190,13 @@ static int __init mpc86xx_hpcn_probe(void)
>  {
>  	unsigned long root = of_get_flat_dt_root();
>  
> -	if (of_flat_dt_is_compatible(root, "mpc86xx"))
> +	if (of_flat_dt_is_compatible(root, "fsl,mpc86xx"))
>  		return 1;	/* Looks good */

This breaks compatibility with older device trees.  You still need to look for
"mpc86xx".

A lot of people have been doing this recently, and it needs to stop.  You need
to wait at least one whole kernel version before you can remove support for an
older device tree.

> -void
> +static void
>  sbc8641_show_cpuinfo(struct seq_file *m)
>  {
>  	struct device_node *root;
> @@ -118,13 +111,13 @@ static int __init sbc8641_probe(void)
>  {
>  	unsigned long root = of_get_flat_dt_root();
>  
> -	if (of_flat_dt_is_compatible(root, "mpc86xx"))
> +	if (of_flat_dt_is_compatible(root, "wrs,sbc8641"))
>  		return 1;	/* Looks good */

Same here.

-- 
Timur Tabi
Linux kernel developer at Freescale
