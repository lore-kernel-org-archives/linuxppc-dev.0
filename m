Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbZXs6CqHzDqTt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 23:39:09 +1000 (AEST)
In-Reply-To: <20170727062455.15404-2-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [v3,2/3] powerpc/mm: Don't send IPI to all cpus on THP updates
Message-Id: <3xbZXs5CkYz9sDB@ozlabs.org>
Date: Mon, 21 Aug 2017 23:39:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-07-27 at 06:24:54 UTC, "Aneesh Kumar K.V" wrote:
> Now that we made sure that lockless walk of linux page table is mostly limitted
> to current task(current->mm->pgdir) we can update the THP update sequence to
> only send IPI to cpus on which this task has run. This helps in reducing the IPI
> overload on systems with large number of CPUs.
> 
> W.r.t kvm even though kvm is walking page table with vpc->arch.pgdir, it is
> done only on secondary cpus and in that case we have primary cpu added to
> task's mm cpumask. Sending an IPI to primary will force the secondary to do
> a vm exit and hence this mm cpumask usage is safe here.
> 
> W.r.t CAPI, we still end up walking linux page table with capi context MM. For
> now the pte lookup serialization sends an IPI to all cpus in CPI is in use. We
> can further improve this by adding the CAPI interrupt handling cpu to task
> mm cpumask. That will be done in a later patch.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fa4531f753f1c80d21b5eb86ec5c02

cheers
