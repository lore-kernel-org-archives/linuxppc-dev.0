Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 8976B2BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 04:02:11 +1000 (EST)
Date: Fri, 8 Oct 2004 11:02:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20041008180209.GD14773@smtp.west.cox.net>
References: <Pine.LNX.4.60.0410080704170.6219@dell.enoriver.com>
	<20041008164047.GC14773@smtp.west.cox.net>
	<944792EE-194E-11D9-9299-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <944792EE-194E-11D9-9299-003065F9B7DC@embeddededge.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cleaning up the Kconfig menu structure -- the bigger picture
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 08, 2004 at 01:22:06PM -0400, Dan Malek wrote:

> 
> On Oct 8, 2004, at 12:40 PM, Tom Rini wrote:
> 
> >Which is where every other serial driver is (that's been updated to use
> >the new serial core and make life easier).
> 
> How does this make life easier?

I wasn't clear.  drivers/serial/ makes the life of serial driver writers
easier as all of the stuff people kept c&p'ing from
drivers/char/serial.c is common, and so on.

Having the serial choice in drivers/serial/Kconfig is easier on folks
migrating from other platforms since it's where they would expect it
(since that's where all of the other serial drivers are).  It's
hopefully nothing for people who've done 8xx on 2.4 compared to all of
the other stuff changed in 2.6, but it isn't making life easier for
them.

> >That's kinda the opposite direction of where I want things to move.
> 
> That doesn't make sense to those of us with experience using all
> of the 8xx/82xx/85xx variants, other processors that may use the
> same peripherals (like ColdFire), or with knowledge of yet to be
> announce parts.

I'll agree it's a change, but this is how everyone else works.  For
example, it might make sense to rename platforms/85xx to platforms/cpm2,
and that's where (making up examples) cpm2 microcode updates, errata
config options, enable foolevel/type cache options could go, while
drivers live under drivers/.

IMHO, the biggest reason someone outside the ppc32 community hasn't
yelled about arch/ppc/{8xx,82xx}_io/ is that it wasn't called
arch/ppc/drivers/{8xx,82xx} :)

> >What, IMHO, should happen is that once the real drivers side of 8xx_io
> >are moved out into drivers/ we'll really be left with commproc and
> >microcode, both of which can live in arch/ppc/syslib/ as cpm1_common.c
> 
> That's irrelevant to keeping the menu options in a central place.
> Maybe it's because I'm old, but keeping the CPM configuration options
> in one place on the screen seems to make it easier to think and choose
> the proper options.  Remember, there is lots more to the CPM than just
> serial ports or Ethernet drivers.  There are drivers floating around 
> that
> for some mysterious reason never seem to make it into the Linus tree
> or out of development trees into other "official" place.

But they too should live with with their drivers/ (or net/)
counter-parts, even if they aren't in Linus' tree.

> >....... and we can deal with microcode
> >questions in arch/ppc/Kconfig where we now source the 8xx_io/Kconfig
> >file ....
> 
> There is never any harm in separating logical functions into separate
> files.  Using this argument I guess you would like the whole kernel
> to just be one big Linux.c file? :-)

Fine, arch/ppc/Kconfig.cpm1 if we don't have platforms/8xx/ :)

> > (or, if it really does end up making sense to, and I'm not yet
> >convinced of this, make platforms/8xx, we can put the question in
> >platforms/8xx/Kconfig).
> 
> I don't know why we don't have the platforms/8xx directory.  We already
> have 4xx and 85xx, there are certainly more 8xx boards and 
> configurations
> than anything else (if all of the 2.4 stuff was actually moved 
> forward).

Yes.  But 8xx isn't board.[ch] and mpc<cpu_variant>.[ch], it's
m8xx_setup.c + board.h.  If we can work it out into being more like
85xx and 4xx, that would convince me :)

> Both
> of the 4xx and 85xx have special IO configuration options even though
> they have drivers in the standard places.  Your desire of "where you 
> want
> 8xx to move" is against what has been established for other processors,
> and of course doesn't make sense to me.

But that's what I just described.  Letting the special config options
(I don't know if I'd call 85xx_PCI2 "I/O", but it is special) live in
platforms/8xx/Kconfig (or ppc/Kconfig.cpm1, or whatever).

-- 
Tom Rini
http://gate.crashing.org/~trini/
