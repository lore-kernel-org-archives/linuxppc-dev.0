Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0113.outbound.protection.outlook.com [65.55.169.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8D6A1A0D99
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 08:35:35 +1000 (AEST)
Message-ID: <1440455590.30043.58.camel@freescale.com>
Subject: Re: [v2 00/11] Freescale DPAA QBMan Drivers
From: Scott Wood <scottwood@freescale.com>
To: <Roy.Pledge@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Date: Mon, 24 Aug 2015 17:33:10 -0500
In-Reply-To: <1439410497-19039-1-git-send-email-Roy.Pledge@freescale.com>
References: <1439410497-19039-1-git-send-email-Roy.Pledge@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-08-12 at 16:14 -0400, Roy Pledge wrote:
> The Freescale Data Path Acceleration Architecture (DPAA) is a set of 
> hardware components on specific QorIQ multicore processors. This 
> architecture provides the infrastructure to support simplified sharing of 
> networking interfaces and accelerators by multiple CPU cores and the 
> accelerators.
> 
> The Queue Manager (QMan) is a hardware queue management block that allows 
> software and accelerators on the datapath to enqueue and dequeue frames in 
> order to communicate.
> 
> The Buffer Manager (BMan) is a hardware buffer pool management block that 
> allows software and accelerators on the datapath to acquire and release 
> buffers in order to build frames.
> 
> This patch set introduces the QBMan driver code that configures initializes 
> the QBMan hardware and provides APIs for software to use the frame queues 
> and buffer pools the blocks provide. These drivers provide the base 
> fuctionality for software to communicate with the other DPAA accelerators 
> on Freescale QorIQ processors.
> 
> Changes from v1:
>       - Cleanup Kconfig options
>       - Changed base QMan and BMan drivers to only be buit in.
>         Will add loadable support in future patch

CONFIG_FSL_BMAN is tristate -- is it not expected to work if you select 'm'?

>       - Replace panic() call with WARN_ON()

panic() is still there.

> 
> >       - Replaced PowerPC specific IO accessors with platform independent versions

PowerPC accessors, and other PPC-specfic things like cache flushing and 
memory barriers, are still there.

-Scott
