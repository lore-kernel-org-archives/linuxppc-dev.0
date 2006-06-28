Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 9F16767A3F
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 14:06:09 +1000 (EST)
Date: Tue, 27 Jun 2006 23:05:40 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Make lparcfg.c work when both iseries and pseries are
	selected
Message-ID: <20060628040539.GW16029@localdomain>
References: <20060628115728.17f1a04d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060628115728.17f1a04d.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
>  static ssize_t lparcfg_write(struct file *file, const char __user * buf,
>  			     size_t count, loff_t * off)
>  {
> +	ssize_t retval = -ENOMEM;
> +#ifdef CONFIG_PPC_PSERIES
>  	char *kbuf;
>  	char *tmp;
>  	u64 new_entitled, *new_entitled_ptr = &new_entitled;
> @@ -479,8 +476,6 @@ static ssize_t lparcfg_write(struct file
>  	unsigned long resource;
>  	u8 current_weight;
>  
> -	ssize_t retval = -ENOMEM;
> -
>  	kbuf = kmalloc(count, GFP_KERNEL);
>  	if (!kbuf)
>  		goto out;
> @@ -546,11 +541,10 @@ static ssize_t lparcfg_write(struct file
>  
>  out:
>  	kfree(kbuf);
> +#endif				/* CONFIG_PPC_PSERIES */
>  	return retval;
>  }

Erm... this is kind of gross, and will return -ENOMEM on iSeries when
it should really return -ENOSYS (I think).

Would it be over-engineering to have an lparcfg_ops struct, with
lparcfg_read and lparcfg_write methods (and the latter would be null
on iSeries)?  All the additional #ifdeffery doesn't really improve
the readability of this code IMO.
