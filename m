Date: Sat, 13 Feb 1999 05:23:26 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Bootstrap code with egcs
Message-Id: <19990213052326.032488@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

I'm in the process of improving the way BootX boots and adding support
for NuBus PowerMacs. However, I need to write some PPC bootstrap code
that will take control before the kernel is actually entered. Part of it
is PPC asm, but I want some C code too.

The Mac-hosted tools I have (CodeWarrior and MrC) can only, to my
knowledge, produce PEF (or XCOFF), so the boostrap code needs a complex
relocation before beeing entered, and I have to handle a TOC which is not
what I want in this boostrap.

I was wondering what kind of options are available with egcs for
generating code that is suitable for bootstraps, if possible, relocatable
code (datas are PC relative).

The bootstrap will be entered with both data and instructions MMUs
disabled, so the logical-physical mapping will be 1:1. The boostreap
itself will be made contiguous and resident somewhere in this physical
memory by BootX along with some memory for a small stack, and eventually
some datas. It will be passed a map of the physical RAM, a map of the
kernel pages (scattered in memory) and will take care of putting the
kernel pages back contiguously in physical mem before entering the kernel.

I'm not very experienced with egcs, ELF format, etc... so some details
about how I can generate an easy-to-relocate code (I can use a RELOC
macro all the time like prom.c does if fixed link address is used) and
how I must parse the resulting ELF (I beleive the way I parse the kernel
header) would help. (By details I mean which tools with which option, I
don't know the gnu toolchain very well).

Thanks in advance !


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
