Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E6C8867B89
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2006 03:47:51 +1000 (EST)
Date: Wed, 11 Oct 2006 10:47:48 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: make MAL use the new DCR methods
Message-ID: <20061011174748.GA3368@gate.ebshome.net>
References: <1160545539.6177.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1160545539.6177.56.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 11, 2006 at 03:45:39PM +1000, Benjamin Herrenschmidt wrote:
> This is a test patch to validate the new DCR method code for the
> "native" case. It will ultimately be the first of a pile porting the
> EMAC driver to ARCH=powerpc and non-native DCRs.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Index: linux-cell/drivers/net/ibm_emac/ibm_emac_mal.h
> ===================================================================
> --- linux-cell.orig/drivers/net/ibm_emac/ibm_emac_mal.h	2006-10-11 13:01:59.000000000 +1000
> +++ linux-cell/drivers/net/ibm_emac/ibm_emac_mal.h	2006-10-11 14:35:28.000000000 +1000
> @@ -24,6 +24,7 @@
>  #include <linux/netdevice.h>
>  
>  #include <asm/io.h>
> +#include <asm/dcr.h>
>  
>  /*
>   * These MAL "versions" probably aren't the real versions IBM uses for these 
> @@ -191,6 +192,7 @@ struct mal_commac {
>  
>  struct ibm_ocp_mal {
>  	int			dcrbase;
> +	dcr_host_t		dcrhost;
>  
>  	struct list_head	poll_list;
>  	struct net_device	poll_dev;
> @@ -207,12 +209,12 @@ struct ibm_ocp_mal {
>  
>  static inline u32 get_mal_dcrn(struct ibm_ocp_mal *mal, int reg)
>  {
> -	return mfdcr(mal->dcrbase + reg);
> +	return dcr_read(mal->dcrhost, mal->dcrbase + reg);
>  }
>  
>  static inline void set_mal_dcrn(struct ibm_ocp_mal *mal, int reg, u32 val)
>  {
> -	mtdcr(mal->dcrbase + reg, val);
> +	dcr_write(mal->dcrhost, mal->dcrbase + reg, val);
>  }
>  
>  /* Register MAL devices */
> 
> 

Looks fine to me.

Acked-by: Eugene Surovegin <ebs@ebshome.net>
