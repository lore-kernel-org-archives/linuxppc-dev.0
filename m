Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 6A530DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 16:31:26 +1100 (EST)
Received: by gxk1 with SMTP id 1so3356841gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 21:31:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1235575933-29691-1-git-send-email-w.sang@pengutronix.de>
References: <1235575933-29691-1-git-send-email-w.sang@pengutronix.de>
Date: Thu, 26 Feb 2009 22:31:24 -0700
Message-ID: <fa686aa40902262131i6c75687foaf42daeb4fc7a3b7@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc52xx: add Phytec phyCORE-MPC5200B-IO board
	(pcm032)
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for the patch Wolfram.  Comments below.

On Wed, Feb 25, 2009 at 8:32 AM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
> =A0arch/powerpc/boot/dts/pcm032.dts =A0 =A0 =A0 =A0 =A0 =A0 | =A0391 ++++=
+++
> =A0arch/powerpc/configs/52xx/pcm032_defconfig =A0 | 1394 ++++++++++++++++=
++++++++++

Do you really need a separate defconfig for this board?  Can it be
merged with an existing defconfig?

> =A0arch/powerpc/platforms/52xx/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/powerpc/platforms/52xx/mpc5200_simple.c | =A0 =A03 +-
> =A04 files changed, 1788 insertions(+), 1 deletions(-)
> =A0create mode 100644 arch/powerpc/boot/dts/pcm032.dts
> =A0create mode 100644 arch/powerpc/configs/52xx/pcm032_defconfig
>
> diff --git a/arch/powerpc/boot/dts/pcm032.dts b/arch/powerpc/boot/dts/pcm=
032.dts
> new file mode 100644
> index 0000000..ebaf660
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/pcm032.dts
> @@ -0,0 +1,391 @@
> [...]
> + =A0 =A0 =A0 lpb@e4000000 {

As per generic names recommended practice, this node name should
really be something like "localbus {", and you should drop the node
address since the local bus doesn't really have an address.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,lpb";

Ideally should be: compatible =3D
"fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus";
I know that 'fsl,lpb' has been used in the past, but it is far to
generic and isn't good practice.  The 'simple-bus' property ensures
that the bus will get probed.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x0 0xe4000000 0x08000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;

Should be #address-cells =3D <2>;.  First cell is CS#, second cell is
offset from base of CS.  This is particularly important if the LPB
FIFO is ever used with any of this hardware.

motionpro.dts is a good example of what it should look like.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* free chipselect */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs4@00000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "free";

Very bad!  If you want to show available chip selects, then add some
commented out sections as examples.  Creating nodes with the extremely
generic compatible value of "free" is just asking for trouble
(especially when someone new sees the example and decides to use the
same thing in their driver).

> + =A0 =A0 =A0 lpb@f7000000 {

Another localbus node?  Why can't a single localbus node hold all the
child nodes?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,lpb";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x0 0xf7000000 0x09000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fpga1@00e00000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fpga1";

Too generic.  Be board specific.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x00e00000 0x02000=
000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank-width =3D <4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fpga2@02e00000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fpga2";

Ditto

Otherwise, the rest of the patch looks good to me.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
