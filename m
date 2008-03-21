Return-Path: <tur@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 540FBDDEF6
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 11:08:37 +1100 (EST)
Message-ID: <47E2FC3E.1020705@semihalf.com>
Date: Fri, 21 Mar 2008 01:07:26 +0100
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Oops with TQM5200 on TQM5200
References: <47E2723D.1090101@grandegger.com> <47E281B6.20702@denx.de>
	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>
In-Reply-To: <fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> Paul, my git server is down at the moment.  Can you please pick this
> one up for .25?  It is needed to boot the tqm5200 board.

Could we also have similar fixes for cm5200.dts and motionpro.dts picked
up? I could provide the patches within a day -- will this be OK?

Regards,
Bartlomiej

> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Cheers,
> g.
> 
> On Thu, Mar 20, 2008 at 9:24 AM, Anatolij Gustschin <agust@denx.de> wrote:
>> Hello Wolfgang,
>>
>>
>>  Wolfgang Grandegger wrote:
>>
>>  > I just tried Linux 2.6.25-rc6 on my TQM5200 module and got the attached
>>  > oops. Are there any known patches fixing the problems?
>>
>>  try the patch below for tqm5200.dts, rebuild dtb and boot
>>  again. Not sure if it works for Linux 2.6.25-rc6, but for
>>  2.6.25-rc3 it does.
>>
>>  Anatolij
>>  --
>>   diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tqm5200.dts
>>  index c86464f..7c23bb3 100644
>>  --- a/arch/powerpc/boot/dts/tqm5200.dts
>>  +++ b/arch/powerpc/boot/dts/tqm5200.dts
>>  @@ -83,6 +83,7 @@
>>                 };
>>
>>                 dma-controller@1200 {
>>  +                       device_type = "dma-controller";
>>                         compatible = "fsl,mpc5200-bestcomm";
>>                         reg = <1200 80>;
>>                         interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
>>  @@ -127,10 +128,25 @@
>>                 ethernet@3000 {
>>                         device_type = "network";
>>                         compatible = "fsl,mpc5200-fec";
>>  -                       reg = <3000 800>;
>>  +                       reg = <3000 400>;
>>                         local-mac-address = [ 00 00 00 00 00 00 ];
>>                         interrupts = <2 5 0>;
>>                         interrupt-parent = <&mpc5200_pic>;
>>  +                       phy-handle = <&phy0>;
>>  +               };
>>  +
>>  +               mdio@3000 {
>>  +                       #address-cells = <1>;
>>  +                       #size-cells = <0>;
>>  +                       compatible = "fsl,mpc5200b-mdio";
>>  +                       reg = <3000 400>;       // fec range, since we need to setup fec interrupts
>>  +                       interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
>>  +                       interrupt-parent = <&mpc5200_pic>;
>>  +
>>  +                       phy0:ethernet-phy@0 {
>>  +                               device_type = "ethernet-phy";
>>  +                               reg = <0>;
>>  +                       };
>>                 };
>>
>>                 ata@3a00 {
