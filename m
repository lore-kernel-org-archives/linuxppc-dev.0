Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A9B00B7249
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 09:46:06 +1100 (EST)
Received: from mail7-ch1 (localhost [127.0.0.1])	by mail7-ch1-R.bigfish.com
 (Postfix) with ESMTP id 6B51742031C	for <linuxppc-dev@ozlabs.org>; Thu, 17
 Nov 2011 22:45:14 +0000 (UTC)
Received: from CH1EHSMHS005.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.247])	by mail7-ch1.bigfish.com (Postfix) with ESMTP id
 522A0680043
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 22:45:12 +0000 (UTC)
Date: Thu, 17 Nov 2011 16:45:58 -0600
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: p1022ds: enable monitor switching via
 pixis indirect mode
Message-ID: <20111117224558.GA18848@schlenkerla.am.freescale.net>
References: <1321556259-4459-1-git-send-email-timur@freescale.com>
 <1321556259-4459-2-git-send-email-timur@freescale.com>
 <20111117213733.GC14736@schlenkerla.am.freescale.net>
 <4EC586B2.5060604@freescale.com>
 <20111117222515.GA18827@schlenkerla.am.freescale.net>
 <4EC58AA0.2070905@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4EC58AA0.2070905@freescale.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2011 at 04:28:48PM -0600, Timur Tabi wrote:
> Scott Wood wrote:
> 
> > As we discussed earlier, you could have a kernel boot parameter that
> > indicates what mode you'd like the localbus to run in.  Then, platform
> > code could update the device tree before any drivers bind.
> 
> How do I update the device tree from platform code?

prom_update_property()

Or, since you shouldn't be declaring these devices directly under a
simple-bus node, selectively probe the devices that are accessible.

> > Or, have U-boot set up the desired mode before entering the kernel, and
> > provide an appropriate device tree.
> 
> I can both of these features, but not in this patch.

This patch is the one that is adding a switch to indirect mode.  You're
adding it to the wrong place (it shouldn't be in a function called by the
DIU driver), so it is relevant to this patch.

-Scott
