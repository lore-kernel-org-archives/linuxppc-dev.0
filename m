Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GsbH1lBrzF3QG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 21:59:39 +1000 (AEST)
In-Reply-To: <20180913053347.11389-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, sjitindarsingh@gmail.com,
 kvm-ppc@vger.kernel.org
Subject: Re: KVM: PPC: Book3S HV: Fix guest r11 corruption with POWER9 TM
 workarounds
Message-Id: <42GsbH0bvyz9sCc@ozlabs.org>
Date: Fri, 21 Sep 2018 21:59:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-09-13 at 05:33:47 UTC, Michael Neuling wrote:
> When we come into the softpatch handler (0x1500), we use r11 to store
> the HSRR0 for later use by the denorm handler.
> 
> We also use the softpatch handler for the TM workarounds for
> POWER9. Unfortunately, in kvmppc_interrupt_hv we later store r11 out
> to the vcpu assuming it's still what we got from userspace.
> 
> This causes r11 to be corrupted in the VCPU and hence when we restore
> the guest, we get a corrupted r11. We've seen this when running TM
> tests inside guests on P9.
> 
> This fixes the problem by only touching r11 in the denorm case.
> 
> Fixes: 4bb3c7a020 ("KVM: PPC: Book3S HV: Work around transactional memory bugs in POWER9")
> Cc: <stable@vger.kernel.org> # 4.17+
> Test-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/f14040bca89258b8a1c71e2112e430

cheers
