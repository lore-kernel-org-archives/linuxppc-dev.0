Return-Path: <Emilian.Medve@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2] [POWERPC] Optimize counting distinct entries in the
	relocation sections
Date: Tue, 27 Nov 2007 07:54:07 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E2701827F50@az33exm24.fsl.freescale.net>
In-Reply-To: <1194971044-28840-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1194971044-28840-1-git-send-email-Emilian.Medve@Freescale.com>
From: "Medve Emilian" <Emilian.Medve@freescale.com>
To: <paulus@samba.org>, <rusty@rustcorp.com.au>, <ntl@pobox.com>,
	<sfr@canb.auug.org.au>, <behlendorf1@llnl.gov>,
	<galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,


I'm just wondering what are your latest thoughts about this patch
(http://patchwork.ozlabs.org/linuxppc/patch?id=3D14707).


Cheers,
Emil.


> -----Original Message-----
> From: Medve Emilian=20
> Sent: Tuesday, November 13, 2007 10:24 AM
> To: paulus@samba.org; rusty@rustcorp.com.au; ntl@pobox.com;=20
> sfr@canb.auug.org.au; behlendorf1@llnl.gov;=20
> galak@kernel.crashing.org; linuxppc-dev@ozlabs.org;=20
> linuxppc-embedded@ozlabs.org
> Cc: Medve Emilian
> Subject: [PATCH v2] [POWERPC] Optimize counting distinct=20
> entries in the relocation sections
>=20
> When a module has relocation sections with tens of thousands=20
> worth of entries,
> counting the distinct/unique entries only (i.e. no=20
> duplicates) at load time can
> take tens of seconds and up to minutes. The sore point is the=20
> count_relocs()
> function which is called as part of the architecture specific=20
> module loading
> processing path:
>=20
> 	-> load_module()			generic
> 	   -> module_frob_arch_sections()	arch specific
> 	      -> get_plt_size()		32-bit
> 	      -> get_stubs_size()	64-bit
> 		 -> count_relocs()
>=20
> (Not sure why the relocation tables could contain lots of=20
> duplicates and why
> they are not trimmed at compile time by the linker. In some=20
> test cases, out of
> 35K relocation entries only 1.5K were distinct/unique)
>=20
> The previous counting algorithm was having O(n^2) complexity.=20
> Basically two
> solutions were proposed on the e-mail list: a hash based=20
> approach and a sort
> based approach
>=20
> The hash based approach is the fastest (O(n)) but the has it=20
> needs additional
> memory and for certain corner cases it could take lots of=20
> memory due to the
> degeneration of the hash. One such proposal was submitted here:
>=20
> http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037641.html
>=20
> In this proposal, the symbol + addendum are hashed to=20
> generate a key and a
> pointer to the relocation entry will be stored in it. The=20
> hash is implemented as
> a linked list of memory pages with PAGE_SIZE /=20
> sizeof(Elfxx_Rela *) entries. In
> case of collisions in all the existing pages, a new page is=20
> added to the list to
> accommodate the new distinct relocation entry
>=20
> For 32-bit PowerPCs with 4K pages, a page can accommodate 1K=20
> worth of pointers
> to relocation entries. In the 35K entries scenario, as=20
> much/little of six (6)
> pages could be allocated using 24K of extra memory during the=20
> module load
>=20
> The sort based approach is slower (O(n * log n + n)) but if=20
> the sorting is done
> "in place" it doesn't need additional memory. A proposal was=20
> submitted here:
>=20
> http://ozlabs.org/pipermail/linuxppc-dev/2007-November/045854.html
> =
(http://patchwork.ozlabs.org/linuxppc/patch?filter=3Ddefault&id=3D14573)
>=20
> In this proposal an array of pointers to the relocation=20
> entries is built and
> then is sorted using the kernel sort() utility function. This=20
> is basically a heap
> sort algorithm with a stable O(n * log n) complexity. With=20
> this counting the
> distinct/unique entries is just linear (O(n)) complexity. The=20
> problem is the
> extra memory needed in this proposal, which in the 35K=20
> relocation entries test
> case it can be as much as 140K (for 32-bit PowerPCs; double=20
> for 64-bit). This is
> much more then the memory needed by the hash based approach described
> above/earlier but it doesn't hide potential degenerative corner cases
>=20
> The current patch is a happy compromise between the two=20
> proposals above:
> O(n + n * log n) performance with no additional memory=20
> requirements due to
> sorting in place the relocation table itself
>=20
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
>=20
> This patch only tries to address counting the distinct=20
> R_PPC_REL24 entries for
> the purpose of sizing the PLT. This operation was/can be=20
> detected by the proper
> kernel logic as a soft lockup for large relocation tables
>=20
> A related optimization (that could cause rewriting the this=20
> patch) is to
> optimize the PLT search from do_plt_call() but that doesn't=20
> seem to be a
> problem right now
>=20
> The errors below are false positives due to the fact that=20
> Elfxx_Rela are
> falsely assumed to be variables/operands instead of types:
>=20
> linux-2.6> scripts/checkpatch.pl=20
> 0001-POWERPC-Optimize-counting-distinct-entries-in-the.patch=20
> ERROR: need consistent spacing around '*' (ctx:WxV)
> #116: FILE: arch/powerpc/kernel/module_32.c:78:
> +       const Elf32_Rela *x, *y;
>                          ^
>=20
> ERROR: need consistent spacing around '*' (ctx:WxV)
> #228: FILE: arch/powerpc/kernel/module_64.c:122:
> +       const Elf64_Rela *x, *y;
>                          ^
>=20
> total: 2 errors, 0 warnings, 218 lines checked
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
>  arch/powerpc/kernel/module_32.c |   77=20
> ++++++++++++++++++++++++++++++-------
>  arch/powerpc/kernel/module_64.c |   81=20
> ++++++++++++++++++++++++++++++--------
>  2 files changed, 127 insertions(+), 31 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/module_32.c=20
> b/arch/powerpc/kernel/module_32.c
> index 07a89a3..eab3138 100644
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
> @@ -54,22 +55,60 @@ void module_free(struct module *mod, void=20
> *module_region)
>     addend) */
>  static unsigned int count_relocs(const Elf32_Rela *rela,=20
> unsigned int num)
>  {
> -	unsigned int i, j, ret =3D 0;
> -
> -	/* Sure, this is order(n^2), but it's usually short, and not
> -           time critical */
> -	for (i =3D 0; i < num; i++) {
> -		for (j =3D 0; j < i; j++) {
> -			/* If this addend appeared before, it's
> -                           already been counted */
> -			if (ELF32_R_SYM(rela[i].r_info)
> -			    =3D=3D ELF32_R_SYM(rela[j].r_info)
> -			    && rela[i].r_addend =3D=3D rela[j].r_addend)
> -				break;
> +	unsigned int i, r_info, r_addend, _count_relocs;
> +
> +	_count_relocs =3D 0;
> +	r_info =3D 0;
> +	r_addend =3D 0;
> +	for (i =3D 0; i < num; i++)
> +		/* Only count 24-bit relocs, others don't need stubs */
> +		if (ELF32_R_TYPE(rela[i].r_info) =3D=3D R_PPC_REL24 &&
> +		    (r_info !=3D ELF32_R_SYM(rela[i].r_info) ||
> +		     r_addend !=3D rela[i].r_addend)) {
> +			_count_relocs++;
> +			r_info =3D ELF32_R_SYM(rela[i].r_info);
> +			r_addend =3D rela[i].r_addend;
>  		}
> -		if (j =3D=3D i) ret++;
> +
> +	return _count_relocs;
> +}
> +
> +static int relacmp(const void *_x, const void *_y)
> +{
> +	const Elf32_Rela *x, *y;
> +
> +	y =3D (Elf32_Rela *)_x;
> +	x =3D (Elf32_Rela *)_y;
> +
> +	/* Compare the entire r_info (as opposed to=20
> ELF32_R_SYM(r_info) only) to
> +	 * make the comparison cheaper/faster. It won't affect=20
> the sorting or
> +	 * the counting algorithms' performance
> +	 */
> +	if (x->r_info < y->r_info)
> +		return -1;
> +	else if (x->r_info > y->r_info)
> +		return 1;
> +	else if (x->r_addend < y->r_addend)
> +		return -1;
> +	else if (x->r_addend > y->r_addend)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +static void relaswap(void *_x, void *_y, int size)
> +{
> +	uint32_t *x, *y, tmp;
> +	int i;
> +
> +	y =3D (uint32_t *)_x;
> +	x =3D (uint32_t *)_y;
> +
> +	for (i =3D 0; i < sizeof(Elf32_Rela) / sizeof(uint32_t); i++) {
> +		tmp =3D x[i];
> +		x[i] =3D y[i];
> +		y[i] =3D tmp;
>  	}
> -	return ret;
>  }
> =20
>  /* Get the potential trampolines size required of the init and
> @@ -100,6 +139,16 @@ static unsigned long get_plt_size(const=20
> Elf32_Ehdr *hdr,
>  			DEBUGP("Ptr: %p.  Number: %u\n",
>  			       (void *)hdr + sechdrs[i].sh_offset,
>  			       sechdrs[i].sh_size / sizeof(Elf32_Rela));
> +
> +			/* Sort the relocation information=20
> based on a symbol and
> +			 * addend key. This is a stable O(n*log=20
> n) complexity
> +			 * alogrithm but it will reduce the=20
> complexity of
> +			 * count_relocs() to linear complexity O(n)
> +			 */
> +			sort((void *)hdr + sechdrs[i].sh_offset,
> +			     sechdrs[i].sh_size / sizeof(Elf32_Rela),
> +			     sizeof(Elf32_Rela), relacmp, relaswap);
> +
>  			ret +=3D count_relocs((void *)hdr
>  					     + sechdrs[i].sh_offset,
>  					     sechdrs[i].sh_size
> diff --git a/arch/powerpc/kernel/module_64.c=20
> b/arch/powerpc/kernel/module_64.c
> index 75c7c4f..3a82b02 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -24,6 +24,7 @@
>  #include <asm/module.h>
>  #include <asm/uaccess.h>
>  #include <asm/firmware.h>
> +#include <linux/sort.h>
> =20
>  #include "setup.h"
> =20
> @@ -81,25 +82,23 @@ static struct ppc64_stub_entry ppc64_stub =3D
>     different addend) */
>  static unsigned int count_relocs(const Elf64_Rela *rela,=20
> unsigned int num)
>  {
> -	unsigned int i, j, ret =3D 0;
> +	unsigned int i, r_info, r_addend, _count_relocs;
> =20
>  	/* FIXME: Only count external ones --RR */
> -	/* Sure, this is order(n^2), but it's usually short, and not
> -           time critical */
> -	for (i =3D 0; i < num; i++) {
> +	_count_relocs =3D 0;
> +	r_info =3D 0;
> +	r_addend =3D 0;
> +	for (i =3D 0; i < num; i++)
>  		/* Only count 24-bit relocs, others don't need stubs */
> -		if (ELF64_R_TYPE(rela[i].r_info) !=3D R_PPC_REL24)
> -			continue;
> -		for (j =3D 0; j < i; j++) {
> -			/* If this addend appeared before, it's
> -                           already been counted */
> -			if (rela[i].r_info =3D=3D rela[j].r_info
> -			    && rela[i].r_addend =3D=3D rela[j].r_addend)
> -				break;
> +		if (ELF64_R_TYPE(rela[i].r_info) =3D=3D R_PPC_REL24 &&
> +		    (r_info !=3D ELF64_R_SYM(rela[i].r_info) ||
> +		     r_addend !=3D rela[i].r_addend)) {
> +			_count_relocs++;
> +			r_info =3D ELF64_R_SYM(rela[i].r_info);
> +			r_addend =3D rela[i].r_addend;
>  		}
> -		if (j =3D=3D i) ret++;
> -	}
> -	return ret;
> +
> +	return _count_relocs;
>  }
> =20
>  void *module_alloc(unsigned long size)
> @@ -118,6 +117,44 @@ void module_free(struct module *mod,=20
> void *module_region)
>             table entries. */
>  }
> =20
> +static int relacmp(const void *_x, const void *_y)
> +{
> +	const Elf64_Rela *x, *y;
> +
> +	y =3D (Elf64_Rela *)_x;
> +	x =3D (Elf64_Rela *)_y;
> +
> +	/* Compare the entire r_info (as opposed to=20
> ELF64_R_SYM(r_info) only) to
> +	 * make the comparison cheaper/faster. It won't affect=20
> the sorting or
> +	 * the counting algorithms' performance
> +	 */
> +	if (x->r_info < y->r_info)
> +		return -1;
> +	else if (x->r_info > y->r_info)
> +		return 1;
> +	else if (x->r_addend < y->r_addend)
> +		return -1;
> +	else if (x->r_addend > y->r_addend)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +static void relaswap(void *_x, void *_y, int size)
> +{
> +	uint64_t *x, *y, tmp;
> +	int i;
> +
> +	y =3D (uint64_t *)_x;
> +	x =3D (uint64_t *)_y;
> +
> +	for (i =3D 0; i < sizeof(Elf64_Rela) / sizeof(uint64_t); i++) {
> +		tmp =3D x[i];
> +		x[i] =3D y[i];
> +		y[i] =3D tmp;
> +	}
> +}
> +
>  /* Get size of potential trampolines required. */
>  static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
>  				    const Elf64_Shdr *sechdrs)
> @@ -133,6 +170,16 @@ static unsigned long=20
> get_stubs_size(const Elf64_Ehdr *hdr,
>  			DEBUGP("Ptr: %p.  Number: %lu\n",
>  			       (void *)sechdrs[i].sh_addr,
>  			       sechdrs[i].sh_size / sizeof(Elf64_Rela));
> +
> +			/* Sort the relocation information=20
> based on a symbol and
> +			 * addend key. This is a stable O(n*log=20
> n) complexity
> +			 * alogrithm but it will reduce the=20
> complexity of
> +			 * count_relocs() to linear complexity O(n)
> +			 */
> +			sort((void *)sechdrs[i].sh_addr,
> +			     sechdrs[i].sh_size / sizeof(Elf64_Rela),
> +			     sizeof(Elf64_Rela), relacmp, relaswap);
> +
>  			relocs +=3D count_relocs((void=20
> *)sechdrs[i].sh_addr,
>  					       sechdrs[i].sh_size
>  					       / sizeof(Elf64_Rela));
> @@ -343,7 +390,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>  			/* Simply set it */
>  			*(u32 *)location =3D value;
>  			break;
> -		=09
> +
>  		case R_PPC64_ADDR64:
>  			/* Simply set it */
>  			*(unsigned long *)location =3D value;
> @@ -399,7 +446,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>  			}
> =20
>  			/* Only replace bits 2 through 26 */
> -			*(uint32_t *)location=20
> +			*(uint32_t *)location
>  				=3D (*(uint32_t *)location & ~0x03fffffc)
>  				| (value & 0x03fffffc);
>  			break;
> --=20
> 1.5.3.GIT
