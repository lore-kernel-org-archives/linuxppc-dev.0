Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 2EDF1DDE98
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 14:14:09 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so392906anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 20:14:05 -0700 (PDT)
Message-ID: <fa686aa40803212014ne560615sfcdef542d59eb6cb@mail.gmail.com>
Date: Fri, 21 Mar 2008 21:14:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Bartlomiej Sieka" <tur@semihalf.com>
Subject: Re: [POWERPC] mpc52xx: Amalgamated dts fixes and updates
In-Reply-To: <20080321235633.GB345@frozen.semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47E2723D.1090101@grandegger.com> <47E281B6.20702@denx.de>
	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>
	<47E2FC3E.1020705@semihalf.com>
	<fa686aa40803201720l3e42c983se121ebc257c89912@mail.gmail.com>
	<20080321235633.GB345@frozen.semihalf.com>
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 21, 2008 at 5:56 PM, Bartlomiej Sieka <tur@semihalf.com> wrote:
> The bulk of this patch is taken from
>  http://patchwork.ozlabs.org/linuxppc/patch?q=Balakowicz&id=16197, with few
>  other updates, in particluar one posted by Anatolij Gustschin, which fixes
>  an Oops during boot.
>
>  Signed-off-by: Marian Balakowicz <m8@semihalf.com>

Comments below.

