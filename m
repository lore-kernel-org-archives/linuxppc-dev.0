Return-Path: <srs0=bdvh=gy=linux.vnet.ibm.com=prvs=0631ac1793=hbathini@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [103.22.144.68])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fzc75YKQzF2BS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 05:26:47 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40Fzc72RQjz8svD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 05:26:47 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40Fzc66CW6z9s0n
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2018 05:26:45 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w33JPHuS095673
 for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2018 15:26:43 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h4fjg0kcj-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 03 Apr 2018 15:26:43 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Tue, 3 Apr 2018 20:26:40 +0100
Subject: Re: [PATCH v3 1/7] powerpc/fadump: Move the metadata region to start
 of the reserved area.
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Ananth Narayan <ananth@in.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <152265046485.23251.1392824827444770657.stgit@jupiter.in.ibm.com>
 <152265058069.23251.1496677151481459154.stgit@jupiter.in.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 4 Apr 2018 00:56:33 +0530
MIME-Version: 1.0
In-Reply-To: <152265058069.23251.1496677151481459154.stgit@jupiter.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f5a8a0f8-0b97-ac3e-dd4b-4796d6976725@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh, I think we should explicitly document that production and 
capture kernel
versions should be same. For changes like below, older/newer production 
kernel vs
capture kernel is bound to fail. Of course, production and capture 
kernel versions
would be the same case usually but for the uninitiated, mentioning that 
explicitly
in documentation would help..?

Thanks
Hari


