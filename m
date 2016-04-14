Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlhjj120ZzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 10:43:20 +1000 (AEST)
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 13 Apr 2016 21:43:16 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 3570E1DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 20:43:08 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3DNexPd3879064
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 20:40:59 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3E0hDti001414
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 20:43:13 -0400
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/kprobes: Remove kretprobe_trampoline_holder.
Date: Wed, 13 Apr 2016 21:43:10 -0300
Message-ID: <1649722.nzyaxjufOM@hactar>
In-Reply-To: <1459455040-25671-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1459455040-25671-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

People seem to be considering patches for next, so this looks like a go=
od=20
moment to ping about this one.

--=20
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center



Am Donnerstag, 31 M=E4rz 2016, 17:10:40 schrieb Thiago Jung Bauermann:
> Fixes the following testsuite failure:
>=20
>   $ sudo ./perf test -v kallsyms
>    1: vmlinux symtab matches kallsyms                          :
>   --- start ---
>   test child forked, pid 12489
>   Using /proc/kcore for kernel object code
>   Looking at the vmlinux_path (8 entries long)
>   Using /boot/vmlinux for symbols
>   0xc00000000003d300: diff name v: .kretprobe_trampoline_holder k:
> kretprobe_trampoline Maps only in vmlinux:
>    c00000000086ca38-c000000000879b6c 87ca38 [kernel].text.unlikely
>    c000000000879b6c-c000000000bf0000 889b6c [kernel].meminit.text
>    c000000000bf0000-c000000000c53264 c00000 [kernel].init.text
>    c000000000c53264-d000000004250000 c63264 [kernel].exit.text
>    d000000004250000-d000000004450000 0 [libcrc32c]
>    d000000004450000-d000000004620000 0 [xfs]
>    d000000004620000-d000000004680000 0 [autofs4]
>    d000000004680000-d0000000046e0000 0 [x_tables]
>    d0000000046e0000-d000000004780000 0 [ip_tables]
>    d000000004780000-d0000000047e0000 0 [rng_core]
>    d0000000047e0000-ffffffffffffffff 0 [pseries_rng]
>   Maps in vmlinux with a different name in kallsyms:
>   Maps only in kallsyms:
>    d000000000000000-f000000000000000 1000000000010000 [kernel.kallsym=
s]
>    f000000000000000-ffffffffffffffff 3000000000010000 [kernel.kallsym=
s]
>   test child finished with -1
>   ---- end ----
>   vmlinux symtab matches kallsyms: FAILED!
>=20
> The problem is that the kretprobe_trampoline symbol looks like this:
>=20
>   $ eu-readelf -s /boot/vmlinux G kretprobe_trampoline
>    2431: c000000001302368     24 NOTYPE  LOCAL  DEFAULT       37
> kretprobe_trampoline_holder 2432: c00000000003d300      8 FUNC    LOC=
AL=20
> DEFAULT        1 .kretprobe_trampoline_holder 97543: c00000000003d300=
   =20
>  0 NOTYPE  GLOBAL DEFAULT        1 kretprobe_trampoline
>=20
> Its type is NOTYPE, and its size is 0, and this is a problem because
> symbol-elf.c:dso__load_sym skips function symbols that are not STT_FU=
NC
> or STT_GNU_IFUNC (this is determined by elf_sym__is_function). Even
> if the type is changed to STT_FUNC, when dso__load_sym calls
> symbols__fixup_duplicate, the kretprobe_trampoline symbol is dropped =
in
> favour of .kretprobe_trampoline_holder because the latter has non-zer=
o
> size (as determined by choose_best_symbol).
>=20
> With this patch, all vmlinux symbols match /proc/kallsyms and the
> testcase passes.
>=20
> Commit c1c355ce14c0 ("x86/kprobes: Get rid of
> kretprobe_trampoline_holder()") gets rid of kretprobe_trampoline_hold=
er
> altogether on x86. This commit does the same on powerpc. This change
> introduces no regressions on the perf and ftracetest testsuite result=
s.
>=20
> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kprobes.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kpro=
bes.c
> index 7c053f281406..417c0eadd094 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -278,12 +278,11 @@ no_kprobe:
>   * =09- When the probed function returns, this probe
>   * =09=09causes the handlers to fire
>   */
> -static void __used kretprobe_trampoline_holder(void)
> -{
> -=09asm volatile(".global kretprobe_trampoline\n"
> -=09=09=09"kretprobe_trampoline:\n"
> -=09=09=09"nop\n");
> -}
> +asm(".global kretprobe_trampoline\n"
> +=09".type kretprobe_trampoline, @function\n"
> +=09"kretprobe_trampoline:\n"
> +=09"nop\n"
> +=09".size kretprobe_trampoline, .-kretprobe_trampoline\n");
>=20
>  /*
>   * Called when the probe at kretprobe trampoline is hit
