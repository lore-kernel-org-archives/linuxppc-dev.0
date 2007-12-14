Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 9E378DDFEA
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 02:23:42 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so328198anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 07:23:41 -0800 (PST)
Message-ID: <fa686aa40712140723y26154baauf28444fa73ca54d9@mail.gmail.com>
Date: Fri, 14 Dec 2007 08:23:41 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Milton Miller" <miltonm@bga.com>
Subject: Re: [PATCH 1/7] bootwrapper: Add a firmware-independent "raw" target.
In-Reply-To: <f7eb0ae3da29213720e6b0049deca335@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071213234221.B0BC27D0054@mail142-sin.bigfish.com>
	<f7eb0ae3da29213720e6b0049deca335@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/14/07, Milton Miller <miltonm@bga.com> wrote:
> On Fri Dec 14 10:43:27 EST 2007,  Stephen Neuendorffer wrote:
>
> > From: Grant Likely <grant.likely at secretlab.ca>
> >
> > This target produces a flat binary rather than an ELF file,
> > fixes the entry point at the beginning of the image, and takes
> > a complete device tree with no fixups needed.
> >
> > The device tree must have labels on /#address-cells, the timebase
> > frequency, and the memory size.
> >
> > Signed-off-by: Grant Likely <grant.likely at secretlab.ca>

For the record; this patch was lifted from my dev tree and in turn I
stole it from Scott Wood.

>
> > +$(obj)/zImage.raw: vmlinux $(dts) $(wrapperbits)
> > +       $(call if_changed,wrap,raw,$(dts))
> >
>
> This should be handled by the standard zImage% rule.

It's weird.  On my system the standard zImage rule wouldn't do this
target.  I had to add this rule just to get it to compile.  I've not
yet been motivated to revisit and fix it.

> I'm not sure exactly what platform you are using this on.  Apparently
> it is a legacy firmware that loads the image and jumps to it leaving
> interrupts on and not invalidating the cache.

Heh; actually it's a platform with *no* firmware.  :-)

It's on a Xilinx FPGA.  SDRAM is initialized by the FPGA design and
the kernel image is loaded either with a debugger, or via the
SystemACE device.  In either case, the kernel is the first thing to
run after reset.... oh, and reset is not as complete as one would
normally expect.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
