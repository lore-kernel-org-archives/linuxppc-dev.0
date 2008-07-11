Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E0815DE005
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 04:14:29 +1000 (EST)
Date: Fri, 11 Jul 2008 22:14:28 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping,
	otherwise kernel will oops
Message-ID: <20080711181428.GA498@polina.dev.rtsoft.ru>
References: <20080711174859.GA24260@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080711174859.GA24260@polina.dev.rtsoft.ru>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 11, 2008 at 09:48:59PM +0400, Anton Vorontsov wrote:
> Firstly kernel warns at set_irq_chip, and then dies completely:
> 
> Trying to install chip for IRQ-1
> ------------[ cut here ]------------
> Badness at c00463b0 [verbose debug info unavailable]
[..]
> Unable to handle kernel paging request for data at address 0x3863ce7c

Btw, I'm seeing this on linux-next. Just looked into the current Linus'
tree, and it seems that the bug is there too. So, this is probably should
go for 2.6.26.

> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/of/of_i2c.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> index b2ccdcb..95a24de 100644
> --- a/drivers/of/of_i2c.c
> +++ b/drivers/of/of_i2c.c
> @@ -93,10 +93,8 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
>  		if (info.irq == NO_IRQ)
>  			info.irq = -1;
>  
> -		if (of_find_i2c_driver(node, &info) < 0) {
> -			irq_dispose_mapping(info.irq);
> -			continue;
> -		}
> +		if (of_find_i2c_driver(node, &info) < 0)
> +			goto err;
>  
>  		info.addr = *addr;
>  
> @@ -107,9 +105,12 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
>  			printk(KERN_ERR
>  			       "of-i2c: Failed to load driver for %s\n",
>  			       info.type);
> -			irq_dispose_mapping(info.irq);
> -			continue;
> +			goto err;
>  		}
> +		continue;
> +err:
> +		if (info.irq > 0)
> +			irq_dispose_mapping(info.irq);
>  	}
>  }
>  EXPORT_SYMBOL(of_register_i2c_devices);
> -- 
> 1.5.5.4

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
