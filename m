Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywyXW6hyXzDqmD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:39:23 +1100 (AEDT)
In-Reply-To: <20171016054914.24832-1-santosh@fossix.org>
To: Santosh Sivaraj <santosh@fossix.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 John Stultz <john.stultz@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [v6] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
Message-Id: <3ywyXW1GZ6z9sPm@ozlabs.org>
Date: Tue, 12 Dec 2017 22:39:22 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-16 at 05:49:14 UTC, Santosh Sivaraj wrote:
> Current vDSO64 implementation does not have support for coarse clocks
> (CLOCK_MONOTONIC_COARSE, CLOCK_REALTIME_COARSE), for which it falls back
> to system call, increasing the response time, vDSO implementation reduces
> the cycle time. Below is a benchmark of the difference in execution times.
> 
> (Non-coarse clocks are also included just for completion)
> 
> clock-gettime-realtime: syscall: 172 nsec/call
> clock-gettime-realtime:    libc: 28 nsec/call
> clock-gettime-realtime:    vdso: 22 nsec/call
> clock-gettime-monotonic: syscall: 171 nsec/call
> clock-gettime-monotonic:    libc: 30 nsec/call
> clock-gettime-monotonic:    vdso: 25 nsec/call
> clock-gettime-realtime-coarse: syscall: 153 nsec/call
> clock-gettime-realtime-coarse:    libc: 16 nsec/call
> clock-gettime-realtime-coarse:    vdso: 10 nsec/call
> clock-gettime-monotonic-coarse: syscall: 167 nsec/call
> clock-gettime-monotonic-coarse:    libc: 17 nsec/call
> clock-gettime-monotonic-coarse:    vdso: 11 nsec/call
> 
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5c929885f1bb4b77f85b1769c49405

cheers
