Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTKHZ5m7GzDqcD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 04:20:42 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4IIDe5q026827
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 14:20:39 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ahgb1s7hn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 14:20:39 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 19 May 2017 04:20:36 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4IIKRGE64028870
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 04:20:35 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4IIK2vS002518
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 04:20:03 +1000
Date: Thu, 18 May 2017 18:19:45 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf: libdw support for powerpc
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: acme@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20170518170018.10507-1-pbonzini@redhat.com>
In-Reply-To: <20170518170018.10507-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1495131092.c1jiws8vlt.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paolo Bonzini wrote:
> The ARM and x86 architectures already use libdw, and it is useful to
> have as much common code for the unwinder as possible.  Porting PPC
> to libdw only needs an architecture-specific hook to move the register
> state from perf to libdw.

Thanks. Ravi has had a similar patch locally, but from what I=20
understand, there are issues with libdw based unwinding on powerpc64. I=20
gave this a quick test and I don't see the user-space call trace being=20
unwinded properly with libdw.

With the same perf.data, with libunwind:

bswap 19286 134866.199717:     321955 cycles:=20
        c0000000000b5e60 [unknown] ([unknown])
                   b31bc pSeries_lpar_hpte_invalidate (/boot/vmlinux)
                   76f10 flush_hash_page (/boot/vmlinux)
                   7ddec hpte_need_flush (/boot/vmlinux)
                  2d9f64 ptep_clear_flush (/boot/vmlinux)
                  2c24dc wp_page_copy (/boot/vmlinux)
                  2c5c44 do_wp_page (/boot/vmlinux)
                  2cabcc __handle_mm_fault (/boot/vmlinux)
                  2cbbe8 handle_mm_fault (/boot/vmlinux)
                   71074 do_page_fault (/boot/vmlinux)
                   1b078 handle_page_fault (/boot/vmlinux)
                    9958 _dl_map_object_from_fd (/lib/powerpc64le-linux-gnu=
/ld-2.24.so)
                    e70c _dl_map_object (/lib/powerpc64le-linux-gnu/ld-2.24=
.so)
                   18da4 openaux (/lib/powerpc64le-linux-gnu/ld-2.24.so)
                   1c068 _dl_catch_error (/lib/powerpc64le-linux-gnu/ld-2.2=
4.so)
                   19430 _dl_map_object_deps (/lib/powerpc64le-linux-gnu/ld=
-2.24.so)
                    41dc dl_main (/lib/powerpc64le-linux-gnu/ld-2.24.so)
                   29954 _dl_sysdep_start (/lib/powerpc64le-linux-gnu/ld-2.=
24.so)
                    1be0 _dl_start_final (/lib/powerpc64le-linux-gnu/ld-2.2=
4.so)
                    6080 _dl_start (/lib/powerpc64le-linux-gnu/ld-2.24.so)
                    1398 _start (/lib/powerpc64le-linux-gnu/ld-2.24.so)

... and with libdw:

bswap 19286 134866.199717:     321955 cycles:=20
        c0000000000b5e60 [unknown] ([unknown])
                   b31bc pSeries_lpar_hpte_invalidate (/boot/vmlinux)
                   76f10 flush_hash_page (/boot/vmlinux)
		   7ddec hpte_need_flush (/boot/vmlinux)
                  2d9f64 ptep_clear_flush (/boot/vmlinux)
                  2c24dc wp_page_copy (/boot/vmlinux)
                  2c5c44 do_wp_page (/boot/vmlinux)
                  2cabcc __handle_mm_fault (/boot/vmlinux)
                  2cbbe8 handle_mm_fault (/boot/vmlinux)
		   71074 do_page_fault (/boot/vmlinux)
                   1b078 handle_page_fault (/boot/vmlinux)

Ravi is OOO currently can will have more to say on this once he is back=20
next week.


