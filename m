Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 2677B2BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Oct 2004 22:18:02 +1000 (EST)
Received: from [10.1.1.102] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-embedded@ozlabs.org; 17 Oct 2004 08:17:57 -0400
Date: Sun, 17 Oct 2004 08:10:58 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.LNX.4.60.0410170722180.3994@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: one more push to clean up microcode patches
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


  (if you're intensely bored with this whole thread on ucode patches,
just hit 'delete'.  i won't take it personally. :-)

  i'd like to submit one more (probably sizable) patch to clean up the
logistics for ucode patches.  as it stands, the current micropatch.c
file is just plain hideously ugly, being filled with not just the code
for applying every conceivable patch, but the patch arrays themselves.
i'd really like to move the actual array contents out of that file
into separate includable files (a la DENX 2.4 kernel tree, which is
aesthetically far nicer).

  so, to that end, some questions and looking for feedback on how to
do this the cleanest way.

  first, a summary of what seems to be the logic for applying a ucode
patch -- please correct me if i'm wrong:

  1) commproc->cp_rccr = 0 ;
  2) copy patch array(s) to some combination of offsets 0x0, 0x0e00 or
     0x0f00 in DPMEM
  3) possibly some extra work to set relocation pointers, whatever
  4) possibly set some combination of trap values, cp_cpmcr[1234]
  5) reset commproc->cp_rccr to appropriate value

is that about right?  it might be slightly simplified but are the
critical steps there, and are they in the right order?  from the
sample patches i've seen, the above looks about right, at least for
the 8xx (i shudder to think about extending this to other processors,
let's not go there just yet, shall we?)

  now, the current infrastructure.  if you take a look at the Kconfig
file, the config variables that represent ucode patching are:

  UCODE_PATCH		# *some* patch was selected
  NO_UCODE_PATCH	# *no* patch was selected
  I2C_SPI_UCODE_PATCH, etc., etc.
			# one config variable per possible patch

that first config variable, CONFIG_UCODE_PATCH, is used in a couple of
places.  first, in commproc.c:

  #ifdef CONFIG_UCODE_PATCH
        /* Perform a reset.
        */
        commproc->cp_cpcr = (CPM_CR_RST | CPM_CR_FLG);

        /* Wait for it.
        */
        while (commproc->cp_cpcr & CPM_CR_FLG);

        cpm_load_patch(imp);
  #endif

and in Makefile:

  ...
  obj-$(CONFIG_SCC_ENET)  += enet.o
  obj-$(CONFIG_UCODE_PATCH) += micropatch.o     <--
  obj-$(CONFIG_HTDMSOUND) += cs4218_tdm.o

note that this means that, currently, neither of those files cares
about *which* patch was selected, only that *some* patch was selected,
and that it's micropatch.c that has to do all the work of checking the
config variable, applying the appropriate patch array, etc.  (but this
could change.)

first, i'd like to clean up micropatch.c by moving the actual arrays
out of there into separate files, and there's a couple choices for
this.

i could break them off as per-patch .h include files, and just
conditionally include them into micropatch.c depending on the config
variable that's set:

  #ifdef CONFIG_I2C_SPI_UCODE_PATCH
  # include "i2c_spi_patch.h"
  #elif ...

and so on.  but i know some folks freak at the thought of a .h file
containing actual compilable code.  i *could* name them as .c files,
of course, but then the same folks might freak at #include'ing .c
source files.  (personally, i'm not that much of a purist here -- i'd
be quite happy with either of these.)

another option is to simplify the logic in micropatch.c and move the
tests into Makefile itself:

obj-$(CONFIG_UCODE_PATCH) += micropatch.o
obj-$(CONFIG_I2C_SPI_PATCH) += i2c_spi_patch.o
obj-$(CONFIG_USB_SOF_PATCH) += usb_sof_patch.o
... etc etc ...

and i have no problem with that either.  (personally, i'd like to keep
the arch/ppc/8xx_io directory relatively clean, and keep all the patch
files in a subdirectory, say "ucode_patches/" or something like that.)

  once all the actual arrays are moved out of micropatch.c (however
that's done), i'd like to take the patching code that's left and make
it *completely* modular, separate for each patch.  currently, the
cpm_load_patch() routine is being clever and shares common code
between some of the patches.  i'd prefer having each patch have its
own function, even if it means a small amount of code duplication.
trying to get clever and share common code is just begging for
trouble, in my opinion, so i could see a separate function for each
config variable that does all the work.

  note that that would mean that micropatch.c would still have to
process the selected patch config variable, so if it already has to do
that, it might be worth having it include the appropriate patch array
at the same time and leave Makefile alone.

  thoughts?  the whole idea is to not just make the code clearer, but
to make it trivial to add and remove patches as time goes by.  i'm
willing to create the source code patch, i'm just interested in
opinions on which of several ways to do it.

rday
