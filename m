Return-Path: <stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Date: Wed, 28 Mar 2007 09:43:16 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
In-Reply-To: <20070328012206.GD1586@mag.az.mvista.com>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>,
	"linuxppc-dev" <Linuxppc-dev@ozlabs.org>
Cc: Dale Farnsworth <dfarnsworth@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Biggest concern is that I see a lot of undocumented device
types and properties...

Device types that I do not recognize include:
+			device_type =3D "brg";
+			device_type =3D "mv64x60-cunit";
+			device_type =3D "mpscrouting";
+			device_type =3D "mpscintr";
+			device_type =3D "mv64x60-pic";
+			device_type =3D "mv64x60-mpp";
+			device_type =3D "mv64x60-gpp";
+			device_type =3D "mv64x60-cpu-error";
+			device_type =3D "mv64x60-sram-error";
+			device_type =3D "mv64x60-pci-error";
+			device_type =3D "mv64x60-memctrl";

These should ideally be documented with required properties
and what they mean.

I think a document similar to Grant Likely's
Documentation/mpc52xx-device-tree-bindings.txt would be
very helpful here.  People using this DTS as a starting
point are going to have a lot of questions.

comments inline below--=20
[snip]

> +
> +	mv64x60@f1000000 { /* Marvell Discovery */
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		#interrupt-cells =3D <1>;
> +		device_type =3D "mv64360";
> +		compatible =3D "mv64x60";
> +		clock-frequency =3D <7f28155>;		/*=20
> 133.333333 Mhz */
> +		reg =3D <f1000000 00010000>;
> +		virtual-reg =3D <f1000000>;

What is virtual-reg for?  I gather it is related to the bootwrapper
needed virtual addresses for devices reg blocks.  But, I counted
12 instances of the property in this file.  Are all needed by the
bootwrapper??

Does anyone where this property came from historically?  If it's
specifically for a Linux bootwrapper the name should reflect=20
that-- linux,bootwrapper-reg-vaddr -- or something...

I also wonder if there is a better place to put this information.
The device nodes strictly speaking should be describing the devices
_physical_ characteristics.

It also needs to be documented in booting-without-of.txt.

[snip]
> +			reg =3D <2000 2000>;
> +			virtual-reg =3D <f1002000>;
> +			eth0 {
> +				device_type =3D "network";
> +				compatible =3D "mv64x60-eth";
> +				block-index =3D <0>;
> +				interrupts =3D <20>;
> +				interrupt-parent =3D <&/mv64x60/pic>;
> +				phy =3D <&/mv64x60/mdio/ethernet-phy@1>;
> +				local-mac-address =3D [ 00 00 00=20
> 00 00 00 ];
> +			};
> +			eth1 {
> +				device_type =3D "network";
> +				compatible =3D "mv64x60-eth";
> +				block-index =3D <1>;
> +				interrupts =3D <21>;
> +				interrupt-parent =3D <&/mv64x60/pic>;
> +				phy =3D <&/mv64x60/mdio/ethernet-phy@3>;
> +				local-mac-address =3D [ 00 00 00=20
> 00 00 00 ];
> +			};
> +		};

Based on some offline dicussions I think I know what block-index
is, but I'd like to see this property documented in
booting-without-of.txt.

[snip]
> +		i2c@c000 {
> +			device_type =3D "i2c";
> +			compatible =3D "mv64x60-i2c";
> +			reg =3D <c000 20>;
> +			virtual-reg =3D <f100c000>;
> +			freq_m =3D <8>;
> +			freq_n =3D <3>;
> +			timeout =3D <3e8>;		/* 1000=20

If freq_m and freq_n are Marvell specific should have
a "Marvel," prepended to them?

[snip]
> +		pci@80000000 {
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			#interrupt-cells =3D <1>;
> +			device_type =3D "pci";
> +			compatible =3D "mv64x60-pci";
> +			reg =3D <0cf8 8>;
> +			ranges =3D <01000000 0        0 88000000=20
> 0 01000000
> +				  02000000 0 80000000 80000000=20
> 0 08000000>;
> +			bus-range =3D <0 ff>;
> +			clock-frequency =3D <3EF1480>;
> +			interrupt-pci-iack =3D <0c34>;

I don't think interrupt-pci-iack is standard.  If it's generally
applicable add it to booting-without-of.txt.  If its MV specific=20
prepend with "Marvel,".

Regards,
Stuart Yoder
