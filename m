Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 3153BDDF9D
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 01:16:23 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1787226wag
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Oct 2007 08:16:22 -0700 (PDT)
Message-ID: <fa686aa40710080816l6ce52da7t6ced519915ec705d@mail.gmail.com>
Date: Mon, 8 Oct 2007 09:16:22 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 07/15] [POWERPC] Promess Motion-PRO DTS
In-Reply-To: <20071008145823.GA4289@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47075FA7.3030108@semihalf.com> <4708C22D.5060805@semihalf.com>
	<20071008145823.GA4289@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey Scott.

Pretty much all your comments below directly apply to the existing
Lite5200 device tree and the Efika firmware.  These are issues that
were created a while ago and I've never gone back to clean up the
mpc5200 device tree bindings.  (Plus we need to have code to maintian
compatibility with the Efika firmware.

g.

On 10/8/07, Scott Wood <scottwood@freescale.com> wrote:
> On Sun, Oct 07, 2007 at 01:25:33PM +0200, Marian Balakowicz wrote:
> > +             gpt@600 {       // General Purpose Timer
> > +                     compatible = "mpc5200b-gpt\0mpc5200-gpt";
> > +                     device_type = "gpt";
>
> "timer" would be a better node name than "gpt", and the device type should be
> left out entirely.  As others pointed out, compatible should be
> "fsl,mpc5200b-gpt", "fsl,mpc5200-gpt".
>
> > +                     has-wdt;
>
> fsl,has-wdt
>
> > +             rtc@800 {       // Real time clock
> > +                     compatible = "mpc5200b-rtc\0mpc5200-rtc";
> > +                     device_type = "rtc";
>
> This doesn't actually implement the OF rtc interface...
>
> > +             mscan@980 {
>
> What is mscan?
>
> > +                     device_type = "mscan";
>
> This is not a standard device type.
>
> > +             bestcomm@1200 {
> > +                     device_type = "dma-controller";
>
> dma-controller should be the node name, and device_type should be omitted.
>
> > +             ethernet@3000 {
> > +                     device_type = "network";
> > +                     compatible = "mpc5200b-fec\0mpc5200-fec";
> > +                     reg = <3000 800>;
> > +                     mac-address = [ 02 03 04 05 06 07 ]; // Bad!
>
> Should be local-mac-address.
> And yes, hardcoding a mac address is bad.  Don't do it. :-)
>
> > +             i2c@3d40 {
> > +                     device_type = "i2c";
> > +                     compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
> > +                     cell-index = <1>;
>
> What is cell-index?  The fsl-i2c driver doesn't use it AFAICT.
>
> > +             sram@8000 {
> > +                     device_type = "sram";
>
> No device type.
>
> > +     cpld {
> > +             device_type = "cpld";
> > +             compatible = "cpld";
> > +             reg = <50010000 ffff>;
> > +     };
>
> This device is compatible with every CPLD that has ever existed?  Wow! :-)
>
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
