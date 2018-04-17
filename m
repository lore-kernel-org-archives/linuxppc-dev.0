Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QLgN0RlCzF1sD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 20:13:36 +1000 (AEST)
In-Reply-To: <20180417014920.21450-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: maddy@linux.ibm.com
Subject: Re: powerpc/64s: Default l1d_size to 64K in RFI fallback flush
Message-Id: <40QLgM6Sq4z9s15@ozlabs.org>
Date: Tue, 17 Apr 2018 20:13:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-17 at 01:49:20 UTC, Michael Ellerman wrote:
> From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> 
> If there is no d-cache-size property in the device tree, l1d_size could
> be zero. We don't actually expect that to happen, it's only been seen
> on mambo (simulator) in some configurations.
> 
> A zero-size l1d_size leads to the loop in the asm wrapping around to
> 2^64-1, and then walking off the end of the fallback area and
> eventually causing a page fault which is fatal.
> 
> Just default to 64K which is correct on some CPUs, and sane enough to
> not cause a crash on others.
> 
> Fixes: aa8a5e0062ac9 ('powerpc/64s: Add support for RFI flush of L1-D cache')
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> [mpe: Rewrite comment and change log]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/9dfbf78e4114fcaf4ef61c49885c3a

cheers
