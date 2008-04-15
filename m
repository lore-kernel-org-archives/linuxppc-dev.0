Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49177DE3ED
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 09:01:43 +1000 (EST)
Message-Id: <320C966D-3E0E-470C-8598-CFB657B75E92@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <20080415224628.GA21663@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] 86xx: mark functions static, other minor cleanups
Date: Tue, 15 Apr 2008 18:01:26 -0500
References: <1207933186-20555-1-git-send-email-paul.gortmaker@windriver.com>
	<4804D39C.9000309@freescale.com> <4804D7C4.8060805@windriver.com>
	<4804D867.4070205@freescale.com>
	<20080415224628.GA21663@windriver.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> -void
> +static void
> mpc86xx_hpcn_show_cpuinfo(struct seq_file *m)
> {
> 	struct device_node *root;
> @@ -190,13 +190,19 @@ static int __init mpc86xx_hpcn_probe(void)
> {
> 	unsigned long root = of_get_flat_dt_root();
>
> -	if (of_flat_dt_is_compatible(root, "mpc86xx"))
> +	/* Delete this in 2.6.27 */
> +	if (of_flat_dt_is_compatible(root, "mpc86xx")) {
> +		pr_warning("WARNING: your dts/dtb is old. You must update before  
> the next kernel release\n");
> +		return 1;
> +	}
> +
> +	if (of_flat_dt_is_compatible(root, "fsl,mpc8641hpcn"))
> 		return 1;	/* Looks good */
>

how about reversing the order of the checks.

- k


> 	return 0;
> }
