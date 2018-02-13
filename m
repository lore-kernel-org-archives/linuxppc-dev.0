Return-Path: <miquel.raynal@bootlin.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zgZJm5mLNzF0xC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 18:43:00 +1100 (AEDT)
Date: Tue, 13 Feb 2018 08:42:46 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris
 <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard
 Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 linux-mtd@lists.infradead.org, Joern Engel <joern@lazybastard.org>, Robert
 Jarzmik <robert.jarzmik@free.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Kyungmin Park <kyungmin.park@samsung.com>,
 Artem Bityutskiy <dedekind1@gmail.com>, Solarflare linux maintainers
 <linux-net-drivers@solarflare.com>, Edward Cree <ecree@solarflare.com>,
 Bert Kenward <bkenward@solarflare.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 5/5] mtd: Stop updating erase_info->state and calling
 mtd_erase_callback()
Message-ID: <20180213084246.4f626bec@xps13>
In-Reply-To: <20180212210311.23244-6-boris.brezillon@bootlin.com>
References: <20180212210311.23244-1-boris.brezillon@bootlin.com>
 <20180212210311.23244-6-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Boris,

Just a few comments about the form.

Otherwise:
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


> diff --git a/drivers/mtd/devices/lart.c b/drivers/mtd/devices/lart.c
> index 555b94406e0b..3d6c8ffd351f 100644
> --- a/drivers/mtd/devices/lart.c
> +++ b/drivers/mtd/devices/lart.c
> @@ -415,7 +415,6 @@ static int flash_erase (struct mtd_info *mtd,struct erase_info *instr)
>  	 {
>  		if (!erase_block (addr))
>  		  {
> -			 instr->state = MTD_ERASE_FAILED;
>  			 return (-EIO);
>  		  }

You can also safely remove these '{' '}'

>  
> @@ -425,9 +424,6 @@ static int flash_erase (struct mtd_info *mtd,struct erase_info *instr)
>  		if (addr == mtd->eraseregions[i].offset + (mtd->eraseregions[i].erasesize * mtd->eraseregions[i].numblocks)) i++;
>  	 }
>  
> -   instr->state = MTD_ERASE_DONE;
> -   mtd_erase_callback(instr);
> -
>     return (0);
>  }
>  
> diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
> index 5dc8bd042cc5..aaaeaae01e1d 100644
> --- a/drivers/mtd/devices/mtd_dataflash.c
> +++ b/drivers/mtd/devices/mtd_dataflash.c
> @@ -220,10 +220,6 @@ static int dataflash_erase(struct mtd_info *mtd, struct erase_info *instr)
>  	}
>  	mutex_unlock(&priv->lock);
>  
> -	/* Inform MTD subsystem that erase is complete */
> -	instr->state = MTD_ERASE_DONE;
> -	mtd_erase_callback(instr);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/mtd/devices/mtdram.c b/drivers/mtd/devices/mtdram.c
> index 0bf4aeaf0cb8..efef43c6684b 100644
> --- a/drivers/mtd/devices/mtdram.c
> +++ b/drivers/mtd/devices/mtdram.c
> @@ -60,8 +60,6 @@ static int ram_erase(struct mtd_info *mtd, struct erase_info *instr)
>  	if (check_offs_len(mtd, instr->addr, instr->len))
>  		return -EINVAL;
>  	memset((char *)mtd->priv + instr->addr, 0xff, instr->len);
> -	instr->state = MTD_ERASE_DONE;
> -	mtd_erase_callback(instr);

Space ?

>  	return 0;
>  }
>  
> diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
> index 7287696a21f9..a963c88d392d 100644
> --- a/drivers/mtd/devices/phram.c
> +++ b/drivers/mtd/devices/phram.c
> @@ -44,8 +44,6 @@ static int phram_erase(struct mtd_info *mtd, struct erase_info *instr)
>  	 * I don't feel at all ashamed. This kind of thing is possible anyway
>  	 * with flash, but unlikely.
>  	 */

Not sure this comment is still relevant? Maybe you could remove it
or at least change it? 

> -	instr->state = MTD_ERASE_DONE;
> -	mtd_erase_callback(instr);

Space ?

>  	return 0;
>  }
>  
> diff --git a/drivers/mtd/devices/pmc551.c b/drivers/mtd/devices/pmc551.c
> index cadea0620cd0..5d842cbca3de 100644
> --- a/drivers/mtd/devices/pmc551.c
> +++ b/drivers/mtd/devices/pmc551.c
> @@ -184,12 +184,10 @@ static int pmc551_erase(struct mtd_info *mtd, struct erase_info *instr)
>  	}
>  
>        out:
> -	instr->state = MTD_ERASE_DONE;
>  #ifdef CONFIG_MTD_PMC551_DEBUG
>  	printk(KERN_DEBUG "pmc551_erase() done\n");
>  #endif
>  
> -	mtd_erase_callback(instr);
>  	return 0;
>  }
>  
> diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
> index 26f9feaa5d17..5f383630c16f 100644
> --- a/drivers/mtd/devices/powernv_flash.c
> +++ b/drivers/mtd/devices/powernv_flash.c
> @@ -175,19 +175,12 @@ static int powernv_flash_erase(struct mtd_info *mtd, struct erase_info *erase)
>  {
>  	int rc;
>  
> -	erase->state = MTD_ERASING;
> -
>  	/* todo: register our own notifier to do a true async implementation */
>  	rc =  powernv_flash_async_op(mtd, FLASH_OP_ERASE, erase->addr,
>  			erase->len, NULL, NULL);

Are you sure this is still needed? Maybe this should go away in your
first patch?

> -
> -	if (rc) {
> +	if (rc)
>  		erase->fail_addr = erase->addr;
> -		erase->state = MTD_ERASE_FAILED;
> -	} else {
> -		erase->state = MTD_ERASE_DONE;
> -	}
> -	mtd_erase_callback(erase);
> +
>  	return rc;
>  }
>  
> diff --git a/drivers/mtd/devices/slram.c b/drivers/mtd/devices/slram.c
> index 0ec85f316d24..2f05e1801047 100644
> --- a/drivers/mtd/devices/slram.c
> +++ b/drivers/mtd/devices/slram.c
> @@ -88,8 +88,6 @@ static int slram_erase(struct mtd_info *mtd, struct erase_info *instr)
>  	 * I don't feel at all ashamed. This kind of thing is possible anyway
>  	 * with flash, but unlikely.
>  	 */

Same with this comment.

> -	instr->state = MTD_ERASE_DONE;
> -	mtd_erase_callback(instr);

Space ?

>  	return(0);
>  }
>  




-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
