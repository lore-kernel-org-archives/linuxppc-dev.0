Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id A2196DDEA3
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 08:33:14 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C85950.90466876"
Subject: Problems with PCI on 8280
Date: Thu, 17 Jan 2008 15:33:13 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B039BA0D4@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C85950.90466876
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi.
 We have e 8280 bioard with PCI. We have three memory ranges set up;
0x8000_0000 to 0x8fff_ffff is prefetchable memory
0x9000_0000 to 0x97ff_ffff is non-prefetchable memory
0x9800_0000 to 0x9800_ffff is IO.

our device tree has
ranges =3D <42000000 0 80000000 80000000 0 10000000    // Pre-fetch =
memory
	  02000000 0 90000000 90000000 0 08000000    // Normal Memory
	  01000000 0 98000000 98000000 0 00010000>;  // I/O

for the memory ranges in the PCI node (full node at the end)

Our problem is that we can only access the first 128MB of the =
prefetchable area.
an access to 0x87ff_ffff works (after ioremap), while an access to =
0x8800_0000 causes an bus error.

trying to access 0x87FFFFFC -> 0x00000000
trying to access 0x88000000 ->Machine check in kernel mode.
Caused by (from SRR1=3D49030): Transfer error ack signal

It is like the prefetch area is not set up correctly for ioremap.

The PCI registers are set up correctly in u-boot, and we can access the =
whole prefetch area in u-boot without any problems.

pci node in device tree:

	pci@f0010800 {
		device_type =3D "pci";
		reg =3D <f0010800 10c f00101ac 8 f00101c4 8>;
		compatible =3D "fsl,mpc8280-pci", "apmax-pci", "fsl,pq2-pci";
		#interrupt-cells =3D <1>;
		#size-cells =3D <2>;
		#address-cells =3D <3>;
		clock-frequency =3D <d#49766400>;               // For our board.
		interrupt-map-mask =3D <f800 0 0 7>;            // Anded with the =
interrupt-map values
		interrupt-map =3D <
		                /* IDSEL 0x11 */
		                00008800 0 0 1 &PCI_INT 5>;   // 3 first numbers pci =
device specifier are: (buss << 16 | id_sel << 11) 0 0
		                                              //    buss =3D 0, id_sel =
=3D 11
		                                              // Next number is =
interrupt 1-4 mapped A-D (interrupt A for us)
		                                              // Last two numbers are =
host interrupt specifier (external interrupt 5)

		//interrupt-parent =3D <&PIC>;
		interrupt-parent =3D <&PCI_INT>;=20
		// interrupts =3D <12 8>;
               // Mem type 0 Bus Add  Loc. Add 0 Length      <<--- =
Remember the mem type is little endian
		ranges =3D <42000000 0 80000000 80000000 0 10000000    // Pre-fetch =
memory
		          02000000 0 90000000 90000000 0 08000000    // Normal Memory
		          01000000 0 98000000 98000000 0 00010000>;  // I/O
		         =20
        bus-range =3D <0 ff>;
        pci@12 {
    		device_type =3D "pci";
            reg =3D <9000 0 0 0 0>;
    		#interrupt-cells =3D <1>;
    		#size-cells =3D <2>;
    		#address-cells =3D <3>;
    		interrupt-parent =3D <&PCI_INT>;=20
    		interrupt-map-mask =3D <0f800 0 0 7>;
    		interrupt-map =3D <
    		                /* IDSEL 0x10 */
    		                00000000 0 0 1 &PCI_INT 1

    		                /* IDSEL 0x11 */
    		                00000800 0 0 1 &PCI_INT 2
    		               =20
    		                /* IDSEL 0x12 */
    		                00001000 0 0 1 &PCI_INT 3
    		               =20
    		                /* IDSEL 0x13 */
    		                00001800 0 0 1 &PCI_INT 4 >;
        };
	};





