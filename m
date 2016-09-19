Return-Path: <pku.leo@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdHBt0PcYzDsft
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 06:13:26 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id b184so16792754wma.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 13:13:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1469425427-33883-2-git-send-email-qiang.zhao@nxp.com>
References: <1469425427-33883-1-git-send-email-qiang.zhao@nxp.com>
 <1469425427-33883-2-git-send-email-qiang.zhao@nxp.com>
From: Leo Li <pku.leo@gmail.com>
Date: Mon, 19 Sep 2016 15:13:21 -0500
Message-ID: <CADRPPNQaPjA1qBab-cRa1Yqmf5h53MPyC0OojO46btBuBjEhfA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] QE: remove PPCisms for QE
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 25, 2016 at 12:43 AM, Zhao Qiang <qiang.zhao@nxp.com> wrote:
> QE was supported on PowerPC, and dependent on PPC,
> Now it is supported on other platforms. so remove PPCisms.
>
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v2:
>         - na
> Changes for v3:
>         - add NO_IRQ
> Changes for v4:
>         - modify spin_event_timeout to opencoded timeout loop
>         - remove NO_IRQ
>         - modify virq_to_hw to opencoed code
> Changes for v5:
>         - modify commit msg
>         - modify depends of QUICC_ENGINE
>         - add kerneldoc header for qe_issue_cmd
>
>  drivers/irqchip/qe_ic.c       | 28 +++++++++------
>  drivers/soc/fsl/qe/Kconfig    |  2 +-
>  drivers/soc/fsl/qe/qe.c       | 80 ++++++++++++++++++++++++++-----------------
>  drivers/soc/fsl/qe/qe_io.c    | 42 ++++++++++-------------
>  drivers/soc/fsl/qe/qe_tdm.c   |  8 ++---
>  drivers/soc/fsl/qe/ucc.c      | 10 +++---
>  drivers/soc/fsl/qe/ucc_fast.c | 68 ++++++++++++++++++------------------
>  include/soc/fsl/qe/qe.h       |  1 -
>  include/soc/fsl/qe/qe_ic.h    | 12 +++----
>  9 files changed, 133 insertions(+), 118 deletions(-)
>

[snip]

> diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
> index 73a2e08..b26b643 100644
> --- a/drivers/soc/fsl/qe/Kconfig
> +++ b/drivers/soc/fsl/qe/Kconfig
> @@ -4,7 +4,7 @@
>
>  config QUICC_ENGINE
>         bool "Freescale QUICC Engine (QE) Support"
> -       depends on FSL_SOC && PPC32
> +       depends on OF && HAS_IOMEM
>         select GENERIC_ALLOCATOR
>         select CRC32
>         help

You make it possible to build QE drivers on ARM, but the UCC_GETH
fails to build on arm64.  Please make sure all these drivers can build
on other architectures.  Or you can simply make them only build for
Power architecture as most of them are not available on ARM.

Regards,
Leo
