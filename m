Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FEFE1A01F4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 22:21:49 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 16:51:47 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 8B4D2E0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 16:52:20 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBABLtkM61276258
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 16:51:56 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBABLghC021596
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 16:51:42 +0530
Date: Wed, 10 Dec 2014 16:51:11 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 6/8] perf tools powerpc: Fix PPC64 ELF ABIv2 symbol
 decoding
Message-ID: <20141210112111.GD16045@naverao1-tp.in.ibm.com>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <fc380ddad57d90d338ea79f319c5f5d1dd6639b9.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <1418206413.9279.9.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418206413.9279.9.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/12/10 09:13PM, Michael Ellerman wrote:
> On Tue, 2014-12-09 at 23:04 +0530, Naveen N. Rao wrote:
> > PPC64 ELF ABIv2 has a Global Entry Point (GEP) and a Local Entry Point
> > (LEP). For purposes of probing, we need the LEP. Offset to the LEP is
> > encoded in st_other.
> > 
> > diff --git a/tools/perf/arch/powerpc/util/elf-sym-decode.c b/tools/perf/arch/powerpc/util/elf-sym-decode.c
> > new file mode 100644
> > index 0000000..7434656
> > --- /dev/null
> > +++ b/tools/perf/arch/powerpc/util/elf-sym-decode.c
> > @@ -0,0 +1,27 @@
> > +/*
> > + * Decode offset from Global Entry Point to Local Entry Point on PPC64
> > + * ELF ABIv2.
> > + *
> > + * Derived from definitions in arch/powerpc/kernel/module_64.c
> > + *
> > + * Copyright (C) 2014 Ananth N Mavinakayanahalli, IBM Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#include <gelf.h>
> > +#include "elf_sym.h"
> > +
> > +/* PowerPC64 ABIv2 specific values for the ELF64_Sym st_other field. */
> > +#define STO_PPC64_LOCAL_BIT	5
> > +#define STO_PPC64_LOCAL_MASK	(7 << STO_PPC64_LOCAL_BIT)
> > +#define PPC64_LOCAL_ENTRY_OFFSET(other)					\
> > + (((1 << (((other) & STO_PPC64_LOCAL_MASK) >> STO_PPC64_LOCAL_BIT)) >> 2) << 2)
> 
> You're in userspace, you should be able to get these from elf.h

Ah, ok.

> 
> > +unsigned int arch_elf_sym_decode_offset(GElf_Sym *sym)
> > +{
> > +	return PPC64_LOCAL_ENTRY_OFFSET(sym->st_other);
> 
> What happens on ABIv1 ? We hope st_other is zero?

Yes, st_other is zero in ABIv1.

> 
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index 67e4392..92a424e 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -10,6 +10,7 @@
> >  #include "vdso.h"
> >  #include <symbol/kallsyms.h>
> >  #include "debug.h"
> > +#include "elf_sym.h"
> >  
> >  #ifndef HAVE_ELF_GETPHDRNUM_SUPPORT
> >  static int elf_getphdrnum(Elf *elf, size_t *dst)
> > @@ -848,6 +849,13 @@ int dso__load_sym(struct dso *dso, struct map *map,
> >  		    (sym.st_value & 1))
> >  			--sym.st_value;
> >  
> > +		/*
> > +		 * PPC64 ELF ABIv2 encodes Local Entry Point offset in
> > +		 * the st_other field
> > +		 */
> > +		if ((map->type == MAP__FUNCTION) && sym.st_other)
> > +			sym.st_value += arch_elf_sym_decode_offset(&sym);
> 
> I guess no other arch has needed to do anything like this.
> 
> But if they did it's unlikely they'll want to do the exact same logic, ie.
> check st_other and add some value to st_value. To make it more generically
> useful you could just make it:
> 
> > +		if (map->type == MAP__FUNCTION)
> > +			arch_elf_sym_decode(&sym);
> 
> And do any other checks in the arch routine.

Sure. Makes sense.

- Naveen
