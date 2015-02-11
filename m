Return-Path: <vinod.koul@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by lists.ozlabs.org (Postfix) with ESMTP id C953D1A0118
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 12:07:50 +1100 (AEDT)
Date: Tue, 10 Feb 2015 17:05:30 -0800
From: Vinod Koul <vinod.koul@intel.com>
To: xuelin.shi@freescale.com
Subject: Re: [PATCH v5] dmaengine: Driver support for FSL RaidEngine device.
Message-ID: <20150211010530.GD21387@intel.com>
References: <1418610748-3586-1-git-send-email-xuelin.shi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418610748-3586-1-git-send-email-xuelin.shi@freescale.com>
Cc: dmaengine@vger.kernel.org, Harninder Rai <harninder.rai@freescale.com>,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
 Naveen Burmi <naveenburmi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 15, 2014 at 10:32:28AM +0800, xuelin.shi@freescale.com wrote:

> +/* Copy descriptor from per chan software queue into hardware job ring */
> +static void fsl_re_issue_pending(struct dma_chan *chan)
> +{
> +	struct fsl_re_chan *re_chan;
> +	int avail;
> +	struct fsl_re_desc *desc, *_desc;
> +	unsigned long flags;
> +
> +	re_chan = container_of(chan, struct fsl_re_chan, chan);
> +
> +	spin_lock_irqsave(&re_chan->desc_lock, flags);
> +	avail = FSL_RE_SLOT_AVAIL(
> +		in_be32(&re_chan->jrregs->inbring_slot_avail));
okay this seems slots avail in hw
> +
> +	list_for_each_entry_safe(desc, _desc, &re_chan->submit_q, node) {
> +		if (!avail)
> +			break;
and why break inside the loop. You shouldn't even enter this only to keep
breaking!


> +static void fsl_re_dequeue(unsigned long data)
> +{
> +	struct fsl_re_chan *re_chan;
> +	struct fsl_re_desc *desc, *_desc;
> +	struct fsl_re_hw_desc *hwdesc;
> +	unsigned long flags;
> +	unsigned int count, oub_count;
> +	int found;
> +
> +	re_chan = dev_get_drvdata((struct device *)data);
> +
> +	fsl_re_cleanup_descs(re_chan);
> +
> +	spin_lock_irqsave(&re_chan->desc_lock, flags);
> +	count =	FSL_RE_SLOT_FULL(in_be32(&re_chan->jrregs->oubring_slot_full));
> +	while (count--) {
> +		found = 0;
> +		hwdesc = &re_chan->oub_ring_virt_addr[re_chan->oub_count];
> +		list_for_each_entry_safe(desc, _desc, &re_chan->active_q,
> +					 node) {
> +			/* compare the hw dma addr to find the completed */
> +			if (desc->hwdesc.lbea32 == hwdesc->lbea32 &&
> +			    desc->hwdesc.addr_low == hwdesc->addr_low) {
> +				found = 1;
> +				break;
> +			}
> +		}
> +
> +		BUG_ON(!found);
you are killing the machine here. I don't think it too severe and can't be
handled gracefully?

> +static struct fsl_re_desc *fsl_re_chan_alloc_desc(struct fsl_re_chan *re_chan,
> +						  unsigned long flags)
> +{
> +	struct fsl_re_desc *desc = NULL;
> +	void *cf;
> +	dma_addr_t paddr;
> +	unsigned long lock_flag;
> +
> +	fsl_re_cleanup_descs(re_chan);
> +
> +	spin_lock_irqsave(&re_chan->desc_lock, lock_flag);
> +	if (!list_empty(&re_chan->free_q)) {
> +		/* take one desc from free_q */
> +		desc = list_first_entry(&re_chan->free_q,
> +					struct fsl_re_desc, node);
> +		list_del(&desc->node);
> +
> +		desc->async_tx.flags = flags;
> +	}
> +	spin_unlock_irqrestore(&re_chan->desc_lock, lock_flag);
> +
> +	if (!desc) {
> +		desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
> +		cf = dma_pool_alloc(re_chan->re_dev->cf_desc_pool, GFP_NOWAIT,
> +				    &paddr);
> +		if (!desc || !cf) {
> +			kfree(desc);
and this is buggy, you can fail in desc while cf is okay..!

> +			return NULL;
> +		}
> +
> +		desc = fsl_re_init_desc(re_chan, desc, cf, paddr);
> +		desc->async_tx.flags = flags;
> +
> +		spin_lock_irqsave(&re_chan->desc_lock, lock_flag);
> +		re_chan->alloc_count++;
> +		spin_unlock_irqrestore(&re_chan->desc_lock, lock_flag);
> +	}
> +
> +	return desc;
> +}
> +
> +static struct dma_async_tx_descriptor *fsl_re_prep_dma_genq(
> +		struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
> +		unsigned int src_cnt, const unsigned char *scf, size_t len,
> +		unsigned long flags)
> +{
> +	struct fsl_re_chan *re_chan;
> +	struct fsl_re_desc *desc;
> +	struct fsl_re_xor_cdb *xor;
> +	struct fsl_re_cmpnd_frame *cf;
> +	u32 cdb;
> +	unsigned int i, j;
> +	unsigned int save_src_cnt = src_cnt;
> +	int cont_q = 0;
> +
> +	if (len > FSL_RE_MAX_DATA_LEN) {
> +		pr_err("Length greater than %d not supported\n",
> +		       FSL_RE_MAX_DATA_LEN);
printing length will be helpful

btw whats wrong with dev_err. You do realize that someone who seems this will
have no clue which device is reporting this

> +
> +static int fsl_re_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct fsl_re_chan *re_chan;
> +	struct fsl_re_desc *desc;
> +	void *cf;
> +	dma_addr_t paddr;
> +	int i;
> +
> +	re_chan = container_of(chan, struct fsl_re_chan, chan);
> +	for (i = 0; i < FSL_RE_MIN_DESCS; i++) {
> +		desc = kzalloc(sizeof(*desc), GFP_KERNEL);
> +		cf = dma_pool_alloc(re_chan->re_dev->cf_desc_pool, GFP_KERNEL,
> +				    &paddr);
> +		if (!desc || !cf) {
> +			kfree(desc);
> +			break;
here as well...


> +	/* Output Ring */
> +	__be32 oubring_base_h;	/* Outbound Ring Base Address Register - High */
> +	__be32 oubring_base_l;	/* Outbound Ring Base Address Register - Low */
> +	__be32 oubring_size;	/* Outbound Ring Size Register */
> +	u8     rsvd8[4];
> +	__be32 oubring_job_rmvd; /* Outbound Ring Job Removed Register */
> +	u8     rsvd9[4];
> +	__be32 oubring_slot_full; /* Outbound Ring Slot Full Register */
> +	u8     rsvd10[4];
> +	__be32 oubring_prdcr_indx; /* Outbound Ring Producer Index */
> +};
is the dma BE always irresepective of CPU type or thats dependent on cpu type
too?

-- 
~Vinod
