Return-Path: <alexs@linux.vnet.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.17.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81928DDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 23:07:48 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.1/8.13.1) with ESMTP id n3SD7e7i026124
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 13:07:40 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n3SD7eVY3870856
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 15:07:40 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n3SD7dZa032708
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 15:07:40 +0200
Date: Tue, 28 Apr 2009 15:07:36 +0200
From: Alexander Schmidt <alexs@linux.vnet.ibm.com>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>, Roland Dreier
	<rdreier@cisco.com>
Subject: Re: [ewg] Re: [PATCH 1/3] IB/ehca: Replace vmalloc with kmalloc
Message-ID: <20090428150736.1ea143f0@BL3D1974.boeblingen.de.ibm.com>
In-Reply-To: <200904221602.29028.ossrosch@linux.vnet.ibm.com>
References: <200904211716.45245.ossrosch@linux.vnet.ibm.com>
	<adaws9dvrkp.fsf@cisco.com>
	<200904221602.29028.ossrosch@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: fenkes@de.ibm.com, LKML <linux-kernel@vger.kernel.org>,
	OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	alexschm@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Roland,

did you have a chance to take a look at the patchset and will you apply it, or
are there any outstanding issues we need to address?

Regards,
Alex

On Wed, 22 Apr 2009 16:02:28 +0200
Stefan Roscher <ossrosch@linux.vnet.ibm.com> wrote:

> In case of large queue pairs there is the possibillity of allocation failures 
> due to memory fragmentationo with kmalloc().To ensure the memory is allocated even
> if kmalloc() can not find chunks which are big enough, we try to allocate the memory
> with vmalloc().
> 
> Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>
> ---
> 
> On Tuesday 21 April 2009 07:34:30 pm Roland Dreier wrote:
> >  > +	queue->queue_pages = kmalloc(nr_of_pages * sizeof(void *), GFP_KERNEL);
> > 
> > How big might this buffer be?  Any chance of allocation failure due to
> > memory fragmentation?
> > 
> >  - R.
> Hey Roland, 
> yes you are right and here is the patch to circumvent the described problem.
> It will apply on top of the patchset.
> regards Stefan
> 
> 
> 
>  drivers/infiniband/hw/ehca/ipz_pt_fn.c |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/ehca/ipz_pt_fn.c b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
> index a260559..1227c59 100644
> --- a/drivers/infiniband/hw/ehca/ipz_pt_fn.c
> +++ b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
> @@ -222,8 +222,11 @@ int ipz_queue_ctor(struct ehca_pd *pd, struct ipz_queue *queue,
>  	/* allocate queue page pointers */
>  	queue->queue_pages = kmalloc(nr_of_pages * sizeof(void *), GFP_KERNEL);
>  	if (!queue->queue_pages) {
> -		ehca_gen_err("Couldn't allocate queue page list");
> -		return 0;
> +		queue->queue_pages = vmalloc(nr_of_pages * sizeof(void *));
> +		if (!queue->queue_pages) {
> +			ehca_gen_err("Couldn't allocate queue page list");
> +			return 0;
> +		}
>  	}
>  	memset(queue->queue_pages, 0, nr_of_pages * sizeof(void *));
> 
> @@ -240,7 +243,10 @@ int ipz_queue_ctor(struct ehca_pd *pd, struct ipz_queue *queue,
>  ipz_queue_ctor_exit0:
>  	ehca_gen_err("Couldn't alloc pages queue=%p "
>  		 "nr_of_pages=%x",  queue, nr_of_pages);
> -	kfree(queue->queue_pages);
> +	if (is_vmalloc_addr(queue->queue_pages))
> +		vfree(queue->queue_pages);
> +	else
> +		kfree(queue->queue_pages);
> 
>  	return 0;
>  }
> @@ -262,7 +268,10 @@ int ipz_queue_dtor(struct ehca_pd *pd, struct ipz_queue *queue)
>  			free_page((unsigned long)queue->queue_pages[i]);
>  	}
> 
> -	kfree(queue->queue_pages);
> +	if (is_vmalloc_addr(queue->queue_pages))
> +		vfree(queue->queue_pages);
> +	else
> +		kfree(queue->queue_pages);
> 
>  	return 1;
>  }
