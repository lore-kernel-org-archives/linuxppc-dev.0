Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WNmz0HVBzDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 16:06:11 +1000 (AEST)
In-Reply-To: <1531902796-32294-1-git-send-email-ego@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Florian Weimer <fweimer@redhat.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc/powernv : Save/Restore SPRG3 on entry/exit from stop.
Message-Id: <41WNmy63X5z9s55@ozlabs.org>
Date: Thu, 19 Jul 2018 16:06:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-07-18 at 08:33:16 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> On 64-bit servers, SPRN_SPRG3 and its userspace read-only mirror
> SPRN_USPRG3 are used as userspace VDSO write and read registers
> respectively.
> 
> SPRN_SPRG3 is lost when we enter stop4 and above, and is currently not
> restored.  As a result, any read from SPRN_USPRG3 returns zero on an
> exit from stop4 and above.
> 
> Thus in this situation, on POWER9, any call from sched_getcpu() always
> returns zero, as on powerpc, we call __kernel_getcpu() which relies
> upon SPRN_USPRG3 to report the CPU and NUMA node information.
> 
> Fix this by restoring SPRN_SPRG3 on wake up from a deep stop state
> with the sprg_vdso value that is cached in PACA.
> 
> Fixes: e1c1cfed5432 ("powerpc/powernv: Save/Restore additional SPRs
> for stop4 cpuidle")
> 
> Reported-by: Florian Weimer <fweimer@redhat.com>
> Cc: <stable@vger.kernel.org> # 4.14
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b03897cf318dfc47de33a7ecbc7655

cheers
