Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWyCb6bQszDqH7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 21:11:07 +1100 (AEDT)
In-Reply-To: <1487690321-21553-1-git-send-email-fweisbec@gmail.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Remove leftover cputime_to_nsecs call causing build error
Message-Id: <3vWyCb5hbdz9sNF@ozlabs.org>
Date: Mon, 27 Feb 2017 21:11:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-21 at 15:18:41 UTC, =?utf-8?b?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= wrote:
> This type conversion is a leftover that got ignored during the kcpustat
> conversion to nanosecs, resulting in build breakage with config having
> CONFIG_NO_HZ_FULL=y.
> 
> 	arch/powerpc/kernel/time.c: In function 'running_clock':
> 	arch/powerpc/kernel/time.c:712:2: error: implicit declaration of function 'cputime_to_nsecs' [-Werror=implicit-function-declaration]
> 	  return local_clock() - cputime_to_nsecs(kcpustat_this_cpu->cpustat[CPUTIME_STEAL]);
> 
> All we need is to remove it.
> 
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Oliver O'Halloran <oohall@gmail.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9f3768e02335ddd6ebe1d85d5cb3a6

cheers
