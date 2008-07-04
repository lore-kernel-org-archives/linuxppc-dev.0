Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id CD70DDDE0A
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 03:27:41 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so558219ywh.39
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Jul 2008 10:27:40 -0700 (PDT)
Message-ID: <9e4733910807041027v5a75b50ao248d3c2848f99630@mail.gmail.com>
Date: Fri, 4 Jul 2008 13:27:39 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Add MPC5200B base board mvBC-P
In-Reply-To: <20080704170041.GD17062@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <486E515B.80508@matrix-vision.de>
	<20080704170041.GD17062@secretlab.ca>
Cc: Andre Schwarz <andre.schwarz@matrix-vision.de>,
	linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/4/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, Jul 04, 2008 at 06:35:39PM +0200, Andre Schwarz wrote:
>  > +             #address-cells = <2>;
>  > +             #size-cells = <1>;
>  > +             ranges = <0x0 0x0 0xff800000 0x00800000>;
>  > +             flash@0,0 {
>  > +                     compatible = "cfi-flash";
>
>  For completeness, it is good practice for the first entry in the compatible
>  list to be the actual flash chip, followed by "cfi-flash"
>
>  > +                     reg = <0 0 0x800000>;
>  > +                     #address-cells = <1>;
>  > +                     #size-cells = <1>;
>  > +                     bank-width = <1>;
>  > +                     device-width = <1>;
>  > +                     nor_total@0x0 {
>  > +                             reg = <0x0 0x800000>;
>  > +                     };
>
>  I don't know if this is legal; to have overlapping flash sections (but
>  I'm not a cfi-flash binding expert).
>
>  > +                     u-boot@0x0 {
>  > +                             reg = <0x0 0x40000>;
>  > +                     };
>  > +                     u-boot_autoscript@0x40000 {
>  > +                             reg = <0x40000 0x10000>;
>  > +                     };
>  > +                     u-boot_autoscript_red@0x50000 {
>  > +                             reg = <0x50000 0x10000>;
>  > +                     };
>  > +                     fpga@0x60000 {
>  > +                             reg = <0x60000 0x40000>;
>  > +                     };
>  > +                     user@0xa0000 {
>  > +                             reg = <0xa00000 0x60000>;
>  > +                     };
>  > +                     rfs@0x100000 {
>  > +                             reg = <0x100000 0x300000>;
>  > +                     };
>  > +                     kernel@0x400000 {
>  > +                             reg = <0x400000 0x3c0000>;
>  > +                     };
>  > +                     dtb@0x7c0000 {
>  > +                             reg = <0x7c0000 0x10000>;
>  > +                     };
>  > +                     dtb@0x7d0000 {
>  > +                             reg = <0x7d0000 0x10000>;
>  > +                     };
>  > +                     ppcboot_env@0x7e0000 {
>  > +                             reg = <0x7e0000 0x10000>;
>  > +                     };
>  > +                     ppcboot_env@0x7f0000 {
>  > +                             reg = <0x7f0000 0x10000>;
>  > +                     };
>
>  I think it would be better to just leave out the partition information
>  and modify U-Boot to fill them in (just like memory and clock speed are
>  left out).  Things like flash partitions are less like hardware
>  description and more like configuration data.

Has anyone tried writing a RedBoot type partition table onto their
flash device? If it is there the kernel will read the partition info
from it. It's a config option in the kernel flash support section. Is
there a utility for creating these tables?

-- 
Jon Smirl
jonsmirl@gmail.com
