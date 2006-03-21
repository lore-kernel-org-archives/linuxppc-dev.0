Return-Path: <kim.phillips@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 44C6767A3D
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 04:48:11 +1100 (EST)
Date: Tue, 21 Mar 2006 11:48:06 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: [PATCH] powerpc: Add FSL SEC node to documentation
Message-Id: <20060321114806.6bcf3885.kim.phillips@freescale.com>
In-Reply-To: <200603202014.44879.hollis@penguinppc.org>
References: <20060320195945.004fdf26.kim.phillips@freescale.com>
	<200603202014.44879.hollis@penguinppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 20 Mar 2006 20:14:43 -0600
Hollis Blanchard <hollis@penguinppc.org> wrote:

> On Monday 20 March 2006 19:59, Kim Phillips wrote:
> > diff --git a/Documentation/powerpc/booting-without-of.txt=20
> b/Documentation/powerpc/booting-without-of.txt
> > index d02c649..72f3241 100644
> > --- a/Documentation/powerpc/booting-without-of.txt
> > +++ b/Documentation/powerpc/booting-without-of.txt
> > @@ -1365,6 +1365,79 @@ platforms are moved over to use the flat
> > =A0=A0=A0=A0=A0=A0};
> > =A0
> > =A0
> > + =A0 g) Freescale SOC SEC Security Engines
> > +
> > + =A0 Required properties:
> > +
> > + =A0 =A0- device_type : Should be "crypto"
> > + =A0 =A0- model : Model of the device. =A0Should be "SEC1" or "SEC2"
> > + =A0 =A0- compatible : Should be "talitos"
> [snip]
>=20
> Have you consulted with any other vendors regarding these properties? I k=
now=20
> there is no IEEE1275 binding for these sorts of devices, but we can at le=
ast=20
> attempt to standardize it (even in the absence of the Open Firmware Worki=
ng=20
> Group)...
>=20
> -Hollis

I took a look at some equivalent devices, the problem is they're all so dif=
ferent, architecturally.  otoh, I'm open to collaborate with others on the =
list in an effort to standardize it.

btw, I had omitted some descriptor types.  Here's a replacement patch:


Documentation: Added FSL SOC SEC node definition

Updated the documentation to include the definition of the SEC device
node format for Freescale SOC devices.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
commit 97d971c1d30e77a453cacaef72c32e00381ab02a
tree 4b815caece1c05b33309f8852eeccd90f020ca49
parent c4a1745aa09fc110afdefea0e5d025043e348bae
author Kim Phillips <kim.phillips@freescale.com> Mon, 20 Mar 2006 19:31:21 =
-0600
committer Kim Phillips <kim.phillips@freescale.com> Mon, 20 Mar 2006 19:31:=
21 -0600

 Documentation/powerpc/booting-without-of.txt |   73 ++++++++++++++++++++++=
++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/p=
owerpc/booting-without-of.txt
index d02c649..72f3241 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1365,6 +1365,79 @@ platforms are moved over to use the flat
 	};
=20
=20
+   g) Freescale SOC SEC Security Engines
+
+   Required properties:
+
+    - device_type : Should be "crypto"
+    - model : Model of the device.  Should be "SEC1" or "SEC2"
+    - compatible : Should be "talitos"
+    - reg : Offset and length of the register set for the device
+    - interrupts : <a b> where a is the interrupt number and b is a
+      field that represents an encoding of the sense and level
+      information for the interrupt.  This should be encoded based on
+      the information in section 2) depending on the type of interrupt
+      controller you have.
+    - interrupt-parent : the phandle for the interrupt controller that
+      services interrupts for this device.
+    - num-channels : An integer representing the number of channels
+      available.  Most modern SEC's have 4 channels.
+    - channel-fifo-len : An integer representing the number of descriptor
+      pointers each channel fetch fifo can hold.  Most modern SEC channel=
=20
+      fetch fifos can hold 24 descriptor pointers.
+    - exec-units-mask : The bitmask representing what execution units (EUs)
+      are available. It's a single 32 bit cell. EU information should be
+      encoded following the SEC's Descriptor Header Dword EU_SEL0 field=20
+      documentation, i.e. as follows:
+
+        bit 0 =3D reserved - should be 0
+        bit 1 =3D set if SEC has the ARC4 EU (AFEU)
+        bit 2 =3D set if SEC has the DES/3DES EU (DEU)
+        bit 3 =3D set if SEC has the message digest EU (MDEU)
+        bit 4 =3D set if SEC has the random number generator EU (RNG)
+        bit 5 =3D set if SEC has the public key EU (PKEU)
+        bit 6 =3D set if SEC has the AES EU (AESU)
+        bit 7 =3D set if SEC has the Kasumi EU (KEU)
+
+      bits 8 through 31 are reserved for future SEC EUs.
+
+    - descriptor-types-mask : The bitmask representing what descriptors
+      are available. It's a single 32 bit cell. Descriptor type informatio=
n=20
+      should be encoded as follows:
+
+        bit 0  =3D set if SEC supports the aesu_ctr_nonsnoop descriptor ty=
pe
+        bit 1  =3D set if SEC supports the ipsec_esp descriptor type
+        bit 2  =3D set if SEC supports the common_nonsnoop descriptor type
+        bit 3  =3D set if SEC supports the 802.11i AES ccmp descriptor type
+        bit 4  =3D set if SEC supports the hmac_snoop_no_afeu descriptor t=
ype
+        bit 5  =3D set if SEC supports the srtp descriptor type
+        bit 6  =3D set if SEC supports the non_hmac_snoop_no_afeu descript=
or type
+        bit 7  =3D set if SEC supports the pkeu_assemble descriptor type
+        bit 8  =3D set if SEC supports the aesu_key_expand_output descript=
or type
+        bit 9  =3D set if SEC supports the pkeu_ptmul descriptor type
+        bit 10 =3D set if SEC supports the common_nonsnoop_afeu descriptor=
 type
+        bit 11 =3D set if SEC supports the pkeu_ptadd_dbl descriptor type
+
+      ..and so on and so forth, following the SEC's Descriptor Header Dword
+      DESC_TYPE field definition in reference documentation.
+=20
+  Example:
+
+	/* MPC8548E */
+	crypto@30000 {
+		device_type =3D "crypto";
+		model =3D "SEC2";
+		compatible =3D "talitos";
+		reg =3D <30000 10000>;
+		interrupts =3D <1d 3>;
+		interrupt-parent =3D <40000>;
+		num-channels =3D <4>;
+		channel-fifo-len =3D <24>;
+		exec-units-mask =3D <000000fe>;
+		descriptor-types-mask =3D <073f1127>;
+	};
+
+
    More devices will be defined as this spec matures.
=20
=20



--=20
