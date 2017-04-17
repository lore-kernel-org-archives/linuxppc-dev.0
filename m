Return-Path: <turtle.in.the.kernel@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6Hhx5jmWzDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 05:03:13 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id o36so19892320qtb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 12:03:13 -0700 (PDT)
Subject: Re: [PATCH] scsi: ibmvfc: don't check for failure from mempool_alloc()
To: NeilBrown <neilb@suse.com>, "James E.J. Bottomley"
 <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
References: <878tn9xb2m.fsf@notabene.neil.brown.name>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <6b896452-e653-bc96-3c26-1deeae995890@gmail.com>
Date: Mon, 17 Apr 2017 12:03:09 -0700
MIME-Version: 1.0
In-Reply-To: <878tn9xb2m.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/09/2017 07:15 PM, NeilBrown wrote:
> 
> mempool_alloc() cannot fail when passed GFP_NOIO or any
> other gfp setting that is permitted to sleep.
> So remove this pointless code.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

> ---
>  drivers/scsi/ibmvscsi/ibmvfc.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
> index 2c92dabb55f6..26cd3c28186a 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc.c
> @@ -3910,12 +3910,6 @@ static int ibmvfc_alloc_target(struct ibmvfc_host *vhost, u64 scsi_id)
>  	spin_unlock_irqrestore(vhost->host->host_lock, flags);
>  
>  	tgt = mempool_alloc(vhost->tgt_pool, GFP_NOIO);
> -	if (!tgt) {
> -		dev_err(vhost->dev, "Target allocation failure for scsi id %08llx\n",
> -			scsi_id);
> -		return -ENOMEM;
> -	}
> -
>  	memset(tgt, 0, sizeof(*tgt));
>  	tgt->scsi_id = scsi_id;
>  	tgt->new_scsi_id = scsi_id;
> 
