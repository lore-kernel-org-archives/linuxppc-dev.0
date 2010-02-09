Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f172.google.com (mail-iw0-f172.google.com
	[209.85.223.172]) by ozlabs.org (Postfix) with ESMTP id 626F2B7D1C
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 03:15:28 +1100 (EST)
Received: by iwn2 with SMTP id 2so4760149iwn.10
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 08:15:27 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1265096864-3506-3-git-send-email-agust@denx.de>
References: <1265096864-3506-1-git-send-email-agust@denx.de>
	<1265096864-3506-3-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 09:15:07 -0700
Message-ID: <fa686aa41002090815l437ca386o4e8d3919606adc0a@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: doc/dts-bindings: document mpc5121 psc uart
	dts-bindings
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 2, 2010 at 12:47 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Support for MPC5121 PSC UART in the mpc52xx_uart driver
> added new DTS properties for FSL MPC5121 PSC FIFO Controller.
> Provide documentation of the new properties and some examples.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0.../powerpc/dts-bindings/fsl/mpc5121-psc.txt =A0 =A0 =A0 | =A0 70 ++++=
++++++++++++++++
> =A01 files changed, 70 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/powerpc/dts-bindings/fsl/mpc5121-psc.=
txt
>
> diff --git a/Documentation/powerpc/dts-bindings/fsl/mpc5121-psc.txt b/Doc=
umentation/powerpc/dts-bindings/fsl/mpc5121-psc.txt
> new file mode 100644
> index 0000000..8832e87
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/fsl/mpc5121-psc.txt
> @@ -0,0 +1,70 @@
> +MPC5121 PSC Device Tree Bindings
> +
> +PSC in UART mode
> +----------------
> +
> +For PSC in UART mode the needed PSC serial devices
> +are specified by fsl,mpc5121-psc-uart nodes in the
> +fsl,mpc5121-immr SoC node. Additionally the PSC FIFO
> +Controller node fsl,mpc5121-psc-fifo is requered there:
> +
> +fsl,mpc5121-psc-uart nodes
> +--------------------------
> +
> +Required properties :
> + - compatible : Should contain "fsl,mpc5121-psc-uart" and "fsl,mpc5121-p=
sc"
> + - cell-index : Index of the PSC in hardware
> + - reg : Offset and length of the register set for the PSC device
> + - interrupts : <a b> where a is the interrupt number of the
> + =A0 PSC FIFO Controller and b is a field that represents an
> + =A0 encoding of the sense and level information for the interrupt.
> + - interrupt-parent : the phandle for the interrupt controller that
> + =A0 services interrupts for this device.
> +
> +Recommended properties :
> + - fsl,rx-fifo-size : the size of the RX fifo slice (a multiple of 4)
> + - fsl,tx-fifo-size : the size of the TX fifo slice (a multiple of 4)
> +
> +
> +fsl,mpc5121-psc-fifo node
> +-------------------------
> +
> +Required properties :
> + - compatible : Should be "fsl,mpc5121-psc-fifo"
> + - reg : Offset and length of the register set for the PSC
> + =A0 =A0 =A0 =A0 FIFO Controller
> + - interrupts : <a b> where a is the interrupt number of the
> + =A0 PSC FIFO Controller and b is a field that represents an
> + =A0 encoding of the sense and level information for the interrupt.
> + - interrupt-parent : the phandle for the interrupt controller that
> + =A0 services interrupts for this device.
> +
> +
> +Example for a board using PSC0 and PSC1 devices in serial mode:
> +
> +serial@11000 {
> + =A0 =A0 =A0 compatible =3D "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
> + =A0 =A0 =A0 cell-index =3D <0>;
> + =A0 =A0 =A0 reg =3D <0x11000 0x100>;
> + =A0 =A0 =A0 interrupts =3D <40 0x8>;
> + =A0 =A0 =A0 interrupt-parent =3D < &ipic >;
> + =A0 =A0 =A0 fsl,rx-fifo-size =3D <16>;
> + =A0 =A0 =A0 fsl,tx-fifo-size =3D <16>;
> +};
> +
> +serial@11100 {
> + =A0 =A0 =A0 compatible =3D "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
> + =A0 =A0 =A0 cell-index =3D <1>;
> + =A0 =A0 =A0 reg =3D <0x11100 0x100>;
> + =A0 =A0 =A0 interrupts =3D <40 0x8>;
> + =A0 =A0 =A0 interrupt-parent =3D < &ipic >;
> + =A0 =A0 =A0 fsl,rx-fifo-size =3D <16>;
> + =A0 =A0 =A0 fsl,tx-fifo-size =3D <16>;
> +};
> +
> +pscfifo@11f00 {
> + =A0 =A0 =A0 compatible =3D "fsl,mpc5121-psc-fifo";
> + =A0 =A0 =A0 reg =3D <0x11f00 0x100>;
> + =A0 =A0 =A0 interrupts =3D <40 0x8>;
> + =A0 =A0 =A0 interrupt-parent =3D < &ipic >;
> +};
> --
> 1.6.3.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
