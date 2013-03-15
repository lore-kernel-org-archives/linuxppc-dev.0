Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 594EC2C0079
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 02:52:59 +1100 (EST)
Subject: Re: [PATCH V2] powerpc/85xx: workaround for chips with MSI hardware
 errata
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01C18FB3@039-SN1MPN1-003.039d.mgd.msft.net>
Date: Fri, 15 Mar 2013 10:52:57 -0500
Message-Id: <15F68699-A225-4103-BE64-36554493C405@kernel.crashing.org>
References: <1363257323-2801-1-git-send-email-hongtao.jia@freescale.com>
 <6844A08B-8711-47AE-ACF1-9FAC23460710@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01C18FB3@039-SN1MPN1-003.039d.mgd.msft.net>
To: Jia Hongtao-B38951 <B38951@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 14, 2013, at 9:00 PM, Jia Hongtao-B38951 wrote:

>=20
>=20
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Friday, March 15, 2013 4:05 AM
>> To: Jia Hongtao-B38951
>> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421;
>> michael@ellerman.id.au; Li Yang-R58472; Jia Hongtao-B38951
>> Subject: Re: [PATCH V2] powerpc/85xx: workaround for chips with MSI
>> hardware errata
>>=20
>>=20
>> On Mar 14, 2013, at 5:35 AM, Jia Hongtao wrote:
>>=20
>>> The MPIC version 2.0 has a MSI errata (errata PIC1 of mpc8544), It
>>> causes that neither MSI nor MSI-X can work fine. This is a =
workaround
>>> to allow MSI-X to function properly.
>>>=20
>>> Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
>>> ---
>>> Changes for V2:
>>> - Address almost all the comments from Michael Ellerman for V1.
>>> Here is the link:
>>> http://patchwork.ozlabs.org/patch/226833/
>>>=20
>>> arch/powerpc/sysdev/fsl_msi.c | 65
>>> +++++++++++++++++++++++++++++++++++++++++--
>>> arch/powerpc/sysdev/fsl_msi.h |  2 ++
>>> 2 files changed, 64 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/arch/powerpc/sysdev/fsl_msi.c
>>> b/arch/powerpc/sysdev/fsl_msi.c index 178c994..54cb83e 100644
>>> --- a/arch/powerpc/sysdev/fsl_msi.c
>>> +++ b/arch/powerpc/sysdev/fsl_msi.c
>>> @@ -98,8 +98,18 @@ static int fsl_msi_init_allocator(struct fsl_msi
>>> *msi_data)
>>>=20
>>> static int fsl_msi_check_device(struct pci_dev *pdev, int nvec, int
>>> type) {
>>> -	if (type =3D=3D PCI_CAP_ID_MSIX)
>>> -		pr_debug("fslmsi: MSI-X untested, trying anyway.\n");
>>> +	struct fsl_msi *msi;
>>> +
>>> +	if (type =3D=3D PCI_CAP_ID_MSI) {
>>> +		/*
>>> +		 * MPIC version 2.0 has erratum PIC1. For now MSI
>>> +		 * could not work. So check to prevent MSI from
>>> +		 * being used on the board with this erratum.
>>> +		 */
>>> +		list_for_each_entry(msi, &msi_head, list)
>>> +			if (msi->feature & MSI_HW_ERRATA_ENDIAN)
>>> +				return -EINVAL;
>>> +	}
>>>=20
>>> 	return 0;
>>> }
>>> @@ -142,7 +152,17 @@ static void fsl_compose_msi_msg(struct pci_dev
>> *pdev, int hwirq,
>>> 	msg->address_lo =3D lower_32_bits(address);
>>> 	msg->address_hi =3D upper_32_bits(address);
>>>=20
>>> -	msg->data =3D hwirq;
>>> +	/*
>>> +	 * MPIC version 2.0 has erratum PIC1. It causes
>>> +	 * that neither MSI nor MSI-X can work fine.
>>> +	 * This is a workaround to allow MSI-X to function
>>> +	 * properly. It only works for MSI-X, we prevent
>>> +	 * MSI on buggy chips in fsl_msi_check_device().
>>> +	 */
>>> +	if (msi_data->feature & MSI_HW_ERRATA_ENDIAN)
>>> +		msg->data =3D __swab32(hwirq);
>>> +	else
>>> +		msg->data =3D hwirq;
>>>=20
>>> 	pr_debug("%s: allocated srs: %d, ibs: %d\n",
>>> 		__func__, hwirq / IRQS_PER_MSI_REG, hwirq % =
IRQS_PER_MSI_REG);
>> @@
>>> -361,6 +381,35 @@ static int fsl_msi_setup_hwirq(struct fsl_msi =
*msi,
>> struct platform_device *dev,
>>> 	return 0;
>>> }
>>>=20
>>> +/* MPIC version 2.0 has erratum PIC1 */ static int
>>> +mpic_has_errata(struct platform_device *dev) {
>>> +	struct device_node *mpic_node;
>>> +
>>> +	mpic_node =3D of_irq_find_parent(dev->dev.of_node);
>>> +	if (mpic_node) {
>>> +		u32 *reg_base, brr1 =3D 0;
>>> +		/* Get the PIC reg base */
>>> +		reg_base =3D of_iomap(mpic_node, 0);
>>> +		of_node_put(mpic_node);
>>> +		if (!reg_base) {
>>> +			dev_err(&dev->dev, "ioremap problem failed.\n");
>>> +			return -EIO;
>>> +		}
>>> +
>>> +		/* Get the mpic version from block revision register 1 =
*/
>>> +		brr1 =3D in_be32(reg_base + MPIC_FSL_BRR1);
>>> +		iounmap(reg_base);
>>> +		if ((brr1 & MPIC_FSL_BRR1_VER) =3D=3D 0x0200)
>>> +			return 1;
>>> +	} else {
>>> +		dev_err(&dev->dev, "MSI can't find his parent mpic =
node.\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> static const struct of_device_id fsl_of_msi_ids[]; static int
>>> fsl_of_msi_probe(struct platform_device *dev) { @@ -423,6 +472,16 @@
>>> static int fsl_of_msi_probe(struct platform_device *dev)
>>>=20
>>> 	msi->feature =3D features->fsl_pic_ip;
>>>=20
>>> +	if ((features->fsl_pic_ip & FSL_PIC_IP_MASK) =3D=3D =
FSL_PIC_IP_MPIC) {
>>> +		rc =3D mpic_has_errata(dev);
>>> +		if (rc > 0) {
>>> +			msi->feature |=3D MSI_HW_ERRATA_ENDIAN;
>>> +		} else if (rc < 0) {
>>> +			err =3D rc;
>>> +			goto error_out;
>>> +		}
>>> +	}
>>> +
>>> 	/*
>>> 	 * Remember the phandle, so that we can match with any PCI nodes
>>> 	 * that have an "fsl,msi" property.
>>> diff --git a/arch/powerpc/sysdev/fsl_msi.h
>>> b/arch/powerpc/sysdev/fsl_msi.h index 8225f86..7389e8e 100644
>>> --- a/arch/powerpc/sysdev/fsl_msi.h
>>> +++ b/arch/powerpc/sysdev/fsl_msi.h
>>> @@ -25,6 +25,8 @@
>>> #define FSL_PIC_IP_IPIC   0x00000002
>>> #define FSL_PIC_IP_VMPIC  0x00000003
>>>=20
>>> +#define MSI_HW_ERRATA_ENDIAN 0x00000010
>>> +
>>=20
>> Is there any reason to put this in fsl_msi.h rather than just in
>> fsl_msi.c itself?
>>=20
>> - k
>=20
> Actually no. This micro is only used by fsl_msi.c.
> Will move it to fsl_msi.c.
>=20
> Thanks.
> -Hongtao.

Also, wondering if we can do the mpic version detection in mpic.c and =
not here.  I'm not sure what means we'd have to get back to the mpic =
struct so we could possible use mpic->flags.

I'll look to see if I can suggest anything along those lines, thus =
reducing the amount of ioremap() and code to find the mpic registers, =
etc.

- k=
