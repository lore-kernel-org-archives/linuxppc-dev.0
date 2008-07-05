Return-Path: <Andre.Schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 0C554DDE9F
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 19:32:08 +1000 (EST)
Message-ID: <486F3F98.3060205@matrix-vision.de>
Date: Sat, 05 Jul 2008 11:32:08 +0200
From: =?ISO-8859-1?Q?Andr=E9_Schwarz?= <Andre.Schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Add MPC5200B base board mvBC-P
References: <486E515B.80508@matrix-vision.de>
	<20080704170041.GD17062@secretlab.ca>
In-Reply-To: <20080704170041.GD17062@secretlab.ca>
Content-Type: multipart/alternative;
	boundary="------------060706030706010803080207"
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060706030706010803080207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Grant,

thanks for the quick feedback - I'll try to improve.
Hopefully monday morning will be on time ....

Comments inline.

regards,
Andr=E9

Grant Likely wrote:
> On Fri, Jul 04, 2008 at 06:35:39PM +0200, Andre Schwarz wrote:
>  =20
>> The mvBlueCOUGAR-P is a MPC5200B based camera system with Intel Gigabi=
t ethernet
>> controller (using e1000). It's just another MPC5200_simple board.
>>
>> Signed-off-by: Andre Schwarz <andre.schwarz@matrix-vision.de>
>> ---
>>
>>
>> Grant,
>>
>> I don't know if there are any merge windows ...
>> If the patch should be modified or re-submitted on a later time please=
 let me know.
