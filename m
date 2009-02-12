Return-Path: <jhautbois@gmail.com>
Received: from mail-fx0-f11.google.com (mail-fx0-f11.google.com
	[209.85.220.11]) by ozlabs.org (Postfix) with ESMTP id A8558DDDDC
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 20:31:56 +1100 (EST)
Received: by fxm4 with SMTP id 4so2570527fxm.9
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 01:31:54 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 12 Feb 2009 10:23:42 +0100
Message-ID: <8cad0aa0902120123p27cfe32fg6bf08d458178c937@mail.gmail.com>
Subject: [MPC8272ADS]Problem adding flash partitions inside the device tree
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=001636c5c0c1c55c810462b546ff
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--001636c5c0c1c55c810462b546ff
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi everybody !
I am currently trying to add the support of partitions for the Flash chip on
my MPC8272ADS board (the chips are Sharp LH28F016SCT-L90).

I have added this part:

flash@0,0 {
                        compatible = "jedec-flash";
                        reg = <0x0 0x0 0x2000000>;
                        bank-width = <4>;
                        device-width = <1>;

                        partition@ff800000 {
                                label = "kernel";
                                reg = <0xff800000 0x00400000>;
                                read-only;
                        };
                        partition@ffc00000 {
                                label = "user";
                                reg = <0xffc00000 0x00300000>;
                        };
                        partition@fff00000 {
                                label = "u-boot";
                                reg = <0xfff00000 0x00100000>;
                                read-only;
                        };
                };

But when I am compiling, I have these warnings:
Warning (reg_format): "reg" property in /localbus@f0010100/flash@0
,0/partition@ff800000 has invalid length (8 bytes) (#address-cells == 2,
#size-cells == 1)
Warning (reg_format): "reg" property in /localbus@f0010100/flash@0
,0/partition@ffc00000 has invalid length (8 bytes) (#address-cells == 2,
#size-cells == 1)
Warning (reg_format): "reg" property in /localbus@f0010100/flash@0
,0/partition@fff00000 has invalid length (8 bytes) (#address-cells == 2,
#size-cells == 1)
Warning (avoid_default_addr_size): Relying on default #address-cells value
for /localbus@f0010100/flash@0,0/partition@ff800000
Warning (avoid_default_addr_size): Relying on default #size-cells value for
/localbus@f0010100/flash@0,0/partition@ff800000
Warning (avoid_default_addr_size): Relying on default #address-cells value
for /localbus@f0010100/flash@0,0/partition@ffc00000
Warning (avoid_default_addr_size): Relying on default #size-cells value for
/localbus@f0010100/flash@0,0/partition@ffc00000
Warning (avoid_default_addr_size): Relying on default #address-cells value
for /localbus@f0010100/flash@0,0/partition@fff00000
Warning (avoid_default_addr_size): Relying on default #size-cells value for
/localbus@f0010100/flash@0,0/partition@fff00000


Can anyone help me ?
I can't understand what the "address-cells" is.

Thanks in advance !
Best Regards.
JM

--001636c5c0c1c55c810462b546ff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi everybody !<br>I am currently trying to add the support of partitions fo=
r the Flash chip on my MPC8272ADS board (the chips are Sharp LH28F016SCT-L9=
0).<br><br>I have added this part:<br><br>flash@0,0 {<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D &quot;jedec-fl=
ash&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt=
;0x0 0x0 0x2000000&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; bank-width =3D &lt;4&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device-width =3D &lt;1&gt;;<br><br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; partition@ff80000=
0 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label =3D &quot;kernel&quot;;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0xff800000 0x00400000&gt;;=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read-only;<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; partition@ffc00000 {<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; label =3D &quot;user&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0xffc00000 0x00300000&gt;;=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; partition@ff=
f00000 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label =3D &quot;u-boot&quo=
t;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0xfff00000 0x001000=
00&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read-only;<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br><br>But=
 when I am compiling, I have these warnings:<br>Warning (reg_format): &quot=
;reg&quot; property in /localbus@f0010100/flash@0,0/partition@ff800000 has =
invalid length (8 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)<br=
>
Warning (reg_format): &quot;reg&quot; property in /localbus@f0010100/flash@=
0,0/partition@ffc00000 has invalid length (8 bytes) (#address-cells =3D=3D =
2, #size-cells =3D=3D 1)<br>Warning (reg_format): &quot;reg&quot; property =
in /localbus@f0010100/flash@0,0/partition@fff00000 has invalid length (8 by=
tes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)<br>
Warning (avoid_default_addr_size): Relying on default #address-cells value =
for /localbus@f0010100/flash@0,0/partition@ff800000<br>Warning (avoid_defau=
lt_addr_size): Relying on default #size-cells value for /localbus@f0010100/=
flash@0,0/partition@ff800000<br>
Warning (avoid_default_addr_size): Relying on default #address-cells value =
for /localbus@f0010100/flash@0,0/partition@ffc00000<br>Warning (avoid_defau=
lt_addr_size): Relying on default #size-cells value for /localbus@f0010100/=
flash@0,0/partition@ffc00000<br>
Warning (avoid_default_addr_size): Relying on default #address-cells value =
for /localbus@f0010100/flash@0,0/partition@fff00000<br>Warning (avoid_defau=
lt_addr_size): Relying on default #size-cells value for /localbus@f0010100/=
flash@0,0/partition@fff00000<br>
<br><br>Can anyone help me ?<br>I can&#39;t understand what the &quot;addre=
ss-cells&quot; is.<br><br>Thanks in advance !<br>Best Regards.<br>JM<br>

--001636c5c0c1c55c810462b546ff--
