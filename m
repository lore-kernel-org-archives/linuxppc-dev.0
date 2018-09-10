Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427wtM6B66zDrM8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 15:03:39 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8A4xcci012386
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 01:03:37 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mdefv75fm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 01:03:37 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Mon, 10 Sep 2018 06:03:34 +0100
Date: Mon, 10 Sep 2018 15:03:28 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux@yadro.com
Subject: Re: [PATCH v2 5/5] PCI/powerpc/eeh: Add pcibios hooks for preparing
 to rescan
References: <20180906115752.29316-1-s.miroshnichenko@yadro.com>
 <20180906115752.29316-6-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
In-Reply-To: <20180906115752.29316-6-s.miroshnichenko@yadro.com>
Message-Id: <20180910050328.GC14370@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Thu, Sep 06, 2018 at 02:57:52PM +0300, Sergey Miroshnichenko wrote:
> Reading an empty slot returns all ones, which triggers a false
> EEH error event on PowerNV.
>=20
> New callbacks pcibios_rescan_prepare/done are introduced to
> pause/resume the EEH during rescan.

If I understand it correctly, this temporarily disables EEH for config space
accesses on the whole PHB while the rescan runs. Is it possible that a
real EEH event could be missed if it occurred during the rescan?

Even if it's not possible, I think it would be good to mention that in a
comment.

> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  arch/powerpc/include/asm/eeh.h               |  2 ++
>  arch/powerpc/kernel/eeh.c                    | 12 +++++++++++
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 22 ++++++++++++++++++++
>  drivers/pci/probe.c                          | 14 +++++++++++++
>  include/linux/pci.h                          |  2 ++
>  5 files changed, 52 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/ee=
h.h
> index 219637ea69a1..926c3e31df99 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -219,6 +219,8 @@ struct eeh_ops {
>  	int (*next_error)(struct eeh_pe **pe);
>  	int (*restore_config)(struct pci_dn *pdn);
>  	int (*notify_resume)(struct pci_dn *pdn);
> +	int (*pause)(struct pci_bus *bus);
> +	int (*resume)(struct pci_bus *bus);

I think these names are a bit too generic, what about naming them
pause_bus()/resume_bus() or even prepare_rescan()/rescan_done()?

>  };
> =20
>  extern int eeh_subsystem_flags;
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 6ebba3e48b01..9fb5012f389d 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1831,3 +1831,15 @@ static int __init eeh_init_proc(void)
>  	return 0;
>  }
>  __initcall(eeh_init_proc);
> +
> +void pcibios_rescan_prepare(struct pci_bus *bus)
> +{
> +	if (eeh_ops && eeh_ops->pause)
> +		eeh_ops->pause(bus);
> +}
> +
> +void pcibios_rescan_done(struct pci_bus *bus)
> +{
> +	if (eeh_ops && eeh_ops->resume)
> +		eeh_ops->resume(bus);
> +}
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/=
platforms/powernv/eeh-powernv.c
> index 3c1beae29f2d..9724a58afcd2 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -59,6 +59,26 @@ void pnv_pcibios_bus_add_device(struct pci_dev *pdev)
>  	eeh_sysfs_add_device(pdev);
>  }
> =20
> +static int pnv_eeh_pause(struct pci_bus *bus)
> +{
> +	struct pci_controller *hose =3D pci_bus_to_host(bus);
> +	struct pnv_phb *phb =3D hose->private_data;
> +
> +	phb->flags &=3D ~PNV_PHB_FLAG_EEH;
> +	disable_irq(eeh_event_irq);
> +	return 0;
> +}
> +
> +static int pnv_eeh_resume(struct pci_bus *bus)
> +{
> +	struct pci_controller *hose =3D pci_bus_to_host(bus);
> +	struct pnv_phb *phb =3D hose->private_data;
> +
> +	enable_irq(eeh_event_irq);
> +	phb->flags |=3D PNV_PHB_FLAG_EEH;
> +	return 0;
> +}
> +
>  static int pnv_eeh_init(void)
>  {
>  	struct pci_controller *hose;
> @@ -1710,6 +1730,8 @@ static struct eeh_ops pnv_eeh_ops =3D {
>  	.write_config           =3D pnv_eeh_write_config,
>  	.next_error		=3D pnv_eeh_next_error,
>  	.restore_config		=3D pnv_eeh_restore_config,
> +	.pause			=3D pnv_eeh_pause,
> +	.resume			=3D pnv_eeh_resume,
>  	.notify_resume		=3D NULL
>  };
> =20
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ac876e32de4b..4a9045364809 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2801,6 +2801,14 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
>  {
>  }
> =20
> +void __weak pcibios_rescan_prepare(struct pci_bus *bus)
> +{
> +}
> +
> +void __weak pcibios_rescan_done(struct pci_bus *bus)
> +{
> +}
> +
>  struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>  		struct pci_ops *ops, void *sysdata, struct list_head *resources)
>  {
> @@ -3055,9 +3063,15 @@ unsigned int pci_rescan_bus_bridge_resize(struct p=
ci_dev *bridge)
>  unsigned int pci_rescan_bus(struct pci_bus *bus)
>  {
>  	unsigned int max;
> +	struct pci_bus *root =3D bus;
> +
> +	while (!pci_is_root_bus(root))
> +		root =3D root->parent;
> =20
> +	pcibios_rescan_prepare(root);
>  	max =3D pci_scan_child_bus(bus);
>  	pci_assign_unassigned_bus_resources(bus);
> +	pcibios_rescan_done(root);
>  	pci_bus_add_devices(bus);
> =20
>  	return max;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 340029b2fb38..42930731c5a7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1929,6 +1929,8 @@ void pcibios_penalize_isa_irq(int irq, int active);
>  int pcibios_alloc_irq(struct pci_dev *dev);
>  void pcibios_free_irq(struct pci_dev *dev);
>  resource_size_t pcibios_default_alignment(void);
> +void pcibios_rescan_prepare(struct pci_bus *bus);
> +void pcibios_rescan_done(struct pci_bus *bus);
> =20
>  #ifdef CONFIG_HIBERNATE_CALLBACKS
>  extern struct dev_pm_ops pcibios_pm_ops;
> --=20
> 2.17.1
>=20

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAluV+xkACgkQMX8w6AQl
/iIbzwf+IW1F4K5TpUhF/LwMfDBJlrNJ55ilRyxpQZrISpwP+bp1sraQABy1xeIG
fall91Se7i59IYp5WtL4/xom0BfsS6Ca4OB7bJU9OQ4J7VL/XlSuRIfOw+p3YiZH
fXWDVlEkBf5fOIJ2vG8kecC+RpxfELtQdpD4aVoBzjMnyOGpl8A3CCPsPxcoLbLc
ZDBGIn03vmkZw3lA6Mw1Fc/7khmZ50AgNOCbJZy/GZm6/IuQ4wzb2Wy1yrqcqp4+
YhJ0+K2Ue7wBaSU1NyIV5kQKHFxwrkF+w4eYd5/ukJVAbwMu02ffI5REKqrbDGPF
6FH+x6D6j9/Op8mGAXAcEbhfZ6j/+g==
=Rk9P
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
