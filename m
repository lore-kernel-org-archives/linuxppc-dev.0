Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17384.31565.896220.384684@cargo.ozlabs.ibm.com>
Date: Tue, 7 Feb 2006 21:49:49 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] missing refcounting of of_find_node_by_name users
In-Reply-To: <20060204122013.GA20324@suse.de>
References: <20060118151840.GA24381@suse.de> <20060204115541.GB19392@suse.de>
	<20060204122013.GA20324@suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> drop the refcount of the node returned from of_find_node_by_name
[snip]

> --- linux-2.6.16-rc2-olh.orig/arch/powerpc/platforms/powermac/feature.c
> +++ linux-2.6.16-rc2-olh/arch/powerpc/platforms/powermac/feature.c
> @@ -2772,6 +2772,7 @@ set_initial_features(void)
>  				g5_gmac_enable(np, 0, 1);
>  			np = of_find_node_by_name(np, "ethernet");
>  		}
> +		of_node_put(np);

This one isn't necessary, since np is NULL by the time we get out of
the loop.  Same applies to the other places in this file that this
patch affects.

> Index: linux-2.6.16-rc2-olh/arch/powerpc/platforms/powermac/pci.c
> ===================================================================
> --- linux-2.6.16-rc2-olh.orig/arch/powerpc/platforms/powermac/pci.c
> +++ linux-2.6.16-rc2-olh/arch/powerpc/platforms/powermac/pci.c
> @@ -695,6 +695,7 @@ static void __init fixup_nec_usb2(void)
>  				nec->intrs[0].line);
>  		}
>  	}
> +	of_put_node(nec);

Once again, nec is NULL by the time we get here.  And of_put_node
doesn't exist. :(  Did you compile-test this?

Regards,
Paul.
