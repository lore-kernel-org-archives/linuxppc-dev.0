Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZRlw06pJzDsWc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 15:28:44 +1000 (AEST)
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sZRlv3YLQz9s3s
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 15:28:43 +1000 (AEST)
Date: Thu, 15 Sep 2016 15:28:32 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Ensure .mem(init|exit).text are within
 _stext/_etext
Message-ID: <20160915152832.0f1a6708@kryten>
In-Reply-To: <1473916319-27736-1-git-send-email-mpe@ellerman.id.au>
References: <1473916319-27736-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> In our linker script we open code the list of text sections, because
> we need to include the __ftr_alt sections, which are arch-specific.
> 
> This means we can't use TEXT_TEXT as defined in vmlinux.lds.h, and so
> we don't have the MEM_KEEP() logic for memory hotplug sections.
> 
> If we build the kernel with the gold linker, and with
> CONFIG_MEMORY_HOTPLUG=y, we see that functions marked __meminit can
> end up outside of the _stext/_etext range, and also outside of
> _sinittext/_einittext, eg:
> 
>     c000000000000000 T _stext
>     c0000000009e0000 A _etext
>     c0000000009e3f18 T hash__vmemmap_create_mapping
>     c000000000ca0000 T _sinittext
>     c000000000d00844 T _einittext
> 
> This causes them to not be recognised as text by is_kernel_text(), and
> prevents them being patched by jump_label (and presumably
> ftrace/kprobes etc.).
> 
> Fix it by adding MEM_KEEP() directives, mirroring what TEXT_TEXT does.
> 
> This isn't a problem when CONFIG_MEMORY_HOTPLUG=n, because we use the
> standard INIT_TEXT_SECTION() and EXIT_TEXT macros from vmlinux.lds.h.

Thanks Michael, looks good:

Tested-by: Anton Blanchard <anton@samba.org>

Anton
--
 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/vmlinux.lds.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S
> b/arch/powerpc/kernel/vmlinux.lds.S index b5fba689fca6..b59d75e194a5
> 100644 --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -56,6 +56,8 @@ SECTIONS
>  		KPROBES_TEXT
>  		IRQENTRY_TEXT
>  		SOFTIRQENTRY_TEXT
> +		MEM_KEEP(init.text)
> +		MEM_KEEP(exit.text)
>  
>  #ifdef CONFIG_PPC32
>  		*(.got1)
