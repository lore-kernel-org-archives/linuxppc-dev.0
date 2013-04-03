Return-Path: <B16395@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A7472C013E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 18:01:17 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu
 implementation.
Date: Wed, 3 Apr 2013 07:01:09 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D450AC2@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
 <1364500442-20927-6-git-send-email-Varun.Sethi@freescale.com>
 <20130402161812.GI15687@8bytes.org>
In-Reply-To: <20130402161812.GI15687@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Tuesday, April 02, 2013 9:48 PM
> To: Sethi Varun-B16395
> Cc: Yoder Stuart-B08248; Wood Scott-B07421; iommu@lists.linux-
> foundation.org; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org; galak@kernel.crashing.org;
> benh@kernel.crashing.org; Alex Williamson
> Subject: Re: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu
> implementation.
>=20
> Cc'ing Alex Williamson
>=20
> Alex, can you please review the iommu-group part of this patch?
>=20
> My comments so far are below:
>=20
> On Fri, Mar 29, 2013 at 01:24:02AM +0530, Varun Sethi wrote:
> > +config FSL_PAMU
> > +	bool "Freescale IOMMU support"
> > +	depends on PPC_E500MC
> > +	select IOMMU_API
> > +	select GENERIC_ALLOCATOR
> > +	help
> > +	  Freescale PAMU support.
>=20
> A bit lame for a help text. Can you elaborate more what PAMU is and when
> it should be enabled?
>=20
[Sethi Varun-B16395] Will update the description.

