Message-Id: <9905280028.AA27888@marc.watson.ibm.com>
To: Tom Rini <tmrini@ntplx.net>
Cc: Brad Midgley <brad@turbolinux.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: new OF: how can we use it? 
In-Reply-To: Message from Tom Rini <tmrini@ntplx.net>
   of "Thu, 27 May 1999 15:39:49 EDT." <Pine.LNX.4.05.9905271537330.30048-100000@pc.wackyland.com>
Date: Thu, 27 May 1999 20:28:38 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	I presume that vger's mknote does all of the following, but the
special details that CHRP requires are:

A standard ELF-format PowerPC program
	e_ident = \7FELF (first byte is hex 7F)
	e_ident[EI_CLASS] = 1
	e_type = 2
	e_machine = 20 (PowerPC)
	e_version = 1
	e_flags = 0

A "note" section which looks like:

	.section .note
	.align 4
	/* length of PowerPC string */
	.long 8
	/* length of note descriptor */
	.long 24
	/* code for PowerPC open firmware */
	.long 0x1275
	/* PowerPC string */
	.asciz "PowerPC"
	/* real-mode true=-1 false=0 */
	.long -1
	/* real base of OF (do not care / use defaults = -1) */
	.long -1
	/* real size of OF (do not care / use defaults = -1) */
	.long -1
	/* virtual base of OF (ignored in real-mode) */
	.long -1
	/* virtual size of OF (ignored in real-mode) */
	.long -1
	/* load base of program (example real mode 0x4000) */
	.long 0x4000

One needs to ensure that the loaded program base does not specify a
location which overwrites Open Firmware itself.

	The ELF header must contain a PT_NOTE segment table entry pointing
to the note section as well as PT_LOAD segment table entries pointing to
the actual program image.  The GNU linker for PowerPC probably does not
create a PT_NOTE segment in the loader header although it does include the
.note section in the image.

	If all is correct, OF transfers control to the image entry point
with the five OF parameters including the OF client services entry point
in r5 (third parameter).

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
