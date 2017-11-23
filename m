Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjKwR4cR0zDr5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 00:31:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org,
 Bjorn Helgaas  <bhelgaas@google.com>
Subject: Re: [PATCH] SB600 for the Nemo board has non-zero devices on non-root
 bus
In-Reply-To: <f3513294-6da0-456f-0f98-1f8c3bac90c9@xenosoft.de>
References: <f3513294-6da0-456f-0f98-1f8c3bac90c9@xenosoft.de>
Date: Fri, 24 Nov 2017 00:31:18 +1100
Message-ID: <87tvxl15qx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christian,

Thanks for your patch.

Christian Zigotzky <chzigotzky@xenosoft.de> writes:
> Hi All,
>
> Just a small patch for the P.A. Semi Nemo board:
>
> -----
>
> diff -rupN a/drivers/pci/probe.c b/drivers/pci/probe.c
> --- a/drivers/pci/probe.c=C2=A0=C2=A0=C2=A0 2017-11-16 08:18:40.504012010=
 +0100
> +++ b/drivers/pci/probe.c=C2=A0=C2=A0=C2=A0 2017-11-16 08:17:22.044368405=
 +0100
> @@ -2219,6 +2219,8 @@ static int only_one_child(struct pci_bus

As this is a patch to the PCI code I can't merge it via the powerpc
tree. You would need to send it to linux-pci@vger.kernel.org.

>
>  =C2=A0=C2=A0=C2=A0=C2=A0 if (!parent || !pci_is_pcie(parent))
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return 0;
> +=C2=A0=C2=A0=C2=A0 #ifndef CONFIG_PPC_PASEMI_NEMO
> +=C2=A0=C2=A0=C2=A0 // SB600 for the Nemo board has non-zero devices on n=
on-root bus.
>  =C2=A0=C2=A0=C2=A0=C2=A0 if (pci_pcie_type(parent) =3D=3D PCI_EXP_TYPE_R=
OOT_PORT)
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return 1;
>
> @@ -2231,6 +2233,7 @@ static int only_one_child(struct pci_bus
>  =C2=A0=C2=A0=C2=A0=C2=A0 if (parent->has_secondary_link &&
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 !pci_has_flag(PCI_SCAN_ALL_P=
CIE_DEVS))
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return 1;
> +=C2=A0=C2=A0=C2=A0 #endif

But the PCI maintainer is not going to accept a patch like this, which
adds a platform specific #ifdef in core code like this.

If you look at the rest of that file I don't think you'll find a single
#ifdef other than for generic configuration symbols.

Are you sure the PCI_SCAN_ALL_PCIE_DEVS logic doesn't work for you? It
sounds like it was added for exactly this problem.

cheers
