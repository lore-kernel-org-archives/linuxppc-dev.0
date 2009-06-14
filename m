Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3B601B70EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 00:40:58 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <1244765062-14144-3-git-send-email-w.sang@pengutronix.de>
References: <1244765062-14144-1-git-send-email-w.sang@pengutronix.de>
	<1244765062-14144-3-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 14 Jun 2009 08:40:34 -0600
Message-ID: <fa686aa40906140740m43e9dd8am4d242310f681c95c@mail.gmail.com>
Subject: Re: [PATCH 2/2] uio: add an of_genirq driver
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@ozlabs.org, "Hans J. Koch" <hjk@linutronix.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Greg KH <gregkh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 11, 2009 at 6:04 PM, Wolfram Sang<w.sang@pengutronix.de> wrote:
> Picking up the now exported generic probe function from the
> platform-variant of this driver, this patch adds an of-version. Also add
> the binding documentation.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Hans J. Koch <hjk@linutronix.de>
> Cc: Greg KH <gregkh@suse.de>
> ---
>
> In probe, I put the resources-array on the stack to simplify the code. If=
 this
> is considered too huge for the stack (140 byte for a 32-bit system at the
> moment), I can also post a version using kzalloc.
>
> =A0Documentation/powerpc/dts-bindings/uio-generic.txt | =A0 16 +++
> =A0drivers/uio/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 =A06 +
> =A0drivers/uio/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/uio/uio_of_genirq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 98 ++++++++++++++++++++
> =A04 files changed, 121 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/powerpc/dts-bindings/uio-generic.txt
> =A0create mode 100644 drivers/uio/uio_of_genirq.c
>
> diff --git a/Documentation/powerpc/dts-bindings/uio-generic.txt b/Documen=
tation/powerpc/dts-bindings/uio-generic.txt
> new file mode 100644
> index 0000000..8ad9861
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/uio-generic.txt
> @@ -0,0 +1,16 @@
> +UIO for custom devices
> +
> +A device which will be mapped using the UIO subsystem.
> +
> +Properties:
> + - compatible : should contain the specific model used, followed by
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"generic-uio".
> + - reg : address range(s) of the device (up to MAX_UIO_MAPS)
> + - interrupts : interrupt of the device
> +
> +Example:
> + =A0 =A0 =A0 =A0c64fpga@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "ptx,c64fpga001", "generi=
c-uio";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x0 0x10000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <0 0 3>;
> + =A0 =A0 =A0 =A0};

Hmmm, I'm not happy about this.  The device tree describes the
hardware, not the way Linux uses the hardware.  UIO definitely falls
into the category of Linux implementation detail.

This should be approached from the other way around.  Either the
generic-uio of_platform driver should contain an explicit list of
devices to be handled by UIO, or the OF infrastructure should be
modified to allow things like force binding of_devices to of_drivers
at runtime.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
