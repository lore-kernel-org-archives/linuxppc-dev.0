Return-Path: <horms@verge.net.au>
Received: from koto.vergenet.net (koto.vergenet.net [210.128.90.7])
	by ozlabs.org (Postfix) with ESMTP id 0314CB7D29
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 12:38:47 +1000 (EST)
Date: Wed, 16 Jun 2010 11:38:44 +0900
From: Simon Horman <horms@verge.net.au>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: [PATCH] Restore kexec uImage-ppc to working state
Message-ID: <20100616023844.GC28659@verge.net.au>
References: <1276544322-30412-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1276544322-30412-1-git-send-email-msm@freescale.com>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CCed linuxppc-dev to fish for an ack.

On Mon, Jun 14, 2010 at 02:38:42PM -0500, Matthew McClintock wrote:
> Booting with uImage-ppc was broken by previous work, this
> patch should restore it to working order
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
>  kexec/arch/ppc/kexec-ppc.c         |   68 ++++++++++++++++++++++-------------
>  kexec/arch/ppc/kexec-uImage-ppc.c  |    5 +--
>  purgatory/arch/ppc/purgatory-ppc.c |    5 +++
>  3 files changed, 49 insertions(+), 29 deletions(-)
> 
> diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
> index 55cadd6..c073f56 100644
> --- a/kexec/arch/ppc/kexec-ppc.c
> +++ b/kexec/arch/ppc/kexec-ppc.c
> @@ -261,11 +261,28 @@ static int get_base_ranges(void)
>  					break;
>  				}
>  			}
> -			base_memory_range[local_memory_ranges].start =
> -				((uint32_t *)buf)[0];
> -			base_memory_range[local_memory_ranges].end  =
> -				base_memory_range[local_memory_ranges].start +
> -				((uint32_t *)buf)[1];
> +
> +			if (n == 8)
> +			{
> +				base_memory_range[local_memory_ranges].start =
> +					((uint32_t *)buf)[0];
> +				base_memory_range[local_memory_ranges].end  =
> +					base_memory_range[local_memory_ranges].start +
> +					((uint32_t *)buf)[1];
> +			}
> +			else if (n == 16)
> +			{
> +				base_memory_range[local_memory_ranges].start =
> +                                        ((uint64_t *)buf)[0];
> +                                base_memory_range[local_memory_ranges].end  =
> +                                        base_memory_range[local_memory_ranges].start +
> +                                        ((uint64_t *)buf)[1];
> +			}
> +			else
> +			{
> +				fprintf(stderr, "Mem node has invalid size: %d\n", n);
> +				return -1;
> +			}
>  			base_memory_range[local_memory_ranges].type = RANGE_RAM;
>  			local_memory_ranges++;
>  			dbgprintf("%016llx-%016llx : %x\n",
> @@ -327,27 +344,28 @@ static int get_devtree_details(unsigned long kexec_flags)
>  		}
>  
>  		if (strncmp(dentry->d_name, "chosen", 6) == 0) {
> -			strcat(fname, "/linux,kernel-end");
> -			file = fopen(fname, "r");
> -			if (!file) {
> -				perror(fname);
> -				goto error_opencdir;
> -			}
> -			if (fread(&tmp_long, sizeof(unsigned long), 1, file)
> -					!= 1) {
> -				perror(fname);
> -				goto error_openfile;
> -			}
> -			kernel_end = tmp_long;
> -			fclose(file);
> -
> -			/* Add kernel memory to exclude_range */
> -			exclude_range[i].start = 0x0UL;
> -			exclude_range[i].end = kernel_end;
> -			i++;
> -			if (i >= max_memory_ranges)
> -				realloc_memory_ranges();
> +			/* only reserve kernel region if we are doing a crash kernel */
>  			if (kexec_flags & KEXEC_ON_CRASH) {
> +				strcat(fname, "/linux,kernel-end");
> +				file = fopen(fname, "r");
> +				if (!file) {
> +					perror(fname);
> +					goto error_opencdir;
> +				}
> +				if (fread(&tmp_long, sizeof(unsigned long), 1, file)
> +						!= 1) {
> +					perror(fname);
> +					goto error_openfile;
> +				}
> +				kernel_end = tmp_long;
> +				fclose(file);
> +
> +				/* Add kernel memory to exclude_range */
> +				exclude_range[i].start = 0x0UL;
> +				exclude_range[i].end = kernel_end;
> +				i++;
> +				if (i >= max_memory_ranges)
> +					realloc_memory_ranges();
>  				memset(fname, 0, sizeof(fname));
>  				strcpy(fname, device_tree);
>  				strcat(fname, dentry->d_name);
> diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
> index 45cde2f..4a8d28d 100644
> --- a/kexec/arch/ppc/kexec-uImage-ppc.c
> +++ b/kexec/arch/ppc/kexec-uImage-ppc.c
> @@ -133,13 +133,10 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
>  	addr = dtb_addr;
>  	elf_rel_set_symbol(&info->rhdr, "dt_offset", &addr, sizeof(addr));
>  
> -	addr = rmo_top;
> -	elf_rel_set_symbol(&info->rhdr, "mem_size", &addr, sizeof(addr));
> -
>  #define PUL_STACK_SIZE  (16 * 1024)
>  	addr = locate_hole(info, PUL_STACK_SIZE, 0, 0, -1, 1);
>  	addr += PUL_STACK_SIZE;
> -	elf_rel_set_symbol(&info->rhdr, "pul_stack", &addr, sizeof(addr));
> +	elf_rel_set_symbol(&info->rhdr, "stack", &addr, sizeof(addr));
>  	/* No allocation past here in order not to overwrite the stack */
>  #undef PUL_STACK_SIZE
>  
> diff --git a/purgatory/arch/ppc/purgatory-ppc.c b/purgatory/arch/ppc/purgatory-ppc.c
> index 3d7d484..349e750 100644
> --- a/purgatory/arch/ppc/purgatory-ppc.c
> +++ b/purgatory/arch/ppc/purgatory-ppc.c
> @@ -39,3 +39,8 @@ void post_verification_setup_arch(void)
>  	if (panic_kernel)
>  		crashdump_backup_memory();
>  }
> +
> +void crashdump_backup_memory(void)
> +{
> +	return;
> +}
> -- 
> 1.6.0.6
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
