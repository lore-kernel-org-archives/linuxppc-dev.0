Return-Path: <ben.c@servergy.com>
Received: from exprod6og114.obsmtp.com (exprod6og114.obsmtp.com [64.18.1.33])
 by ozlabs.org (Postfix) with SMTP id 9F0A6B6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 09:35:56 +1000 (EST)
Received: by dadv36 with SMTP id v36so13156dad.41
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jun 2012 16:35:53 -0700 (PDT)
Subject: Re: [PATCH] PPC: PCI: Fix pcibios_io_space_offset() so it works for
 32-bit ptr/64-bit rsrcs
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Ben Collins <ben.c@servergy.com>
In-Reply-To: <4FCFC870.40004@freescale.com>
Date: Wed, 6 Jun 2012 19:35:51 -0400
Message-Id: <16AB27C3-8709-4A7C-AFFE-42A0B658AC1D@servergy.com>
References: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
 <4FCFC870.40004@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 6, 2012, at 5:15 PM, Scott Wood wrote:

> On 06/05/2012 10:50 PM, Ben Collins wrote:
>> The commit introducing pcibios_io_space_offset() was ignoring 32-bit =
to
>> 64-bit sign extention, which is the case on ppc32 with 64-bit =
resource
>> addresses. This only seems to have shown up while running under QEMU =
for
>> e500mc target. It may or may be suboptimal that QEMU has an IO base
>> address > 32-bits for the e500-pci implementation, but 1) it's still =
a
>> regression and 2) it's more correct to handle things this way.
>=20
> Where do you see addresses over 32 bits in QEMU's e500-pci, at least
> with current mainline QEMU and the mpc8544ds model?
>=20
> I/O space should be at 0xe1000000.

The problem is this:

pci_bus 0000:00: root bus resource [io  0xffbed000-0xffbfcfff] (bus =
address [0x100000000-0x10000ffff])

Without the fix that I sent, it ends up looking like:

pci_bus 0000:00: root bus resource [io  0xffbed000-0xffbfcfff] (bus =
address [0x0000-0xffff])

And that's when some devices fail to be assigned valid bar 0's and the =
kernel complains because of it.

> I'm also not sure what this has to do with the virtual address =
returned
> by ioremap().
>=20
>> Signed-off-by: Ben Collins <bcollins@ubuntu.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> ---
>> arch/powerpc/kernel/pci-common.c |    8 +++++++-
>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/powerpc/kernel/pci-common.c =
b/arch/powerpc/kernel/pci-common.c
>> index 8e78e93..be9ced7 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -1477,9 +1477,15 @@ int pcibios_enable_device(struct pci_dev *dev, =
int mask)
>> 	return pci_enable_resources(dev, mask);
>> }
>>=20
>> +/* Before assuming too much here, take care to realize that we need =
sign
>> + * extension from 32-bit pointers to 64-bit resource addresses to =
work.
>> + */
>> resource_size_t pcibios_io_space_offset(struct pci_controller *hose)
>> {
>> -	return (unsigned long) hose->io_base_virt - _IO_BASE;
>> +	long vbase =3D (long)hose->io_base_virt;
>> +	long io_base =3D _IO_BASE;
>> +
>> +	return (resource_size_t)(vbase - io_base);
>=20
> Why do we want sign extension here?
>=20
> If we do want it, there are a lot of other places in this file where =
the
> same calculation is done.
>=20
> -Scott
>=20

--
Ben Collins
Servergy, Inc.
(757) 243-7557

CONFIDENTIALITY NOTICE: This communication contains privileged and/or =
confidential information; and should be maintained with the strictest =
confidence. It is intended solely for the use of the person or entity in =
which it is addressed. If you are not the intended recipient, you are =
STRICTLY PROHIBITED from disclosing, copying, distributing or using any =
of this information. If you received this communication in error, please =
contact the sender immediately and destroy the material in its entirety, =
whether electronic or hard copy.
