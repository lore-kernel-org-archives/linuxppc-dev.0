Return-Path: <pku.leo@gmail.com>
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GQrg4KYNzF3Nn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 04:54:43 +1000 (AEST)
Received: by mail-ot1-f66.google.com with SMTP id o13-v6so10512459otl.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 11:54:43 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com.
 [209.85.210.45])
 by smtp.gmail.com with ESMTPSA id f7-v6sm7499694otb.9.2018.09.20.11.54.40
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Sep 2018 11:54:40 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id c12-v6so10508945otl.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 11:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
 <1537456011-10769-3-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1537456011-10769-3-git-send-email-madalin.bucur@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Thu, 20 Sep 2018 13:54:28 -0500
Message-ID: <CADRPPNSz-x1uf98+cKUjj54sSxQbJOXWk7xn_ExhbcjdAYKUpw@mail.gmail.com>
Subject: Re: [PATCH 2/4] soc/fsl/qbman: Add 64 bit DMA addressing requirement
 to QBMan
To: madalin.bucur@nxp.com
Cc: Roy Pledge <roy.pledge@nxp.com>, claudiu.manoil@nxp.com,
 Catalin Marinas <catalin.marinas@arm.com>, Scott Wood <oss@buserror.net>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 20, 2018 at 10:09 AM Madalin Bucur <madalin.bucur@nxp.com> wrote:
>
> From: Roy Pledge <roy.pledge@nxp.com>
>
> The QBMan block is memory mapped on SoCs above a 32 bit (4 Gigabyte)
> boundary so enabling 64 bit DMA addressing is needed for QBMan to
> be usable.
>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> ---
>  drivers/soc/fsl/qbman/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/qbman/Kconfig b/drivers/soc/fsl/qbman/Kconfig
> index d570cb5fd381..19d6f4621e23 100644
> --- a/drivers/soc/fsl/qbman/Kconfig
> +++ b/drivers/soc/fsl/qbman/Kconfig
> @@ -1,6 +1,6 @@
>  menuconfig FSL_DPAA
>         bool "QorIQ DPAA1 framework support"
> -       depends on (FSL_SOC_BOOKE || ARCH_LAYERSCAPE)
> +       depends on ((FSL_SOC_BOOKE || ARCH_LAYERSCAPE || ARM) && ARCH_DMA_ADDR_T_64BIT)

You also added ARM support here.  Actually the dependency on
ARCH_DMA_ADDR_T_64BIT is only explicitly needed by ARM(other platforms
already implies ARCH_DMA_ADDR_T_64BIT).  So I think the patch title
should be like: adding 32-bit ARM support.  The ARCH_DMA_ADDR_T_64BIT
is enabled by ARM_LPAE on ARM.  Probably we should make that
straightforward in the Kconfig, so that people better understand what
is needed for 32-bit ARM.

>         select GENERIC_ALLOCATOR
>         help
>           The Freescale Data Path Acceleration Architecture (DPAA) is a set of
> --
> 2.1.0
>
