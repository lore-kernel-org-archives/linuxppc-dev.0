Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xghdZ3zTkzDqKd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 16:27:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel 4/5] powerpc/eeh: Remove unnecessary config_addr
 from eeh_dev
In-Reply-To: <20170823101901.33961-5-aik@ozlabs.ru>
References: <20170823101901.33961-1-aik@ozlabs.ru>
 <20170823101901.33961-5-aik@ozlabs.ru>
Date: Mon, 28 Aug 2017 16:27:30 +1000
Message-ID: <87bmn0ryul.fsf@concordia.ellerman.id.au>
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

> The eeh_dev struct hold a config space address of an associated node
> and the very same address is also stored in the pci_dn struct which
> is always present during the eeh_dev lifetime.
>
> This uses bus:devfn directly from pci_dn instead of cached and packed
> config_addr.
>
> Since config_addr is made from device's bus:dev.fn, there is no point
> in keeping it in the debugfs either so remove that too.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/eeh.h               |  1 -
>  arch/powerpc/kernel/eeh_pe.c                 | 42 ++++++++++++++--------=
------
>  arch/powerpc/kernel/eeh_sysfs.c              |  3 --
>  arch/powerpc/platforms/powernv/eeh-powernv.c |  9 +++---

  arch/powerpc/platforms/pseries/eeh_pseries.c:257:7: error: =E2=80=98struc=
t eeh_dev=E2=80=99 has no member named =E2=80=98config_addr=E2=80=99; did y=
ou mean =E2=80=98pe_config_addr=E2=80=99?
  edev->config_addr =3D (pdn->busno << 16) | (pdn->devfn << 8);
      ^~
  arch/powerpc/platforms/pseries/eeh_pseries.c:282:8: error: =E2=80=98struc=
t eeh_dev=E2=80=99 has no member named =E2=80=98config_addr=E2=80=99; did y=
ou mean =E2=80=98pe_config_addr=E2=80=99?
   edev->config_addr =3D pdn_to_eeh_dev(pdn->parent)->config_addr;
       ^~
  arch/powerpc/platforms/pseries/eeh_pseries.c:282:51: error: =E2=80=98stru=
ct eeh_dev=E2=80=99 has no member named =E2=80=98config_addr=E2=80=99; did =
you mean =E2=80=98pe_config_addr=E2=80=99?
   edev->config_addr =3D pdn_to_eeh_dev(pdn->parent)->config_addr;
                                                   ^~
cheers
