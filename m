Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-f194.google.com (mail-ot0-f194.google.com
 [74.125.82.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BxDF2ZWkzF0Vt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 21:29:16 +1000 (AEST)
Received: by mail-ot0-f194.google.com with SMTP id 92-v6so7115843otw.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 04:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180322202007.23088-8-malat@debian.org>
 <20180328193935.1338-1-malat@debian.org>
In-Reply-To: <20180328193935.1338-1-malat@debian.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 22 Jun 2018 13:29:03 +0200
Message-ID: <CA+7wUsxL=r6hip9hwt9xsrFYAZeqqFBmf89N37sPVeMdOsJjGw@mail.gmail.com>
Subject: Re: [PATCH v2 07/19] powerpc/powermac: Make some functions static
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This one should also be good to go.

On Wed, Mar 28, 2018 at 9:39 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> These functions can all be static, make it so. Fix warnings treated as
> errors with W=3D1:
>
>   arch/powerpc/platforms/powermac/pci.c:1022:6: error: no previous protot=
ype for =E2=80=98pmac_pci_fixup_ohci=E2=80=99 [-Werror=3Dmissing-prototypes=
]
>   arch/powerpc/platforms/powermac/pci.c:1057:6: error: no previous protot=
ype for =E2=80=98pmac_pci_fixup_cardbus=E2=80=99 [-Werror=3Dmissing-prototy=
pes]
>   arch/powerpc/platforms/powermac/pci.c:1094:6: error: no previous protot=
ype for =E2=80=98pmac_pci_fixup_pciata=E2=80=99 [-Werror=3Dmissing-prototyp=
es]
>
> Remove has_address declaration and assignment since not used. Also add gc=
c
> attribute unused to fix a warning treated as error with W=3D1:
>
>   arch/powerpc/platforms/powermac/pci.c:784:19: error: variable =E2=80=98=
has_address=E2=80=99 set but not used [-Werror=3Dunused-but-set-variable]
>   arch/powerpc/platforms/powermac/pci.c:907:22: error: variable =E2=80=98=
ht=E2=80=99 set but not used [-Werror=3Dunused-but-set-variable]
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: remove has_address variable since not used
>  arch/powerpc/platforms/powermac/pci.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platfor=
ms/powermac/pci.c
> index 0b8174a79993..67c497093e0a 100644
> --- a/arch/powerpc/platforms/powermac/pci.c
> +++ b/arch/powerpc/platforms/powermac/pci.c
> @@ -781,12 +781,12 @@ static int __init pmac_add_bridge(struct device_nod=
e *dev)
>         struct resource rsrc;
>         char *disp_name;
>         const int *bus_range;
> -       int primary =3D 1, has_address =3D 0;
> +       int primary =3D 1;
>
>         DBG("Adding PCI host bridge %pOF\n", dev);
>
>         /* Fetch host bridge registers address */
> -       has_address =3D (of_address_to_resource(dev, 0, &rsrc) =3D=3D 0);
> +       of_address_to_resource(dev, 0, &rsrc);
>
>         /* Get bus range if any */
>         bus_range =3D of_get_property(dev, "bus-range", &len);
> @@ -904,7 +904,7 @@ static int pmac_pci_root_bridge_prepare(struct pci_ho=
st_bridge *bridge)
>  void __init pmac_pci_init(void)
>  {
>         struct device_node *np, *root;
> -       struct device_node *ht =3D NULL;
> +       struct device_node *ht __maybe_unused =3D NULL;
>
>         pci_set_flags(PCI_CAN_SKIP_ISA_ALIGN);
>
> @@ -1019,7 +1019,7 @@ static bool pmac_pci_enable_device_hook(struct pci_=
dev *dev)
>         return true;
>  }
>
> -void pmac_pci_fixup_ohci(struct pci_dev *dev)
> +static void pmac_pci_fixup_ohci(struct pci_dev *dev)
>  {
>         struct device_node *node =3D pci_device_to_OF_node(dev);
>
> @@ -1054,7 +1054,7 @@ void __init pmac_pcibios_after_init(void)
>         }
>  }
>
> -void pmac_pci_fixup_cardbus(struct pci_dev* dev)
> +static void pmac_pci_fixup_cardbus(struct pci_dev *dev)
>  {
>         if (!machine_is(powermac))
>                 return;
> @@ -1091,7 +1091,7 @@ void pmac_pci_fixup_cardbus(struct pci_dev* dev)
>
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TI, PCI_ANY_ID, pmac_pci_fixup_car=
dbus);
>
> -void pmac_pci_fixup_pciata(struct pci_dev* dev)
> +static void pmac_pci_fixup_pciata(struct pci_dev *dev)
>  {
>         u8 progif =3D 0;
>
> --
> 2.11.0
>
