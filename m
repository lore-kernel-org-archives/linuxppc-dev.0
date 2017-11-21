Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x241.google.com (mail-vk0-x241.google.com
 [IPv6:2607:f8b0:400c:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhLnv5jmXzDqyH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 10:07:15 +1100 (AEDT)
Received: by mail-vk0-x241.google.com with SMTP id h21so4708980vke.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 15:07:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171121142820.C744F6BB8F@po15668-vm-win7.idsi0.si.c-s.fr>
References: <20171121142820.C744F6BB8F@po15668-vm-win7.idsi0.si.c-s.fr>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 22 Nov 2017 10:07:11 +1100
Message-ID: <CAKTCnznviUQfizSdfMDGxO_8CFuwhPCNSkK2VagNSRvZdpLqyg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: fix boot on BOOK3S_32 with
 CONFIG_STRICT_KERNEL_RWX
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 Meelis Roos <mroos@linux.ee>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 22, 2017 at 1:28 AM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> On powerpc32, patch_instruction() is called by apply_feature_fixups()
> which is called from early_init()
>
> There is the following note in front of early_init():
>  * Note that the kernel may be running at an address which is different
>  * from the address that it was linked at, so we must use RELOC/PTRRELOC
>  * to access static data (including strings).  -- paulus
>
> Therefore, slab_is_available() cannot be called yet, and
> text_poke_area must be addressed with PTRRELOC()
>
> Fixes: 37bc3e5fd764f ("powerpc/lib/code-patching: Use alternate map
> for patch_instruction()")
> Reported-by: Meelis Roos <mroos@linux.ee>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: Added missing asm/setup.h
>
>  arch/powerpc/lib/code-patching.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index c9de03e0c1f1..d469224c4ada 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -21,6 +21,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/page.h>
>  #include <asm/code-patching.h>
> +#include <asm/setup.h>
>
>  static int __patch_instruction(unsigned int *addr, unsigned int instr)
>  {
> @@ -146,11 +147,8 @@ int patch_instruction(unsigned int *addr, unsigned int instr)
>          * During early early boot patch_instruction is called
>          * when text_poke_area is not ready, but we still need
>          * to allow patching. We just do the plain old patching
> -        * We use slab_is_available and per cpu read * via this_cpu_read
> -        * of text_poke_area. Per-CPU areas might not be up early
> -        * this can create problems with just using this_cpu_read()
>          */
> -       if (!slab_is_available() || !this_cpu_read(text_poke_area))
> +       if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>                 return __patch_instruction(addr, instr);

On ppc64, we call apply_feature_fixups() in early_setup() after we've
relocated ourselves. Sorry for missing the ppc32 case. I would like to
avoid PTRRELOC when unnecessary.

Balbir Singh.
