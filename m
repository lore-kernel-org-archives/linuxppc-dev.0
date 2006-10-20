Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2247667B6D
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 16:06:41 +1000 (EST)
Subject: Re: [PATCH 4/5] powerpc: Support feature fixups in modules
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20061020010147.3ef4694e@pb15>
References: <1161308839.10524.111.camel@localhost.localdomain>
	<20061020010147.3ef4694e@pb15>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 16:06:24 +1000
Message-Id: <1161324384.10524.152.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-10-20 at 01:01 -0500, Olof Johansson wrote:
> On Fri, 20 Oct 2006 11:47:19 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > This patch adds support for feature fixups in modules. This involves
> > adding support for R_PPC64_REL64 relocs to the 64 bits module loader.
> > It also modifies modpost.c to ignore the powerpc fixup sections (or it
> > would warn when used in .init.text).
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> 
> > Index: linux-cell/arch/powerpc/kernel/module_32.c
> > ===================================================================
> > --- linux-cell.orig/arch/powerpc/kernel/module_32.c	2006-10-13 16:00:26.000000000 +1000
> > +++ linux-cell/arch/powerpc/kernel/module_32.c	2006-10-13 16:59:36.000000000 +1000
> [...]
> > +static const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
> > +				    const Elf_Shdr *sechdrs,
> > +				    const char *name)
> > +{
> > +	char *secstrings;
> > +	unsigned int i;
> > +
> > +	secstrings = (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
> > +	for (i = 1; i < hdr->e_shnum; i++)
> > +		if (strcmp(secstrings+sechdrs[i].sh_name, name) == 0)
> > +			return &sechdrs[i];
> > +	return NULL;
> > +}
> > +
> 
> It would be nice if this could be put in some common location instead
> of duplicated between the two files. It builds differently on 32 and 64
> bits due to the type defines, but both will never be used in the same
> kernel.

Or even made completely common, I'll look at it separately.

Ben.
