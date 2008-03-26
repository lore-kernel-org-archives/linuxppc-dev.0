Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6D767DE1FD
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 07:48:13 +1100 (EST)
Message-ID: <47EAB687.5040702@grandegger.com>
Date: Wed, 26 Mar 2008 21:48:07 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RESEND][POWERPC] mpc5200: Amalgamated dts fixes and updates
References: <47E2723D.1090101@grandegger.com>
	<47E281B6.20702@denx.de>	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>	<47E2FC3E.1020705@semihalf.com>	<fa686aa40803201720l3e42c983se121ebc257c89912@mail.gmail.com>	<20080321235633.GB345@frozen.semihalf.com>	<fa686aa40803212014ne560615sfcdef542d59eb6cb@mail.gmail.com>	<20080326194526.GA17424@frozen.semihalf.com>
	<fa686aa40803261335q2b8af09cw6f05dc0cf905d0b5@mail.gmail.com>
In-Reply-To: <fa686aa40803261335q2b8af09cw6f05dc0cf905d0b5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Wed, Mar 26, 2008 at 1:45 PM, Bartlomiej Sieka <tur@semihalf.com> wrote:
>>     The bulk of this patch is taken from
>>     http://patchwork.ozlabs.org/linuxppc/patch?q=Balakowicz&id=16197, with few
>>     other updates.
>>
>>     Signed-off-by: Marian Balakowicz <m8@semihalf.com>
>>  ---
>>  Addressed comments from the list; would appreciate picking up as the patch
>>  fixes booting issue on TQM5200 and Motion-PRO (cm5200 changes are analogous,
>>  but not tested due to hardware unavailability).
> 
> I see one obvious error; but other than that it looks good.  Once that
> is fixed I can recommend for Paul to pick it up for .25.  It's just
> dts changes, so I don't expect it to be a problem.
> 
> Cheers,
> g.
> 
>>  diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
>>  index 76951ab..f27256b 100644
>>  --- a/arch/powerpc/boot/dts/motionpro.dts
>>  +++ b/arch/powerpc/boot/dts/motionpro.dts
>>  @@ -209,10 +208,25 @@
>>  +               mdio@3000 {
>>  +                       #address-cells = <1>;
>>  +                       #size-cells = <0>;
>>  +                       compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
>>  +                       reg = <3000 400>;       // fec range, since we need to setup fec interrupts
>>  +                       interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
>>  +                       interrupt-parent = <&mpc5200_pic>;
>>  +
>>  +                       phy0:ethernet-phy@0 {
>>  +                               device_type = "ethernet-phy";
>>  +                               reg = <2>;
> 
> This doesn't look right.  Reg should match the value in "ethernet-phy@0"

And whats about the two CAN nodes for tqm5200.dts? Do we have them already?

Thanks,

Wolfgang.
