Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNsvX0sKrzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 13:33:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/mm: Invalidate partition table cache on host proc
 tbl base update
In-Reply-To: <1501808533.5037.1.camel@gmail.com>
References: <20170803041551.7934-1-sjitindarsingh@gmail.com>
 <87h8xpqi28.fsf@concordia.ellerman.id.au>
 <1501745720.2664.38.camel@kernel.crashing.org>
 <1501808533.5037.1.camel@gmail.com>
Date: Fri, 04 Aug 2017 13:33:09 +1000
Message-ID: <878tj0qa6i.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:

> On Thu, 2017-08-03 at 17:35 +1000, Benjamin Herrenschmidt wrote:
>> On Thu, 2017-08-03 at 16:30 +1000, Michael Ellerman wrote:
>> > Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
>> >=20
>> > > The host process table base is stored in the partition table by
>> > > calling
>> > > the function native_register_process_table(). Currently this just
>> > > sets
>> > > the entry in memory and is missing a proceeding cache
>> > > invalidation
>> > > instruction. Any update to the partition table should be followed
>> > > by a
>> > > cache invalidation instruction specifying invalidation of the
>> > > caching of
>> > > any partition table entries (RIC =3D 2, PRS =3D 0).
>> > >=20
>> > > We already have a function to update the partition table with the
>> > > required cache invalidation instructions -
>> > > mmu_partition_table_set_entry().
>> > > Update the native_register_process_table() function to call
>> > > mmu_partition_table_set_entry(), this ensures all appropriate
>> > > invalidation will be performed.
>> >=20
>> > Without this patch the kernel will:
>> > =C2=A0[ ] work normally
>> > =C2=A0[ ] randomly crash
>> > =C2=A0[ ] catch fire
>>=20
>> I think we get lucky because OPAL added a "flush the whole world" to
>> opal_reinit_cpus() but this patch seems to improve general code
>> "correctness".
>
> I guess there's the possibility of:
> [x] randomly crash

But you haven't actually see any right?

> This is required to run a powernv kernel as a guest because we need to
> know when it's updated its process table location.

Which doesn't currently work for other reasons :)

cheers
