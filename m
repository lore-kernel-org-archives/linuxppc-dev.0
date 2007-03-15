Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id B2C0BDDD07
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 12:58:24 +1100 (EST)
Date: Wed, 14 Mar 2007 18:59:04 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070315015904.GB8406@mag.az.mvista.com>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
	<20070314214805.GA9546@mag.az.mvista.com>
	<45F86DC1.9010804@freescale.com>
	<20070314232339.GA32287@mag.az.mvista.com>
	<20070315000445.GE12573@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070315000445.GE12573@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 15, 2007 at 11:04:45AM +1100, David Gibson wrote:
> On Wed, Mar 14, 2007 at 04:23:39PM -0700, Mark A. Greer wrote:
> > On Wed, Mar 14, 2007 at 04:48:49PM -0500, Scott Wood wrote:
> > > Mark A. Greer wrote:
> > > >Are you sure that '_end' (which is the end of the zImage/cuImage)
> > > >is safe to use?  If the kernel is large enough (e.g., INITRAMFS)
> > > >it will overwrite your dtb when its decompressed and relocated to 0.
> > > >You need to grok the elfheader to figure out where the kernel will end
> > > >and take the max of that and _end.
> > > 
> > > Wouldn't it overwrite the bootwrapper itself before overwriting the heap?
> > 
> > Sure but that doesn't matter--the kernel is running so the bootwrapper's
> > life is over but the dtb's life isn't.
> 
> The bootloader now expands the kernel directly at 0, rather than
> allocating space for it, except on platforms that can't (OF).

Well, its not at 0 if you have a platform_ops.vmlinux_alloc()
defined which could be anyone.  But I get your point.

> So we
> *would* clobber the bootloader during the bootloader's life if the
> kernel was too large.  There's a check for a too-large kernel as we
> decompress it.

This seems like a problem to me.  Premably, INITRAMFS will be used
more & more often so this check is going to fail more & more often.
We'll end up havng to keep moving the addr it loads at further & further
back or define platform_ops.vmlinux_alloc() and have the issue I
mentioned.

Mark
