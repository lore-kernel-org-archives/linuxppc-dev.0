From: Peter Bergner <bergner@brule.borg.umn.edu>
Date: Fri, 21 Sep 2001 14:40:50 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: hollis@austin.ibm.com,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org,
	Debian PowerPC <debian-powerpc@lists.debian.org>, dan@debian.org
Subject: Re: yaboot & zImage's
Message-ID: <20010921144050.A223060@brule.borg.umn.edu>
References: <20010920150939.32251@smtp.adsl.oleane.com> <20010920152246.B14835@plato.local.lan> <20010921114951.A211936@brule.borg.umn.edu> <20010921112047.B23691@cpe-24-221-152-185.az.sprintbbd.net> <20010921132904.C17347@austin.ibm.com> <20010921113329.C23691@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010921113329.C23691@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry, I should have been a little more explicit.  Yes, I meant to
say zImage (including zImage.initrd, duh).  No, yaboot does not
do compression.

The only reason we couldn't boot zImages before, was that yaboot
_always_ loaded the image from the FS into memory at KERNELADDR.
This is what vmlinux wants/expects.  OTOH, zImage (or any other
program) expects to be loaded into memory where it was linked at.
The code now detects if we're loading a vmlinux or not.  If it's a
vmlinux, then yaboot loads the image at KERNELADDR, otherwise it
loads it at the p_vaddr value for each ELF segment.

To detect if we're loading a vmlinux, we look at the e_entry value and
if it is equal to 0xC0000000 for ELF32 or 0xC000000000000000 for ELF64,
then we _assume_ it's a vmlinux.


Peter

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
