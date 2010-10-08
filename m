Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0144B70DE
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 07:20:44 +1100 (EST)
Subject: Re: [PATCH 03/11] powerpc/fsl-booke: Add PCI device ids for
	P2040/P3041/P5010/P5020 QoirQ chips
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AANLkTimRGqcDOeR92m0CQZHTxSNSm=D8sZni0zw-He11@mail.gmail.com>
Date: Fri, 8 Oct 2010 15:20:33 -0500
Message-Id: <E17429EB-2F31-4E72-8CD6-5B933F512CEE@kernel.crashing.org>
References: <1286564813-21209-1-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-2-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-3-git-send-email-galak@kernel.crashing.org>
	<AANLkTimRGqcDOeR92m0CQZHTxSNSm=D8sZni0zw-He11@mail.gmail.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 8, 2010, at 2:28 PM, Timur Tabi wrote:

> On Fri, Oct 8, 2010 at 2:06 PM, Kumar Gala <galak@kernel.crashing.org> =
wrote:
>=20
>> diff --git a/arch/powerpc/sysdev/fsl_pci.c =
b/arch/powerpc/sysdev/fsl_pci.c
>> index 32012a2..4d0b249 100644
>> --- a/arch/powerpc/sysdev/fsl_pci.c
>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>> @@ -417,10 +417,18 @@ DECLARE_PCI_FIXUP_HEADER(0x1957, =
PCI_DEVICE_ID_P2010E, quirk_fsl_pcie_header);
>>  DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2010, =
quirk_fsl_pcie_header);
>>  DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2020E, =
quirk_fsl_pcie_header);
>>  DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2020, =
quirk_fsl_pcie_header);
>> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2040E, =
quirk_fsl_pcie_header);
>> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2040, =
quirk_fsl_pcie_header);
>> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P3041E, =
quirk_fsl_pcie_header);
>> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P3041, =
quirk_fsl_pcie_header);
>>  DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4040E, =
quirk_fsl_pcie_header);
>>  DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4040, =
quirk_fsl_pcie_header);
>>  DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4080E, =
quirk_fsl_pcie_header);
>>  DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4080, =
quirk_fsl_pcie_header);
>> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5010E, =
quirk_fsl_pcie_header);
>> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5010, =
quirk_fsl_pcie_header);
>> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5020E, =
quirk_fsl_pcie_header);
>> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5020, =
quirk_fsl_pcie_header);
>=20
> Do we really need to add an entry for each new chip?  This table now
> has almost three dozen entries, and they all same the same thing.
> Can't we just assume that if the vendor ID is 0x1957, that we should
> default to quirk_fsl_pcie_header unless there's another entry
> somewhere else?

Unfortunately we can't assume if 0x1957 is other FSL devices that are =
not PPC SoC would use that Vendor ID.

I'll ponder if we can handle this some other more generic way to do =
detection, but for now we'll keep adding to the list.

- k=
