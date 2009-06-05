Return-Path: <subrata@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 03E3AB7095
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 04:26:37 +1000 (EST)
From: Subrata Modak <subrata@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 05 Jun 2009 13:26:25 -0500
Message-Id: <20090605182625.24093.7808.sendpatchset@elm3a191.beaverton.ibm.com>
Subject: Re: [BUILD FAILURE 01/04] Next June 04:PPC64 randconfig
	[drivers/staging/comedi/drivers.o]
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Linux-Next <linux-next@vger.kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Subrata Modak <subrata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>On Thu, 2009-06-04 at 22:40 +0200, Geert Uytterhoeven wrote:
>On Thu, Jun 4, 2009 at 20:07, Greg KH <greg@kroah.com> wrote:
> > On Thu, Jun 04, 2009 at 07:01:32PM +0530, Subrata Modak wrote:
> >> CC [M]  drivers/staging/comedi/drivers.o
> >> drivers/staging/comedi/drivers.c: In function ‘comedi_buf_alloc’:
> >> drivers/staging/comedi/drivers.c:496: error: ‘PAGE_KERNEL_NOCACHE’ undeclared (first use in this function)
> >> drivers/staging/comedi/drivers.c:496: error: (Each undeclared identifier is reported only once
> >> drivers/staging/comedi/drivers.c:496: error: for each function it appears in.)
> >> make[3]: *** [drivers/staging/comedi/drivers.o] Error 1
> >> make[2]: *** [drivers/staging/comedi] Error 2
> >> make[1]: *** [drivers/staging] Error 2
> >> make: *** [drivers] Error 2
> >>
> >> Is it still normal to expect this failure ?
> >
> > No.
> >
> >> I reported them long back during April:
> >> http://www.gossamer-threads.com/lists/linux/kernel/1065227,
> >
> > Yes, and I took some patches that were supposed to fix this.  I can't
> > duplicate this here, care to send a patch that would fix it?

I tried this. But, with some catch. ‘PAGE_KERNEL_NOCACHE’ seems to be the
choice for majority of architectures like frv, m32r, sh, x86, etc, as Geert
mentions below. However, i believe POWERPC defines it as ‘PAGE_KERNEL_NC‘
found at arch/powerpc/include/asm/pte-common.h.

Paul/Banjamin,
Can you please confirm this ?

The below patch fixes the build error.

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
---

--- linux-2.6.30-rc8/drivers/staging/comedi/drivers.c.orig	2009-06-05 12:46:35.000000000 -0500
+++ linux-2.6.30-rc8/drivers/staging/comedi/drivers.c	2009-06-05 13:03:31.000000000 -0500
@@ -43,9 +43,13 @@
 #include <linux/vmalloc.h>
 #include <linux/cdev.h>
 #include <linux/dma-mapping.h>
-
 #include <asm/io.h>
 #include <asm/system.h>
+#ifdef __powerpc64__
+#include <asm/pte-common.h>
+#else
+#include <asm/pgtable.h>
+#endif
 
 static int postconfig(struct comedi_device *dev);
 static int insn_rw_emulate_bits(struct comedi_device *dev, struct comedi_subdevice *s,
@@ -492,8 +496,13 @@ int comedi_buf_alloc(struct comedi_devic
 		}
 		if (i == n_pages) {
 			async->prealloc_buf =
+#ifdef __powerpc64__
+				vmap(pages, n_pages, VM_MAP,
+				PAGE_KERNEL_NC);
+#else
 				vmap(pages, n_pages, VM_MAP,
 				PAGE_KERNEL_NOCACHE);
+#endif
 		}
 		if (pages) {
 			vfree(pages);

---
Regards--
Subrata

> PAGE_KERNEL_NOCACHE is defined on a few architectures only, namely
> frv, m32r, mn10300, sh, and x86[*]. On all others, it will fail.
> 
> [*] Interestingly, sparc refers to it in one of its include files,
> without providing a
>     definition, Probably that code is unused.
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
