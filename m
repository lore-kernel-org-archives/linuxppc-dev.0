Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [patch 4/5] cell: saving spus information for
	kexec crash
From: Michael Ellerman <michael@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20070618224923.498962312@arndb.de>
References: <20070618224247.972139855@arndb.de>
	<20070618224923.498962312@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-YuaHsJ4utt8P/ETpzEwb"
Date: Tue, 19 Jun 2007 09:58:39 +1000
Message-Id: <1182211119.23887.3.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	Lucio Jose Herculano Correia <luciojhc@br.ibm.com>,
	Andre Detsch <adetsch@br.ibm.com>, cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-YuaHsJ4utt8P/ETpzEwb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-06-19 at 00:42 +0200, Arnd Bergmann wrote:
> plain text document attachment (cell-spus-info-kexec-crash-1.diff)
> From: Andre Detsch <adetsch@br.ibm.com>
> This patch adds support for investigating spus information after a
> kernel crash event, through kdump vmcore file.
> Implementation is based on xmon code, but the new functionality was
> kept independent from xmon.
>=20
> Signed-off-by: Lucio Jose Herculano Correia <luciojhc@br.ibm.com>
> Signed-off-by: Andre Detsch <adetsch@br.ibm.com>
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>


I'd like to have this patch share the emergency stopping logic with the
xmon code, I'll try and get a patch done in the next few days.

cheers

> Index: linux-2.6/arch/powerpc/kernel/crash.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/kernel/crash.c
> +++ linux-2.6/arch/powerpc/kernel/crash.c
> @@ -219,6 +219,70 @@ void crash_kexec_secondary(struct pt_reg
>  	cpus_in_sr =3D CPU_MASK_NONE;
>  }
>  #endif
> +#ifdef CONFIG_SPU_BASE
> +
> +#include <asm/spu.h>
> +#include <asm/spu_priv1.h>
> +
> +struct crash_spu_info {
> +	struct spu *spu;
> +	u32 saved_spu_runcntl_RW;
> +	u32 saved_spu_status_R;
> +	u32 saved_spu_npc_RW;
> +	u64 saved_mfc_sr1_RW;
> +	u64 saved_mfc_dar;
> +	u64 saved_mfc_dsisr;
> +};
> +
> +#define CRASH_NUM_SPUS	16	/* Enough for current hardware */
> +static struct crash_spu_info crash_spu_info[CRASH_NUM_SPUS];
> +
> +static void crash_kexec_stop_spus(void)
> +{
> +	struct spu *spu;
> +	int i;
> +	u64 tmp;
> +
> +	for (i =3D 0; i < CRASH_NUM_SPUS; i++) {
> +		if (!crash_spu_info[i].spu)
> +			continue;
> +
> +		spu =3D crash_spu_info[i].spu;
> +
> +		crash_spu_info[i].saved_spu_runcntl_RW =3D
> +			in_be32(&spu->problem->spu_runcntl_RW);
> +		crash_spu_info[i].saved_spu_status_R =3D
> +			in_be32(&spu->problem->spu_status_R);
> +		crash_spu_info[i].saved_spu_npc_RW =3D
> +			in_be32(&spu->problem->spu_npc_RW);
> +
> +		crash_spu_info[i].saved_mfc_dar    =3D spu_mfc_dar_get(spu);
> +		crash_spu_info[i].saved_mfc_dsisr  =3D spu_mfc_dsisr_get(spu);
> +		tmp =3D spu_mfc_sr1_get(spu);
> +		crash_spu_info[i].saved_mfc_sr1_RW =3D tmp;
> +
> +		tmp &=3D ~MFC_STATE1_MASTER_RUN_CONTROL_MASK;
> +		spu_mfc_sr1_set(spu, tmp);
> +
> +		__delay(200);
> +	}
> +}
> +
> +void crash_register_spus(struct list_head *list)
> +{
> +	struct spu *spu;
> +
> +	list_for_each_entry(spu, list, full_list) {
> +		if (spu->number >=3D CRASH_NUM_SPUS) {
> +			WARN_ON(1);
> +			continue;
> +		}
> +
> +		crash_spu_info[spu->number].spu =3D spu;
> +	}
> +}
> +
> +#endif /* CONFIG_SPU_BASE */
> =20
>  void default_machine_crash_shutdown(struct pt_regs *regs)
>  {
> @@ -254,6 +318,9 @@ void default_machine_crash_shutdown(stru
>  	crash_save_cpu(regs, crashing_cpu);
>  	crash_kexec_prepare_cpus(crashing_cpu);
>  	cpu_set(crashing_cpu, cpus_in_crash);
> +#ifdef CONFIG_SPU_BASE
> +	crash_kexec_stop_spus();
> +#endif
>  	if (ppc_md.kexec_cpu_down)
>  		ppc_md.kexec_cpu_down(1, 0);
>  }
> Index: linux-2.6/include/asm-powerpc/spu.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/asm-powerpc/spu.h
> +++ linux-2.6/include/asm-powerpc/spu.h
> @@ -166,6 +166,10 @@ int spu_irq_class_0_bottom(struct spu *s
>  int spu_irq_class_1_bottom(struct spu *spu);
>  void spu_irq_setaffinity(struct spu *spu, int cpu);
> =20
> +#ifdef CONFIG_KEXEC
> +void crash_register_spus(struct list_head *list);
> +#endif
> +
>  extern void spu_invalidate_slbs(struct spu *spu);
>  extern void spu_associate_mm(struct spu *spu, struct mm_struct *mm);
> =20
> Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
> +++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
> @@ -610,6 +610,9 @@ static int __init init_spu_base(void)
>  	}
> =20
>  	xmon_register_spus(&spu_full_list);
> +#ifdef CONFIG_KEXEC
> +	crash_register_spus(&spu_full_list);
> +#endif
> =20
>  	return 0;
> =20
>=20
> --
>=20
> _______________________________________________
> cbe-oss-dev mailing list
> cbe-oss-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/cbe-oss-dev
--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-YuaHsJ4utt8P/ETpzEwb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGdxwvdSjSd0sB4dIRAikQAKCHoy7+sjTAPNf4AQOGj6h6QC2QAgCePPtr
GlI3UMkwW0WrxBHTmfEyxMA=
=+JIY
-----END PGP SIGNATURE-----

--=-YuaHsJ4utt8P/ETpzEwb--
