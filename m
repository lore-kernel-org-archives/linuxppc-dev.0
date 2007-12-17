Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9877FDDDF9
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 09:50:40 +1100 (EST)
Date: Mon, 17 Dec 2007 16:56:40 -0600
From: Olof Johansson <olof@lixom.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Fix build break caused by "ide: remove ideprobe_init()"
Message-ID: <20071217225640.GA22779@lixom.net>
References: <200711182325.09262.bzolnier@gmail.com>
	<20071214090915.GA28681@lixom.net>
	<200712172153.31427.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200712172153.31427.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 17, 2007 at 09:53:31PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> applied but...
> 
> > ---
> > 
> > On Sun, Nov 18, 2007 at 11:25:09PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > * Rename ide_device_add() to ide_device_add_all() and make it accept
> > >   'u8 idx[MAX_HWIFS]' instead of 'u8 idx[4]' as an argument.
> > > 
> > > * Add ide_device_add() wrapper for ide_device_add_all().
> > > 
> > > * Convert ide_generic_init() to use ide_device_add_all().
> > > 
> > > * Remove no longer needed ideprobe_init().
> > > 
> > > There should be no functionality changes caused by this patch.
> > 
> > This patch broke builds of powerpc holly_defconfig in -mm. It has
> > CONFIG_EMBEDDED=y, CONFIG_IDE=n but includes linux/ide.h:
>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> ...could you also fix the root source of the problem so the similar issue
> won't re-appear in the future?
> 
> <linux/ide.h> is IDE subsystem specific in the same way that <linux/libata.h>
> is libata specific, <linux/ata.h> is the place to put subsystem independent
> defines, inlines and co.
> 
> There are some powerpc abusers of the above rule but they should at least cover
> references to <linux/ide.h> and IDE subsystem specific code with #ifdef/#endif
> CONFIG_BLK_DEV_IDE.
> 
> In arch/powerpc/platforms/embedded6xx/holly.c case it seems that <linux/ide.h>
> include is actually not needed and may be just removed?

Yep, that was my original simple fix to the problem, but when I looked
closer I wanted to get the include file fixed as well.

Turns out I never posted the powerpc patch :), I'll do so (and audit
other platforms for the same).


Thanks,

-Olof
