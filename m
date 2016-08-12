Return-Path: <sam@mendozajonas.com>
Received: from mendozajonas.com (mendozajonas.com [188.166.185.233])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9R4Q0mybzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 10:45:09 +1000 (AEST)
Message-ID: <1470962700.2570.6.camel@mendozajonas.com>
Subject: Re: [PATCH v5 11/13] powerpc: Allow userspace to set device tree
 properties in kexec_file_load
From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 kexec@lists.infradead.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>,  linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Eric Biederman
 <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young
 <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal
 <vgoyal@redhat.com>
Date: Fri, 12 Aug 2016 10:45:00 +1000
In-Reply-To: <1470956898-5991-12-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956898-5991-12-git-send-email-bauerman@linux.vnet.ibm.com>
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

On Thu, 2016-08-11 at 20:08 -0300, Thiago Jung Bauermann wrote:
> Implement the arch_kexec_verify_buffer hook to verify that a device
> tree blob passed by userspace via kexec_file_load contains only nodes
> and properties from a whitelist.
> 
> In elf64_load we merge those properties into the device tree that
> will be passed to the next kernel.
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kexec.h       |   1 +
>  arch/powerpc/kernel/kexec_elf_64.c     |   9 ++
>  arch/powerpc/kernel/machine_kexec_64.c | 242 +++++++++++++++++++++++++++++++++
>  3 files changed, 252 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index f263cc867891..31bc64e07c8f 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -99,6 +99,7 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
>  int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
>                   unsigned long initrd_len, const char *cmdline);
>  bool find_debug_console(const void *fdt, int chosen_node);
> +int merge_partial_dtb(void *to, const void *from);
>  #endif /* CONFIG_KEXEC_FILE */
>  
>  #else /* !CONFIG_KEXEC */
> diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
> index 49cba9509464..1b902ad66e2a 100644
> --- a/arch/powerpc/kernel/kexec_elf_64.c
> +++ b/arch/powerpc/kernel/kexec_elf_64.c
> @@ -210,6 +210,15 @@ void *elf64_load(struct kimage *image, char *kernel_buf,
>                 goto out;
>         }
>  
> +       /* Add nodes and properties from the DTB passed by userspace. */
> +       if (image->dtb_buf) {
> +               ret = merge_partial_dtb(fdt, image->dtb_buf);
> +               if (ret) {
> +                       pr_err("Error merging partial device tree.\n");
> +                       goto out;
> +               }
> +       }
> +
>         ret = setup_new_fdt(fdt, initrd_load_addr, initrd_len, cmdline);
>         if (ret)
>                 goto out;
> diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
> index 527f98efe651..a484a6346146 100644
> --- a/arch/powerpc/kernel/machine_kexec_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_64.c
> @@ -35,6 +35,7 @@
>  #include <asm/kexec_elf_64.h>
>  
>  #define SLAVE_CODE_SIZE                256
> +#define MAX_DT_PATH            512
>  
>  #ifdef CONFIG_KEXEC_FILE
>  static struct kexec_file_ops *kexec_file_loaders[] = {
> @@ -908,4 +909,245 @@ bool find_debug_console(const void *fdt, int chosen_node)
>         return false;
>  }
>  
> +/**
> + * struct allowed_node - a node in the whitelist and its allowed properties.
> + * @name:              node name or full node path
> + * @properties:                NULL-terminated array of names or name=value pairs
> + *
> + * If name starts with /, then the node has to be at the specified path in
> + * the device tree (including unit addresses for all nodes in the path).
> + * If it doesn't, then the node can be anywhere in the device tree.
> + *
> + * An entry in properties can specify a string value that the property must
> + * have by using the "name=value" format. If the entry ends with =, it means
> + * that the property must be empty.
> + */
> +static struct allowed_node {
> +       const char *name;
> +       const char *properties[9];
> +} allowed_nodes[] = {
> +       {
> +               .name = "/chosen",
> +               .properties = {
> +                       "stdout-path",
> +                       "linux,stdout-path",
> +                       NULL,
> +               }
> +       },
> +       {
> +               .name = "vga",
> +               .properties = {
> +                       "device_type=display",
> +                       "assigned-addresses",
> +                       "width",
> +                       "height",
> +                       "depth",
> +                       "little-endian=",
> +                       "linux,opened=",
> +                       "linux,boot-display=",ss
> +                       NULL,
> +               }
> +       },
> +};

Hi Thiago,

As much as this solves problems for *me*, I suspect adding 'vga' here
might be the subject of some discussion. Having /chosen whitelisted makes
sense on it's own, but 'vga' and its properties are very specific without
much explanation.

If everyone's happy to have it there, cool! If not, I have the majority
of a patch that handles the original reason for these property updates
separately in the kernel rather than from userspace. If needed I'll clean
it up and we can handle it that way.

Cheers,
Sam
