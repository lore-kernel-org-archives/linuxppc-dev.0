Return-Path: <pskhanapur@googlemail.com>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95C151007EB
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 May 2011 22:20:51 +1000 (EST)
Received: by qyk7 with SMTP id 7so3577988qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 07 May 2011 05:20:46 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 7 May 2011 14:20:46 +0200
Message-ID: <BANLkTik7tZSJ9-OPDbQEPJDHpZ13wMmo_Q@mail.gmail.com>
Subject: Regarding P2020 in AMP mode
From: Prasanna Khanapur <pskhanapur@googlemail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=90e6ba5bba87cc425204a2aea2fb
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--90e6ba5bba87cc425204a2aea2fb
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I'm running P2020 in AMP mode, each core running its linux os.
Ethernet 1(@25000) and Ethernet 2(@26000) assigned to Core0 are working
fine.
I'm facing problems with Ethernet interface(@24000) assigned to Core1, its
not working.

I'm using dts file which were added by :
http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-September/075594.html

Looks either there is some mistake in the dts file or my understanding is
wrong.

MDIO @24000 is defined in core0 dts file though the Ethernet is assigned to
Core 1.

DTS files :
http://web.mornfall.net/repos/linux-2.6/git/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
http://web.mornfall.net/repos/linux-2.6/git/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts

		mdio@24520 {
			#address-cells = <1>;
			#size-cells = <0>;
			compatible = "fsl,gianfar-mdio";
			reg = <0x24520 0x20>;

			phy0: ethernet-phy@0 {
				interrupt-parent = <&mpic>;
				interrupts = <3 1>;
				reg = <0x0>;
			};
			phy1: ethernet-phy@1 {
				interrupt-parent = <&mpic>;
				interrupts = <3 1>;
				reg = <0x1>;
			};
		};

Also, MDIO for 25520 has wrong register value:

		mdio@25520 {
			#address-cells = <1>;
			#size-cells = <0>;
			compatible = "fsl,gianfar-tbi";
			reg = <0x26520 0x20>;

			tbi0: tbi-phy@11 {
				reg = <0x11>;
				device_type = "tbi-phy";
			};
		};



Please correct me if  I'm wrong.  Has freescale released a working dts files
for P2020 in AMP mode ? as this seems to be not working.

Best Regards
Prasanna Khanapur.

--90e6ba5bba87cc425204a2aea2fb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div>I&#39;m running P2020 in AMP mode, each core running its linux os.<=
/div><div>Ethernet 1(@25000) and=A0Ethernet=A02(@26000) assigned to Core0 a=
re working fine.</div><div>I&#39;m facing problems with=A0Ethernet=A0interf=
ace(@24000) assigned to Core1, its not working.</div>
<div><br></div><div>I&#39;m using dts file which were added by :</div><div>=
<a href=3D"http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-September/07=
5594.html">http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-September/07=
5594.html</a></div>
<div><br></div><div>Looks either there is some mistake in the dts file or m=
y understanding is wrong.</div><div><br></div><div>MDIO @24000 is defined i=
n core0 dts file though the=A0Ethernet=A0is assigned to Core 1.</div><div><=
br>
</div><div>DTS files :=A0<a href=3D"http://web.mornfall.net/repos/linux-2.6=
/git/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts">http://web.mornfall.net=
/repos/linux-2.6/git/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts</a></div=
>
<div><a href=3D"http://web.mornfall.net/repos/linux-2.6/git/arch/powerpc/bo=
ot/dts/p2020rdb_camp_core1.dts">http://web.mornfall.net/repos/linux-2.6/git=
/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts</a></div><div><span class=3D=
"Apple-style-span" style=3D"font-family: &#39;Times New Roman&#39;; font-si=
ze: medium; "><pre style=3D"word-wrap: break-word; white-space: pre-wrap; "=
>
		mdio@24520 {
			#address-cells =3D &lt;1&gt;;
			#size-cells =3D &lt;0&gt;;
			compatible =3D &quot;fsl,gianfar-mdio&quot;;
			reg =3D &lt;0x24520 0x20&gt;;

			phy0: ethernet-phy@0 {
				interrupt-parent =3D &lt;&amp;mpic&gt;;
				interrupts =3D &lt;3 1&gt;;
				reg =3D &lt;0x0&gt;;
			};
			phy1: ethernet-phy@1 {
				interrupt-parent =3D &lt;&amp;mpic&gt;;
				interrupts =3D &lt;3 1&gt;;
				reg =3D &lt;0x1&gt;;
			};
		};
</pre></span><div style=3D"font-family: &#39;Times New Roman&#39;; font-siz=
e: medium; ">Also, MDIO for 25520 has wrong register value:</div><div style=
=3D"font-family: &#39;Times New Roman&#39;; font-size: medium; "><pre style=
=3D"word-wrap: break-word; white-space: pre-wrap; ">
		mdio@25520 {
			#address-cells =3D &lt;1&gt;;
			#size-cells =3D &lt;0&gt;;
			compatible =3D &quot;fsl,gianfar-tbi&quot;;
			reg =3D &lt;0x26520 0x20&gt;;

			tbi0: tbi-phy@11 {
				reg =3D &lt;0x11&gt;;
				device_type =3D &quot;tbi-phy&quot;;
			};
		};
</pre></div><div style=3D"font-family: &#39;Times New Roman&#39;; font-size=
: medium; "><br></div><div style=3D"font-family: &#39;Times New Roman&#39;;=
 font-size: medium; "><br></div><div style=3D"font-family: &#39;Times New R=
oman&#39;; font-size: medium; ">
Please correct me if =A0I&#39;m wrong. =A0Has freescale released a working =
dts files for P2020 in AMP mode ? as this seems to be not working.</div><di=
v style=3D"font-family: &#39;Times New Roman&#39;; font-size: medium; "><br=
></div>
<div style=3D"font-family: &#39;Times New Roman&#39;; font-size: medium; ">=
Best Regards</div><div style=3D"font-family: &#39;Times New Roman&#39;; fon=
t-size: medium; ">Prasanna Khanapur.</div></div><div><br></div><div><br></d=
iv>
<div><br></div>

--90e6ba5bba87cc425204a2aea2fb--
