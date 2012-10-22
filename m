Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 755212C0134
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2012 10:53:12 +1100 (EST)
Date: Mon, 22 Oct 2012 18:53:02 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3 v3] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
To: Tabi Timur-B04825 <B04825@freescale.com>
In-Reply-To: <6AE080B68D46FC4BA2D2769E68D765B7081084A7@039-SN2MPN1-023.039d.mgd.msft.net>
 (from B04825@freescale.com on Mon Oct 22 16:18:07 2012)
Message-ID: <1350949982.30970.11@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Sethi Varun-B16395 <B16395@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "joerg.roedel@amd.com" <joerg.roedel@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/22/2012 04:18:07 PM, Tabi Timur-B04825 wrote:
> On Wed, Oct 17, 2012 at 12:32 PM, Varun Sethi =20
> <Varun.Sethi@freescale.com> wrote:
> > +}
> > +
> > +static unsigned long pamu_get_fspi_and_allocate(u32 subwin_cnt)
> > +{
>=20
> subwin_cnt should probably be an unsigned int.
>=20
> This function needs to be documented.  What value is being returned?

spaact offset (yes, this needs to be documented)

> > +       unsigned long spaace_addr;
> > +
> > +       spaace_addr =3D gen_pool_alloc(spaace_pool, subwin_cnt * =20
> sizeof(paace_t));
> > +       if (!spaace_addr)
> > +               return ULONG_MAX;
>=20
> What's wrong with returning 0 on error?

0 is a valid spaact offset

> > +
> > +       return (spaace_addr - (unsigned long)spaact) / =20
> (sizeof(paace_t));
>=20
> Is this supposed to be a virtual address?  If so, then return void*
> instead of an unsigned long.

It's not a virtual address.  How often does subtraction followed by =20
division result in a valid virtual address?

> > +int  pamu_update_paace_stash(int liodn, u32 subwin, u32 value)

Whitespace

> > +#define PAMU_PAGE_SHIFT 12
> > +#define PAMU_PAGE_SIZE  4096ULL
>=20
> 4096ULL?  Why not just 4096?

This lets it be used in phys_addr_t expressions without needing casts
everywhere or dropping bits.

> > +/* This bitmap advertises the page sizes supported by PAMU hardware
> > + * to the IOMMU API.
> > + */
> > +#define FSL_PAMU_PGSIZES       (~0xFFFUL)
>=20
> There should be a better way to define this.  ~(PAMU_PAGE_SIZE-1) =20
> maybe?

Is it even true?  We don't support IOMMU pages larger than the SoC can
address.

The (~0xFFFUL) version also discards some valid IOMMU page sizes on
32-bit kernels.  One use case for windows larger than the CPU virtual
address space is creating one big identity-map window to effectively
disable translation.  If we're to support that, the size of =20
pgsize_bitmap
will need to change as well.

> > +static int map_liodn(int liodn, struct fsl_dma_domain *dma_domain)
> > +{
> > +       u32 subwin_cnt =3D dma_domain->subwin_cnt;
> > +       unsigned long rpn;
> > +       int ret =3D 0, i;
> > +
> > +       if (subwin_cnt) {
> > +               struct dma_subwindow *sub_win_ptr =3D
> > +                                       &dma_domain->sub_win_arr[0];
> > +               for (i =3D 0; i < subwin_cnt; i++) {
> > +                       if (sub_win_ptr[i].valid) {
> > +                               rpn =3D sub_win_ptr[i].paddr >>
> > +                                        PAMU_PAGE_SHIFT,
> > +                               spin_lock(&iommu_lock);
> > +                               ret =3D pamu_config_spaace(liodn, =20
> subwin_cnt, i,
> > +                                                        =20
> sub_win_ptr[i].size,
> > +                                                        -1,
> > +                                                        rpn,
> > +                                                        =20
> dma_domain->snoop_id,
> > +                                                        =20
> dma_domain->stash_id,
> > +                                                        (i > 0) ? =20
> 1 : 0,
> > +                                                        =20
> sub_win_ptr[i].prot);
> > +                               spin_unlock(&iommu_lock);
> > +                               if (ret) {
> > +                                       pr_err("PAMU SPAACE =20
> configuration failed for liodn %d\n",
> > +                                                liodn);
> > +                                       return ret;
> > +                               }
> > +                       }
> > +               }

Break up that nesting with some subfunctions.

> > +       while (!list_empty(&dma_domain->devices)) {
> > +               info =3D list_entry(dma_domain->devices.next,
> > +                       struct device_domain_info, link);
> > +               remove_domain_ref(info, dma_domain->subwin_cnt);
> > +       }
>=20
> I wonder if you should use list_for_each_safe() instead.

The above is simpler if you're destroying the entire list.

> > +}
> > +
> > +static int configure_domain_dma_state(struct fsl_dma_domain =20
> *dma_domain, int enable)
>=20
> bool enable
>=20
> Finally, please CC: me on all IOMMU and PAMU patches you post =20
> upstream.

Me too.

-Scott=
