Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQpPJ2BTXzDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 17:02:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Zhao Qiang <qiang.zhao@nxp.com>, tglx@linutronix.de
Cc: oss@buserror.net, Zhao Qiang <qiang.zhao@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, xiaobo.xie@nxp.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 4/4] irqchip/qeic: remove PPCisms for QEIC
In-Reply-To: <1502075236-24078-5-git-send-email-qiang.zhao@nxp.com>
References: <1502075236-24078-1-git-send-email-qiang.zhao@nxp.com>
 <1502075236-24078-5-git-send-email-qiang.zhao@nxp.com>
Date: Mon, 07 Aug 2017 17:02:11 +1000
Message-ID: <87h8xjq2rw.fsf@concordia.ellerman.id.au>
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

Zhao Qiang <qiang.zhao@nxp.com> writes:

> QEIC was supported on PowerPC, and dependent on PPC,
> Now it is supported on other platforms, so remove PPCisms.
>
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
>  arch/powerpc/platforms/83xx/km83xx.c          |   1 -
>  arch/powerpc/platforms/83xx/misc.c            |   1 -
>  arch/powerpc/platforms/83xx/mpc832x_mds.c     |   1 -
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c     |   1 -
>  arch/powerpc/platforms/83xx/mpc836x_mds.c     |   1 -
>  arch/powerpc/platforms/83xx/mpc836x_rdk.c     |   1 -
>  arch/powerpc/platforms/85xx/corenet_generic.c |   1 -
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c     |   1 -
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |   1 -
>  arch/powerpc/platforms/85xx/twr_p102x.c       |   1 -
>  drivers/irqchip/irq-qeic.c                    | 188 +++++++++++---------------
>  include/soc/fsl/qe/qe_ic.h                    | 132 ------------------
>  12 files changed, 80 insertions(+), 250 deletions(-)
>  delete mode 100644 include/soc/fsl/qe/qe_ic.h
>
> diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
> index d8642a4..b1cef0a 100644
> --- a/arch/powerpc/platforms/83xx/km83xx.c
> +++ b/arch/powerpc/platforms/83xx/km83xx.c
> @@ -38,7 +38,6 @@
>  #include <sysdev/fsl_soc.h>
>  #include <sysdev/fsl_pci.h>
>  #include <soc/fsl/qe/qe.h>
> -#include <soc/fsl/qe/qe_ic.h>

You deleted that file in patch 2. So didn't you just break the build for
the last two commits?

cheers
