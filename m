Return-Path: <s.miroshnichenko@yadro.com>
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428CSt6qsHzF39h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 02:01:02 +1000 (AEST)
Subject: Re: [PATCH v2 5/5] PCI/powerpc/eeh: Add pcibios hooks for preparing
 to rescan
To: Sam Bobroff <sbobroff@linux.ibm.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux@yadro.com>
References: <20180906115752.29316-1-s.miroshnichenko@yadro.com>
 <20180906115752.29316-6-s.miroshnichenko@yadro.com>
 <20180910050328.GC14370@tungsten.ozlabs.ibm.com>
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Message-ID: <61e8e5b9-0ed2-1848-d676-64bcbd3b9cbc@yadro.com>
Date: Mon, 10 Sep 2018 19:00:52 +0300
MIME-Version: 1.0
In-Reply-To: <20180910050328.GC14370@tungsten.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lXKbvMeGiZmBJcnUzItKWsd2XBte1GsJp"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--lXKbvMeGiZmBJcnUzItKWsd2XBte1GsJp
Content-Type: multipart/mixed; boundary="BuxwwyRtquxuFZ5p8jZikcRkIgLpeek74";
 protected-headers="v1"
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: Sam Bobroff <sbobroff@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux@yadro.com
Message-ID: <61e8e5b9-0ed2-1848-d676-64bcbd3b9cbc@yadro.com>
Subject: Re: [PATCH v2 5/5] PCI/powerpc/eeh: Add pcibios hooks for preparing
 to rescan
References: <20180906115752.29316-1-s.miroshnichenko@yadro.com>
 <20180906115752.29316-6-s.miroshnichenko@yadro.com>
 <20180910050328.GC14370@tungsten.ozlabs.ibm.com>
In-Reply-To: <20180910050328.GC14370@tungsten.ozlabs.ibm.com>

--BuxwwyRtquxuFZ5p8jZikcRkIgLpeek74
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Sam,

On 9/10/18 8:03 AM, Sam Bobroff wrote:
> Hi Sergey,
>=20
> On Thu, Sep 06, 2018 at 02:57:52PM +0300, Sergey Miroshnichenko wrote:
>> Reading an empty slot returns all ones, which triggers a false
>> EEH error event on PowerNV.
>>
>> New callbacks pcibios_rescan_prepare/done are introduced to
>> pause/resume the EEH during rescan.
>=20
> If I understand it correctly, this temporarily disables EEH for config =
space
> accesses on the whole PHB while the rescan runs. Is it possible that a
> real EEH event could be missed if it occurred during the rescan?
>=20
> Even if it's not possible, I think it would be good to mention that in =
a
> comment.

Yes, missing a real EEH event is possible, unfortunately, and it is
indeed worth mentioning.

To reduce this probability the next patchset I'll post in a few days
among other things puts all the affected device drivers to pause during
rescan, mainly because of moving BARs and bridge windows, but it will
also help here a bit.

