Return-Path: <mel@skynet.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C96E9DDE23
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 01:14:41 +1000 (EST)
Date: Thu, 20 Sep 2007 16:14:35 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.23-rc6-mm1: Build failure on ppc64 drivers/ata/pata_scc.c
Message-ID: <20070920151435.GA5081@skynet.ie>
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
	<20070920131315.GE24105@skynet.ie>
	<20070920150925.0caf3aef@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20070920150925.0caf3aef@the-village.bc.nu>
From: mel@skynet.ie (Mel Gorman)
Cc: linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, jeff@garzik.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (20/09/07 15:09), Alan Cox didst pronounce:
> On Thu, 20 Sep 2007 14:13:15 +0100
> mel@skynet.ie (Mel Gorman) wrote:
> 
> > PPC64 building allmodconfig fails to compile drivers/ata/pata_scc.c . It
> > doesn't show up on other arches because this driver is specific to the
> > architecture.
> > 
> > drivers/ata/pata_scc.c: In function `scc_bmdma_status'
> 
> Its not been updated to match the libata core changes. Try something like
> this. Whoever is maintaining it should also remove the prereset cable handling
> code and use the proper cable detect method.
> 

I can confirm it builds with the following messages

  CC [M]  drivers/ata/pata_scc.o
drivers/ata/pata_scc.c: In function `scc_error_handler':
drivers/ata/pata_scc.c:909: warning: passing arg 3 of `ata_bmdma_drive_eh' from incompatible pointer type

As for the rest, I cannot comment.

Thanks Alan

> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc6-mm1/drivers/ata/pata_scc.c linux-2.6.23rc6-mm1/drivers/ata/pata_scc.c
> --- linux.vanilla-2.6.23rc6-mm1/drivers/ata/pata_scc.c	2007-09-18 15:32:51.000000000 +0100
> +++ linux-2.6.23rc6-mm1/drivers/ata/pata_scc.c	2007-09-20 14:23:32.879807760 +0100
> @@ -731,7 +731,7 @@
>  	void __iomem *mmio = ap->ioaddr.bmdma_addr;
>  	u8 host_stat = in_be32(mmio + SCC_DMA_STATUS);
>  	u32 int_status = in_be32(mmio + SCC_DMA_INTST);
> -	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
> +	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->link.active_tag);
>  	static int retry = 0;
>  
>  	/* return if IOS_SS is cleared */
> @@ -860,10 +860,10 @@
>   *	@deadline: deadline jiffies for the operation
>   */
>  
> -static int scc_pata_prereset(struct ata_port *ap, unsigned long deadline)
> +static int scc_pata_prereset(struct ata_link *link, unsigned long deadline)
>  {
> -	ap->cbl = ATA_CBL_PATA80;
> -	return ata_std_prereset(ap, deadline);
> +	link->ap->cbl = ATA_CBL_PATA80;
> +	return ata_std_prereset(link, deadline);
>  }
>  
>  /**
> @@ -874,8 +874,9 @@
>   *	Note: Original code is ata_std_postreset().
>   */
>  
> -static void scc_std_postreset (struct ata_port *ap, unsigned int *classes)
> +static void scc_std_postreset (struct ata_link *link, unsigned int *classes)
>  {
> +	struct ata_port *ap = link->ap;
>  	DPRINTK("ENTER\n");
>  
>  	/* is double-select really necessary? */
> 

-- 
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
