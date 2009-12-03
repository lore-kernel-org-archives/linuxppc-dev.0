Return-Path: <pbathija@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5493EB7BBE
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 10:21:48 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [SCSI] mpt fusion: Fix 32 bit platforms with 64 bit
	resources.
Date: Thu, 3 Dec 2009 15:21:41 -0800
Message-ID: <9D1E2BDCB5C57B46B56E6D80843439EB097BB063@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <20091203085628.5140FE6D391@gemini.denx.de>
References: <1259805106-23636-1-git-send-email-pbathija@amcc.com>
	<20091203085628.5140FE6D391@gemini.denx.de>
From: "Pravin Bathija" <pbathija@amcc.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: linuxppc-dev@ozlabs.org, Eric.Moore@lsi.com, "Desai,
	Kashyap" <Kashyap.Desai@lsi.com>, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfgang,

> -----Original Message-----
> From: Wolfgang Denk [mailto:wd@denx.de]
> Sent: Thursday, December 03, 2009 12:56 AM
> To: Pravin Bathija; Benjamin Herrenschmidt; Desai, Kashyap
> Cc: linux-scsi@vger.kernel.org; linuxppc-dev@ozlabs.org;
> Eric.Moore@lsi.com
> Subject: Re: [PATCH] [SCSI] mpt fusion: Fix 32 bit platforms with 64
> bit resources.
>=20
> Dear Pravin Bathija,
>=20
> In message <1259805106-23636-1-git-send-email-pbathija@amcc.com> you
> wrote:
> >     Powerpc 44x uses 36 bit real address while the real address
> defined
> >     in MPT Fusion driver is of type 32 bit. This causes ioremap to
> fail and driver
> >     fails to initialize. This fix changes the data types
representing
> the real
> >     address from unsigned long 32-bit types to resource_size_t which
> is 64-bit. The
> >     driver has been tested, the disks get discovered correctly and
> can do IO.
> ...
> > --- a/drivers/message/fusion/mptbase.c
> > +++ b/drivers/message/fusion/mptbase.c
> > @@ -1511,7 +1511,7 @@ mpt_mapresources(MPT_ADAPTER *ioc)
> >  {
> >  	u8		__iomem *mem;
> >  	int		 ii;
> > -	unsigned long	 mem_phys;
> > +	resource_size_t	 mem_phys;
> >  	unsigned long	 port;
> >  	u32		 msize;
> >  	u32		 psize;
>=20
> I'm not sure if this one-liner really covers all the related issues.
> We submitted a similar (but apparently more complete) patch more than
> a year ago. Dunno why it has never been picked up. See
> http://thread.gmane.org/gmane.linux.scsi/46082 for reference.
>=20

I submitted a patch on similar lines several weeks ago and it wasn't
accepted on grounds that it was too tied to the powerpc platform. Below
is a link

http://article.gmane.org/gmane.linux.scsi/55794




>=20
> > From: Yuri Tikhonov <yur@emcraft.com>
> To: linux-scsi@vger.kernel.org
> Subject: [PATCH] mptbase: use resource_size_t instead of unsigned long
> and u32
> Date: Thu, 13 Nov 2008 11:33:16 +0300
>=20
>  Hello,
>=20
>  The following patch adds using resource_size_t for the
> pci_resource_start()/pci_resource_len() return values. This
> makes mptbase driver work correctly on 32 bit systems with
> 64 bit resources (e.g. PPC440SPe).
>=20
> Do some minor cleanups in mpt_mapresources() as well.
>=20
> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
>  drivers/message/fusion/mptbase.c |   38
++++++++++++++++++++++++++----
> --------
>  drivers/message/fusion/mptbase.h |    5 +++--
>  2 files changed, 29 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/message/fusion/mptbase.c
> b/drivers/message/fusion/mptbase.c
> index d6a0074..9daf844 100644
> --- a/drivers/message/fusion/mptbase.c
> +++ b/drivers/message/fusion/mptbase.c
> @@ -1488,11 +1488,12 @@ static int
>  mpt_mapresources(MPT_ADAPTER *ioc)
>  {
>  	u8		__iomem *mem;
> +	u8		__iomem *port;
>  	int		 ii;
> -	unsigned long	 mem_phys;
> -	unsigned long	 port;
> -	u32		 msize;
> -	u32		 psize;
> +	resource_size_t	 mem_phys;
> +	resource_size_t	 port_phys;
> +	resource_size_t	 msize;
> +	resource_size_t	 psize;
>  	u8		 revision;
>  	int		 r =3D -ENODEV;
>  	struct pci_dev *pdev;
> @@ -1530,13 +1531,13 @@ mpt_mapresources(MPT_ADAPTER *ioc)
>  	}
>=20
>  	mem_phys =3D msize =3D 0;
> -	port =3D psize =3D 0;
> +	port_phys =3D psize =3D 0;
>  	for (ii =3D 0; ii < DEVICE_COUNT_RESOURCE; ii++) {
>  		if (pci_resource_flags(pdev, ii) &
> PCI_BASE_ADDRESS_SPACE_IO) {
>  			if (psize)
>  				continue;
>  			/* Get I/O space! */
> -			port =3D pci_resource_start(pdev, ii);
> +			port_phys =3D pci_resource_start(pdev, ii);
>  			psize =3D pci_resource_len(pdev, ii);
>  		} else {
>  			if (msize)
> @@ -1546,11 +1547,8 @@ mpt_mapresources(MPT_ADAPTER *ioc)
>  			msize =3D pci_resource_len(pdev, ii);
>  		}
>  	}
> -	ioc->mem_size =3D msize;
>=20
> -	mem =3D NULL;
>  	/* Get logical ptr for PciMem0 space */
> -	/*mem =3D ioremap(mem_phys, msize);*/
>  	mem =3D ioremap(mem_phys, msize);
>  	if (mem =3D=3D NULL) {
>  		printk(MYIOC_s_ERR_FMT ": ERROR - Unable to map adapter"
> @@ -1558,14 +1556,24 @@ mpt_mapresources(MPT_ADAPTER *ioc)
>  		return -EINVAL;
>  	}
>  	ioc->memmap =3D mem;
> -	dinitprintk(ioc, printk(MYIOC_s_INFO_FMT "mem =3D %p, mem_phys =3D
> %lx\n",
> -	    ioc->name, mem, mem_phys));
> +	dinitprintk(ioc, printk(MYIOC_s_INFO_FMT "mem=3D%p,
> mem_phys=3D%llx\n",
> +	    ioc->name, mem, (u64)mem_phys));
>=20
>  	ioc->mem_phys =3D mem_phys;
>  	ioc->chip =3D (SYSIF_REGS __iomem *)mem;
>=20
>  	/* Save Port IO values in case we need to do downloadboot */
> -	ioc->pio_mem_phys =3D port;
> +	port =3D ioremap(port_phys, psize);
> +	if (port =3D=3D NULL) {
> +		printk(MYIOC_s_ERR_FMT ": ERROR - Unable to map adapter"
> +			" port!\n", ioc->name);
> +		return -EINVAL;
> +	}
> +	ioc->portmap =3D port;
> +	dinitprintk(ioc, printk(MYIOC_s_INFO_FMT "port=3D%p,
> port_phys=3D%llx\n",
> +	    ioc->name, port, (u64)port_phys));
> +
> +	ioc->pio_mem_phys =3D port_phys;
>  	ioc->pio_chip =3D (SYSIF_REGS __iomem *)port;
>=20
>  	return 0;
> @@ -1790,6 +1798,7 @@ mpt_attach(struct pci_dev *pdev, const struct
> pci_device_id *id)
>  		list_del(&ioc->list);
>  		if (ioc->alt_ioc)
>  			ioc->alt_ioc->alt_ioc =3D NULL;
> +		iounmap(ioc->portmap);
>  		iounmap(ioc->memmap);
>  		if (r !=3D -5)
>  			pci_release_selected_regions(pdev, ioc->bars);
> @@ -2547,6 +2556,11 @@ mpt_adapter_dispose(MPT_ADAPTER *ioc)
>  		ioc->pci_irq =3D -1;
>  	}
>=20
> +	if (ioc->portmap !=3D NULL) {
> +		iounmap(ioc->portmap);
> +		ioc->portmap =3D NULL;
> +	}
> +
>  	if (ioc->memmap !=3D NULL) {
>  		iounmap(ioc->memmap);
>  		ioc->memmap =3D NULL;
> diff --git a/drivers/message/fusion/mptbase.h
> b/drivers/message/fusion/mptbase.h
> index dff048c..17826b3 100644
> --- a/drivers/message/fusion/mptbase.h
> +++ b/drivers/message/fusion/mptbase.h
> @@ -584,8 +584,8 @@ typedef struct _MPT_ADAPTER
>  	SYSIF_REGS __iomem	*chip;		/* =3D=3D c8817000 (mmap)
> */
>  	SYSIF_REGS __iomem	*pio_chip;	/* Programmed IO
> (downloadboot) */
>  	u8			 bus_type;
> -	u32			 mem_phys;	/* =3D=3D f4020000 (mmap) */
> -	u32			 pio_mem_phys;	/* Programmed IO
> (downloadboot) */
> +	resource_size_t		 mem_phys;	/* =3D=3D f4020000 (mmap) */
> +	resource_size_t		 pio_mem_phys;	/* Programmed IO
> (downloadboot) */
>  	int			 mem_size;	/* mmap memory size */
>  	int			 number_of_buses;
>  	int			 devices_per_bus;
> @@ -635,6 +635,7 @@ typedef struct _MPT_ADAPTER
>  	int			bars;		/* bitmask of BAR's that
must be
> configured */
>  	int			msi_enable;
>  	u8			__iomem *memmap;	/* mmap address
*/
> +	u8			__iomem *portmap;	/* mmap address
*/
>  	struct Scsi_Host	*sh;		/* Scsi Host pointer */
>  	SpiCfgData		spi_data;	/* Scsi config. data */
>  	RaidCfgData		raid_data;	/* Raid config. data */
> --
> 1.5.6.1
>=20
>=20
> --
> Yuri Tikhonov, Senior Software Engineer
> Emcraft Systems, www.emcraft.com
>=20
>=20
>=20
>=20
>=20
>=20
> Best regards,
>=20
> Wolfgang Denk
>=20
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> "I haven't lost my mind - it's backed up on tape somewhere."
