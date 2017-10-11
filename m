Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBnjq6qQBzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 19:50:07 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9B8o0DE029994
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 04:50:04 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dhcm19ae3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 04:50:04 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 11 Oct 2017 09:50:00 +0100
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9B8nujO29687870
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 08:49:58 GMT
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9B8nteq003705
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 19:49:56 +1100
Date: Wed, 11 Oct 2017 14:19:51 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Santosh Sivaraj <santosh@fossix.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v5] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
References: <20171011083502.11648-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171011083502.11648-1-santosh@fossix.org>
Message-Id: <20171011084951.sxl3erxrth3gja5a@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/10/11 08:35AM, Santosh Sivaraj wrote:
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
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
> Changelog:
> v1:
> - gettimeofday was moved from asm to C
> - Coarse timer support addition
> v2:
> - Moved Syscall fallback from inline assembly back to its original place in
>   __kernel_clock_gettime
> v3:
> - Based on Ben's input, coarse timer support was added in assembly itself
> - Dropped idea of conversion to C due to the vdso update_count variable
>   being optimized out in C
> v4:
> - Based on Naveen's comments restructured code to avoid a duplicate code
>   block
> v5:
> - Skip creating dependency for registers that are not used for
>   CLOCK_REALTIME_COARSE (Naveen)
> - Reorder instructions to get proper dependency setup (Naveen)
> 
>  arch/powerpc/kernel/asm-offsets.c         |  2 +
>  arch/powerpc/kernel/vdso64/gettimeofday.S | 68 ++++++++++++++++++++++++++-----
>  2 files changed, 59 insertions(+), 11 deletions(-)

Looks good to me.
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
