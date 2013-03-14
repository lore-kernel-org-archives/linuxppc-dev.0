Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 0050D2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 03:26:25 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix -mcmodel=medium breakage in prom_init.c
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20130312225151.2faeb395@kryten>
Date: Thu, 14 Mar 2013 17:26:17 +0100
Message-Id: <944D093B-3C8D-4832-BF23-D8CC0D9EA287@suse.de>
References: <20130312225151.2faeb395@kryten>
To: Anton Blanchard <anton@samba.org>
Cc: amodra@gmail.com, linuxppc-dev@lists.ozlabs.org, aaro.koskinen@iki.fi
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 12.03.2013, at 12:51, Anton Blanchard wrote:

>=20
> Commit 5ac47f7a6efb (powerpc: Relocate prom_init.c on 64bit) made
> prom_init.c position independent by manually relocating its entries
> in the TOC.
>=20
> We get the address of the TOC entries with the __prom_init_toc_start
> linker symbol. If __prom_init_toc_start ends up as an entry in the
> TOC then we need to add an offset to get the current address. This is
> the case for older toolchains.
>=20
> On the other hand, if we have a newer toolchain that supports
> -mcmodel=3Dmedium then __prom_init_toc_start will be created by a
> relative offset from r2 (the TOC pointer). Since r2 has already been
> relocated, nothing more needs to be done.  Adding an offset in this
> case is wrong and Aaro Koskinen and Alexander Graf have noticed =
noticed
> G5 and OpenBIOS breakage.
>=20
> Alan Modra suggested we just use r2 to get at the TOC which is simpler
> and works with both old and new toolchains.
>=20
> Reported-by: Alexander Graf <agraf@suse.de>
> Signed-off-by: Anton Blanchard <anton@samba.org>

This fixes my G5 again as well.

Acked-by: Alexander Graf <agraf@suse.de>

Please make sure this patch goes into 3.9.


Alex


> ---
>=20
> Thanks Aaro for reporting this, and Alexander for an initial
> fix. This tested ok for me with both a new and an old toolchain,
> but would appreciate if you could double check it fixes your issues
> too.
>=20
> diff --git a/arch/powerpc/kernel/prom_init.c =
b/arch/powerpc/kernel/prom_init.c
> index 7f7fb7f..13f8d16 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -2832,11 +2832,13 @@ static void unreloc_toc(void)
> {
> }
> #else
> -static void __reloc_toc(void *tocstart, unsigned long offset,
> -			unsigned long nr_entries)
> +static void __reloc_toc(unsigned long offset, unsigned long =
nr_entries)
> {
> 	unsigned long i;
> -	unsigned long *toc_entry =3D (unsigned long *)tocstart;
> +	unsigned long *toc_entry;
> +
> +	/* Get the start of the TOC by using r2 directly. */
> +	asm volatile("addi %0,2,-0x8000" : "=3Db" (toc_entry));
>=20
> 	for (i =3D 0; i < nr_entries; i++) {
> 		*toc_entry =3D *toc_entry + offset;
> @@ -2850,8 +2852,7 @@ static void reloc_toc(void)
> 	unsigned long nr_entries =3D
> 		(__prom_init_toc_end - __prom_init_toc_start) / =
sizeof(long);
>=20
> -	/* Need to add offset to get at __prom_init_toc_start */
> -	__reloc_toc(__prom_init_toc_start + offset, offset, nr_entries);
> +	__reloc_toc(offset, nr_entries);
>=20
> 	mb();
> }
> @@ -2864,8 +2865,7 @@ static void unreloc_toc(void)
>=20
> 	mb();
>=20
> -	/* __prom_init_toc_start has been relocated, no need to add =
offset */
> -	__reloc_toc(__prom_init_toc_start, -offset, nr_entries);
> +	__reloc_toc(-offset, nr_entries);
> }
> #endif
> #endif
