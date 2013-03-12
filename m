Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 74CEC2C008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 07:48:05 +1100 (EST)
Subject: Re: [PATCH] Make PCIe hotplug work with Freescale PCIe controllers
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <92335390-A05A-4E1D-9D07-A69896768A57@kernel.crashing.org>
Date: Tue, 12 Mar 2013 15:48:01 -0500
Message-Id: <B392DAB5-F9A7-4B1A-8CAE-015CA5AC2C33@kernel.crashing.org>
References: <3989200.gO920IVs04@pcimr>
 <179EA411-594D-4774-903A-6C0445A01747@kernel.crashing.org>
 <2399353.017i5G1tnZ@pcimr>
 <92335390-A05A-4E1D-9D07-A69896768A57@kernel.crashing.org>
To: Rojhalat Ibrahim <imr@rtschenk.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 12, 2013, at 3:44 PM, Kumar Gala wrote:

>=20
> On Mar 12, 2013, at 4:23 AM, Rojhalat Ibrahim wrote:
>=20
>> On Monday 11 March 2013 12:17:42 Kumar Gala wrote:
>>>=20
>>> Rather than do it this way, we should do something like:
>>>=20
>>> fsl_indirect_read_config() {
>>> 	link check
>>> 	if (link)
>>> 		indirect_read_config()
>>> }
>>>=20
>>> and just add fsl_indirect_{r,w}_config into fsl_pci.c
>>>=20
>>> - k
>>>=20
>>=20
>> Ok, how about this:
>>=20
>=20
> I'd rather we just export indirect_read_config() & =
indirect_write_config() from indirect_pci.c and call the functions =
directly.  Adding a global and call them via a function pointer seems =
wrong to me.
>=20
> - k

Also, can you base this patch on my powerpc.git next branch as =
fsl_pci.{c,h} have some changes in them.

- k

>=20
>>=20
>> Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>
>> ---
>> arch/powerpc/sysdev/fsl_pci.c |   49=20
>> ++++++++++++++++++++++++++++++++++++++----
>> 1 file changed, 45 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/arch/powerpc/sysdev/fsl_pci.c =
b/arch/powerpc/sysdev/fsl_pci.c
>> index 682084d..693db9f 100644
>> --- a/arch/powerpc/sysdev/fsl_pci.c
>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>> @@ -36,6 +36,8 @@
>>=20
>> static int fsl_pcie_bus_fixup, is_mpc83xx_pci;
>>=20
>> +static struct pci_ops *indirect_pci_ops;
>> +
>> static void quirk_fsl_pcie_header(struct pci_dev *dev)
>> {
>> 	u8 hdr_type;
>> @@ -64,6 +66,45 @@ static int __init fsl_pcie_check_link(struct =
pci_controller=20
>> *hose)
>> 	return 0;
>> }
>>=20
>> +static int fsl_indirect_read_config(struct pci_bus *bus, unsigned =
int devfn,
>> +				    int offset, int len, u32 *val)
>> +{
>> +	struct pci_controller *hose =3D pci_bus_to_host(bus);
>> +=09
>> +	// check the link status
>> +	if ((bus->number =3D=3D hose->first_busno) && (devfn =3D=3D 0)) =
{
>> +		u32 ltssm =3D 0;
>> +		indirect_pci_ops->read(bus, 0, PCIE_LTSSM, 4, &ltssm);
>> +		if (ltssm < PCIE_LTSSM_L0) {
>> +			hose->indirect_type |=3D =
PPC_INDIRECT_TYPE_NO_PCIE_LINK;
>> +		} else {
>> +			hose->indirect_type &=3D =
~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
>> +		}
>> +	}
>> +	return indirect_pci_ops->read(bus, devfn, offset, len, val);
>> +}
>> +
>> +static int fsl_indirect_write_config(struct pci_bus *bus, unsigned =
int devfn,
>> +				     int offset, int len, u32 val)
>> +{
>> +	return indirect_pci_ops->write(bus, devfn, offset, len, val);
>> +}
>> +
>> +static struct pci_ops fsl_indirect_pci_ops =3D
>> +{
>> +	.read =3D fsl_indirect_read_config,
>> +	.write =3D fsl_indirect_write_config,
>> +};
>> +
>> +static void __init fsl_setup_indirect_pci(struct pci_controller* =
hose,
>> +					  resource_size_t cfg_addr,
>> +					  resource_size_t cfg_data, u32 =
flags)
>> +{
>> +	setup_indirect_pci(hose, cfg_addr, cfg_data, flags);
>> +	indirect_pci_ops =3D hose->ops;
>> +	hose->ops =3D &fsl_indirect_pci_ops;
>> +}
>> +
>> #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
>>=20
>> #define MAX_PHYS_ADDR_BITS	40
>> @@ -461,8 +502,8 @@ int __init fsl_add_bridge(struct platform_device =
*pdev,=20
>> int is_primary)
>> 	hose->first_busno =3D bus_range ? bus_range[0] : 0x0;
>> 	hose->last_busno =3D bus_range ? bus_range[1] : 0xff;
>>=20
>> -	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
>> -		PPC_INDIRECT_TYPE_BIG_ENDIAN);
>> +	fsl_setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
>> +			       PPC_INDIRECT_TYPE_BIG_ENDIAN);
>>=20
>> 	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
>> 		/* For PCIE read HEADER_TYPE to identify controler mode =
*/
>> @@ -766,8 +807,8 @@ int __init mpc83xx_add_bridge(struct device_node =
*dev)
>> 		if (ret)
>> 			goto err0;
>> 	} else {
>> -		setup_indirect_pci(hose, rsrc_cfg.start,
>> -				   rsrc_cfg.start + 4, 0);
>> +		fsl_setup_indirect_pci(hose, rsrc_cfg.start,
>> +				       rsrc_cfg.start + 4, 0);
>> 	}
>>=20
>> 	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
>>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
