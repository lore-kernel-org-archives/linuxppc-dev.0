Return-Path: <srs0=z+6r=hw=gmail.com=mathieu.malaterre@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cPPf2NlRzF2X5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 04:51:34 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40cPPf1dNKz8sy1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 04:51:34 +1000 (AEST)
Received: from mail-ot0-x244.google.com (mail-ot0-x244.google.com
 [IPv6:2607:f8b0:4003:c0f::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40cPPd50lGz9s3G
 for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2018 04:51:33 +1000 (AEST)
Received: by mail-ot0-x244.google.com with SMTP id j27-v6so21818996ota.5
 for <linuxppc-dev@ozlabs.org>; Thu, 03 May 2018 11:51:33 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <20180502132051.28861-1-mpe@ellerman.id.au>
References: <20180502132051.28861-1-mpe@ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 3 May 2018 20:51:10 +0200
Message-ID: <CA+7wUswY3wCj7ZGuRhuZOmciDBsgpzFXMJZeZTo=iMxbb1cJrA@mail.gmail.com>
Subject: Re: [PATCH 1/6] powerpc/syscalls: Switch trivial cases to
 SYSCALL_DEFINE
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 2, 2018 at 3:20 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>

Maybe add:

Link: https://github.com/linuxppc/linux/issues/131

For the series: compile, build without error (W=1), and works on my system.

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/powerpc/kernel/pci_32.c               | 6 +++---
>  arch/powerpc/kernel/pci_64.c               | 4 ++--
>  arch/powerpc/mm/subpage-prot.c             | 4 +++-
>  arch/powerpc/platforms/cell/spu_syscalls.c | 3 ++-
>  4 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> index 85ad2f78b889..af36e46c3ed6 100644
> --- a/arch/powerpc/kernel/pci_32.c
> +++ b/arch/powerpc/kernel/pci_32.c
> @@ -16,6 +16,7 @@
>  #include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/export.h>
> +#include <linux/syscalls.h>
>
>  #include <asm/processor.h>
>  #include <asm/io.h>
> @@ -283,7 +284,8 @@ pci_bus_to_hose(int bus)
>   * Note that the returned IO or memory base is a physical address
>   */
>
> -long sys_pciconfig_iobase(long which, unsigned long bus, unsigned long devfn)
> +SYSCALL_DEFINE3(pciconfig_iobase, long, which,
> +               unsigned long, bus, unsigned long, devfn)
>  {
>         struct pci_controller* hose;
>         long result = -EOPNOTSUPP;
> @@ -307,5 +309,3 @@ long sys_pciconfig_iobase(long which, unsigned long bus, unsigned long devfn)
>
>         return result;
>  }
> -
> -
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index 15ce0306b092..dff28f903512 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -203,8 +203,8 @@ void pcibios_setup_phb_io_space(struct pci_controller *hose)
>  #define IOBASE_ISA_IO          3
>  #define IOBASE_ISA_MEM         4
>
> -long sys_pciconfig_iobase(long which, unsigned long in_bus,
> -                         unsigned long in_devfn)
> +SYSCALL_DEFINE3(pciconfig_iobase, long, which, unsigned long, in_bus,
> +                         unsigned long, in_devfn)
>  {
>         struct pci_controller* hose;
>         struct pci_bus *tmp_bus, *bus = NULL;
> diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
> index f14a07c2fb90..9d16ee251fc0 100644
> --- a/arch/powerpc/mm/subpage-prot.c
> +++ b/arch/powerpc/mm/subpage-prot.c
> @@ -13,6 +13,7 @@
>  #include <linux/types.h>
>  #include <linux/mm.h>
>  #include <linux/hugetlb.h>
> +#include <linux/syscalls.h>
>
>  #include <asm/pgtable.h>
>  #include <linux/uaccess.h>
> @@ -185,7 +186,8 @@ static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
>   * in a 2-bit field won't allow writes to a page that is otherwise
>   * write-protected.
>   */
> -long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
> +SYSCALL_DEFINE3(subpage_prot, unsigned long, addr,
> +               unsigned long, len, u32 __user *, map)
>  {
>         struct mm_struct *mm = current->mm;
>         struct subpage_prot_table *spt = &mm->context.spt;
> diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
> index 5e6e0bad6db6..263413a34823 100644
> --- a/arch/powerpc/platforms/cell/spu_syscalls.c
> +++ b/arch/powerpc/platforms/cell/spu_syscalls.c
> @@ -26,6 +26,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/rcupdate.h>
>  #include <linux/binfmts.h>
> +#include <linux/syscalls.h>
>
>  #include <asm/spu.h>
>
> @@ -90,7 +91,7 @@ SYSCALL_DEFINE4(spu_create, const char __user *, name, unsigned int, flags,
>         return ret;
>  }
>
> -asmlinkage long sys_spu_run(int fd, __u32 __user *unpc, __u32 __user *ustatus)
> +SYSCALL_DEFINE3(spu_run,int, fd, __u32 __user *, unpc, __u32 __user *, ustatus)
>  {
>         long ret;
>         struct fd arg;
> --
> 2.14.1
>
