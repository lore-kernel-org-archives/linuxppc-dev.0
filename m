Return-Path: <mbenes@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D37C61A03A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 21:50:32 +1100 (AEDT)
Date: Tue, 26 Jan 2016 11:50:25 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Torsten Duwe <duwe@lst.de>
cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 live-patching@vger.kernel.org, pmladek@suse.cz
Subject: Re: [PATCH v6 8/9] Implement kernel live patching for ppc64le (ABIv2)
In-Reply-To: <20160125170804.A11DB692DD@newverein.lst.de>
Message-ID: <alpine.LNX.2.00.1601261142190.24510@pobox.suse.cz>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170804.A11DB692DD@newverein.lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


[ added Petr to CC list ]

On Mon, 25 Jan 2016, Torsten Duwe wrote:

>   * create the appropriate files+functions
>     arch/powerpc/include/asm/livepatch.h
>         klp_check_compiler_support,
>         klp_arch_set_pc
>     arch/powerpc/kernel/livepatch.c with a stub for
>         klp_write_module_reloc
>     This is architecture-independent work in progress.
>   * introduce a fixup in arch/powerpc/kernel/entry_64.S
>     for local calls that are becoming global due to live patching.
>     And of course do the main KLP thing: return to a maybe different
>     address, possibly altered by the live patching ftrace op.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>

Hi,

I have a few questions...

We still need Petr's patch from [1] to make livepatch work, right? Could 
you, please, add it to this patch set to make it self-sufficient?

Second, what is the situation with mcount prologue between gcc < 6 and 
gcc-6? Are there only 12 bytes in gcc-6 prologue? If yes, we need to 
change Petr's patch to make it more general and to be able to cope with 
different prologues. This is unfortunate. Either way, please mention it 
somewhere in a changelog.

I haven't reviewed the patch properly yet, but there is a comment below.

[1] http://lkml.kernel.org/g/20151203160004.GE8047@pathway.suse.cz

> +/**
> + * klp_write_module_reloc() - write a relocation in a module
> + * @mod:       module in which the section to be modified is found
> + * @type:      ELF relocation type (see asm/elf.h)
> + * @loc:       address that the relocation should be written to
> + * @value:     relocation value (sym address + addend)
> + *
> + * This function writes a relocation to the specified location for
> + * a particular module.
> + */
> +int klp_write_module_reloc(struct module *mod, unsigned long type,
> +			    unsigned long loc, unsigned long value)
> +{
> +	/* This requires infrastructure changes; we need the loadinfos. */
> +	pr_err("lpc_write_module_reloc not yet supported\n");

This is a nit, but there is no lpc_write_module_reloc. It should be 
klp_write_module_reloc.

Thanks,
Miroslav
