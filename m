Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.248])
	by ozlabs.org (Postfix) with ESMTP id BE796DE08B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 08:27:57 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so1110200hsz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:27:55 -0700 (PDT)
Message-ID: <fa686aa40803201427r2a756fd9v54f88b6e95a20aab@mail.gmail.com>
Date: Thu, 20 Mar 2008 15:27:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Bartlomiej Sieka" <tur@semihalf.com>
Subject: Re: Oops with TQM5200 on TQM5200
In-Reply-To: <47E28E15.2070809@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47E2723D.1090101@grandegger.com> <47E281B6.20702@denx.de>
	<47E28E15.2070809@semihalf.com>
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2008 at 10:17 AM, Bartlomiej Sieka <tur@semihalf.com> wrote:
> Anatolij Gustschin wrote:
>  > Hello Wolfgang,
>  >
>  > Wolfgang Grandegger wrote:
>  >
>  >> I just tried Linux 2.6.25-rc6 on my TQM5200 module and got the attached
>  >> oops. Are there any known patches fixing the problems?
>  >
>  > try the patch below for tqm5200.dts, rebuild dtb and boot
>  > again. Not sure if it works for Linux 2.6.25-rc6, but for
>  > 2.6.25-rc3 it does.
>
>  It helps 2.6.25-rc6 too - thanks Anatolij.
>
>
>  >
>  > Anatolij
>  > --
>  > diff --git a/arch/powerpc/boot/dts/tqm5200.dts
>  > b/arch/powerpc/boot/dts/tqm5200.dts
>  > index c86464f..7c23bb3 100644
>  > --- a/arch/powerpc/boot/dts/tqm5200.dts
>  > +++ b/arch/powerpc/boot/dts/tqm5200.dts
>  > @@ -83,6 +83,7 @@
>  >         };
>  >
>  >         dma-controller@1200 {
>  > +            device_type = "dma-controller";
>
>  This actually fixes the Oops.

Hmm, this sounds like a band-aid; the kernel shouldn't oops if this is
missing from the device tree.  Fail, perhaps, but oops is worrisome.
Would someone like to investigate?

In fact, device_type should not be necessary at all, but that's beside
the point.

>  > @@ -127,10 +128,25 @@
>  >         ethernet@3000 {
>  >             device_type = "network";
>  >             compatible = "fsl,mpc5200-fec";
>  > -            reg = <3000 800>;
>  > +            reg = <3000 400>;
>  >             local-mac-address = [ 00 00 00 00 00 00 ];
>  >             interrupts = <2 5 0>;
>  >             interrupt-parent = <&mpc5200_pic>;
>  > +            phy-handle = <&phy0>;
>  > +        };
>  > +
>  > +        mdio@3000 {
>  > +            #address-cells = <1>;
>  > +            #size-cells = <0>;
>  > +            compatible = "fsl,mpc5200b-mdio";
>  > +            reg = <3000 400>;       // fec range, since we need to
>  > setup fec interrupts
>  > +            interrupts = <2 5 0>;   // these are for "mii command
>  > finished", not link changes & co.
>  > +            interrupt-parent = <&mpc5200_pic>;
>  > +
>  > +            phy0:ethernet-phy@0 {
>  > +                device_type = "ethernet-phy";
>  > +                reg = <0>;
>  > +            };
>
>  And this fixes networking issues (NFS-mounted rootfs timeouts, etc).
>  BTW: it's been posted a while back
>  (http://patchwork.ozlabs.org/linuxppc/patch?q=Balakowicz&id=16197) but
>  didn't get merged.
>
>  Grant -- any chances these fixes could be rushed upstream?

Nuts, I dropped it on the floor.  I'll pick this up.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
