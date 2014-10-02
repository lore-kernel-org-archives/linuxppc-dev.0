Return-Path: <bhelgaas@google.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F2581A1806
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 01:34:08 +1000 (EST)
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E325B140161
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2014 01:34:07 +1000 (EST)
Received: by mail-pa0-f43.google.com with SMTP id lf10so2697399pab.30
 for <linuxppc-dev@ozlabs.org>; Thu, 02 Oct 2014 08:34:06 -0700 (PDT)
Date: Thu, 2 Oct 2014 09:34:02 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 2/4] gpu/radeon: Move 64-bit MSI quirk from arch to
 driver
Message-ID: <20141002153402.GC18056@google.com>
References: <1412210062.10667.1.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412210062.10667.1.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Anton Blanchard <anton@au1.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, Yijing Wang <wangyijing@huawei.com>,
 Takashi Iwai <tiwai@suse.de>, Alex Deucher <alexdeucher@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 02, 2014 at 10:34:22AM +1000, Benjamin Herrenschmidt wrote:
> 
> A number of radeon cards have a HW limitation causing them to be
> unable to generate the full 64-bit of address bits for MSIs. This
> breaks MSIs on some platforms such as POWER machines.
> 
> We used to have a powerpc specific quirk to address that on a
> single card, but this doesn't scale very well, this is better
> put under control of the drivers who know precisely what a given
> HW revision can do.
> 
> This moves the setting of the quirk flag to the radeon driver
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> v2: This is just adjusted to the new flag name

I'm sorta confused because I got two "v2 2/4" emails a minute or so apart.
I assume they're the same.

> 
>  arch/powerpc/kernel/pci_64.c            |  1 -
>  drivers/gpu/drm/radeon/radeon_irq_kms.c | 10 ++++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index d41a831..5330f6d 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -271,5 +271,4 @@ static void quirk_radeon_32bit_msi(struct pci_dev *dev)
>  {
>  	dev->no_64bit_msi = true;
>  }
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x68f2, quirk_radeon_32bit_msi);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0xaa68, quirk_radeon_32bit_msi);

Why do we keep the 0xaa68 quirk?  Shouldn't that be made generic, too?

> diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
> index 16807af..e760671 100644
> --- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
> @@ -202,6 +202,16 @@ static bool radeon_msi_ok(struct radeon_device *rdev)
>  	if (rdev->flags & RADEON_IS_AGP)
>  		return false;
>  
> +	/*
> +	 * Older chips have a HW limitation, they can only generate 40 bits
> +	 * of address for "64-bit" MSIs which breaks on some platforms, notably
> +	 * IBM POWER servers, so we limit them
> +	 */
> +	if (rdev->family < CHIP_BONAIRE) {
> +		dev_info(rdev->dev, "radeon: MSI limited to 32-bit\n");
> +		rdev->pdev->no_64bit_msi = true;
> +	}
> +
>  	/* force MSI on */
>  	if (radeon_msi == 1)
>  		return true;
> 
> 
> 
