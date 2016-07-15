Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrKX23qDHzDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 14:36:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joe Perches <joe@perches.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powernv: Use __printf in pe_level_printk
In-Reply-To: <b204dbb1d8d13998eb8dee4dabbc91a0ee4b38b4.1468511136.git.joe@perches.com>
References: <b204dbb1d8d13998eb8dee4dabbc91a0ee4b38b4.1468511136.git.joe@perches.com>
Date: Fri, 15 Jul 2016 14:36:17 +1000
Message-ID: <87eg6vbjr2.fsf@@concordia.ellerman.id.au>
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

Joe Perches <joe@perches.com> writes:

> Make the compiler detect format and argument mismatches.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/powerpc/platforms/powernv/pci.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 3a97990..1c1a586 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -213,6 +213,7 @@ extern void pnv_pci_dma_bus_setup(struct pci_bus *bus=
);
>  extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
>  extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
>=20=20
> +__printf(3, 4)
>  extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *le=
vel,
>  			    const char *fmt, ...);

Thanks, but it breaks the build due to lots of new warnings.

We'll have to fix those before merging it.

cheers

In file included from ../arch/powerpc/platforms/powernv/pci-ioda.c:49:0:
../arch/powerpc/platforms/powernv/pci-ioda.c: In function =E2=80=98pnv_ioda=
_deconfigure_pe=E2=80=99:
../arch/powerpc/platforms/powernv/pci-ioda.c:784:15: error: format =E2=80=
=98%ld=E2=80=99 expects argument of type =E2=80=98long int=E2=80=99, but ar=
gument 4 has type =E2=80=98int64_t {aka long long int}=E2=80=99 [-Werror=3D=
format=3D]
   pe_warn(pe, "OPAL error %ld remove self from PELTV\n", rc);
               ^
