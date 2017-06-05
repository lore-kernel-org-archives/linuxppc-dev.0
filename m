Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wh40118BbzDqKp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 15:59:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>, Gustavo Romero <gusbromero@gmail.com>
Subject: Re: [PATCH] powerpc/kernel: improve FP and vector registers
 restoration
In-Reply-To: <1496439810-11240-1-git-send-email-leitao@debian.org>
References: <1496439810-11240-1-git-send-email-leitao@debian.org>
Date: Mon, 05 Jun 2017 15:59:28 +1000
Message-ID: <87vaobq8jj.fsf@concordia.ellerman.id.au>
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

Breno Leitao <leitao@debian.org> writes:

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

Thanks, I tweaked the wording a little and added:

Fixes: 70fe3d980f5f ("powerpc: Restore FPU/VEC/VSX if previously used")
Cc: stable@vger.kernel.org # v4.6+

cheers
