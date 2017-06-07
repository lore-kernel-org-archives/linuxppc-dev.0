Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjQKc6QZTzDqKY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 20:49:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Murilo Opsfelder Araujo <mopsfelder@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Subject: Re: [PATCH] include/linux/vfio.h: Guard powerpc-specific functions
 with CONFIG_VFIO_SPAPR_EEH
In-Reply-To: <20170606120914.15851-1-mopsfelder@gmail.com>
References: <20170606120914.15851-1-mopsfelder@gmail.com>
Date: Wed, 07 Jun 2017 20:49:23 +1000
Message-ID: <87a85kf4y4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Murilo Opsfelder Araujo <mopsfelder@gmail.com> writes:

> When CONFIG_EEH=y and CONFIG_VFIO_SPAPR_EEH=n, build fails with the
> following:
>
>     drivers/vfio/pci/vfio_pci.o: In function `.vfio_pci_release':
>     vfio_pci.c:(.text+0xa98): undefined reference to `.vfio_spapr_pci_eeh_release'
>     drivers/vfio/pci/vfio_pci.o: In function `.vfio_pci_open':
>     vfio_pci.c:(.text+0x1420): undefined reference to `.vfio_spapr_pci_eeh_open'
>
> In this case, vfio_pci.c should use the empty definitions of
> vfio_spapr_pci_eeh_open and vfio_spapr_pci_eeh_release functions.
>
> This patch fixes it by guarding these function definitions with
> CONFIG_VFIO_SPAPR_EEH, the symbol that controls whether vfio_spapr_eeh.c is
> built, which is where the non-empty versions of these functions are.
>
> This issue was found during a randconfig build. Logs are here:
>
>     http://kisskb.ellerman.id.au/kisskb/buildresult/12982362/
>
> Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
> ---
>  include/linux/vfio.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Alex I assume you will take this, thanks.

cheers
