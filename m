Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sS160rPzDqgS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:26:41 +1000 (AEST)
In-Reply-To: <147040459202.19770.16560483806363144997.stgit@jupiter.in.ibm.com>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: powernv: Load correct TOC pointer while waking up from winkle.
Message-Id: <3s7sS14Sxkz9t23@ozlabs.org>
Date: Tue,  9 Aug 2016 21:26:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-05-08 at 13:43:12 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> The function pnv_restore_hyp_resource() loads the TOC into r2 from
> the invalid PACA pointer before fixing r13 value. This do not affect
> POWER ISA 3.0 but it does have an impact on POWER ISA 2.07 or less
> leading CPU to get stuck forever.
> 
> 	login: [  471.830433] Processor 120 is stuck.
> 
> 
> This can be easily reproducible using following steps:
> - Turn off SMT
> 	$ ppc64_cpu --smt=off
> - offline/online any online cpu (Thread 0 of any core which is online)
> 	$ echo 0 > /sys/devices/system/cpu/cpu<num>/online
> 	$ echo 1 > /sys/devices/system/cpu/cpu<num>/online
> 
> For POWER ISA 2.07 or less, the last bit of HSPRG0 is set indicating
> that thread is waking up from winkle. Hence, the last bit of HSPRG0(r13)
> needs to be clear before accessing it as PACA to avoid loading invalid
> values from invalid PACA pointer.
> 
> Fix this by loading TOC after r13 register is corrected.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/e325d76f8bd2d222a1f577aba0

cheers
