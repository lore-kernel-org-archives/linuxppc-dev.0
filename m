Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNMLx6kQSzDrLc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 17:36:41 +1000 (AEST)
Message-ID: <1501745720.2664.38.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Invalidate partition table cache on host
 proc tbl base update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Suraj Jitindar Singh
 <sjitindarsingh@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Date: Thu, 03 Aug 2017 17:35:20 +1000
In-Reply-To: <87h8xpqi28.fsf@concordia.ellerman.id.au>
References: <20170803041551.7934-1-sjitindarsingh@gmail.com>
 <87h8xpqi28.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-08-03 at 16:30 +1000, Michael Ellerman wrote:
> Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
> 
> > The host process table base is stored in the partition table by calling
> > the function native_register_process_table(). Currently this just sets
> > the entry in memory and is missing a proceeding cache invalidation
> > instruction. Any update to the partition table should be followed by a
> > cache invalidation instruction specifying invalidation of the caching of
> > any partition table entries (RIC = 2, PRS = 0).
> > 
> > We already have a function to update the partition table with the
> > required cache invalidation instructions - mmu_partition_table_set_entry().
> > Update the native_register_process_table() function to call
> > mmu_partition_table_set_entry(), this ensures all appropriate
> > invalidation will be performed.
> 
> Without this patch the kernel will:
>  [ ] work normally
>  [ ] randomly crash
>  [ ] catch fire

I think we get lucky because OPAL added a "flush the whole world" to
opal_reinit_cpus() but this patch seems to improve general code
"correctness".

Cheers,
Ben.
