Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B0105B6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 08:41:49 +1100 (EST)
Message-ID: <1329946899.20389.9.camel@pasglop>
Subject: Re: [PATCH v1 09/11] powerpc/PCI: replace pci_probe_only with
 pci_flags
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 23 Feb 2012 08:41:39 +1100
In-Reply-To: <20120222181948.27513.96215.stgit@bhelgaas.mtv.corp.google.com>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
 <20120222181948.27513.96215.stgit@bhelgaas.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-02-22 at 11:19 -0700, Bjorn Helgaas wrote:
>  int maple_pci_get_legacy_ide_irq(struct pci_dev *pdev, int channel)
> diff --git a/arch/powerpc/platforms/pasemi/pci.c
> b/arch/powerpc/platforms/pasemi/pci.c
> index b6a0ec4..b27d886 100644
> --- a/arch/powerpc/platforms/pasemi/pci.c
> +++ b/arch/powerpc/platforms/pasemi/pci.c
> @@ -231,7 +231,7 @@ void __init pas_pci_init(void)
>         pci_devs_phb_init();
>  
>         /* Use the common resource allocation mechanism */
> -       pci_probe_only = 1;
> +       pci_add_flags(PCI_PROBE_ONLY);
>  }

Olof, do you remember why you used to set that on pasemi ?

I would have expected it to be clear, so the kernel can re-assign things
if needed. We really only want it set for pseries because of the
hypervisor being a PITA :-)

Cheers,
Ben.
