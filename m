Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdq9Q45npzDqfS
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Apr 2016 21:13:30 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] spapr: Don't set the TM ibm,
 pa-features bit in PR KVM mode
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20160404210928.0d9ae644@kryten>
Date: Mon, 4 Apr 2016 13:13:18 +0200
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 David Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@lists.ozlabs.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-Id: <F99A6122-6B6D-45A3-99E2-2F56F143FB50@suse.de>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten> <20160404210928.0d9ae644@kryten>
To: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> Am 04.04.2016 um 13:09 schrieb Anton Blanchard <anton@samba.org>:
>=20
> We don't support transactional memory in PR KVM, so don't tell
> the OS that we do.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e7be21e..538bd87 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -696,6 +696,12 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *=
fdt, int offset,
>     } else /* env->mmu_model =3D=3D POWERPC_MMU_2_07 */ {
>         pa_features =3D pa_features_207;
>         pa_size =3D sizeof(pa_features_207);
> +
> +        /* Don't enable TM in PR KVM mode */
> +        if (kvm_enabled() &&
> +            kvm_vm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_PVINFO)=
)

Does this compile on non-kvm systems?

Alex

> {
> +            pa_features[24] &=3D ~0x80;
> +        }
>     }
>     if (env->ci_large_pages) {
>         pa_features[3] |=3D 0x20;
