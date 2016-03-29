Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZRwd54MlzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 10:35:45 +1100 (AEDT)
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 29 Mar 2016 20:35:39 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 219931DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 19:35:32 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2TMZ36V38600800
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 19:35:03 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2TNZae0014379
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 20:35:37 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, ananth@in.ibm.com
Subject: Re: [PATCH] Remove kretprobe_trampoline_holder.
Date: Tue, 29 Mar 2016 20:35:32 -0300
Message-ID: <3337968.FTL1d9fOmu@hactar>
In-Reply-To: <1459222294.8173.8.camel@ellerman.id.au>
References: <3qWbvb0yVwz9sdm@ozlabs.org>
 <1459195592-6559-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1459222294.8173.8.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Dienstag, 29 M=C3=A4rz 2016, 14:31:34 schrieb Michael Ellerman:
> On Mon, 2016-03-28 at 17:06 -0300, Thiago Jung Bauermann wrote:
> > With this patch, all vmlinux symbols match /proc/kallsyms and the
> > testcase passes.
>=20
> Have you tested this on an LE system?

No, I was focusing on ppc64 BE.

> I did a quick test and it appears to
> be completely broken. Basically every symbol is not found, eg:
>=20
>  1: vmlinux symtab matches kallsyms                          :
> --- start ---
> test child forked, pid 16222
> Using /proc/kcore for kernel object code
> Looking at the vmlinux_path (8 entries long)
> Using /boot/vmlinux-4.5.0-11318-gdf01bc5cf4ea for symbols
> 0xc00000000000b428: run_init_process not on kallsyms
> 0xc00000000000b478: try_to_run_init_process not on kallsyms
> 0xc00000000000b4f8: do_one_initcall not on kallsyms
> 0xc00000000000b768: match_dev_by_uuid not on kallsyms
> ...
> 0xc0000000009846b8: write_mem not on kallsyms
> 0xc000000000984728: do_fp_store not on kallsyms
> 0xc000000000984828: emulate_step not on kallsyms
>=20
> $ sudo grep emulate_step /proc/kallsyms
> c000000000984820 T emulate_step
>=20
>=20
> Notice it's off by 8. That's because of the local/global entry point =
on
> LE. So that will need to be fixed somewhere.

Symbols loaded from the vmlinux file get adjusted to the local entry po=
int=20
because symbol-elf.c:dso__load_sym calls arch__elf_sym_adjust for each=20=

function symbol, which on ppc64le adjusts the address to the local entr=
y=20
point. On the other hand, when symbols are loaded from /proc/kallsyms t=
hey=20
are used as-is (i.e., with the global entry point address).

This seems inconsistent: dso__load_kernel_sym can end up loading symbol=
s=20
from either vmlinux or /proc/kallsyms, so it seems symbols should look =
the=20
same wherever they are loaded from. I am still trying to understand wha=
t the=20
rest of the perf code expects.

If I comment out the call to arch__elf_sym_adjust in dso__load_sym, the=
n all=20
symbols are found in the vmlinux-kallsyms.c test (the test still fails=20=

because two symbols have different names. I haven=E2=80=99t checked why=
). Also, the=20
code-reading.c test is able to read object code for a lot (but not all)=
 of=20
the sample events, whereas in the adjusted symbols case it can=E2=80=99=
t read object=20
code for any sample event. The other perf tests are unaffected by the=20=

change.

I thought that if there=E2=80=99s no vmlinux available, then perf would=
 have to rely=20
only on /proc/kallsyms and I would see some difference in the test resu=
lts=20
compared to when perf uses vmlinux and adjusts the symbols to the local=
=20
entry point, but I saw no difference at all.

So at first glance, it looks like perf is better off using symbols that=
=20
point to the global entry point...
--=20
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
