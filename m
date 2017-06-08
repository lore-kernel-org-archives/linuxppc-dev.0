Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjsJs5hNGzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 14:05:17 +1000 (AEST)
In-Reply-To: <1496439810-11240-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>, Gustavo Romero <gusbromero@gmail.com>
Subject: Re: powerpc/kernel: improve FP and vector registers restoration
Message-Id: <3wjsJs4LQLz9sCX@ozlabs.org>
Date: Thu,  8 Jun 2017 14:05:17 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-06-02 at 21:43:30 UTC, Breno Leitao wrote:
> Currently tsk->thread->load_vec and load_fp are not initialized during a
> task creation, which set garbage to these variables (non-zero value).
> 
> These variables will be checked later at restore_math() to validate if the
> FP and vectors are being utilized. Since these values might be non-zero,
> the restore_math() will continue to save the FP and vectors even if they
> were never utilized before the userspace application. load_fp and load_vec
> counters will then overflow and the FP and Altivec will be finally
> disabled, but before that condition is reached (counter overflow) several
> context switches restored FP and vector registers without need, causing a
> performance degradation.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Gustavo Romero <gusbromero@gmail.com>
> Acked-by: Anton Blanchard <anton@samba.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/1195892c091a15cc862f4e202482a3

cheers
