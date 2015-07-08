Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26A701A1992
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 20:54:09 +1000 (AEST)
In-Reply-To: <20150707193725.GA12395@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 gustavold@linux.vnet.ibm.com
Subject: Re: powerpc/perf/24x7: Fix lockdep warning
Message-Id: <20150708105409.131F7140B0D@ozlabs.org>
Date: Wed,  8 Jul 2015 20:54:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-07-07 at 19:37:25 UTC, Sukadev Bhattiprolu wrote:
> >From 370152d9427e57cd9632b00189f71099f8e85544 Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Tue, 7 Jul 2015 12:21:10 -0400
> Subject: [PATCH 1/1] powerpc/perf/24x7: Fix lockdep warning
> 
> The sysfs attributes for the 24x7 counters are dynamically allocated.
> Initialize the attributes using sysfs_attr_init() to fix following
> warning which occurs when CONFIG_DEBUG_LOCK_VMALLOC=y.
> 
> [    0.346249] audit: initializing netlink subsys (disabled)
> [    0.346284] audit: type=2000 audit(1436295254.340:1): initialized
> [    0.346489] BUG: key c0000000efe90198 not in .data!
> [    0.346491] DEBUG_LOCKS_WARN_ON(1)
> [    0.346502] ------------[ cut here ]------------
> [    0.346504] WARNING: at ../kernel/locking/lockdep.c:3002
> [    0.346506] Modules linked in:
> 
> Reported-by: Gustavo Luiz Duarte <gustavold@linux.vnet.ibm.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Tested-by: Gustavo Luiz Duarte <gustavold@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?h=fixes&id=442053e57a4fc58b719b6ceab60f29ef9cf4404c

cheers
