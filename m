Return-Path: <julianosam@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id 86A9EB70F6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Sep 2010 06:39:17 +1000 (EST)
Received: by wwa36 with SMTP id 36so1253822wwa.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 13:39:14 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 16 Sep 2010 17:39:14 -0300
Message-ID: <AANLkTin-W8qD-shAYojvR6pXbO-HumzSJXFhCUGM35xJ@mail.gmail.com>
Subject: Can't find Ethernet PHY on MDIO bus
From: Juliano Maia <julianosam@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016367fad7171dc66049066700c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016367fad7171dc66049066700c
Content-Type: text/plain; charset=ISO-8859-1

Hi.

I have 2 Ethernet PHYs connected to Powerpc MPC8313 TSEC1 and TSEC2
interfaces. The PHY I'm having trouble with is a Marvell 88E3015, and its
connected to TSEC2. I have mapped them in DTS file as follows:

mdio@24520 {
#address-cells = <1>;
#size-cells = <0>;
compatible = "fsl,gianfar-mdio";
reg = <0x24520 0x20>;
phy3: ethernet-phy@3 {
reg = <0x3>;
device_type = "ethernet-phy";
};
phy1: ethernet-phy@1 {
interrupt-parent = <&ipic>;
interrupts = <24 0x8>;
reg = <0x1>;
device_type = "ethernet-phy";
};
};

enet0: ethernet@24000 {
cell-index = <0>;
device_type = "network";
compatible = "gianfar";
reg = <0x24000 0x1000>;
model = "eTSEC";
local-mac-address = [ 00 00 00 00 00 00 ];
interrupts = <32 0x8 33 0x8 34 0x8>;
interrupt-parent = <&ipic>;
fixed-link = <3 1 100 1 0>;
linux,network-index = <0>;
};

enet1: ethernet@25000 {
#address-cells = <1>;
#size-cells = <1>;

cell-index = <1>;
device_type = "network";
model = "eTSEC";
compatible = "gianfar";
reg = <0x25000 0x1000>;
local-mac-address = [ 00 a0 3e a8 a6 6E ];
interrupts = <35 0x8 36 0x8 37 0x8>;
interrupt-parent = <&ipic>;
phy-handle = < &phy1 >;
};

The problem is I'm not being able to set *ETH1* up. When i try, say "*ifconfig
eth1 up*" i got:
*vmunix: Trying to connect phy mdio@e0024520:01
vmunix: eth1: Could not attach to PHY*

I've tried to track this error down and found that the it raises from *
bus_find_device_by_name* function at *bus.c*. For some reason ETH1 is never
added do *devices_kset* for MDIO bus. It only contains an entry for ETH0,
which is 00:3.

What could be wrong? In a hardware point of view, this PHY seems to be OK,
since I've made some tests from U-boot command line trying some MDIO
commands. I've also checked MDIO pins with oscilloscope and everything seems
to be fine. But during Linux initialization I could not see any activity in
MDIO pins. Is that normal? Is there any other files I should change (other
than DTS) to make PHYs work?


Thanks

-- 
Juliano Maia

--0016367fad7171dc66049066700c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi.<br><br>
<div>I have 2 Ethernet PHYs connected to Powerpc MPC8313 TSEC1 and TSEC2 in=
terfaces. The PHY I&#39;m having trouble with is a Marvell 88E3015, and its=
 connected to TSEC2. I have mapped them in DTS file as follows:
<br>

<br>
		mdio@24520 {
<br>
			#address-cells =3D &lt;1&gt;;
<br>
			#size-cells =3D &lt;0&gt;;
<br>
			compatible =3D &quot;fsl,gianfar-mdio&quot;;
<br>
			reg =3D &lt;0x24520 0x20&gt;;
<br>
			phy3: ethernet-phy@3 {
<br>
				reg =3D &lt;0x3&gt;;
<br>
				device_type =3D &quot;ethernet-phy&quot;;
<br>
			};
<br>
			phy1: ethernet-phy@1 {
<br>
					interrupt-parent =3D &lt;&amp;ipic&gt;;
<br>
					interrupts =3D &lt;24 0x8&gt;;
<br>
					reg =3D &lt;0x1&gt;;
<br>
					device_type =3D &quot;ethernet-phy&quot;;
<br>
			};
<br>
		};
<br>

<br>
		enet0: ethernet@24000 {
<br>
			cell-index =3D &lt;0&gt;;
<br>
			device_type =3D &quot;network&quot;;
<br>
			compatible =3D &quot;gianfar&quot;;
<br>
			reg =3D &lt;0x24000 0x1000&gt;;
<br>
			model =3D &quot;eTSEC&quot;;
<br>
			local-mac-address =3D [ 00 00 00 00 00 00 ];
<br>
			interrupts =3D &lt;32 0x8 33 0x8 34 0x8&gt;;
<br>
			interrupt-parent =3D &lt;&amp;ipic&gt;;
<br>
			fixed-link =3D &lt;3 1 100 1 0&gt;;
<br>
			linux,network-index =3D &lt;0&gt;;=20
<br>
		};
<br>

<br>
		enet1: ethernet@25000 {
<br>
			#address-cells =3D &lt;1&gt;;
<br>
			#size-cells =3D &lt;1&gt;;
<br>

<br>
			cell-index =3D &lt;1&gt;;
<br>
			device_type =3D &quot;network&quot;;
<br>
			model =3D &quot;eTSEC&quot;;
<br>
			compatible =3D &quot;gianfar&quot;;
<br>
			reg =3D &lt;0x25000 0x1000&gt;;
<br>
			local-mac-address =3D [ 00 a0 3e a8 a6 6E ];
<br>
			interrupts =3D &lt;35 0x8 36 0x8 37 0x8&gt;;
<br>
			interrupt-parent =3D &lt;&amp;ipic&gt;;
<br>
			phy-handle =3D &lt; &amp;phy1 &gt;;
<br>
		};
<br>

<br>
The problem is I&#39;m not being able to set <b>ETH1</b> up. When i try, sa=
y &quot;<b>ifconfig eth1 up</b>&quot; i got:
<br>
<strong>vmunix: Trying to connect phy mdio@e0024520:01
<br>
vmunix: eth1: Could not attach to PHY</strong>
<br>

<br>
I&#39;ve tried to track this error down and found that the it raises from <=
strong>bus_find_device_by_name</strong> function at <strong>bus.c</strong>.=
 For some reason ETH1 is never added do  <strong>devices_kset</strong> for =
MDIO bus. It only contains an entry for ETH0, which is 00:3.
<br>

<br>
What could be wrong? In a hardware point of view, this PHY seems to be OK, =
since I&#39;ve made some tests=20
from U-boot command line trying some MDIO commands. I&#39;ve also checked M=
DIO pins with oscilloscope and everything seems to be fine. But during Linu=
x initialization I could not see any activity in MDIO pins. Is that normal?=
=A0Is there any other files
 I should change (other than DTS) to make PHYs work?=A0</div><div>

<br>

<br>
Thanks                        <br clear=3D"all"><br>-- <br>Juliano Maia<br>=
<br><br>
</div>

--0016367fad7171dc66049066700c--
