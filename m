Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xW6Yz0tfPzDr4d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 17:24:39 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id y192so9301120pgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 00:24:39 -0700 (PDT)
Message-ID: <1502695471.2143.2.camel@gmail.com>
Subject: Re: [PATCH] powerpc/mm: Invalidate partition table cache on host
 proc tbl base update
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Date: Mon, 14 Aug 2017 17:24:31 +1000
In-Reply-To: <871solnidm.fsf@concordia.ellerman.id.au>
References: <20170803041551.7934-1-sjitindarsingh@gmail.com>
 <871solnidm.fsf@concordia.ellerman.id.au>
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

On Wed, 2017-08-09 at 20:30 +1000, Michael Ellerman wrote:
> Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
> 
> > The host process table base is stored in the partition table by
> > calling
> > the function native_register_process_table(). Currently this just
> > sets
> > the entry in memory and is missing a proceeding cache invalidation
> > instruction. Any update to the partition table should be followed
> > by a
> > cache invalidation instruction specifying invalidation of the
> > caching of
> > any partition table entries (RIC = 2, PRS = 0).
> > 
> > We already have a function to update the partition table with the
> > required cache invalidation instructions -
> > mmu_partition_table_set_entry().
> > Update the native_register_process_table() function to call
> > mmu_partition_table_set_entry(), this ensures all appropriate
> > invalidation will be performed.
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > ---
> >  arch/powerpc/mm/pgtable-radix.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/mm/pgtable-radix.c
> > b/arch/powerpc/mm/pgtable-radix.c
> > index 671a45d..1d5178f 100644
> > --- a/arch/powerpc/mm/pgtable-radix.c
> > +++ b/arch/powerpc/mm/pgtable-radix.c
> > @@ -33,7 +33,8 @@ static int native_register_process_table(unsigned
> > long base, unsigned long pg_sz
> >  {
> >  	unsigned long patb1 = base | table_size | PATB_GR;
> >  
> > -	partition_tb->patb1 = cpu_to_be64(patb1);
> > +	mmu_partition_table_set_entry(0, be64_to_cpu(partition_tb-
> > >patb0),
> > +				      patb1);
> 
> This is really a bit gross.
> 
> Can we agree on whether partition_tb is an array or not?

Well it is an array, it's just we only ever want the first element in
this function. That being said we might as well access it as an array
to make that clear.

> 
> How about ...
> 
> cheers
> 
> diff --git a/arch/powerpc/mm/pgtable-radix.c
> b/arch/powerpc/mm/pgtable-radix.c
> index c1185c8ecb22..5d8be076f8e5 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -28,9 +28,13 @@
>  static int native_register_process_table(unsigned long base,
> unsigned long pg_sz,
>                                          unsigned long table_size)
>  {
> -       unsigned long patb1 = base | table_size | PATB_GR;
> +       unsigned long patb0, patb1;
> +
> +       patb0 = be64_to_cpu(partition_tb[0].patb0);
> +       patb1 = base | table_size | PATB_GR;
> +
> +       mmu_partition_table_set_entry(0, patb0, patb1);
>  
> -       partition_tb->patb1 = cpu_to_be64(patb1);
>         return 0;
>  }

Looks good :)
