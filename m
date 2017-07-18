Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBcWt0BkczDrFV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 20:55:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: laurentiu.tudor@nxp.com, oss@buserror.net, linuxppc-dev@lists.ozlabs.org
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v2] powerpc: allow compiling with GENERIC_MSI_IRQ_DOMAIN
In-Reply-To: <20170717131243.2157-1-laurentiu.tudor@nxp.com>
References: <20170717131243.2157-1-laurentiu.tudor@nxp.com>
Date: Tue, 18 Jul 2017 20:55:36 +1000
Message-ID: <87pocyhv4n.fsf@concordia.ellerman.id.au>
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

laurentiu.tudor@nxp.com writes:

> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> This allows building powerpc with the GENERIC_MSI_IRQ_DOMAIN
> Kconfig by enabling the asm-generic msi.h in Kbuild. Without
> this, there's a compilation error [1] because powerpc, as most
> arches, doesn't provide an asm/msi.h.
>
> [1] In file included from ./include/linux/kvm_host.h:20:0,
>                  from ./arch/powerpc/include/asm/kvm_ppc.h:30,
>                  from arch/powerpc/kernel/dbell.c:20:
> ./include/linux/msi.h:195:21: fatal error: asm/msi.h: No such file or directory
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
> v2:
>  - compilation error happens when GENERIC_MSI_IRQ_DOMAIN is enabled and not
>    GENERIC_MSI_IRQ, so fix commit msg and title

It looks like the only way powerpc can enable GENERIC_MSI_IRQ_DOMAIN is
by enabling FSL_MC_BUS ?

cheers
