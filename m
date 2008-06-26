Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id F0C44DDEFE
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 21:18:56 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Modem control lines support for the cpm_uart
	driver
Date: Thu, 26 Jun 2008 13:18:53 +0200
References: <200804161110.21778.laurentp@cse-semaphore.com>
	<200805261158.57704.laurentp@cse-semaphore.com>
In-Reply-To: <200805261158.57704.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7742450.up0FB8pXns";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200806261318.54009.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>, panto@intracom.gr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart7742450.up0FB8pXns
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 26 May 2008 11:58, Laurent Pinchart wrote:
> On Wednesday 16 April 2008 11:10, Laurent Pinchart wrote:
> > This patch replaces the get_mctrl/set_mctrl stubs with modem control li=
ne
> > read/write access through the GPIO lib.
> >=20
> > Available modem control lines are described in the device tree using GP=
IO
> > bindings.
>=20
> Any show stopper on this patch ? Could it get into powerpc-next ?

Sorry to bother everybody again, but I'd like this patch to go in 2.6.27. I=
s=20
there any pending issue ? Platforms without GPIO support shouldn't be=20
affected and get_mctrl()/set_mctrl() behaviour is backward compatible for=20
existing platforms.

> > Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> > ---
> >  Documentation/powerpc/booting-without-of.txt |   10 ++++++
> >  drivers/serial/cpm_uart/cpm_uart.h           |   10 ++++++
> >  drivers/serial/cpm_uart/cpm_uart_core.c      |   40=20
++++++++++++++++++++++++--
> >  3 files changed, 57 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/powerpc/booting-without-of.txt=20
b/Documentation/powerpc/booting-without-of.txt
> > index 1e5572a..012f231 100644
> > --- a/Documentation/powerpc/booting-without-of.txt
> > +++ b/Documentation/powerpc/booting-without-of.txt
> > @@ -1976,6 +1976,14 @@ platforms are moved over to use the=20
flattened-device-tree model.
> >     - fsl,cpm2-scc-uart
> >     - fsl,qe-uart
> > =20
> > +   Modem control lines connected to GPIO controllers are listed in the
> > +   gpios property as described in section VIII.1 in the following orde=
r:
> > +
> > +   CTS, RTS, DCD, DSR, DTR, and RI.
> > +
> > +   The gpios property is optional and can be left out when control lin=
es=20
are
> > +   not used.
> > +
> >     Example:
> > =20
> >  	serial@11a00 {
> > @@ -1987,6 +1995,8 @@ platforms are moved over to use the=20
flattened-device-tree model.
> >  		interrupt-parent =3D <&PIC>;
> >  		fsl,cpm-brg =3D <1>;
> >  		fsl,cpm-command =3D <00800000>;
> > +		gpios =3D <&gpio_c 15 0
> > +			 &gpio_d 29 0>;
> >  	};
> > =20
> >     iii) Network
> > diff --git a/drivers/serial/cpm_uart/cpm_uart.h=20
b/drivers/serial/cpm_uart/cpm_uart.h
> > index 0cc39f8..d0c55e2 100644
> > --- a/drivers/serial/cpm_uart/cpm_uart.h
> > +++ b/drivers/serial/cpm_uart/cpm_uart.h
> > @@ -50,6 +50,15 @@
> > =20
> >  #define SCC_WAIT_CLOSING 100
> > =20
> > +#define GPIO_CTS	0
> > +#define GPIO_RTS	1
> > +#define GPIO_DCD	2
> > +#define GPIO_DSR	3
> > +#define GPIO_DTR	4
> > +#define GPIO_RI		5
> > +
> > +#define NUM_GPIOS	(GPIO_RI+1)
> > +
> >  struct uart_cpm_port {
> >  	struct uart_port	port;
> >  	u16			rx_nrfifos;
> > @@ -82,6 +91,7 @@ struct uart_cpm_port {
> >  	int 			wait_closing;
> >  	/* value to combine with opcode to form cpm command */
> >  	u32			command;
> > +	int			gpios[NUM_GPIOS];
> >  };
> > =20
> >  #ifndef CONFIG_PPC_CPM_NEW_BINDING
> > diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c=20
b/drivers/serial/cpm_uart/cpm_uart_core.c
> > index 7a704ff..0f08071 100644
> > --- a/drivers/serial/cpm_uart/cpm_uart_core.c
> > +++ b/drivers/serial/cpm_uart/cpm_uart_core.c
> > @@ -42,6 +42,8 @@
> >  #include <linux/bootmem.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/fs_uart_pd.h>
> > +#include <linux/gpio.h>
> > +#include <linux/of_gpio.h>
> > =20
> >  #include <asm/io.h>
> >  #include <asm/irq.h>
> > @@ -152,13 +154,41 @@ static unsigned int cpm_uart_tx_empty(struct=20
uart_port *port)
> > =20
> >  static void cpm_uart_set_mctrl(struct uart_port *port, unsigned int=20
mctrl)
> >  {
> > -	/* Whee. Do nothing. */
> > +	struct uart_cpm_port *pinfo =3D (struct uart_cpm_port *)port;
> > +
> > +	if (pinfo->gpios[GPIO_RTS] >=3D 0)
> > +		gpio_set_value(pinfo->gpios[GPIO_RTS], !(mctrl & TIOCM_RTS));
> > +
> > +	if (pinfo->gpios[GPIO_DTR] >=3D 0)
> > +		gpio_set_value(pinfo->gpios[GPIO_DTR], !(mctrl & TIOCM_DTR));
> >  }
> > =20
> >  static unsigned int cpm_uart_get_mctrl(struct uart_port *port)
> >  {
> > -	/* Whee. Do nothing. */
> > -	return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
> > +	struct uart_cpm_port *pinfo =3D (struct uart_cpm_port *)port;
> > +	unsigned int mctrl =3D TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> > +
> > +	if (pinfo->gpios[GPIO_CTS] >=3D 0) {
> > +		if (gpio_get_value(pinfo->gpios[GPIO_CTS]))
> > +			mctrl &=3D ~TIOCM_CTS;
> > +	}
> > +
> > +	if (pinfo->gpios[GPIO_DSR] >=3D 0) {
> > +		if (gpio_get_value(pinfo->gpios[GPIO_DSR]))
> > +			mctrl &=3D ~TIOCM_DSR;
> > +	}
> > +
> > +	if (pinfo->gpios[GPIO_DCD] >=3D 0) {
> > +		if (gpio_get_value(pinfo->gpios[GPIO_DCD]))
> > +			mctrl &=3D ~TIOCM_CAR;
> > +	}
> > +
> > +	if (pinfo->gpios[GPIO_RI] >=3D 0) {
> > +		if (!gpio_get_value(pinfo->gpios[GPIO_RI]))
> > +			mctrl |=3D TIOCM_RNG;
> > +	}
> > +
> > +	return mctrl;
> >  }
> > =20
> >  /*
> > @@ -959,6 +989,7 @@ static int cpm_uart_init_port(struct device_node *n=
p,
> >  	void __iomem *mem, *pram;
> >  	int len;
> >  	int ret;
> > +	int i;
> > =20
> >  	data =3D of_get_property(np, "fsl,cpm-brg", &len);
> >  	if (!data || len !=3D 4) {
> > @@ -1017,6 +1048,9 @@ static int cpm_uart_init_port(struct device_node=
=20
*np,
> >  		goto out_pram;
> >  	}
> > =20
> > +	for (i =3D 0; i < NUM_GPIOS; i++)
> > +		pinfo->gpios[i] =3D of_get_gpio(np, i);
> > +
> >  	return cpm_uart_request_port(&pinfo->port);
> > =20
> >  out_pram:
> > --=20
> > 1.5.0
> >=20
> >=20
>=20

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart7742450.up0FB8pXns
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIY3sd8y9gWxC9vpcRAsVVAJ4z6uQGYSark563+sIqsPo0Rg+ikwCfabrm
badr7OFztzZFOIjvm1Mi8OM=
=wlbo
-----END PGP SIGNATURE-----

--nextPart7742450.up0FB8pXns--
