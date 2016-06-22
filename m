Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZCPD2rD9zDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 15:11:28 +1000 (AEST)
Message-ID: <1466572287.8686.1.camel@neuling.org>
Subject: Re: [PATCH v6 07/11] powerpc/powernv: set power_save func after the
 idle states are initialized
From: Michael Neuling <mikey@neuling.org>
To: benh@au1.ibm.com, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 mpe@ellerman.id.au
Cc: ego@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Wed, 22 Jun 2016 15:11:27 +1000
In-Reply-To: <1466560468.4089.7.camel@au1.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1465404871-5406-8-git-send-email-shreyas@linux.vnet.ibm.com>
 <1466560468.4089.7.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-22 at 11:54 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2016-06-08 at 11:54 -0500, Shreyas B. Prabhu wrote:
> >=20
> > pnv_init_idle_states discovers supported idle states from the
> > device tree and does the required initialization. Set power_save
> > function pointer only after this initialization is done
> >=20
> > Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Please merge that one as-is now, no need to wait for the rest, as
> otherwise pwoer9 crashes at boot. It doesn't need to wait for the
> rest of the series.

Acked-by: Michael Neuling <mikey@neuling.org>

For the same reason. Without this we need powersave=3Doff on the cmdline on
POWER9.

Mikey

>=20
> Cheers,
> Ben.
>=20
> >=20
> > ---
> > - No changes since v1
> >=20
> > =C2=A0arch/powerpc/platforms/powernv/idle.c=C2=A0=C2=A0| 3 +++
> > =C2=A0arch/powerpc/platforms/powernv/setup.c | 2 +-
> > =C2=A02 files changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/platforms/powernv/idle.c
> > b/arch/powerpc/platforms/powernv/idle.c
> > index fcc8b68..fbb09fb 100644
> > --- a/arch/powerpc/platforms/powernv/idle.c
> > +++ b/arch/powerpc/platforms/powernv/idle.c
> > @@ -285,6 +285,9 @@ static int __init pnv_init_idle_states(void)
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	pnv_alloc_idle_core_states();
> > +
> > +	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
> > +		ppc_md.power_save =3D power7_idle;
> > =C2=A0out_free:
> > =C2=A0	kfree(flags);
> > =C2=A0out:
> > diff --git a/arch/powerpc/platforms/powernv/setup.c
> > b/arch/powerpc/platforms/powernv/setup.c
> > index ee6430b..8492bbb 100644
> > --- a/arch/powerpc/platforms/powernv/setup.c
> > +++ b/arch/powerpc/platforms/powernv/setup.c
> > @@ -315,7 +315,7 @@ define_machine(powernv) {
> > =C2=A0	.get_proc_freq=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=3D pnv_get_proc_freq,
> > =C2=A0	.progress		=3D pnv_progress,
> > =C2=A0	.machine_shutdown	=3D pnv_shutdown,
> > -	.power_save=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=3D power7_idle,
> > +	.power_save=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=3D NULL,
> > =C2=A0	.calibrate_decr		=3D generic_calibrate_decr,
> > =C2=A0#ifdef CONFIG_KEXEC
> > =C2=A0	.kexec_cpu_down		=3D pnv_kexec_cpu_down,
