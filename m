Return-Path: <SRS0+04cdd449c1b762fe1908+1270+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 083C4DDE38
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 09:28:34 +1100 (EST)
Date: Wed, 14 Feb 2007 22:28:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2.6.21-rc1 4/5] ehca: replace yield() by
	wait_for_completion()
Message-ID: <20070214222824.GA11579@infradead.org>
References: <200702141741.35444.hnguyen@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200702141741.35444.hnguyen@linux.vnet.ibm.com>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com, h.carstens@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> @@ -332,7 +333,7 @@ int ehca_destroy_cq(struct ib_cq *cq)
>         spin_lock_irqsave(&ehca_cq_idr_lock, flags);
>         while (my_cq->nr_callbacks) {
>                 spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
> -               yield();
> +               wait_for_completion(&my_cq->zero_callbacks);
>                 spin_lock_irqsave(&ehca_cq_idr_lock, flags);
>         }

A while loop around wait_for_completion doesn't make all that much sense.
I suspect a simple

	if (my_cq->nr_callbacks)
		wait_for_completion(&my_cq->zero_callbacks);

Is what you need.
