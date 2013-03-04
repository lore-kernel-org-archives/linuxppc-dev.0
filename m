Return-Path: <B16395@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 88E7D2C0318
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2013 22:31:28 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Stuart Yoder <b08248@gmail.com>
Subject: RE: [PATCH 6/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Mon, 4 Mar 2013 11:31:19 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D3D12D9@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
 <1361191939-21260-7-git-send-email-Varun.Sethi@freescale.com>
 <CALRxmdDEccTaS2Houuns44DoQ_8wUbXAMiXQ8w0Ks9R2F2u-Ag@mail.gmail.com>
In-Reply-To: <CALRxmdDEccTaS2Houuns44DoQ_8wUbXAMiXQ8w0Ks9R2F2u-Ag@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>, Joerg Roedel <joro@8bytes.org>,
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
> From: Stuart Yoder [mailto:b08248@gmail.com]
> Sent: Saturday, March 02, 2013 4:58 AM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; Wood Scott-B07421; Joerg Roedel; Yoder
> Stuart-B08248
> Subject: Re: [PATCH 6/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU
> API implementation.
>=20
> On Mon, Feb 18, 2013 at 6:52 AM, Varun Sethi <Varun.Sethi@freescale.com>
> wrote:
> [cut]
> > +static phys_addr_t get_phys_addr(struct fsl_dma_domain *dma_domain,
> > +unsigned long iova) {
> > +       u32 win_cnt =3D dma_domain->win_cnt;
> > +       struct dma_window *win_ptr =3D
> > +                               &dma_domain->win_arr[0];
> > +       struct iommu_domain_geometry *geom;
> > +
> > +       geom =3D &dma_domain->iommu_domain->geometry;
> > +
> > +       if (!win_cnt || !dma_domain->geom_size) {
> > +               pr_err("Number of windows/geometry not configured for
> the domain\n");
> > +               return 0;
> > +       }
> > +
> > +       if (win_cnt > 1) {
> > +               u64 subwin_size;
> > +               unsigned long subwin_iova;
> > +               u32 wnd;
> > +
> > +               subwin_size =3D dma_domain->geom_size >> ilog2(win_cnt)=
;
>=20
> Could it be just geom_size / win_cnt ??
[Sethi Varun-B16395] You would run in to linking issues with respect to u64=
 division on 32 bit kernels.

>=20
> > +               subwin_iova =3D iova & ~(subwin_size - 1);
> > +               wnd =3D (subwin_iova - geom->aperture_start) >>
> ilog2(subwin_size);
> > +               win_ptr =3D &dma_domain->win_arr[wnd];
> > +       }
> > +
> > +       if (win_ptr->valid)
> > +               return (win_ptr->paddr + (iova & (win_ptr->size -
> > + 1)));
> > +
> > +       return 0;
> > +}
> > +
> > +static int map_liodn_subwins(int liodn, struct fsl_dma_domain
> > +*dma_domain)
>=20
> Just call it map_subwins().  They are just sub windows, not "liodn sub
> windows".
>=20
[Sethi Varun-B16395] This would be called per liodn.

> [cut]
>=20
> > +static int map_liodn_win(int liodn, struct fsl_dma_domain
> > +*dma_domain)
>=20
> Call it map_win().
[Sethi Varun-B16395] This would again be called per liodn.

>=20
> [cut]
> > +static struct fsl_dma_domain *iommu_alloc_dma_domain(void) {
> > +       struct fsl_dma_domain *domain;
> > +
> > +       domain =3D kmem_cache_zalloc(fsl_pamu_domain_cache, GFP_KERNEL)=
;
> > +       if (!domain)
> > +               return NULL;
> > +
> > +       domain->stash_id =3D ~(u32)0;
> > +       domain->snoop_id =3D ~(u32)0;
> > +       domain->win_cnt =3D max_subwindow_count;
>=20
> To align with my previous comments on fsl_pamu.c, I think instead of
> referencing a global variable (in fsl_pamu.c) you should be making an
> accessor API call here to get the max subwindow _count.
>=20
[Sethi Varun-B16395] ok, I will make a accessor API call.

> > +       domain->geom_size =3D 0;
> > +
> > +       INIT_LIST_HEAD(&domain->devices);
> > +
> > +       spin_lock_init(&domain->domain_lock);
> > +
> > +       return domain;
> > +}
> > +
> > +static inline struct device_domain_info *find_domain(struct device
> > +*dev) {
> > +       return dev->archdata.iommu_domain; }
> > +
> > +static void remove_domain_ref(struct device_domain_info *info, u32
> > +win_cnt) {
> > +               list_del(&info->link);
> > +               spin_lock(&iommu_lock);
> > +               if (win_cnt)
> > +                       pamu_free_subwins(info->liodn);
> > +               pamu_disable_liodn(info->liodn);
> > +               spin_unlock(&iommu_lock);
> > +               spin_lock(&device_domain_lock);
> > +               info->dev->archdata.iommu_domain =3D NULL;
> > +               kmem_cache_free(iommu_devinfo_cache, info);
> > +               spin_unlock(&device_domain_lock); }
>=20
> The above function is literally removing the _device_ reference from the
> domain.
> The name implies that it is removing a "domain reference".   Suggestion
> is
> to call it "remove_device_ref".
>=20
> Also, the whitespace is messed up there.  You have 2 tabs instead of 1.
[Sethi Varun-B16395]  ok will make the change.
>=20
> > +static void destroy_domain(struct fsl_dma_domain *dma_domain) {
> > +       struct device_domain_info *info;
> > +
> > +       /* Dissociate all the devices from this domain */
> > +       while (!list_empty(&dma_domain->devices)) {
> > +               info =3D list_entry(dma_domain->devices.next,
> > +                       struct device_domain_info, link);
> > +               remove_domain_ref(info, dma_domain->win_cnt);
> > +       }
> > +}
>=20
> This function is removing all devices from a domain...maybe to be
> consistent with my suggestion below on detach_domain(), call this
> detach_all_devices().
>  We have 2 functions
> doing almost the same thing....one detaches a single device, one detaches
> all devices.
> The current names "destroy_domain" and "detach_domain" are not as clear
> to me.
>=20
[Sethi Varun-B16395]ok=20

> > +static void detach_domain(struct device *dev, struct fsl_dma_domain
> > +*dma_domain) {
> > +       struct device_domain_info *info;
> > +       struct list_head *entry, *tmp;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&dma_domain->domain_lock, flags);
> > +       /* Remove the device from the domain device list */
> > +       if (!list_empty(&dma_domain->devices)) {
> > +               list_for_each_safe(entry, tmp, &dma_domain->devices) {
> > +                       info =3D list_entry(entry, struct
> device_domain_info, link);
> > +                       if (info->dev =3D=3D dev)
> > +                               remove_domain_ref(info, dma_domain-
> >win_cnt);
> > +               }
> > +       }
> > +       spin_unlock_irqrestore(&dma_domain->domain_lock, flags); }
>=20
> This function is not "detaching a domain", but is detaching a device.
>  Call it detach_device().
>=20
[Sethi Varun-B16395] ok, will address this.

> > +static void attach_domain(struct fsl_dma_domain *dma_domain, int
> > +liodn, struct device *dev) {
>=20
> Same thing here.   This is not attaching a domain, but attaching a
> device.  Call it attach_device.
>=20
[Sethi Varun-B16395] ok.

> > +       struct device_domain_info *info, *old_domain_info;
> > +
> > +       spin_lock(&device_domain_lock);
> > +       /*
> > +        * Check here if the device is already attached to domain or
> not.
> > +        * If the device is already attached to a domain detach it.
> > +        */
> > +       old_domain_info =3D find_domain(dev);
> > +       if (old_domain_info && old_domain_info->domain !=3D dma_domain)=
 {
> > +               spin_unlock(&device_domain_lock);
> > +               detach_domain(dev, old_domain_info->domain);
> > +               spin_lock(&device_domain_lock);
> > +       }
> > +
> > +       info =3D kmem_cache_zalloc(iommu_devinfo_cache, GFP_KERNEL);
> > +
> > +       info->dev =3D dev;
> > +       info->liodn =3D liodn;
> > +       info->domain =3D dma_domain;
> > +
> > +       list_add(&info->link, &dma_domain->devices);
> > +       /*
> > +        * In case of devices with multiple LIODNs just store
> > +        * the info for the first LIODN as all
> > +        * LIODNs share the same domain
> > +        */
> > +       if (!old_domain_info)
> > +               dev->archdata.iommu_domain =3D info;
> > +       spin_unlock(&device_domain_lock);
> > +
> > +}
> > +
>=20
> [cut]
> > +/* Configure geometry settings for all LIODNs associated with domain
> > +*/ static int configure_domain(struct fsl_dma_domain *dma_domain,
> > +                           struct iommu_domain_geometry *geom_attr,
> > +                           u32 win_cnt)
>=20
> This function is not configuring the iommu domain...which is a concept in
> the Linux driver, it is taking the domain geometry and setting up the
> PAMU tables for all LIODNs currently in the domain.
>=20
> Maybe it would help if you used a prefix like "pamu" or "paact" to
> identify functions that operate on the actual PAMU tables.
>=20
> maybe:  pamu_set_domain_geometry()
>=20
[Sethi Varun-B16395] ok.
> > +{
> > +       struct device_domain_info *info;
> > +       int ret =3D 0;
> > +
> > +       if (!list_empty(&dma_domain->devices)) {
> > +               list_for_each_entry(info, &dma_domain->devices, link) {
> > +                       ret =3D configure_liodn(info->liodn, info->dev,
> dma_domain,
> > +                                             geom_attr, win_cnt);
>=20
> ...and following the above naming convention, call this (?):
> pamu_set_liodn
[Sethi Varun-B16395] ok.

>=20
> > +                       if (ret)
> > +                               break;
> > +               }
> > +       }
> > +
> > +       return ret;
> > +}
> > +
>=20
> [cut]
> > +static int fsl_pamu_window_enable(struct iommu_domain *domain, u32
> wnd_nr,
> > +                                 phys_addr_t paddr, u64 size, int
> > +iommu_prot) {
> > +       struct fsl_dma_domain *dma_domain =3D domain->priv;
> > +       struct dma_window *wnd;
> > +       int prot =3D 0;
> > +       int ret;
> > +       unsigned long flags;
> > +       u64 win_size;
> > +
> > +       if (iommu_prot & IOMMU_READ)
> > +               prot |=3D PAACE_AP_PERMS_QUERY;
> > +       if (iommu_prot & IOMMU_WRITE)
> > +               prot |=3D PAACE_AP_PERMS_UPDATE;
> > +
> > +       spin_lock_irqsave(&dma_domain->domain_lock, flags);
> > +       if (!dma_domain->win_arr) {
> > +               pr_err("Number of windows not configured\n");
> > +               spin_unlock_irqrestore(&dma_domain->domain_lock,
> flags);
> > +               return -ENODEV;
> > +       }
> > +
> > +       if (wnd_nr >=3D dma_domain->win_cnt) {
> > +               pr_err("Invalid window index\n");
> > +               spin_unlock_irqrestore(&dma_domain->domain_lock,
> flags);
> > +               return -EINVAL;
> > +       }
> > +
> > +       win_size =3D dma_domain->geom_size >>
> > + ilog2(dma_domain->win_cnt);
>=20
> Isn't size just geom_size / win_cnt.   Not sure why you do the ilog2()
> and right shift...
> We already validated that  win_cnt is power of 2 when it was set.
>=20
[Sethi Varun-B16395] problem with u64 division.

> > +       if (size > win_size) {
> > +               pr_err("Invalid window size \n");
> > +               spin_unlock_irqrestore(&dma_domain->domain_lock,
> flags);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (dma_domain->win_cnt =3D=3D 1) {
> > +               if (dma_domain->enabled) {
> > +                       pr_err("Disable the window before updating the
> mapping\n");
> > +                       spin_unlock_irqrestore(&dma_domain-
> >domain_lock, flags);
> > +                       return -EBUSY;
> > +               }
> > +
> > +               ret =3D check_size(size, domain-
> >geometry.aperture_start);
> > +               if (ret) {
> > +                       pr_err("Aperture start not aligned to the
> size\n");
> > +                       spin_unlock_irqrestore(&dma_domain-
> >domain_lock, flags);
> > +                       return -EINVAL;
> > +               }
> > +       }
>=20
> Why is win_cnt=3D=3D1 a special case?    Would the geometry not have been
> verified
> when it was originally set up?
>=20
[Sethi Varun-B16395] Yes, but in case of a single window you can still have=
 the flexibility of specifying a different size range. But the start addres=
s should still be aligned to the new size.
> Also, do you need a check here to verify if the geometry has been set.
> Is it a requirement to set the geometry prior to window enable?
[Sethi Varun-B16395] That is already checked with the subwindow array check=
.

>=20
> > +       wnd =3D &dma_domain->win_arr[wnd_nr];
> > +       if (!wnd->valid) {
> > +               wnd->paddr =3D paddr;
> > +               wnd->size =3D size;
> > +               wnd->prot =3D prot;
> > +
> > +               ret =3D update_domain_mapping(dma_domain, wnd_nr);
> > +               if (!ret) {
> > +                       wnd->valid =3D 1;
> > +                       dma_domain->mapped++;
> > +               }
> > +       } else {
> > +               pr_err("Disable the window before updating the
> mapping\n");
> > +               ret =3D -EBUSY;
> > +       }
> > +
> > +       spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> > +
> > +       return ret;
> > +}
> > +
> > +/*
>=20
> [cut]
> > +static int fsl_pamu_attach_device(struct iommu_domain *domain,
> > +                                 struct device *dev) {
> > +       struct fsl_dma_domain *dma_domain =3D domain->priv;
> > +       const u32 *prop;
> > +       u32 prop_cnt;
> > +       int len, ret =3D 0;
> > +       struct pci_dev *pdev =3D NULL;
> > +       struct pci_controller *pci_ctl;
> > +
> > +       /*
> > +        * Hack to make attach device work for the PCI devices. Simply
> assign the
> > +        * the LIODN for the PCI controller to the PCI device.
> > +        */
>=20
> Instead of "Simply assign...", perhaps say instead:  Use the LIODN for
> the PCI controller when attaching a PCI device.
[Sethi Varun-B16395] ok.

>=20
> > +       if (dev->bus =3D=3D &pci_bus_type) {
> > +               pdev =3D to_pci_dev(dev);
> > +               pci_ctl =3D pci_bus_to_host(pdev->bus);
> > +               /*
> > +                * make dev point to pci controller device
> > +                * so we can get the LIODN programmed by
> > +                * u-boot;
> > +                */
> > +               dev =3D pci_ctl->parent;
> > +       }
> > +
> > +       prop =3D of_get_property(dev->of_node, "fsl,liodn", &len);
>=20
> suggestion: name "prop" to be "liodn" and "prop_cnt" to be "liodn_cnt".
> That will be more clear.
[Sethi Varun-B16395] ok.

>=20
> > +       if (prop) {
> > +               prop_cnt =3D len / sizeof(u32);
> > +               ret =3D handle_attach_device(dma_domain, dev,
> > +                                        prop, prop_cnt);
> > +       } else {
> > +               pr_err("missing fsl,liodn property at %s\n",
> > +                         dev->of_node->full_name);
> > +                       ret =3D -EINVAL;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static void fsl_pamu_detach_device(struct iommu_domain *domain,
> > +                                     struct device *dev) {
> > +       struct fsl_dma_domain *dma_domain =3D domain->priv;
> > +       const u32 *prop;
> > +       int len;
> > +       struct pci_dev *pdev =3D NULL;
> > +       struct pci_controller *pci_ctl;
> > +
> > +       /*
> > +        * Hack to make detach device work for the PCI devices. Simply
> assign the
> > +        * the LIODN for the PCI controller to the PCI device.
> > +        */
> > +       if (dev->bus =3D=3D &pci_bus_type) {
> > +               pdev =3D to_pci_dev(dev);
> > +               pci_ctl =3D pci_bus_to_host(pdev->bus);
> > +               /*
> > +                * make dev point to pci controller device
> > +                * so we can get the LIODN programmed by
> > +                * u-boot;
> > +                */
> > +               dev =3D pci_ctl->parent;
> > +       }
> > +
> > +       prop =3D of_get_property(dev->of_node, "fsl,liodn", &len);
> > +       if (prop)
> > +               detach_domain(dev, dma_domain);
> > +       else
> > +               pr_err("missing fsl,liodn property at %s\n",
> > +                         dev->of_node->full_name); }
>=20
> I understand why you need the LIODN when attaching, but why do you get it
> in the detatch function.   You are not using "prop" here.
[Sethi Varun-B16395] Just a sanity check.

>=20
> [cut]
> > +static  bool check_pci_ctl_endpt_part(struct pci_controller *pci_ctl)
> > +{
> > +       u32 version;
> > +
> > +       /* Check the PCI controller version number by readding BRR1
> register */
> > +       version =3D in_be32(pci_ctl->cfg_addr + (PCI_FSL_BRR1 >> 2));
> > +       version &=3D PCI_FSL_BRR1_VER;
> > +       /* If PCI controller version is >=3D 0x204 we can partition
> endpoints*/
> > +       if (version >=3D 0x204)
> > +               return 1;
> > +
> > +       return 0;
> > +}
>=20
> Can we just use the compatible string here to identify the different
> kinds of PCI
> controllers?   Reading the actual device registers is ugly right now
> because
> you are #defining the BRR1 stuff in a generic powerpc header.
>=20
[Sethi Varun-B16395] hmmm......, I would have to check for various differen=
t compatible strings in that case. May be I can move the defines to a diffe=
rent file. What if I move them to some other header?

> > +static int fsl_pamu_add_device(struct device *dev) {
> > +       struct iommu_group *group =3D NULL;
> > +       struct pci_dev *pdev;
> > +       struct pci_dev *bridge, *dma_pdev =3D NULL;
> > +       struct pci_controller *pci_ctl;
> > +       int ret;
> > +
> > +       /*
> > +        * For platform devices we allocate a separate group for
> > +        * each of the devices.
> > +        */
> > +       if (dev->bus =3D=3D &pci_bus_type) {
> > +               bool pci_endpt_part;
>=20
> That variable name is not clear, the abbreviations are not natural.  I
> would just call it pci_endpoint_partitioning.
[Sethi Varun-B16395] ok.

-Varun