> > +int pamu_enable_liodn(int liodn)
> > +{
> > +	struct paace *ppaace;
> > +
> > +	ppaace =3D pamu_get_ppaace(liodn);
> > +	if (!ppaace) {
> > +		pr_err("Invalid primary paace entry\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	if (!get_bf(ppaace->addr_bitfields, PPAACE_AF_WSE)) {
> > +		pr_err("liodn %d not configured\n", liodn);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Ensure that all other stores to the ppaace complete first */
> > +	mb();
> > +
> > +	ppaace->addr_bitfields |=3D PAACE_V_VALID;
> > +	mb();
>=20
> Why is it sufficient to set the bit in a variable when enabling liodn but
> when disabling it set_bf needs to be called? This looks a bit assymetric.
>=20
[Sethi Varun-B16395] Will make it symetric :)

> > +/* Derive the window size encoding for a particular PAACE entry */
> > +static unsigned int map_addrspace_size_to_wse(phys_addr_t
> > +addrspace_size) {
> > +	/* Bug if not a power of 2 */
> > +	BUG_ON((addrspace_size & (addrspace_size - 1)));
>=20
> Please use is_power_of_2 here.
>=20
> > +
> > +	/* window size is 2^(WSE+1) bytes */
> > +	return __ffs(addrspace_size >> PAMU_PAGE_SHIFT) + PAMU_PAGE_SHIFT -
> > +1;
>=20
> The PAMU_PAGE_SHIFT shifting and adding looks redundant.
>=20
> > +	if ((win_size & (win_size - 1)) || win_size < PAMU_PAGE_SIZE) {
> > +		pr_err("window size too small or not a power of two %llx\n",
> win_size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (win_addr & (win_size - 1)) {
> > +		pr_err("window address is not aligned with window size\n");
> > +		return -EINVAL;
> > +	}
>=20
> Again, use is_power_of_2 instead of hand-coding.
>
[Sethi Varun-B16395] ok
=20
> > +	if (~stashid !=3D 0)
> > +		set_bf(paace->impl_attr, PAACE_IA_CID, stashid);
> > +
> > +	smp_wmb();
> > +
> > +	if (enable)
> > +		paace->addr_bitfields |=3D PAACE_V_VALID;
>=20
> Havn't you written a helper funtion to set this bit?
>=20
[Sethi Varun-B16395] We already have a PAACE entry with us here so we can d=
irectly manipulate it here.

> > +irqreturn_t pamu_av_isr(int irq, void *arg) {
> > +	struct pamu_isr_data *data =3D arg;
> > +	phys_addr_t phys;
> > +	unsigned int i, j;
> > +
> > +	pr_emerg("fsl-pamu: access violation interrupt\n");
> > +
> > +	for (i =3D 0; i < data->count; i++) {
> > +		void __iomem *p =3D data->pamu_reg_base + i * PAMU_OFFSET;
> > +		u32 pics =3D in_be32(p + PAMU_PICS);
> > +
> > +		if (pics & PAMU_ACCESS_VIOLATION_STAT) {
> > +			pr_emerg("POES1=3D%08x\n", in_be32(p + PAMU_POES1));
> > +			pr_emerg("POES2=3D%08x\n", in_be32(p + PAMU_POES2));
> > +			pr_emerg("AVS1=3D%08x\n", in_be32(p + PAMU_AVS1));
> > +			pr_emerg("AVS2=3D%08x\n", in_be32(p + PAMU_AVS2));
> > +			pr_emerg("AVA=3D%016llx\n", make64(in_be32(p +
> PAMU_AVAH),
> > +				in_be32(p + PAMU_AVAL)));
> > +			pr_emerg("UDAD=3D%08x\n", in_be32(p + PAMU_UDAD));
> > +			pr_emerg("POEA=3D%016llx\n", make64(in_be32(p +
> PAMU_POEAH),
> > +				in_be32(p + PAMU_POEAL)));
> > +
> > +			phys =3D make64(in_be32(p + PAMU_POEAH),
> > +				in_be32(p + PAMU_POEAL));
> > +
> > +			/* Assume that POEA points to a PAACE */
> > +			if (phys) {
> > +				u32 *paace =3D phys_to_virt(phys);
> > +
> > +				/* Only the first four words are relevant */
> > +				for (j =3D 0; j < 4; j++)
> > +					pr_emerg("PAACE[%u]=3D%08x\n", j,
> in_be32(paace + j));
> > +			}
> > +		}
> > +	}
> > +
> > +	panic("\n");
>=20
> A kernel panic seems like an over-reaction to an access violation.
> Besides the device that caused the violation the system should still
> work, no?
>=20
[Sethi Varun-B16395] Well, if device continues to DMA outside the set apert=
ure then it's a serious problem. We can run in to an interrupt storm (acces=
s violations).
Alternative could be to disable LIODN, but after that device DMAs would nev=
er go through. So, for the guest device is not functional.

> > +#define make64(high, low) (((u64)(high) << 32) | (low))
>=20
> You redefined this make64 here.
[Sethi Varun-B16395] :(

>=20
> > +static int map_subwins(int liodn, struct fsl_dma_domain *dma_domain)
> > +{
> > +	struct dma_window *sub_win_ptr =3D
> > +				&dma_domain->win_arr[0];
> > +	int i, ret;
> > +	unsigned long rpn;
> > +
> > +	for (i =3D 0; i < dma_domain->win_cnt; i++) {
> > +		if (sub_win_ptr[i].valid) {
> > +			rpn =3D sub_win_ptr[i].paddr >>
> > +				 PAMU_PAGE_SHIFT;
> > +			spin_lock(&iommu_lock);
>=20
> IOMMU code might run in interrupt context, so please use
> spin_lock_irqsave for the iommu_lock.
[Sethi Varun-B16395] ok

>=20
> > +static void detach_device(struct device *dev, struct fsl_dma_domain
> > +*dma_domain) {
> > +	struct device_domain_info *info;
> > +	struct list_head *entry, *tmp;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&dma_domain->domain_lock, flags);
> > +	/* Remove the device from the domain device list */
> > +	if (!list_empty(&dma_domain->devices)) {
> > +		list_for_each_safe(entry, tmp, &dma_domain->devices) {
> > +			info =3D list_entry(entry, struct device_domain_info,
> link);
> > +			if (!dev || (info->dev =3D=3D dev))
> > +				remove_device_ref(info, dma_domain->win_cnt);
> > +		}
> > +	}
> > +	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
>=20
> list_empty check is not needed. You can also use
> list_for_each_entry_safe.
[Sethi Varun-B16395] ok.

>=20
> > +static void attach_device(struct fsl_dma_domain *dma_domain, int
> > +liodn, struct device *dev) {
> > +	struct device_domain_info *info, *old_domain_info;
> > +
> > +	spin_lock(&device_domain_lock);
> > +	/*
> > +	 * Check here if the device is already attached to domain or not.
> > +	 * If the device is already attached to a domain detach it.
> > +	 */
> > +	old_domain_info =3D find_domain(dev);
> > +	if (old_domain_info && old_domain_info->domain !=3D dma_domain) {
> > +		spin_unlock(&device_domain_lock);
> > +		detach_device(dev, old_domain_info->domain);
> > +		spin_lock(&device_domain_lock);
> > +	}
> > +
> > +	info =3D kmem_cache_zalloc(iommu_devinfo_cache, GFP_KERNEL);
> > +
> > +	info->dev =3D dev;
> > +	info->liodn =3D liodn;
> > +	info->domain =3D dma_domain;
> > +
> > +	list_add(&info->link, &dma_domain->devices);
> > +	/*
> > +	 * In case of devices with multiple LIODNs just store
> > +	 * the info for the first LIODN as all
> > +	 * LIODNs share the same domain
> > +	 */
> > +	if (!old_domain_info)
> > +		dev->archdata.iommu_domain =3D info;
> > +	spin_unlock(&device_domain_lock);
>=20
> Don't you have to tell the hardware that a device was added to a domain?
> I don't see that, what I am missing?
[Sethi Varun-B16395] Not sure I understand, once the device is attached to =
the domain we can do the PAMU window setup corresponding to the device LIOD=
N (if the window information is available).

>=20
> > +static void swap_pci_ref(struct pci_dev **from, struct pci_dev *to) {
> > +	pci_dev_put(*from);
> > +	*from =3D to;
> > +}
>=20
> Hmm, looks like this function is re-implemented in a few IOMMU drivers.
> Want to use the chance to consolidate these implementations?
>=20

[Sethi Varun-B16395] Will consolidate :)

-Varun
