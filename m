Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20110223021221.17638.42707.stgit@localhost6.localdomain6>
References: <20110223021221.17638.42707.stgit@localhost6.localdomain6>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 25 Feb 2011 12:22:37 -0700
Message-ID: <AANLkTinx2YxOs3Y-XDHaWe44Bw8HqiMyanouV5Bo3KuX@mail.gmail.com>
Subject: Re: [PATCH] tty/serial: Relax the device_type restriction from
	of_serial
To: devicetree-discuss@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd and Ben,

I forgot to cc you guys on this patch.  Greg has it in his tree, but I
wanted to make sure you noticed it.  If you have any objections, let
me know and I'll ask Greg to drop it.

Thanks,
g.


On Tue, Feb 22, 2011 at 7:12 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> There is no need to test for a device_type property in ns8250
> compatible serial ports. =A0device_type is an OpenFirmware property that
> is not required when using the flattened tree representation.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> =A0drivers/tty/serial/of_serial.c | =A0 18 +++++++++---------
> =A01 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_seria=
l.c
> index 5c7abe4..6a18ca6 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -160,17 +160,17 @@ static int of_platform_serial_remove(struct platfor=
m_device *ofdev)
> =A0* A few common types, add more as needed.
> =A0*/
> =A0static struct of_device_id __devinitdata of_platform_serial_table[] =
=3D {
> - =A0 =A0 =A0 { .type =3D "serial", .compatible =3D "ns8250", =A0 .data =
=3D (void *)PORT_8250, },
> - =A0 =A0 =A0 { .type =3D "serial", .compatible =3D "ns16450", =A0.data =
=3D (void *)PORT_16450, },
> - =A0 =A0 =A0 { .type =3D "serial", .compatible =3D "ns16550a", .data =3D=
 (void *)PORT_16550A, },
> - =A0 =A0 =A0 { .type =3D "serial", .compatible =3D "ns16550", =A0.data =
=3D (void *)PORT_16550, },
> - =A0 =A0 =A0 { .type =3D "serial", .compatible =3D "ns16750", =A0.data =
=3D (void *)PORT_16750, },
> - =A0 =A0 =A0 { .type =3D "serial", .compatible =3D "ns16850", =A0.data =
=3D (void *)PORT_16850, },
> + =A0 =A0 =A0 { .compatible =3D "ns8250", =A0 .data =3D (void *)PORT_8250=
, },
> + =A0 =A0 =A0 { .compatible =3D "ns16450", =A0.data =3D (void *)PORT_1645=
0, },
> + =A0 =A0 =A0 { .compatible =3D "ns16550a", .data =3D (void *)PORT_16550A=
, },
> + =A0 =A0 =A0 { .compatible =3D "ns16550", =A0.data =3D (void *)PORT_1655=
0, },
> + =A0 =A0 =A0 { .compatible =3D "ns16750", =A0.data =3D (void *)PORT_1675=
0, },
> + =A0 =A0 =A0 { .compatible =3D "ns16850", =A0.data =3D (void *)PORT_1685=
0, },
> =A0#ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL
> - =A0 =A0 =A0 { .type =3D "serial", .compatible =3D "ibm,qpace-nwp-serial=
",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 .data =3D (void *)PORT_NWPSERIAL, },
> + =A0 =A0 =A0 { .compatible =3D "ibm,qpace-nwp-serial",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .data =3D (void *)PORT_NWPSERIAL, },
> =A0#endif
> - =A0 =A0 =A0 { .type =3D "serial", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 .data =3D (void *)PORT_UNKNOWN, },
> + =A0 =A0 =A0 { .type =3D "serial", =A0 =A0 =A0 =A0 .data =3D (void *)POR=
T_UNKNOWN, },
> =A0 =A0 =A0 =A0{ /* end of list */ },
> =A0};
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
