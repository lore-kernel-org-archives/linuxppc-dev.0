Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNpYV0KfFzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 11:02:22 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 83so273980pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Aug 2017 18:02:21 -0700 (PDT)
Message-ID: <1501808533.5037.1.camel@gmail.com>
Subject: Re: [PATCH] powerpc/mm: Invalidate partition table cache on host
 proc tbl base update
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Date: Fri, 04 Aug 2017 11:02:13 +1000
In-Reply-To: <1501745720.2664.38.camel@kernel.crashing.org>
References: <20170803041551.7934-1-sjitindarsingh@gmail.com>
 <87h8xpqi28.fsf@concordia.ellerman.id.au>
 <1501745720.2664.38.camel@kernel.crashing.org>
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

On Thu, 2017-08-03 at 17:35 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2017-08-03 at 16:30 +1000, Michael Ellerman wrote:
> > Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
> > 
> > > The host process table base is stored in the partition table by
> > > calling
> > > the function native_register_process_table(). Currently this just
> > > sets
> > > the entry in memory and is missing a proceeding cache
> > > invalidation
> > > instruction. Any update to the partition table should be followed
> > > by a
> > > cache invalidation instruction specifying invalidation of the
> > > caching of
> > > any partition table entries (RIC = 2, PRS = 0).
> > > 
> > > We already have a function to update the partition table with the
> > > required cache invalidation instructions -
> > > mmu_partition_table_set_entry().
> > > Update the native_register_process_table() function to call
> > > mmu_partition_table_set_entry(), this ensures all appropriate
> > > invalidation will be performed.
> > 
> > Without this patch the kernel will:
> >  [ ] work normally
> >  [ ] randomly crash
> >  [ ] catch fire
> 
> I think we get lucky because OPAL added a "flush the whole world" to
> opal_reinit_cpus() but this patch seems to improve general code
> "correctness".
> 
> Cheers,
> Ben.
> 

I guess there's the possibility of:
[x] randomly crash

This is required to run a powernv kernel as a guest because we need to
know when it's updated its process table location.
