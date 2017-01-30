Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vC1ZJ6z34zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 07:43:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org, mahesh@linux.vnet.ibm.com,
 mhiramat@kernel.org, anju@linux.vnet.ibm.com
Subject: Re: [PATCH V3 3/4] arch/powerpc: Implement Optprobes
In-Reply-To: <1482153507-17350-2-git-send-email-anju@linux.vnet.ibm.com>
References: <1482153507-17350-1-git-send-email-anju@linux.vnet.ibm.com>
 <1482153507-17350-2-git-send-email-anju@linux.vnet.ibm.com>
Date: Tue, 31 Jan 2017 07:43:35 +1100
Message-ID: <878tpswa6g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:

> Detour buffer contains instructions to create an in memory pt_regs.
> After the execution of the pre-handler, a call is made for instruction em=
ulation.
> The NIP is determined in advanced through dummy instruction emulation and=
 a branch
> instruction is created to the NIP at the end of the trampoline.
>
> Instruction slot for detour buffer is allocated from the reserved area.
> For the time being, 64KB is reserved in memory for this purpose.
>
> Instructions which can be emulated using analyse_instr() are suppliants
> for optimization. Before optimization ensure that the address range
> between the detour buffer allocated and the instruction being probed
> is within =C2=B1 32MB.
>
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  .../features/debug/optprobes/arch-support.txt      |   2 +-
>  arch/powerpc/Kconfig                               |   1 +
>  arch/powerpc/include/asm/kprobes.h                 |  24 +-
>  arch/powerpc/include/asm/sstep.h                   |   1 +
>  arch/powerpc/kernel/Makefile                       |   1 +
>  arch/powerpc/kernel/optprobes.c                    | 331 +++++++++++++++=
++++++
>  arch/powerpc/kernel/optprobes_head.S               | 135 +++++++++
>  arch/powerpc/lib/sstep.c                           |  21 ++
>  8 files changed, 514 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/kernel/optprobes.c
>  create mode 100644 arch/powerpc/kernel/optprobes_head.S

This breaks the pseries_defconfig (at least) build:

  In file included from ../include/linux/kprobes.h:45:0,
                   from ../arch/powerpc/kernel/optprobes.c:12:
  ../arch/powerpc/kernel/optprobes.c: In function =E2=80=98arch_prepare_opt=
imized_kprobe=E2=80=99:
  ../arch/powerpc/include/asm/kprobes.h:79:16: error: =E2=80=98MODULE_NAME_=
LEN=E2=80=99 undeclared (first use in this function)
    char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];  \
                  ^
  ../arch/powerpc/kernel/optprobes.c:230:2: note: in expansion of macro =E2=
=80=98kprobe_lookup_name=E2=80=99
    kprobe_lookup_name("optimized_callback", op_callback_addr);
    ^~~~~~~~~~~~~~~~~~
  ../arch/powerpc/include/asm/kprobes.h:79:16: note: each undeclared identi=
fier is reported only once for each function it appears in
    char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];  \
                  ^
  ../arch/powerpc/kernel/optprobes.c:230:2: note: in expansion of macro =E2=
=80=98kprobe_lookup_name=E2=80=99
    kprobe_lookup_name("optimized_callback", op_callback_addr);
    ^~~~~~~~~~~~~~~~~~
  ../arch/powerpc/include/asm/kprobes.h:82:14: error: assignment discards =
=E2=80=98const=E2=80=99 qualifier from pointer target type [-Werror=3Ddisca=
rded-qualifiers]
    if ((modsym =3D strchr(name, ':')) !=3D NULL) {   \
                ^
  ../arch/powerpc/kernel/optprobes.c:230:2: note: in expansion of macro =E2=
=80=98kprobe_lookup_name=E2=80=99
    kprobe_lookup_name("optimized_callback", op_callback_addr);
    ^~~~~~~~~~~~~~~~~~
  ../arch/powerpc/include/asm/kprobes.h:79:7: error: unused variable =E2=80=
=98dot_name=E2=80=99 [-Werror=3Dunused-variable]
    char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];  \
         ^
  ../arch/powerpc/kernel/optprobes.c:230:2: note: in expansion of macro =E2=
=80=98kprobe_lookup_name=E2=80=99
    kprobe_lookup_name("optimized_callback", op_callback_addr);
    ^~~~~~~~~~~~~~~~~~
  ../arch/powerpc/include/asm/kprobes.h:82:14: error: assignment discards =
=E2=80=98const=E2=80=99 qualifier from pointer target type [-Werror=3Ddisca=
rded-qualifiers]
    if ((modsym =3D strchr(name, ':')) !=3D NULL) {   \
                ^
  ../arch/powerpc/kernel/optprobes.c:231:2: note: in expansion of macro =E2=
=80=98kprobe_lookup_name=E2=80=99
    kprobe_lookup_name("emulate_step", emulate_step_addr);
    ^~~~~~~~~~~~~~~~~~
  ../arch/powerpc/include/asm/kprobes.h:79:7: error: unused variable =E2=80=
=98dot_name=E2=80=99 [-Werror=3Dunused-variable]
    char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];  \
         ^
  ../arch/powerpc/kernel/optprobes.c:231:2: note: in expansion of macro =E2=
=80=98kprobe_lookup_name=E2=80=99
    kprobe_lookup_name("emulate_step", emulate_step_addr);
    ^~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  make[2]: *** [arch/powerpc/kernel/optprobes.o] Error 1
  make[2]: *** Waiting for unfinished jobs....
  make[1]: *** [arch/powerpc/kernel] Error 2
  make[1]: *** Waiting for unfinished jobs....
  make: *** [sub-make] Error 2


This may not be your bug, but your patch exposes it unfortunately.

cheers
