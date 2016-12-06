Return-Path: <keescook@google.com>
Received: from mail-io0-x236.google.com (mail-io0-x236.google.com
 [IPv6:2607:f8b0:4001:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYD6c0fgtzDrWR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 07:40:55 +1100 (AEDT)
Received: by mail-io0-x236.google.com with SMTP id c21so620539003ioj.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 12:40:55 -0800 (PST)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20161206062800.21800-3-andrew.donnellan@au1.ibm.com>
References: <20161206062800.21800-1-andrew.donnellan@au1.ibm.com>
 <20161206062800.21800-3-andrew.donnellan@au1.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 6 Dec 2016 12:40:50 -0800
Message-ID: <CAGXu5jKQf4ReBkGC85+r_j1rVUFTZoeWk9A_mjhjnFHq1PAr8Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] powerpc: enable support for GCC plugins
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
 Emese Revfy <re.emese@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
 Michal Marek <mmarek@suse.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 5, 2016 at 10:28 PM, Andrew Donnellan
<andrew.donnellan@au1.ibm.com> wrote:
> Enable support for GCC plugins on powerpc.
>
> Add an additional version check in gcc-plugins-check to advise users to
> upgrade to gcc 5.2+ on powerpc to avoid issues with header files (gcc <=
> 4.6) or missing copies of rs6000-cpus.def (4.8 to 5.1 on 64-bit targets).
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> ---
>
> Open to bikeshedding on the gcc version check.

I think this looks fine. Anyone wanting to use gcc plugins on ppc with
an earlier gcc can send patches if they find a sane way to make it
work. :)

> Compile tested with all plugins enabled on gcc 4.6-6.2,
> x86->ppc{32,64,64le} and 4.8-6.2 ppc64le->ppc{32,64,64le}. Thanks to
> Chris Smart for help with this.

I assume also tested on 5.2? :)

> I think it's best to take this through powerpc#next with an ACK from
> Kees/Emese?

That would be fine by me. Please consider the whole series:

Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

> ---
>  arch/powerpc/Kconfig         | 1 +
>  scripts/Makefile.gcc-plugins | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 65fba4c..6efbc08 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -92,6 +92,7 @@ config PPC
>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if MPROFILE_KERNEL
>         select HAVE_FUNCTION_TRACER
>         select HAVE_FUNCTION_GRAPH_TRACER
> +       select HAVE_GCC_PLUGINS
>         select SYSCTL_EXCEPTION_TRACE
>         select VIRT_TO_BUS if !PPC64
>         select HAVE_IDE
> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
> index 26c67b7..9835a75 100644
> --- a/scripts/Makefile.gcc-plugins
> +++ b/scripts/Makefile.gcc-plugins
> @@ -47,6 +47,14 @@ gcc-plugins-check: FORCE
>  ifdef CONFIG_GCC_PLUGINS
>    ifeq ($(PLUGINCC),)
>      ifneq ($(GCC_PLUGINS_CFLAGS),)
> +      # Various gccs between 4.5 and 5.1 have bugs on powerpc due to missing
> +      # header files. gcc <= 4.6 doesn't work at all, gccs from 4.8 to 5.1 have
> +      # issues with 64-bit targets.
> +      ifeq ($(ARCH),powerpc)
> +        ifeq ($(call cc-ifversion, -le, 0501, y), y)
> +         @echo "Cannot use CONFIG_GCC_PLUGINS: plugin support on gcc <= 5.1 is buggy on powerpc, please upgrade to gcc 5.2 or newer" >&2 && exit 1
> +        endif
> +      endif
>        ifeq ($(call cc-ifversion, -ge, 0405, y), y)
>         $(Q)$(srctree)/scripts/gcc-plugin.sh --show-error "$(__PLUGINCC)" "$(HOSTCXX)" "$(CC)" || true
>         @echo "Cannot use CONFIG_GCC_PLUGINS: your gcc installation does not support plugins, perhaps the necessary headers are missing?" >&2 && exit 1
> --
> Andrew Donnellan              OzLabs, ADL Canberra
> andrew.donnellan@au1.ibm.com  IBM Australia Limited
>



-- 
Kees Cook
Nexus Security
