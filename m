Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 906BDDEA84
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 09:33:09 +1100 (EST)
Date: Fri, 26 Jan 2007 14:32:04 -0800
From: Greg KH <gregkh@suse.de>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [3/4] PMC-related cleanups
Message-ID: <20070126223204.GE11008@suse.de>
References: <20070125082002.GD10716@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070125082002.GD10716@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 25, 2007 at 02:20:02AM -0600, Olof Johansson wrote:
> Introduce _SYSDEV_ATTR(), to be used to just define the struct, and not a
> named variable with the attribute. Useful for arrays of sysdev_attributes.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> 
> Index: powerpc/include/linux/sysdev.h
> ===================================================================
> --- powerpc.orig/include/linux/sysdev.h
> +++ powerpc/include/linux/sysdev.h
> @@ -98,12 +98,15 @@ struct sysdev_attribute { 
>  };
>  
>  
> -#define SYSDEV_ATTR(_name,_mode,_show,_store) 		\
> -struct sysdev_attribute attr_##_name = { 			\
> +#define _SYSDEV_ATTR(_name,_mode,_show,_store)			\
> +{								\
>  	.attr = {.name = __stringify(_name), .mode = _mode },	\
>  	.show	= _show,					\
>  	.store	= _store,					\
> -};
> +}

Oops, you need to add '.owner' to that attribute structure.  In all
fairness, it's a bug, not caused by anything that you did.

If you add that, feel free to add my:
	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

to the patch and send it through Paul.

thanks,

greg k-h
