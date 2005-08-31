Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 04A9868135
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2005 11:01:30 +1000 (EST)
Date: Tue, 30 Aug 2005 17:59:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nicolas DET <nd@bplan-gmbh.de>
Message-Id: <20050830175934.4bca259f.akpm@osdl.org>
In-Reply-To: <20050830181119.E3A491C000B2@mwinf1203.wanadoo.fr>
References: <20050830181119.E3A491C000B2@mwinf1203.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, Garzik <jgarzik@pobox.com>,
	galak@freescale.com, Jeff
Subject: Re: Marvell MV6436xx ethernet driver patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nicolas DET <nd@bplan-gmbh.de> wrote:
>
> You can find enclosed a patch for the Marvell MV643xx ethernet driver.
> 
>  It's also there:
>  http://arrakin.homedns.org/~nicolas/mv643xx_eth.tar.gz (tarball)
>  http://arrakin.homedns.org/~nicolas/mv643xx_eth.diff.bz2 
> 
>  The diff is against the kernel 2.6.13 (kernel.org).
> 
>  The main changes (AFAIR):
>  * Workaround for the TCP/UDP hw checksum
>  * Use hardware for statistics
>  * Define and use SRAM (for pegasos II archp/ppc/chrp_pegasos_eth.c)
>  * Able to use max burst size from/to DDR (serious transfer boost)
>  * Option can be selected through the menu (drivers/net/Kconfig)
>  * ...
> 
>  some testing...
> 
>  By the way, I noticed that page_address() sometimes returns NULL when using
>  highmem (with a lot of mem).
> 
>  You are welcome to review this patch. Some parts (especially the TX bug
>  workaroud) will be appreciated IMO.

- Does strange things to drivers/net/Kconfig, like removing the SKGE entry(?)

- Generates rather a lot of rejects agains post-2.6.13 changes.  You'll
  need to rediff this against current Linus tree or, preferably, against
  the next -mm kernel, please.

- Please cc netdev@vger.kernel.org next time.
