Message-ID: <3B39E532.7040202@humboldt.co.uk>
Date: Wed, 27 Jun 2001 14:52:50 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-commit@ppcbk.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: rearrangements in linuxppc_2_4_devel
References: <15161.33091.788459.48900@cargo.ozlabs.ibm.com>	<3B39C8AA.5000605@humboldt.co.uk> <15161.54515.559935.629883@cargo.ozlabs.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------060600010201050303010000"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060600010201050303010000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Paul Mackerras wrote:

> Adrian Cox writes:
>>APUS is probably broken, because it believes that it can call
>>parse_bootinfo with a pointer to the boot records. From apus_setup.c:
> APUS uses the m68k bootinfo format anyway, which ours is gratuitously
> different from.  The apus booter probably does pass the address in a
> register, which would actually be the sensible thing to do. :)


Looking at the makefile, APUS links with setup.c. So it's going to link
with our standard parse_bootinfo, which doesn't take any arguments. I
suspect APUS needs a bit more work to integrate it into the 2_4_devel tree.


>>Paul: would you take patches that moved some of this stuff into header
>>files, and if so, which header file would you like all the miscellaneous
>>setup functions to move into?


> Ummm, it would depend which functions you're talking about.  There is
> certainly an argument for having a couple more .h files in
> arch/ppc/kernel to declare functions that are used only in
> arch/ppc/kernel/*.c.


That's what I'm thinking of - I just want to cut down the number of
extern declarations in the C files in arch/ppc/kernel.

Candidate functions include things like xmon functions, and various
platform specific functions on the platforms I'm interested in. In some
cases we have declarations in header files, so I may remove the
duplication. I've been doing this since I started working on machine
check, as I found clashing uses of bad_page_fault(), fixed by the
attached patch.

--
Adrian Cox   http://www.humboldt.co.uk/

--------------060600010201050303010000
Content-Type: text/plain;
 name="badpage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="badpage.patch"

===== arch/ppc/kernel/traps.c 1.14 vs edited =====
--- 1.14/arch/ppc/kernel/traps.c	Fri Jun 15 05:11:42 2001
+++ edited/arch/ppc/kernel/traps.c	Wed Jun 27 14:46:32 2001
@@ -40,7 +40,6 @@
 #include <asm/processor.h>

 extern int fix_alignment(struct pt_regs *);
-extern void bad_page_fault(struct pt_regs *, unsigned long);

 #ifdef CONFIG_XMON
 extern void xmon(struct pt_regs *regs);
@@ -317,7 +316,7 @@
 		if (user_mode(regs))
 			force_sig(SIGSEGV, current);
 		else
-			bad_page_fault(regs, regs->dar);
+			bad_page_fault(regs, regs->dar, SIGSEGV);
 		return;
 	}
 	_exception(SIGBUS, regs);

--------------060600010201050303010000--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
