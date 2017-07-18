Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBbsw2ttdzDrFM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 20:26:12 +1000 (AEST)
In-Reply-To: <1500291060-8133-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: abdhalee@linux.vnet.ibm.com
Subject: Re: powerpc/powernv: Fix boot on Power8 bare metal due to
 opal_configure_cores()
Message-Id: <3xBbsw2373z9t2J@ozlabs.org>
Date: Tue, 18 Jul 2017 20:26:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-17 at 11:31:00 UTC, Michael Ellerman wrote:
> In commit 1c0eaf0f56d6 ("powerpc/powernv: Tell OPAL about our MMU mode
> on POWER9"), we added additional flags to the OPAL call to configure
> CPUs at boot.
> 
> These flags only work on Power9 firmwares, and worse can cause boot
> failures on Power8 machines, so we check for CPU_FTR_ARCH_300 (aka POWER9)
> before adding the extra flags.
> 
> Unfortunately we forgot that opal_configure_cores() is called before
> the CPU feature checks are dynamically patched, meaning the check
> always returns true.
> 
> We definitely need to do something to make the CPU feature checks less
> prone to bugs like this, but for now the minimal fix is to use
> early_cpu_has_feature().
> 
> Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Fixes: 1c0eaf0f56d6 ("powerpc/powernv: Tell OPAL about our MMU mode on POWER9")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/a70b487b07cf4201bc6702e7f646fa

cheers