>=20
>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>> ---
>>  arch/powerpc/include/asm/eeh.h               |  2 ++
>>  arch/powerpc/kernel/eeh.c                    | 12 +++++++++++
>>  arch/powerpc/platforms/powernv/eeh-powernv.c | 22 +++++++++++++++++++=
+
>>  drivers/pci/probe.c                          | 14 +++++++++++++
>>  include/linux/pci.h                          |  2 ++
>>  5 files changed, 52 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm=
/eeh.h
>> index 219637ea69a1..926c3e31df99 100644
>> --- a/arch/powerpc/include/asm/eeh.h
>> +++ b/arch/powerpc/include/asm/eeh.h
>> @@ -219,6 +219,8 @@ struct eeh_ops {
>>  	int (*next_error)(struct eeh_pe **pe);
>>  	int (*restore_config)(struct pci_dn *pdn);
>>  	int (*notify_resume)(struct pci_dn *pdn);
>> +	int (*pause)(struct pci_bus *bus);
>> +	int (*resume)(struct pci_bus *bus);
>=20
> I think these names are a bit too generic, what about naming them
> pause_bus()/resume_bus() or even prepare_rescan()/rescan_done()?
>=20

Thanks! I will rename them to rescan_prepare/rescan_done to make friends
with reset_prepare/reset_done from struct pci_error_handlers.

>>  };
>> =20
>>  extern int eeh_subsystem_flags;
>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>> index 6ebba3e48b01..9fb5012f389d 100644
>> --- a/arch/powerpc/kernel/eeh.c
>> +++ b/arch/powerpc/kernel/eeh.c
>> @@ -1831,3 +1831,15 @@ static int __init eeh_init_proc(void)
>>  	return 0;
>>  }
>>  __initcall(eeh_init_proc);
>> +
>> +void pcibios_rescan_prepare(struct pci_bus *bus)
>> +{
>> +	if (eeh_ops && eeh_ops->pause)
>> +		eeh_ops->pause(bus);
>> +}
>> +
>> +void pcibios_rescan_done(struct pci_bus *bus)
>> +{
>> +	if (eeh_ops && eeh_ops->resume)
>> +		eeh_ops->resume(bus);
>> +}
>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/power=
pc/platforms/powernv/eeh-powernv.c
>> index 3c1beae29f2d..9724a58afcd2 100644
>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>> @@ -59,6 +59,26 @@ void pnv_pcibios_bus_add_device(struct pci_dev *pde=
v)
>>  	eeh_sysfs_add_device(pdev);
>>  }
>> =20
>> +static int pnv_eeh_pause(struct pci_bus *bus)
>> +{
>> +	struct pci_controller *hose =3D pci_bus_to_host(bus);
>> +	struct pnv_phb *phb =3D hose->private_data;
>> +
>> +	phb->flags &=3D ~PNV_PHB_FLAG_EEH;
>> +	disable_irq(eeh_event_irq);
>> +	return 0;
>> +}
>> +
>> +static int pnv_eeh_resume(struct pci_bus *bus)
>> +{
>> +	struct pci_controller *hose =3D pci_bus_to_host(bus);
>> +	struct pnv_phb *phb =3D hose->private_data;
>> +
>> +	enable_irq(eeh_event_irq);
>> +	phb->flags |=3D PNV_PHB_FLAG_EEH;
>> +	return 0;
>> +}
>> +
>>  static int pnv_eeh_init(void)
>>  {
>>  	struct pci_controller *hose;
>> @@ -1710,6 +1730,8 @@ static struct eeh_ops pnv_eeh_ops =3D {
>>  	.write_config           =3D pnv_eeh_write_config,
>>  	.next_error		=3D pnv_eeh_next_error,
>>  	.restore_config		=3D pnv_eeh_restore_config,
>> +	.pause			=3D pnv_eeh_pause,
>> +	.resume			=3D pnv_eeh_resume,
>>  	.notify_resume		=3D NULL
>>  };
>> =20
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index ac876e32de4b..4a9045364809 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2801,6 +2801,14 @@ void __weak pcibios_remove_bus(struct pci_bus *=
bus)
>>  {
>>  }
>> =20
>> +void __weak pcibios_rescan_prepare(struct pci_bus *bus)
>> +{
>> +}
>> +
>> +void __weak pcibios_rescan_done(struct pci_bus *bus)
>> +{
>> +}
>> +
>>  struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>>  		struct pci_ops *ops, void *sysdata, struct list_head *resources)
>>  {
>> @@ -3055,9 +3063,15 @@ unsigned int pci_rescan_bus_bridge_resize(struc=
t pci_dev *bridge)
>>  unsigned int pci_rescan_bus(struct pci_bus *bus)
>>  {
>>  	unsigned int max;
>> +	struct pci_bus *root =3D bus;
>> +
>> +	while (!pci_is_root_bus(root))
>> +		root =3D root->parent;
>> =20
>> +	pcibios_rescan_prepare(root);
>>  	max =3D pci_scan_child_bus(bus);
>>  	pci_assign_unassigned_bus_resources(bus);
>> +	pcibios_rescan_done(root);
>>  	pci_bus_add_devices(bus);
>> =20
>>  	return max;
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 340029b2fb38..42930731c5a7 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1929,6 +1929,8 @@ void pcibios_penalize_isa_irq(int irq, int activ=
e);
>>  int pcibios_alloc_irq(struct pci_dev *dev);
>>  void pcibios_free_irq(struct pci_dev *dev);
>>  resource_size_t pcibios_default_alignment(void);
>> +void pcibios_rescan_prepare(struct pci_bus *bus);
>> +void pcibios_rescan_done(struct pci_bus *bus);
>> =20
>>  #ifdef CONFIG_HIBERNATE_CALLBACKS
>>  extern struct dev_pm_ops pcibios_pm_ops;
>> --=20
>> 2.17.1
>>

Best regards,
Serge


--BuxwwyRtquxuFZ5p8jZikcRkIgLpeek74--

--lXKbvMeGiZmBJcnUzItKWsd2XBte1GsJp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEHW7T7ovP/cFp8+b3DHQ+aNFTs7UFAluWlTQACgkQDHQ+aNFT
s7UqDg//Yj9KDkuhvOQyuJV8nfh/T1o3yCuEPmpaO/XAdFHvNjbGNNjvvUAQuFYj
xxGWYSHH3BYMbGtz7BizYJVrGCUZ8UlPMR4iayaIDdKW0hPFQBFZwuVDkwslDMqT
B8zDfAmcugLh62qbqPP7ULMsW/M1FSllRP6jubY2iVUioG7jHv688kooXLz7sOEo
2U9bMEx8IdOKsNZN26K/RyMNxDLYK9YHU5TXrxWNwDsEsuCir5gvG+CCkfiaLU3N
0CyKziCgWdRZuc0hLGHiGIH5xf4VlB9eNnhO3vBr6IdkI3tlTtkkAHwRpt/rIW9/
VrswVKPJ6npRkKqZPYoRvZF4IkuGBT285fe9kUDHLhDt7LiUqULV+jYERyUdQcFx
wAjd9k67PqUI4AAzT2fmVNQrGvnvSRLSgNb07bpuZ1IqCtUSrQiYKPudH4in3+Yr
Z6abbKEJdzodkJaY5wNLnRykWTG+vEed7pHOBOc4OmQw64VCy1jRDacncnGnemaP
vGaI64miFdTIRVxQSDloBYW+Y0sohj/G5FugZLnnVHZZ99g602fH0fau1F9vKmgg
2x/KyBlgaefVtNNzLN06x6cG4utIV1Mjdi+m1Am29f+6zcT03K9kFvMPv6uYu3mQ
a9+HOGAstZeEeRZdwKUi4NTk55iMWJqMgV9dzGQM9BQdJ4vFvvs=
=sd1W
-----END PGP SIGNATURE-----

--lXKbvMeGiZmBJcnUzItKWsd2XBte1GsJp--
