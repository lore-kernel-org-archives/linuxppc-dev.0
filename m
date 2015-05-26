Return-Path: <hongtao.jia@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0131.outbound.protection.outlook.com [207.46.100.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D747B1A0E53
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 16:33:23 +1000 (AEST)
From: Hongtao Jia <hongtao.jia@freescale.com>
To: Scott Wood <scottwood@freescale.com>, "edubezval@gmail.com"
 <edubezval@gmail.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "rui.zhang@intel.com"
 <rui.zhang@intel.com>, Hongtao Jia <hongtao.jia@freescale.com>
Subject: RE: [PATCH V2] QorIQ/TMU: add TMU node to device tree for QorIQ T104x
Date: Tue, 26 May 2015 06:33:16 +0000
Message-ID: <BLUPR03MB1498C018F80A754767DF48FE1CC0@BLUPR03MB149.namprd03.prod.outlook.com>
References: <1429085868-47577-1-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1429085868-47577-1-git-send-email-hongtao.jia@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

Eduardo indicated that "calibration" property should add "fsl" prefix.
I updated the patch.
Any other comments?
If not I will send V3 soon.

Thanks.

---
Best Regards,
Hongtao


> -----Original Message-----
> From: Jia Hongtao [mailto:hongtao.jia@freescale.com]
> Sent: Wednesday, April 15, 2015 4:18 PM
> To: Wood Scott-B07421
> Cc: linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org;
> robh+dt@kernel.org; rui.zhang@intel.com; Jia Hongtao-B38951
> Subject: [PATCH V2] QorIQ/TMU: add TMU node to device tree for QorIQ
> T104x
>=20
> This is Thermal Monitoring Unit for QorIQ platform.
>=20
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> ---
> Changes from V1:
> * Provide more details on compatible and calibration properties.
>=20
>  .../devicetree/bindings/thermal/qoriq-thermal.txt  | 68
> ++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/qoriq-tmu-t104xsi.dtsi   | 82
> ++++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |  1 +
>  3 files changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qoriq-
> thermal.txt
>  create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-tmu-t104xsi.dtsi
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> new file mode 100644
> index 0000000..48e7fff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> @@ -0,0 +1,68 @@
> +* Thermal Monitoring Unit (TMU) on Freescale QorIQ SoCs
> +
> +Required properties:
> +- compatible : Must include "fsl,qoriq-tmu". The version of the device
> is
> +	determined by the TMU IP Block Revision Register (IPBRR0) at
> +	offset 0x0BF8.
> +	Table of correspondences between IPBRR0 values and example  chips:
> +		Value           Device
> +		----------      -----
> +		0x01900102      T1040
> +- reg : Address range of TMU registers.
> +- interrupts : Contains the interrupt for TMU.
> +- calibration : Calibration table for TMU. This is required to determine
> +	what a specific sensor reading translates to in degrees Celsius.
> +	There are four calibration config ranges, for each range we need
> +	a couple of calibration data formatted like <TTCFGR, TSCFGR>.
> +	Freescale provides the data required.
> +
> +Example:
> +
> +tmu@f0000 {
> +	compatible =3D "fsl,qoriq-tmu";
> +	reg =3D <0xf0000 0x1000>;
> +	interrupts =3D <18 2 0 0>;
> +	calibration =3D <0x00000000 0x0000000f
> +		       0x00000001 0x00000017
> +		       0x00000002 0x0000001e
> +		       0x00000003 0x00000026
> +		       0x00000004 0x0000002e
> +		       0x00000005 0x00000035
> +		       0x00000006 0x0000003d
> +		       0x00000007 0x00000044
> +		       0x00000008 0x0000004c
> +		       0x00000009 0x00000053
> +		       0x0000000a 0x0000005b
> +		       0x0000000b 0x00000062
> +
> +		       0x00010000 0x00000011
> +		       0x00010001 0x00000019
> +		       0x00010002 0x00000021
> +		       0x00010003 0x0000002a
> +		       0x00010004 0x00000032
> +		       0x00010005 0x0000003a
> +		       0x00010006 0x00000042
> +		       0x00010007 0x0000004b
> +		       0x00010008 0x00000053
> +		       0x00010009 0x0000005b
> +		       0x0001000a 0x00000063
> +
> +		       0x00020000 0x00000012
> +		       0x00020001 0x0000001b
> +		       0x00020002 0x00000024
> +		       0x00020003 0x0000002c
> +		       0x00020004 0x00000035
> +		       0x00020005 0x0000003d
> +		       0x00020006 0x00000046
> +		       0x00020007 0x0000004e
> +		       0x00020008 0x00000057
> +
> +		       0x00030000 0x00000009
> +		       0x00030001 0x00000011
> +		       0x00030002 0x00000019
> +		       0x00030003 0x00000021
> +		       0x00030004 0x00000029
> +		       0x00030005 0x00000031
> +		       0x00030006 0x00000039
> +		       0x00030007 0x00000041>;
> +};
> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-tmu-t104xsi.dtsi
> b/arch/powerpc/boot/dts/fsl/qoriq-tmu-t104xsi.dtsi
> new file mode 100644
> index 0000000..d85c77d
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/qoriq-tmu-t104xsi.dtsi
> @@ -0,0 +1,82 @@
> +/*
> + * QorIQ TMU device tree stub [ controller @ offset 0xf0000 ]
> + *
> + * Copyright 2015 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> are met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above
> copyright
> + *       notice, this list of conditions and the following disclaimer in
> the
> + *       documentation and/or other materials provided with the
> distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote
> products
> + *       derived from this software without specific prior written
> permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of
> the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND
> ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR
> ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
> SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
> CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +tmu@f0000 {
> +	compatible =3D "fsl,qoriq-tmu";
> +	reg =3D <0xf0000 0x1000>;
> +	interrupts =3D <18 2 0 0>;
> +	calibration =3D <0x00000000 0x0000000f
> +		       0x00000001 0x00000017
> +		       0x00000002 0x0000001e
> +		       0x00000003 0x00000026
> +		       0x00000004 0x0000002e
> +		       0x00000005 0x00000035
> +		       0x00000006 0x0000003d
> +		       0x00000007 0x00000044
> +		       0x00000008 0x0000004c
> +		       0x00000009 0x00000053
> +		       0x0000000a 0x0000005b
> +		       0x0000000b 0x00000062
> +
> +		       0x00010000 0x00000011
> +		       0x00010001 0x00000019
> +		       0x00010002 0x00000021
> +		       0x00010003 0x0000002a
> +		       0x00010004 0x00000032
> +		       0x00010005 0x0000003a
> +		       0x00010006 0x00000042
> +		       0x00010007 0x0000004b
> +		       0x00010008 0x00000053
> +		       0x00010009 0x0000005b
> +		       0x0001000a 0x00000063
> +
> +		       0x00020000 0x00000012
> +		       0x00020001 0x0000001b
> +		       0x00020002 0x00000024
> +		       0x00020003 0x0000002c
> +		       0x00020004 0x00000035
> +		       0x00020005 0x0000003d
> +		       0x00020006 0x00000046
> +		       0x00020007 0x0000004e
> +		       0x00020008 0x00000057
> +
> +		       0x00030000 0x00000009
> +		       0x00030001 0x00000011
> +		       0x00030002 0x00000019
> +		       0x00030003 0x00000021
> +		       0x00030004 0x00000029
> +		       0x00030005 0x00000031
> +		       0x00030006 0x00000039
> +		       0x00030007 0x00000041>;
> +};
> diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> index 15ae462..bb9f792 100644
> --- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> @@ -345,6 +345,7 @@
>  		reg	   =3D <0xea000 0x4000>;
>  	};
>=20
> +/include/ "qoriq-tmu-t104xsi.dtsi"
>  /include/ "elo3-dma-0.dtsi"
>  /include/ "elo3-dma-1.dtsi"
>  /include/ "qoriq-espi-0.dtsi"
> --
> 2.1.0.27.g96db324