>>    =20
>
> The merge window will be opening any day now.  If you address comments
> quickly then I should be able to merge it into 2.6.27
>
>  =20
great.
>>  arch/powerpc/boot/dts/mvbc-p.dts             |  206 +++++
>>  arch/powerpc/configs/mvbc-p_defconfig        | 1158 +++++++++++++++++=
+++++++++
>>    =20
> Rename this to arch/powerpc/config/52xx/mvbc_p_defconfig (use platform
> specific defconfig dir and don't mix '-' and '_' in filenames).
>
>  =20
ok - no problem.
>> diff --git a/arch/powerpc/boot/dts/mvbc-p.dts b/arch/powerpc/boot/dts/=
mvbc-p.dts
>> new file mode 100644
>> index 0000000..90a2808
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/mvbc-p.dts
>> @@ -0,0 +1,206 @@
>> +/*
>> + * mvBlueCOUGAR-P device tree source
>> + *
>> + * Copyright (C) 2008 Matrix Vision GmbH
>> + * Andre Schwarz <andre.schwarz@matrix-vision.de>
>> + *
>> + * This program is free software; you can redistribute it and/or modi=
fy it
>> + * under the terms of the GNU General Public License as published by =
the
>> + * Free Software Foundation; either version 2 of the License, or (at =
your
>> + * option) any later version.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +/ {
>> +	model =3D "matrix-vision,mvbc-p";
>> +	compatible =3D "matrix-vision,mvbc-p";
>> +	#address-cells =3D <1>;
>> +	#size-cells =3D <1>;
>> +
>> +	cpus {
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <0>;
>> +
>> +		PowerPC,5200@0 {
>> +			device_type =3D "cpu";
>> +			reg =3D <0>;
>> +			d-cache-line-size =3D <32>;
>> +			i-cache-line-size =3D <32>;
>> +			d-cache-size =3D <0x4000>;
>> +			i-cache-size =3D <0x4000>;
>> +			timebase-frequency =3D <0>;
>> +			bus-frequency =3D <0>;
>> +			clock-frequency =3D <0>;
>> +		};
>> +	};
>> +
>> +	memory {
>> +		device_type =3D "memory";
>> +		reg =3D <0x00000000 0x00000000>;
>> +	};
>> +
>> +	soc5200@f0000000 {
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <1>;
>> +		compatible =3D "fsl,mpc5200-immr";
>>    =20
>
> Does this board use the original 5200, or the 5200B?  If it uses the
> 5200B, then you should specify both fsl,mpc5200b-immr and
> fsl,mpc5200-immr.  Same goes for all other compatible properties in the
> tree; see lite5200b.dts for an example.
>
> I am toying with the option of eliminating the need for fsl,mpc5200b-*,
> but until then the conservative and safest thing to do is to claim
> compatibility with both.
>
>  =20
It's a MPC5200B. I thought that the "b"-Option has already out of use=20
after reading about this a few weeks ago ... maybe I misinterpreted.
I'll fix this.
>> +	lpb {
>> +		compatible =3D "fsl,lpb";
>>    =20
>
> You should also claim compatibility with "simple-bus" here.
>
> ie:  compatible =3D "fsl,lpb", "simple-bus";
>
>  =20
ok.
>> +		#address-cells =3D <2>;
>> +		#size-cells =3D <1>;
>> +		ranges =3D <0x0 0x0 0xff800000 0x00800000>;
>> +		flash@0,0 {
>> +			compatible =3D "cfi-flash";
>>    =20
>
> For completeness, it is good practice for the first entry in the compat=
ible
> list to be the actual flash chip, followed by "cfi-flash"
>
>  =20
ok.
>> +			reg =3D <0 0 0x800000>;
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <1>;
>> +			bank-width =3D <1>;
>> +			device-width =3D <1>;
>> +			nor_total@0x0 {
>> +				reg =3D <0x0 0x800000>;
>> +			};
>>    =20
>
> I don't know if this is legal; to have overlapping flash sections (but
> I'm not a cfi-flash binding expert).
>
>  =20
Hopefully this is still possible. Nested mtd partitions have always been=20
possible, e.g. embedded environment inside u-boot partition.
It's proven very useful to have access to the whole chip - so it's=20
possible to make binary updates even with the partition layout changing .=
...
I'd really like to stick to it if you don't mind.
>> +			u-boot@0x0 {
>> +				reg =3D <0x0 0x40000>;
>> +			};
>> +			u-boot_autoscript@0x40000 {
>> +				reg =3D <0x40000 0x10000>;
>> +			};
>> +			u-boot_autoscript_red@0x50000 {
>> +				reg =3D <0x50000 0x10000>;
>> +			};
>> +			fpga@0x60000 {
>> +				reg =3D <0x60000 0x40000>;
>> +			};
>> +			user@0xa0000 {
>> +				reg =3D <0xa00000 0x60000>;
>> +			};
>> +			rfs@0x100000 {
>> +				reg =3D <0x100000 0x300000>;
>> +			};
>> +			kernel@0x400000 {
>> +				reg =3D <0x400000 0x3c0000>;
>> +			};
>> +			dtb@0x7c0000 {
>> +				reg =3D <0x7c0000 0x10000>;
>> +			};
>> +			dtb@0x7d0000 {
>> +				reg =3D <0x7d0000 0x10000>;
>> +			};
>> +			ppcboot_env@0x7e0000 {
>> +				reg =3D <0x7e0000 0x10000>;
>> +			};
>> +			ppcboot_env@0x7f0000 {
>> +				reg =3D <0x7f0000 0x10000>;
>> +			};
>>    =20
>
> I think it would be better to just leave out the partition information
> and modify U-Boot to fill them in (just like memory and clock speed are
> left out).  Things like flash partitions are less like hardware
> description and more like configuration data.
>
>  =20
never did this. Is it quick'n'easy ?
Honestly I don't like the bootloader to set up everything.
If you need any change it will require a bootloader update which is a=20
very fragile operation out in the field.
There will always be bricked systems afterwards ....
Failure in updating the (redundant) dtb blob or kernel will do almost=20
always no harm since the system is still accessible and flashable using=20
ethernet or serial.

If it's not against all rule (which I don't think) I'd really like to=20
stick to it, too.
Is this ok ?
>> +		};
>> +	};
>> +
>> +	pci: pci@0xf0000d00 {
>> +		#interrupt-cells =3D <1>;
>> +		#size-cells =3D <2>;
>> +		#address-cells =3D <3>;
>> +		device_type =3D "pci";
>> +		compatible =3D "fsl,mpc5200-pci";
>> +		reg =3D <0xf0000d00 0x100>;
>> +		interrupt-map-mask =3D <0xf800 0 0 7>;
>> +		interrupt-map =3D <0x5800 0 0 1 &mpc5200_pic 1 2 3
>> +			0x5000 0 0 1 &mpc5200_pic 1 3 3>;
>> +		clock-frequency =3D <0>;
>> +		interrupts =3D <2 8 0 2 9 0 2 10 0>;
>> +		interrupt-parent =3D <&mpc5200_pic>;
>> +		bus-range =3D <0 0>;
>> +		ranges =3D <0x42000000 0 0x80000000 0x80000000 0 0x20000000
>> +			0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
>> +			0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
>> +	};
>> +};
>>    =20



MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

--------------060706030706010803080207
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Grant,<br>
<br>
thanks for the quick feedback - I'll try to improve.<br>
Hopefully monday morning will be on time ....<br>
<br>
Comments inline.<br>
<br>
regards,<br>
Andr&eacute;<br>
<br>
Grant Likely wrote:
<blockquote cite="mid:20080704170041.GD17062@secretlab.ca" type="cite">
  <pre wrap="">On Fri, Jul 04, 2008 at 06:35:39PM +0200, Andre Schwarz wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">The mvBlueCOUGAR-P is a MPC5200B based camera system with Intel Gigabit ethernet
controller (using e1000). It's just another MPC5200_simple board.

Signed-off-by: Andre Schwarz <a class="moz-txt-link-rfc2396E" href="mailto:andre.schwarz@matrix-vision.de">&lt;andre.schwarz@matrix-vision.de&gt;</a>
---


Grant,

I don't know if there are any merge windows ...
If the patch should be modified or re-submitted on a later time please let me know.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The merge window will be opening any day now.  If you address comments
quickly then I should be able to merge it into 2.6.27

  </pre>
</blockquote>
great.<br>
<blockquote cite="mid:20080704170041.GD17062@secretlab.ca" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap=""> arch/powerpc/boot/dts/mvbc-p.dts             |  206 +++++
 arch/powerpc/configs/mvbc-p_defconfig        | 1158 ++++++++++++++++++++++++++
    </pre>
  </blockquote>
  <pre wrap=""><!---->Rename this to arch/powerpc/config/52xx/mvbc_p_defconfig (use platform
specific defconfig dir and don't mix '-' and '_' in filenames).

  </pre>
</blockquote>
ok - no problem.<br>
<blockquote cite="mid:20080704170041.GD17062@secretlab.ca" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">diff --git a/arch/powerpc/boot/dts/mvbc-p.dts b/arch/powerpc/boot/dts/mvbc-p.dts
new file mode 100644
index 0000000..90a2808
--- /dev/null
+++ b/arch/powerpc/boot/dts/mvbc-p.dts
@@ -0,0 +1,206 @@
+/*
+ * mvBlueCOUGAR-P device tree source
+ *
+ * Copyright (C) 2008 Matrix Vision GmbH
+ * Andre Schwarz <a class="moz-txt-link-rfc2396E" href="mailto:andre.schwarz@matrix-vision.de">&lt;andre.schwarz@matrix-vision.de&gt;</a>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "matrix-vision,mvbc-p";
+	compatible = "matrix-vision,mvbc-p";
+	#address-cells = &lt;1&gt;;
+	#size-cells = &lt;1&gt;;
+
+	cpus {
+		#address-cells = &lt;1&gt;;
+		#size-cells = &lt;0&gt;;
+
+		PowerPC,5200@0 {
+			device_type = "cpu";
+			reg = &lt;0&gt;;
+			d-cache-line-size = &lt;32&gt;;
+			i-cache-line-size = &lt;32&gt;;
+			d-cache-size = &lt;0x4000&gt;;
+			i-cache-size = &lt;0x4000&gt;;
+			timebase-frequency = &lt;0&gt;;
+			bus-frequency = &lt;0&gt;;
+			clock-frequency = &lt;0&gt;;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = &lt;0x00000000 0x00000000&gt;;
+	};
+
+	soc5200@f0000000 {
+		#address-cells = &lt;1&gt;;
+		#size-cells = &lt;1&gt;;
+		compatible = "fsl,mpc5200-immr";
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Does this board use the original 5200, or the 5200B?  If it uses the
5200B, then you should specify both fsl,mpc5200b-immr and
fsl,mpc5200-immr.  Same goes for all other compatible properties in the
tree; see lite5200b.dts for an example.

I am toying with the option of eliminating the need for fsl,mpc5200b-*,
but until then the conservative and safest thing to do is to claim
compatibility with both.

  </pre>
</blockquote>
It's a MPC5200B. I thought that the "b"-Option has already out of use
after reading about this a few weeks ago ... maybe I misinterpreted.<br>
I'll fix this.<br>
<blockquote cite="mid:20080704170041.GD17062@secretlab.ca" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">+	lpb {
+		compatible = "fsl,lpb";
    </pre>
  </blockquote>
  <pre wrap=""><!---->
You should also claim compatibility with "simple-bus" here.

ie:  compatible = "fsl,lpb", "simple-bus";

  </pre>
</blockquote>
ok.<br>
<blockquote cite="mid:20080704170041.GD17062@secretlab.ca" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">+		#address-cells = &lt;2&gt;;
+		#size-cells = &lt;1&gt;;
+		ranges = &lt;0x0 0x0 0xff800000 0x00800000&gt;;
+		flash@0,0 {
+			compatible = "cfi-flash";
    </pre>
  </blockquote>
  <pre wrap=""><!---->
For completeness, it is good practice for the first entry in the compatible
list to be the actual flash chip, followed by "cfi-flash"

  </pre>
</blockquote>
ok.<br>
<blockquote cite="mid:20080704170041.GD17062@secretlab.ca" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">+			reg = &lt;0 0 0x800000&gt;;
+			#address-cells = &lt;1&gt;;
+			#size-cells = &lt;1&gt;;
+			bank-width = &lt;1&gt;;
+			device-width = &lt;1&gt;;
+			nor_total@0x0 {
+				reg = &lt;0x0 0x800000&gt;;
+			};
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I don't know if this is legal; to have overlapping flash sections (but
I'm not a cfi-flash binding expert).

  </pre>
</blockquote>
Hopefully this is still possible. Nested mtd partitions have always
been possible, e.g. embedded environment inside u-boot partition.<br>
It's proven very useful to have access to the whole chip - so it's
possible to make binary updates even with the partition layout changing
....<br>
I'd really like to stick to it if you don't mind.<br>
<blockquote cite="mid:20080704170041.GD17062@secretlab.ca" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">+			u-boot@0x0 {
+				reg = &lt;0x0 0x40000&gt;;
+			};
+			u-boot_autoscript@0x40000 {
+				reg = &lt;0x40000 0x10000&gt;;
+			};
+			u-boot_autoscript_red@0x50000 {
+				reg = &lt;0x50000 0x10000&gt;;
+			};
+			fpga@0x60000 {
+				reg = &lt;0x60000 0x40000&gt;;
+			};
+			user@0xa0000 {
+				reg = &lt;0xa00000 0x60000&gt;;
+			};
+			rfs@0x100000 {
+				reg = &lt;0x100000 0x300000&gt;;
+			};
+			kernel@0x400000 {
+				reg = &lt;0x400000 0x3c0000&gt;;
+			};
+			dtb@0x7c0000 {
+				reg = &lt;0x7c0000 0x10000&gt;;
+			};
+			dtb@0x7d0000 {
+				reg = &lt;0x7d0000 0x10000&gt;;
+			};
+			ppcboot_env@0x7e0000 {
+				reg = &lt;0x7e0000 0x10000&gt;;
+			};
+			ppcboot_env@0x7f0000 {
+				reg = &lt;0x7f0000 0x10000&gt;;
+			};
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I think it would be better to just leave out the partition information
and modify U-Boot to fill them in (just like memory and clock speed are
left out).  Things like flash partitions are less like hardware
description and more like configuration data.

  </pre>
</blockquote>
never did this. Is it quick'n'easy ?<br>
Honestly I don't like the bootloader to set up everything.<br>
If you need any change it will require a bootloader update which is a
very fragile operation out in the field.<br>
There will always be bricked systems afterwards ....<br>
Failure in updating the (redundant) dtb blob or kernel will do almost
always no harm since the system is still accessible and flashable using
ethernet or serial.<br>
<br>
If it's not against all rule (which I don't think) I'd really like to
stick to it, too.<br>
Is this ok ?<br>
<blockquote cite="mid:20080704170041.GD17062@secretlab.ca" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">+		};
+	};
+
+	pci: pci@0xf0000d00 {
+		#interrupt-cells = &lt;1&gt;;
+		#size-cells = &lt;2&gt;;
+		#address-cells = &lt;3&gt;;
+		device_type = "pci";
+		compatible = "fsl,mpc5200-pci";
+		reg = &lt;0xf0000d00 0x100&gt;;
+		interrupt-map-mask = &lt;0xf800 0 0 7&gt;;
+		interrupt-map = &lt;0x5800 0 0 1 &amp;mpc5200_pic 1 2 3
+			0x5000 0 0 1 &amp;mpc5200_pic 1 3 3&gt;;
+		clock-frequency = &lt;0&gt;;
+		interrupts = &lt;2 8 0 2 9 0 2 10 0&gt;;
+		interrupt-parent = &lt;&amp;mpc5200_pic&gt;;
+		bus-range = &lt;0 0&gt;;
+		ranges = &lt;0x42000000 0 0x80000000 0x80000000 0 0x20000000
+			0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+			0x01000000 0 0x00000000 0xb0000000 0 0x01000000&gt;;
+	};
+};
    </pre>
  </blockquote>
</blockquote>
<br>
<BR>

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
<BR>
</body>
</html>

--------------060706030706010803080207--
