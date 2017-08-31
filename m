Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLW2Y0GzDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:19 +1000 (AEST)
In-Reply-To: <20170825043036.18236-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kvm-ppc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v3,
 1/4] KVM: PPC: Book3S HV: POWER9 does not require secondary thread
 management
Message-Id: <3xjgLV5WRVz9t2M@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:17 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-08-25 at 04:30:33 UTC, Nicholas Piggin wrote:
> POWER9 CPUs have independent MMU contexts per thread, so KVM does not
> need to quiesce secondary threads, so the hwthread_req/hwthread_state
> protocol does not have to be used. So patch it away on POWER9, and patch
> away the branch from the Linux idle wakeup to kvm_start_guest that is
> never used.
> 
> Add a warning and error out of kvmppc_grab_hwthread in case it is ever
> called on POWER9.
> 
> This avoids a hwsync in the idle wakeup path on POWER9.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/94a04bc25a2c6296bd0c5e82c10e82

cheers
