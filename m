Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AB9CDDDE99
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 01:45:33 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8KFjYAW001232
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 01:45:34 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8KFn6qg219482
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 01:49:06 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8KGjFO7030264
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 02:45:15 +1000
Message-ID: <46F2957F.60707@linux.vnet.ibm.com>
Date: Thu, 20 Sep 2007 21:15:03 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.23-rc6-mm1: Build failure on ppc64 drivers/ata/pata_scc.c
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
	<20070920131315.GE24105@skynet.ie>
	<20070920150925.0caf3aef@the-village.bc.nu>
In-Reply-To: <20070920150925.0caf3aef@the-village.bc.nu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: jeff@garzik.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, Mel Gorman <mel@skynet.ie>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Cox wrote:
> On Thu, 20 Sep 2007 14:13:15 +0100
> mel@skynet.ie (Mel Gorman) wrote:
>
>   
>> PPC64 building allmodconfig fails to compile drivers/ata/pata_scc.c . It
>> doesn't show up on other arches because this driver is specific to the
>> architecture.
>>
>> drivers/ata/pata_scc.c: In function `scc_bmdma_status'
>>     
>
> Its not been updated to match the libata core changes. Try something like
> this. Whoever is maintaining it should also remove the prereset cable handling
> code and use the proper cable detect method.
>
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
>
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
> +	struct ata_port *ap = link->ap;
>  	DPRINTK("ENTER\n");
>
>  	/* is double-select really necessary? */
>
>   
Hi,

This patch solves the build failure, but with following warnings
CC drivers/ata/pata_scc.o
drivers/ata/pata_scc.c: In function ‘scc_error_handler’:
drivers/ata/pata_scc.c:909: warning: passing argument 3 of 
‘ata_bmdma_drive_eh’ from incompatible pointer type

and after that the build fails with

CC [M] drivers/net/spider_net.o
drivers/net/spider_net.c: In function ‘spider_net_release_tx_chain’:
drivers/net/spider_net.c:818: error: ‘dev’ undeclared (first use in this 
function)
drivers/net/spider_net.c:818: error: (Each undeclared identifier is 
reported only once
drivers/net/spider_net.c:818: error: for each function it appears in.)
drivers/net/spider_net.c: In function ‘spider_net_xmit’:
drivers/net/spider_net.c:922: error: ‘dev’ undeclared (first use in this 
function)
drivers/net/spider_net.c: In function ‘spider_net_pass_skb_up’:
drivers/net/spider_net.c:1018: error: ‘dev’ undeclared (first use in 
this function)
drivers/net/spider_net.c: In function ‘spider_net_decode_one_descr’:
drivers/net/spider_net.c:1215: error: ‘dev’ undeclared (first use in 
this function)
make[2]: *** [drivers/net/spider_net.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2


-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
