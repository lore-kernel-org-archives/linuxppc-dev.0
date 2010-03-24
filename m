Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id A0880B7CED
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 17:08:13 +1100 (EST)
Received: by gyf1 with SMTP id 1so3635247gyf.15
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Mar 2010 23:08:11 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1269380552-10418-1-git-send-email-timur@freescale.com>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 24 Mar 2010 00:07:51 -0600
Message-ID: <fa686aa41003232307s39af071bn6377800951d6615c@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 23, 2010 at 3:42 PM, Timur Tabi <timur@freescale.com> wrote:
> Define a binding for embedding a QE firmware blob into the device tree. =
=A0Also
> define a new property for the QE node that links to a firmware node.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> =A0.../powerpc/dts-bindings/fsl/cpm_qe/qe.txt =A0 =A0 =A0 =A0 | =A0 50 ++=
++++++++++++++++++
> =A01 files changed, 50 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt b/Docum=
entation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
> index 6e37be1..d9d6431 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
> @@ -20,6 +20,14 @@ Required properties:
> =A0- fsl,qe-num-riscs: define how many RISC engines the QE has.
> =A0- fsl,qe-num-snums: define how many serial number(SNUM) the QE can use=
 for the
> =A0 threads.
> +- fsl,firmware-phandle:
> + =A0 =A0Usage: required
> + =A0 =A0Value type: <phandle>
> + =A0 =A0Definition: Points to a firmware node (see "QE Firmware Node" be=
low)
> + =A0 =A0 =A0 =A0that contains the firmware that should be uploaded for t=
his QE.
> + =A0 =A0 =A0 =A0The compatible property for the firmware node should say=
,
> + =A0 =A0 =A0 =A0"fsl,qe-firmware".
> +

Why the phandle redirection?  Why not just put the firmware blob into
a property in the QE node, or as a subnode?

g.

>
> =A0Recommended properties
> =A0- brg-frequency : the internal clock source frequency for baud-rate
> @@ -59,3 +67,45 @@ Example:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0 c000>;
> =A0 =A0 =A0 =A0};
> =A0 =A0 =A0};
> +
> +* QE Firmware Node
> +
> +This node defines a firmware binary that is embedded in the device tree,=
 for
> +the purpose of passing the firmware from bootloader to the kernel, or fr=
om
> +the hypervisor to the guest.
> +
> +The firmware node itself contains the firmware binary contents, a compat=
ible
> +property, and any firmware-specific properties. =A0The node itself can b=
e located
> +anywhere, but should probably be placed at the top level. =A0The QE node
> +that needs the firmware should define a property that links to the firmw=
are
> +node's phandle.
> +
> +This node is typically not defined in the DTS. =A0Instead, the boot load=
er
> +normally creates the node from scratch, using a firmware binary that is =
already
> +located in non-volatile storage or transferred from a tftp server.
> +
> +Required properties:
> + =A0- compatible
> + =A0 =A0 =A0Usage: required
> + =A0 =A0 =A0Value type: <string>
> + =A0 =A0 =A0Definition: A standard property. =A0Specify a string that in=
dicates what
> + =A0 =A0 =A0 =A0 =A0kind of firmware it is. =A0For QE, this should be "f=
sl,qe-firmware".
> +
> + =A0 - fsl,firmware
> + =A0 =A0 =A0Usage: required
> + =A0 =A0 =A0Value type: <prop-encoded-array>, encoded as an array of byt=
es
> + =A0 =A0 =A0Definition: A standard property. =A0This property contains t=
he firmware
> + =A0 =A0 =A0 =A0 =A0binary "blob".
> +
> +Example:
> + =A0 =A0 =A0 qe@e0080000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,qe";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,firmware-phandle =3D <&qe_firmware>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 qe_firmware:qe-firmware {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,qe-firmware";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,firmware =3D <0x70 0xcd 0x00 0x00 0x01 =
0x46 0x45 0x63 ...>
> + =A0 =A0 =A0 }
> +
> --
> 1.6.5
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
