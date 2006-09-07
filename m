Return-Path: <mporter@embeddedalley.com>
Received: from matthew-porters-computer.local (cpe-088197.static.wadsnet.net
	[65.114.88.197]) by ozlabs.org (Postfix) with ESMTP id 1809167BD5
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 23:23:26 +1000 (EST)
Date: Thu, 7 Sep 2006 09:23:19 -0400
From: Matt Porter <mporter@embeddedalley.com>
To: Josh Boyer <jdub@us.ibm.com>
Subject: Re: [PATCH] [v2] PPC 4xx: Enable XMON on PPC 4xx boards
Message-ID: <20060907132319.GA476@matthew-porters-computer.local>
References: <1157632424.6098.32.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1157632424.6098.32.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 07, 2006 at 07:33:44AM -0500, Josh Boyer wrote:
> --- linux-2.6.orig/arch/ppc/xmon/start.c
> +++ linux-2.6/arch/ppc/xmon/start.c
> @@ -73,6 +73,12 @@ xmon_map_scc(void)
>  	TXRDY = 0x20;
>  	RXRDY = 1;
>  	DLAB = 0x80;
> +#elif ( defined(CONFIG_440) || defined(CONFIG_440GX) )
> +	sccd = (volatile unsigned char *) ioremap64(0x0000000140000200ULL, 8);
> +	sccc = sccd + 5;
> +	TXRDY = 0x20;
> +	RXRDY = 1;
> +	DLAB = 0x80;
>  #endif /* platform */

These can be represented with CONFIG_44x. Though it doesn't work for
440EP since it doesn't have the 36-bit memory map. It should be:

+#elif ( defined(CONFIG_44x) && !defined(CONFIG_440EP) )
+     sccd = (volatile unsigned char *) ioremap64(0x0000000140000200ULL, 8);
+     sccc = sccd + 5;
+     TXRDY = 0x20;
+     RXRDY = 1;
+     DLAB = 0x80;

Adding in another case would enable 440EP as well:

+#elif ( defined(CONFIG_440EP) )
+     sccd = (volatile unsigned char *) ioremap(0xef600300, 8);
+     sccc = sccd + 5;
+     TXRDY = 0x20;
+     RXRDY = 1;
+     DLAB = 0x80;

-Matt
