Return-Path: <xuelin.shi@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0147.outbound.protection.outlook.com [157.56.110.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA69C1A06A2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 17:50:35 +1100 (AEDT)
From: Xuelin Shi <xuelin.shi@freescale.com>
To: Vinod Koul <vinod.koul@intel.com>
Subject: RE: [PATCH v5] dmaengine: Driver support for FSL RaidEngine device.
Date: Wed, 11 Feb 2015 06:34:58 +0000
Message-ID: <CY1PR0301MB06846E02973B1E1AA8B3019186250@CY1PR0301MB0684.namprd03.prod.outlook.com>
References: <1418610748-3586-1-git-send-email-xuelin.shi@freescale.com>
 <20150211010530.GD21387@intel.com>
In-Reply-To: <20150211010530.GD21387@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, Harninder
 Rai <harninder.rai@freescale.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Naveen Burmi <NaveenBurmi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,=20

Please see my comments inline.

Thanks,
Shi xuelin

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul@intel.com]
> Sent: Wednesday, February 11, 2015 09:06
> To: Shi Xuelin-B29237
> Cc: dan.j.williams@intel.com; dmaengine@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Rai Harninder-B01044; Burmi Naveen-B16502
> Subject: Re: [PATCH v5] dmaengine: Driver support for FSL RaidEngine
> device.
>=20
> On Mon, Dec 15, 2014 at 10:32:28AM +0800, xuelin.shi@freescale.com wrote:
>=20
> > +/* Copy descriptor from per chan software queue into hardware job
> > +ring */ static void fsl_re_issue_pending(struct dma_chan *chan) {
> > +	struct fsl_re_chan *re_chan;
> > +	int avail;
> > +	struct fsl_re_desc *desc, *_desc;
> > +	unsigned long flags;
> > +
> > +	re_chan =3D container_of(chan, struct fsl_re_chan, chan);
> > +
> > +	spin_lock_irqsave(&re_chan->desc_lock, flags);
> > +	avail =3D FSL_RE_SLOT_AVAIL(
> > +		in_be32(&re_chan->jrregs->inbring_slot_avail));
> okay this seems slots avail in hw
> > +
> > +	list_for_each_entry_safe(desc, _desc, &re_chan->submit_q, node) {
> > +		if (!avail)
> > +			break;
> and why break inside the loop. You shouldn't even enter this only to keep
> breaking!
This "if" is necessary because "avail--" is also in the loop.=20


>=20
>=20
> > +static void fsl_re_dequeue(unsigned long data) {
> > +	struct fsl_re_chan *re_chan;
> > +	struct fsl_re_desc *desc, *_desc;
> > +	struct fsl_re_hw_desc *hwdesc;
> > +	unsigned long flags;
> > +	unsigned int count, oub_count;
> > +	int found;
> > +
> > +	re_chan =3D dev_get_drvdata((struct device *)data);
> > +
> > +	fsl_re_cleanup_descs(re_chan);
> > +
> > +	spin_lock_irqsave(&re_chan->desc_lock, flags);
> > +	count =3D	FSL_RE_SLOT_FULL(in_be32(&re_chan->jrregs-
> >oubring_slot_full));
> > +	while (count--) {
> > +		found =3D 0;
> > +		hwdesc =3D &re_chan->oub_ring_virt_addr[re_chan->oub_count];
> > +		list_for_each_entry_safe(desc, _desc, &re_chan->active_q,
> > +					 node) {
> > +			/* compare the hw dma addr to find the completed */
> > +			if (desc->hwdesc.lbea32 =3D=3D hwdesc->lbea32 &&
> > +			    desc->hwdesc.addr_low =3D=3D hwdesc->addr_low) {
> > +				found =3D 1;
> > +				break;
> > +			}
> > +		}
> > +
> > +		BUG_ON(!found);
> you are killing the machine here. I don't think it too severe and can't
> be handled gracefully?
>=20
OK, BUG_ON should be avoided.


> > +static struct fsl_re_desc *fsl_re_chan_alloc_desc(struct fsl_re_chan
> *re_chan,
> > +						  unsigned long flags)
> > +{
> > +	struct fsl_re_desc *desc =3D NULL;
> > +	void *cf;
> > +	dma_addr_t paddr;
> > +	unsigned long lock_flag;
> > +
> > +	fsl_re_cleanup_descs(re_chan);
> > +
> > +	spin_lock_irqsave(&re_chan->desc_lock, lock_flag);
> > +	if (!list_empty(&re_chan->free_q)) {
> > +		/* take one desc from free_q */
> > +		desc =3D list_first_entry(&re_chan->free_q,
> > +					struct fsl_re_desc, node);
> > +		list_del(&desc->node);
> > +
> > +		desc->async_tx.flags =3D flags;
> > +	}
> > +	spin_unlock_irqrestore(&re_chan->desc_lock, lock_flag);
> > +
> > +	if (!desc) {
> > +		desc =3D kzalloc(sizeof(*desc), GFP_NOWAIT);
> > +		cf =3D dma_pool_alloc(re_chan->re_dev->cf_desc_pool, GFP_NOWAIT,
> > +				    &paddr);
> > +		if (!desc || !cf) {
> > +			kfree(desc);
> and this is buggy, you can fail in desc while cf is okay..!
>=20
OK, will be revised.

> > +			return NULL;
> > +		}
> > +
> > +		desc =3D fsl_re_init_desc(re_chan, desc, cf, paddr);
> > +		desc->async_tx.flags =3D flags;
> > +
> > +		spin_lock_irqsave(&re_chan->desc_lock, lock_flag);
> > +		re_chan->alloc_count++;
> > +		spin_unlock_irqrestore(&re_chan->desc_lock, lock_flag);
> > +	}
> > +
> > +	return desc;
> > +}
> > +
> > +static struct dma_async_tx_descriptor *fsl_re_prep_dma_genq(
> > +		struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
> > +		unsigned int src_cnt, const unsigned char *scf, size_t len,
> > +		unsigned long flags)
> > +{
> > +	struct fsl_re_chan *re_chan;
> > +	struct fsl_re_desc *desc;
> > +	struct fsl_re_xor_cdb *xor;
> > +	struct fsl_re_cmpnd_frame *cf;
> > +	u32 cdb;
> > +	unsigned int i, j;
> > +	unsigned int save_src_cnt =3D src_cnt;
> > +	int cont_q =3D 0;
> > +
> > +	if (len > FSL_RE_MAX_DATA_LEN) {
> > +		pr_err("Length greater than %d not supported\n",
> > +		       FSL_RE_MAX_DATA_LEN);
> printing length will be helpful
>=20
> btw whats wrong with dev_err. You do realize that someone who seems this
> will have no clue which device is reporting this
>=20
OK, dev_err will be used instead of pr_err.


> > +
> > +static int fsl_re_alloc_chan_resources(struct dma_chan *chan) {
> > +	struct fsl_re_chan *re_chan;
> > +	struct fsl_re_desc *desc;
> > +	void *cf;
> > +	dma_addr_t paddr;
> > +	int i;
> > +
> > +	re_chan =3D container_of(chan, struct fsl_re_chan, chan);
> > +	for (i =3D 0; i < FSL_RE_MIN_DESCS; i++) {
> > +		desc =3D kzalloc(sizeof(*desc), GFP_KERNEL);
> > +		cf =3D dma_pool_alloc(re_chan->re_dev->cf_desc_pool, GFP_KERNEL,
> > +				    &paddr);
> > +		if (!desc || !cf) {
> > +			kfree(desc);
> > +			break;
> here as well...
>=20
OK, will be revised.


>=20
> > +	/* Output Ring */
> > +	__be32 oubring_base_h;	/* Outbound Ring Base Address Register -
> High */
> > +	__be32 oubring_base_l;	/* Outbound Ring Base Address Register -
> Low */
> > +	__be32 oubring_size;	/* Outbound Ring Size Register */
> > +	u8     rsvd8[4];
> > +	__be32 oubring_job_rmvd; /* Outbound Ring Job Removed Register */
> > +	u8     rsvd9[4];
> > +	__be32 oubring_slot_full; /* Outbound Ring Slot Full Register */
> > +	u8     rsvd10[4];
> > +	__be32 oubring_prdcr_indx; /* Outbound Ring Producer Index */ };
> is the dma BE always irresepective of CPU type or thats dependent on cpu
> type too?
>=20
The reference manual says the structure should be BigEndian.
This dev is only used in Freescale PowerPC SoC.

> --
> ~Vinod
