Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYxCB2Jd7zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 14:31:34 +1100 (AEDT)
Message-ID: <1459222294.8173.8.camel@ellerman.id.au>
Subject: Re: [PATCH] Remove kretprobe_trampoline_holder.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 Mar 2016 14:31:34 +1100
In-Reply-To: <1459195592-6559-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <3qWbvb0yVwz9sdm@ozlabs.org>
 <1459195592-6559-1-git-send-email-bauerman@linux.vnet.ibm.com>
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

On Mon, 2016-03-28 at 17:06 -0300, Thiago Jung Bauermann wrote:

> Fixes the following testsuite failure:
> 
> $ sudo ./perf test -v kallsyms
>  1: vmlinux symtab matches kallsyms                          :
> --- start ---
> test child forked, pid 12489
> Using /proc/kcore for kernel object code
> Looking at the vmlinux_path (8 entries long)
> Using /boot/vmlinux for symbols
> 0xc00000000003d300: diff name v: .kretprobe_trampoline_holder k: kretprobe_trampoline
> Maps only in vmlinux:
>  c00000000086ca38-c000000000879b6c 87ca38 [kernel].text.unlikely
>  c000000000879b6c-c000000000bf0000 889b6c [kernel].meminit.text
>  c000000000bf0000-c000000000c53264 c00000 [kernel].init.text
>  c000000000c53264-d000000004250000 c63264 [kernel].exit.text
>  d000000004250000-d000000004450000 0 [libcrc32c]
>  d000000004450000-d000000004620000 0 [xfs]
>  d000000004620000-d000000004680000 0 [autofs4]
>  d000000004680000-d0000000046e0000 0 [x_tables]
>  d0000000046e0000-d000000004780000 0 [ip_tables]
>  d000000004780000-d0000000047e0000 0 [rng_core]
>  d0000000047e0000-ffffffffffffffff 0 [pseries_rng]
> Maps in vmlinux with a different name in kallsyms:
> Maps only in kallsyms:
>  d000000000000000-f000000000000000 1000000000010000 [kernel.kallsyms]
>  f000000000000000-ffffffffffffffff 3000000000010000 [kernel.kallsyms]
> test child finished with -1
> ---- end ----
> vmlinux symtab matches kallsyms: FAILED!
> 
> The problem is that the kretprobe_trampoline symbol looks like this:
> 
> $ eu-readelf -s /boot/vmlinux G kretprobe_trampoline
>  2431: c000000001302368     24 NOTYPE  LOCAL  DEFAULT       37 kretprobe_trampoline_holder
>  2432: c00000000003d300      8 FUNC    LOCAL  DEFAULT        1 .kretprobe_trampoline_holder
> 97543: c00000000003d300      0 NOTYPE  GLOBAL DEFAULT        1 kretprobe_trampoline
> 
> Its type is NOTYPE, and its size is 0, and this is a problem because
> symbol-elf.c:dso__load_sym skips function symbols that are not STT_FUNC
> or STT_GNU_IFUNC (this is determined by elf_sym__is_function). Even
> if the type is changed to STT_FUNC, when dso__load_sym calls
> symbols__fixup_duplicate, the kretprobe_trampoline symbol is dropped in
> favour of .kretprobe_trampoline_holder because the latter has non-zero
> size (as determined by choose_best_symbol).
> 
> With this patch, all vmlinux symbols match /proc/kallsyms and the
> testcase passes.

Have you tested this on an LE system? I did a quick test and it appears to be
completely broken. Basically every symbol is not found, eg:

 1: vmlinux symtab matches kallsyms                          :
--- start ---
test child forked, pid 16222
Using /proc/kcore for kernel object code
Looking at the vmlinux_path (8 entries long)
Using /boot/vmlinux-4.5.0-11318-gdf01bc5cf4ea for symbols
0xc00000000000b428: run_init_process not on kallsyms
0xc00000000000b478: try_to_run_init_process not on kallsyms
0xc00000000000b4f8: do_one_initcall not on kallsyms
0xc00000000000b768: match_dev_by_uuid not on kallsyms
...
0xc0000000009846b8: write_mem not on kallsyms
0xc000000000984728: do_fp_store not on kallsyms
0xc000000000984828: emulate_step not on kallsyms

$ sudo grep emulate_step /proc/kallsyms
c000000000984820 T emulate_step


Notice it's off by 8. That's because of the local/global entry point on LE. So
that will need to be fixed somewhere.

cheers
