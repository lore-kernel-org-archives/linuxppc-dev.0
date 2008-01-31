Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id CF1AADDDE9
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 13:40:29 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so127345anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 18:40:28 -0800 (PST)
Message-ID: <fa686aa40801301840k3d9a9ba2n251d2cdb9e659748@mail.gmail.com>
Date: Wed, 30 Jan 2008 19:40:28 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [RFC] [POWERPC] bootwrapper: build multiple cuImages
In-Reply-To: <20080131014952.83827290071@mail95-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080131003347.5779.96112.stgit@trillian.secretlab.ca>
	<20080131014952.83827290071@mail95-dub.bigfish.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/30/08, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>
> I like the spirit...  It does seem like the compiled in device tree is
> specified in the wrong place.

heh, thanks.  :-)

> > +zImage.mpc866ads: vmlinux $(wrapperbits) $(dtstree)/mpc866ads.dts
> > +     $(call if_changed,wrap,$*,$(dtstree)/mpc866ads.dts)
> > +zImage.initrd.mpc866ads: vmlinux $(wrapperbits)
> $(dtstree)/mpc866ads.dts
> > +     $(call
> if_changed,wrap,$*,$(dtstree)/mpc866ads.dts,,$(obj)/ramdisk.image.gz)
> > +
> > +zImage.mpc885ads: vmlinux $(wrapperbits) $(dtstree)/mpc885ads.dts
> > +     $(call if_changed,wrap,$*,$(dtstree)/mpc885ads.dts)
> > +zImage.initrd.mpc885ads: vmlinux $(wrapperbits)
> $(dtstree)/mpc885ads.dts
> > +     $(call
> if_changed,wrap,$*,$(dtstree)/mpc885ads.dts,,$(obj)/ramdisk.image.gz)
> > +
> > +zImage.ep88xc: vmlinux $(wrapperbits) $(dtstree)/ep88xc.dts
> > +     $(call if_changed,wrap,$*,$(dtstree)/ep88xc.dts)
> > +zImage.initrd.ep88xc: vmlinux $(wrapperbits) $(dtstree)/ep88xc.dts
> > +     $(call
> if_changed,wrap,$*,$(dtstree)/ep88xc.dts,,$(obj)/ramdisk.image.gz)
>
> It seems like all you've done here is expand out the $(obj)/zImage.%
> rule?, but now the $* has nothing to match to?  I don't think this
> works.

Oops, that's a mistake.  $* should have been replaced.

>
> How about just:
> $(obj)/zImage.initrd.%: vmlinux $(wrapperbits) %.dts
>         $(call if_changed,wrap,$*,$*.dts,,$(obj)/ramdisk.image.gz)

mpc866ads, mpc885ads and ep88xc are oddities in that they build
zImages with embedded device tree blobs.  Most zImages don't do that
and zImage* is an overloaded target.  Only the three boards above have
.dts files that should be included.  Doing it this way matches the
method used for the ps3 zImages.

Consider for instance when zImage.chrp is built.  With the rule above,
the wrapper would go looking for chrp.dts and fail when it couldn't
find it.  The old rule works because dts is set to nothing if
CONFIG_DEVICE_TREE is not set and the wrapper just passes over the dts
processing commands.

I could change the wrapper to just skip dts files that don't exist,
but I don't think that is the right behavior either.  Then you'll have
inconsistent behavior when files are present/absent and there are
cases (like the three boards above) where we *want* the wrapper to
fail if the dts file is missing.

One option would be to add two new targets: zImage.dtb.% and
zImage.initrd.dtb.%, but I'm not sure if it is a good idea.

>
> Which would handle the default case of platform code for each dts.
>
> Then for cases where you have a multiplatform target, you'd have
> something like
> $(obj)/zImage.initrd.virtex.%: vmlinux $(wrapperbits) %.dts
>         $(call if_changed,wrap,virtex,$*.dts,,$(obj)/ramdisk.image.gz)

cuImage is already an example of exactly this, except for the mapping
between cuImage-*.c and .dts files.  Also, I think the '.virtex' in
the above example is superfluous.  The .dts file itself discribes the
platform as a virtex platform.

However, specifically for the virtex, we still need something like:
zImage.raw.% or elfImage.%.  (I'd like to avoid overloading zImage
even more, so 'elfImage' or something like it is probably the better
choice).

> > diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> > index 763a0c4..b70ec6a 100755
> > --- a/arch/powerpc/boot/wrapper
> > +++ b/arch/powerpc/boot/wrapper
> > @@ -158,6 +158,26 @@ miboot|uboot)
> >  cuboot*)
> >      binary=y
> >      gzip=
> > +    case "$platform" in
> > +    *-mpc885ads|*-adder875*|*-ep88xc)
> > +        platformo=$object/cuboot-8xx.o
> > +        ;;
> > +    *5200*|*-motionpro)
> > +        platformo=$object/cuboot-52xx.o
> > +        ;;
> > +    *-pq2fads|*-ep8248e|*-mpc8272*)
> > +        platformo=$object/cuboot-pq2.o
> > +        ;;
> > +    *-mpc824*)
> > +        platformo=$object/cuboot-824x.o
> > +        ;;
> > +    *-mpc83*)
> > +        platformo=$object/cuboot-83xx.o
> > +        ;;
> > +    *-mpc85*)
> > +        platformo=$object/cuboot-85xx.o
> > +        ;;
> > +    esac
> >      ;;
> >  ps3)
> >      platformo="$object/ps3-head.o $object/ps3-hvcall.o $object/ps3.o"
>
> I'm not particularly fond of making the wrapper smarter...  It seems
> like the wrapper should be stupid and the logic about what to include
> done in the Makefile or in Kconfig.  Also, it seems like a strange place
> to explicitly encode the dependency between the name of the dts file and
> the platform code.

No; I'm not totally sold on this approach either, but there is already
precedence in the wrapper and I can't think of a cleaner or easier
place to map dts files to cuboot-* objects.

Thanks for the comments

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
