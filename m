Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B83F6B720B
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 09:25:21 +1100 (EST)
Received: from mail105-ch1 (localhost [127.0.0.1])	by
 mail105-ch1-R.bigfish.com (Postfix) with ESMTP id 3C1995001AB	for
 <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 22:25:04 +0000 (UTC)
Received: from CH1EHSMHS030.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.252])	by mail105-ch1.bigfish.com (Postfix) with ESMTP id
 1C8324C0043	for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 22:25:04 +0000
 (UTC)
Date: Thu, 17 Nov 2011 16:25:15 -0600
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: p1022ds: enable monitor switching via
 pixis indirect mode
Message-ID: <20111117222515.GA18827@schlenkerla.am.freescale.net>
References: <1321556259-4459-1-git-send-email-timur@freescale.com>
 <1321556259-4459-2-git-send-email-timur@freescale.com>
 <20111117213733.GC14736@schlenkerla.am.freescale.net>
 <4EC586B2.5060604@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4EC586B2.5060604@freescale.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2011 at 04:12:02PM -0600, Timur Tabi wrote:
> Scott Wood wrote:
> 
> >> This has the side-effect of no longer requiring U-Boot to enable the DIU.
> >> Now Linux can enable the DIU all by itself.
> > 
> > Under what circumstances does Linux do this?  
> 
> p1022ds_set_monitor_port() is called by the DIU driver when it enables
> the DIU.  This happens on boot, for example, if you enable the
> framebuffer console.
> 
> > How does Linux prevent the
> > NOR flash driver from binding to the device when this mode has been or
> > will be used?
> 
> It doesn't.  This isn't a simple problem to solve.  On the P1022, NOR
> flash and the DIU are incompatible, and yet that's exactly what we ship
> on the P1022DS board.  We could just remove the NOR flash node from the
> DTS.

As we discussed earlier, you could have a kernel boot parameter that
indicates what mode you'd like the localbus to run in.  Then, platform
code could update the device tree before any drivers bind.

Or, have U-boot set up the desired mode before entering the kernel, and
provide an appropriate device tree.

Letting the kernel bind to localbus devices such as NOR flash, and then
taking the devices away without notice just because another device gets
initialized, is not the way to go.  We've already left "it just works"
territory, might as well make the user choose explicitly.

-Scott
