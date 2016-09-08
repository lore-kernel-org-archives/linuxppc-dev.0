Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVB7R2XPzzDsFQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 17:00:50 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u886wGmW031371
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Sep 2016 03:00:48 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25av5fe5m4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Sep 2016 03:00:47 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 8 Sep 2016 17:00:45 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A87B03578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 17:00:41 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8870foT6750556
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Sep 2016 17:00:41 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8870f81018646
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Sep 2016 17:00:41 +1000
Subject: Re: [PATCH v2 4/5] powerpc/fadump: Make ELF eflags depend on endian
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
References: <1473139963-7496-1-git-send-email-dja@axtens.net>
 <1473139963-7496-4-git-send-email-dja@axtens.net>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 8 Sep 2016 12:30:39 +0530
MIME-Version: 1.0
In-Reply-To: <1473139963-7496-4-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset=windows-1252
Message-Id: <2cc58c5b-9465-207d-60d8-f09dff6ca0c8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/06/2016 11:02 AM, Daniel Axtens wrote:
> Firmware Assisted Dump is a facility to dump kernel core with assistance
> from firmware.  As part of this process the kernel ELF version is
> stored.
> 
> Currently, fadump.h defines this to 0 if it is not already defined. This
> clashes with a define in elf.h which sets it based on the current task -
> not based on the kernel.
> 
> When the kernel is compiled on LE, the kernel will always be version
> 2. Otherwise it will be version 0. So the correct behaviour is to set
> the ELF eflags based on the endianness of the kernel. Do that.
> 
> Remove the definition in fadump.h, which becomes unused.
> 
> Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> ---
> 
> Mahesh or Hari: I'm not familiar with this code at all, so if either of
> you could check that this makes sense I would really appreciate that.
> Thanks!
> ---
>  arch/powerpc/include/asm/fadump.h | 4 ----
>  arch/powerpc/kernel/fadump.c      | 6 +++++-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
> index b4407d0add27..0031806475f0 100644
> --- a/arch/powerpc/include/asm/fadump.h
> +++ b/arch/powerpc/include/asm/fadump.h
> @@ -45,10 +45,6 @@
> 
>  #define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
> 
> -#ifndef ELF_CORE_EFLAGS
> -#define ELF_CORE_EFLAGS 0
> -#endif
> -
>  /* Firmware provided dump sections */
>  #define FADUMP_CPU_STATE_DATA	0x0001
>  #define FADUMP_HPTE_REGION	0x0002
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 0638b82ce294..457f08e544c6 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -779,7 +779,11 @@ static int fadump_init_elfcore_header(char *bufp)
>  	elf->e_entry = 0;
>  	elf->e_phoff = sizeof(struct elfhdr);
>  	elf->e_shoff = 0;
> -	elf->e_flags = ELF_CORE_EFLAGS;
> +#ifdef __LITTLE_ENDIAN__

Wouldn't '#ifdef PPC64_ELF_ABI_v2' be more appropriate here ?

> +	elf->e_flags = 2;
> +#else
> +	elf->e_flags = 0;
> +#endif
>  	elf->e_ehsize = sizeof(struct elfhdr);
>  	elf->e_phentsize = sizeof(struct elf_phdr);
>  	elf->e_phnum = 0;
> 

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Thanks,
-Mahesh.
