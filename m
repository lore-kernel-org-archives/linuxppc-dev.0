Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 1A3602BDB3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 06:11:31 +1000 (EST)
Received: from [10.1.1.107] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-dev@ozlabs.org; 20 Sep 2004 16:11:26 -0400
Date: Mon, 20 Sep 2004 16:05:09 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Message-ID: <Pine.LNX.4.60.0409201531570.5653@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: thoughts and questions on 8xx patches
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


   based on my reading the source (and, in this case, 
arch/ppc/8xx_io/micropatch.c), i have a number of 
questions/observations on the whole ugly area of microcode patches, so 
i saved them all up and i'll ask them all at once.

   as a quick intro, the RISC Controller Config Register (RCCR) is 
what determines which regions of DPRAM can contain executable 
microcode.  according to the MPC850 manual, there are four 
possibilities for the ucode settings in that register (bits 14-15):

   00: no microcode execution
   01: 512 bytes at 0x2000, 256 bytes at 0x2f00
   10: 1K at 0x2000, 256 bytes at 0x2f00
   11: 2K at 0x2000, 512 bytes at 0x2e00

1) am i to assume that the two chunks of microcode written to these
    two different addresses are run independently?  and that it's
    *always* the case that, if there is any microcode at all, there
    will *always* be exactly two segments at the selected addresses?
    (that is, it's not possible to just write a patch to the first
    address and leave it at that.  or is it?  the docs don't make
    this clear.)

remaining questions deal with micropatch.c

2) in cpm_load_patch(), before writing microcode into dpmem, the
    RCCR register is set to disable microcode:

    commproc->cp_rccr = 0;

    and is reactivated later.  is this necessary while you're
    installing ucode?

3) next, in micropatch.c, microcode is directly copied from the
    patch arrays patch_2000[] and patch_2f00[] into the respective
    addresses in dpmem.  but who's to say that these arrays are
    always guaranteed to exist?  notice above that there could very
    well exist a patch that writes to 2000 and 2e00 instead.  it
    seems like a bad idea to just flat-out assume that those two
    arrays will always exist, unless there's something more subtle
    happening here that i missed.

4) if the USB SOF patch is being applied, i notice that the RCCR
    register is reset with the value 0x0009, which not only sets
    the microcode address sizes, but sets the RCCR bit for EIE --
    external interrupt enable.  i'm not even going to ask what that
    does, but it will come up later.  i'm just going to accept it as
    magic and move on.

5) if you've defined either SMC PATCH or IIC PATCH, then this
    routine defines the relocation base for the IIC and SPI structs:

    #define RPBASE 0x0400

    this is an error since, from above in that file, the size of the
    SMC/IIC/SPI patch is not 1024 bytes, but 1280, which means that
    the patch will clash with those relocated structures at offset
    0x0400.  redefine RPBASE to 0x0500 to fix this.

6) if you're applying the SMC patch, notice that this routine will
    also apply the patch array patch_2e00[].  now, how exactly does
    that co-operate with the patch_2f00[] array that has *already* been
    installed?  the 2e00 patch is awfully short, and *that's* the ucode
    that's going to be run.  what happens with the stuff that was
    installed at offset 0x2f00 earlier?  will it be run as well?  how?

7) finally, the function verify_patch() clearly does just that --
    verifies the patch contents.  at the top, it disables ucode
    execution (again, why?) with:

    commproc->cp_rccr = 0;

    but at the bottom, it resets the RCCR register with:

    commproc->cp_rccr = 0x0009;

    huh?  i'm pretty sure that's a bad idea, given that the restored
    value should reflect what was in that register before, rather
    than just hardcoding it to 0x0009.  this is fine if you're
    verifying the USB SOF patch, but it's not so good if you're
    verifying any other kind of patch.

    thoughts?

rday
