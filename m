Return-Path: <SRS0+c81ddf811d472c051b1d+1039+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BCFE767C09
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 03:10:32 +1000 (EST)
Date: Wed, 28 Jun 2006 18:10:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
Subject: Re: [PATCH 4/7] powerpc: Add QE library qe_lib--ucc support
Message-ID: <20060628171027.GC7162@infradead.org>
References: <9FCDBA58F226D911B202000BDBAD467306E04FD5@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E04FD5@zch01exm40.ap.freescale.net>
Cc: Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, 'Paul Mackerras' <paulus@samba.org>,
	Gridish Shlomi-RM96313 <gridish@freescale.com>,
	Chu hanjin-r52514 <Hanjin.Chu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +int ucc_set_qe_mux_mii_mng(int ucc_num)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	out_be32(&qe_immr->qmx.cmxgcr,
> +		 ((in_be32(&qe_immr->qmx.cmxgcr) &
> +		   ~QE_CMXGCR_MII_ENET_MNG) |
> +		  (ucc_num << QE_CMXGCR_MII_ENET_MNG_SHIFT)));
> +	local_irq_restore(flags);

Using local_irq_save to protect hardware access is wrong.  Please use
spinlocks.
