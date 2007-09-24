Return-Path: <mel@skynet.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33E2BDDE00
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 21:01:32 +1000 (EST)
Date: Mon, 24 Sep 2007 12:01:24 +0100
To: Satyam Sharma <satyam@infradead.org>
Subject: Re: 2.6.23-rc6-mm1: Build failure on ppc64 drivers/ata/pata_scc.c
Message-ID: <20070924110124.GB3968@skynet.ie>
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
	<20070920131315.GE24105@skynet.ie>
	<20070920150925.0caf3aef@the-village.bc.nu>
	<alpine.LFD.0.999.0709220816170.14412@enigma.security.iitk.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <alpine.LFD.0.999.0709220816170.14412@enigma.security.iitk.ac.in>
From: mel@skynet.ie (Mel Gorman)
Cc: jeff@garzik.org, linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kamalesh@linux.vnet.ibm.com, linux-ide@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (22/09/07 08:20), Satyam Sharma didst pronounce:
> Hi,
> 
> 
> On Thu, 20 Sep 2007, Alan Cox wrote:
> > 
> > On Thu, 20 Sep 2007 14:13:15 +0100
> > mel@skynet.ie (Mel Gorman) wrote:
> > 
> > > PPC64 building allmodconfig fails to compile drivers/ata/pata_scc.c . It
> > > doesn't show up on other arches because this driver is specific to the
> > > architecture.
> > > 
> > > drivers/ata/pata_scc.c: In function `scc_bmdma_status'
> > 
> > Its not been updated to match the libata core changes. Try something like
> > this. Whoever is maintaining it should also remove the prereset cable handling
> > code and use the proper cable detect method.
> 
> It appears you forgot to fix scc_std_softreset() and one of its callsites
> in scc_bdma_stop(). A complete patch is attempted below -- please review.
> 

I can confirm it builds without warnings or errors, so thanks. I'm not in
the position to review it for correctness.

> 
> [PATCH -mm] pata_scc: Keep up with libata core API changes
> 
> Little fixlets, that the build started erroring / warning about:
> 
> drivers/ata/pata_scc.c: In function 'scc_bmdma_status':
> drivers/ata/pata_scc.c:734: error: structure has no member named 'active_tag'
> drivers/ata/pata_scc.c: In function 'scc_pata_prereset':
> drivers/ata/pata_scc.c:866: warning: passing arg 1 of 'ata_std_prereset' from incompatible pointer type
> drivers/ata/pata_scc.c: In function 'scc_error_handler':
> drivers/ata/pata_scc.c:908: warning: passing arg 2 of 'ata_bmdma_drive_eh' from incompatible pointer type
> drivers/ata/pata_scc.c:908: warning: passing arg 3 of 'ata_bmdma_drive_eh' from incompatible pointer type
> drivers/ata/pata_scc.c:908: warning: passing arg 5 of 'ata_bmdma_drive_eh' from incompatible pointer type
> make[2]: *** [drivers/ata/pata_scc.o] Error 1
> 
> Signed-off-by: Satyam Sharma <satyam@infradead.org>
> Cc: Alan Cox <alan@redhat.com>
> Cc: Mel Gorman <mel@skynet.ie>
> 
> ---
> 
> Andrew, this includes (supercedes) the previous two ones from Mel / Alan.
> 
>  drivers/ata/pata_scc.c |   21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff -ruNp a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
> --- a/drivers/ata/pata_scc.c	2007-09-22 06:26:37.000000000 +0530
> +++ b/drivers/ata/pata_scc.c	2007-09-22 08:04:42.000000000 +0530
> @@ -594,16 +594,17 @@ static unsigned int scc_bus_softreset(st
>   *	Note: Original code is ata_std_softreset().
>   */
>  
> -static int scc_std_softreset (struct ata_port *ap, unsigned int *classes,
> -                              unsigned long deadline)
> +static int scc_std_softreset(struct ata_link *link, unsigned int *classes,
> +                             unsigned long deadline)
>  {
> +	struct ata_port *ap = link->ap;
>  	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
>  	unsigned int devmask = 0, err_mask;
>  	u8 err;
>  
>  	DPRINTK("ENTER\n");
>  
> -	if (ata_link_offline(&ap->link)) {
> +	if (ata_link_offline(link)) {
>  		classes[0] = ATA_DEV_NONE;
>  		goto out;
>  	}
> @@ -692,7 +693,7 @@ static void scc_bmdma_stop (struct ata_q
>  			printk(KERN_WARNING "%s: Internal Bus Error\n", DRV_NAME);
>  			out_be32(bmid_base + SCC_DMA_INTST, INTSTS_BMSINT);
>  			/* TBD: SW reset */
> -			scc_std_softreset(ap, &classes, deadline);
> +			scc_std_softreset(&ap->link, &classes, deadline);
>  			continue;
>  		}
>  
> @@ -731,7 +732,7 @@ static u8 scc_bmdma_status (struct ata_p
>  	void __iomem *mmio = ap->ioaddr.bmdma_addr;
>  	u8 host_stat = in_be32(mmio + SCC_DMA_STATUS);
>  	u32 int_status = in_be32(mmio + SCC_DMA_INTST);
> -	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
> +	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->link.active_tag);
>  	static int retry = 0;
>  
>  	/* return if IOS_SS is cleared */
> @@ -860,10 +861,10 @@ static void scc_bmdma_freeze (struct ata
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
> @@ -874,8 +875,10 @@ static int scc_pata_prereset(struct ata_
>   *	Note: Original code is ata_std_postreset().
>   */
>  
> -static void scc_std_postreset (struct ata_port *ap, unsigned int *classes)
> +static void scc_std_postreset(struct ata_link *link, unsigned int *classes)
>  {
> +	struct ata_port *ap = link->ap;
> +
>  	DPRINTK("ENTER\n");
>  
>  	/* is double-select really necessary? */
> 

-- 
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