------_=_NextPart_001_01C85950.90466876
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>Problems with PCI on 8280</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi.<BR>
&nbsp;We have e 8280 bioard with PCI. We have three memory ranges set =
up;<BR>
0x8000_0000 to 0x8fff_ffff is prefetchable memory<BR>
0x9000_0000 to 0x97ff_ffff is non-prefetchable memory<BR>
0x9800_0000 to 0x9800_ffff is IO.<BR>
<BR>
our device tree has<BR>
ranges =3D &lt;42000000 0 80000000 80000000 0 10000000&nbsp;&nbsp;&nbsp; =
// Pre-fetch memory<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 02000000 0 90000000 =
90000000 0 08000000&nbsp;&nbsp;&nbsp; // Normal Memory<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 01000000 0 98000000 =
98000000 0 00010000&gt;;&nbsp; // I/O<BR>
<BR>
for the memory ranges in the PCI node (full node at the end)<BR>
<BR>
Our problem is that we can only access the first 128MB of the =
prefetchable area.<BR>
an access to 0x87ff_ffff works (after ioremap), while an access to =
0x8800_0000 causes an bus error.<BR>
<BR>
trying to access 0x87FFFFFC -&gt; 0x00000000<BR>
trying to access 0x88000000 -&gt;Machine check in kernel mode.<BR>
Caused by (from SRR1=3D49030): Transfer error ack signal<BR>
<BR>
It is like the prefetch area is not set up correctly for ioremap.<BR>
<BR>
The PCI registers are set up correctly in u-boot, and we can access the =
whole prefetch area in u-boot without any problems.<BR>
<BR>
pci node in device tree:<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci@f0010800 {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;pci&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;f0010800 10c =
f00101ac 8 f00101c4 8&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;fsl,mpc8280-pci&quot;, &quot;apmax-pci&quot;, =
&quot;fsl,pq2-pci&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells =3D =
&lt;1&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =
&lt;2&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D =
&lt;3&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock-frequency =3D =
&lt;d#49766400&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // For our board.<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-map-mask =3D =
&lt;f800 0 0 =
7&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
// Anded with the interrupt-map values<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-map =3D &lt;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* IDSEL 0x11 */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 00008800 0 0 1 &amp;PCI_INT 5&gt;;&nbsp;&nbsp; // 3 =
first numbers pci device specifier are: (buss &lt;&lt; 16 | id_sel =
&lt;&lt; 11) 0 0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; =
buss =3D 0, id_sel =3D 11<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Next number is =
interrupt 1-4 mapped A-D (interrupt A for us)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Last two numbers =
are host interrupt specifier (external interrupt 5)<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //interrupt-parent =3D =
&lt;&amp;PIC&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;PCI_INT&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // interrupts =3D &lt;12 =
8&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; // Mem type 0 Bus Add&nbsp; Loc. Add 0 =
Length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;&lt;--- Remember the mem type =
is little endian<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges =3D &lt;42000000 0 =
80000000 80000000 0 10000000&nbsp;&nbsp;&nbsp; // Pre-fetch memory<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 02000000 0 =
90000000 90000000 0 08000000&nbsp;&nbsp;&nbsp; // Normal Memory<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01000000 0 =
98000000 98000000 0 00010000&gt;;&nbsp; // I/O<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bus-range =3D &lt;0 =
ff&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci@12 {<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;pci&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =
=3D &lt;9000 0 0 0 0&gt;;<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells =3D =
&lt;1&gt;;<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =
&lt;2&gt;;<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D =
&lt;3&gt;;<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;PCI_INT&gt;;<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-map-mask =3D =
&lt;0f800 0 0 7&gt;;<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-map =3D &lt;<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* IDSEL 0x10 */<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 00000000 0 0 1 &amp;PCI_INT 1<BR>
<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* IDSEL 0x11 */<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 00000800 0 0 1 &amp;PCI_INT 2<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* IDSEL 0x12 */<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 00001000 0 0 1 &amp;PCI_INT 3<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* IDSEL 0x13 */<BR>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 00001800 0 0 1 &amp;PCI_INT 4 &gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C85950.90466876--
