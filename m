Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPZRv0B1gzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 13:58:51 +1000 (AEST)
In-Reply-To: <1464860688-2085-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm/radix: Make the pid unsigned long
Message-Id: <3rPZRt6Q4wz9sxb@ozlabs.org>
Date: Wed,  8 Jun 2016 13:58:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-02-06 at 09:44:48 UTC, "Aneesh Kumar K.V" wrote:
> Semantic Issue: comparison of constant 18446744073709551615 with
> expression of type 'unsigned int' is always false.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/mm/tlb-radix.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I'm going to take this as a fix, I rewrote the change log to:

    powerpc/mm/radix: Fix always false comparison against MMU_NO_CONTEXT
    
    In some of the radix TLB flush routines, we use a local to store the
    mm->context.id, AKA the PID.
    
    Currently we use an int, but the PID is unsigned long, so large values
    of PID will be truncated. In particular MMU_NO_CONTEXT is -1, which
    means all our comparisons against that value can never be true.
    
    This means we'll issue TLB flushes when we shouldn't on radix enabled
    machines.
    
    Fix it by using an unsigned long for the local. Discovered by Coverity.
    
    Fixes: 1a472c9dba6b ("powerpc/mm/radix: Add tlbflush routines")
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
    Reviewed-by: Balbir Singh <bsingharora@gmail.com>
    [mpe: Write change log]
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
