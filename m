Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id D873F685A6
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Oct 2005 04:30:05 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 25 Oct 2005 11:30:04 -0700
To: Nicolas DET <nd@bplan-gmbh.de>, linuxppc-dev@ozlabs.org
Message-ID: <20051025183004.GB13982@xyzzy.farnsworth.org>
References: <1130225496.3946.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1130225496.3946.2.camel@localhost.localdomain>
Subject: Re: [PATCH 2.6.14-rc5 1/1] : mv643xx_eth_showsram: Added
	information message when using the SRAM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 25, 2005 at 07:31:35AM +0000, Nicolas DET wrote:
> Added information message when using the SRAM in mv643xx_eth_probe()
> 
> Signed-off-by: Nicolas DET <det.nicolas@free.fr>
> Signed-off-by: Sven Luther <sl@bplan-gmbh.de>
> 

> diff -Naur a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
> --- a/drivers/net/mv643xx_eth.c	2005-10-25 09:24:57.952386000 +0200
> +++ b/drivers/net/mv643xx_eth.c	2005-10-25 09:25:02.220386000 +0200
> @@ -1533,6 +1533,9 @@
>  	printk(KERN_NOTICE "%s: RX NAPI Enabled \n", dev->name);
>  #endif
>  
> +	if (mp->tx_sram_size > 0)
> +		printk(KERN_NOTICE "%s: Using SRAM\n", dev->name);
> +
>  	return 0;
>  
>  out:

Do you really think this is necessary?  I think this driver is already
too verbose and we should be remove messages, not add them. :)

-Dale
