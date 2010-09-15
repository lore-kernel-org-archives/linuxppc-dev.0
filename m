Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1284573958-8397-14-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-14-git-send-email-nacc@us.ibm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 15 Sep 2010 12:34:35 -0600
Message-ID: <AANLkTi=Hu44HLHj5RAUvSfR9Bv--OZEvi5eDj-R=yiks@mail.gmail.com>
Subject: Re: [PATCH 13/15] ppc/pseries: iommu cleanup
To: Nishanth Aravamudan <nacc@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, Milton Miller <miltonm@bga.com>,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 15, 2010 at 12:05 PM, Nishanth Aravamudan <nacc@us.ibm.com> wro=
te:
> No need to initialize per-cpu pointer to NULL, it is the default.
>
> Direct dma ops and no setup are the defaults, no need to set for
> iommu-off.
>
> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Also looks correct.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

g.

> ---
> =A0arch/powerpc/platforms/pseries/iommu.c | =A0 =A09 ++-------
> =A01 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platfo=
rms/pseries/iommu.c
> index a77bcae..9184db3 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -140,7 +140,7 @@ static int tce_build_pSeriesLP(struct iommu_table *tb=
l, long tcenum,
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -static DEFINE_PER_CPU(u64 *, tce_page) =3D NULL;
> +static DEFINE_PER_CPU(u64 *, tce_page);
>
> =A0static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcen=
um,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l=
ong npages, unsigned long uaddr,
> @@ -589,13 +589,8 @@ static struct notifier_block iommu_reconfig_nb =3D {
> =A0/* These are called very early. */
> =A0void iommu_init_early_pSeries(void)
> =A0{
> - =A0 =A0 =A0 if (of_chosen && of_get_property(of_chosen, "linux,iommu-of=
f", NULL)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Direct I/O, IOMMU off */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc_md.pci_dma_dev_setup =3D NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc_md.pci_dma_bus_setup =3D NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_pci_dma_ops(&dma_direct_ops);
> + =A0 =A0 =A0 if (of_chosen && of_get_property(of_chosen, "linux,iommu-of=
f", NULL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> - =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (firmware_has_feature(FW_FEATURE_LPAR)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (firmware_has_feature(FW_FEATURE_MULTIT=
CE)) {
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
