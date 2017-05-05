Return-Path: <srs0=eibx=4l=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wK2gD1rCjzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 16:54:00 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wK2gD15Ltz8svH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 16:54:00 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wK2gC4lZGz9s8V
 for <linuxppc-dev@ozlabs.org>; Fri,  5 May 2017 16:53:59 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v456rsHS054700
 for <linuxppc-dev@ozlabs.org>; Fri, 5 May 2017 02:53:55 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a8ecjw4wr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 05 May 2017 02:53:55 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 5 May 2017 16:53:10 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v456r0iY47382528
 for <linuxppc-dev@ozlabs.org>; Fri, 5 May 2017 16:53:08 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v456qZoo024614
 for <linuxppc-dev@ozlabs.org>; Fri, 5 May 2017 16:52:35 +1000
Subject: Re: [PATCH 1/2] powerpc/fadump: avoid duplicates in crash memory
 ranges
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <149392041651.10802.10097444663269312695.stgit@hbathini.in.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Pingfan Liu <piliu@redhat.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 5 May 2017 12:22:17 +0530
MIME-Version: 1.0
In-Reply-To: <149392041651.10802.10097444663269312695.stgit@hbathini.in.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <4018f229-ce85-494a-6c70-967d9d33f932@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/04/2017 11:23 PM, Hari Bathini wrote:
> fadump sets up crash memory ranges to be used for creating PT_LOAD
> program headers in elfcore header. Memory chunk RMA_START through
> boot memory area size is added as the first memory range because
> firmware, at the time of crash, moves this memory chunk to different
> location specified during fadump registration making it necessary to
> create a separate program header for it with the correct offset.
> This memory chunk is skipped while setting up the remaining memory
> ranges. But currently, there is possibility that some of this memory
> may have duplicate entries like when it is hot-removed and added
> again. Ensure that no two memory ranges represent the same memory.
> 
> When 5 lmbs are hot-removed and then hot-plugged before registering
> fadump, here is how the program headers in /proc/vmcore exported by
> fadump look like

We should also make sure that fadump registration fails with proper
error if user don't put back those lmbs creating holes below the boot
memory size.

But for this patch

Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>

Thanks,
-Mahesh.

> 
> without this change:
> 
>   Program Headers:
>     Type           Offset             VirtAddr           PhysAddr
>                    FileSiz            MemSiz              Flags  Align
>     NOTE           0x0000000000010000 0x0000000000000000 0x0000000000000000
>                    0x0000000000001894 0x0000000000001894         0
>     LOAD           0x0000000000021020 0xc000000000000000 0x0000000000000000
>                    0x0000000040000000 0x0000000040000000  RWE    0
>     LOAD           0x0000000040031020 0xc000000000000000 0x0000000000000000
>                    0x0000000010000000 0x0000000010000000  RWE    0
>     LOAD           0x0000000050040000 0xc000000010000000 0x0000000010000000
>                    0x0000000050000000 0x0000000050000000  RWE    0
>     LOAD           0x00000000a0040000 0xc000000060000000 0x0000000060000000
>                    0x000000019ffe0000 0x000000019ffe0000  RWE    0
> 
> and with this change:
> 
>   Program Headers:
>     Type           Offset             VirtAddr           PhysAddr
>                    FileSiz            MemSiz              Flags  Align
>     NOTE           0x0000000000010000 0x0000000000000000 0x0000000000000000
>                    0x0000000000001894 0x0000000000001894         0
>     LOAD           0x0000000000021020 0xc000000000000000 0x0000000000000000
>                    0x0000000040000000 0x0000000040000000  RWE    0
>     LOAD           0x0000000040030000 0xc000000040000000 0x0000000040000000
>                    0x0000000020000000 0x0000000020000000  RWE    0
>     LOAD           0x0000000060030000 0xc000000060000000 0x0000000060000000
>                    0x000000019ffe0000 0x000000019ffe0000  RWE    0
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/fadump.c |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 8ff0dd4..03563c6 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -844,8 +844,17 @@ static void fadump_setup_crash_memory_ranges(void)
>  	for_each_memblock(memory, reg) {
>  		start = (unsigned long long)reg->base;
>  		end = start + (unsigned long long)reg->size;
> -		if (start == RMA_START && end >= fw_dump.boot_memory_size)
> -			start = fw_dump.boot_memory_size;
> +
> +		/*
> +		 * skip the first memory chunk (RMA_START through
> +		 * boot_memory_size) that is already added.
> +		 */
> +		if (start < fw_dump.boot_memory_size && start >= RMA_START) {
> +			if (end > fw_dump.boot_memory_size)
> +				start = fw_dump.boot_memory_size;
> +			else
> +				continue;
> +		}
> 
>  		/* add this range excluding the reserved dump area. */
>  		fadump_exclude_reserved_area(start, end);
> 
