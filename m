Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0090.hostedemail.com
 [216.40.44.90])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhGT815wBzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 20:50:35 +1000 (AEST)
Message-ID: <1460112618.1800.36.camel@perches.com>
Subject: Re: [PATCH] mtd: nand: pasemi: switch to pr_* functions
From: Joe Perches <joe@perches.com>
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, Boris Brezillon
 <boris.brezillon@free-electrons.com>
Cc: Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, Olof
 Johansson <olof@lixom.net>, David Woodhouse <dwmw2@infradead.org>, Brian
 Norris <computersforpeace@gmail.com>, "open list:LINUX FOR POWERPC PA SEMI
 PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Fri, 08 Apr 2016 03:50:18 -0700
In-Reply-To: <1460111589-18781-1-git-send-email-zajec5@gmail.com>
References: <1460111589-18781-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-04-08 at 12:33 +0200, Rafał Miłecki wrote:
> This patch also replaces %08llx with %08zx for printing resource start
> address. Old format was triggering:
> warning: format ‘%08llx’ expects type ‘long long unsigned int’, but argument 2 has type ‘resource_size_t’

trivia:

> diff --git a/drivers/mtd/nand/pasemi_nand.c b/drivers/mtd/nand/pasemi_nand.c
[]
> @@ -112,8 +112,7 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
>  	/* Allocate memory for MTD device structure and private data */
>  	chip = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
>  	if (!chip) {
> -		printk(KERN_WARNING
> -		       "Unable to allocate PASEMI NAND MTD device structure\n");
> +		pr_warn("Unable to allocate PASEMI NAND MTD device structure\n");

Maybe remove this unnecessary as there's an OOM stack dump.

>  		err = -ENOMEM;
>  		goto out;
>  	}
> @@ -163,13 +162,13 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
>  	}
>  
>  	if (mtd_device_register(pasemi_nand_mtd, NULL, 0)) {
> -		printk(KERN_ERR "pasemi_nand: Unable to register MTD device\n");
> +		pr_err("pasemi_nand: Unable to register MTD device\n");

Maybe remove the embedded "pasemi_nand: " and add
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
before the first #include?

>  		err = -ENODEV;
>  		goto out_lpc;
>  	}
>  
> -	printk(KERN_INFO "PA Semi NAND flash at %08llx, control at I/O %x\n",
> -	       res.start, lpcctl);
> +	pr_info("PA Semi NAND flash at %08zx, control at I/O %x\n", res.start,
> +		lpcctl);

Maybe use %pR, &res instead of res.start?

	pr_info("PA Semi NAND flash at %pR, control at I/O %x\n", &res, lpcctl);
