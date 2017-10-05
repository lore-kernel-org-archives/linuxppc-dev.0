Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x243.google.com (mail-vk0-x243.google.com
 [IPv6:2607:f8b0:400c:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7S2J46SzzDqhb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 09:22:46 +1100 (AEDT)
Received: by mail-vk0-x243.google.com with SMTP id q75so4609629vkf.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Oct 2017 15:22:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171005190317.GA98302@beast>
References: <20171005190317.GA98302@beast>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 6 Oct 2017 09:22:43 +1100
Message-ID: <CAKTCnznf2z6oQ_YO0YK+yeh_CX+gc47AvxA929LP=6NPiP8FjA@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: Default to enabling STRICT_KERNEL_RWX
To: Kees Cook <keescook@chromium.org>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 6, 2017 at 6:03 AM, Kees Cook <keescook@chromium.org> wrote:
> When available, CONFIG_KERNEL_RWX should be default-enabled for PPC64.
> On PPC32, there is a performance trade-off.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe LEROY <christophe.leroy@c-s.fr>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2:
> - depend on PPC64, as noted by Christophe.
> ---
>  arch/powerpc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 809c468edab1..4315c9b2db4f 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -178,6 +178,7 @@ config PPC
>         select HAVE_ARCH_TRACEHOOK
>         select ARCH_HAS_STRICT_KERNEL_RWX       if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
>         select ARCH_OPTIONAL_KERNEL_RWX         if ARCH_HAS_STRICT_KERNEL_RWX
> +       select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if PPC64

We usually have CONFIG_RELOCATABLE on - on most configs. Our STRICT
RWX depends on !RELOCATABLE as you've seen. I have patches to fix
STRICT_KERNEL_RWX on CONFIG_RELOCATABLE

https://patchwork.ozlabs.org/patch/795744/ (I need to rebase this to
use generic helpers we have to convert an mm,addr to pte)
Aside, I also have set_memory_xx at
https://patchwork.ozlabs.org/patch/796183/ (again I need to rebase
them)

I hope to get to them next week, hopefully

Balbir Singh.
