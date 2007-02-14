Return-Path: <Masato.Noguchi@jp.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/3] powerpc: Remove SPU struct page's for PS3
Date: Wed, 14 Feb 2007 10:32:47 +0900
Message-ID: <C3DCD550FB9ACD4D911D1271DD8CFDD2014625A5@jptkyxms38.jp.sony.com>
From: "Noguchi, Masato" <Masato.Noguchi@jp.sony.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Paul Mackerras" <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I read it carefully and ran testsuite on PS3 platform with it.
It seems pretty good.

Regards,
  >> Masato.Noguchi@jp.sony.com <<

> -----Original Message-----
> From: cbe-oss-dev-bounces+masato.noguchi=3Djp.sony.com@ozlabs.org
> [mailto:cbe-oss-dev-bounces+masato.noguchi=3Djp.sony.com@ozlabs.org] =
On
> Behalf Of Benjamin Herrenschmidt
> Sent: Tuesday, February 13, 2007 9:46 AM
> To: Paul Mackerras
> Cc: linuxppc-dev@ozlabs.org; cbe-oss-dev@ozlabs.org
> Subject: [Cbe-oss-dev] [PATCH 2/3] powerpc: Remove SPU struct page's
for PS3
>=20
> Struct page are no longer needed for SPUs, so let's not create them
> on PS3 anymore.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
>  arch/powerpc/platforms/ps3/spu.c |   42
> +--------------------------------------
>  1 file changed, 2 insertions(+), 40 deletions(-)
>=20
> Index: linux-cell/arch/powerpc/platforms/ps3/spu.c
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-cell.orig/arch/powerpc/platforms/ps3/spu.c	2007-02-13
> 11:34:38.000000000 +1100
> +++ linux-cell/arch/powerpc/platforms/ps3/spu.c	2007-02-13
> 11:37:07.000000000 +1100
> @@ -170,31 +170,6 @@ static int __init construct_spu(struct s
>  	return result;
>  }
>=20
> -static int __init add_spu_pages(unsigned long start_addr, unsigned
long size)
> -{
> -	int result;
> -	unsigned long start_pfn;
> -	unsigned long nr_pages;
> -	struct pglist_data *pgdata;
> -	struct zone *zone;
> -
> -	BUG_ON(!mem_init_done);
> -
> -	start_pfn =3D start_addr >> PAGE_SHIFT;
> -	nr_pages =3D (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> -
> -	pgdata =3D NODE_DATA(0);
> -	zone =3D pgdata->node_zones;
> -
> -	result =3D __add_pages(zone, start_pfn, nr_pages);
> -
> -	if (result)
> -		pr_debug("%s:%d: __add_pages failed: (%d)\n",
> -			__func__, __LINE__, result);
> -
> -	return result;
> -}
> -
>  static void spu_unmap(struct spu *spu)
>  {
>  	iounmap(spu->priv2);
> @@ -206,19 +181,6 @@ static void spu_unmap(struct spu *spu)
>  static int __init setup_areas(struct spu *spu)
>  {
>  	struct table {char* name; unsigned long addr; unsigned long
size;};
> -	int result;
> -
> -	/* setup pages */
> -
> -	result =3D add_spu_pages(spu->local_store_phys, LS_SIZE);
> -	if (result)
> -		goto fail_add;
> -
> -	result =3D add_spu_pages(spu->problem_phys, sizeof(struct
> spu_problem));
> -	if (result)
> -		goto fail_add;
> -
> -	/* ioremap */
>=20
>  	spu_pdata(spu)->shadow =3D __ioremap(
>  		spu_pdata(spu)->shadow_addr, sizeof(struct spe_shadow),
> @@ -260,8 +222,8 @@ static int __init setup_areas(struct spu
>=20
>  fail_ioremap:
>  	spu_unmap(spu);
> -fail_add:
> -	return result;
> +
> +	return -ENOMEM;
>  }
>=20
>  static int __init setup_interrupts(struct spu *spu)
> _______________________________________________
> cbe-oss-dev mailing list
> cbe-oss-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/cbe-oss-dev
