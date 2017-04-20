Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7pwl14W5zDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 16:33:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: kprobes: blacklist exception handlers
In-Reply-To: <1ec8a69d73b38e365347f0c4b6329407d8861afa.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
 <1ec8a69d73b38e365347f0c4b6329407d8861afa.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
Date: Thu, 20 Apr 2017 16:33:42 +1000
Message-ID: <87inlz4mgp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 71286dfd76a0..59159337a097 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -112,6 +113,14 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
>  	return addr;
>  }
>  
> +bool arch_within_kprobe_blacklist(unsigned long addr)
> +{
> +	return  (addr >= (unsigned long)__kprobes_text_start &&
> +		 addr < (unsigned long)__kprobes_text_end) ||
> +		(addr >= (unsigned long)_stext &&
> +		 addr < (unsigned long)__head_end);
> +}

This isn't quite right when the kernel is relocated.

_stext and __head_end will be updated to point to the relocated copy of
the kernel, eg:

# grep -e _stext /proc/kallsyms 
c000000002000000 T _stext

So you probably also want something like:

  if (_stext != PAGE_OFFSET &&
      addr >= PAGE_OFFSET &&
      addr < (PAGE_OFFSET + (__head_end - _stext)))
      return true;

But that's entirely untested :)

You can test the relocatable case by enabling CONFIG_RELOCATABLE_TEST.

cheers
