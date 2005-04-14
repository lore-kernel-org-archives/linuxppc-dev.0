Return-Path: <jakob.viketoft@bitsim.se>
Received: from amsfep20-int.chello.nl (amsfep20-int.chello.nl [213.46.243.18])
	by ozlabs.org (Postfix) with ESMTP id A5CFD67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 19:47:20 +1000 (EST)
Message-ID: <425E3DC6.7030007@bitsim.se>
Date: Thu, 14 Apr 2005 11:54:14 +0200
From: Jakob Viketoft <jakob.viketoft@bitsim.se>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
References: <424ACFF1.5000403@bitsim.se>	
	<111d2ae873d1bfee413409dfc4f2f064@freescale.com>	
	<424BEDFC.8080300@jonmasters.org>	
	<1112284541.23088.77.camel@cashmere.sps.mot.com>	
	<4250EACF.1040403@bitsim.se> <42511D55.4040507@ru.mvista.com>	
	<20050407172003.GP3396@smtp.west.cox.net>	
	<1112895351.11987.89.camel@cashmere.sps.mot.com>	
	<20050407174936.GR3396@smtp.west.cox.net>
	<1113235114.9846.11.camel@cashmere.sps.mot.com>
In-Reply-To: <1113235114.9846.11.camel@cashmere.sps.mot.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jon Masters <jonathan@jonmasters.org>, Tom Rini <trini@kernel.crashing.org>,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Flat OF Device Tree for ppc32 [was: Platform bus/ppc
	sys	model...]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Has any more happened on this off-list, or it is just in testing-mode 
right now?

I applied the changes to a 2.6.12-rc2 tree (with some minor rejects to 
sort out) and it compiles and boots fine on my Memec FF1152 board with 
the Virtex-II Pro chip (Xilinx ML300 config).

A couple of small changes to be able to use the simple boot-loader is below.

Cheers!

	/Jakob

diff -ruN org-nobd-linux-2.6.12-rc2/arch/ppc/boot/simple/embed_config.c 
nobd-linux-2.6.12-rc2/arch/ppc/boot/simple/embed_config.c
--- org-nobd-linux-2.6.12-rc2/arch/ppc/boot/simple/embed_config.c 
2005-04-04 18:38:03.000000000 +0200
+++ nobd-linux-2.6.12-rc2/arch/ppc/boot/simple/embed_config.c 
2005-04-14 11:36:49.000000000 +0200
@@ -23,6 +23,8 @@
  #endif
  extern unsigned long timebase_period_ns;

+#include <syslib/fw_bdt.h>
+
  /* For those boards that don't provide one.
  */
  #if !defined(CONFIG_MBX)
@@ -776,8 +778,7 @@
         bd->bi_intfreq = XPAR_CORE_CLOCK_FREQ_HZ;
         bd->bi_busfreq = XPAR_PLB_CLOCK_FREQ_HZ;
         bd->bi_pci_busfreq = XPAR_PCI_0_CLOCK_FREQ_HZ;
-       timebase_period_ns = 1000000000 / bd->bi_tbfreq;
-       /* see bi_tbfreq definition in 
arch/ppc/platforms/4xx/xilinx_ml300.h */
+       timebase_period_ns = 1000000000 / bd->bi_intfreq;
  }
  #endif /* CONFIG_XILINX_ML300 */

diff -ruN org-nobd-linux-2.6.12-rc2/arch/ppc/boot/simple/misc-embedded.c 
nobd-linux-2.6.12-rc2/arch/ppc/boot/simple/misc-embedded.c
--- org-nobd-linux-2.6.12-rc2/arch/ppc/boot/simple/misc-embedded.c 
2005-04-04 18:38:04.000000000 +0200
+++ nobd-linux-2.6.12-rc2/arch/ppc/boot/simple/misc-embedded.c 
2005-04-14 10:22:38.000000000 +0200
@@ -22,6 +22,7 @@
  #endif

  #include "nonstdio.h"
+#include <syslib/fw_bdt.h>

  /* The linker tells us where the image is. */
  extern char __image_begin, __image_end;


Jon Loeliger wrote:
> On Thu, 2005-04-07 at 12:49, Tom Rini wrote:
> 
> 
>>Please post to the list as an RFC.  Thanks.
> 
> 
> Folks,
> 
> Apologies to those who have received this notice twice.
> I first sent it to the list where it was summarily
> denied for size reasons.
> 
> I have now posted a tgz file here instead:
> 
>     http://www.jdl.com/bdt_cleanup.tgz
> 
> What follows is my original email content.
> 
> 
> OK, for those keeping score over on the U-Boot list, _this_
> message is really intended to be sent to the public list. :-)
> 
> Here (as noted above) are my diffs against a clone of
>     http://linux.bkbits.net/linux-2.6
> as last pulled a couple days ago. (*)
> 
> Please consider this a Request For Comments for now.  Feel free
> to apply it and test it out as well, of course. :-)  I'll sign-off
> on it when it has ripened some more and gets a nod or two...
> 
> These changes relocate almost all of the ppcboot.h definitions
> into new files, arc/ppc/syslib/fw_bdt.[ch] and front them
> with a new, shim interface in include/asm-ppc/firmware.h.
> 
> There is a Kconfig option that allows you to select between
> a "bd_t" interface and a non-existant "OF Flat dev tree"
> interface.  Choose wisely (default) for now.  It adds the
> new fw_bdt.o file.
> 
> Some potential gotchas or points to note:
> 
> - As of this patch, no interface to any board should change.
>   This just isolates the scattered bd_t references to one place.
> 
> - On Kumar's advice arch/ppc/boot/simple was totally ignored.
>   For now; this round.  It can be next on the hit parade easily.
>   It holds the last reference to ppcboot.h still.
> 
> - Earlier cut-n-paste of some devices led to me changing a few
>   files over in 68k land to remove some now-obsolete ppcboot.h
>   related comments justs for completeness.
> 
> - I've compiled uImage using defconfigs for the following boards:
> 
>         8560_ads        cpci690         ash             redwood5
>         8540_ads        ads_8272        TQM8260         est8260
>         rpx8260         bseip           mbx             mpc834x_sys
>         ocotea          lite5200        hdpu            lopec
>         TQM860L         rpxlite         radstone_ppc7d  walnut
> 
> - The file include/asm-ppc/ppcboot.h used to contain a nested
>   include of linux/types.h that was tacitly used by many files.
>   In ripping ppcboot.h out of many platform .h files, I've had
>   to add direct #include <linux/types.h> in several places.
>   If your board isn't listed above and it looks really broken,
>   consider if it needs a <linux/types.h>?
> 
> 
> Enjoy,
> jdl
> 
> --
> (*) -- BK is dead.  Long live BK!
> 