../arch/powerpc/platforms/powernv/pci.h:233:36: note: in definition of macr=
o =E2=80=98pe_warn=E2=80=99
  pe_level_printk(pe, KERN_WARNING, fmt, ##__VA_ARGS__)
                                    ^~~
../arch/powerpc/platforms/powernv/pci-ioda.c:788:14: error: format =E2=80=
=98%ld=E2=80=99 expects argument of type =E2=80=98long int=E2=80=99, but ar=
gument 4 has type =E2=80=98int64_t {aka long long int}=E2=80=99 [-Werror=3D=
format=3D]
   pe_err(pe, "OPAL error %ld trying to setup PELT table\n", rc);
              ^
../arch/powerpc/platforms/powernv/pci.h:231:32: note: in definition of macr=
o =E2=80=98pe_err=E2=80=99
  pe_level_printk(pe, KERN_ERR, fmt, ##__VA_ARGS__)
                                ^~~
../arch/powerpc/platforms/powernv/pci-ioda.c: In function =E2=80=98pnv_ioda=
_setup_bus_PE=E2=80=99:
../arch/powerpc/platforms/powernv/pci-ioda.c:1095:15: error: format =E2=80=
=98%d=E2=80=99 expects argument of type =E2=80=98int=E2=80=99, but argument=
 4 has type =E2=80=98resource_size_t {aka long long unsigned int}=E2=80=99 =
[-Werror=3Dformat=3D]
   pe_info(pe, "Secondary bus %d..%d associated with PE#%d\n",
               ^
../arch/powerpc/platforms/powernv/pci.h:235:33: note: in definition of macr=
o =E2=80=98pe_info=E2=80=99
  pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
                                 ^~~
../arch/powerpc/platforms/powernv/pci-ioda.c:1095:15: error: format =E2=80=
=98%d=E2=80=99 expects argument of type =E2=80=98int=E2=80=99, but argument=
 5 has type =E2=80=98resource_size_t {aka long long unsigned int}=E2=80=99 =
[-Werror=3Dformat=3D]
   pe_info(pe, "Secondary bus %d..%d associated with PE#%d\n",
               ^
../arch/powerpc/platforms/powernv/pci.h:235:33: note: in definition of macr=
o =E2=80=98pe_info=E2=80=99
  pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
                                 ^~~
../arch/powerpc/platforms/powernv/pci-ioda.c:1098:15: error: format =E2=80=
=98%d=E2=80=99 expects argument of type =E2=80=98int=E2=80=99, but argument=
 4 has type =E2=80=98resource_size_t {aka long long unsigned int}=E2=80=99 =
[-Werror=3Dformat=3D]
   pe_info(pe, "Secondary bus %d associated with PE#%d\n",
               ^
../arch/powerpc/platforms/powernv/pci.h:235:33: note: in definition of macr=
o =E2=80=98pe_info=E2=80=99
  pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
                                 ^~~
../arch/powerpc/platforms/powernv/pci-ioda.c: In function =E2=80=98pnv_pci_=
ioda2_release_dma_pe=E2=80=99:
../arch/powerpc/platforms/powernv/pci-ioda.c:1351:15: error: format =E2=80=
=98%ld=E2=80=99 expects argument of type =E2=80=98long int=E2=80=99, but ar=
gument 4 has type =E2=80=98int64_t {aka long long int}=E2=80=99 [-Werror=3D=
format=3D]
   pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
               ^
../arch/powerpc/platforms/powernv/pci.h:233:36: note: in definition of macr=
o =E2=80=98pe_warn=E2=80=99
  pe_level_printk(pe, KERN_WARNING, fmt, ##__VA_ARGS__)
                                    ^~~
../arch/powerpc/platforms/powernv/pci-ioda.c: In function =E2=80=98pnv_pci_=
ioda1_setup_dma_pe=E2=80=99:
../arch/powerpc/platforms/powernv/pci-ioda.c:2093:15: error: format =E2=80=
=98%ld=E2=80=99 expects argument of type =E2=80=98long int=E2=80=99, but ar=
gument 4 has type =E2=80=98int64_t {aka long long int}=E2=80=99 [-Werror=3D=
format=3D]
    pe_err(pe, " Failed to configure 32-bit TCE table,"
               ^
../arch/powerpc/platforms/powernv/pci.h:231:32: note: in definition of macr=
o =E2=80=98pe_err=E2=80=99
  pe_level_printk(pe, KERN_ERR, fmt, ##__VA_ARGS__)
                                ^~~
../arch/powerpc/platforms/powernv/pci-ioda.c: In function =E2=80=98pnv_pci_=
ioda2_set_window=E2=80=99:
../arch/powerpc/platforms/powernv/pci-ioda.c:2153:14: error: format =E2=80=
=98%x=E2=80=99 expects argument of type =E2=80=98unsigned int=E2=80=99, but=
 argument 7 has type =E2=80=98long unsigned int=E2=80=99 [-Werror=3Dformat=
=3D]
  pe_info(pe, "Setting up window#%d %llx..%llx pg=3D%x\n", num,
              ^
../arch/powerpc/platforms/powernv/pci.h:235:33: note: in definition of macr=
o =E2=80=98pe_info=E2=80=99
  pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
                                 ^~~
../arch/powerpc/platforms/powernv/pci-ioda.c:2169:14: error: format =E2=80=
=98%ld=E2=80=99 expects argument of type =E2=80=98long int=E2=80=99, but ar=
gument 4 has type =E2=80=98int64_t {aka long long int}=E2=80=99 [-Werror=3D=
format=3D]
   pe_err(pe, "Failed to configure TCE table, err %ld\n", rc);
              ^
../arch/powerpc/platforms/powernv/pci.h:231:32: note: in definition of macr=
o =E2=80=98pe_err=E2=80=99
  pe_level_printk(pe, KERN_ERR, fmt, ##__VA_ARGS__)
                                ^~~
../arch/powerpc/platforms/powernv/pci-ioda.c: In function =E2=80=98pnv_pci_=
ioda2_release_pe_dma=E2=80=99:
../arch/powerpc/platforms/powernv/pci-ioda.c:3312:15: error: format =E2=80=
=98%ld=E2=80=99 expects argument of type =E2=80=98long int=E2=80=99, but ar=
gument 4 has type =E2=80=98int64_t {aka long long int}=E2=80=99 [-Werror=3D=
format=3D]
   pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
               ^
../arch/powerpc/platforms/powernv/pci.h:233:36: note: in definition of macr=
o =E2=80=98pe_warn=E2=80=99
  pe_level_printk(pe, KERN_WARNING, fmt, ##__VA_ARGS__)
                                    ^~~
../arch/powerpc/platforms/powernv/pci-ioda.c: In function =E2=80=98pnv_ioda=
_free_pe_seg=E2=80=99:
../arch/powerpc/platforms/powernv/pci-ioda.c:3347:16: error: format =E2=80=
=98%ld=E2=80=99 expects argument of type =E2=80=98long int=E2=80=99, but ar=
gument 4 has type =E2=80=98int64_t {aka long long int}=E2=80=99 [-Werror=3D=
format=3D]
    pe_warn(pe, "Error %ld unmapping (%d) segment#%d\n",
                ^
../arch/powerpc/platforms/powernv/pci.h:233:36: note: in definition of macr=
o =E2=80=98pe_warn=E2=80=99
  pe_level_printk(pe, KERN_WARNING, fmt, ##__VA_ARGS__)
                                    ^~~
