Return-Path: <bhelgaas@google.com>
Received: from mail-oa0-f41.google.com (mail-oa0-f41.google.com
 [209.85.219.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 476B02C018D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2013 07:24:33 +1100 (EST)
Received: by mail-oa0-f41.google.com with SMTP id f4so4391967oah.28
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2013 13:24:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201304042158.r34LwGPg010714@d03av02.boulder.ibm.com>
References: <201304042158.r34LwGPg010714@d03av02.boulder.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 5 Apr 2013 14:24:09 -0600
Message-ID: <CAErSpo4LsJjRkw6UektwqW8m1NXdU6BTjhTDA9eORM3z3qDcdA@mail.gmail.com>
Subject: Re: [PATCH 3/3] powerpc: Set default VGA device
To: Brian King <brking@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 klebers <klebers@linux.vnet.ibm.com>,
 Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
 sparclinux@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 4, 2013 at 3:58 PM, Brian King <brking@linux.vnet.ibm.com> wrote:
>
> Add a PCI quirk for VGA devices on Power to set the default VGA device.
> Ensures a default VGA is always set if a graphics adapter is present,
> even if firmware did not initialize it. If more than one graphics
> adapter is present, ensure the one initialized by firmware is set
> as the default VGA device. This ensures that X autoconfiguration
> will work.
>
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
>
>  arch/powerpc/kernel/pci-common.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff -puN arch/powerpc/kernel/pci-common.c~powerpc_vga_default_device arch/powerpc/kernel/pci-common.c
> --- linux/arch/powerpc/kernel/pci-common.c~powerpc_vga_default_device   2013-04-03 09:50:33.000000000 -0500
> +++ linux-bjking1/arch/powerpc/kernel/pci-common.c      2013-04-03 09:50:33.000000000 -0500
> @@ -30,6 +30,7 @@
>  #include <linux/irq.h>
>  #include <linux/vmalloc.h>
>  #include <linux/slab.h>
> +#include <linux/vgaarb.h>
>
>  #include <asm/processor.h>
>  #include <asm/io.h>
> @@ -1725,3 +1726,15 @@ static void fixup_hide_host_resource_fsl
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_hide_host_resource_fsl);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_hide_host_resource_fsl);
> +
> +static void fixup_vga(struct pci_dev *pdev)
> +{
> +       u16 cmd;
> +
> +       pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +       if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !vga_default_device())
> +               vga_set_default_device(pdev);
> +
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
> +                             PCI_CLASS_DISPLAY_VGA, 8, fixup_vga);

This not really an arch-specific issue, so it's a shame to add another
arch-specific quirk for it (in addition to the x86 and ia64 ones we
already have).

In b5e4efe7e0, Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com> tried to
make this quirk generic, but the implementation was naive and it
didn't work for sparc64.  There's a good thread about the sparc issue
at https://lkml.org/lkml/2006/10/19/17

The outcome was to basically revert back to arch-specific quirks with
6b5c76b8e2, but I think the generic version probably could have been
made to work, possibly with a pcibios hook or something for anything
that really is arch-dependent, like the shadowed ROM image.

This particular patch is arch-specific, and I'm not going to try to
nack it because I'm not the powerpc maintainer, but I will certainly
try to help you if you want to push on making a generic version.

Bjorn
