Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xH2cD0Q4ZzDqmv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 01:44:43 +1000 (AEST)
Date: Tue, 25 Jul 2017 09:44:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Murilo Opsfelder =?UTF-8?B?QXJhw7pqbw==?= <mopsfelder@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, <aik@ozlabs.ru>, David
 Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2] include/linux/vfio.h: Guard powerpc-specific
 functions with CONFIG_VFIO_SPAPR_EEH
Message-ID: <20170725094439.7859c41c@w520.home>
In-Reply-To: <c570cffb-f713-22d9-ebf7-46d752d562be@gmail.com>
References: <20170718172220.9954-1-mopsfelder@gmail.com>
 <c570cffb-f713-22d9-ebf7-46d752d562be@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[cc +Alexey, David]

Any comments from the usual suspects for vfio/spapr?  Thanks,

Alex

On Tue, 25 Jul 2017 10:56:38 -0300
Murilo Opsfelder Ara=C3=BAjo <mopsfelder@gmail.com> wrote:

> On 07/18/2017 02:22 PM, Murilo Opsfelder Araujo wrote:
> > When CONFIG_EEH=3Dy and CONFIG_VFIO_SPAPR_EEH=3Dn, build fails with the
> > following:
> >=20
> >     drivers/vfio/pci/vfio_pci.o: In function `.vfio_pci_release':
> >     vfio_pci.c:(.text+0xa98): undefined reference to `.vfio_spapr_pci_e=
eh_release'
> >     drivers/vfio/pci/vfio_pci.o: In function `.vfio_pci_open':
> >     vfio_pci.c:(.text+0x1420): undefined reference to `.vfio_spapr_pci_=
eeh_open'
> >=20
> > In this case, vfio_pci.c should use the empty definitions of
> > vfio_spapr_pci_eeh_open and vfio_spapr_pci_eeh_release functions.
> >=20
> > This patch fixes it by guarding these function definitions with
> > CONFIG_VFIO_SPAPR_EEH, the symbol that controls whether vfio_spapr_eeh.=
c is
> > built, which is where the non-empty versions of these functions are. We=
 need to
> > make use of IS_ENABLED() macro because CONFIG_VFIO_SPAPR_EEH is a trist=
ate
> > option.
> >=20
> > This issue was found during a randconfig build. Logs are here:
> >=20
> >     http://kisskb.ellerman.id.au/kisskb/buildresult/12982362/
> >=20
> > Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
> > ---
> >=20
> > Changes from v1:
> > - Rebased on top of next-20170718. =20
>=20
> Hi, Alex.
>=20
> Are you applying this?
>=20
> Thanks!
>=20
