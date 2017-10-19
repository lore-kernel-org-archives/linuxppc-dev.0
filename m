Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHnTK02L3zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 22:56:36 +1100 (AEDT)
Date: Thu, 19 Oct 2017 13:56:32 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe
 <jgunthorpe@obsidianresearch.com>, Jerry Snitselaar <jsnitsel@redhat.com>,
 Kenneth Goldman <kgold@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@samba.org>, Peter =?UTF-8?B?SMO8d2U=?= <PeterHuewe@gmx.de>, Stefan
 Berger <stefanb@linux.vnet.ibm.com>, kernel-janitors@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] char/tpm: Less checks in tpm_ibmvtpm_probe() after
 error detection
Message-ID: <20171019135632.4af42743@kitsune.suse.cz>
In-Reply-To: <09a2c3a1-1b10-507d-a866-258b570f6da1@users.sourceforge.net>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <09a2c3a1-1b10-507d-a866-258b570f6da1@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,


On Mon, 16 Oct 2017 19:34:56 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 16 Oct 2017 19:00:34 +0200
> 
> Two pointer checks could be repeated by the tpm_ibmvtpm_probe()
> function during error handling even if the relevant properties can be
> determined for the involved variables before by source code analysis.
> 
> * Return directly after a call of the function "kzalloc" failed
>   at the beginning.
> 
> * Adjust jump targets so that extra checks can be omitted at the end.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c
> b/drivers/char/tpm/tpm_ibmvtpm.c index a4b462a77b99..b8dda7546f64
> 100644 --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -610,7 +610,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev
> *vio_dev, 
>  	ibmvtpm = kzalloc(sizeof(*ibmvtpm), GFP_KERNEL);
>  	if (!ibmvtpm)
> -		goto cleanup;
> +		return -ENOMEM;

Just no.

I have seen many fixes that do inverse of this after a piece of code
allocating some more resources was added before code that returns
straight away because it is the first allocation in a function.

>  
>  	ibmvtpm->dev = dev;
>  	ibmvtpm->vdev = vio_dev;
> @@ -619,7 +619,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev
> *vio_dev, crq_q->crq_addr = (struct ibmvtpm_crq
> *)get_zeroed_page(GFP_KERNEL); if (!crq_q->crq_addr) {
>  		dev_err(dev, "Unable to allocate memory for
> crq_addr\n");
> -		goto cleanup;
> +		goto free_tpm;
>  	}
>  
>  	crq_q->num_entry = CRQ_RES_BUF_SIZE /
> sizeof(*crq_q->crq_addr); @@ -629,7 +629,7 @@ static int
> tpm_ibmvtpm_probe(struct vio_dev *vio_dev, 
>  	if (dma_mapping_error(dev, ibmvtpm->crq_dma_handle)) {
>  		dev_err(dev, "dma mapping failed\n");
> -		goto cleanup;
> +		goto free_page;
>  	}
>  
>  	rc = plpar_hcall_norets(H_REG_CRQ, vio_dev->unit_address,
> @@ -683,13 +683,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev
> *vio_dev, reg_crq_cleanup:
>  	dma_unmap_single(dev, ibmvtpm->crq_dma_handle,
> CRQ_RES_BUF_SIZE, DMA_BIDIRECTIONAL);
> -cleanup:
> -	if (ibmvtpm) {
> -		if (crq_q->crq_addr)
> -			free_page((unsigned long)crq_q->crq_addr);
> -		kfree(ibmvtpm);
> -	}
> -

I think a single cleanup section is better than many labels that just
avoid a single null check.

As long as you can tell easily which resources were already allocated
and need to be freed it is saner to keep only one cleanup section.

If the code doing the allocation is changed in the future the single
cleanup can stay whereas multiple labels have to be rewritten again.

Also just changing this just for the sake of code style does not seem
worth it whatever style you prefer.

Thanks

Michal
