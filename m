Date: Thu, 22 Jul 2004 08:00:01 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: random ramblings on 8xx patches (long and tedious :-)
Message-ID: <Pine.LNX.4.60.0407220638390.3652@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   i'd like to clarify a number of things regarding potential 8xx
patches, ask some questions, make some observations, etc.  (poor
wolfgang has already seen much of this via private e-mail so i expect
he'll skim it, if that.  i'm still working thru his replies so i'll be
repeating some of the stuff i already sent him.)

What's a "patch"?
-----------------

   from the mpc850 family user's manual, i have the parameter RAM
memory map table (USB, I2C, SCC2, SPI, and so on), and it's clear that
a major purpose of patching is to relocate some of these areas
elsewhere in DPRAM by patching the microcode (did i phrase that
correctly?)  in our case, we need to relocate SMC1 so we can use SCC3
for ethernet, and we already have that working under an ancient 2.4.22
kernel so, yes, we've succesfully applied a patch.

   does that completely cover the definition of a patch?  an array of
hex values to be written to, say, 2000, or 2f00 (or elsewhere)?  and
strictly for the purposes of parameter relocation?  if not, what else
would fall under the definition of "patch" that should be available to
the developer?

How many potential patches are there?
-------------------------------------

   currently, in the latest bk pull, there is only one patch selection
option: "I2C/SPI Microcode Patch".  but clearly there are other
choices.  even though that's the only selection listed in the config
menu, if you look at micropatch.c, there's mention of an SMC patch
(which you can apparently get only by editing the file, not by just
selecting an option).  there's also reference to a USB SOF patch.
why wouldn't these also be listed in the kernel config menu?  it seems
misleading to display a choice for only a single patch when, in fact,
there are *clearly* others (specifically, SMC1 relocation to use SCC3
for ethernet which is the one we need although, admittedly, that's
kind of specialized).

   rather than that single selection in the "MPC8xx CPM Options", it
would make far more sense to have *all* patches listed as subentries
under a patch menu, like:

   MPC8xx CPM Patches -->

akin to top-level config menu entries like:

   Device drivers -->
   File systems -->

and so on, with mutually-exclusive patches deactivating one another as
they're selected.  to present the user with a single I2C/SPI patch
option is just silly.

What's the limit on patches?
----------------------------

   again, based on my reading, it seems clear that you can apply only a
limited number of patches, as each patch appears to require a certain
number of "traps" in micropatch.c  for example, if you want to apply
the SMC patch, there's this excerpt in micropatch.c:

 	/* Enable the traps to get to it. */

         commproc->cp_cpmcr1 = 0x8080;
         commproc->cp_cpmcr2 = 0x808a;
         commproc->cp_cpmcr3 = 0x8028;
         commproc->cp_cpmcr4 = 0x802a;

similarly, if you want the IIC patch:

 	/* Enable the traps to get to it. */

         commproc->cp_cpmcr1 = 0x802a;
         commproc->cp_cpmcr2 = 0x8028;
         commproc->cp_cpmcr3 = 0x802e;
         commproc->cp_cpmcr4 = 0x802c;

which suggests that not only are the SMC and IIC patches mutually
exclusive, once you pick either one, you're finished in terms of
applying other patches.  is that accurate?

   (interestingly, there's nothing in micropatch.c that forces those
two patches to be mutually exclusive.  since IIC occurs further down
in the file, it would apparently override the earlier SMC patch.  not
good.)

   and what about the USB patch?  at first glance, it doesn't appear to
require any traps, but it does set "commproc->cp_rccr", so does that
make it mutually exclusive with IIC and SMC patches?

   in short, it would be useful to know:

   * what's the definition of a patch?
   * what are the list of possible patches?
   * what are the resources required for a patch to be applied, and
     what are the consequences for patch co-existence?

The I2C/SPI patch
-----------------

   perhaps showing my unbounded ignorance but, given that the parameter
RAM memory map table shows different addresses for I2C and SPI,
respectively, is it feasible to relocate one and not the other?  why
does all the literature i read insist on referring to the *combined*
I2C/SPI patch?  just curious.  would there be any value in relocating
just one and, if you could, would that cost only two traps, leaving
open the possibility of another patch?

The USB SOF patch
-----------------

   apparently, the onboard USB on the 850 is somewhat flaky, which is
why the USB SOF patch isn't even selectable in micropatch.c, is that
it?  note the excerpt from micropatch.c

#ifdef CONFIG_USB_MPC8xx
#define USE_USB_SOF_PATCH
#endif

   a recursive grep shows that there's nothing in the entire kernel
source tree that even defines CONFIG_USB_MPC8xx, so that patch is
pretty well a non-issue.

   (side note:  apparently, up to rev. b of the processor had this
problem.  we are using rev. c which allegedly has fixed the problem,
but rev. c is not widely available.  in any case, it might still be
nice to re-activate the potential US patch, albeit with a warning
that, unless you have rev. c, you're taking your chances.  just a
thought.)

Patch dependencies on selected features
---------------------------------------

   is it reasonable for selectable patches to depend on the underlying
features having already been selected?  for example, should you only
be allowed to apply the USB patch if you selected basic USB support in
the first place?  should you only be presented with the I2C patch if
you've selected I2C support?  at the moment, even if you don't pick
I2C support in the kernel, you can still apply the I2C/SPI patch.
does this make sense?  should the kernel config files be more rigorous
in terms of dependencies?

   (in our case, i can see being presented with a patch to relocate
SMC1 for SCC3 ethernet, but only if networking was selected to begin
with.  otherwise, what's the point?)

Patch menu entries -- policy versus implementation
--------------------------------------------------

   if one comes up with a more organized (read: sane) menu for patch
selection, it might be useful for newbies (read: me) if the text that
was presented didn't refer to implementation, but rather to policy.

   for instance, it didn't mean anything to me to be asked whether i
wanted to apply the I2C/SPI patch, since i had no clue what the heck
that meant.  what *would* have made sense is for the menu entry to
have explained what the effect would have been.

   as an example, consider two menu entries:

   [ ] SMC patch                                         (bad)
   [ ] Move SMC1 to free up SCC3 for Ethernet            (good)

even a complete noob like me would at least have understood what that
second choice was telling me.

Processor-dependent patches
---------------------------

   perhaps overly ambitious, but it would be *really* cool if the
patches presented to the developer were tied to the underlying
processor.  that is, once you've selected, say, RPXlite, the only
patches displayed in the menu should be those relevant to the rpxlite.
admittedly, this might be a bit much, but it seems that there should
be some kinds of safeguards that stop you from applying patches that
are hideously inappropriate for your selected platform (with, perhaps,
the possibility of overriding those safeguards).

   anyway, as i said, that's pretty ambitious.

"Help"
------

   yes, much more "Help" info during the kernel config process. lots of
help.  buckets of help.  no excuse for "There is no help available for
this option."  (unless it really is a stunningly obvious option, but
keep in mind that one man's "stunningly obvious" is another man's
"what the hell?").

   thoughts?  i'm willing to help with menu reorg -- my only
contribution to the 2.6 kernel was to thoroughly restructure the
"Filesystems" menu.  which means i like it, and i don't care what
*you* think. ;-)

rday


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
