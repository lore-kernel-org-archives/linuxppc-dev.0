Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4AA61A00FC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 11:40:11 +1000 (AEST)
Message-ID: <1440034811.13406.9.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/hvsi: Fix endianness issues in the HVSI driver
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>,
 linux-kernel@vger.kernel.org
Date: Thu, 20 Aug 2015 11:40:11 +1000
In-Reply-To: <55D4FAE9.7000504@linux.vnet.ibm.com>
References: <1438334990-11765-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1438649494.9418.0.camel@ellerman.id.au>
 <55D4FAE9.7000504@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-08-19 at 23:53 +0200, Laurent Dufour wrote:
> On 04/08/2015 02:51, Michael Ellerman wrote:
> > On Fri, 2015-07-31 at 11:29 +0200, Laurent Dufour wrote:
> >> This patch fixes several endianness issues detected when running the HVSI
> >> driver in little endian mode.
> >>
> >> These issues are raised in little endian mode because the data exchanged in
> >> memory between the kernel and the hypervisor has to be in big endian
> >> format.
> > 
> > Can you include the sparse output before and after?
> 
> Hi Michael,
> 
> Here is the output message displayed on the console when the bug occurred:
> 
> [    0.000517] irq: (null) didn't like hwirq-0x1000a00 to VIRQ16 mapping (rc=-22)
> [    0.000578] hvsi_console_init: couldn't create irq mapping for 0x1000a00
> 
> With the patch is applied, the hvsi driver is initializing correctly and
> no message is displayed, except the one saying the number of device the
> hvsi driver has configured. For instance:

> [    1.535783] HVSI: registered 1 devices


OK that's also good.

I was talking about the output from sparse endian checking, as the driver seems
to already be endian annotated.

ie, before:

$ make C=2 CF=-D__CHECK_ENDIAN__
...
drivers/tty/hvc/hvsi.c:245:36: warning: restricted __be32 degrades to integer
drivers/tty/hvc/hvsi.c:243:23: warning: restricted __be16 degrades to integer
drivers/tty/hvc/hvsi.c:243:23: warning: restricted __be16 degrades to integer
drivers/tty/hvc/hvsi.c:277:36: warning: restricted __be32 degrades to integer
drivers/tty/hvc/hvsi.c:279:36: warning: restricted __be32 degrades to integer
drivers/tty/hvc/hvsi.c:298:26: warning: incorrect type in assignment (different base types)
drivers/tty/hvc/hvsi.c:298:26:    expected restricted __be16 [assigned] [usertype] seqno
drivers/tty/hvc/hvsi.c:298:26:    got int
drivers/tty/hvc/hvsi.c:299:21: warning: incorrect type in assignment (different base types)
drivers/tty/hvc/hvsi.c:299:21:    expected restricted __be16 [assigned] [usertype] verb
drivers/tty/hvc/hvsi.c:299:21:    got int
drivers/tty/hvc/hvsi.c:301:28: warning: incorrect type in assignment (different base types)
drivers/tty/hvc/hvsi.c:301:28:    expected restricted __be16 [assigned] [usertype] query_seqno
drivers/tty/hvc/hvsi.c:301:28:    got int
drivers/tty/hvc/hvsi.c:322:60: warning: incorrect type in argument 2 (different base types)
drivers/tty/hvc/hvsi.c:322:60:    expected unsigned short [unsigned] [usertype] query_seqno
drivers/tty/hvc/hvsi.c:322:60:    got restricted __be16 [usertype] seqno
drivers/tty/hvc/hvsi.c:558:26: warning: incorrect type in assignment (different base types)
drivers/tty/hvc/hvsi.c:558:26:    expected restricted __be16 [assigned] [usertype] seqno
drivers/tty/hvc/hvsi.c:558:26:    got int
drivers/tty/hvc/hvsi.c:559:21: warning: incorrect type in assignment (different base types)
drivers/tty/hvc/hvsi.c:559:21:    expected restricted __be16 [assigned] [usertype] verb
drivers/tty/hvc/hvsi.c:559:21:    got unsigned short [unsigned] [usertype] verb
drivers/tty/hvc/hvsi.c:600:26: warning: incorrect type in assignment (different base types)
drivers/tty/hvc/hvsi.c:600:26:    expected restricted __be16 [assigned] [usertype] seqno
drivers/tty/hvc/hvsi.c:600:26:    got int
drivers/tty/hvc/hvsi.c:602:21: warning: incorrect type in assignment (different base types)
drivers/tty/hvc/hvsi.c:602:21:    expected restricted __be16 [assigned] [usertype] verb
drivers/tty/hvc/hvsi.c:602:21:    got int
drivers/tty/hvc/hvsi.c:603:21: warning: incorrect type in assignment (different base types)
drivers/tty/hvc/hvsi.c:603:21:    expected restricted __be32 [assigned] [usertype] mask
drivers/tty/hvc/hvsi.c:603:21:    got int
drivers/tty/hvc/hvsi.c:606:29: warning: incorrect type in assignment (different base types)
drivers/tty/hvc/hvsi.c:606:29:    expected restricted __be32 [assigned] [usertype] word
drivers/tty/hvc/hvsi.c:606:29:    got int
drivers/tty/hvc/hvsi.c:683:26: warning: incorrect type in assignment (different base types)
drivers/tty/hvc/hvsi.c:683:26:    expected restricted __be16 [assigned] [usertype] seqno
drivers/tty/hvc/hvsi.c:683:26:    got int
drivers/tty/hvc/hvsi.c:700:26: warning: incorrect type in assignment (different base types)
drivers/tty/hvc/hvsi.c:700:26:    expected restricted __be16 [assigned] [usertype] seqno
drivers/tty/hvc/hvsi.c:700:26:    got int
drivers/tty/hvc/hvsi.c:702:21: warning: incorrect type in assignment (different base types)
drivers/tty/hvc/hvsi.c:702:21:    expected restricted __be16 [assigned] [usertype] verb
drivers/tty/hvc/hvsi.c:702:21:    got int
...

And with your patch applied there are no warnings from hvsi.c!

So it seems you fixed all the issues, or at least all the issues we can detect
with sparse. So I'll merge this as-is with an updated changelog.

cheers
