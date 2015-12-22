Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0059.outbound.protection.outlook.com [65.55.169.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E07AB1A0AA5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 03:11:56 +1100 (AEDT)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "igal.liberman@freescale.com" <igal.liberman@freescale.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "scottwood@freescale.com" <scottwood@freescale.com>,
 "shaohui.xie@freescale.com" <shaohui.xie@freescale.com>,
 "madalin.bucur@freescale.com" <madalin.bucur@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: Update fman dt binding with pcs-phy and
 tbi-phy
Date: Tue, 22 Dec 2015 15:56:57 +0000
Message-ID: <1450799843.28718.56.camel@infinera.com>
References: <1450757888-14216-1-git-send-email-igal.liberman@freescale.com>
In-Reply-To: <1450757888-14216-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-12-22 at 06:18 +0200, igal.liberman@freescale.com wrote:
> From: Igal Liberman <igal.liberman@freescale.com>
>=20
> Signed-off-by: Igal Liberman <igal.liberman@freescale.com>
> ---
> =A0.../devicetree/bindings/powerpc/fsl/fman.txt=A0=A0=A0=A0=A0=A0=A0|=A0=
=A0=A039 ++++++++++++++++++++
> =A01 file changed, 39 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> index 1fc5328..7a6d7c3 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> @@ -315,6 +315,16 @@ PROPERTIES
> =A0		Value type: <phandle>
> =A0		Definition: A phandle for 1EEE1588 timer.
> =A0
> +- pcsphy-handle
> +		Usage required for "fsl,fman-memac" MACs
> +		Value type: <phandle>
> +		Definition: A phandle for pcsphy.
> +
> +- tbi-handle
> +		Usage required for "fsl,fman-dtsec" MACs
> +		Value type: <phandle>
> +		Definition: A phandle for tbiphy.
> +
> =A0EXAMPLE
> =A0
> =A0fman1_tx28: port@a8000 {
> @@ -340,6 +350,7 @@ ethernet@e0000 {
> =A0	reg =3D <0xe0000 0x1000>;
> =A0	fsl,fman-ports =3D <&fman1_rx8 &fman1_tx28>;
> =A0	ptp-timer =3D <&ptp-timer>;
> +	tbi-handle =3D <&tbi0>;
> =A0};
> =A0
> =A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> @@ -415,6 +426,13 @@ PROPERTIES
> =A0		The settings and programming routines for internal/external
> =A0		MDIO are different. Must be included for internal MDIO.
> =A0
> +For internal PHY device on internal mdio bus, a PHY node should be creat=
ed.
> +See the definition of the PHY node in booting-without-of.txt for an
> +example of how to define a PHY (Internal PHY has no interrupt line).
> +- For "fsl,fman-mdio" compatible internal mdio bus, the PHY is TBI PHY.
> +- For "fsl,fman-memac-mdio" compatible internal mdio bus, the PHY is PCS=
 PHY,
> +=A0=A0PCS PHY addr must be '0'.

Will this replace the need for fixed PHYs ?

=A0 =A0Jocke=
