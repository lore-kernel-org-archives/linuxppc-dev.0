Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 869252BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Sep 2004 00:41:53 +1000 (EST)
Date: Sat, 25 Sep 2004 10:35:22 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20040925134431.77E73C108D@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0409251007320.4085@dell.enoriver.com>
References: <20040925134431.77E73C108D@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] to support choice of 8xx microcode patch 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 25 Sep 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0409250834090.3738@dell.enoriver.com> you wrote:
>>
>>    yes, this is a *full* and apparently working source code patch that
>
> For which CPU types did you test it?

mine.  850DE, and that's it.  i've verified that my board works with:

   a) no patch applied
   b) IIC/SPI/SMC1 patch applied, and no networking
   c) IIC/SPI/SMC1 patch applied, with ethernet on SCC3

> Where do you select which CPU type gets used, and adjust for the 
> corresponding version of the uCode patch?

   i don't, but that's not the point.  this kernel source patch is 
based on the code in the latest "bk pull" so, while it clearly has 
deficiencies, they're no more than the deficiencies that *already* 
*exist* in the source tree.  (i.e., i don't break anything that's not 
already broken. :-)

   i'm not claiming that this is the perfect solution to ucode patches. 
what i'm claiming is that it's a *better* approach than what's already 
there, which requires folks to hack the source files to define the 
appropriate macros.  in short, you lose *nothing* in the way of 
functionality compared to what's currently there, and you gain in the 
way of improved flexibility and usage.  if you're going to say, "well, 
that patch doesn't let me do X", i'm going to reply, "you can't do X 
at the moment, anyway, so you can't complain."  (what the patch *does* 
do, i believe, is allow functionality to be added much more easily 
than the current situation.)

   anyway, some observations/questions about the current state of 
things re: ucode patches (some of which is definite ugliness and 
redundancy in the code).  (and, BTW, i want to give credit to torsten 
demke, who sent me the basic patch to do the SMC1/SCC3 co-existence.)

1) obviously, the "#warning"s i put into various files can be removed
    later.


   related to arch/ppc/8xx_io/Kconfig:


2) the new structure of Kconfig makes it trivial to add/remove/change
    the selectable patches.


   related to arch/ppc/8xx_io/micropatch.c:


3) rather than having all the patch arrays lumped together in
    micropatch.c, i would prefer to see them as they are in the DENX
    source tree -- broken into separate files, one of which, of course,
    would be conditionally included based on the selected patch.  this
    would obviously be a trivial change.

4) regarding the functions cpm_load_patch() and verify_patch(), i have
    no idea why they're conditionally defined in micropatch.c, since
    that file isn't even part of the build unless a patch is selected,
    based on the "Makefile" in that directory.  kind of redundant.

5) i'm not even sure what verify_patch() is doing there, since
    no one else in the entire kernel source tree calls it.  but what
    the heck, i just left it there.

6) i'm *extremely* nervous about the first part of cpm_load_patch(),
    which just *assumes* that any patch will *always* incorporate both
    a patch_2000[] and patch_2f00[] array.  i don't see why this has to
    be true.  theoretically, a patch can consist of a patch_2000[] and
    a patch_2e00[] array, no?  certainly, that's a possibility based on
    the possible settings in commproc->cp_rccr, and i don't recall
    anyone clearing up that issue.

    rather than try to get clever by having this common code at the
    top of cpm_load_patch() to save lines, i'd prefer to break out each
    patch processing all by itself, just to make things clearer.  so
    what if you duplicate a few lines?  it's cleaner.

7) note that, if you relocate SMC1, you need to increase RPBASE based
    on the size of that patch's patch_2000[] array, from 0x400 to
    0x500.  any reason not to make that a constant change regardless?
    no big deal, just asking.

8) some definite redundancy currently in micropatch.c -- the code:

         iip->iic_rpbase = RPBASE;

         /* Put SPI above the IIC, also 32-byte aligned.
         */
         i = (RPBASE + sizeof(iic_t) + 31) & ~31;
         spp = (spi_t *)&commproc->cp_dparam[PROFF_SPI];
         spp->spi_rpbase = i;

    appears in two different places in cpm_load_patch().  sure seems
    unnecessary, but i left it in just in case.

9) if verify_patch() is going to stay there, can someone explain why
    it deactivates the patch selection bits at the top:

        commproc->cp_rccr = 0;

    and then hardcodes that value back at the bottom, regardless of
    what it was in the first place?

         commproc->cp_rccr = 0x0009;

    i can't believe that's correct, but i left it as is since no one
    calls it anyway.

thoughts?  as you can see, there's plenty of stuff that can be 
clarified/cleaned up/thrown away.

rday
