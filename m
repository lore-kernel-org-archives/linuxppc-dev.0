Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkQkt3YbVzDqrN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 00:10:14 +1000 (AEST)
In-Reply-To: <1457472378-22274-1-git-send-email-linux@rasmusvillemoes.dk>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc/pseries: fix error return value in cmm_mem_going_offline
Message-Id: <3rkQkt2qMHz9t0T@ozlabs.org>
Date: Wed,  6 Jul 2016 00:10:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-08-03 at 21:26:17 UTC, Rasmus Villemoes wrote:
> cmm_mem_going_offline is (only) called from cmm_memory_cb(), which
> sends the return value through notifier_from_errno(). The latter
> expects 0 or -errno (notifier_to_errno(notifier_from_errno(x)) is 0
> for any x >= 0, so passing a positive value cannot make sense). Hence
> negate ENOMEM.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e2be23712a9c8e3710c9e2684a

cheers
