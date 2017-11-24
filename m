Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjrtp6RztzDrnw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 20:46:42 +1100 (AEDT)
In-Reply-To: <20171124035102.28051-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: yilzhang@redhat.com, david@gibson.dropbear.id.au
Subject: Re: powerpc/kexec: Fix kexec/kdump in P9 guest kernels
Message-Id: <3yjrtp24pQz9t20@ozlabs.org>
Date: Fri, 24 Nov 2017 20:46:41 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-11-24 at 03:51:02 UTC, Michael Ellerman wrote:
> The code that cleans up the IAMR/AMOR before kexec'ing failed to
> remember that when we're running as a guest AMOR is not writable, it's
> hypervisor privileged.
> 
> They symptom is that the kexec stops before entering purgatory and
> nothing else is seen on the console. If you examine the state of the
> system all threads will be in the 0x700 program check handler.
> 
> Fix it by making the write to AMOR dependent on HV mode.
> 
> Fixes: 1e2a516e89fc ("powerpc/kexec: Fix radix to hash kexec due to IAMR/AMOR")
> Cc: stable@vger.kernel.org # v4.10+
> Reported-by: Yilin Zhang <yilzhang@redhat.com>
> Debugged-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Tested-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/2621e945fbf1d6df5f3f0ba7be5bae

cheers
