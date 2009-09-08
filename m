Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DBB1EB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Sep 2009 07:31:23 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 41B62DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Sep 2009 07:31:22 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Fix SMP compile error and allow NULL for
	smp_ops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1252437668-28508-1-git-send-email-galak@kernel.crashing.org>
References: <1252437668-28508-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 09 Sep 2009 07:31:12 +1000
Message-Id: <1252445472.4950.96.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-09-08 at 14:21 -0500, Kumar Gala wrote:

>  
>  struct smp_ops_t smp_85xx_ops = {
> +	.message_pass = NULL,
> +	.probe = NULL,
>  	.kick_cpu = smp_85xx_kick_cpu,
> +	.setup_cpu = NULL,
>  };

Why explicitely setting those to NULL ?

Cheers,
Ben.

> -static int __init smp_dummy_probe(void)
> -{
> -	return NR_CPUS;
> -}
> -
>  void __init mpc85xx_smp_init(void)
>  {
>  	struct device_node *np;
>  
> -	smp_85xx_ops.message_pass = NULL;
> -
>  	np = of_find_node_by_type(NULL, "open-pic");
>  	if (np) {
>  		smp_85xx_ops.probe = smp_mpic_probe;
>  		smp_85xx_ops.setup_cpu = smp_85xx_setup_cpu;
>  		smp_85xx_ops.message_pass = smp_mpic_message_pass;
> -	} else {
> -		smp_85xx_ops.probe = smp_dummy_probe;
> -		smp_85xx_ops.setup_cpu = smp_85xx_basic_setup;
>  	}
>  
>  	if (cpu_has_feature(CPU_FTR_DBELL))
