Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xghf240V1zDqF7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 16:27:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel 5/5] powerpc/eeh: Remove unnecessary node from
 pci_dn
In-Reply-To: <20170823101901.33961-6-aik@ozlabs.ru>
References: <20170823101901.33961-1-aik@ozlabs.ru>
 <20170823101901.33961-6-aik@ozlabs.ru>
Date: Mon, 28 Aug 2017 16:27:54 +1000
Message-ID: <878ti4rytx.fsf@concordia.ellerman.id.au>
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

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> The pci_dn struct caches a OF device node pointer in order to access
> the "ibm,loc-code" property when EEH is recovering.
>
> However, when this happens in eeh_dev_check_failure(), we also have
> a pci_dev pointer which should have a valid pointer to the device node
> when pci_dn has one (both pointers are not NULL for physical functions
> and are NULL for virtual functions).
>
> This removes the node pointer from the pci_dn struct and used pdev
> in eeh_dev_check_failure() instead.
>
> This changes pci_remove_device_node_info() to look for a parent of
> the node being removed, just like pci_add_device_node_info() does when it
> references the parent node.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/pci-bridge.h | 1 -
>  arch/powerpc/kernel/eeh.c             | 9 +++++----
>  arch/powerpc/kernel/pci_dn.c          | 8 +++++---
>  3 files changed, 10 insertions(+), 8 deletions(-)

  arch/powerpc/platforms/pseries/msi.c: In function =E2=80=98check_req=E2=
=80=99:
  arch/powerpc/platforms/pseries/msi.c:143:10: error: =E2=80=98struct pci_d=
n=E2=80=99 has no member named =E2=80=98node=E2=80=99
  dn =3D pdn->node;
          ^~
  arch/powerpc/platforms/pseries/msi.c: In function =E2=80=98find_pe_dn=E2=
=80=99:
  arch/powerpc/platforms/pseries/msi.c:214:16: error: =E2=80=98struct pci_d=
n=E2=80=99 has no member named =E2=80=98node=E2=80=99
  dn =3D pdn ? pdn->node : NULL;
                ^~
cheers
