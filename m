Date: Fri, 10 Aug 2001 16:17:14 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Michel Lanners <mlan@cpu.lu>
Cc: bob@kunk.jriver.com, debian-powerpc@lists.debian.org,
	LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Compiling EIDE patch on PPC
Message-ID: <20010810161714.E28914@mikef-linux.matchmail.com>
References: <20010807162104.H22821@mikef-linux.matchmail.com> <200108091943.VAA00688@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200108091943.VAA00688@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 09, 2001 at 09:43:41PM +0200, Michel Lanners wrote:
> Hi Mike,
>
> On   7 Aug, this message from Mike Fedyk echoed through cyberspace:
> > I am attempting to compile a 2.2.19 kernel for a promise udma66 ide
> > controller on PPC.
>
> Hm, I have not been using 2.2 kernels for a long time....
>
> > Michel, what else I need to do for a working Promise UDMA66 on PPC?
> >
> > I have applied:
> > 2.2.18-pci.diff
> > ide.2.2.19.05042001.patch.bz2
>
> That should be it.....
>
> > and this patch (from Phil Brutsche <pbrutsch@tux.creighton.edu> on LKML):
> > --- 2.2.19-ide-05042001/drivers/block/ll_rw_blk.c~      Tue Aug  7 15:34:29
> > 2001
> > +++ 2.2.19-ide-05042001/drivers/block/ll_rw_blk.c       Tue Aug  7 15:50:08
> > 2001
> > @@ -25,6 +25,7 @@
> >  #include <linux/blk.h>
> >
> >  #ifdef CONFIG_POWERMAC
> > +#include <linux/ide.h>
> >  #include <asm/ide.h>
> >  #endif
>
> Ah, this problem.... I guess every single kernel file had this problem
> at one time or another.... You can probably remove the #include
> <asm/ide.h>, since <linux/ide.h> includes that itself.
>

OK, I've been able to compile it successfully.  Changes included.

I haven't booted the kernel yet.  Can someone take a look at the patch to
see if I may have made any bad changes?  Maybe the actual files in asm-ppc
should be changed instead?  If it is good, I'll send it to Hedrick for the
next patch release.

Also, there is an include for asm/ide.h in apus_setup.c.  I didn't change it
because I don't have any prep machines for testing, and for some reason it is
also including from the m86k arch.

Michel, I'm going to do another compile with your pci-fixup patch.  Do you
have any idea if it is needed on 7200, 6500, or oldworld g3 powermacs also?

This patch is against 2.2.19 + ide.05042001

The patch is below:
--- 2.2.19-ide-05042001/drivers/block/ide-pmac.c	Fri Aug 10 12:40:07 2001
+++ 2.2.19-ide-05042001-mikef/drivers/block/ide-pmac.c	Fri Aug 10 12:34:47 2001
@@ -28,7 +28,6 @@
 #include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/dbdma.h>
-//	#include <asm/ide.h>
 #include <asm/mediabay.h>
 #include <asm/feature.h>
 #ifdef CONFIG_PMAC_PBOOK
--- 2.2.19-ide-05042001/drivers/block/ide-disk.c	Fri Aug 10 12:40:07 2001
+++ 2.2.19-ide-05042001-mikef/drivers/block/ide-disk.c	Fri Aug 10 12:35:23 2001
@@ -54,7 +54,6 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
-#include <asm/ide.h>

 #ifdef CONFIG_BLK_DEV_PDC4030
 #define IS_PDC4030_DRIVE (HWIF(drive)->chipset == ide_pdc4030)
--- 2.2.19-ide-05042001/drivers/block/ll_rw_blk.c	Fri Aug 10 12:40:07 2001
+++ 2.2.19-ide-05042001-mikef/drivers/block/ll_rw_blk.c	Fri Aug 10 12:35:57 2001
@@ -25,7 +25,7 @@
 #include <linux/blk.h>

 #ifdef CONFIG_POWERMAC
-#include <asm/ide.h>
+#include <linux/ide.h>
 #endif

 #include <linux/module.h>
--- 2.2.19-ide-05042001/arch/ppc/kernel/residual.c	Fri Aug 10 12:40:06 2001
+++ 2.2.19-ide-05042001-mikef/arch/ppc/kernel/residual.c	Fri Aug 10 12:36:29 2001
@@ -47,7 +47,6 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <linux/ide.h>
-#include <asm/ide.h>


 const char * PnP_BASE_TYPES[] __initdata = {
--- 2.2.19-ide-05042001/arch/ppc/kernel/ppc_ksyms.c	Fri Aug 10 12:40:06 2001
+++ 2.2.19-ide-05042001-mikef/arch/ppc/kernel/ppc_ksyms.c	Fri Aug 10 12:32:38 2001
@@ -12,7 +12,6 @@
 #include <asm/semaphore.h>
 #include <asm/processor.h>
 #include <asm/uaccess.h>
-#include <asm/ide.h>
 #include <linux/ide.h>
 #include <asm/checksum.h>
 #include <asm/pgtable.h>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
