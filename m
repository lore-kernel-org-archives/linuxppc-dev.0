Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbXtb5LxwzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 19:23:03 +1000 (AEST)
Date: Fri, 24 Jun 2016 19:21:16 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, KVM <kvm@vger.kernel.org>,
 KVM-PPC <kvm-ppc@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Powernv: Remove the usage of PACAR1 from opal
 wrappers
Message-ID: <20160624092116.GD26584@fergus.ozlabs.ibm.com>
References: <20160515041413.2280.747.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160515041413.2280.747.stgit@mars>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 15, 2016 at 09:44:13AM +0530, Mahesh J Salgaonkar wrote:
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
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks, both patches applied to my kvm-ppc-next branch at
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git.

Paul.
