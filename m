Date: Mon, 1 Nov 1999 13:20:01 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Subject: ASM-PPC Include File Rework Proposal: Processor / Board Header Files
In-Reply-To: <Pine.LNX.4.04.9910281311170.30195-100000@www.linuxppc.org>
Message-ID: <Pine.SGI.4.10.9911011256160.155416-100000@brule.lcse.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


As more PowerPC processor variants get added and as more board types are
supported by the stock Linux/PPC distribution the current state of affairs
in the asm-ppc directory is going to get a little unruly.

The real ugliness comes with the large number of ifdef's sprinkled all
over the place. As I add in the 4xx stuff, it's going to only get worse.

I'd like to propose a solution, the first is a new file and the second is
a change to processor.h.

Dan has a nice solution to board-specific information with the mpc8xx.h
file and it's associated files (rpxlite.h, mbx.h, etc.). I'd like to go
one further and define a new file "board.h". Any other C file or other
include file which needs board-specific (NOT processor specific)
information includes board.h and ONLY board.h. Based on the configuration
stuff, board.h then pulls in the more specific files. For example:


#ifndef __BOARD_H__
#define	__BOARD_H__

#if defined(CONFIG_RPXLITE)
#include <asm/rpxlite.h>
#endif

#if defined(CONFIG_OAK)
#include <asm/oak.h>
#endif

#if defined(CONFIG_WALNUT)
#include <asm/walnut.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif



#ifdef __cplusplus
}
#endif

#endif /* __BOARD_H__ */

Also, processor.h has a smattering of all sorts of information. Some of it
processor related, some of it board related, and almost all of it specific
to the 6xx/7xx processor cores. I'd like to define several new files,
which include information of varying levels of generality:

	ppc.h - Included by anyone needed basic PowerPC processor stuff
	        (this would be included by processor.h).

	6xx.h - 6xx core-generic stuff
	603.h - 603-specific stuff
	604.h - 604-specific stuff
	7xx.h - 7xx core-generic stuff (it's really a 603+604, so it might
                include 6xx, 603, and 604 as well).
	750.h - 740/750-specific stuff
	8xx.h - 8xx core-generic stuff
	821.h - 821-specific stuff
	823.h - "
	850.h - "
	855.h - "
	860.h - "
	4xx.h - 4xx core-generic stuff
	403.h - 403 core-generic stuff
	403gcx.h - 403GCX-specific stuff
	405gp.h - 405GP-specific stuff

Maybe the right thing to do is have board.h reference some board-specific
file and then that file in turn pulls in the right processor files for
that particular board. I'm open to suggestions and debate on the subject.

I'm got all of the above processor files implemented in my build tree and
working for 6xx and 8xx builds. In addition, the stuff that's in
processor.h is defined on stuff in the processor-specific files for
compatibility. For example:

/* Special Purpose Registers */

/*
 * Most of these are already defined in "ppc.h" and other processor-specific
 * header files are contained here for code compatibility. NOTE: Just because
 * they are defined here does NOT mean they are guaranteed to exist in all
 * PowerPC implementations.
 */

#define CTR     SPRN_CTR        /* Counter Register */
#define DAR     SPRN_DAR        /* Data Address Register */
#define DABR    SPRN_DABR       /* Data Address Breakpoint Register */
#define DBAT0L  SPRN_DBAT0L     /* Data BAT 0 Lower Register */
#define DBAT0U  SPRN_DBAT0U     /* Data BAT 0 Upper Register */
#define DBAT1L  SPRN_DBAT1L     /* Data BAT 1 Lower Register */
#define DBAT1U  SPRN_DBAT1U     /* Data BAT 1 Upper Register */


 Grant M. Erickson                           University of Minnesota  
  o mail:grant@lcse.umn.edu                               1996 BSEE
  o http://www.tc.umn.edu/nlhome/g496/eric0139/           1998 MSEE


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
