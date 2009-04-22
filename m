Return-Path: <michael@evidence.eu.com>
Received: from panicking.kicks-ass.org (unknown [77.224.194.88])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 391C0DDED1
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 02:01:49 +1000 (EST)
Message-ID: <49EF254A.6020106@evidence.eu.com>
Date: Wed, 22 Apr 2009 16:10:18 +0200
From: michael <michael@evidence.eu.com>
MIME-Version: 1.0
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] IB/ehca: Replace vmalloc with kmalloc
References: <200904211716.45245.ossrosch@linux.vnet.ibm.com>	<adaws9dvrkp.fsf@cisco.com>
	<200904221602.29028.ossrosch@linux.vnet.ibm.com>
In-Reply-To: <200904221602.29028.ossrosch@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Roland Dreier <rdreier@cisco.com>, fenkes@de.ibm.com,
	LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
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

Hi,

Stefan Roscher wrote:
> In case of large queue pairs there is the possibillity of allocation failures 
> due to memory fragmentationo with kmalloc().To ensure the memory is allocated even
> if kmalloc() can not find chunks which are big enough, we try to allocate the memory
> with vmalloc().
>
> Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>
> ---
>
> On Tuesday 21 April 2009 07:34:30 pm Roland Dreier wrote:
>   
>>  > +	queue->queue_pages = kmalloc(nr_of_pages * sizeof(void *), GFP_KERNEL);
>>
>> How big might this buffer be?  Any chance of allocation failure due to
>> memory fragmentation?
>>
>>  - R.
>>     
> Hey Roland, 
> yes you are right and here is the patch to circumvent the described problem.
> It will apply on top of the patchset.
> regards Stefan
>
>   
I don't take the point, if it is not import use the vmalloc. Why you try 
with a kmalloc
alloc first? and why do not use kzalloc?
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
>   

Regards Michael
