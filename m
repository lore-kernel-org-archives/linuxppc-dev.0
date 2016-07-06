Return-Path: <jason@lakedaemon.net>
Received: from outbound1a.ore.mailhop.org (outbound1a.ore.mailhop.org
 [54.213.22.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlB6K27BVzDr0j
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 05:44:41 +1000 (AEST)
Date: Wed, 6 Jul 2016 18:28:23 +0000
From: Jason Cooper <jason@lakedaemon.net>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: oss@buserror.net, tglx@linutronix.de, marc.zyngier@arm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 xiaobo.xie@nxp.com
Subject: Re: [PATCH v2 1/2] irqchip/qeic: merge qeic init code from platforms
 to a common function
Message-ID: <20160706182823.GM3348@io.lakedaemon.net>
References: <1467784901-11615-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467784901-11615-1-git-send-email-qiang.zhao@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Zhao Qiang,

On Wed, Jul 06, 2016 at 02:01:38PM +0800, Zhao Qiang wrote:
> The codes of qe_ic init from a variety of platforms are redundant,
> merge them to a common function and put it to irqchip/qe_ic.c
> 
> For non-p1021_mds mpc85xx_mds boards, use "qe_ic_init(np, 0,
> qe_ic_cascade_low_mpic, qe_ic_cascade_high_mpic);" instead of
> "qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);".
> 
> qe_ic_cascade_muxed_mpic was used for boards has the same interrupt
> number for low interrupt and high interrupt, qe_ic_init has checked
> if "low interrupt == high interrupt"
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v2:
> 	- modify subject and commit msg
> 	- add check for qeic by type
> 
>  arch/powerpc/platforms/83xx/misc.c            | 15 ---------------
>  arch/powerpc/platforms/85xx/corenet_generic.c |  9 ---------
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c     | 14 --------------
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c     | 16 ----------------
>  arch/powerpc/platforms/85xx/twr_p102x.c       | 14 --------------
>  drivers/irqchip/qe_ic.c                       | 16 ++++++++++++++++
>  6 files changed, 16 insertions(+), 68 deletions(-)

Hmmm, I seem to be missing the patch moving qe_ic.c into
drivers/irqchip/ ... :-/  Please resend with it attached.  Also, while
we're here,  please follow the file naming convention inside the
drivers/irqchip/ directory.  Something like drivers/irqchip/irq-qeic.c

thx,

Jason.
