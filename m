Message-Id: <00Jul6.121427adt.7305@dragon.appliedmicro.ns.ca>
From: Frank Smith <smith@amirix.com>
MIME-Version: 1.0
To: Pete Buechler <peterb@suse.com>
CC: Ruedi.Hofer@ascom.ch, linuxppc-embedded@lists.linuxppc.org,
        distribution@linux01.hasler.ascom.ch
Subject: Re: newlib, uclib
References: <0FXA0055X023NC@pmdf-it.hasler.ascom.ch> <00070608033801.21103@CX579290-B>
Content-Type: text/plain; charset=us-ascii
Date: Thu, 6 Jul 2000 12:14:19 -0300
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pete Buechler wrote:

>
> Another option is to identify the C library functions that you are actually
> using and remove the others from the archive. That would be rather tough by
> hand. Lineo has a closed source tool called "Lipo" which will do that for you -
> there may be a free replacement in the works somewhere.

The Debian boot-floppies package has a script that does this sort of
thing,
I believe. Don't know how well it performs as compared to lipo-suction.

Excerpt from 'boot-floppies/scripts/rootdisk/mklibs.sh':

# Introduction:
# When creating boot floppies, there is never enough room on the disks.
# So it is important not to waste bytes on unnecessary code.
# Shared Libraries contain many functions that are probably not used in
the
# binaries included in the boot disks, and copying the whole library is
a
# waste of space.
# This utilitiy helps to reduce the necessary libraries to only include
the
# symbols needed to run a given set of executables.
#
# Features:
# * Automatic detection of all necessary libraries, even for
inter-library
#   dependencies, for a given set of executables.
# * Automatic installation of all needed libraries and soname links.
# * Automatic reduction of all libraries to minimal size for which PIC
#   libraries are provided.
#
# Requirements:
# * Beside the shared libraries, you need libfoo_pic.a files for all
#   libraries you want to reduce.
# * You need binutils (notably objdump and objcopy) installed.


Frank.


--
Frank Smith, MCompSci
Principal Software Designer      frank.smith@amirix.com
AMIRIX Systems Inc.              http://www.amirix.com/
Embedded Debian Project          http://www.emdebian.org/
77 Chain Lake Drive              902-450-1700 x289 (Phone)
Halifax, N.S. B3S 1E1            902-450-1704 (FAX)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