>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tools/perf/Makefile.config                  |  2 +-
>  tools/perf/arch/powerpc/util/Build          |  2 +
>  tools/perf/arch/powerpc/util/unwind-libdw.c | 73 +++++++++++++++++++++++=
++++++
>  3 files changed, 76 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/arch/powerpc/util/unwind-libdw.c
>=20
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index f67ae83..342c57c 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -61,7 +61,7 @@ endif
>  # Disable it on all other architectures in case libdw unwind
>  # support is detected in system. Add supported architectures
>  # to the check.
> -ifneq ($(ARCH),$(filter $(ARCH),x86 arm))
> +ifneq ($(ARCH),$(filter $(ARCH),x86 arm powerpc))
>    NO_LIBDW_DWARF_UNWIND :=3D 1
>  endif
> =20
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc=
/util/Build
> index 90ad64b..2e65953 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -5,4 +5,6 @@ libperf-y +=3D perf_regs.o
> =20
>  libperf-$(CONFIG_DWARF) +=3D dwarf-regs.o
>  libperf-$(CONFIG_DWARF) +=3D skip-callchain-idx.o
> +
>  libperf-$(CONFIG_LIBUNWIND) +=3D unwind-libunwind.o
> +libperf-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/arc=
h/powerpc/util/unwind-libdw.c
> new file mode 100644
> index 0000000..c61e1d8
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/unwind-libdw.c
> @@ -0,0 +1,73 @@
> +#include <elfutils/libdwfl.h>
> +#include "../../util/util.h"
> +#include "../../util/unwind-libdw.h"
> +#include "../../util/perf_regs.h"

As an aside, we also need to include "event.h", without which there are=20
a few compile errors.


- Naveen

> +
> +/* See backends/ppc_initreg.c and backends/ppc_regs.c in elfutils.  */
> +static const int special_regs[3][2] =3D {
> +	{ 65, PERF_REG_POWERPC_LINK },
> +	{ 101, PERF_REG_POWERPC_XER },
> +	{ 109, PERF_REG_POWERPC_CTR },
> +};
> +
> +bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +{
> +	struct unwind_info *ui =3D arg;
> +	struct regs_dump *user_regs =3D &ui->sample->user_regs;
> +	Dwarf_Word dwarf_regs[32], dwarf_nip;
> +	size_t i;
> +
> +#define REG(r) ({						\
> +	Dwarf_Word val =3D 0;					\
> +	perf_reg_value(&val, user_regs, PERF_REG_POWERPC_##r);	\
> +	val;							\
> +})
> +
> +	dwarf_regs[0]  =3D REG(R0);
> +	dwarf_regs[1]  =3D REG(R1);
> +	dwarf_regs[2]  =3D REG(R2);
> +	dwarf_regs[3]  =3D REG(R3);
> +	dwarf_regs[4]  =3D REG(R4);
> +	dwarf_regs[5]  =3D REG(R5);
> +	dwarf_regs[6]  =3D REG(R6);
> +	dwarf_regs[7]  =3D REG(R7);
> +	dwarf_regs[8]  =3D REG(R8);
> +	dwarf_regs[9]  =3D REG(R9);
> +	dwarf_regs[10] =3D REG(R10);
> +	dwarf_regs[11] =3D REG(R11);
> +	dwarf_regs[12] =3D REG(R12);
> +	dwarf_regs[13] =3D REG(R13);
> +	dwarf_regs[14] =3D REG(R14);
> +	dwarf_regs[15] =3D REG(R15);
> +	dwarf_regs[16] =3D REG(R16);
> +	dwarf_regs[17] =3D REG(R17);
> +	dwarf_regs[18] =3D REG(R18);
> +	dwarf_regs[19] =3D REG(R19);
> +	dwarf_regs[20] =3D REG(R20);
> +	dwarf_regs[21] =3D REG(R21);
> +	dwarf_regs[22] =3D REG(R22);
> +	dwarf_regs[23] =3D REG(R23);
> +	dwarf_regs[24] =3D REG(R24);
> +	dwarf_regs[25] =3D REG(R25);
> +	dwarf_regs[26] =3D REG(R26);
> +	dwarf_regs[27] =3D REG(R27);
> +	dwarf_regs[28] =3D REG(R28);
> +	dwarf_regs[29] =3D REG(R29);
> +	dwarf_regs[30] =3D REG(R30);
> +	dwarf_regs[31] =3D REG(R31);
> +	if (!dwfl_thread_state_registers(thread, 0, 32, dwarf_regs))
> +		return false;
> +
> +	dwarf_nip =3D REG(NIP);
> +	dwfl_thread_state_register_pc(thread, dwarf_nip);
> +	for (i =3D 0; i < ARRAY_SIZE(special_regs); i++) {
> +		Dwarf_Word val =3D 0;
> +		perf_reg_value(&val, user_regs, special_regs[i][1]);
> +		if (!dwfl_thread_state_registers(thread,
> +						 special_regs[i][0], 1,
> +						 &val))
> +			return false;
> +	}
> +
> +	return true;
> +}
> --=20
> 1.8.3.1
>=20
>=20
>=20
=
