Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xghZt5xd0zDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 16:25:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel 3/5] powerpc/eeh: Remove unnecessary pointer to phb
 from eeh_dev
In-Reply-To: <20170823101901.33961-4-aik@ozlabs.ru>
References: <20170823101901.33961-1-aik@ozlabs.ru>
 <20170823101901.33961-4-aik@ozlabs.ru>
Date: Mon, 28 Aug 2017 16:25:09 +1000
Message-ID: <87efrwryyi.fsf@concordia.ellerman.id.au>
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

> The eeh_dev struct already holds a pointer to pci_dn which it does not
> exist without and pci_dn itself holds the very same pointer so just
> use it.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/eeh.h               |  1 -
>  arch/powerpc/kernel/eeh.c                    |  7 +++----
>  arch/powerpc/kernel/eeh_dev.c                |  2 --
>  arch/powerpc/kernel/eeh_driver.c             |  2 +-
>  arch/powerpc/kernel/eeh_pe.c                 | 24 +++++++++++++---------=
--
>  arch/powerpc/platforms/powernv/eeh-powernv.c |  5 ++---

Doesn't build ?

  arch/powerpc/platforms/pseries/eeh_pseries.c: In function =E2=80=98pserie=
s_eeh_probe=E2=80=99:
  arch/powerpc/platforms/pseries/eeh_pseries.c:250:15: error: =E2=80=98stru=
ct eeh_dev=E2=80=99 has no member named =E2=80=98phb=E2=80=99
  pe.phb =3D edev->phb;
               ^~

cheers
