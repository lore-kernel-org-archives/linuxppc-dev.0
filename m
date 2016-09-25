Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shYdZ0vq8zDrLW
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 14:14:25 +1000 (AEST)
Date: Sat, 24 Sep 2016 23:14:11 -0500
From: Scott Wood <oss@buserror.net>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, pku.leo@gmail.com, xiaobo.xie@nxp.com,
 linux-kernel@vger.kernel.org
Message-ID: <20160925041411.GA16092@home.buserror.net>
References: <1474597232-33397-2-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474597232-33397-2-git-send-email-qiang.zhao@nxp.com>
Subject: Re: [v6,2/2] QE: remove PPCisms for QE
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 23, 2016 at 10:20:32AM +0800, Zhao Qiang wrote:
> QE was supported on PowerPC, and dependent on PPC,
> Now it is supported on other platforms. so remove PPCisms.
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v2:
> 	- na
> Changes for v3:
> 	- add NO_IRQ
> Changes for v4:
> 	- modify spin_event_timeout to opencoded timeout loop
> 	- remove NO_IRQ
> 	- modify virq_to_hw to opencoed code
> Changes for v5:
> 	- modify commit msg
> 	- modify depends of QUICC_ENGINE
> 	- add kerneldoc header for qe_issue_cmd
> Changes for v6:
> 	- add dependency on FSL_SOC and PPC32 for drivers
> 	  depending on QUICC_ENGING but not available on ARM
> 
>  drivers/irqchip/qe_ic.c                | 28 +++++++-----
>  drivers/net/ethernet/freescale/Kconfig | 10 ++---
>  drivers/soc/fsl/qe/Kconfig             |  2 +-
>  drivers/soc/fsl/qe/qe.c                | 80 ++++++++++++++++++++--------------
>  drivers/soc/fsl/qe/qe_io.c             | 42 ++++++++----------
>  drivers/soc/fsl/qe/qe_tdm.c            |  8 ++--
>  drivers/soc/fsl/qe/ucc.c               | 10 ++---
>  drivers/soc/fsl/qe/ucc_fast.c          | 68 ++++++++++++++---------------
>  drivers/tty/serial/Kconfig             |  2 +-
>  drivers/usb/gadget/udc/Kconfig         |  2 +-
>  drivers/usb/host/Kconfig               |  2 +-
>  include/soc/fsl/qe/qe.h                |  1 -
>  include/soc/fsl/qe/qe_ic.h             | 12 ++---
>  13 files changed, 141 insertions(+), 126 deletions(-)

I assume this means you'll be updating
http://patchwork.ozlabs.org/patch/654473/
to be based on top of this...

-Scott