>  ---
>  Anatolij, would you like to add your S-O-B?
>
>  diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
>  index 30737ea..8b2e8e4 100644
>  --- a/arch/powerpc/boot/dts/cm5200.dts
>  +++ b/arch/powerpc/boot/dts/cm5200.dts
>  @@ -159,6 +159,7 @@
>                 };
>
>                 dma-controller@1200 {
>  +                       device_type = "dma-controller";
>                         compatible = "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
>                         reg = <1200 80>;
>                         interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
>  @@ -212,13 +213,31 @@
>                 ethernet@3000 {
>                         device_type = "network";
>                         compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
>  -                       reg = <3000 800>;
>  +                       reg = <3000 400>;
>                         local-mac-address = [ 00 00 00 00 00 00 ];
>                         interrupts = <2 5 0>;
>                         interrupt-parent = <&mpc5200_pic>;
>  +                       phy-handle = <&phy0>;
>  +               };
>  +
>  +               mdio@3000 {
>  +                       #address-cells = <1>;
>  +                       #size-cells = <0>;
>  +                       device_type = "mdio";

Drop device type; it's unneeded and unused.

>  +                       compatible = "fsl,mpc5200b-mdio";

Should technically be "fsl,mpc5200b-mdio", "fsl,mpc5200-mdio";  (I
know the lite5200b.dts doesn't have this either, but I'll write a
patch right now to fix it so that it's correct in .25)

I regret introducing "fsl,mpc5200b-*" at all since the 5200b is really
just a bug fix of the 5200 except for a very few incompatible device
changes.  Just the nodes for specific incompatible devices need to
claim 5200b-<blah> in their compatible string (without claiming
5200-<blah>). It seems to me that specific silicon revision
differences by conventional is too fine grained for the compatible
field and if really needed can be discovered from the SVR.

I may even drop it in the .26 series.  All device trees in the wild
claim compatibility with both so it won't break any existing boards.

heh; I guess that's just a long winded way to say make sure
fsl,mpc5200-mdio is in there so it remains possible to drop
mpc5200b-mdio in the future.

>  +                       reg = <3000 400>;       // fec range, since we need to setup fec interrupts
>  +                       interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
>  +                       interrupt-parent = <&mpc5200_pic>;
>  +
>  +                       phy0:ethernet-phy@0 {
>  +                               device_type = "ethernet-phy";
>  +                               reg = <0>;
>  +                       };
>                 };
>
>                 i2c@3d40 {
>  +               #address-cells = <1>;
>  +               #size-cells = <0>;

inconsistent indentation?

>                         compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
>                         reg = <3d40 40>;
>                         interrupts = <2 10 0>;
>  @@ -231,4 +250,22 @@
>                         reg = <8000 4000>;
>                 };
>         };
>  +
>  +       lpb {
>  +               model = "fsl,lpb";
>  +               compatible = "fsl,lpb";
>  +               #address-cells = <2>;
>  +               #size-cells = <1>;
>  +               ranges = <0 0 fc000000 2000000>;
>  +
>  +               // 16-bit flash device at LocalPlus Bus CS0
>  +               flash@0,0 {
>  +                       compatible = "cfi-flash";
>  +                       reg = <0 0 2000000>;
>  +                       bank-width = <2>;
>  +                       device-width = <2>;
>  +                       #size-cells = <1>;
>  +                       #address-cells = <1>;
>  +               };
>  +       };
>   };
>  diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
>  index 76951ab..9ca81ff 100644
>  --- a/arch/powerpc/boot/dts/motionpro.dts
>  +++ b/arch/powerpc/boot/dts/motionpro.dts
>  @@ -127,6 +127,13 @@
>                         interrupt-parent = <&mpc5200_pic>;
>                 };
>
>  +               mscan@900 {
>  +                       compatible = "mpc5200b-mscan\0mpc5200-mscan";

"mpc5200b-mscan", "mpc5200-mscan";   The '\0' is depreciated.

>  +                       interrupts = <2 11 0>;
>  +                       interrupt-parent = <&mpc5200_pic>;
>  +                       reg = <900 80>;
>  +               };
>  +
>                 mscan@980 {
>                         compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
>                         interrupts = <2 12 0>;
>  @@ -148,7 +155,6 @@
>                         interrupt-parent = <&mpc5200_pic>;
>                 };
>
>  -
>                 spi@f00 {
>                         compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
>                         reg = <f00 20>;
>  @@ -164,6 +170,7 @@
>                 };
>
>                 dma-controller@1200 {
>  +                       device_type = "dma-controller";
>                         compatible = "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
>                         reg = <1200 80>;
>                         interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
>  @@ -209,10 +216,26 @@
>                 ethernet@3000 {
>                         device_type = "network";
>                         compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
>  -                       reg = <3000 800>;
>  +                       reg = <3000 400>;
>                         local-mac-address = [ 00 00 00 00 00 00 ];
>                         interrupts = <2 5 0>;
>                         interrupt-parent = <&mpc5200_pic>;
>  +                       phy-handle = <&phy0>;
>  +               };
>  +
>  +               mdio@3000 {
>  +                       #address-cells = <1>;
>  +                       #size-cells = <0>;
>  +                       device_type = "mdio";

Drop device type

>  +                       compatible = "fsl,mpc5200b-mdio";

Same here; should include fsl,mpc5200-mdio

>  +                       reg = <3000 400>;       // fec range, since we need to setup fec interrupts
>  +                       interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
>  +                       interrupt-parent = <&mpc5200_pic>;
>  +
>  +                       phy0:ethernet-phy@0 {
>  +                               device_type = "ethernet-phy";
>  +                               reg = <2>;
>  +                       };
>                 };
>
>                 ata@3a00 {
>  @@ -223,11 +246,19 @@
>                 };
>
>                 i2c@3d40 {
>  +                       #address-cells = <1>;
>  +                       #size-cells = <0>;
>                         compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
>                         reg = <3d40 40>;
>                         interrupts = <2 10 0>;
>                         interrupt-parent = <&mpc5200_pic>;
>                         fsl5200-clocking;
>  +
>  +                       rtc@68 {
>  +                               device_type = "rtc";
>  +                               compatible = "dallas,ds1339";
>  +                               reg = <68>;
>  +                       };
>                 };
>
>                 sram@8000 {
>  @@ -240,7 +271,8 @@
>                 compatible = "fsl,lpb";
>                 #address-cells = <2>;
>                 #size-cells = <1>;
>  -               ranges = <1 0 50000000 00010000
>  +               ranges = <0 0 ff000000 01000000
>  +                         1 0 50000000 00010000
>                           2 0 50010000 00010000
>                           3 0 50020000 00010000>;
>
>  @@ -271,31 +303,15 @@
>                         compatible = "promess,pro_module_dio";
>                         reg = <3 800 2>;
>                 };
>  -       };
>
>  -       pci@f0000d00 {
>  -               #interrupt-cells = <1>;
>  -               #size-cells = <2>;
>  -               #address-cells = <3>;
>  -               device_type = "pci";
>  -               compatible = "fsl,mpc5200b-pci","fsl,mpc5200-pci";
>  -               reg = <f0000d00 100>;
>  -               interrupt-map-mask = <f800 0 0 7>;
>  -               interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
>  -                                c000 0 0 2 &mpc5200_pic 1 1 3
>  -                                c000 0 0 3 &mpc5200_pic 1 2 3
>  -                                c000 0 0 4 &mpc5200_pic 1 3 3
>  -
>  -                                c800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
>  -                                c800 0 0 2 &mpc5200_pic 1 2 3
>  -                                c800 0 0 3 &mpc5200_pic 1 3 3
>  -                                c800 0 0 4 &mpc5200_pic 0 0 3>;
>  -               clock-frequency = <0>; // From boot loader
>  -               interrupts = <2 8 0 2 9 0 2 a 0>;
>  -               interrupt-parent = <&mpc5200_pic>;
>  -               bus-range = <0 0>;
>  -               ranges = <42000000 0 80000000 80000000 0 20000000
>  -                         02000000 0 a0000000 a0000000 0 10000000
>  -                         01000000 0 00000000 b0000000 0 01000000>;
>  +               // 16-bit flash device at LocalPlus Bus CS0
>  +               flash@0,0 {
>  +                       compatible = "cfi-flash";
>  +                       reg = <0 0 01000000>;
>  +                       bank-width = <2>;
>  +                       device-width = <2>;
>  +                       #size-cells = <1>;
>  +                       #address-cells = <1>;
>  +               };
>         };
>   };
>  diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tqm5200.dts
>  index c86464f..bbac984 100644
>  --- a/arch/powerpc/boot/dts/tqm5200.dts
>  +++ b/arch/powerpc/boot/dts/tqm5200.dts
>  @@ -83,6 +83,7 @@
>                 };
>
>                 dma-controller@1200 {
>  +                       device_type = "dma-controller";
>                         compatible = "fsl,mpc5200-bestcomm";
>                         reg = <1200 80>;
>                         interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
>  @@ -127,10 +128,26 @@
>                 ethernet@3000 {
>                         device_type = "network";
>                         compatible = "fsl,mpc5200-fec";
>  -                       reg = <3000 800>;
>  +                       reg = <3000 400>;
>                         local-mac-address = [ 00 00 00 00 00 00 ];
>                         interrupts = <2 5 0>;
>                         interrupt-parent = <&mpc5200_pic>;
>  +                       phy-handle = <&phy0>;
>  +               };
>  +
>  +               mdio@3000 {
>  +                       #address-cells = <1>;
>  +                       #size-cells = <0>;
>  +                       device_type = "mdio";

ditto

>  +                       compatible = "fsl,mpc5200b-mdio";

ditto

>  +                       reg = <3000 400>;       // fec range, since we need to setup fec interrupts
>  +                       interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
>  +                       interrupt-parent = <&mpc5200_pic>;
>  +
>  +                       phy0:ethernet-phy@0 {
>  +                               device_type = "ethernet-phy";
>  +                               reg = <0>;
>  +                       };
>                 };
>
>                 ata@3a00 {
>  @@ -141,11 +158,19 @@
>                 };
>
>                 i2c@3d40 {
>  +                       #address-cells = <1>;
>  +                       #size-cells = <0>;
>                         compatible = "fsl,mpc5200-i2c","fsl-i2c";
>                         reg = <3d40 40>;
>                         interrupts = <2 10 0>;
>                         interrupt-parent = <&mpc5200_pic>;
>                         fsl5200-clocking;
>  +
>  +                        rtc@68 {
>  +                               device_type = "rtc";
>  +                               compatible = "dallas,ds1307";
>  +                               reg = <68>;
>  +                       };
>                 };
>
>                 sram@8000 {
>  @@ -154,6 +179,23 @@
>                 };
>         };
>
>  +       lpb {
>  +               model = "fsl,lpb";
>  +               compatible = "fsl,lpb";
>  +               #address-cells = <2>;
>  +               #size-cells = <1>;
>  +               ranges = <0 0 fc000000 02000000>;
>  +
>  +               flash@0,0 {
>  +                       compatible = "cfi-flash";
>  +                       reg = <0 0 02000000>;
>  +                       bank-width = <4>;
>  +                       device-width = <2>;
>  +                       #size-cells = <1>;
>  +                       #address-cells = <1>;
>  +               };
>  +       };
>  +
>         pci@f0000d00 {
>                 #interrupt-cells = <1>;
>                 #size-cells = <2>;
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
