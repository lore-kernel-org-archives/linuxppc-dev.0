Return-Path: <srs0=hwms=cv=c-s.fr=christophe.leroy@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yj9jF1gmkzDrK2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 18:21:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yj9jF1FCZz8tRN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 18:21:05 +1100 (AEDT)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yj9jD32KQz9t2M
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 18:21:03 +1100 (AEDT)
Subject: Re: [PATCH v6 06/10] powerpc/lib/code-patching: Use alternate map for
 patch_instruction()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 Balbir Singh <bsingharora@gmail.com>
References: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
 <1499086914-25695-6-git-send-email-mpe@ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <c89803a4-3d43-d24c-171c-75a42a48f59d@c-s.fr>
Date: Thu, 23 Nov 2017 08:12:58 +0100
MIME-Version: 1.0
In-Reply-To: <1499086914-25695-6-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 03/07/2017 à 15:01, Michael Ellerman a écrit :
> From: Balbir Singh <bsingharora@gmail.com>
> 
> This patch creates the window using text_poke_area, allocated via
> get_vm_area(). text_poke_area is per CPU to avoid locking.
> text_poke_area for each cpu is setup using late_initcall, prior to
> setup of these alternate mapping areas, we continue to use direct
> write to change/modify kernel text. With the ability to use alternate
> mappings to write to kernel text, it provides us the freedom to then
> turn text read-only and implement CONFIG_STRICT_KERNEL_RWX.
> 
> This code is CPU hotplug aware to ensure that the we have mappings for
> any new cpus as they come online and tear down mappings for any CPUs
> that go offline.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   arch/powerpc/lib/code-patching.c | 171 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 167 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 500b0f6a0b64..c9de03e0c1f1 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -12,23 +12,186 @@
>   #include <linux/vmalloc.h>
>   #include <linux/init.h>
>   #include <linux/mm.h>
> -#include <asm/page.h>
> -#include <asm/code-patching.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/slab.h>
>   #include <linux/uaccess.h>
>   #include <linux/kprobes.h>
>   
> +#include <asm/pgtable.h>
> +#include <asm/tlbflush.h>
> +#include <asm/page.h>
> +#include <asm/code-patching.h>
>   
> -int patch_instruction(unsigned int *addr, unsigned int instr)
> +static int __patch_instruction(unsigned int *addr, unsigned int instr)
>   {
>   	int err;
>   
>   	__put_user_size(instr, addr, 4, err);
>   	if (err)
>   		return err;
> -	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" : : "r" (addr));
> +
> +	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" :: "r" (addr));
> +
> +	return 0;
> +}
> +

[...]

> +int patch_instruction(unsigned int *addr, unsigned int instr)
> +{
> +	int err;
> +	unsigned int *dest = NULL;
> +	unsigned long flags;
> +	unsigned long text_poke_addr;
> +	unsigned long kaddr = (unsigned long)addr;
> +
> +	/*
> +	 * During early early boot patch_instruction is called
> +	 * when text_poke_area is not ready, but we still need
> +	 * to allow patching. We just do the plain old patching
> +	 * We use slab_is_available and per cpu read * via this_cpu_read
> +	 * of text_poke_area. Per-CPU areas might not be up early
> +	 * this can create problems with just using this_cpu_read()
> +	 */
> +	if (!slab_is_available() || !this_cpu_read(text_poke_area))
> +		return __patch_instruction(addr, instr);
> +
> +	local_irq_save(flags);
> +
> +	text_poke_addr = (unsigned long)__this_cpu_read(text_poke_area)->addr;
> +	if (map_patch_area(addr, text_poke_addr)) {
> +		err = -1;
> +		goto out;
> +	}
> +
> +	dest = (unsigned int *)(text_poke_addr) +
> +			((kaddr & ~PAGE_MASK) / sizeof(unsigned int));
> +
> +	/*
> +	 * We use __put_user_size so that we can handle faults while
> +	 * writing to dest and return err to handle faults gracefully
> +	 */
> +	__put_user_size(instr, dest, 4, err);
> +	if (!err)
> +		asm ("dcbst 0, %0; sync; icbi 0,%0; icbi 0,%1; sync; isync"
> +			::"r" (dest), "r"(addr));

Is the second icbi really needed since the alternative area is mapped 
with PAGE_KERNEL which is not executable ?
If we could avoid that, we could refactor this part as follows:

diff --git a/arch/powerpc/lib/code-patching.c 
b/arch/powerpc/lib/code-patching.c
index d469224c4ada..85031de43bb9 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -23,15 +23,17 @@
  #include <asm/code-patching.h>
  #include <asm/setup.h>

-static int __patch_instruction(unsigned int *addr, unsigned int instr)
+static int __patch_instruction(unsigned int *addr, unsigned int instr,
+			       unsigned int *dest)
  {
  	int err;

-	__put_user_size(instr, addr, 4, err);
+	__put_user_size(instr, dest, 4, err);
  	if (err)
  		return err;

-	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" :: "r" (addr));
+	asm ("dcbst 0, %0; sync; icbi 0,%1; sync; isync" :: "r" (dest),
+							    "r" (addr));

  	return 0;
  }
@@ -149,7 +151,7 @@ int patch_instruction(unsigned int *addr, unsigned 
int instr)
  	 * to allow patching. We just do the plain old patching
  	 */
  	if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
-		return __patch_instruction(addr, instr);
+		return __patch_instruction(addr, instr, addr);

  	local_irq_save(flags);

@@ -162,14 +164,7 @@ int patch_instruction(unsigned int *addr, unsigned 
int instr)
  	dest = (unsigned int *)(text_poke_addr) +
  			((kaddr & ~PAGE_MASK) / sizeof(unsigned int));

-	/*
-	 * We use __put_user_size so that we can handle faults while
-	 * writing to dest and return err to handle faults gracefully
-	 */
-	__put_user_size(instr, dest, 4, err);
-	if (!err)
-		asm ("dcbst 0, %0; sync; icbi 0,%0; icbi 0,%1; sync; isync"
-			::"r" (dest), "r"(addr));
+	__patch_instruction(addr, instr, dest);

  	err = unmap_patch_area(text_poke_addr);
  	if (err)
@@ -184,7 +179,7 @@ int patch_instruction(unsigned int *addr, unsigned 
int instr)

  int patch_instruction(unsigned int *addr, unsigned int instr)
  {
-	return __patch_instruction(addr, instr);
+	return __patch_instruction(addr, instr, addr);
  }

  #endif /* CONFIG_STRICT_KERNEL_RWX */


> +
> +	err = unmap_patch_area(text_poke_addr);
> +	if (err)
> +		pr_warn("failed to unmap %lx\n", text_poke_addr);
> +
> +out:
> +	local_irq_restore(flags);
> +
> +	return err;
> +}
> +#else /* !CONFIG_STRICT_KERNEL_RWX */
> +
> +int patch_instruction(unsigned int *addr, unsigned int instr)
> +{
> +	return __patch_instruction(addr, instr);
> +}
> +
> +#endif /* CONFIG_STRICT_KERNEL_RWX */
> +NOKPROBE_SYMBOL(patch_instruction);
> +
>   int patch_branch(unsigned int *addr, unsigned long target, int flags)
>   {
>   	return patch_instruction(addr, create_branch(addr, target, flags));
> 
