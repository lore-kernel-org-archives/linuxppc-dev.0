Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 926B62BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Oct 2004 05:36:58 +1000 (EST)
Received: from [10.1.1.102] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-embedded@ozlabs.org; 6 Oct 2004 15:36:47 -0400
Date: Wed, 6 Oct 2004 15:30:01 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.LNX.4.60.0410061425100.13510@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: more (unanswered) questions on microcode patches
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


   and since i'm pretty sure i haven't beaten this subject bloody yet, 
and while i wait -- patiently -- for my patch to be applied, some 
questions to clarify still-mysterious issues related to ucode patches 
so i can make further enhancements.  i've asked some of these before 
and i still haven't got an unambiguous answer.


1) is there any value to the source file arch/ppc/8xx_io/uart.c 
anymore?  i was under the impression that the code to implement UARTs 
now lives in drivers/serial/cpm_uart/.  if that's the case, that file, 
and all references to it in other files (Makefile, Kconfig) should be 
deleted.  (i can add those deletions to a subsequent patch if it's 
appropriate.)

(as it is, i'm not selecting "Use UART" from the "MPC8xx CPM Options" 
menu, but i still have my console on SMC1 working just fine.)


2) as it stands now, the file for applying ucode patches 
(micropatch.c) just flat out assumes that *all* conceivable patches 
will be represented at least by arrays to be copied to offsets at 
0x2000 and 0x2f00.  this strikes me as dangerous since you can set the 
RCCR register to specify that the patch locations in DPMEM can be 
0x2000 and 0x2e00 instead.  if there's ever a patch that involves 
loading patch code at those addresses instead, micropatch.c will blow 
up, looking for an array named "patch_2f00" that doesn't exist.

any thoughts on this?  (the function verify_patch() has the same 
potential problem -- it flat out assumes that there will always exist 
arrays named "patch_2000" and "patch_2f00", and will not bother to 
verify any other patch array, like "patch_2e00".  since no one even 
calls this function, it's not like it's a problem.  but, if no one 
calls it, what's it doing there?  in any case, it's pretty clearly 
wrong.

3) and, still on the topic of verify_patch() in micropatch.c, i'm 
still bothered that, at the top, rccr <- 0 (good), and is then 
explicitly set back to 0x0009 at the bottom, which just *can't* be 
right.  it would seem that what you want is to save rccr at the top, 
and *restore* it at the bottom.  again, since no one calls this 
function, it's not like this is going to hurt, but that code has just 
*got* to be wrong.

basically, that verify_patch() function is pretty much junk.

   there's more, but i'd settle for clarification of the above for now.

rday
