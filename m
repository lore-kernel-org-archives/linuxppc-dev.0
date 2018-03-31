Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0b61ctYzF1rw
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:04:02 +1100 (AEDT)
In-Reply-To: <20180322104146.5350-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc: Fix smp_wmb barrier definition use use lwsync
 consistently
Message-Id: <40D0b50g4jz9s2b@ozlabs.org>
Date: Sun,  1 Apr 2018 01:04:00 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-22 at 10:41:46 UTC, Nicholas Piggin wrote:
> asm/barrier.h is not always included after asm/synch.h, which meant
> it was missing __SUBARCH_HAS_LWSYNC, so in some files smp_wmb() would
> be eieio when it should be lwsync. kernel/time/hrtimer.c is one case.
> 
> __SUBARCH_HAS_LWSYNC is only used in one place, so just fold it in
> to where it's used. Previously with my small simulator config, 377
> instances of eieio in the tree. After this patch there are 55.
> 
> Cc: Anton Blanchard <anton@samba.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0bfdf598900fd62869659f360d3387

cheers
