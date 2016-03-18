Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qR9mW4QYyzDqHw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 14:33:31 +1100 (AEDT)
In-Reply-To: <20160114031457.1287.32132.stgit@mars>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: KVM <kvm@vger.kernel.org>, KVM-PPC <kvm-ppc@vger.kernel.org>
Subject: Re: [1/3] Powernv: Remove the usage of PACAR1 from opal wrappers
Message-Id: <3qR9mW32mxz9sCk@ozlabs.org>
Date: Fri, 18 Mar 2016 14:33:31 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-14-01 at 03:14:58 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> OPAL_CALL wrapper code sticks the r1 (stack pointer) into PACAR1 purely
> for debugging purpose only. The power7_wakeup* functions relies on stack
> pointer saved in PACAR1. Any opal call made using opal wrapper (directly
> or in-directly) before we fall through power7_wakeup*, then it ends up
> replacing r1 in PACAR1(r13) leading to kernel panic. So far we don't see
> any issues because we have never made any opal calls using OPAL wrapper
> before power7_wakeup*. But the subsequent HMI patch would need to invoke
> C calls during cpu wakeup/idle path that in-directly makes opal call using
> opal wrapper. This patch facilitates the subsequent HMI patch by removing
> usage of PACAR1 from opal call wrapper.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
