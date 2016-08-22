Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHf4f0tt5zDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 13:21:54 +1000 (AEST)
Date: Mon, 22 Aug 2016 11:21:35 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-ima-devel@lists.sourceforge.net,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>,
 Petko Manolov <petkan@mip-labs.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 David Laight <David.Laight@ACULAB.COM>,
 Eric Biederman <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/6] powerpc: kexec_file: Add buffer hand-over support
 for the next kernel
Message-ID: <20160822032135.GB30489@dhcp-128-65.nay.redhat.com>
References: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1471058305-30198-3-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471058305-30198-3-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/13/16 at 12:18am, Thiago Jung Bauermann wrote:
> The buffer hand-over mechanism allows the currently running kernel to pass
> data to kernel that will be kexec'd via a kexec segment. The second kernel
> can check whether the previous kernel sent data and retrieve it.
> 
> This is the architecture-specific part.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kexec.h       |  12 +++-
>  arch/powerpc/kernel/kexec_elf_64.c     |   2 +-
>  arch/powerpc/kernel/machine_kexec_64.c | 114 +++++++++++++++++++++++++++++++--
>  3 files changed, 120 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index 31bc64e07c8f..b20738df26f8 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -92,12 +92,20 @@ static inline bool kdump_in_progress(void)
>  }
>  
>  #ifdef CONFIG_KEXEC_FILE
> +#define ARCH_HAS_KIMAGE_ARCH
> +
> +struct kimage_arch {
> +	phys_addr_t handover_buffer_addr;
> +	unsigned long handover_buffer_size;
> +};
> +
>  int setup_purgatory(struct kimage *image, const void *slave_code,
>  		    const void *fdt, unsigned long kernel_load_addr,
>  		    unsigned long fdt_load_addr, unsigned long stack_top,
>  		    int debug);
> -int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
> -		  unsigned long initrd_len, const char *cmdline);
> +int setup_new_fdt(const struct kimage *image, void *fdt,
> +		  unsigned long initrd_load_addr, unsigned long initrd_len,
> +		  const char *cmdline);
>  bool find_debug_console(const void *fdt, int chosen_node);
>  int merge_partial_dtb(void *to, const void *from);
>  #endif /* CONFIG_KEXEC_FILE */
> diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
> index 1b902ad66e2a..22afc7b5ee73 100644
> --- a/arch/powerpc/kernel/kexec_elf_64.c
> +++ b/arch/powerpc/kernel/kexec_elf_64.c
> @@ -219,7 +219,7 @@ void *elf64_load(struct kimage *image, char *kernel_buf,
>  		}
>  	}
>  
> -	ret = setup_new_fdt(fdt, initrd_load_addr, initrd_len, cmdline);
> +	ret = setup_new_fdt(image, fdt, initrd_load_addr, initrd_len, cmdline);
>  	if (ret)
>  		goto out;
>  
> diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
> index a484a6346146..190c652e49b7 100644
> --- a/arch/powerpc/kernel/machine_kexec_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_64.c
> @@ -490,6 +490,60 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  	return image->fops->cleanup(image->image_loader_data);
>  }
>  
> +bool kexec_can_hand_over_buffer(void)
> +{
> +	return true;
> +}
> +
> +int arch_kexec_add_handover_buffer(struct kimage *image,
> +				   unsigned long load_addr, unsigned long size)
> +{
> +	image->arch.handover_buffer_addr = load_addr;
> +	image->arch.handover_buffer_size = size;
> +
> +	return 0;
> +}
> +
> +int kexec_get_handover_buffer(void **addr, unsigned long *size)
> +{
> +	int ret;
> +	u64 start_addr, end_addr;
> +
> +	ret = of_property_read_u64(of_chosen,
> +				   "linux,kexec-handover-buffer-start",
> +				   &start_addr);
> +	if (ret == -EINVAL)
> +		return -ENOENT;
> +	else if (ret)
> +		return -EINVAL;
> +
> +	ret = of_property_read_u64(of_chosen, "linux,kexec-handover-buffer-end",
> +				   &end_addr);
> +	if (ret == -EINVAL)
> +		return -ENOENT;
> +	else if (ret)
> +		return -EINVAL;
> +
> +	*addr =  __va(start_addr);
> +	/* -end is the first address after the buffer. */
> +	*size = end_addr - start_addr;
> +
> +	return 0;
> +}

