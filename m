Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] kdump shutdown hook support
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20071212054512.A02B062C153@localhost.localdomain>
References: <20071212054512.A02B062C153@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Kza0KCx0MG8nsjfq7kOz"
Date: Thu, 13 Dec 2007 10:07:19 +1100
Message-Id: <1197500839.7695.19.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, THEMANN@de.ibm.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Kza0KCx0MG8nsjfq7kOz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-12-12 at 16:45 +1100, Michael Neuling wrote:
> This adds hooks into the default_machine_crash_shutdown so drivers can
> register a function to be run in the first kernel before we hand off
> to the second kernel.  This should only be used in exceptional
> circumstances, like where the device can't be reset in the second
> kernel alone (as is the case with eHEA).  To emphasize this, the
> number of handles allowed to be registered is currently #def to 1.
>=20
> This uses the setjmp/longjmp code to call out to the registered hooks,
> so any bogus exceptions we encounter will hopefully be recoverable. =20
>=20
> I've tested with bogus data and instruction exceptions.
>=20
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>=20
>  arch/powerpc/kernel/crash.c |   90 +++++++++++++++++++++++++++++++++++++=
++++---
>  include/asm-powerpc/kexec.h |    3 +
>  2 files changed, 88 insertions(+), 5 deletions(-)
>=20
> Index: linux-2.6-ozlabs/arch/powerpc/kernel/crash.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/crash.c
> +++ linux-2.6-ozlabs/arch/powerpc/kernel/crash.c
> @@ -32,6 +32,8 @@
>  #include <asm/lmb.h>
>  #include <asm/firmware.h>
>  #include <asm/smp.h>
> +#include <asm/system.h>
> +#include <asm/setjmp.h>
> =20
>  #ifdef DEBUG
>  #include <asm/udbg.h>
> @@ -45,6 +47,11 @@ int crashing_cpu =3D -1;
>  static cpumask_t cpus_in_crash =3D CPU_MASK_NONE;
>  cpumask_t cpus_in_sr =3D CPU_MASK_NONE;
> =20
> +#define CRASH_SHUTDOWN_HANDLES_NUM 1

CRASH_HANDLER_MAX ?

> +/* NULL terminated list of shutdown handles */
> +static crash_shutdown_t crash_shutdown_handles[CRASH_SHUTDOWN_HANDLES_NU=
M+1];
> +static DEFINE_SPINLOCK(crash_handles_lock);
> +
>  #ifdef CONFIG_SMP
>  static atomic_t enter_on_soft_reset =3D ATOMIC_INIT(0);
> =20
> @@ -285,9 +292,69 @@ static inline void crash_kexec_stop_spus
>  }
>  #endif /* CONFIG_SPU_BASE */
> =20
> +/*=20
> + * Register a function to be called on shutdown.  Only use this if you
> + * can't reset your device in the second kernel.
> + */
> +int crash_shutdown_register(crash_shutdown_t handler)
> +{
> +	unsigned int i, rc;
> +
> +	spin_lock(&crash_handles_lock);

> +	for(i =3D 0 ; i <=3D CRASH_SHUTDOWN_HANDLES_NUM; i++) {
> +		if (!crash_shutdown_handles[i]) {
> +			/* Insert handle at end */
> +			crash_shutdown_handles[i] =3D handler;
> +			rc =3D 0;
> +			break;
> +		}
> +	}
>=20
> +	if (i =3D=3D CRASH_SHUTDOWN_HANDLES_NUM){
> +		printk(KERN_ERR "Crash shutdown handles full, "
> +		       "not registered.\n");
> +		rc =3D 1;
> +	}
> +
> +	spin_unlock(&crash_handles_lock);

Perhaps?

> +	return rc;
> +}
> +EXPORT_SYMBOL(crash_shutdown_register);
> +
> +int crash_shutdown_unregister(crash_shutdown_t handler)
> +{
> +	unsigned int i;
> +
> +	spin_lock(&crash_handles_lock);
> +	for(i =3D 0 ; i <=3D CRASH_SHUTDOWN_HANDLES_NUM; i++)
> +		if (crash_shutdown_handles[i] =3D=3D handler)
> +			break;
> +
> +	if (i =3D=3D CRASH_SHUTDOWN_HANDLES_NUM){
> +		printk(KERN_ERR "Crash shutdown handle not found\n");
> +		spin_unlock(&crash_handles_lock);
> +		return 1;
> +	}
> +
> +	/* Shift handles down */
> +	while(crash_shutdown_handles[i]) {
> +		crash_shutdown_handles[i] =3D crash_shutdown_handles[i+1];
> +		i++;
> +	}
> +	spin_unlock(&crash_handles_lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL(crash_shutdown_unregister);
> +
> +static long crash_shutdown_buf[SETJMP_BUF_LEN];

unsigned long?

> +
> +static int handle_fault(struct pt_regs *regs)
> +{
> +	longjmp(crash_shutdown_buf, 1);
> +	return 0;
> +}
> +
>  void default_machine_crash_shutdown(struct pt_regs *regs)
>  {
> -	unsigned int irq;
> +	unsigned int i;
> =20
>  	/*
>  	 * This function is only called after the system
> @@ -301,14 +368,27 @@ void default_machine_crash_shutdown(stru
>  	 */
>  	hard_irq_disable();
> =20
> -	for_each_irq(irq) {
> -		struct irq_desc *desc =3D irq_desc + irq;
> +	for_each_irq(i) {
> +		struct irq_desc *desc =3D irq_desc + i;
> =20
>  		if (desc->status & IRQ_INPROGRESS)
> -			desc->chip->eoi(irq);
> +			desc->chip->eoi(i);
> =20
>  		if (!(desc->status & IRQ_DISABLED))
> -			desc->chip->disable(irq);
> +			desc->chip->disable(i);
> +	}
> +
> +	/* Call registered shutdown routines */
> +	__debugger_fault_handler =3D handle_fault;
> +	i =3D 0;
> +	while(crash_shutdown_handles[i]){
> +		if (setjmp(crash_shutdown_buf) =3D=3D 0) {
> +			asm volatile("sync; isync");
> +			crash_shutdown_handles[i]();
> +			asm volatile("sync; isync");
> +			__delay(200);
> +		}
> +		i++;
>  	}

You should probably reset __debugger_fault_handler, just to be safe.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Kza0KCx0MG8nsjfq7kOz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHYGmndSjSd0sB4dIRAvQDAKC57G4dlfRdXiRwm8mlRIzARSBTBgCdHaF0
eBF51B6qd/fPTzYrTmvPkJk=
=yLKR
-----END PGP SIGNATURE-----

--=-Kza0KCx0MG8nsjfq7kOz--
