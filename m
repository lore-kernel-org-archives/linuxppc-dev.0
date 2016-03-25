Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qWbvb1sz9zDq71
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 19:24:59 +1100 (AEDT)
In-Reply-To: <1458839824-27844-1-git-send-email-bauerman@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: Make kretprobe_trampoline symbol look like a function.
Message-Id: <3qWbvb0yVwz9sdm@ozlabs.org>
Date: Fri, 25 Mar 2016 19:24:59 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-24-03 at 17:17:04 UTC, Thiago Jung Bauermann wrote:
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
> With this patch, during symbol deduplication kretprobe_trampoline is
> used instead of .kretprobe_trampoline_holder, making all vmlinux symbols match
> /proc/kallsyms and the testcase passes.

Thanks, good change log.

> Alternatively, I just noticed that commit c1c355c was merged and it
> gets rid of kretprobe_trampoline_holder altogether on x86. I believe that
> would fix this problem as well, but I don't know enough about kprobes to
> know whether kretprobe_trampoline_holder has any use  on powerpc.

I don't see any reason why we need it on powerpc.

So can you try removing kretprobe_trampoline_holder and check that kretprobes
still work. And then confirm that it also fixes this bug?

cheers
