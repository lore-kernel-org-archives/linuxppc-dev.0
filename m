Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id CA4ADDE33A
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 01:13:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Does Dev Tree WORK with soc@y_xxxx_0000 <#address/size> = <2/1>
Date: Tue, 12 Aug 2008 11:14:15 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010DF4EFAF@EMPBEDEX.empirix.com>
In-Reply-To: <0120619E-B530-4605-B550-15085F7009E2@freescale.com>
References: <mailman.1745.1218472641.19168.linuxppc-dev@ozlabs.org>
	<BD261180E6D35F4D9D32F3E44FD3D9010DF4EB31@EMPBEDEX.empirix.com>
	<0120619E-B530-4605-B550-15085F7009E2@freescale.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Becky Bruce" <becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thank you Becky (and Kumar) for all the information....and help!

To answer your questions, yes, we are using 4GB++ of memory
(and plan more in the near future). But, for the initial bring
up, I reduced the memory to 2Gig. Further, I have modified u-boot=20
to NOT modify the memory reg properties (see below my snippet)...

Question: what other 'devices' does u-boot put down that I care=20
about I have modified u-boot to put the correct memory structure?=20

Also, are you saying there are additional patches for=20
prom parsing code for this to work right - or are you=20
talking about in general for the 4Gig memory??

Here is a dts snippet with some of the interesting parts:

/{	model =3D "MPC8548_CHEETAH";
	compatible =3D "MPC8548_CHEETAH";
	#address-cells =3D <2>;
	#size-cells =3D <2>;
 =20
 	memory { device_type =3D "memory";
		  reg =3D <0 	00000000 0 80000000>; // 2 GIG @ 0x0
         	};

	soc8548@c6df00000 {
		#address-cells =3D <1>;
		#size-cells =3D <1>;
		#interrupt-cells =3D <2>;
		device_type =3D "soc";
		ranges =3D <00001000 00000000c 6df00000 000ff000>;
		reg =3D <0000000C 6df00000 0 001000>;	// CCSRBAR

.........
		serial@4500 {
			device_type =3D "serial";
			compatible =3D "ns16550";
			reg =3D <4500 100>;	// reg base, size
			clock-frequency =3D <0>;	// should we fill in in
uboot?
			interrupts =3D <2a 2>;
			interrupt-parent =3D <&mpic>;
		};

		serial@4600 {
			device_type =3D "serial";
			compatible =3D "ns16550";
			reg =3D <4600 100>;	// reg base, size
			clock-frequency =3D <0>;	// should we fill in in
uboot?
			interrupts =3D <2a 2>;
			interrupt-parent =3D <&mpic>;
		};

.........
};

Now, it looks like I am successfully parsing and translating the=20
address to the expected address for the default stdout (0xc_6df0_4600)!

FWIW, I have identified that another problem with the code configuring
the CCSRBAR (and am sure I'll figure that one out soon because we have=20
a working solution in the arch/ppc directory).

While I have your expert attention, I'd like to have you comment about
what potentially could be right/wrong with my definitions for the pci
express settings...

   a) Do I put those ranges in the ranges for the parent soc device
(also)?

   b) Do the below correctly define a 2 Gig PCI memory Window starting=20
      at 0xC_6F00_0000 (to 0xC_EF00_0000) and PCI IO 16M Window starting
      at 0xC_6E00_0000 (to 0xC_6F00_0000)?

-----
  /* PCI Express */
  pcie@a000 {
	compatible =3D "fsl,mpc8548-pcie";
	device_type =3D "pci";
	#interrupt-cells =3D <1>;
	#size-cells =3D <2>;
	#address-cells =3D <3>;
	reg =3D <a000 1000>;
	bus-range =3D <0 ff>;
	ranges =3D <02000000 0 c 6f000000 c 6f000000 0 80000000
  		   01000000  0 00000000 0000000c 6E000000 0 01000000>;

-----

Thank you for all your help/comments...

Sincerely,

Tom Morrison
-----Original Message-----
From: Becky Bruce [mailto:becky.bruce@freescale.com]=20
Sent: Monday, August 11, 2008 6:26 PM
To: Morrison, Tom
Cc: linuxppc-dev@ozlabs.org; Paul Mackerras
Subject: Re: Does Dev Tree WORK with soc@y_xxxx_0000 <#address/size> =3D
<2/1>


On Aug 11, 2008, at 4:37 PM, Morrison, Tom wrote:

> I am sorry, but I've butted my head against a tree for over a
> week and some things just aren't making sense...especially how
> the prom parse code is working to exact / resolve physical
> addresses to then ioremap...
>
> a) Setup, I have a working MPC8548E board using 2.6.23.8 (ARCH=3Dppc)
>   with PHYS/PTE_64BIT enabled (with the proper patches)).

So, how much RAM are you trying to use?  If it's 4GB+, there are still
patches you need that haven't been released yet but should be out in
the next week or so (I'm in the middle of pulling everything up to
top-of-tree and re-testing).

>
>
> b) Goal: we want to move our board to a generic 2.6.23 version that
>   Freescale has produced to support the MPC8572DS (and eventually
>   use that kernel to build our BSP for our next board).
>
> c) I have successfully gotten to work a pure '32-bit' dev tree
>   (PHYS/PTE_64BIT not defined - and the CCSRBAR @ 0xE000_0000)
>    The #address/#size <1/1> is '1' (as well as the #size is '1')
>
> d) I have modified this dev tree to support the 36bit mode addressing
>   (with the CCSRBAR and PCIExpress defined to in the last 4Gig =20
> (instead
>    of the default first 4Gig - e.g.: 0xC_E000_0000)...
>
> e) I then set the soc to have #address-cells to '2' (#size-cells is =20
> '1')
>   (and added the additional values accordingly to the ranges...=09

I'm not sure you've done the right thing here.  In many cases, you don't
actually need to modify the size/addr cells in the soc node - those just
impact the children of that node, which are relative to the parent.

You do need to change your high-level platform node at the very top of
the .dts to have the right width - here's a patch snippet from a dts I =20
had
with 2/1 formatting (this is a very old .dts, so it uses the old-style
number formatting before we started using '0x'):

+       model =3D "MPC8641HPCN";
+       compatible =3D "mpc86xx";
+       #address-cells =3D <2>;
+       #size-cells =3D <1>;

and then the soc node itself was: (I located things at 0xf_xxx0_0000)

+       soc8641@ff8000000 {
+               #address-cells =3D <1>;
+               #size-cells =3D <1>;
+               device_type =3D "soc";
+               ranges =3D <00000000 0f f8000000 00100000>;
+               reg =3D <f f8000000 00001000>;    // CCSRBAR

The reg and ranges now reflect the wider parent bus address.

>
>
> f) The prom_parse code has a problem with translating these addresses

>
>
> The main question is: has anyone ever tested this with soc #address/=20
> size
> being <2/1> in this fashion?

I did that a while ago with 8641D and it worked fine at that point;
since then I've converted to a 2/2 format (which also works fine).

That, of course, assumes you've modified your bootloader to put the
devices in the right spot.  Without that, all bets are off.

Hope that helps.... if you're still confused, post some snippets of =20
your dts and I'll take a look.

Cheers,
B
