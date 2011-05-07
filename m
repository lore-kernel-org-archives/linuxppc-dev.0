Return-Path: <B11780@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D059E1007E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  8 May 2011 02:21:23 +1000 (EST)
Subject: Re: [PATCH] PCI: portdrv: fix irq initialization on FSL pcie host
	controller
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1303977671.1642.742.camel@xulei-desktop>
Date: Sat, 7 May 2011 11:21:16 -0500
Message-ID: <E8D326F6-7E52-4A20-87B3-6C4CC34406C4@freescale.com>
References: <1303458219-31915-1-git-send-email-B33228@freescale.com>
	<1303977671.1642.742.camel@xulei-desktop>
To: Xu Lei <B33228@freescale.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 28, 2011, at 3:01 AM, Xu Lei wrote:

>=20
> 	Any feedback on this patch? Thanks.
>=20
> On Friday, 2011-04-22 at 15:43 +0800, Lei Xu wrote:
>> Root complex ports for Freescale PCIe host controller only receive
>> interrupts, so if there is no irq setting for RC, it should not =
return
>> error, otherwise it may result the PCIe host controller is disabled.
>>=20
>> Signed-off-by: Lei Xu <B33228@freescale.com>
>> ---
>> drivers/pci/pcie/portdrv_core.c |    5 ++++-
>> 1 files changed, 4 insertions(+), 1 deletions(-)
>>=20
>> diff --git a/drivers/pci/pcie/portdrv_core.c =
b/drivers/pci/pcie/portdrv_core.c
>> index 595654a..95e64c8 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -209,7 +209,10 @@ static int init_service_irqs(struct pci_dev =
*dev, int *irqs, int mask)
>> 		irqs[i] =3D irq;
>> 	irqs[PCIE_PORT_SERVICE_VC_SHIFT] =3D -1;
>>=20
>> -	if (irq < 0)
>> +	/* Root complex ports for Freescale PCIe host controller only
>> +	 * receive interrupts, so if there is no irq setting for RC,
>> +	 * it should not return error. */
>> +	if ((irq < 0) && (dev->pcie_type !=3D PCI_EXP_TYPE_ROOT_PORT))
>> 		return -ENODEV;
>> 	return 0;
>> }
>=20
> --=20
> Regards
>=20
> Lei
>=20

Reviewing this in more detail this is not the right solution.  We should =
have an dev->irq set and need to fix that.

The means to accomplish that is by fixing up the device tree to properly =
get the interrupt assigned to the root complex node.

- k=
