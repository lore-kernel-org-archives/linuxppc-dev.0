Return-Path: <srs0=wkuz=7m=linux.vnet.ibm.com=arbab@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSvJg51yjzDqs4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 02:50:27 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xSvJg4H4dz8vp3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 02:50:27 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xSvJg0X1Hz9s7M
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2017 02:50:26 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7AGnTIE102071
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2017 12:50:23 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c8u3bgt85-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2017 12:50:23 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 10 Aug 2017 12:50:22 -0400
Date: Thu, 10 Aug 2017 11:50:19 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, nfont@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [FIX PATCH v0] powerpc: Fix memory unplug failure on radix guest
References: <1502357028-27465-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <1502357028-27465-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <20170810165019.unrvv6id2daqazju@arbab-laptop.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 10, 2017 at 02:53:48PM +0530, Bharata B Rao wrote:
>diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>index f830562..24ecf53 100644
>--- a/arch/powerpc/kernel/prom.c
>+++ b/arch/powerpc/kernel/prom.c
>@@ -524,6 +524,7 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
> 					size = 0x80000000ul - base;
> 			}
> 			memblock_add(base, size);
>+			memblock_mark_hotplug(base, size);
> 		} while (--rngs);
> 	}
> 	memblock_dump_all();

Doing this has the effect of putting all the affected memory into 
ZONE_MOVABLE. See find_zone_movable_pfns_for_nodes(). This means no 
kernel allocations can occur there. Is that okay?

>diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
>index 671a45d..180d25a 100644
>--- a/arch/powerpc/mm/pgtable-radix.c
>+++ b/arch/powerpc/mm/pgtable-radix.c
>@@ -12,6 +12,7 @@
> #include <linux/memblock.h>
> #include <linux/of_fdt.h>
> #include <linux/mm.h>
>+#include <linux/memory.h>
>
> #include <asm/pgtable.h>
> #include <asm/pgalloc.h>
>@@ -255,15 +256,25 @@ static void __init radix_init_pgtable(void)
> {
> 	unsigned long rts_field;
> 	struct memblock_region *reg;
>+	phys_addr_t addr;
>+	u64 lmb_size = memory_block_size_bytes();
>
> 	/* We don't support slb for radix */
> 	mmu_slb_size = 0;
> 	/*
> 	 * Create the linear mapping, using standard page size for now
> 	 */
>-	for_each_memblock(memory, reg)
>-		WARN_ON(create_physical_mapping(reg->base,
>-						reg->base + reg->size));
>+	for_each_memblock(memory, reg) {
>+		if (memblock_is_hotpluggable(reg)) {
>+			for (addr = reg->base; addr < (reg->base + reg->size);
>+				addr += lmb_size)
>+				WARN_ON(create_physical_mapping(addr,
>+					addr + lmb_size));
>+		} else {
>+			WARN_ON(create_physical_mapping(reg->base,
>+							reg->base + reg->size));
>+		}
>+	}
>
> 	/* Find out how many PID bits are supported */
> 	if (cpu_has_feature(CPU_FTR_HVMODE)) {
>-- 
>2.7.4
>

-- 
Reza Arbab
