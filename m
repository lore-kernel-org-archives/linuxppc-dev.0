Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
	[209.85.211.196]) by ozlabs.org (Postfix) with ESMTP id 8AC62B7CF0
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Mar 2010 09:46:58 +1100 (EST)
Received: by ywh34 with SMTP id 34so5082168ywh.17
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 15:46:57 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1269643337-29431-1-git-send-email-timur@freescale.com>
References: <1269643337-29431-1-git-send-email-timur@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 26 Mar 2010 16:46:37 -0600
Message-ID: <fa686aa41003261546y48812e37xcbda00703781c678@mail.gmail.com>
Subject: Re: [PATCH] [v3] powerpc/fsl: add device tree binding for QE firmware
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

On Fri, Mar 26, 2010 at 4:42 PM, Timur Tabi <timur@freescale.com> wrote:
> Define a binding for embedding a QE firmware blob into the device tree. =
=A0Also
> define a new property for the QE node that links to a firmware node.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> =A0.../powerpc/dts-bindings/fsl/cpm_qe/qe.txt =A0 =A0 =A0 =A0 | =A0 54 ++=
++++++++++++++++++
> =A01 files changed, 54 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt b/Docum=
entation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
> index 6e37be1..8b7246b 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
> @@ -21,6 +21,15 @@ Required properties:
> =A0- fsl,qe-num-snums: define how many serial number(SNUM) the QE can use=
 for the
> =A0 threads.
>
> +Optional properties:
> +- fsl,firmware-phandle:
> + =A0 =A0Usage: required only if there is no fsl,qe-firmware child node
> + =A0 =A0Value type: <phandle>
> + =A0 =A0Definition: Points to a firmware node (see "QE Firmware Node" be=
low)
> + =A0 =A0 =A0 =A0that contains the firmware that should be uploaded for t=
his QE.
> + =A0 =A0 =A0 =A0The compatible property for the firmware node should say=
,
> + =A0 =A0 =A0 =A0"fsl,qe-firmware".
> +
> =A0Recommended properties
> =A0- brg-frequency : the internal clock source frequency for baud-rate
> =A0 generators in Hz.
> @@ -59,3 +68,48 @@ Example:
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
> +property, and any firmware-specific properties. =A0The node should be pl=
aced
> +inside a QE node that needs it. =A0Doing so eliminates the need for a
> +fsl,firmware-phandle property. =A0Other QE nodes that need the same firm=
ware
> +should define an fsl,firmware-phandle property that points to the firmwa=
re node
> +in the first QE node.
> +
> +The fsl,firmware property can be specified in the DTS (possibly using in=
cbin)
> +or can be inserted by the boot loader at boot time.
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
> + =A0 =A0 =A0 qe1@e0080000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,qe";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qe_firmware:qe-firmware {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,qe-firm=
ware";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,firmware =3D <0x70 0xcd=
 0x00 0x00 0x01 0x46 0x45 ...>

This should actually be square brackets for 8-bit data (as opposed to
cells).  I'll fix it up when I merge the patch.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 qe2@e0090000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,qe";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,firmware-phandle =3D <&qe_firmware>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
> + =A0 =A0 =A0 }
> --
> 1.6.5
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
