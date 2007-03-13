Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 96484DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 16:32:22 +1100 (EST)
Date: Mon, 12 Mar 2007 22:32:59 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 02/19] bootwrapper: Set -msoft-float and assembler target
	options.
Message-ID: <20070313053258.GB27618@mag.az.mvista.com>
References: <20070312204140.GB28545@ld0162-tx32.am.freescale.net>
	<17910.4629.587851.80369@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17910.4629.587851.80369@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 13, 2007 at 01:53:09PM +1100, Paul Mackerras wrote:

Many of these are really mine to answer...

> Scott Wood writes:
> > Without the assembler target option, the assembler will use the old
> > dedicated mftb/mftbu instructions, rather than mfspr.  This causes the
> > boot to hang on e500, which doesn't have the dedicated instructions.
> 
> I see mftb being used for udelay in util.S, and udelay being used in
> serial_edit_cmdline in serial.c.  It's somewhat bogus that we just
> hard-code an assumed timebase frequency in util.S, and also bogus that

The timebase stuff was a straight copy from arch/ppc/boot/common/util.S.
I agree that its a bogus and should be fixed.

> we get command line editing for serial consoles but not for OF
> consoles (why should they be different?).

IIRC, a few of us talked about that on IRC way back.  The consensus
was that you would just change it with OF.  I added editing for non-OF
(should really be any fw that doesn't pass in an updated dtb (i.e.,
anything but OF and the new u-boot)) because, the cmdline would be
coming from the dtb embedded in the zImage (or from builtin_cmdline).
To change it, you have to find the dts, change it, and run 'wrapper'
(or run a pgm to set builtin_cmdline).  Seems like a lot to do for
a quick, temporary cmdline edit.

Its easy enough to add for OF, if you think its worth it.  I lack the OF
knowledge to do so though.

> It looks to me like we should at least make the platform code provide
> udelay (or mdelay), possibly with the aid of a helper function.

Agreed.

> We
> should also consider whether the command-line editing is generally
> useful, or not, and whether the function to do it should be made more
> generic.

IMHO, it is very useful if you have fw that doesn't update the dtb for
you (i.e., OF and u-boot).  Don't know if it makes sense for OF and/or
u-boot.

Mark
