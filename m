Return-Path: <John.Linn@xilinx.com>
Received: from outbound3-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C837EDE19F
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 05:20:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 2/3][POWERPC][V2] Xilinx: of_serial support for Xilinx
	uart 16550.
Date: Wed, 2 Apr 2008 12:20:20 -0600
In-Reply-To: <fa686aa40804021100j13a7e223jde9d222df379b1f8@mail.gmail.com>
References: <12071551351007-git-send-email-john.linn@xilinx.com>
	<12071551354058-git-send-email-john.linn@xilinx.com>
	<20080402165222.2468414080A9@mail104-dub.bigfish.com>
	<fa686aa40804021100j13a7e223jde9d222df379b1f8@mail.gmail.com>
From: "John Linn" <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080402182023.8FA7318B808D@mail52-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sounds good, those are easy changes and make sense.

Since I'm a newbie, I don't know any better sometimes when I copy other
code that may not be as safe. =20

The same thing, of_get_property(np, "current-speed", NULL);, is done
right above my code I added. =20

Should the other code in the driver using the same method be fixed, or
just my patch?

Thanks for your patience,
John

-----Original Message-----
From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
Grant Likely
Sent: Wednesday, April 02, 2008 12:00 PM
To: John Linn
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3][POWERPC][V2] Xilinx: of_serial support for
Xilinx uart 16550.

On Wed, Apr 2, 2008 at 10:52 AM, John Linn <john.linn@xilinx.com> wrote:
> The Xilinx 16550 uart core is not a standard 16550 because it uses
>  word-based addressing rather than byte-based addressing. With
>  additional properties it is compatible with the open firmware
>  'ns16550' compatible binding.
>
>  This code updates the of_serial driver to handle the reg-offset
>  and reg-shift properties to enable this core to be used.
>
>  Signed-off-by: John Linn <john.linn@xilinx.com>

Comments below...

>  ---
>   Documentation/powerpc/booting-without-of.txt |   11 +++++++++++
>   drivers/serial/of_serial.c                   |   15 +++++++++++++--
>   2 files changed, 24 insertions(+), 2 deletions(-)
>
>  diff --git a/Documentation/powerpc/booting-without-of.txt
b/Documentation/powerpc/booting-without-of.txt
>  index 87f4d84..af112d9 100644
>  --- a/Documentation/powerpc/booting-without-of.txt
>  +++ b/Documentation/powerpc/booting-without-of.txt
>  @@ -2539,6 +2539,17 @@ platforms are moved over to use the
flattened-device-tree model.
>                        differ between different families.  May be
>                        'virtex2p', 'virtex4', or 'virtex5'.
>
>  +      iv) Xilinx Uart 16550
>  +
>  +      Xilinx UART 16550 devices are very similar to the NS16550 such
that they
>  +      use the ns16550 binding with properties to specify register
spacing and
>  +      an offset from the base address.
>  +
>  +      Requred properties:
>  +       - clock-frequency : Frequency of the clock input
>  +       - reg-offset : A value of 3 is required
>  +       - reg-shift : A value of 2 is required
>  +
>     More devices will be defined as this spec matures.
>
>   VII - Specifying interrupt information for devices
>  diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
>  index 2efb892..af9ed48 100644
>  --- a/drivers/serial/of_serial.c
>  +++ b/drivers/serial/of_serial.c
>  @@ -30,7 +30,7 @@ static int __devinit
of_platform_serial_setup(struct of_device *ofdev,
>   {
>         struct resource resource;
>         struct device_node *np =3D ofdev->node;
>  -       const unsigned int *clk, *spd;
>  +       const unsigned int *clk, *spd, *reg_offset, *reg_shift;

These should really be u32's I believe; on 64 bit architectures this
will misbehave (not an immediate practical problem, but it's best to
be explicit about these things).

>         int ret;
>
>         memset(port, 0, sizeof *port);
>  @@ -48,7 +48,18 @@ static int __devinit
of_platform_serial_setup(struct of_device *ofdev,
>         }
>
>         spin_lock_init(&port->lock);
>  -       port->mapbase =3D resource.start;
>  +
>  +       reg_offset =3D of_get_property(np, "reg-offset", NULL);
>  +       reg_shift =3D of_get_property(np, "reg-shift", NULL);
>  +
>  +       if (!reg_offset)
>  +               port->mapbase =3D resource.start;
>  +       else
>  +               port->mapbase =3D resource.start + *reg_offset;
>  +
>  +       if (reg_shift)
>  +               port->regshift =3D *reg_shift;
>  +

This is a little unsafe since it doesn't check the property size, I'd
do the following instead:

port->mapbase =3D resource.start

/* Check for shifted address mapping */
prop =3D of_get_property(np, "reg-offset", &prop_size);
if (prop && (prop_size =3D=3D sizeof(u32))
        port->mapbase +=3D *prop;

/* Check for registers offset within the devices address range */
prop =3D of_get_property(np, "reg-shift", &prop_size);
if (prop && (prop_size =3D=3D sizeof(u32)))
        port->regshift =3D *prop;

Cheers,
g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
