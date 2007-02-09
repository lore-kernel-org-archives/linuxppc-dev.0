Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 64284DDECF
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 10:01:21 +1100 (EST)
Date: Fri, 9 Feb 2007 16:02:07 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 15/19] bootwrapper: Add initrd information to the device
	tree in ft_finalize().
Message-ID: <20070209230207.GA12035@mag.az.mvista.com>
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230140.GO3849@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070207230140.GO3849@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 07, 2007 at 05:01:40PM -0600, Scott Wood wrote:

Sorry for being so slow on this Scott.

<snip>

> diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
> index 04da38f..39fa010 100644
> --- a/arch/powerpc/boot/flatdevtree_misc.c
> +++ b/arch/powerpc/boot/flatdevtree_misc.c
> @@ -33,8 +33,20 @@ static int ft_setprop(const void *phandl
>  	return ft_set_prop(&cxt, phandle, propname, buf, buflen);
>  }
>  
> -static unsigned long ft_finalize(void)
> +unsigned long ft_finalize(void)

This is unnecessary.  There is already global access from
dt_ops.finalize.

>  {
> +	unsigned long initrd_end = initrd.addr + initrd.size;
> +	void *devp;
> +
> +	if (initrd.size && (devp = finddevice("/chosen"))) {
> +		setprop(devp, "linux,initrd-start", &initrd.addr,
> +		        sizeof(initrd.addr));
> +		setprop(devp, "linux,initrd-end", &initrd_end,
> +		        sizeof(initrd_end));
> +
> +		ft_add_rsvmap(&cxt, initrd.addr, initrd.size);
> +	}
> +

IMHO, this is a very unnatural place to put this code.
It really belongs in main.c.  That's where all the rest
of the code that accesses initrd.* is.

Mark