On Monday 02 April 2018 11:59 AM, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> Currently the metadata region that holds crash info structure and ELF core
> header is placed towards the end of reserved memory area. This patch places
> it at the beginning of the reserved memory area.
>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/fadump.h |    4 ++
>   arch/powerpc/kernel/fadump.c      |   92 ++++++++++++++++++++++++++++++++-----
>   2 files changed, 83 insertions(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
> index 5a23010af600..44b6ebfe9be6 100644
> --- a/arch/powerpc/include/asm/fadump.h
> +++ b/arch/powerpc/include/asm/fadump.h
> @@ -61,6 +61,9 @@
>   #define FADUMP_UNREGISTER	2
>   #define FADUMP_INVALIDATE	3
>
> +/* Number of dump sections requested by kernel */
> +#define FADUMP_NUM_SECTIONS	4
> +
>   /* Dump status flag */
>   #define FADUMP_ERROR_FLAG	0x2000
>
> @@ -119,6 +122,7 @@ struct fadump_mem_struct {
>   	struct fadump_section		cpu_state_data;
>   	struct fadump_section		hpte_region;
>   	struct fadump_section		rmr_region;
> +	struct fadump_section		metadata_region;
>   };
>
>   /* Firmware-assisted dump configuration details. */
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 3c2c2688918f..80552fd7d5f8 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -188,17 +188,48 @@ static void fadump_show_config(void)
>   	pr_debug("Boot memory size  : %lx\n", fw_dump.boot_memory_size);
>   }
>
> +static unsigned long get_fadump_metadata_size(void)
> +{
> +	unsigned long size = 0;
> +
> +	/*
> +	 * If fadump is active then look into fdm_active to get metadata
> +	 * size set by previous kernel.
> +	 */
> +	if (fw_dump.dump_active) {
> +		size = fdm_active->cpu_state_data.destination_address -
> +				fdm_active->metadata_region.source_address;
> +		goto out;
> +	}
> +	size += sizeof(struct fadump_crash_info_header);
> +	size += sizeof(struct elfhdr); /* ELF core header.*/
> +	size += sizeof(struct elf_phdr); /* place holder for cpu notes */
> +	/* Program headers for crash memory regions. */
> +	size += sizeof(struct elf_phdr) * (memblock_num_regions(memory) + 2);
> +
> +	size = PAGE_ALIGN(size);
> +out:
> +	pr_debug("fadump Metadata size is %ld\n", size);
> +	return size;
> +}
> +
>   static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
>   				unsigned long addr)
>   {
> +	uint16_t num_sections = 0;
> +	unsigned long metadata_base = 0;
> +
>   	if (!fdm)
>   		return 0;
>
> +	/* Skip the fadump metadata area. */
> +	metadata_base = addr;
> +	addr += get_fadump_metadata_size();
> +
>   	memset(fdm, 0, sizeof(struct fadump_mem_struct));
>   	addr = addr & PAGE_MASK;
>
>   	fdm->header.dump_format_version = cpu_to_be32(0x00000001);
> -	fdm->header.dump_num_sections = cpu_to_be16(3);
>   	fdm->header.dump_status_flag = 0;
>   	fdm->header.offset_first_dump_section =
>   		cpu_to_be32((u32)offsetof(struct fadump_mem_struct, cpu_state_data));
> @@ -222,6 +253,7 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
>   	fdm->cpu_state_data.source_address = 0;
>   	fdm->cpu_state_data.source_len = cpu_to_be64(fw_dump.cpu_state_data_size);
>   	fdm->cpu_state_data.destination_address = cpu_to_be64(addr);
> +	num_sections++;
>   	addr += fw_dump.cpu_state_data_size;
>
>   	/* hpte region section */
> @@ -230,6 +262,7 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
>   	fdm->hpte_region.source_address = 0;
>   	fdm->hpte_region.source_len = cpu_to_be64(fw_dump.hpte_region_size);
>   	fdm->hpte_region.destination_address = cpu_to_be64(addr);
> +	num_sections++;
>   	addr += fw_dump.hpte_region_size;
>
>   	/* RMA region section */
> @@ -238,8 +271,25 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
>   	fdm->rmr_region.source_address = cpu_to_be64(RMA_START);
>   	fdm->rmr_region.source_len = cpu_to_be64(fw_dump.boot_memory_size);
>   	fdm->rmr_region.destination_address = cpu_to_be64(addr);
> +	num_sections++;
>   	addr += fw_dump.boot_memory_size;
>
> +	/*
> +	 * fadump metadata section.
> +	 * Add an entry with source len a zero. We are only intereseted in
> +	 * source address which will help us to detect the location of
> +	 * metadata area where faump header and elf core header is placed.
> +	 */
> +	fdm->metadata_region.request_flag = cpu_to_be32(FADUMP_REQUEST_FLAG);
> +	fdm->metadata_region.source_data_type =
> +					cpu_to_be16(FADUMP_REAL_MODE_REGION);
> +	fdm->metadata_region.source_address = cpu_to_be64(metadata_base);
> +	fdm->metadata_region.source_len = 0;
> +	fdm->metadata_region.destination_address = cpu_to_be64(addr);
> +	num_sections++;
> +
> +	fdm->header.dump_num_sections = cpu_to_be16(num_sections);
> +	BUILD_BUG_ON(num_sections != FADUMP_NUM_SECTIONS);
>   	return addr;
>   }
>
> @@ -325,16 +375,17 @@ static unsigned long get_fadump_area_size(void)
>   	size += fw_dump.cpu_state_data_size;
>   	size += fw_dump.hpte_region_size;
>   	size += fw_dump.boot_memory_size;
> -	size += sizeof(struct fadump_crash_info_header);
> -	size += sizeof(struct elfhdr); /* ELF core header.*/
> -	size += sizeof(struct elf_phdr); /* place holder for cpu notes */
> -	/* Program headers for crash memory regions. */
> -	size += sizeof(struct elf_phdr) * (memblock_num_regions(memory) + 2);
> -
> +	size += get_fadump_metadata_size();
>   	size = PAGE_ALIGN(size);
>   	return size;
>   }
>
> +static inline unsigned long get_fadump_metadata_base(
> +			const struct fadump_mem_struct *fdm)
> +{
> +	return be64_to_cpu(fdm->metadata_region.source_address);
> +}
> +
>   int __init fadump_reserve_mem(void)
>   {
>   	unsigned long base, size, memory_boundary;
> @@ -395,9 +446,9 @@ int __init fadump_reserve_mem(void)
>   				(unsigned long)(size >> 20),
>   				(unsigned long)(base >> 20));
>
> -		fw_dump.fadumphdr_addr =
> -				be64_to_cpu(fdm_active->rmr_region.destination_address) +
> -				be64_to_cpu(fdm_active->rmr_region.source_len);
> +		pr_info("Number of kernel Dump sections: %d\n",
> +			be16_to_cpu(fdm_active->header.dump_num_sections));
> +		fw_dump.fadumphdr_addr = get_fadump_metadata_base(fdm_active);
>   		pr_debug("fadumphdr_addr = %p\n",
>   				(void *) fw_dump.fadumphdr_addr);
>   	} else {
> @@ -803,14 +854,24 @@ static int __init fadump_build_cpu_notes(const struct fadump_mem_struct *fdm)
>   static int __init process_fadump(const struct fadump_mem_struct *fdm_active)
>   {
>   	struct fadump_crash_info_header *fdh;
> +	uint16_t num_sections = 0;
>   	int rc = 0;
>
>   	if (!fdm_active || !fw_dump.fadumphdr_addr)
>   		return -EINVAL;
>
> +	/* Check if platform has honored all 4 dump sections requested. */
> +	num_sections = be16_to_cpu(fdm_active->header.dump_num_sections);
> +	if (num_sections < FADUMP_NUM_SECTIONS) {
> +		printk(KERN_ERR "Dump taken by platform does not "
> +				"contain all requested sections\n");
> +		return -EINVAL;
> +	}
> +
>   	/* Check if the dump data is valid. */
>   	if ((be16_to_cpu(fdm_active->header.dump_status_flag) == FADUMP_ERROR_FLAG) ||
>   			(fdm_active->cpu_state_data.error_flags != 0) ||
> +			(fdm_active->metadata_region.error_flags != 0) ||
>   			(fdm_active->rmr_region.error_flags != 0)) {
>   		printk(KERN_ERR "Dump taken by platform is not valid\n");
>   		return -EINVAL;
> @@ -821,6 +882,11 @@ static int __init process_fadump(const struct fadump_mem_struct *fdm_active)
>   		printk(KERN_ERR "Dump taken by platform is incomplete\n");
>   		return -EINVAL;
>   	}
> +	if ((fdm_active->metadata_region.bytes_dumped !=
> +			fdm_active->metadata_region.source_len)) {
> +		printk(KERN_ERR "Dump taken by platform is incomplete\n");
> +		return -EINVAL;
> +	}
>
>   	/* Validate the fadump crash info header */
>   	fdh = __va(fw_dump.fadumphdr_addr);
> @@ -1082,7 +1148,7 @@ static int register_fadump(void)
>
>   	fadump_setup_crash_memory_ranges();
>
> -	addr = be64_to_cpu(fdm.rmr_region.destination_address) + be64_to_cpu(fdm.rmr_region.source_len);
> +	addr = get_fadump_metadata_base(&fdm);
>   	/* Initialize fadump crash info header. */
>   	addr = init_fadump_header(addr);
>   	vaddr = __va(addr);
> @@ -1153,7 +1219,7 @@ void fadump_cleanup(void)
>   	/* Invalidate the registration only if dump is active. */
>   	if (fw_dump.dump_active) {
>   		init_fadump_mem_struct(&fdm,
> -			be64_to_cpu(fdm_active->cpu_state_data.destination_address));
> +				get_fadump_metadata_base(fdm_active));
>   		fadump_invalidate_dump(&fdm);
>   	}
>   }
> @@ -1236,7 +1302,7 @@ static void fadump_invalidate_release_mem(void)
>   		return;
>   	}
>
> -	destination_address = be64_to_cpu(fdm_active->cpu_state_data.destination_address);
> +	destination_address = get_fadump_metadata_base(fdm_active);
>   	fadump_cleanup();
>   	mutex_unlock(&fadump_mutex);
>
>
