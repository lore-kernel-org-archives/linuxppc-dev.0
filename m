Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC912B7D72
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 05:23:43 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc, kdump: Fix race in kdump shutdown
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100514054011.5E585D34AB@localhost.localdomain>
Date: Mon, 24 May 2010 14:23:27 -0500
Message-Id: <E722EF44-A08B-41E1-8ECA-D5BE46009128@kernel.crashing.org>
References: <20100514054011.5E585D34AB@localhost.localdomain>
To: Michael Neuling <mikey@neuling.org>
Cc: jlarrew@linux.vnet.ibm.com, kexec@lists.infradead.org,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 14, 2010, at 12:40 AM, Michael Neuling wrote:

> When we are crashing, the crashing/primary CPU IPIs the secondaries to
> turn off IRQs, go into real mode and wait in kexec_wait.  While this
> is happening, the primary tears down all the MMU maps.  Unfortunately
> the primary doesn't check to make sure the secondaries have entered
> real mode before doing this.
>=20
> On PHYP machines, the secondaries can take a long time shutting down
> the IRQ controller as RTAS calls are need.  These RTAS calls need to
> be serialised which resilts in the secondaries contending in
> lock_rtas() and hence taking a long time to shut down.
>=20
> We've hit this on large POWER7 machines, where some secondaries are
> still waiting in lock_rtas(), when the primary tears down the HPTEs.
>=20
> This patch makes sure all secondaries are in real mode before the
> primary tears down the MMU.  It uses the new kexec_state entry in the
> paca.  It times out if the secondaries don't reach real mode after
> 10sec.
>=20
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>=20
> arch/powerpc/kernel/crash.c |   27 +++++++++++++++++++++++++++
> 1 file changed, 27 insertions(+)
>=20
> Index: linux-2.6-ozlabs/arch/powerpc/kernel/crash.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/crash.c
> +++ linux-2.6-ozlabs/arch/powerpc/kernel/crash.c
> @@ -162,6 +162,32 @@ static void crash_kexec_prepare_cpus(int
> 	/* Leave the IPI callback set */
> }
>=20
> +/* wait for all the CPUs to hit real mode but timeout if they don't =
come in */
> +static void crash_kexec_wait_realmode(int cpu)
> +{
> +	unsigned int msecs;
> +	int i;
> +
> +	msecs =3D 10000;
> +	for (i=3D0; i < NR_CPUS && msecs > 0; i++) {
> +		if (i =3D=3D cpu)
> +			continue;
> +
> +		while (paca[i].kexec_state < KEXEC_STATE_REAL_MODE) {
> +			barrier();
> +			if (!cpu_possible(i)) {
> +				break;
> +			}
> +			if (!cpu_online(i)) {
> +				break;
> +			}
> +			msecs--;
> +			mdelay(1);
> +		}
> +	}
> +	mb();
> +}
> +
> /*
>  * This function will be called by secondary cpus or by kexec cpu
>  * if soft-reset is activated to stop some CPUs.
> @@ -412,6 +438,7 @@ void default_machine_crash_shutdown(stru
> 	crash_kexec_prepare_cpus(crashing_cpu);
> 	cpu_set(crashing_cpu, cpus_in_crash);
> 	crash_kexec_stop_spus();

should this be

#ifdef CONFIG_PPC_STD_MMU

> +	crash_kexec_wait_realmode(crashing_cpu);

#endif

- k
