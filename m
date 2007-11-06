Return-Path: <Emilian.Medve@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 612B9DDDE9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 10:58:32 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lA6NwPT3024829
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 16:58:26 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id lA6NwPN3000373
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 17:58:25 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC/PATCH] reduce load time for modules with lots of relocs
Date: Tue, 6 Nov 2007 16:58:24 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E270174D37B@az33exm24.fsl.freescale.net>
In-Reply-To: <20071106023355.GJ9695@localdomain>
References: <598D5675D34BE349929AF5EDE9B03E270174CC98@az33exm24.fsl.freescale.net>
	<20071101235728.GE9695@localdomain>
	<20071106023355.GJ9695@localdomain>
From: "Medve Emilian" <Emilian.Medve@freescale.com>
To: "Nathan Lynch" <ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Nathan,


Would it be possible to do the sort "in place" (without the extra
buffer)? I mean would that upset any other part of the kernel?


Thanks,
Emil.


> -----Original Message-----
> From: Nathan Lynch [mailto:ntl@pobox.com]=20
> Sent: Monday, November 05, 2007 8:34 PM
> To: Medve Emilian
> Cc: linuxppc-dev@ozlabs.org
> Subject: [RFC/PATCH] reduce load time for modules with lots of relocs
>=20
> Nathan Lynch wrote:
> > Medve Emilian-EMMEDVE1 wrote:
> > >=20
> > > I have module with 36K relocation entries (I know, I=20
> know, how could
> > > that be...) and the count_relocs() function takes ~17=20
> seconds to crunch
> > > through the relocation table from the .rela.text section.=20
> I don't think
> > > I can reduce the number of entries in the relocation=20
> table (can I?) so
> > > I'm thinking at improving the performance of=20
> count_relocs() (currently
> > > O(n^2)). Does anybody have a simpler idea? Does anyone have any
> > > constructive suggestion on how to improve the situation?
> >=20
> > This seems to come up every few months.  There was a patch submitted
> > here:
> >=20
> > http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037641.html
>=20
> I think this comes up often enough for us to fix it (IIRC unionfs
> people complained about it long ago too), and it's kind of lame to
> spend 17 seconds in the kernel without scheduling.  So I dug up some
> old patches that should reduce the complexity to O(n logn), using the
> sort() function, which IMO is preferable to doing our own hash thing
> as that patch from June does.  Only the 64-bit code is tested.  Does
> this help your situation?
>=20
>  arch/powerpc/kernel/module_32.c |   85=20
> +++++++++++++++++++++++++++++++---------
>  arch/powerpc/kernel/module_64.c |   80=20
> ++++++++++++++++++++++++++++++-------
>  2 files changed, 132 insertions(+), 33 deletions(-)
>=20
>=20
> diff --git a/arch/powerpc/kernel/module_32.c=20
> b/arch/powerpc/kernel/module_32.c
> index 07a89a3..001b941 100644
> --- a/arch/powerpc/kernel/module_32.c
> +++ b/arch/powerpc/kernel/module_32.c
> @@ -24,6 +24,7 @@
>  #include <linux/kernel.h>
>  #include <linux/cache.h>
>  #include <linux/bug.h>
> +#include <linux/sort.h>
> =20
>  #include "setup.h"
> =20
> @@ -50,26 +51,64 @@ void module_free(struct module *mod, void=20
> *module_region)
>             table entries. */
>  }
> =20
> +static int reloc_cmp(const void *_a, const void *_b)
> +{
> +	const Elf32_Rela *a =3D *(Elf32_Rela **)_a, *b =3D=20
> *(Elf32_Rela **)_b;
> +
> +	if (a->r_info < b->r_info)
> +		return -1;
> +	else if (a->r_info > b->r_info)
> +		return 1;
> +	else if (a->r_addend < b->r_addend)
> +		return -1;
> +	else if (a->r_addend > b->r_addend)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +
>  /* Count how many different relocations (different symbol, different
>     addend) */
>  static unsigned int count_relocs(const Elf32_Rela *rela,=20
> unsigned int num)
>  {
> -	unsigned int i, j, ret =3D 0;
> +	unsigned int i, sorted_count =3D 0;
> +	Elf32_Word last_info;
> +	Elf32_Sword last_addend;
> +	Elf32_Rela **sortbuf =3D NULL;
> +
> +	if (num =3D=3D 0)
> +		return 0;
> +
> +	sortbuf =3D vmalloc(num * sizeof(*sortbuf));
> +
> +	if (!sortbuf)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < num; i++)
> +		sortbuf[i] =3D (Elf32_Rela *)&rela[i];
> +
> +	sort(sortbuf, i, sizeof(sortbuf[0]), reloc_cmp, NULL);
> +
> +	last_info =3D sortbuf[0]->r_info;
> +	last_addend =3D sortbuf[0]->r_addend;
> +	sorted_count =3D 1;
> =20
> -	/* Sure, this is order(n^2), but it's usually short, and not
> -           time critical */
>  	for (i =3D 0; i < num; i++) {
> -		for (j =3D 0; j < i; j++) {
> -			/* If this addend appeared before, it's
> -                           already been counted */
> -			if (ELF32_R_SYM(rela[i].r_info)
> -			    =3D=3D ELF32_R_SYM(rela[j].r_info)
> -			    && rela[i].r_addend =3D=3D rela[j].r_addend)
> -				break;
> -		}
> -		if (j =3D=3D i) ret++;
> +		/* If this r_info,r_addend tuple matches the previous
> +		 * entry, don't count it again
> +		 */
> +		if (sortbuf[i]->r_info =3D=3D last_info &&
> +		    sortbuf[i]->r_addend =3D=3D last_addend)
> +			continue;
> +
> +		last_info =3D sortbuf[i]->r_info;
> +		last_addend =3D sortbuf[i]->r_addend;
> +		sorted_count++;
>  	}
> -	return ret;
> +
> +	vfree(sortbuf);
> +	return sorted_count;
>  }
> =20
>  /* Get the potential trampolines size required of the init and
> @@ -96,15 +135,19 @@ static unsigned long get_plt_size(const=20
> Elf32_Ehdr *hdr,
>  			continue;
> =20
>  		if (sechdrs[i].sh_type =3D=3D SHT_RELA) {
> +			int count;
>  			DEBUGP("Found relocations in section %u\n", i);
>  			DEBUGP("Ptr: %p.  Number: %u\n",
>  			       (void *)hdr + sechdrs[i].sh_offset,
>  			       sechdrs[i].sh_size / sizeof(Elf32_Rela));
> -			ret +=3D count_relocs((void *)hdr
> +			count =3D count_relocs((void *)hdr
>  					     + sechdrs[i].sh_offset,
>  					     sechdrs[i].sh_size
>  					     / sizeof(Elf32_Rela))
>  				* sizeof(struct ppc_plt_entry);
> +			if (count < 0)
> +				return count;
> +			ret +=3D count;
>  		}
>  	}
> =20
> @@ -117,6 +160,7 @@ int module_frob_arch_sections(Elf32_Ehdr *hdr,
>  			      struct module *me)
>  {
>  	unsigned int i;
> +	int ret;
> =20
>  	/* Find .plt and .init.plt sections */
>  	for (i =3D 0; i < hdr->e_shnum; i++) {
> @@ -131,10 +175,15 @@ int module_frob_arch_sections(Elf32_Ehdr *hdr,
>  	}
> =20
>  	/* Override their sizes */
> -	sechdrs[me->arch.core_plt_section].sh_size
> -		=3D get_plt_size(hdr, sechdrs, secstrings, 0);
> -	sechdrs[me->arch.init_plt_section].sh_size
> -		=3D get_plt_size(hdr, sechdrs, secstrings, 1);
> +	ret =3D get_plt_size(hdr, sechdrs, secstrings, 0);
> +	if (ret < 0)
> +		return ret;
> +	sechdrs[me->arch.core_plt_section].sh_size =3D ret;
> +
> +	ret =3D get_plt_size(hdr, sechdrs, secstrings, 1);
> +	if (ret < 0)
> +		return ret;
> +	sechdrs[me->arch.init_plt_section].sh_size =3D ret;
>  	return 0;
>  }
> =20
> diff --git a/arch/powerpc/kernel/module_64.c=20
> b/arch/powerpc/kernel/module_64.c
> index 75c7c4f..bfc5b98 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -21,6 +21,7 @@
>  #include <linux/err.h>
>  #include <linux/vmalloc.h>
>  #include <linux/bug.h>
> +#include <linux/sort.h>
>  #include <asm/module.h>
>  #include <asm/uaccess.h>
>  #include <asm/firmware.h>
> @@ -77,28 +78,68 @@ static struct ppc64_stub_entry ppc64_stub =3D
>  	0x4e, 0x80, 0x04, 0x20  /* bctr */
>  } };
> =20
> +static int reloc_cmp(const void *_a, const void *_b)
> +{
> +	const Elf64_Rela *a =3D *(Elf64_Rela **)_a, *b =3D=20
> *(Elf64_Rela **)_b;
> +
> +	if (a->r_info < b->r_info)
> +		return -1;
> +	else if (a->r_info > b->r_info)
> +		return 1;
> +	else if (a->r_addend < b->r_addend)
> +		return -1;
> +	else if (a->r_addend > b->r_addend)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  /* Count how many different 24-bit relocations (different symbol,
>     different addend) */
> -static unsigned int count_relocs(const Elf64_Rela *rela,=20
> unsigned int num)
> +static int count_relocs(const Elf64_Rela *rela, unsigned int num)
>  {
>  	unsigned int i, j, ret =3D 0;
> +	Elf64_Xword last_info;
> +	Elf64_Sxword last_addend;
> +	Elf64_Rela **sortbuf =3D NULL;
> +
> +	if (num =3D=3D 0)
> +		return 0;
> +
> +	sortbuf =3D vmalloc(num * sizeof(*sortbuf));
> =20
> -	/* FIXME: Only count external ones --RR */
> -	/* Sure, this is order(n^2), but it's usually short, and not
> -           time critical */
> -	for (i =3D 0; i < num; i++) {
> +	if (!sortbuf)
> +		return -ENOMEM;
> +
> +	for (j =3D 0, i =3D 0; i < num; i++) {
>  		/* Only count 24-bit relocs, others don't need stubs */
>  		if (ELF64_R_TYPE(rela[i].r_info) !=3D R_PPC_REL24)
>  			continue;
> -		for (j =3D 0; j < i; j++) {
> -			/* If this addend appeared before, it's
> -                           already been counted */
> -			if (rela[i].r_info =3D=3D rela[j].r_info
> -			    && rela[i].r_addend =3D=3D rela[j].r_addend)
> -				break;
> -		}
> -		if (j =3D=3D i) ret++;
> +		sortbuf[j++] =3D (Elf64_Rela *)&rela[i];
>  	}
> +
> +	if (j =3D=3D 0)
> +		goto out;
> +
> +	sort(sortbuf, j, sizeof(sortbuf[0]), reloc_cmp, NULL);
> +
> +	last_info =3D sortbuf[0]->r_info;
> +	last_addend =3D sortbuf[0]->r_addend;
> +	ret =3D 1;
> +	for (i =3D 0; i < j; i++) {
> +		/* If this r_info,r_addend tuple matches the previous
> +		 * entry, don't count it again
> +		 */
> +		if (sortbuf[i]->r_info =3D=3D last_info &&
> +		    sortbuf[i]->r_addend =3D=3D last_addend)
> +			continue;
> +
> +		last_info =3D sortbuf[i]->r_info;
> +		last_addend =3D sortbuf[i]->r_addend;
> +		ret++;
> +	}
> +out:
> +	vfree(sortbuf);
>  	return ret;
>  }
> =20
> @@ -129,13 +170,17 @@ static unsigned long=20
> get_stubs_size(const Elf64_Ehdr *hdr,
>  	/* Every relocated section... */
>  	for (i =3D 1; i < hdr->e_shnum; i++) {
>  		if (sechdrs[i].sh_type =3D=3D SHT_RELA) {
> +			int count;
>  			DEBUGP("Found relocations in section %u\n", i);
>  			DEBUGP("Ptr: %p.  Number: %lu\n",
>  			       (void *)sechdrs[i].sh_addr,
>  			       sechdrs[i].sh_size / sizeof(Elf64_Rela));
> -			relocs +=3D count_relocs((void=20
> *)sechdrs[i].sh_addr,
> +			count =3D count_relocs((void *)sechdrs[i].sh_addr,
>  					       sechdrs[i].sh_size
>  					       / sizeof(Elf64_Rela));
> +			if (count < 0)
> +				return count;
> +			relocs +=3D count;
>  		}
>  	}
> =20
> @@ -173,6 +218,7 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
>  			      struct module *me)
>  {
>  	unsigned int i;
> +	int stubs_size;
> =20
>  	/* Find .toc and .stubs sections, symtab and strtab */
>  	for (i =3D 1; i < hdr->e_shnum; i++) {
> @@ -209,7 +255,11 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
>  		me->arch.toc_section =3D me->arch.stubs_section;
> =20
>  	/* Override the stubs size */
> -	sechdrs[me->arch.stubs_section].sh_size =3D=20
> get_stubs_size(hdr, sechdrs);
> +	stubs_size =3D get_stubs_size(hdr, sechdrs);
> +	if (stubs_size < 0)
> +		return stubs_size;
> +
> +	sechdrs[me->arch.stubs_section].sh_size =3D stubs_size;
>  	return 0;
>  }
