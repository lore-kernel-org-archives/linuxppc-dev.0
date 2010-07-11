Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 8BC9AB6EE9
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jul 2010 17:40:35 +1000 (EST)
To: Steve Deiters <SteveDeiters@BASLER.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: arch/powerpc/lib/copy_32.S: Use alternate memcpy for MPC512x and
	MPC52xx
References: <181804936ABC2349BE503168465576460F272CA4@exchserver.basler.com>
In-Reply-To: <181804936ABC2349BE503168465576460F272CA4@exchserver.basler.com>
Date: Sun, 11 Jul 2010 02:40:22 -0500
Message-ID: <1278834022_17748@mail4.comsite.net>
Cc: Albrecht Dreß <albrecht.dress@arcor.de>, linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Steve wrote:
> These processors will corrupt data if accessing the local bus with
> unaligned addresses. This version fixes the typical case of copying from
> Flash on the local bus by keeping the source address always aligned.

As Dave said in May of 2008[1], the map driver is advertising xip access
to userspace so jffs2 is taking the XIP path and doing straight memcpy.

My reading of the mtd code says this is because map_is_linear() is true
a cfi cmdset 0001 nor flash will create a point function which jffs2
calls and it finds it will map the whole fs, so it just reads at will
from the direct mapping.

If the point fails to map the whole device, then jffs2 will use the
mtd mapping driver to copy to a buffer, and the default mapping drivers
will use memcpy_fromio to fill this buffer.

Steve, can you verify this by setting phys to NO_XIP in the mapping
driver and setting CONFIG_MTD_COMPLEX_MAPPINGS?  This is just a test,
as it is aparent this driver needs to have a custom mapping driver
that handles the alignment and read/modfiy/write issues -- the existing
memcopy_*io assumes byte writes are always ok which is not the case for
this processor and bus.


[1] http://thread.gmane.org/gmane.linux.drivers.mtd/21521
(found from the link in Albrecht's reply)

milton
