Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS6wQ4rcCzDr2Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 20:30:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: [PATCH] powerpc/mm: Invalidate partition table cache on host proc
 tbl base update
In-Reply-To: <20170803041551.7934-1-sjitindarsingh@gmail.com>
References: <20170803041551.7934-1-sjitindarsingh@gmail.com>
Date: Wed, 09 Aug 2017 20:30:13 +1000
Message-ID: <871solnidm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:

> The host process table base is stored in the partition table by calling
> the function native_register_process_table(). Currently this just sets
> the entry in memory and is missing a proceeding cache invalidation
> instruction. Any update to the partition table should be followed by a
> cache invalidation instruction specifying invalidation of the caching of
> any partition table entries (RIC = 2, PRS = 0).
>
> We already have a function to update the partition table with the
> required cache invalidation instructions - mmu_partition_table_set_entry().
> Update the native_register_process_table() function to call
> mmu_partition_table_set_entry(), this ensures all appropriate
> invalidation will be performed.
>
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  arch/powerpc/mm/pgtable-radix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 671a45d..1d5178f 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -33,7 +33,8 @@ static int native_register_process_table(unsigned long base, unsigned long pg_sz
>  {
>  	unsigned long patb1 = base | table_size | PATB_GR;
>  
> -	partition_tb->patb1 = cpu_to_be64(patb1);
> +	mmu_partition_table_set_entry(0, be64_to_cpu(partition_tb->patb0),
> +				      patb1);

This is really a bit gross.

Can we agree on whether partition_tb is an array or not?

How about ...

cheers

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index c1185c8ecb22..5d8be076f8e5 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -28,9 +28,13 @@
 static int native_register_process_table(unsigned long base, unsigned long pg_sz,
                                         unsigned long table_size)
 {
-       unsigned long patb1 = base | table_size | PATB_GR;
+       unsigned long patb0, patb1;
+
+       patb0 = be64_to_cpu(partition_tb[0].patb0);
+       patb1 = base | table_size | PATB_GR;
+
+       mmu_partition_table_set_entry(0, patb0, patb1);
 
-       partition_tb->patb1 = cpu_to_be64(patb1);
        return 0;
 }
