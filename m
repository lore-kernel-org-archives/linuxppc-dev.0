Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8BA45DDDEB
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 02:09:19 +1100 (EST)
Date: Mon, 3 Dec 2007 09:08:44 -0600
From: Scott Wood <scottwood@freescale.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PPC BOOT] Find device-tree source file in default directory.
Message-ID: <20071203150843.GA4393@loki.buserror.net>
References: <1196650083.13978.113.camel@pmac.infradead.org>
	<1196650164.13978.115.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196650164.13978.115.camel@pmac.infradead.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 03, 2007 at 02:49:24AM +0000, David Woodhouse wrote:
> If a .dts file is given to the bootwrapper script without a full path
> name, look in a sensible place for it.
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -116,6 +118,9 @@ while [ "$#" -gt 0 ]; do
>  done
>  
>  if [ -n "$dts" ]; then
> +    if [ ! -r "$dts" -a -r "$object/dts/$dts" ]; then
> +	dts="$object/dts/$dts"
> +    fi
>      if [ -z "$dtb" ]; then
>  	dtb="$platform.dtb"
>      fi

Shouldn't this be $srctree (which doesn't seem to be passed to wrapper at
the moment), not $object?

BTW, if we do this, we should remove the part in arch/powerpc/boot/Makefile
where this is done.

-Scott
