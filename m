Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4D05FDDF3F
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 17:43:11 +1100 (EST)
Date: Fri, 11 Jan 2008 17:42:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 1/5] Warp Base Platform
Message-Id: <20080111174259.b749f1f0.sfr@canb.auug.org.au>
In-Reply-To: <47852C41.8000506@pikatech.com>
References: <47852C41.8000506@pikatech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__11_Jan_2008_17_42_59_+1100_j1XulB0mhUQ9uuCz"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__11_Jan_2008_17_42_59_+1100_j1XulB0mhUQ9uuCz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 09 Jan 2008 15:19:13 -0500 Sean MacLennan <smaclennan@pikatech.com>=
 wrote:
>
> I have split up the patches slightly differently based on Josh's comments.
>=20
> The first patch is basically the platform/44x files.
>=20
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

> No comments? I really thought I would get raked over the coals for this o=
ne.

Ah ha! A challenge!  :-)

> +++ arch/powerpc/platforms/44x/warp.c	2008-01-08 17:59:48.000000000 -0500

> +void warp_set_power_leds(int green, int red)
> +{
> +	static void *gpio_base =3D NULL;
> +	unsigned leds;
> +
> +	if(gpio_base =3D=3D NULL) {
          ^
space, please

> +		if((gpio_base =3D ioremap(WARP_GPIO_BASE, 0x148)) =3D=3D NULL) {

and again. Also split the assignment from the test.

> +			printk("ERROR: Unable to remap GPIO base.\n");
> +			return;
> +		}
> +	}
> +
> +	leds =3D readl(gpio_base + 0x100);
> +
> +	switch(green) {

space

> +	case 0: leds &=3D ~0x80; break;
> +	case 1: leds |=3D  0x80; break;
> +	}
> +	switch(red) {

again

> +	case 0: leds &=3D ~0x40; break;
> +	case 1: leds |=3D  0x40; break;
> +	}
> +
> +	writel(leds, gpio_base + 0x100);
> +}
> +EXPORT_SYMBOL(warp_set_power_leds);
> +
> +
> +static int pika_dtm_thread(void *fpga)
> +{
> +	extern int ad7414_get_temp(int index);

no externs in C code - put it in a header file.

> +
> +	while(!kthread_should_stop()) {

space

> +static int __devinit warp_fpga_init(void)
> +{
> +	struct device_node *np;
> +	void *fpga;
> +	int irq;
> +	struct resource res;
> +	struct task_struct *dtm_thread;
> +
> +	if((np =3D of_find_compatible_node(NULL, NULL, "pika,fpga")) =3D=3D NUL=
L) {

space and split the assignment from the test.

> +		printk(KERN_ERR __FILE__ ": Unable to find fpga\n");
> +		return -ENOENT;
> +	}
> +
> +	if((irq =3D irq_of_parse_and_map(np, 0)) =3D=3D NO_IRQ) {

again

> +		printk(KERN_ERR __FILE__ ": irq_of_parse_and_map failed\n");
> +		return -EBUSY;
> +	}
> +
> +	/* We do not call of_iomap here since it would map in the entire
> +	 * fpga space, which is over 8k.
> +	 */
> +	if(of_address_to_resource(np, 0, &res) ||
> +	   (fpga =3D ioremap(res.start, 0x24)) =3D=3D NULL) {

and again

> +		printk(KERN_ERR __FILE__ ": Unable to map FPGA\n");
> +		return -ENOENT;
> +	}
> +
> +	/* Turn off the line LEDs */
> +	out_be32(fpga + 8, 0);
> +
> +	dtm_thread =3D kthread_run(pika_dtm_thread, fpga + 0x20, "pika-dtm");
> +
> +	if(IS_ERR(dtm_thread)) {

space

enough?  :-)
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__11_Jan_2008_17_42_59_+1100_j1XulB0mhUQ9uuCz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhw/3TgG2atn1QN8RAvIwAJ0ejzJssvfYs9jmgwPAgvZxnMwwYwCfT04V
TnAkOhcZYk15yE6+R/jXFDE=
=bM9K
-----END PGP SIGNATURE-----

--Signature=_Fri__11_Jan_2008_17_42_59_+1100_j1XulB0mhUQ9uuCz--
