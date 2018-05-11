Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hzxY35f6zF2DX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 16:01:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH  05/17] powerpc: move io mapping functions into ioremap.c
In-Reply-To: <b6f1dc10a4e2be3674fb9999d5b176a5ce9787e6.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
 <b6f1dc10a4e2be3674fb9999d5b176a5ce9787e6.1525435203.git.christophe.leroy@c-s.fr>
Date: Fri, 11 May 2018 16:01:36 +1000
Message-ID: <87y3gqrarj.fsf@concordia.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
> new file mode 100644
> index 000000000000..5d2645193568
> --- /dev/null
> +++ b/arch/powerpc/mm/ioremap.c
> @@ -0,0 +1,350 @@
> +/*
> + * This file contains the routines for mapping IO areas
> + *
> + *  Derived from arch/powerpc/mm/pgtable_32.c and
> + *  arch/powerpc/mm/pgtable_64.c
> + *
> + * SPDX-License-Identifier: GPL-2.0

This goes at the top of the file as:

// SPDX-License-Identifier: GPL-2.0

See:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/license-rules.rst?#n56

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +#include <linux/vmalloc.h>
> +#include <linux/init.h>
> +#include <linux/highmem.h>
> +#include <linux/memblock.h>
> +#include <linux/slab.h>
> +
> +#include <asm/pgtable.h>
> +#include <asm/pgalloc.h>
> +#include <asm/fixmap.h>
> +#include <asm/io.h>
> +#include <asm/setup.h>
> +#include <asm/sections.h>

I needed:

+#include <asm/machdep.h>

To fix:

../arch/powerpc/mm/ioremap.c: In function =E2=80=98ioremap_wc=E2=80=99:
../arch/powerpc/mm/ioremap.c:290:6: error: =E2=80=98ppc_md=E2=80=99 undecla=
red (first use in this function)
  if (ppc_md.ioremap)
      ^~~~~~

cheers