This depends on dtb, so if IMA want to extend it to arches like x86 in
the future you will have to think about other way to pass it.

How about think about a general way now?

> +
> +int kexec_free_handover_buffer(void)
> +{
> +	int ret;
> +	void *addr;
> +	unsigned long size;
> +
> +	ret = kexec_get_handover_buffer(&addr, &size);
> +	if (ret)
> +		return ret;
> +
> +	return memblock_free((phys_addr_t) addr, size);
> +}
> +
>  /**
>   * arch_kexec_walk_mem() - call func(data) for each unreserved memory block
>   * @kbuf:	Context info for the search. Also passed to @func.
> @@ -687,9 +741,52 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
>  	return 0;
>  }
>  
> -/*
> - * setup_new_fdt() - modify /chosen and memory reservation for the next kernel
> - * @fdt:
> +/**
> + * setup_handover_buffer() - add properties and reservation for the handover buffer
> + * @image:		kexec image being loaded.
> + * @fdt:		Flattened device tree for the next kernel.
> + * @chosen_node:	Offset to the chosen node.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +static int setup_handover_buffer(const struct kimage *image, void *fdt,
> +				 int chosen_node)
> +{
> +	int ret;
> +
> +	if (image->arch.handover_buffer_addr == 0)
> +		return 0;
> +
> +	ret = fdt_setprop_u64(fdt, chosen_node,
> +			      "linux,kexec-handover-buffer-start",
> +			      image->arch.handover_buffer_addr);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	/* -end is the first address after the buffer. */
> +	ret = fdt_setprop_u64(fdt, chosen_node,
> +			      "linux,kexec-handover-buffer-end",
> +			      image->arch.handover_buffer_addr +
> +			      image->arch.handover_buffer_size);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	ret = fdt_add_mem_rsv(fdt, image->arch.handover_buffer_addr,
> +			      image->arch.handover_buffer_size);
> +	if (ret)
> +		return -EINVAL;
> +
> +	pr_debug("kexec handover buffer at 0x%llx, size = 0x%lx\n",
> +		 image->arch.handover_buffer_addr,
> +		 image->arch.handover_buffer_size);
> +
> +	return 0;
> +}
> +
> +/**
> + * setup_new_fdt() - modify /chosen and memory reservations for the next kernel
> + * @image:		kexec image being loaded.
> + * @fdt:		Flattened device tree for the next kernel.
>   * @initrd_load_addr:	Address where the next initrd will be loaded.
>   * @initrd_len:		Size of the next initrd, or 0 if there will be none.
>   * @cmdline:		Command line for the next kernel, or NULL if there will
> @@ -697,8 +794,9 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
>   *
>   * Return: 0 on success, or negative errno on error.
>   */
> -int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
> -		  unsigned long initrd_len, const char *cmdline)
> +int setup_new_fdt(const struct kimage *image, void *fdt,
> +		  unsigned long initrd_load_addr, unsigned long initrd_len,
> +		  const char *cmdline)
>  {
>  	uint64_t oldfdt_addr;
>  	int i, ret, chosen_node;
> @@ -847,6 +945,12 @@ int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
>  		}
>  	}
>  
> +	ret = setup_handover_buffer(image, fdt, chosen_node);
> +	if (ret) {
> +		pr_err("Error setting up the new device tree.\n");
> +		return ret;
> +	}
> +
>  	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
>  	if (ret) {
>  		pr_err("Error setting up the new device tree.\n");
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
