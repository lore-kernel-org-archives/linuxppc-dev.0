From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15161.33091.788459.48900@cargo.ozlabs.ibm.com>
Date: Wed, 27 Jun 2001 16:46:27 +1000 (EST)
To: linuxppc-commit@ppcbk.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: rearrangements in linuxppc_2_4_devel
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just checked in a change into linuxppc_2_4_devel that changes the
way we deal with the large and increasing variety of platforms that
PPC/Linux supports.  The aim with these changes is to reduce the
number of places where we have to change stuff to add support for a
new platform.

When I say "platform" I'm talking about a class of machines that can
all run a single vmlinux binary.  So the CONFIG_ALL_PPC machines count
as a single platform, and each of the choices under the various
'Machine type' questions also count as a platform.

The first change is to make each platform export a procedure called
platform_init.  This is called from machine_init (which used to be
called identify_machine) early on.  So for example I renamed
m8xx_setup to platform_setup.  That removed a whole pile of #ifdefs in
setup.c.

The second change is to make MMU_init call a platform-specific
function to set up any I/O mappings that the platform needs, namely
ppc_md.setup_io_mappings().  This will typically call
io_block_mapping(), which is like setbat except that it will add ptes
instead of setting a BAT if there is no BAT available.  I have moved
the code from MMU_init into the various xxx_setup.c files and made it
call io_block_mapping instead of setbat or ioremap.

That means that ioremap now doesn't need to do virtual = physical
mappings any more AFAICS.  If there are other places where you call
ioremap and you need virtual == physical, please either change the
code so it doesn't assume that or else use io_block_mapping.

The next thing I would like to do, which I haven't done yet, is to
avoid the need to have a separate _MACH_xxx define for each platform.
I would see _machine as distinguishing between different types of
machine that count as a single platform, rather than distinguishing
between platforms.  (We distinguish between platforms by their config
options.)  Thus I don't see any need for anything more than
_MACH_prep, _MACH_Pmac and _MACH_chrp.

With those changes, I think that adding a new platform should only
require adding stuff to arch/ppc/config.in, arch/ppc/kernel/Makefile,
and adding a new xxx_setup.c file.

Comments?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
