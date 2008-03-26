Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 946C2DDF8D
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 07:35:26 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so28618anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 13:35:24 -0700 (PDT)
Message-ID: <fa686aa40803261335q2b8af09cw6f05dc0cf905d0b5@mail.gmail.com>
Date: Wed, 26 Mar 2008 14:35:24 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Bartlomiej Sieka" <tur@semihalf.com>
Subject: Re: [RESEND][POWERPC] mpc5200: Amalgamated dts fixes and updates
In-Reply-To: <20080326194526.GA17424@frozen.semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47E2723D.1090101@grandegger.com> <47E281B6.20702@denx.de>
	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>
	<47E2FC3E.1020705@semihalf.com>
	<fa686aa40803201720l3e42c983se121ebc257c89912@mail.gmail.com>
	<20080321235633.GB345@frozen.semihalf.com>
	<fa686aa40803212014ne560615sfcdef542d59eb6cb@mail.gmail.com>
	<20080326194526.GA17424@frozen.semihalf.com>
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

On Wed, Mar 26, 2008 at 1:45 PM, Bartlomiej Sieka <tur@semihalf.com> wrote:
>     The bulk of this patch is taken from
>     http://patchwork.ozlabs.org/linuxppc/patch?q=Balakowicz&id=16197, with few
>     other updates.
>
>     Signed-off-by: Marian Balakowicz <m8@semihalf.com>
>  ---
>  Addressed comments from the list; would appreciate picking up as the patch
>  fixes booting issue on TQM5200 and Motion-PRO (cm5200 changes are analogous,
>  but not tested due to hardware unavailability).

I see one obvious error; but other than that it looks good.  Once that
is fixed I can recommend for Paul to pick it up for .25.  It's just
dts changes, so I don't expect it to be a problem.

Cheers,
g.

>  diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
>  index 76951ab..f27256b 100644
>  --- a/arch/powerpc/boot/dts/motionpro.dts
>  +++ b/arch/powerpc/boot/dts/motionpro.dts
>  @@ -209,10 +208,25 @@
>  +               mdio@3000 {
>  +                       #address-cells = <1>;
>  +                       #size-cells = <0>;
>  +                       compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
>  +                       reg = <3000 400>;       // fec range, since we need to setup fec interrupts
>  +                       interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
>  +                       interrupt-parent = <&mpc5200_pic>;
>  +
>  +                       phy0:ethernet-phy@0 {
>  +                               device_type = "ethernet-phy";
>  +                               reg = <2>;

This doesn't look right.  Reg should match the value in "ethernet-phy@0"


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
