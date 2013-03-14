Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5333A2C00B9
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Mar 2013 07:35:39 +1100 (EST)
Subject: Re: [RFC][PATCH 2/2] powerpc/fsl-pci Make PCIe hotplug work with
 Freescale
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4166754.n4Zsp0OSQ4@pcimr>
Date: Thu, 14 Mar 2013 15:35:40 -0500
Message-Id: <677E5CC0-EC8D-4DB5-B9E3-F4E4D39EEF59@kernel.crashing.org>
References: <1363201636-7318-1-git-send-email-galak@kernel.crashing.org>
 <1363201636-7318-2-git-send-email-galak@kernel.crashing.org>
 <4166754.n4Zsp0OSQ4@pcimr>
To: Rojhalat Ibrahim <imr@rtschenk.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 14, 2013, at 4:43 AM, Rojhalat Ibrahim wrote:

> On Wednesday 13 March 2013 14:07:16 Kumar Gala wrote:
>> diff --git a/arch/powerpc/sysdev/fsl_pci.c =
b/arch/powerpc/sysdev/fsl_pci.c
>> index 41bbcc4..b18c377 100644
>> --- a/arch/powerpc/sysdev/fsl_pci.c
>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>> @@ -74,6 +74,35 @@ static int __init fsl_pcie_check_link(struct
>> pci_controller *hose) return 0;
>> }
>>=20
>> +static int fsl_indirect_read_config(struct pci_bus *bus, unsigned =
int
>> devfn, +				    int offset, int len, u32 =
*val)
>> +{
>> +	struct pci_controller *hose =3D pci_bus_to_host(bus);
>> +
>> +	/* check the link status */
>> +	if ((bus->number =3D=3D hose->first_busno) && (devfn =3D=3D 0)) =
{
>> +		if (fsl_pcie_check_link(hose))
>> +			hose->indirect_type |=3D =
PPC_INDIRECT_TYPE_NO_PCIE_LINK;
>> +		else
>> +			hose->indirect_type &=3D =
~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
>> +	}
>> +	return indirect_read_config(bus, devfn, offset, len, val);
>> +}
>> +
>=20
> This does not work because fsl_indirect_read_config calls =
fsl_pcie_check_link which calls early_read_config_dword which eventually =
calls fsl_indirect_read_config, so the kernel hangs in a recursion loop. =
Below is a modified patch that does work.

ok, that makes sense, but I guess now its making me question the =
following statement:

> if ((bus->number =3D=3D hose->first_busno) && (devfn =3D=3D 0)) {

Why do we have this conditional?

- k=
