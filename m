Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E763E67C10
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 23:22:59 +1000 (EST)
Date: Tue, 17 Oct 2006 15:22:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
Message-ID: <20061017132243.GA6773@lst.de>
References: <4534BE9D.7030908@bplan-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4534BE9D.7030908@bplan-gmbh.de>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Sven Luther <sl@bplan-gmbh.de>,
	tilmann@bitterberg.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> --- a/arch/powerpc/kernel/rtas-proc.c	2006-10-14 05:34:03.000000000 +0200
> +++ b/arch/powerpc/kernel/rtas-proc.c	2006-10-16 10:46:16.000000000 +0200
> @@ -253,43 +253,70 @@ static void get_location_code(struct seq
>  static void check_location_string(struct seq_file *m, char *c);
>  static void check_location(struct seq_file *m, char *c);
>  
> +#ifdef CONFIG_PPC64
> +#define PROCRTAS_ROOT "ppc64"
> +#else
> +#define PROCRTAS_ROOT "ppc"

Please don't do any pathname changes.  Even if ppc64 isn't correct it's
what applications expect and what we should provide for a coherent user
interface.

> -	if (!machine_is(pseries))
> +	if ( ! ( machine_is(pseries) || machine_is(chrp) ) )
>  		return -ENODEV;

This should be the only change you need, and it should follow kernel
coding style, aka:

	if (!machine_is(pseries) && !machine_is(chrp))
		return -ENODEV;

>  	rtas_node = of_find_node_by_name(NULL, "rtas");
>  	if (rtas_node == NULL)
>  		return -ENODEV;

And given this check I wonder why we need the platform check at all.  It
should be safe to just remove it.
