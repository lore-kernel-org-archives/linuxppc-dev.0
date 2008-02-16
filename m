Return-Path: <bzolnier@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id AAF89DDE21
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2008 02:16:16 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so675012fgg.39
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 07:16:14 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUID_FAILURE] next-20080215 Build failure caused by ide: rework
	PowerMac media-bay support
Date: Sat, 16 Feb 2008 15:57:32 +0100
References: <47B5D1C3.40702@linux.vnet.ibm.com>
In-Reply-To: <47B5D1C3.40702@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802161557.32788.bzolnier@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 15 February 2008, Kamalesh Babulal wrote:
> The linux-next-20080215 kernel build fails on the powerpc with
> following error
>  
>   CC      arch/powerpc/platforms/powermac/setup.o
> In file included from arch/powerpc/platforms/powermac/setup.c:66:
> include/asm/mediabay.h:29: error: syntax error before 'ide_hwif_t'
> include/asm/mediabay.h:29: warning: function declaration isn't a prototype
> make[2]: *** [arch/powerpc/platforms/powermac/setup.o] Error 1
> make[1]: *** [arch/powerpc/platforms/powermac] Error 2
> make: *** [arch/powerpc/platforms] Error 2
> 
> This build failure is caused by the  ide: rework PowerMac media-bay support
> patch.This problem was reported and solution suggested according to
> http://lkml.org/lkml/2008/2/13/195 including the 
> 
> #include <linux/ide.h> after
> 
> #ifdef CONFIG_BLK_DEV_IDE_PMAC
> 
> helps in fixing the build failure.

Thanks, I fixed the original patch.

interdiff:

[...]
v2:
* Fix build by adding <linux/ide.h> include to <asm-powerpc/mediabay.h>.
  (Reported by Michael/Kamalesh/Andrew).

Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Michael Ellerman <michael@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
[...]

diff -u b/include/asm-powerpc/mediabay.h b/include/asm-powerpc/mediabay.h
--- b/include/asm-powerpc/mediabay.h
+++ b/include/asm-powerpc/mediabay.h
@@ -23,6 +23,8 @@
 extern int media_bay_count;
 
 #ifdef CONFIG_BLK_DEV_IDE_PMAC
+#include <linux/ide.h>
+
 int check_media_bay_by_base(unsigned long base, int what);
 /* called by IDE PMAC host driver to register IDE controller for media bay */
 int media_bay_set_ide_infos(struct device_node *which_bay, unsigned long base,
