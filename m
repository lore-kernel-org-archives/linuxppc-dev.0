Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B3EC067B8F
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 03:26:16 +1000 (EST)
Date: Thu, 7 Sep 2006 10:19:16 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Josh Boyer <jdub@us.ibm.com>
Subject: Re: [PATCH] [v3] PPC 4xx: Enable XMON on PPC 4xx boards
Message-ID: <20060907171916.GB18929@gate.ebshome.net>
References: <1157639720.6098.49.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1157639720.6098.49.camel@zod.rchland.ibm.com>
Cc: paulus@samba.org, mporter@embeddedalley.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 07, 2006 at 09:35:20AM -0500, Josh Boyer wrote:

[snip]

> --- linux-2.6.orig/arch/ppc/xmon/start.c
> +++ linux-2.6/arch/ppc/xmon/start.c
> @@ -73,6 +73,27 @@ xmon_map_scc(void)
>  	TXRDY = 0x20;
>  	RXRDY = 1;
>  	DLAB = 0x80;
> +#elif defined(CONFIG_440EP)
> +	sccd = (volatile unsigned char *) ioremap(0xef600300, 8);
> +	sccc = sccd + 5;
> +	TXRDY = 0x20;
> +	RXRDY = 1;
> +	DLAB = 0x80;
> +#elif defined(CONFIG_440SP)
> +	sccd = (volatile unsigned char *) ioremap64(0x00000001f0000200ULL, 8);
> +	sccc = sccd + 5;
> +	TXRDY = 0x20;
> +	RXRDY = 1;
> +	DLAB = 0x80;
> +#elif defined(CONFIG_44x)
> +	/* This is the default for 44x platforms.  Any boards that have a
> +	   different UART address need to be put in cases before this or the
> +	   port will be mapped incorrectly */
> +	sccd = (volatile unsigned char *) ioremap64(0x0000000140000200ULL, 8);
> +	sccc = sccd + 5;
> +	TXRDY = 0x20;
> +	RXRDY = 1;
> +	DLAB = 0x80;

There is only one line which is different, why did you put all other 
under #ifdef?

Also, all these hardcoded addresses are already available as defines, 
why just not use them?

-- 
Eugene
