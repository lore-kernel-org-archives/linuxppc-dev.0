Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9ACE01A0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 11:57:41 +1000 (EST)
Message-ID: <1408586243.4058.96.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 1/2] powerpc/booke: Restrict SPE exception handlers
 to e200/e500 cores
From: Scott Wood <scottwood@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Date: Wed, 20 Aug 2014 20:57:23 -0500
In-Reply-To: <1408540144-24436-1-git-send-email-mihai.caraman@freescale.com>
References: <1408540144-24436-1-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-08-20 at 16:09 +0300, Mihai Caraman wrote:
> SPE exception handlers are now defined for 32-bit e500mc cores even though
> SPE unit is not present and CONFIG_SPE is undefined.
> 
> Restrict SPE exception handlers to e200/e500 cores adding CONFIG_SPE_POSSIBLE
> and consequently guard __stup_ivors and __setup_cpu functions.
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: Alexander Graf <agraf@suse.de>
> ---
> v2:
>  - use CONFIG_PPC_E500MC without CONFIG_E500
>  - use elif defined()
> 
>  arch/powerpc/kernel/cpu_setup_fsl_booke.S | 12 +++++++++++-
>  arch/powerpc/kernel/cputable.c            |  5 +++++
>  arch/powerpc/kernel/head_fsl_booke.S      | 18 +++++++++++++-----
>  arch/powerpc/platforms/Kconfig.cputype    |  6 +++++-
>  4 files changed, 34 insertions(+), 7 deletions(-)

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
