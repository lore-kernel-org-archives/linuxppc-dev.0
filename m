Return-Path: <SRS0=1YdR=PK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412E2C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 22:31:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE1E206C0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 22:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE1E206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43VQkZ55YTzDqLH
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 09:31:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43VQhG6Y4NzDqJM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jan 2019 09:29:18 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 9316D2A126;
 Wed,  2 Jan 2019 17:29:14 -0500 (EST)
Date: Thu, 3 Jan 2019 09:29:14 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v8 02/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
In-Reply-To: <alpine.LNX.2.21.1812291053110.152@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1901021542310.609@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <5a285a9d9aecc1ee748f62e41870111e7e0f4cff.1545784679.git.fthain@telegraphics.com.au>
 <20181228175113.Horde.5ZUOOQLIT5SWwDlYCZQjrw1@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812291053110.152@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 29 Dec 2018, I wrote:

> On Fri, 28 Dec 2018, LEROY Christophe wrote:
> 
> > > --- a/drivers/char/nvram.c
> > > +++ b/drivers/char/nvram.c
> > > @@ -21,13 +21,6 @@
> > >   * ioctl(NVRAM_SETCKS) (doesn't change contents, just makes checksum valid
> > >   * again; use with care!)
> > >   *
> > > - * This file also provides some functions for other parts of the kernel that
> > > - * want to access the NVRAM: nvram_{read,write,check_checksum,set_checksum}.
> > > - * Obviously this can be used only if this driver is always configured into
> > > - * the kernel and is not a module. Since the functions are used by  
> > > some Atari
> > > - * drivers, this is the case on the Atari.
> > > - *
> > > - *
> > >   * 	1.1	Cesar Barros: SMP locking fixes
> > >   * 		added changelog
> > >   * 	1.2	Erik Gilling: Cobalt Networks support
> > > @@ -39,64 +32,6 @@
> > >
> > >  #include <linux/module.h>
> > >  #include <linux/nvram.h>
> > > -
> > > -#define PC		1
> > > -#define ATARI		2
> > > -
> > > -/* select machine configuration */
> > > -#if defined(CONFIG_ATARI)
> > > -#  define MACH ATARI
> > > -#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__)   
> > > /* and ?? */
> > > -#  define MACH PC
> > > -#else
> > > -#  error Cannot build nvram driver for this machine configuration.
> > > -#endif
> > > -
> > > -#if MACH == PC
> > > -
> > > -/* RTC in a PC */
> > > -#define CHECK_DRIVER_INIT()	1
> > > -
> > > -/* On PCs, the checksum is built only over bytes 2..31 */
> > > -#define PC_CKS_RANGE_START	2
> > > -#define PC_CKS_RANGE_END	31
> > > -#define PC_CKS_LOC		32
> > > -#define NVRAM_BYTES		(128-NVRAM_FIRST_BYTE)
> > > -
> > > -#define mach_check_checksum	pc_check_checksum
> > > -#define mach_set_checksum	pc_set_checksum
> > > -#define mach_proc_infos		pc_proc_infos
> > > -
> > > -#endif
> > > -
> > > -#if MACH == ATARI
> > > -
> > > -/* Special parameters for RTC in Atari machines */
> > > -#include <asm/atarihw.h>
> > > -#include <asm/atariints.h>
> > > -#define RTC_PORT(x)		(TT_RTC_BAS + 2*(x))
> > > -#define CHECK_DRIVER_INIT()	(MACH_IS_ATARI && ATARIHW_PRESENT(TT_CLK))
> > > -
> > > -#define NVRAM_BYTES		50
> > > -
> > > -/* On Ataris, the checksum is over all bytes except the checksum bytes
> > > - * themselves; these are at the very end */
> > > -#define ATARI_CKS_RANGE_START	0
> > > -#define ATARI_CKS_RANGE_END	47
> > > -#define ATARI_CKS_LOC		48
> > > -
> > > -#define mach_check_checksum	atari_check_checksum
> > > -#define mach_set_checksum	atari_set_checksum
> > > -#define mach_proc_infos		atari_proc_infos
> > > -
> > > -#endif
> > > -
> > > -/* Note that *all* calls to CMOS_READ and CMOS_WRITE must be done with
> > > - * rtc_lock held. Due to the index-port/data-port design of the RTC, we
> > > - * don't want two different things trying to get to it at once. (e.g. the
> > > - * periodic 11 min sync from kernel/time/ntp.c vs. this driver.)
> > > - */
> > > -
> > >  #include <linux/types.h>
> > >  #include <linux/errno.h>
> > >  #include <linux/miscdevice.h>
> > > @@ -120,12 +55,9 @@ static int nvram_open_mode;	/* special open modes */
> > >  #define NVRAM_WRITE		1 /* opened for writing (exclusive) */
> > >  #define NVRAM_EXCL		2 /* opened with O_EXCL */
> > >
> > > -static int mach_check_checksum(void);
> > > -static void mach_set_checksum(void);
> > > -
> > >  #ifdef CONFIG_PROC_FS
> > > -static void mach_proc_infos(unsigned char *contents, struct seq_file *seq,
> > > -								void *offset);
> > > +static void pc_nvram_proc_read(unsigned char *contents, struct  
> > > seq_file *seq,
> > > +			       void *offset);
> > >  #endif
> > >
> > >  /*
> > > @@ -139,6 +71,14 @@ static void mach_proc_infos(unsigned char  
> > > *contents, struct seq_file *seq,
> > >   * know about the RTC cruft.
> > >   */
> > >
> > > +#define NVRAM_BYTES		(128 - NVRAM_FIRST_BYTE)
> > > +
> > > +/* Note that *all* calls to CMOS_READ and CMOS_WRITE must be done with
> > > + * rtc_lock held. Due to the index-port/data-port design of the RTC, we
> > > + * don't want two different things trying to get to it at once. (e.g. the
> > > + * periodic 11 min sync from kernel/time/ntp.c vs. this driver.)
> > > + */
> > > +
> > >  unsigned char __nvram_read_byte(int i)
> > >  {
> > >  	return CMOS_READ(NVRAM_FIRST_BYTE + i);
> > > @@ -174,9 +114,22 @@ void nvram_write_byte(unsigned char c, int i)
> > >  }
> > >  EXPORT_SYMBOL(nvram_write_byte);
> > >
> > > +/* On PCs, the checksum is built only over bytes 2..31 */
> > > +#define PC_CKS_RANGE_START	2
> > > +#define PC_CKS_RANGE_END	31
> > > +#define PC_CKS_LOC		32
> > > +
> > >  int __nvram_check_checksum(void)
> > >  {
> > > -	return mach_check_checksum();
> > > +	int i;
> > > +	unsigned short sum = 0;
> > > +	unsigned short expect;
> > > +
> > > +	for (i = PC_CKS_RANGE_START; i <= PC_CKS_RANGE_END; ++i)
> > > +		sum += __nvram_read_byte(i);
> > > +	expect = __nvram_read_byte(PC_CKS_LOC)<<8 |
> > > +	    __nvram_read_byte(PC_CKS_LOC+1);
> > > +	return (sum & 0xffff) == expect;
> > >  }
> > 
> > 
> > I don't understand how this is part of the code move.
> > Does the pc specific checksum becomes the generic one ?
> > 
> 
> This is not generic code, of course. Please refer to the two patches 
> that follow this one, in which all of the x86-specific code gets wrapped 
> with #ifdef CONFIG_X86.
> 
> This code gets moved because the MACH macro is made redundant. You might 
> defer this code motion to patch 4 or patch 5 but I don't see that as being 
> an improvement.
> 
> [...]
> 
> You may argue that there should be no CONFIG_X86 code in drivers/char. 

I think I now remember why this x86-specific code doesn't get moved from 
drivers/char to arch/x86 in this patch series.

In the case of PPC32 and PPC64, the nvram accessors are presently built-in 
using rules like this,

arch/powerpc/platforms/powermac/Makefile:obj-$(CONFIG_PPC64) += nvram.o
arch/powerpc/platforms/powernv/Makefile:obj-y += ... opal-nvram.o ...
arch/powerpc/platforms/pseries/Makefile:obj-y := ... nvram.o ...

... or like this,

arch/powerpc/platforms/powermac/Makefile:obj-$(CONFIG_NVRAM:m=y) += nvram.o

... except in one case they are in a separate module, though this doesn't 
work for built-in callers such as chrp_init2(),

arch/powerpc/platforms/chrp/Makefile:obj-$(CONFIG_NVRAM) += nvram.o

Anyway, I didn't think that any of these options would make it past the 
x86 maintainers so I just left the x86-specific code in place.

-- 
