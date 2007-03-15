Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 Mar 2007 11:04:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070315000445.GE12573@localhost.localdomain>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
	<20070314214805.GA9546@mag.az.mvista.com>
	<45F86DC1.9010804@freescale.com>
	<20070314232339.GA32287@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070314232339.GA32287@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2007 at 04:23:39PM -0700, Mark A. Greer wrote:
> On Wed, Mar 14, 2007 at 04:48:49PM -0500, Scott Wood wrote:
> > Mark A. Greer wrote:
> > >Are you sure that '_end' (which is the end of the zImage/cuImage)
> > >is safe to use?  If the kernel is large enough (e.g., INITRAMFS)
> > >it will overwrite your dtb when its decompressed and relocated to 0.
> > >You need to grok the elfheader to figure out where the kernel will end
> > >and take the max of that and _end.
> > 
> > Wouldn't it overwrite the bootwrapper itself before overwriting the heap?
> 
> Sure but that doesn't matter--the kernel is running so the bootwrapper's
> life is over but the dtb's life isn't.

The bootloader now expands the kernel directly at 0, rather than
allocating space for it, except on platforms that can't (OF).  So we
*would* clobber the bootloader during the bootloader's life if the
kernel was too large.  There's a check for a too-large kernel as we
decompress it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
