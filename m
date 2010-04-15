Return-Path: <mhiramat@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 55270B7D00
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 01:16:13 +1000 (EST)
Message-ID: <4BC72E82.7080401@redhat.com>
Date: Thu, 15 Apr 2010 08:19:30 -0700
From: Masami Hiramatsu <mhiramat@redhat.com>
MIME-Version: 1.0
To: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH v3 2/2] perf probe: Add PowerPC DWARF register number
	mappings
References: <1271303822-11542-1-git-send-email-imunsie@au.ibm.com>
	<1271303822-11542-2-git-send-email-imunsie@au.ibm.com>
	<1271303822-11542-3-git-send-email-imunsie@au.ibm.com>
In-Reply-To: <1271303822-11542-3-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ian Munsie wrote:
> From: Ian Munsie <imunsie@au.ibm.com>
> 
> This patch adds mappings from the register numbers from DWARF to the
> register names used in the PowerPC Regs and Stack Access API. This
> allows perf probe to be used to record variable contents on PowerPC.
> 
> This patch depends on functionality in the powerpc/next tree, though it
> will compile fine without it. Specifically this patch depends on commit
> "powerpc: Add kprobe-based event tracer"
> 
> Signed-off-by: Ian Munsie <imunsie@au.ibm.com>

Acked-by: Masami Hiramatsu <mhiramat@redhat.com>

Thank you!

> ---
>  tools/perf/arch/powerpc/Makefile          |    2 +
>  tools/perf/arch/powerpc/util/dwarf-regs.c |   88 +++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+), 0 deletions(-)
>  create mode 100644 tools/perf/arch/powerpc/Makefile
>  create mode 100644 tools/perf/arch/powerpc/util/dwarf-regs.c
> 
> diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
> new file mode 100644
> index 0000000..cbd7833
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/Makefile
> @@ -0,0 +1,2 @@
> +PERF_HAVE_DWARF_REGS := 1
> +LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/dwarf-regs.o
> diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c b/tools/perf/arch/powerpc/util/dwarf-regs.c
> new file mode 100644
> index 0000000..48ae0c5
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/dwarf-regs.c
> @@ -0,0 +1,88 @@
> +/*
> + * Mapping of DWARF debug register numbers into register names.
> + *
> + * Copyright (C) 2010 Ian Munsie, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <libio.h>
> +#include <dwarf-regs.h>
> +
> +
> +struct pt_regs_dwarfnum {
> +	const char *name;
> +	unsigned int dwarfnum;
> +};
> +
> +#define STR(s) #s
> +#define REG_DWARFNUM_NAME(r, num) {.name = r, .dwarfnum = num}
> +#define GPR_DWARFNUM_NAME(num)	\
> +	{.name = STR(%gpr##num), .dwarfnum = num}
> +#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
> +
> +/*
> + * Reference:
> + * http://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html
> + */
> +static const struct pt_regs_dwarfnum regdwarfnum_table[] = {
> +	GPR_DWARFNUM_NAME(0),
> +	GPR_DWARFNUM_NAME(1),
> +	GPR_DWARFNUM_NAME(2),
> +	GPR_DWARFNUM_NAME(3),
> +	GPR_DWARFNUM_NAME(4),
> +	GPR_DWARFNUM_NAME(5),
> +	GPR_DWARFNUM_NAME(6),
> +	GPR_DWARFNUM_NAME(7),
> +	GPR_DWARFNUM_NAME(8),
> +	GPR_DWARFNUM_NAME(9),
> +	GPR_DWARFNUM_NAME(10),
> +	GPR_DWARFNUM_NAME(11),
> +	GPR_DWARFNUM_NAME(12),
> +	GPR_DWARFNUM_NAME(13),
> +	GPR_DWARFNUM_NAME(14),
> +	GPR_DWARFNUM_NAME(15),
> +	GPR_DWARFNUM_NAME(16),
> +	GPR_DWARFNUM_NAME(17),
> +	GPR_DWARFNUM_NAME(18),
> +	GPR_DWARFNUM_NAME(19),
> +	GPR_DWARFNUM_NAME(20),
> +	GPR_DWARFNUM_NAME(21),
> +	GPR_DWARFNUM_NAME(22),
> +	GPR_DWARFNUM_NAME(23),
> +	GPR_DWARFNUM_NAME(24),
> +	GPR_DWARFNUM_NAME(25),
> +	GPR_DWARFNUM_NAME(26),
> +	GPR_DWARFNUM_NAME(27),
> +	GPR_DWARFNUM_NAME(28),
> +	GPR_DWARFNUM_NAME(29),
> +	GPR_DWARFNUM_NAME(30),
> +	GPR_DWARFNUM_NAME(31),
> +	REG_DWARFNUM_NAME("%msr",   66),
> +	REG_DWARFNUM_NAME("%ctr",   109),
> +	REG_DWARFNUM_NAME("%link",  108),
> +	REG_DWARFNUM_NAME("%xer",   101),
> +	REG_DWARFNUM_NAME("%dar",   119),
> +	REG_DWARFNUM_NAME("%dsisr", 118),
> +	REG_DWARFNUM_END,
> +};
> +
> +/**
> + * get_arch_regstr() - lookup register name from it's DWARF register number
> + * @n:	the DWARF register number
> + *
> + * get_arch_regstr() returns the name of the register in struct
> + * regdwarfnum_table from it's DWARF register number. If the register is not
> + * found in the table, this returns NULL;
> + */
> +const char *get_arch_regstr(unsigned int n)
> +{
> +	const struct pt_regs_dwarfnum *roff;
> +	for (roff = regdwarfnum_table; roff->name != NULL; roff++)
> +		if (roff->dwarfnum == n)
> +			return roff->name;
> +	return NULL;
> +}

-- 
Masami Hiramatsu
e-mail: mhiramat@redhat.com
