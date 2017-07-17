Return-Path: <thomas.besemer@gmail.com>
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com
 [IPv6:2a00:1450:400c:c09::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9kjn3vsWzDr32
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 10:31:08 +1000 (AEST)
Received: by mail-wm0-x233.google.com with SMTP id b134so32541866wma.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jul 2017 17:31:08 -0700 (PDT)
MIME-Version: 1.0
From: Thomas Besemer <thomas.besemer@gmail.com>
Date: Sun, 16 Jul 2017 17:31:05 -0700
Message-ID: <CAO7m3AkpuUdApRiiDw+Sv6fqyhVsfBOUA8cw1xChJLxT1r6_wA@mail.gmail.com>
Subject: 440EP NOR Flash Mapping with DTS
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="001a11471358b0d356055478832e"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11471358b0d356055478832e
Content-Type: text/plain; charset="UTF-8"

I'm trying to map some NOR flash in via DTS on a Yosemite
style 440EP board. I've tried a few different things, below
showing my latest attempt.  During Kernel boot, it does not
appear to detect the device, as no messages are emitted.

Flash is Spansion S29GL256P, base address 0xFE000000.

DTS:

EBC0: ebc {
       compatible = "ibm,ebc-440ep", "ibm,ebc-440gp", "ibm,ebc";
       dcr-reg = <0x012 0x002>;
       #address-cells = <2>;
       #size-cells = <1>;
       clock-frequency = <0>; /* Filled in by zImage */
       interrupts = <0x5 0x1>;
       interrupt-parent = <&UIC1>;

       nor_flash@FE0000000,0 {
               compatible = "amd,p29gl256p", "cfi-flash";
               #bank-width = <2>;
               reg = <0xFE000000 0x02000000>;
               #address-cells = <1>;
               #size-cells = <1>;
               partition@0 {
                       label = "Kernel";
                       reg = <0x00000000 0x00180000>;
               };
               partition@180000 {
                       label = "OS Filesystem";
                       reg = <0x00180000 0x01DE0000>;
               };
       };
};

DTS appears to parse:

# pwd
/proc/device-tree/plb/opb/ebc
# find nor_flash@FE0000000,0/
nor_flash@FE0000000,0/
nor_flash@FE0000000,0/compatible
nor_flash@FE0000000,0/partition@0
nor_flash@FE0000000,0/partition@0/label
nor_flash@FE0000000,0/partition@0/reg
nor_flash@FE0000000,0/partition@0/name
nor_flash@FE0000000,0/#address-cells
nor_flash@FE0000000,0/#bank-width
nor_flash@FE0000000,0/#size-cells
nor_flash@FE0000000,0/reg
nor_flash@FE0000000,0/partition@180000
nor_flash@FE0000000,0/partition@180000/label
nor_flash@FE0000000,0/partition@180000/reg
nor_flash@FE0000000,0/partition@180000/name
nor_flash@FE0000000,0/name

I'm sure this is some sort of syntax error on my part.

Any suggestions?

--001a11471358b0d356055478832e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;m trying to map some NOR flash in via DTS on a Yosem=
ite<br>style 440EP board. I&#39;ve tried a few different things, below<br>s=
howing my latest attempt.=C2=A0 During Kernel boot, it does not <br>appear =
to detect the device, as no messages are emitted.<br><br>Flash is Spansion =
S29GL256P, base address 0xFE000000.<br><br>DTS:<br><br>EBC0: ebc {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;ibm,ebc-440ep&quot;, &quot;ibm=
,ebc-440gp&quot;, &quot;ibm,ebc&quot;;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0dcr-re=
g =3D &lt;0x012 0x002&gt;;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0#address-cells =3D=
 &lt;2&gt;;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0#size-cells =3D &lt;1&gt;;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0clock-frequency =3D &lt;0&gt;; /* Filled in by zIma=
ge */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0interrupts =3D &lt;0x5 0x1&gt;;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0interrupt-parent =3D &lt;&amp;UIC1&gt;;<br><br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0nor_flash@FE0000000,0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;amd,p29gl256p&quot;, &q=
uot;cfi-flash&quot;;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0#bank-width =3D &lt;2&gt;;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0reg =3D &lt;0xFE000000 0x02000000&gt;;<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#address-cells =3D &lt;1&gt;;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#size-cells =3D &lt;=
1&gt;;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0partition@=
0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0label =3D &quot;Kernel&quot;;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x00=
000000 0x00180000&gt;;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0};<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0partitio=
n@180000 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0label =3D &quot;OS Filesystem&quot;;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
g =3D &lt;0x00180000 0x01DE0000&gt;;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0};<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>};<br><br>DTS ap=
pears to parse:<br><br># pwd<br>/proc/device-tree/plb/opb/ebc<br># find nor=
_flash@FE0000000,0/<br>nor_flash@FE0000000,0/<br>nor_flash@FE0000000,0/comp=
atible<br>nor_flash@FE0000000,0/partition@0<br>nor_flash@FE0000000,0/partit=
ion@0/label<br>nor_flash@FE0000000,0/partition@0/reg<br>nor_flash@FE0000000=
,0/partition@0/name<br>nor_flash@FE0000000,0/#address-cells<br>nor_flash@FE=
0000000,0/#bank-width<br>nor_flash@FE0000000,0/#size-cells<br>nor_flash@FE0=
000000,0/reg<br>nor_flash@FE0000000,0/partition@180000<br>nor_flash@FE00000=
00,0/partition@180000/label<br>nor_flash@FE0000000,0/partition@180000/reg<b=
r>nor_flash@FE0000000,0/partition@180000/name<br>nor_flash@FE0000000,0/name=
<br><br>I&#39;m sure this is some sort of syntax error on my part.<br><br>A=
ny suggestions?<br></div>

--001a11471358b0d356055478832e--
