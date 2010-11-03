Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc: Disable VPHN polling during a suspend
	operation
From: Michael Ellerman <michael@ellerman.id.au>
To: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
In-Reply-To: <20101029002921.17835.88560.sendpatchset@manic8ball.ltc.austin.ibm.com>
References: <20101029002628.17835.37125.sendpatchset@manic8ball.ltc.austin.ibm.com>
	<20101029002921.17835.88560.sendpatchset@manic8ball.ltc.austin.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-Y5XTSbYRoJm82Ro5JtC4"
Date: Wed, 03 Nov 2010 23:12:42 +1100
Message-ID: <1288786362.989.66.camel@concordia>
Mime-Version: 1.0
Cc: markn@au1.ibm.com, pmac@au1.ibm.com, tbreeds@au1.ibm.com,
	lkessler@us.ibm.com, mjwolf@us.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-Y5XTSbYRoJm82Ro5JtC4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-10-28 at 20:30 -0400, Jesse Larrew wrote:=20
> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

Hi Jesse, a few comments ...

> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/a=
sm/topology.h
> index afe4aaa..1747d27 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -49,7 +49,7 @@ static inline int pcibus_to_node(struct pci_bus *bus)
>  {
>  	return -1;
>  }
> -#endif
> +#endif /* CONFIG_PCI */

Random change, though not a biggy I suppose.

> #define cpumask_of_pcibus(bus)	(pcibus_to_node(bus) =3D=3D -1 ?		\
>  				 cpu_all_mask :				\
> @@ -93,6 +93,8 @@ extern void __init dump_numa_cpu_topology(void);
>  extern int sysfs_add_device_to_node(struct sys_device *dev, int nid);
>  extern void sysfs_remove_device_from_node(struct sys_device *dev, int ni=
d);
> =20
> +extern int __init init_topology_update(void);
> +extern int stop_topology_update(void);

init_topology_update() is called repeatedly from post_suspend_work() so
it seems like it should be called start_topology_update(). And it can't
be __init because the suspend code is called after boot. You should get
a section mismatch warning if they are enabled.

> #else
> =20
>  static inline void dump_numa_cpu_topology(void) {}
> @@ -107,6 +109,8 @@ static inline void sysfs_remove_device_from_node(stru=
ct sys_device *dev,
>  {
>  }
> =20
> +static int __init init_topology_update(void) {}
> +static int stop_topology_update(void) {}

That doesn't look like it compiles to me, you want static inline, and
they both return int.

> #endif /* CONFIG_NUMA */
> =20
>  #include <asm-generic/topology.h>
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 8fe8bc6..317ff2f 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -41,6 +41,7 @@
>  #include <asm/atomic.h>
>  #include <asm/time.h>
>  #include <asm/mmu.h>
> +#include <asm/topology.h>
> =20
>  struct rtas_t rtas =3D {
>  	.lock =3D __ARCH_SPIN_LOCK_UNLOCKED
> @@ -706,6 +707,18 @@ void rtas_os_term(char *str)
> =20
>  static int ibm_suspend_me_token =3D RTAS_UNKNOWN_SERVICE;
>  #ifdef CONFIG_PPC_PSERIES
> +static void pre_suspend_work(void)
> +{
> +	stop_topology_update();
> +	return;
> +}
> +
> +static void post_suspend_work(void)
> +{
> +	init_topology_update();
> +	return;
> +}

I'm not sure if it's worth splitting these out into "generic"
callbacks ..

> static int __rtas_suspend_last_cpu(struct rtas_suspend_me_data *data, int=
 wake_when_done)
>  {
>  	u16 slb_size =3D mmu_slb_size;
> @@ -713,6 +726,7 @@ static int __rtas_suspend_last_cpu(struct rtas_suspen=
d_me_data *data, int wake_w
>  	int cpu;
> =20
>  	slb_set_size(SLB_MIN_SIZE);
> +	pre_suspend_work();
>  	printk(KERN_DEBUG "calling ibm,suspend-me on cpu %i\n", smp_processor_i=
d());
> =20
>  	while (rc =3D=3D H_MULTI_THREADS_ACTIVE && !atomic_read(&data->done) &&

And isn't there an error case here where you're not re-enabling the
polling? See eg. the slb_set_size() call.

> @@ -728,6 +742,7 @@ static int __rtas_suspend_last_cpu(struct rtas_suspen=
d_me_data *data, int wake_w
>  		rc =3D atomic_read(&data->error);
> =20
>  	atomic_set(&data->error, rc);
> +	post_suspend_work();
> =20
>  	if (wake_when_done) {
>  		atomic_set(&data->done, 1);

cheers



--=-Y5XTSbYRoJm82Ro5JtC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzRUboACgkQdSjSd0sB4dJ4iwCePvVhanU7UXfQc2Ivfy9Bf1qZ
BKEAoKGIM61zX8wH+7qESFtnkDZxbcI/
=GAi7
-----END PGP SIGNATURE-----

--=-Y5XTSbYRoJm82Ro5JtC4--
