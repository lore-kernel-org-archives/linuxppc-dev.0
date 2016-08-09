Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sRt3KqJzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:26:34 +1000 (AEST)
In-Reply-To: <147039865296.4007.7482355227065137884.stgit@jupiter.in.ibm.com>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [v3,
 2/2] powernv: Fix MCE handler to avoid trashing CR0/CR1 registers.
Message-Id: <3s7sRt1mFFz9t1Q@ozlabs.org>
Date: Tue,  9 Aug 2016 21:26:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-05-08 at 12:04:13 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> The current implementation of MCE early handling modifies CR0/1 registers
> without saving its old values. Fix this by moving early check for
> powersaving mode to machine_check_handle_early().
> 
> The power architecture 2.06 or later allows the possibility of getting
> machine check while in nap/sleep/winkle. The last bit of HSPRG0 is set
> to 1, if thread is woken up from winkle. Hence, clear the last bit of
> HSPRG0 (r13) before MCE handler starts using it as paca pointer.
> 
> Also, the current code always puts the thread into nap state irrespective
> of whatever idle state it woke up from. Fix that by looking at
> paca->thread_idle_state and put the thread back into same state where it
> came from.
> 
> Reported-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Reviewed-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/bc14c49195e49b3231c01e4c44

cheers
