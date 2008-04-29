Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id 1F7B4DDF0F
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 11:58:27 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so9622anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 18:58:26 -0700 (PDT)
Message-ID: <fa686aa40804281858r6b2a1f9eva16983d0a3680fc0@mail.gmail.com>
Date: Mon, 28 Apr 2008 19:58:26 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sean MacLennan" <smaclennan@pikatech.com>
Subject: Re: [RESEND][PATCH 2/2][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
In-Reply-To: <20080428215029.0e38a0d2@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080428214711.240419c3@lappy.seanm.ca>
	<20080428215029.0e38a0d2@lappy.seanm.ca>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2008 at 7:50 PM, Sean MacLennan <smaclennan@pikatech.com> wrote:
> diff --git a/arch/powerpc/boot/dts/warp.dts b/arch/powerpc/boot/dts/warp.dts
>  index b04a52e..3e95e99 100644

You still need to have *some* kind of change log and a signed-off-by
line in this patch.  :-)

There is one minor change that needs to be added below; otherwise:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

(You can add my acked-by line to the next version of this patch if
you're only changing the thing I comment on).

Josh, when he respins it I think the dts changes are ready to be picked up.

>  @@ -186,18 +179,45 @@
>                         GPIO1: gpio@ef600c00 {
>                                 compatible = "ibm,gpio-440ep";
>                                 reg = <ef600c00 48>;
>  +                               #gpio-cells = <2>;
>  +                               gpio-controller;
>  +
>  +                               led@31 {
>
> +                                       compatible = "linux,gpio-led";
>  +                                       linux,name = ":green:";
>  +                                       gpios = <&GPIO1 31>;

Since #gpio-cells is '2'; the gpios property needs to reflect that.
It should be:

gpios = <&GPIO1 31 0>;

The second cell the GPIO controller would use for flags (inverted,
open-drain, etc).

>  +                               };
>  +
>  +                               led@30 {
>  +                                       compatible = "linux,gpio-led";
>  +                                       linux,name = ":red:";
>  +                                       gpios = <&GPIO1 30>;

ditto

>  +                               };
>
>
>                         };
>

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
